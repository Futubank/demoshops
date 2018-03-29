<?php
/**
atonator.com. All rights reserved.
 * @package    Driver_PaymentSystem 
 * @version    2.1 
 * @size       19008 Ir0IylM8FLAw8+FJMznCOcsj9TRGquV7yaOgqNH9Rxnqx4SQ+q4LOz1aNU7EpPJx+TIuwurEOYeg7H7VMs/n/M9RTaG9zfXQRnjq/y1P1GUQLOqNux/gPZhBxTf2pGpAWCOj+IQQdaSKt9du+CiGIKeLqPsTVDiCcx/AB8//hnY=
 */
?><?php


/**
 * OnPay.ru payment system driver.
 *
 * @package Driver_PaymentSystem
 */
class AtoOnpay_PaymentSystemDriver extends AMI_PaymentSystemDriver
{
    /**#@+
     * Internal error code
     */

    const AMI_ERROR_MISSING_OBLIGATORY_PARAMETER = 1;
    const AMI_ERROR_RUR_ONLY = 2;
    const AMI_ERROR_UNSUPPORTED_CURRENCY = 3;
    const AMI_ERROR_MISSING_ORDER_ID = 4;
    const AMI_ERROR_INVALID_SIGN = 5;

    /**#@-*/

    /**#@+
     * OnPay.ru error code
     */

    const ONPAY_ERROR_PAYMENT_CANCELLED = 2;
    const ONPAY_ERROR_INVALID_REQUEST_PARAMS = 3;
    const ONPAY_ERROR_INVALID_REQUEST_SIGN = 7;
    const ONPAY_ERROR_TEMPORARY = 10;

    /**#@-*/

    /**
     * Driver name
     *
     * @var string
     */
    protected $driverName = 'ato_onpay';

    /**
     * Secret key
     *
     * @var string
     * @see AtoOnpay_PaymentSystemDriver::payCallback()
     */
    private $_secretKey;

    /**
     * Payment system background callback request data
     *
     * @var array
     * @see AtoOnpay_PaymentSystemDriver::payCallback()
     */
    private $_request;

    /**
     * Payment system background callback XML response
     *
     * @var string
     */
    private $_response;

    /**
     * Returns request key name for order id.
     *
     * @return string
     */
    public static function getOrderIdVarName()
    {
        return 'pay_for';
    }

    /**
     * Return real system order id from data that provided by payment system.
     *
     * @param  array $aGet               HTTP-GET data
     * @param  array $aPost              HTTP-POST data
     * @param  array &$aRes              Rreserved array reference
     * @param  array $aAdditionalParams  Reserved array
     * @return int   Order Id
     * @see AMI_PaymentSystemDriver::getProcessOrder()
     */
    public function getProcessOrder(array $aGet, array $aPost, array &$aRes, array $aAdditionalParams)
    {
        $request = $aGet + $aPost;
        $orderId = isset($request['pay_for']) ? (int)$request['pay_for'] : 0;
        if ($orderId) {
            $aRes['error'] = 'Success';
            $aRes['errno'] = 0;
        } else {
            $aRes['error'] = 'Missing order id';
            $aRes['errno'] = self::AMI_ERROR_MISSING_ORDER_ID;
        }
        return $orderId;
    }

