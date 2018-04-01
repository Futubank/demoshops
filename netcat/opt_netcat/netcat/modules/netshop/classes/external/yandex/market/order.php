<?php
       
// Класс для интеграции системы с Яндекс-Маркетом
class nc_netshop_external_yandex_market_order extends nc_netshop_external_order {
    
    static protected $order_sources_list_name = "ShopOrderSource";
    static protected $delivery_types = array(
        nc_netshop_delivery::DELIVERY_TYPE_COURIER => 'DELIVERY',
        nc_netshop_delivery::DELIVERY_TYPE_PICKUP => 'PICKUP',
        nc_netshop_delivery::DELIVERY_TYPE_POST => 'POST',
    );
    
    /**
     * Авторизация - проверяем переданные параметры на соответствие настройкам магазина
     *
     * @param $yandex_market_auth_token    // Авторизационный токен
     */
    static public function authorize($yandex_market_auth_token = null){
        $netshop = nc_netshop::get_instance();
        $shop_yandex_market_campaign_id = $netshop->get_setting('YandexMarketCampaignID');
        $shop_yandex_market_auth_token = $netshop->get_setting('YandexMarketAuthToken');
        if (!strlen($shop_yandex_market_auth_token) || !strlen($shop_yandex_market_campaign_id)) {
            self::return_json(array(
                'message' => 'Yandex Market order is not allowed for this site',
                'data' => array('code' => 40)
            ));
        } else if ($yandex_market_auth_token != $shop_yandex_market_auth_token) {
            self::return_json(array(
                'message' => 'Wrong Authorization token',
                'data' => array('code' => 41)
            ));
        }
    }
    
    /**
     * Приведение массива товаров к формату, используемому в netshop
     *
     * @param $order_data    // Массив товаров
     * @return array         // Отформатированный массив товаров
     */
    static public function items_data_to_array($order_data) {
        $items_array = array();
        foreach ($order_data as $item) {
            $offer_id= explode('x', $item['offerId']);
            $offer_class_id = $offer_id[0];
            $offer_message_id = $offer_id[1];
            
            $items_array[$offer_class_id][$offer_message_id]['Qty'] = $item['count'];
            $items_array[$offer_class_id][$offer_message_id]['OrderParameters'] = array(
                'feedId' => $item['feedId'],
                'offerId' => $item['offerId']
            );
        }
        
        return $items_array;
    }
    
    /**
     * Получение города по данным региона доставки
     *
     * @param array $region      // данные региона доставки
     * @return int|string|null   // значение для поля City
     */
    static public function get_city_field_value($region) {
        if (!isset($region['name'])) {
            return null;
        }

        $nc_core = nc_core::get_object();
        $netshop = nc_netshop::get_instance();
        $order_component = $nc_core->get_component($netshop->get_setting('OrderComponentID'));
        $city_field_type = $order_component->get_field('City', 'type');
        if ($city_field_type === null) {
            trigger_error(__METHOD__ . ": no 'City' field?", E_USER_WARNING);
            return null;
        }

        $location = array();
        while ($region) {
            $name = $region['name'];
            switch ($region['type']) {
                case 'CITY':
                case 'TOWN':
                case 'VILLAGE':
                case 'SETTLEMENT':
                    $location['locality_name'] = $name;
                    break;
                case 'REPUBLIC_AREA':
                case 'SUBJECT_FEDERATION_DISTRICT':
                    $location['district_name'] = $name;
                    break;
                case 'REPUBLIC':
                case 'SUBJECT_FEDERATION':
                    // В Яндексе Московская область входит в субъект "Москва и Московская область"
                    if ($name === 'Москва и Московская область') {
                        $name = 'Московская область';
                    }
                    // Также в Яндексе есть "Санкт-Петербург и Ленинградская область"
                    if ($name === 'Санкт-Петербург и Ленинградская область') {
                        $name = 'Ленинградская область';
                    }
                    // "Республика Северная Осетия - Алания" написана в Яндексе с длинным тире,
                    // в БД Почты через «-»
                    $name = str_replace('—', '-', $name);
                    $location['region_name'] = $name;
                    break;
                case 'COUNTRY':
                    $location['country_name'] = $name;
                    break;
            }
            $region = $region['parent'];
        }

        if ($city_field_type == NC_FIELDTYPE_SELECT) {
            $db = $nc_core->db;
            return $db->get_var(
                "SELECT `Region_ID` 
                        FROM `Classificator_Region` 
                       WHERE `Region_Name` = '" . $db->escape($location['locality_name']) . "'"
            );
        }

        // anything else is treated as a string field

        if ($location['country_name'] === 'Россия') {
            $names_to_check = array(
                "$location[locality_name]",
                "$location[locality_name], $location[region_name]",
                "$location[locality_name], $location[region_name], $location[district_name]",
            );
        } else {
            $names_to_check = array(
                $location['country_name'] . ', ' .
                (!empty($location['region_name']) ? $location['region_name'] . ', ' : '') .
                $location['locality_name'],
            );
        }

        foreach ($names_to_check as $name_to_check) {
            if (!$nc_core->NC_UNICODE) {
                $name_to_check = $nc_core->utf8->utf2win($name_to_check);
            }

            $location = $netshop->location->find_locations($name_to_check)->first();
            if ($location && $location['is_exact_match']) {
                return $location['name'];
            } 
        }

        return null;
    }
    
