<?php

/**
 * Интеграция с Яндекс.Доставкой
 */
class nc_netshop_delivery_service_yandex extends nc_netshop_delivery_service {

    /** @var string название службы */
    protected $name = NETCAT_MODULE_NETSHOP_DELIVERY_YANDEX;

    /** @var string тип доставки */
    protected $delivery_type = nc_netshop_delivery::DELIVERY_TYPE_MULTIPLE;

    /** @var bool служба может предложить более одного варианта доставки */
    protected $can_provide_multiple_variants = true;

    /**
     * Поля, которым нужны соответствия
     * @var array
     */
    
    protected $mapped_fields = array(
        'from_city' => NETCAT_MODULE_NETSHOP_DELIVERY_METHOD_SERVICE_FROM_CITY,
        'to_zipcode' => NETCAT_MODULE_NETSHOP_DELIVERY_METHOD_SERVICE_TO_ZIP_CODE,
        'to_city' => NETCAT_MODULE_NETSHOP_DELIVERY_METHOD_SERVICE_TO_CITY,
        'to_address' =>  NETCAT_MODULE_NETSHOP_DELIVERY_METHOD_SERVICE_TO_ADDRESS,
        'to_street' =>  NETCAT_MODULE_NETSHOP_DELIVERY_METHOD_SERVICE_TO_STREET,
        'to_house' =>  NETCAT_MODULE_NETSHOP_DELIVERY_METHOD_SERVICE_TO_HOUSE,
        'to_housing' =>  NETCAT_MODULE_NETSHOP_DELIVERY_METHOD_SERVICE_TO_HOUSING,
        'to_building' =>  NETCAT_MODULE_NETSHOP_DELIVERY_METHOD_SERVICE_TO_BUILDING,
        'to_flat' =>  NETCAT_MODULE_NETSHOP_DELIVERY_METHOD_SERVICE_TO_FLAT,
        'full_name' =>  NETCAT_MODULE_NETSHOP_DELIVERY_METHOD_SERVICE_FULL_NAME,
        'last_name' =>  NETCAT_MODULE_NETSHOP_DELIVERY_METHOD_SERVICE_LAST_NAME,
        'first_name' =>  NETCAT_MODULE_NETSHOP_DELIVERY_METHOD_SERVICE_FIRST_NAME,
        'middle_name' =>  NETCAT_MODULE_NETSHOP_DELIVERY_METHOD_SERVICE_MIDDLE_NAME,
    );

    protected $yandex_keys = array();
    protected $yandex_ids = array();

    /**
     * Рассчитать стоимость посылки.
     * При успешном выполнении возвращается массив:
     * array(
     *     'price' => стоимость доставки,
     *     'currency' => валюта стоимости доставки
     *     'min_days' => минимальное количество дней на доставку
     *     'max_days' => максимальное количество дней на доставку
     * )
     *
     * При ошибке возвращается null
     *
     * @return array|null
     */
    public function calculate_delivery() {
        return null;
    }

    /**
     * @param nc_netshop_delivery_method $method
     * @return nc_netshop_delivery_method_collection
     */
    public function get_variants(nc_netshop_delivery_method $method) {
        $response = $this->get_yandex_delivery_data();
        
        if (!$response || nc_array_value($response, 'status') !== 'ok') {
            return new nc_netshop_delivery_method_collection();
        }

        $converter = new nc_netshop_delivery_service_yandex_converter($this, $this->data);
        $variants = $converter->get_delivery_variants($response);
        
        return $variants;
    }