    /**
     * Get checkout button HTML form.
     *
     * @param  array &$aRes         Will contain "error" (error description,
     *                              'Success by default') and "errno"
     *                              (error code, 0 by default). "forms" will
     *                              contain a created form
     * @param  array $aData         The data list for button generation
     * @param  bool  $bAutoRedirect If form autosubmit required
     *                              (directly from checkout page)
     * @return bool  True if form is generated, false otherwise
     */
    public function getPayButton(array &$aRes, array $aData, $bAutoRedirect = FALSE)
    {
        // Format fields
        foreach (array('return', 'description') as $k){
            $aData[$k] = htmlspecialchars($aData[$k]);
        }
        $currency = $aData['driver_currency'];
        switch ((int)$aData['onpay_payment']) {
            case 0:
                // RUR currency only
                if ($currency != 'RUR') {
                $aRes['error'] = 'Only RUR currency is supported';
                $aRes['errno'] = self::AMI_ERROR_RUR_ONLY;
                    return FALSE;
                }
                break;
            case 2:
                // Supported currence only
                if (!isset($aData['onpay_payment_' . $currency])) {
                    $aRes['error'] = 'Unsupported currency ' . $currency;
                    $aRes['errno'] = self::AMI_ERROR_UNSUPPORTED_CURRENCY;
                    return FALSE;
                }
                break;
        }

        // Wipe fields starting with 'onpay_' from form hidden fields
        foreach (array_keys($aData) as $key) {
            if (mb_strpos($key, 'onpay_') === 0) {
                unset($aData[$key]);
            }
        }
        // Wipe exclusions from form hidden fields
        $aEclusion =
            array(
                'return',
                'cancel',
                'callback',
                'pay_to_email',
                'amount',
                'currency',
                'description_title',
                'description',
                'order',
                'button_name',
                'button'
            );
        // Fill form hidden fields
        $hiddens = '';
        foreach ($aData as $key => $value) {
            if (!in_array($key, $aEclusion)) {
                $hiddens .=
                    '<input type="hidden" name="' . $key .
                    '" value="' . (is_null($value) ? $aData[$key] : $value) .
                    '" />' . "\n";
            }
        }
        $aData['hiddens'] = $hiddens;

        return parent::getPayButton($aRes, $aData, $bAutoRedirect);
    }

    /**
     * Get the form that will be autosubmitted to payment system.
     * This step is required for some shooping cart actions.
     *
     * @param  array $aData  The data list for button generation
     * @param  array &$aRes  Will contain "error" (error description,
     *                       'Success by default') and "errno"
     *                       (error code, 0 by default). "forms" will contain
     *                       a created form
     * @return bool  True if form is generated, false otherwise
     */
    public function getPayButtonParams(array $aData, array &$aRes)
    {
        // Check parameters and set fields

        /**
         * @var AMI_Response
         */
        $oResponse = AMI::getSingleton('response');
        $oResponse->HTTP->setCookie('ato_onpay_order', NULL);

        // Check obligatory parameters
        foreach (array('onpay_login', 'onpay_secret_key') as $key) {
            if(empty($aData[$key])){
                $aRes['errno'] = self::AMI_ERROR_MISSING_OBLIGATORY_PARAMETER;
                $aRes['error'] = 'Obligatory parameter "' . $key . ' is missed';
                return FALSE;
            }
        }

        // Set defaults
        $aData += array(
            'onpay_convert'     => FALSE,
            'onpay_price_final' => FALSE,
            'onpay_direct_no'   => FALSE,
            'onpay_payment'     => 0,
            'onpay_one_way'     => FALSE
        );
        $aData['onpay_convert'] = $aData['onpay_convert'] ? 'yes' : 'no';
        $aData['onpay_price_final'] = $aData['onpay_price_final'] ? 'true' : '';
        $aData['onpay_direct_no'] = $aData['onpay_direct_no'] ? 'true' : '';

        // Check currency settings {

        $currency = $aData['driver_currency'];
        switch ((int)$aData['onpay_payment']) {
            case 0:
                // RUR currency only
                if ($currency != 'RUR') {
                    $aRes['error'] = 'Only RUR currency is supported';
                    $aRes['errno'] = self::AMI_ERROR_RUR_ONLY;
                    return FALSE;
                }
                break;
            case 1:
                // Convert any order currency to RUR
                if ($currency != 'RUR') {
                    $aData['amount'] =
                        number_format(
                            $GLOBALS['oEshop']
                                ->convertCurrency(
                                    $aData['amount'],
                                    $aData['driver_currency'],
                                    'RUR'
                                ),
                            2,
                            '.',
                            ''
                        );
                    $aData['driver_currency'] = 'RUR';
                }
                break;
            case 2:
                // Supported currence only
                if (isset($aData['onpay_payment_' . $currency])) {
                    $aData['driver_currency'] = 'RUR';
                    $aData['onpay_one_way'] = $aData['onpay_payment_' . $currency];
                } else {
                    $aRes['error'] = 'Currency (' . $currency . ') is not supported';
                    $aRes['errno'] = self::AMI_ERROR_UNSUPPORTED_CURRENCY;
                    return FALSE;
                }
                break;
        }

        // } Check currency settings

        $aRes['errno'] = 0;
        $aRes['error'] = 'Success';

        // Sign
        // pay_mode;price;currency;pay_for;convert;secret_key
        $aData['md5'] = md5(
            'fix;' .
            number_format($aData['amount'], 1, '.', '') . ';' .
            $aData['driver_currency'] . ';' .
            $aData['order'] . ';' .
            $aData['onpay_convert'] . ';' .
            $aData['onpay_secret_key']
        );

        $tail =
            '&sign=' . md5(
                $aData['order'] . ';' .
                $aData['onpay_secret_key']
            );
        $aData['url_success'] = $aData['return'] . $tail;
        $aData['url_fail'] = $aData['cancel'] . $tail;

        return parent::getPayButtonParams($aData, $aRes);
    }

