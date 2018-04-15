<?php

require_once('fpayments.php');

class nc_payment_system_modulbank extends nc_payment_system
{

    // принимаемые валюты
    protected $accepted_currencies = array('RUB', 'RUR');

    // параметры сайта в платежной системе
    protected $settings = array(
        'merchant_id' => null,
        'secret_key' => null,
        'is_test' => false,
        'nds' => 1,
        'receipt_enabled' => false,
    );

    // передаваемые параметры
    protected $request_parameters = array();

    public function can_send_receipt_data_with_invoice() {
        return $this->get_setting('receipt_enabled');
    }

    /**
     * @param nc_payment_invoice $invoice
     */
    public function execute_payment_request(nc_payment_invoice $invoice)
    {
        $client_email = $invoice->get('customer_email');
        $client_name = $invoice->get('customer_name');
        $client_phone = $invoice->get('customer_phone');

        $receipt_contact = '';
        $receipt_items = null;
        if ($this->get_setting('receipt_enabled')) {
            $nds = $this->get_setting('nds');
            $receipt_contact = $client_email;
            $receipt_items = array();
            foreach ($invoice->get_items() as $item) {
                $item_s = array();
                foreach ($item as $key => $val) {
                    if ($key == 'name') {
                        $item_s['name'] = $this->fix_encoding($val);
                    }
                    if ($key == 'item_price') {
                        $item_s['item_price'] = $val;
                    }
                    if ($key == 'qty') {
                        $item_s['qty'] = $val;
                    }
                }
                $receipt_items[] = new FPaymentsRecieptItem($item_s['name'], $item_s['item_price'], $item_s['qty'], $nds);
            }
        }

        // FIXME: должно работать $NETSHOP['OrderURL'], но там пусто
        $success_url = $this->abs_url('/orders/');
        $fail_url = $this->abs_url('/orders/');
        $cancel_url = $this->abs_url('/orders/');

        $meta = '';

        $form = $this->get_fpayments_form();
        $form_data = $form->compose(
            $invoice->get_amount('%0.2F'),
            $this->fix_currency($invoice->get_currency()),
            $invoice->get_id(),
            $client_email,
            $client_name,
            $client_phone,
            $success_url,
            $fail_url,
            $cancel_url,
            $meta,
            $this->fix_encoding($invoice->get_description()),
            $receipt_contact,
            $receipt_items
        );

        ob_end_clean();
        echo "
            <html>
              <body>
                <form action='" . $form->get_url() . "' method='post'>" . FPaymentsForm::array_to_hidden_fields($form_data) . "
                </form>
                <script>
                  document.forms[0].submit();
                </script>
              </body>
            </html>
        ";
        exit;
    }

    public function abs_url($path) {
        // FIXME: порт не учитывается
        if (isset($_SERVER['HTTPS'])) {
            $scheme = $_SERVER['HTTPS'];
        } else {
            $scheme = '';
        }
        if (($scheme) && ($scheme != 'off')) {
            $scheme = 'https://';
        } else {
            $scheme = 'http://';
        }
        return $scheme . $_SERVER['SERVER_NAME'] . $GLOBALS['SUB_FOLDER'] . $path;
    }

    public function fix_currency($s) {
        if ($s == 'RUR') {  // старый код рубля
            return 'RUB';
        }
        return $s;
    }

    public function fix_encoding($s) {
        $nc_core = nc_core::get_object();
        if ($nc_core->NC_UNICODE) {
            return $s;
        } else {
            return $nc_core->utf8->win2utf($s);
        }
    }

    /**
     * @param nc_payment_invoice $invoice
     */
    public function on_response(nc_payment_invoice $invoice = null)
    {
        $h = new ModulbankCallbackHandler($this);
        $h->show($_POST);
    }

    /**
     *
     */
    public function validate_payment_request_parameters()
    {

    }

    /**
     * @param nc_payment_invoice $invoice
     */
    public function validate_payment_callback_response(nc_payment_invoice $invoice = null)
    {

    }

    public function get_fpayments_form() {
        $plugininfo = 'nc_payment_system_modulbank';
        $nc_core = nc_core::get_object();
        try {
            $version = $nc_core->get_settings('VersionNumber', 'system');
        } catch (Exception $e) {
            $version = '?';
        }
        $cmsinfo = 'NetCat ' . $version;
        return new FPaymentsForm(
            $this->get_setting('merchant_id'),
            $this->get_setting('secret_key'),
            (bool)$this->get_setting('is_test'),
            $plugininfo,
            $cmsinfo
        );
    }

    // паттерн «паблик Морозов»

    public function load_invoice($order)
    {
        return parent::load_invoice($order);
    }

    public function on_payment_success($order)
    {
        return parent::on_payment_success($order);
    }

    public function on_payment_failure($order)
    {
        return parent::on_payment_failure($order);
    }

}


class ModulbankCallbackHandler extends AbstractFPaymentsCallbackHandler
{
    private $plugin;

    public function __construct($plugin)
    {
        $this->plugin = $plugin;
    }

    /**
     * @return FPaymentsForm
     */
    protected function get_fpayments_form()
    {
        return $this->plugin->get_fpayments_form();
    }

    protected function load_order($order_id)
    {
        return $this->plugin->load_invoice($order_id);
    }

    protected function get_order_currency($order)
    {
        return $this->plugin->fix_currency($order->get_currency());
    }

    protected function get_order_amount($order)
    {
        return $order->get_amount('%0.2F');
    }

    /**
     * @return bool
     */
    protected function is_order_completed($order)
    {
        return $order->get('status') >= nc_payment_invoice::STATUS_SUCCESS;
    }

    protected function mark_order_as_completed($order, array $data)
    {
        $this->plugin->on_payment_success($order);
        return true;
    }

    protected function mark_order_as_error($order, array $data)
    {
        $this->plugin->on_payment_failure($order);
        return true;
    }

}