    /**
     * Возвращает массив с описанием дополнительных настроек способа доставки
     * (в формате, подходящем для nc_a2f).
     *
     * @return array
     */
    public function get_settings_fields() {
        return array(
            'keys' =>
                array(
                    'type' => 'textarea',
                    'caption' => NETCAT_MODULE_NETSHOP_DELIVERY_YANDEX_KEYS,
                    'size' => '6',
                    'codemirror' => false,
                ),
            'ids' =>
                array(
                    'type' => 'textarea',
                    'caption' => NETCAT_MODULE_NETSHOP_DELIVERY_YANDEX_IDS,
                    'size' => '6',
                    'codemirror' => false,
                ),
            'payment_charge' =>
                array (
                    'type' => 'select',
                    'subtype' => 'static',
                    'caption' => NETCAT_MODULE_NETSHOP_DELIVERY_YANDEX_PAYMENT_CHARGE,
                    'values' => array(
                        0 => NETCAT_MODULE_NETSHOP_DELIVERY_YANDEX_PAYMENT_CHARGE_INCLUDED,
                        1 => NETCAT_MODULE_NETSHOP_DELIVERY_YANDEX_PAYMENT_CHARGE_EXTRA,
                    ),
                    'default_value' => 0,
                ),
            'shipment_type' =>
                array (
                    'type' => 'select',
                    'subtype' => 'static',
                    'caption' => NETCAT_MODULE_NETSHOP_DELIVERY_YANDEX_SHIPMENT_TYPE,
                    'values' => array(
                        'import' => NETCAT_MODULE_NETSHOP_DELIVERY_YANDEX_SHIPMENT_TYPE_IMPORT,
                        'withdraw' => NETCAT_MODULE_NETSHOP_DELIVERY_YANDEX_SHIPMENT_TYPE_WITHDRAW,
                    ),
                    'default_value' => 'import',
                ),
            'dadata_api_key' =>
                array (
                    'type' => 'string',
                    'caption' => NETCAT_MODULE_NETSHOP_DELIVERY_DADATA_API_KEY,
                    'size' => 40,
                ),
        );
    }

    /**
     * Устанавливает дополнительные настройки (из настроек способа доставки)
     *
     * @param array $settings
     */
    public function set_settings(array $settings) {
        parent::set_settings($settings);
        $this->yandex_keys = json_decode($this->get_setting('keys') ?: '{}', true);
        $this->yandex_ids = json_decode($this->get_setting('ids') ?: '{}', true);
    }

    /**
     * Создание заказа в Яндекс.Доставка
     * @param nc_netshop_order $order
     */
    public function checkout(nc_netshop_order $order) {
        // Создадим черновик заказа
        $yandex_order_id = $this->create_yandex_order($order);
        
        // Подтвердим заказ
        if ($yandex_order_id) {
            $this->confirm_yandex_order($order, $yandex_order_id);
        }
    }
    
