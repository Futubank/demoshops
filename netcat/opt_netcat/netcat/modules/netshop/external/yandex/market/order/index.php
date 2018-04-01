<?php

require_once '../../../../../../connect_io.php';
$nc_core = nc_core::get_object();
$nc_core->modules->load_env();

// Авторизация Яндекс-Маркета по авторизационному токену
$all_headers = getallheaders();
nc_netshop_external_yandex_market_order::authorize($all_headers['Authorization']);

$netshop = nc_netshop::get_instance();
$input = json_decode(file_get_contents('php://input'), true);

switch($_GET['action']){

    // Уточнение состава заказа
    case '/cart':

        $items_array = nc_netshop_external_yandex_market_order::items_data_to_array($input['cart']['items']);
        $city = nc_netshop_external_yandex_market_order::get_city_field_value($input['cart']['delivery']['region']);

        $new_order = $netshop->create_order(array(
            'City' => $city
        ));

        $new_order->set_items(nc_netshop_item_collection::from_array($items_array));
        $cart_array = nc_netshop_external_yandex_market_order::build_cart_array($new_order);

        nc_netshop_external_yandex_market_order::return_json($cart_array);

        break;

    // Запрос на принятие заказа
    case '/order/accept':

        $items_array = nc_netshop_external_yandex_market_order::items_data_to_array($input['order']['items']);
        $city = nc_netshop_external_yandex_market_order::get_city_field_value($input['order']['delivery']['region']);
        $address = nc_netshop_external_yandex_market_order::build_address_by_array($input['order']['delivery']['address']);
        $delivery_point_id = isset($input['order']['delivery']['outlet']['id'])
                                 ? $input['order']['delivery']['outlet']['id']
                                 : null;

        $new_order = new nc_netshop_external_order(array(
            'properties' => array(
                'City' => $city,
                'Address' => $address,
                'OrderSource' => nc_netshop_external_yandex_market_order::get_yandex_order_source_id(),
                'ExternalID' => $input['order']['id'],
                'Email' => NETCAT_MODULE_NETSHOP_YANDEX_MARKET_ORDER_NO_DATA_YET,
                'Phone' => NETCAT_MODULE_NETSHOP_YANDEX_MARKET_ORDER_NO_DATA_YET,
                'ContactName' => NETCAT_MODULE_NETSHOP_YANDEX_MARKET_ORDER_NO_DATA_YET
            ),
            'delivery_variant_id' => $input['order']['delivery']['id'],
            'delivery_point_id' => $delivery_point_id,
            'items' => $items_array
        ));

        $payment_method = $input['order']['paymentMethod'];
        if ($payment_method) {
            $payment_methods_mapping = array(
                'YANDEX' => 'YandexMarketPrepaid'
            );
            if (in_array($payment_method, array_keys($payment_methods_mapping))) {
                $payment_method = $netshop->get_setting($payment_methods_mapping[$payment_method]);
            } else {
                $context = nc_netshop_condition_context::for_order($new_order->order);
                foreach ($netshop->payment->get_enabled_methods()->matching($context) as $enabled_payment_method) {
                    foreach(array(
                        'payment_on_delivery_cash' => 'CASH_ON_DELIVERY',
                        'payment_on_delivery_card' => 'CARD_ON_DELIVERY'
                    ) as $local_payment_method => $yandex_payment_method) {
                        if ($payment_method == $yandex_payment_method && $enabled_payment_method->get($local_payment_method)) {
                            $payment_method = $enabled_payment_method->get('id');
                            break;
                        }
                    }
                }
            }

            if ($payment_method) {
                $new_order->order->set('PaymentMethod', $payment_method);
                $new_order->order->save();
            }
        }

        nc_netshop_external_yandex_market_order::return_json(array(
            'order' => array(
                'accepted' => true,
                'id' => $new_order->id
            )
        ));

        break;

    // Уточнение данных заказа
    case '/order/status':

        $yandex_order_id = $db->escape($input['order']['id']);
        $order = $netshop->load_order_by_external_id(nc_netshop_external_yandex_market_order::get_yandex_order_source_id(), $yandex_order_id);

        $order_status_mapping = json_decode($netshop->get_setting('YandexMarketOrderStatusMapping'), true);

        // Данные клиента
        $buyer_data = $input['order']['buyer'];
        if ($buyer_data) {
            $order->set('Email', $buyer_data['email']);
            $order->set('Phone', $buyer_data['phone']);
            $order->set('ContactName', $buyer_data['firstName'] . ' ' . $buyer_data['lastName']);
        }

        // Статус заказа
        $order_status = $input['order']['status'];
        if ($order_status) {
            $order->set('Status', $order_status_mapping[$order_status]);
        }

        $order->save();
        break;

    // Если передано неверное действие, сообщаем об этом
    default:
        nc_netshop_external_yandex_market_order::return_json(array(
            'message' => 'Wrong action: ' . $_GET['action'],
            'data' => array('code' => 4)
        ));
}
