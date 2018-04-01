<?

class nc_payment_system_yandexcpp extends nc_payment_system {

    const ERROR_SHOPID_IS_NOT_VALID = NETCAT_MODULE_PAYMENT_YANDEX_CPP_ERROR_SHOPID_IS_NOT_VALID;
    const ERROR_SCID_IS_NOT_VALID = NETCAT_MODULE_PAYMENT_YANDEX_CPP_ERROR_SCID_IS_NOT_VALID;
    const ERROR_SHOP_PASSWORD_IS_NOT_VALID = NETCAT_MODULE_PAYMENT_YANDEX_CPP_ERROR_SHOP_PASSWORD_IS_NOT_VALID;
    const ERROR_AMOUNT = NETCAT_MODULE_PAYMENT_YANDEX_CPP_ERROR_AMOUNT;
    const ERROR_ORDER_ID_IS_NOT_VALID = NETCAT_MODULE_PAYMENT_YANDEX_CPP_ERROR_ORDER_ID_IS_NOT_VALID;
    const ERROR_PRIVATE_SECURITY_IS_NOT_VALID = NETCAT_MODULE_PAYMENT_YANDEX_CPP_ERROR_PRIVATE_SECURITY_IS_NOT_VALID;

    const TARGET_URL = "https://money.yandex.ru/eshop.xml";
    const TARGET_TEST_URL = "https://demomoney.yandex.ru/eshop.xml";

    protected $automatic = TRUE;

    // принимаемые валюты
    protected $accepted_currencies = array('RUB', 'RUR');

    protected $currency_map = array(
        'RUR' => 10643,
        'RUB' => 10643,
    );


    // параметры сайта в платежной системе
    // paymentType в формате "AC" если один и "PC:Яндекс деньги, AC:Банковская карта" если несколько
    protected $settings = array(
        'shopId' => null,
        'scid' => null,
        'shopPassword' => null,
        'shopFailURL' => null,
        'shopSuccessURL' => null,
        'paymentType' => null,
        'testMode' => null,
        'sendReceipts' => null
    );

    // передаваемые параметры
    protected $request_parameters = array(
        'payment_type' => null,
    );

    // коды НДС, используемые в ym_merchant_receipt
    static protected $yandex_vat_enum = array(
        '' => 1,
        0 => 2,
        10 => 3,
        18 => 4,
    );
    static protected $yandex_default_vat = 4;

    /**
     *
     */
    public function execute_payment_request(nc_payment_invoice $invoice) {
        $inputs = array(
            'shopId' => $this->get_setting('shopId'),
            'scid' => $this->get_setting('scid'),
            'sum' => $invoice->get_amount('%0.2F'),
            'orderNumber' => $invoice->get_id(),
            'orderDetails' => $invoice->get_description(),
            'customerNumber' => $invoice->get('customer_id'),
            'cps_email' => $invoice->get('customer_email'),
            'cps_phone' => nc_normalize_phone_number($invoice->get('customer_phone')),
            'cms_name' => 'netcat',
        );

        $unnecessary_settings = array('shopFailURL', 'shopSuccessURL');

        foreach($unnecessary_settings as $setting) {
            $value = $this->get_setting($setting);
            if ($value) {
                $inputs[$setting] = $value;
            }
        }

        if ($this->get_request_parameter('payment_type')) {
            $inputs['paymentType'] = $this->get_request_parameter('payment_type');
        } elseif ($this->get_setting('paymentType')) {
            $inputs['paymentType'] = $this->get_setting('paymentType');
        }

        // Чек. (Возвраты здесь не обрабатываются.)
        $receipt_data = $this->create_sell_receipt($invoice);
        if ($receipt_data) {
            $inputs['ym_merchant_receipt'] = json_encode($receipt_data);
        }

        $target_url = $this->get_setting('testMode')
                        ? nc_payment_system_yandexcpp::TARGET_TEST_URL
                        : nc_payment_system_yandexcpp::TARGET_URL;

        ob_end_clean();
        $form = "
            <html>
              <body>
                    <form action='" . $target_url . "' method='post'>" .
                    $this->make_inputs($inputs) . "
                </form>
                <script>
                  document.forms[0].submit();
                </script>
              </body>
            </html>
            ";
        echo $form;
    }

    /**
     * @param nc_payment_invoice $invoice
     * @return null|array
     */
    protected function create_sell_receipt(nc_payment_invoice $invoice) {
        if (!$this->get_setting('sendReceipts')) {
            return null;
        }

        $receipt = $invoice->get_sell_receipt();
        if (!$receipt) {
            return null;
        }

        $receipt_data = array(
            'customerContact' => $invoice->get_customer_contact_for_receipt(),
            'items' => array(),
        );

        /** @var nc_payment_invoice_item $item */
        foreach ($receipt->get_items() as $item) {
            $receipt_data['items'][] = array(
                'quantity' => $item->get('qty'),
                'price' => array(
                    'amount' => (float)$item->get('item_price'),
                ),
                'tax' => nc_array_value(self::$yandex_vat_enum, $item->get('vat_rate'), self::$yandex_default_vat),
                'text' => $item->get('name'),
            );
        }

        // нет способа проверить результат? если будет найден, то надо будет обновлять статус
        $receipt->save_status($receipt::STATUS_PENDING, array('ym_merchant_receipt' => $receipt_data));
        return $receipt_data;
    }