    /**
     * Создание заказа на Яндекс.Доставка
     * @param nc_netshop_order $order
     * @return string|null $yandex_order_id
     */
    protected function create_yandex_order(nc_netshop_order $order) {
        // Способ доставки
        $delivery_method = $order->get_delivery_method();
        
        // Товары в заказе
        $items = $order->get_items_with_distributed_cart_discount();
        
        // Размеры товаров в заказе
        $size = $items->get_package_size();
        
        // Вес корзины
        $items_weight = $items->get_field_sum('Weight') ?: 100;
        
        // Данные клиента
        list($client_first_name, $client_middle_name, $client_last_name) = $this->parse_client_data();
        
        // ID данных доставки
        $delivery_delivery_id = $delivery_method->get('_yandex_delivery_id');
        $delivery_tariff_id = nc_array_value(explode(':', $order->get_delivery_variant_id()), 1);
        $delivery_pickuppoint_id = nc_array_value(explode(':', $order->get_delivery_point_id()), 2);

        // Адрес доставки
        list($delivery_address, $delivery_city, $delivery_street,
             $delivery_house, $delivery_housing, $delivery_building, 
             $delivery_flat, $delivery_index) = $this->get_yandex_address_components($order);
        
        // ID города в Яндексе
        $delivery_geo_id = $this->get_yandex_geo_id($delivery_city);

        // Оплата при получении?
        $payment_method = $order->get_payment_method();
        $payment_on_delivery = $payment_method && $payment_method->get('payment_from_delivery');

        // Стоимость доставки
        // * наценка за оплату добавляется к стоимости доставки — как «товар» её добавить
        //   не получается из-за отсутствия веса и габаритов)
        // * ЯД не принимает стоимость с копейками. Чтобы не обидеть покупателя, округляем
        //   вниз (в случае оплаты при получении — покупатель не переплачивает по сравнению
        //   со стоимостью заказа в ИМ) или вверх (в случае оплаты на сайте —  покупатель
        //   видит, что заплатил не больше, чем стоимость в документах  транспортной компании)
        $rounding_function = $payment_on_delivery ? 'floor' : 'ceil';
        $delivery_cost = $rounding_function($order['DeliveryCost'] - $order['DeliveryDiscountSum'] + $order['PaymentCost']);

        $netshop = nc_netshop::get_instance($order->get_catalogue_id());
        $default_vat = $netshop->get_setting('VAT');

        // Товары
        $order_items = array();
        $order_cost = 0;
        foreach ($items as $item) {
            $item_cost = $rounding_function($item['ItemPrice']); // ЯД не принимает стоимость с копейками
            $order_cost += $item_cost * $item['Qty'];

            $item_vat = $item['VAT'];
            if (!strlen($item_vat)) {
                $item_vat = $default_vat;
            }

            $order_items[] = array(
                'orderitem_name' => $item['FullName'],
                'orderitem_cost' => $item_cost, // ЯД не принимает стоимость с копейками
                'orderitem_id' => $item['Message_ID'],
                'orderitem_article' => $item['Article'],
                'orderitem_width' => $item['PackageSize1'],
                'orderitem_height' => $item['PackageSize2'],
                'orderitem_length' => $item['PackageSize3'],
                'orderitem_weight' => sprintf('%.3F', $item['Weight'] / 1000),
                'orderitem_quantity' => $item['Qty'],
                'orderitem_vat_value' => $this->get_yandex_vat_id($item_vat),
            );
        }

        // Сумма предоплаты
        $amount_prepaid = $payment_on_delivery ? 0 : $order_cost + $delivery_cost;

        // Создадим черновик заказа
        $data = array(
            'order_num' => $order->get_id(),
            'order_weight' => sprintf('%.3F', $items_weight / 1000),
            'order_length' => (int)$size[0],
            'order_height' => (int)$size[1],
            'order_width' => (int)$size[2],
            'order_assessed_value' => $order_cost,
            'order_delivery_cost' => $delivery_cost,
            'order_shipment_type' => $this->get_yandex_delivery_type($delivery_method->get('delivery_type')),
            'is_manual_delivery_cost' => '1',
            'order_amount_prepaid' => $amount_prepaid,
            
            'recipient' => array(
                'last_name' => $client_last_name,
                'first_name' => $client_first_name,
                'middle_name' => $client_middle_name,
                'phone' => $order['Phone'],
                'email' => $order['Email'],
            ),
            
            'delivery' => array(
                'to_yd_warehouse' => $delivery_method->get('_yandex_to_yd_warehouse'),
                'delivery' => $delivery_delivery_id,
                'tariff' => $delivery_tariff_id,
                'pickuppoint' => $delivery_pickuppoint_id,
                'direction' => $delivery_geo_id,
                'interval' => '',
            ),
            
            'deliverypoint' => array(
                'geo_id' => $delivery_geo_id,
                'index' => $delivery_index,
                'comment' => "Исходный адрес: {$delivery_address}",
                
                'city' => $delivery_city,
                'street' => $delivery_street,
                'house' => $delivery_house,
                'housing' => $delivery_housing,
                'building' => $delivery_building,
                'flat' => $delivery_flat,
            ),
            
            'order_items' => $order_items,
        );
        
        // Создадим черновик заказа
        $response = $this->make_yandex_api_request('createOrder', $data);
        
        $order_id = null;
        
        if (!empty($response['status']) && $response['status'] == 'ok') {
            $order_id = $response['data']['order']['id'];
        }
        
        return $order_id;
    }
    
    /**
     * Подтверждение созданного на Яндекс.Доставка
     * @param nc_netshop_order $order
     * @param string $yandex_order_id
     */
    protected function confirm_yandex_order(nc_netshop_order $order, $yandex_order_id) {
        if (!$yandex_order_id) {
            return;
        }
        
        // Способ доставки
        $delivery_method = $order->get_delivery_method();
        
        $days_until_shipment = $delivery_method->get_days_until_shipment();
        $days_until_shipment = intval($days_until_shipment);
        
        $data = array(
            'order_ids' => $yandex_order_id,
            'shipment_date' => date('Y-m-d', strtotime("+{$days_until_shipment} days")),
            'type' => $this->get_setting('shipment_type'),
        );
        
        $response = $this->make_yandex_api_request('confirmSenderOrders', $data);
    }
    
    /**
     * Получение ID города в Яндексе
     * @param string $city
     * @return int $geo_id
     */
    protected function get_yandex_geo_id($city) {
        $response = $this->make_yandex_api_request('autocomplete', array(
            'type' => 'locality',
            'term' => $city,
        ));
        
        $geo_id = null;
        
        if ($response['status'] == 'ok') {
            $geo_id = !empty($response['data']['suggestions'][0]['geo_id']) ? $response['data']['suggestions'][0]['geo_id'] : null;
        }
        
        return $geo_id;
    }
    