    /**
     * Verify the order by payment system background response.
     * In success case 'confirmed' status will be setup for order.
     *
     * @param  array $aGet        HTTP-GET data
     * @param  array $aPost       HTTP-POST data
     * @param  array &$aRes       Reserved array reference
     * @param  array $aCheckData  Data that provided in driver configuration
     * @param  array $aOrderData  Order data that contains such fields as id, total, order_date, status
     * @return int   -1 - ignore post, 0 - reject(cancel) order, 1 - confirm order
     * @see AMI_PaymentSystemDriver::payCallback()
     */
    public function payCallback(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData)
    {
        $this->_secretKey = $aCheckData['onpay_secret_key'];

        $this->_request =
            $aPost + $aGet +
            array(
                'type'           => '',
                'pay_for'        => '',
                'onpay_id'       => '',
                'order_amount'   => '',
                'order_currency' => ''
            );

        // Check obligatory parameters for check / pay OnPay requests

        $obligatoryParams =
            array(
                'pay_for',
                'order_amount',
                'order_currency',
                'type',
                'md5'
            );
        $result = -1; // Amiro.CMS flag specifying to ignore request
        switch ($this->_request['type']) {
            case 'check':
                break;
            case 'pay':
                $result = 1; // Amiro.CMS flag specifying to confirm order
                $obligatoryParams +=
                    array(
                        'onpay_id',
                        'paymentDateTime'
                    );
                break;
            default:
                if (empty($this->_request[$param])) {
                    $this->prepareResponse(
                        self::ONPAY_ERROR_INVALID_REQUEST_PARAMS,
                        "Invalid 'type' parameter value '" .
                            $this->_request['type'] . "'"
                    );
                    $this->sendResponse();
                }
        }
        foreach ($obligatoryParams as $param) {
            if (empty($this->_request[$param])) {
                $this->prepareResponse(
                    self::ONPAY_ERROR_INVALID_REQUEST_PARAMS,
                    "Missing obligatory parameter '{$param}'"
                );
                $this->sendResponse();
            }
        }
        $this->validateRequestSign();
        $this->prepareResponse();
        if ($this->_request['type'] == 'check') {
            // Send response immidiatly for 'check' request
            $this->sendResponse();
        }
        return $result;
    }

    /**
     * Do required operations after the payment is confirmed with payment system call.
     *
     * @param  int $orderId  Id of order in the system will be passed to this function
     * @return void
     */
    public function onPaymentConfirmed($orderId)
    {
        if ($this->_request['pay_for'] == $orderId) {
            $this->prepareResponse();
            $this->sendResponse();
        }
    }

    /**
     * Verify the order from user back link.
     * In success case 'accepted' status will be setup for order.
     *
     * @param  array $aGet        HTTP-GET data
     * @param  array $aPost       HTTP-POST data
     * @param  array &$aRes       Reserved array reference
     * @param  array $aCheckData  Data that provided in driver configuration
     * @param  array $aOrderData  Order data that contains such fields as id, total, order_date, status
     * @return bool  True if order is correct and false otherwise
     * @see AMI_PaymentSystemDriver::payProcess()
     */
    public function payProcess(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData)
    {
        $aRes['error'] = 'Success';
        $aRes['errno'] = 0;

        $request =
            $aGet +
            array('status' => 'fail', 'item_number' => 0, 'sign' => '');

        $res = $request['status'] == 'ok';
        if (
            $request['sign'] != md5(
                $request['item_number'] . ';' .
                $aCheckData['onpay_secret_key']
            )
        ) {
            $res = FALSE;
            $aRes['error'] = 'Invalid sign';
            $aRes['errno'] = self::AMI_ERROR_INVALID_SIGN;
        }

        return $res;
    }