    /**
     * @param nc_payment_invoice $invoice
     */
    public function on_response(nc_payment_invoice $invoice = null) {
        $action = $this->get_response_value('action');

        if ($action == 'checkOrder') {
            $shop_id = $this->get_setting('shopId');
            $invoice_id = $this->get_response_value('invoiceId');

            $invoice->set('status', nc_payment_invoice::STATUS_WAITING);
            $invoice->save();

            $this->print_callback_answer('checkOrderResponse', 0, $invoice_id, $shop_id);
        } else if ($action == 'paymentAviso') {
            $shop_id = $this->get_setting('shopId');
            $invoice_id = $this->get_response_value('invoiceId');

            $this->print_callback_answer('paymentAvisoResponse ', 0, $invoice_id, $shop_id);
            $this->on_payment_success($invoice);
        }
    }

    /**
     *
     */
    public function validate_payment_request_parameters() {
        if (!$this->get_setting('shopId')) {
            $this->add_error(nc_payment_system_yandexcpp::ERROR_SHOPID_IS_NOT_VALID);
        }

        if (!$this->get_setting('scid')) {
            $this->add_error(nc_payment_system_yandexcpp::ERROR_SCID_IS_NOT_VALID);
        }
    }

    /**
     * @param nc_payment_invoice $invoice
     */
    public function validate_payment_callback_response(nc_payment_invoice $invoice = null) {
        $md5 = $this->get_response_value('md5');

        $signature_values = array(
            $this->get_response_value('action'),
            $this->get_response_value('orderSumAmount'),
            $this->get_response_value('orderSumCurrencyPaycash'),
            $this->get_response_value('orderSumBankPaycash'),
            $this->get_response_value('shopId'),
            $this->get_response_value('invoiceId'),
            $this->get_response_value('customerNumber'),
            $this->get_setting('shopPassword')
        );

        $key = strtoupper(md5(join(";", $signature_values)));
        $error = false;
        $action = $this->get_response_value('action');
        $shop_id = $this->get_setting('shopId');
        $invoice_id = $this->get_response_value('invoiceId');

        if ($invoice) {
            if ($key != $md5 || $shop_id != $this->get_setting('shopId')) {
                $error = nc_payment_invoice::STATUS_CALLBACK_ERROR;
                $this->add_error(nc_payment_system_yandexcpp::ERROR_INVALID_SIGNATURE);
            } else if ($invoice->get_amount() != $this->get_response_value('orderSumAmount')) {
                $error = nc_payment_invoice::STATUS_CALLBACK_WRONG_SUM;
                $this->add_error(nc_payment_system_yandexcpp::ERROR_INVALID_SUM);
            }

            if ($error) {
                $invoice->set('status', $error);
                $invoice->save();
            }
        } else {
            $error = true;
            $this->add_error(nc_payment_system_yandexcpp::ERROR_INVOICE_NOT_FOUND);
        }

        if ($error) {
            $this->print_callback_answer($action . 'Response', 1, $invoice_id, $shop_id);
        }
    }

    /**
     * @param string $response_type
     * @param int $code
     * @param int $invoice_id
     * @param int $shop_id
     */
    public function print_callback_answer($response_type, $code, $invoice_id, $shop_id) {
        $datetime = date('Y-m-d\TH:i:s.000P'); // образец из документации: '2011-05-04T20:38:00.000+04:00', с миллисекундами

        $out = '<?xml version="1.0" encoding="UTF-8"?>
<' . $response_type . ' performedDatetime ="' . $datetime . '" code="' . $code . '" invoiceId="' . $invoice_id . '" shopId="' . $shop_id . '"/>';

        echo $out;
    }

    public function load_invoice_on_callback() {
        return $this->load_invoice($this->get_response_value('orderNumber'));
    }

    /**
     * Возвращает форму заполнения деталей платежа.
     */
    public function get_request_form(nc_payment_invoice $invoice, $show = 1, $select_caption = '') {
        $select_caption = $select_caption ? $select_caption : "<label name='param_payment_type'>" . NETCAT_MODULE_PAYMENT_FORM_PAY_SELECT . ":</label>";
        $payment_types = explode(",", $this->get_setting('paymentType'));

        $select_types = '';
        if (count($payment_types) > 1) {
            $select_types = $select_caption;
            $select_types .= "<select name='param_payment_type'>";
            foreach ($payment_types as $type) {
               $type = explode(':' , $type);
               $select_types .= "<option value='" . trim($type[0]) . "'>" . trim($type[1] ? $type[1] : $type[0]) . "</option>";
            }
            $select_types .= "</select><p></p>";
            $show = 1;
        }

        $result = "<form action='" . $this->get_request_script_path() . "' method='post' target='_blank' id='nc_payment_form'>";
        $result .= $this->make_input('invoice_id', $invoice->get_id());
        $result .= $this->make_input('payment_system', get_class($this));
        $result .= $select_types;
        $result .= $show ? "<input type='submit' value='".NETCAT_MODULE_PAYMENT_FORM_PAY."'>" : "";
        $result .= "</form>";
        $result .= !$show ? "<script type='text/javascript'>document.getElementById('nc_payment_form').submit();</script>" : "";

        return $result;
    }

    /**
     * @return bool
     */
    public function can_send_receipt_data_with_invoice() {
        return (bool)$this->get_setting('sendReceipts');
    }
}