    /**
     * Получение массива доступных способов доставки для конкретного заказа
     * (Способы доставки в локальные пункты самовывоза отбрасываются)
     *
     * @param nc_netshop_order $order                      // Заказ
     * @return nc_netshop_record_conditional_collection    // Коллекция доступных способов доставки
     */
    static public function get_enabled_delivery_methods(nc_netshop_order $order) {
        $context = nc_netshop_condition_context::for_order($order);
        $enabled_methods = nc_netshop::get_instance()->delivery->get_enabled_methods()->matching($context);
        /** @var nc_netshop_delivery_method $method */
        foreach ($enabled_methods as $key => $method) {
            if ($method->get('delivery_type') == nc_netshop_delivery::DELIVERY_TYPE_PICKUP) {
                if ($method->get_delivery_points() instanceof nc_netshop_delivery_point_external_collection) {
                    unset($enabled_methods[$key]);
                }
            }
        }

        return $enabled_methods;
    }
    
    /**
     * Построение массива данных корзины
     *
     * @param $order nc_netshop_order    // Заказ
     * @return array                     // Массив данных корзины
     */
    static public function build_cart_array($order) {

        $netshop = nc_netshop::get_instance();
        $cart_array = array();
        
        // Способы доставки
        /** @var nc_netshop_delivery_method $delivery_method */
        foreach (self::get_enabled_delivery_methods($order) as $delivery_method) {
            $order->set_delivery_method($delivery_method);
            $context = nc_netshop_condition_context::for_order($order);
            $enabled_payment_methods_yandex = array();
            $payment_methods = $netshop->payment->get_enabled_methods()->matching($context);
            
            foreach(array(
                'payment_on_delivery_cash' => 'CASH_ON_DELIVERY',
                'payment_on_delivery_card' => 'CARD_ON_DELIVERY'
            ) as $local_payment_method => $yandex_payment_method) {
                if ($payment_methods->any($local_payment_method, 1)) {
                    $enabled_payment_methods_yandex[$yandex_payment_method] = 1;
                }
            }

            $estimate = $delivery_method->get_estimate($order);
            $closest_delivery_date = $estimate->get_closest_delivery_date();
            if ($closest_delivery_date) {
                $delivery_option = array(
                    'price' => intval($estimate->get('price')),
                    'id' => $estimate->get('delivery_method_id'),
                    'serviceName' => $estimate->get('delivery_method_name'),
                    'type' => nc_array_value(self::$delivery_types, $delivery_method->get_delivery_type(), 'DELIVERY'),
                    'dates' => array(
                        'fromDate' => (string)date("d-m-Y", strtotime((string)$closest_delivery_date)),
                        'toDate' => (string)date("d-m-Y", strtotime((string)$estimate->get_latest_delivery_date()))
                    )
                );
                if ($enabled_payment_methods_yandex) {
                    $delivery_option['paymentMethods'] = array_keys($enabled_payment_methods_yandex);
                }
                if ($delivery_method->get_delivery_type() === nc_netshop_delivery::DELIVERY_TYPE_PICKUP) {
                    $delivery_option['outlets'] = array();
                    /** @var nc_netshop_delivery_point $delivery_point */
                    foreach ($delivery_method->get_delivery_points($order->get_location_name()) as $delivery_point) {
                        $delivery_option['outlets'][] = array('id' => (int)$delivery_point->get_id());
                    }
                }
                $cart_array['cart']['deliveryOptions'][] = $delivery_option;
            }
        }

        // Товары
        $items_array = array();
        foreach ($order->get_items() as $item) {
            $order_parameters = $item->get('OrderParameters');
            $items_array[] = array(
                'count' => $item->get('Qty'),
                'delivery' => true,
                'price' => (float)$item->get('ItemPrice'),
                'feedId' => $order_parameters['feedId'],
                'offerId' => $order_parameters['offerId'],
            );
        }
        $cart_array['cart']['items'] = $items_array;
        
        if (nc_netshop::get_instance()->get_setting('YandexMarketOnlinePayment')) {
            $cart_array['cart']['paymentMethods'][] = 'YANDEX';
        }
        
        return $cart_array;
    }
    