    /**
     * Получение ID НДС в Яндексе
     * @param int $vat
     * @return int $vat_id
     */
    protected function get_yandex_vat_id($vat) {
        // Конвертация VAT в формат Яндекса
        // 1 — 18 процентов.
        // 2 — 10 процентов.
        // 5 — 0 процентов.
        // 6 — НДС не облагается.
        $vat_our_to_yandex = array(
            // Процент => Значение
            18 => 1,
            10 => 2,
            0 => 5,
        );
        $vat_default = 6;

        return !empty($vat_our_to_yandex[$vat]) ? $vat_our_to_yandex[$vat] : $vat_default;
    }
    
    /**
     * Конвертация типа доставки в формат Яндекса
     * @param string $delivery_type
     * @return string $delivery_type
     */
    protected function get_yandex_delivery_type($delivery_type) {
        $delivery_type_our_to_yandex = array(
            nc_netshop_delivery::DELIVERY_TYPE_COURIER => 'todoor',
            nc_netshop_delivery::DELIVERY_TYPE_PICKUP => 'pickup',
            nc_netshop_delivery::DELIVERY_TYPE_POST => 'post',
        );
        
        return $delivery_type_our_to_yandex[$delivery_type];
    }
    
    /**
     * Разбор контактных данных на составляющие
     * @return array $client_data_components
     */
    protected function parse_client_data() {
        // Части контактных данных
        $field_full_name = $this->data['full_name'];
        $field_first_name = $this->data['first_name'];
        $field_middle_name = $this->data['middle_name'];
        $field_last_name = $this->data['last_name'];
        
        // Соберём воедино
        if (!empty($field_first_name) || !empty($field_middle_name) || !empty($field_last_name)) {
            $fio = implode(' ', array($field_last_name, $field_first_name, $field_middle_name));
        } else {
            $fio = $field_full_name;
        }
        
        $fio = trim($fio);
        $fio = preg_split('/\s+/', $fio, 3);
        
        $last_name = $this->to_cyrillic($fio[0]);
        $first_name = !empty($fio[1]) ? $this->to_cyrillic($fio[1]) : '';
        $middle_name = !empty($fio[2]) ? $this->to_cyrillic($fio[2]) : '';
        
        return array(
            $first_name,
            $middle_name,
            $last_name,
        );
    }
    
    /**
     * Получение компонентов адреса после геокодирования исходной строки
     * @param nc_netshop_order $order
     * @return array $address_components
     */
    protected function get_yandex_address_components(nc_netshop_order $order) {
        // Компоненты адреса
        $city = $order->get_location_name();
        $street = $house = $housing = $building = $flat = '';
        $index = $this->data['to_zipcode'] ?: '';
        
        // Части адреса
        $field_address = $this->data['to_address'];
        $field_street = $this->data['to_street'];
        $field_house = $this->data['to_house'];
        $field_housing = $this->data['to_housing'];
        $field_building = $this->data['to_building'];
        $field_flat = $this->data['to_flat'];
        
        // Соберём воедино
        if (!empty($field_street) || !empty($field_house) || !empty($field_housing) || !empty($field_building) || !empty($field_flat)) {
            $local_address = array(
                $field_street,
                $field_house ? "дом $field_house" : '',
                $field_housing ? "корпус $field_housing" : '',
                $field_building ? "строение $field_building" : '',
                $field_flat ? "кв. $field_flat" : '',
            );
            $local_address = array_filter($local_address);
            $local_address = implode(', ', $local_address);
        } else {
            $local_address = trim($field_address);
        }

        $address = $local_address ? $city . ', ' . $local_address : $city;

        // Распарсим адрес в dadata.ru
        $api_key = $this->get_setting('dadata_api_key') ?: null;
        
        if (!empty($api_key)) {
            $url = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address';
            $data = array(
                'query' => $address,
                'count' => 1,
            );
            $headers = array(
                'Content-Type' => 'application/json',
                'Accept' => 'application/json',
                'Authorization' => "Token {$api_key}",
            );
            
            $response = $this->make_http_request($url, json_encode($data, JSON_UNESCAPED_UNICODE), $headers);
            
            if (!empty($response)) {
                $response = json_decode($response, true);
                
                if (!empty($response['suggestions'][0]['data'])) {
                    $response = $response['suggestions'][0]['data'];
                    
                    $city = $response['city'] ?: null;
                    $street = $response['street_with_type'] ?: null;
                    $house = $response['house'] ?: null;
                    
                    if (!empty($response['block'])) {
                        list($housing, $building) = explode(' стр ', $response['block']);
                    }
                    
                    $flat = $response['flat'] ?: null;
                    $index = $response['postal_code'] ?: null;
                }
            }
        }

        return array(
            $address,
            $city,
            $street,
            $house,
            $housing,
            $building,
            $flat,
            $index,
        );
    }
    