    /**
     * Returns true if CMS version is supported by the driver.
     *
     * @return bool
     */
    private function isCMSVersionValid()
    {
        return
            !(
                $version[0] < 5 ||
                ($version[0] == 5 && $version[1] < 12) ||
                ($version[0] == 5 && $version[1] == 12 && $version[2] < 12)
            );
    }

    /**
     * Prepares XML response for OnPay.ru.
     *
     * @param  int    $code     Response code
     * @param  string $message  Response Message
     * @return void
     */
    private function prepareResponse($code = 0, $message = 'OK')
    {
        $sign = $this->getResponseSign($code);
        $orderId =
            isset($this->_request['pay_for'])
                ? $this->_request['pay_for']
                : '';
        if ($this->_request['type'] == 'check') {
            $response =
    <<<EOT
<?xml version="1.0" encoding="UTF-8"?>
<result>
    <code>{$code}</code>
    <pay_for>{$orderId}</pay_for>
    <comment>{$message}</comment>
    <md5>{$sign}</md5>
</result>
EOT;
        } else {
            $onpayId = $this->_request['onpay_id'];
            $response =
<<<EOT
<?xml version="1.0" encoding="UTF-8"?>
<result>
    <code>{$code}</code>
    <comment>{$message}</comment>
    <onpay_id>{$onpayId}</onpay_id>
    <pay_for>{$orderId}</pay_for>
    <order_id>{$orderId}</order_id>
    <md5>{$sign}</md5>
</result>
EOT;
        }
        $this->_response = $response;
    }

    /**
     * Sends prepared XML response to the OnPay.ru.
     *
     * @return void
     */
    private function sendResponse()
    {
        // Clean up buffer
        while(ob_get_level()){
            $aStatus = ob_get_status();
            if('ob_gzhandler' === $aStatus['name']){
                break;
            }
            ob_end_clean();
        }
        header('Status: 200 OK');
        header('HTTP/1.0 200 OK');
        echo $this->_response;
        die;
    }

    /**
     * Validates expected OnPay.ru sign.
     *
     * @return void
     */
    private function validateRequestSign()
    {
        // type;pay_for;order_amount;order_currency;secret_key_for_api_in
        // type;pay_for;onpay_id;order_amount;order_currency;secret_key_for_api_in
        $sign =
            strtoupper(
                md5(
                    $this->_request['type'] . ';' .
                    $this->_request['pay_for'] . ';' .
                    (
                        $this->_request['type'] === 'check'
                            ? ''
                            : $this->_request['onpay_id'] . ';'
                    ) .
                    $this->_request['order_amount'] . ';' .
                    $this->_request['order_currency'] . ';' .
                    $this->_secretKey
                )
            );
        if ($this->_request['md5'] != $sign) {
            $this->prepareResponse(
                self::ONPAY_ERROR_INVALID_REQUEST_SIGN,
                'Invalid sign'
            );
            $this->sendResponse();
        }
    }

    /**
     * Returns OnPay.ru response sign.
     *
     * @param  int $code  Response code
     * @return string
     */
    private function getResponseSign($code)
    {
        return
            strtoupper(
                md5(
                    $this->_request['type'] === 'check'
                        ?
    // type;pay_for;order_amount;order_currency;code;secret_key_api_in
                            $this->_request['type'] . ';' .
                            $this->_request['pay_for'] . ';' .
                            $this->_request['order_amount'] . ';' .
                            $this->_request['order_currency'] . ';' .
                            $code . ';' .
                            $this->_secretKey
                        :
    // type;pay_for;onpay_id;order_id;order_amount;order_currency;code;secret_key_api_in
    // order_id === pay_for
                            $this->_request['type'] . ';' .
                            $this->_request['pay_for'] . ';' .
                            $this->_request['onpay_id'] . ';' .
                            $this->_request['pay_for'] . ';' .
                            $this->_request['order_amount'] . ';' .
                            $this->_request['order_currency'] . ';' .
                            $code . ';' .
                            $this->_secretKey
                )
            );
    }
}