    /**
     * Построение строки из массива данных адреса
     *
     * @param $address_array    // Массив данных адреса
     * @return string           // Полный адрес
     */
    static public function build_address_by_array($address_array) {
        $address = array();
        $address_keys_compares = array(
            'city' => 'г.',
            'subway' => 'м.',
            'street' => 'ул.',
            'house' => 'д.',
            'block' => 'к.',
            'entrance' => 'подъезд',
            'entryphone' => 'домофон',
            'floor' => 'этаж',
            'apartment' => 'кв.',
            'phone' => 'тел.'
        );
        foreach ($address_array as $key => $value) {
            $address[] = $address_keys_compares[$key] . ' ' . $value;
        }
        $address = implode(', ', $address);

        $nc_core = nc_core::get_object();
        if (!$nc_core->NC_UNICODE) {
            $address = $nc_core->utf8->utf2win($address);
        }
        
        return $address;
    }
    
    /**
     * Обновление статуса заказа на Яндекс.Маркете
     *
     * @param $order    nc_netshop_order
     */
    static public function process_status_change($order) {
        $netshop = nc_netshop::get_instance();
        
        $order_status_mapping = json_decode($netshop->get_setting('YandexMarketOrderStatusMapping'), true);
        $order_status_mapping_reversed = array_flip($order_status_mapping);
        $yandex_status = $order_status_mapping_reversed[$order->get_status_id()];

         $yandex_data = array(
            'order' => array(
                'status' => $yandex_status
            )
        );

        if ($yandex_status === 'CANCELLED') {
            $yandex_data['order']['substatus'] = 'SHOP_FAILED';
        }
        
        $json_data = json_encode($yandex_data);

        $campaign_id = $netshop->get_setting('YandexMarketCampaignID');
        $oauth_id = $netshop->get_setting('YandexMarketOAuthID');
        $oauth_token = $netshop->get_setting('YandexMarketOAuthToken');
        
        $url = 'https://api.partner.market.yandex.ru/v2/campaigns/' . $campaign_id;
        $url .= '/orders/' . $order->get('ExternalID') . '/status.json';
        $url .= '?oauth_token=' . $oauth_token . '&oauth_client_id=' . $oauth_id;

        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'Content-Length: ' . strlen($json_data)));
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
        curl_setopt($ch, CURLOPT_POSTFIELDS, $json_data);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT_MS, 10240);
        $response = curl_exec($ch);
        curl_close($ch);
    }
    
    /**
     * Определяет список доступных для заказа статусов
     * (Приводим соответствия статусов на Яндексе к соответствиям
     * локальных статусов на основе настроек модуля)
     *
     * @param nc_netshop_order $order         // Объект заказа
     * @return array
     */
    static public function get_available_statuses($order) {
        $statuses = array(
            'UNPAID' => array(
                'PROCESSING'
            ),
            'RESERVED' => array(
                'PROCESSING'
            ),
            'PROCESSING' => array(
                'DELIVERY',
                'CANCELLED'
            ),
            'DELIVERY' => array(
                'PICKUP',
                'DELIVERED',
                'CANCELLED'
            ),
            'PICKUP' => array(
                'DELIVERED',
                'CANCELLED'
            )
        );
        
        $netshop = nc_netshop::get_instance();
        $order_status_mapping = json_decode($netshop->get_setting('YandexMarketOrderStatusMapping'), true);
        
        $local_statuses = array();
        foreach ($statuses as $old_status => $new_statuses) {
            foreach ($new_statuses as $new_yandex_status) {
                $local_statuses[$order_status_mapping[$old_status]][] = $order_status_mapping[$new_yandex_status];
            }
        }
        
        $order_status_id = $order->get_status_id();
        
        return isset($local_statuses[(int)$order_status_id])
                ? array_unique($local_statuses[(int)$order_status_id])
                : array();
    }
    
    /**
     * Возвращает ID источника заказа "Яндекс.Маркет"
     *
     * @return int
     */
    static public function get_yandex_order_source_id() {
        return nc_db()->get_var("
            SELECT
                `" . self::$order_sources_list_name . "_ID`
            FROM
                `Classificator_" . self::$order_sources_list_name . "`
            WHERE
                Value = '" . __CLASS__ . "'
        ");
    }
    
}