    /**
     * Обратная транслитерация строки
     * @param string $text
     * @return string $text
     */
    protected function to_cyrillic($text) {
        $tr = array(
            "a" => "а", "b" => "б", "c" => "с", "d" => "д",
            "e" => "е", "f" => "ф", "g" => "г", "h" => "х",
            "i" => "и", "j" => "ж", "k" => "к", "l" => "л",
            "m" => "м", "n" => "н", "o" => "о", "p" => "п",
            "q" => "к", "r" => "р", "s" => "с", "t" => "т",
            "u" => "ю", "v" => "в", "w" => "в", "x" => "кс",
            "y" => "у", "z" => "з", 
            "A" => "А", "B" => "Б", "C" => "С", "D" => "Д",
            "E" => "Е", "F" => "Ф", "G" => "Г", "H" => "Х",
            "I" => "И", "J" => "Ж", "K" => "К", "L" => "Л",
            "M" => "М", "N" => "Н", "O" => "О", "P" => "П",
            "Q" => "К", "R" => "Р", "S" => "С", "T" => "Т",
            "U" => "Ю", "V" => "В", "W" => "В", "X" => "КС",
            "Y" => "У", "Z" => "З",
        );
        
        return strtr($text, $tr);
    }

    // ----- Yandex-specific -----

    /**
     * Запрос к API Яндекс.Доставки
     *
     * @return array|false
     */
    protected function get_yandex_delivery_data() {
        $to_city = isset($this->data['to_location_data']['name'])
                       ? $this->data['to_location_data']['name']
                       : $this->data['to_city'];

        $data = array(
            'city_from' => $this->data['from_city'],
            'city_to' => $to_city,
            'index_city' => $this->data['to_zipcode'],
            'weight' => sprintf('%.3F', $this->data['weight'] / 1000),
            'length' => (int)$this->data['size1'],
            'width' => (int)$this->data['size2'],
            'height' => (int)$this->data['size3'],
            'assessed_value' => $this->data['valuation'],
        );
        
        return $this->make_yandex_api_request('searchDeliveryList', $data);
    }


    /**
     * @param string $method
     * @param array $data
     * @return array|false
     */
    protected function make_yandex_api_request($method, array $data) {
        if (!isset($this->yandex_keys[$method])) {
            $this->show_message_for_supervisor("Yandex.Delivery keys are not set for method $method");
            return false;
        }

        $nc_core = nc_core::get_object();

        if (!$nc_core->NC_UNICODE) {
            $data = $nc_core->utf8->array_win2utf($data);
        }

        $data['client_id'] = $this->yandex_ids['client']['id'];
        $data['sender_id'] = $this->yandex_ids['senders'][0]['id'];

        $values_string = self::get_array_values_for_yandex_signature($data);
        $data['secret_key'] = md5($values_string . $this->yandex_keys[$method]);
        
        $url = 'https://delivery.yandex.ru/api/last/' . $method;

        $result = $this->make_http_request($url, $data);
        if (!$result) {
            $this->show_message_for_supervisor("No response from $url");
            return false;
        }

        $result = json_decode($result, true);
        if (!$result) {
            $this->show_message_for_supervisor('Cannot decode response');
            return false;
        }

        if (!$nc_core->NC_UNICODE) {
            $result = $nc_core->utf8->array_utf2win($result);
        }

        if (nc_array_value($result, 'status') === 'error') {
            $errors = '';
            foreach ($result['data']['errors'] as $key => $value) {
                $errors[] = "<em>$key:</em> $value";
            }
            $this->show_message_for_supervisor(implode('<br>', $errors));
        }

        return $result;
    }

    /**
     * @param $data
     * @return array|string
     */
    static public function get_array_values_for_yandex_signature($data) {
        if (!is_array($data)) {
            return $data;
        }
        ksort($data);
        return implode('', array_map(function($k) {
            return nc_netshop_delivery_service_yandex::get_array_values_for_yandex_signature($k);
        }, $data));
    }

}
