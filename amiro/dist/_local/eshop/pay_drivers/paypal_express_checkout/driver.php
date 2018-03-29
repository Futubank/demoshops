<?php
/**
 * @copyright Amiro.CMS. All rights reserved. Changes are not allowed.
 * @category  AMI
 * @package   Driver_PaymentSystem
 * @version   $Id: driver.php 42587 2013-10-23 12:05:12Z Leontiev Anton $
 */

/**
 * PayPal Express Checkout pay driver
 *
 * @package Driver_PaymentSystem
 */
class PaypalExpressCheckout_PaymentSystemDriver extends AMI_PaymentSystemDriver{
    const EXPRESS_CHECKUPUT_PROTOCOL_VERSION = 109;

    const ERROR_MISSING_PARAMETER = 1;
    const ERROR_REQUEST_FAILED    = 2;
    const ERROR_RESPONSE_FAILED   = 3;
    const ERROR_INVALID_ORDER_ID  = 4;
    const ERROR_INVALID_TOKEN     = 5;

    /**
     * Flag specifying to log all request/responses
     *
     * @var bool
     */
    protected $logAll = FALSE;

    /**
     * Returns request key name for order id.
     *
     * @return string
     */
    public static function getOrderIdVarName(){
        return 'item_number';
    }

    /**
     * Get checkout button HTML form.
     *
     * @param  array &$aRes          Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @param  array $aData          The data list for button generation
     * @param  bool  $bAutoRedirect  If form autosubmit required (directly from checkout page)
     * @return bool true if form is generated, false otherwise
     */
    public function getPayButton(array &$aRes, array $aData, $bAutoRedirect = false){
        foreach(array(
            'drv_request_url',
            'drv_payment_url',
            'drv_login',
            'drv_password',
            'drv_signature'
        ) as $parameter){
            if(empty($aData[$parameter])){
                $message = "Missing '" . $parameter . "' parameter value";
                $this->reportError($message);
                $aRes['error'] = $message;
                $aRes['errno'] = self::ERROR_MISSING_PARAMETER;

                return FALSE;
            }
        }

        $indeces = array_keys($aData);
        foreach($indeces as $index){
            if('drv_' === mb_substr($aData[$index], 0, 4)){
                unset($aData[$index]);
            }
        }
        $aData['hiddens'] = $this->getScopeAsFormHiddenFields($aData);

        return parent::getPayButton($aRes, $aData, $bAutoRedirect);
    }

    /**
     * Get the form that will be autosubmitted to payment system. This step is required for some shooping cart actions.
     *
     * @param array $aData  The data list for button generation
     * @param array &$aRes  Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @return bool true if form is generated, false otherwise
     */
    public function getPayButtonParams($aData, &$aRes){
        if(!is_array($aRes)){
            $aRes = array();
        }

        $orderId = (int)$aData['order_id'];
        $oOrder =
            AMI::getResourceModel('eshop_order/table')
            ->find($orderId);
        if($orderId != $oOrder->id){
            $message = "Invalid order id '" . $aData['order_id'] . "'";
            $this->reportError($message);
            $aRes['error'] = $message;
            $aRes['errno'] = self::ERROR_INVALID_ORDER_ID;

            return FALSE;
        }

        $countryCode = $aData['drv_country_code'];

        // PaPpal doesn't support RUR
        $currency = $aData['currency'];
        if('RUR' === $currency){
            $currency = 'RUB';
        }

        // Do SetExpressCheckout request
        $aRequest =
            array(
                'USER'       => $aData['drv_login'],
                'PWD'        => $aData['drv_password'],
                'SIGNATURE'  => $aData['drv_signature'],
                'METHOD'     => 'SetExpressCheckout',
                'VERSION'    => self::EXPRESS_CHECKUPUT_PROTOCOL_VERSION,
                'RETURNURL'  => $aData['return'],
                'CANCELURL'  => $aData['cancel'],
                'LOCALECODE' => mb_strtoupper($aData['language']),

                'PAYMENTREQUEST_0_PAYMENTACTION' => 'Sale',
                'PAYMENTREQUEST_0_AMT'           => $aData['amount'],
                'PAYMENTREQUEST_0_CURRENCYCODE'  => $currency
            );

        // Add data from order
        $aCart = array();
        foreach(
            array(
                'shipping' => 'PAYMENTREQUEST_0_SHIPPINGAMT',
                'tax'      => 'PAYMENTREQUEST_0_TAXAMT'
            ) as $srcField => $destField
        ){
            $aCart[$destField] = $oOrder->getValue($srcField);
        }

        if('' != $countryCode){
            $aOrderData = $oOrder->custom_info;
            $shipToName = '';
            if(!empty($oOrder->firstname)){
                $shipToName = $oOrder->firstname;
            }
            if(!empty($oOrder->lastname)){
                $shipToName = trim($shipToName . ' ' . $oOrder->lastname);
            }
            $aOrderData['drv_name'] = $shipToName;

            foreach(
                array(
                    'city'     => 'PAYMENTREQUEST_0_SHIPTOCITY',
                    'region'   => 'PAYMENTREQUEST_0_SHIPTOSTATE',
                    'zip'      => 'PAYMENTREQUEST_0_SHIPTOZIP',
                    'drv_name' => 'PAYMENTREQUEST_0_SHIPTONAME'
                ) as $srcField => $destField
            ){
                if(isset($aOrderData[$srcField])){
                    $aCart[$destField] = $aOrderData[$srcField];
                }
            }

            $aAddress = array();
            foreach(array('street', 'house', 'app') as $srcField){
                if(isset($aOrderData[$srcField])){
                    $aAddress[] = $aOrderData[$srcField];
                }
            }
            if(sizeof($aAddress)){
                $aCart['PAYMENTREQUEST_0_SHIPTOSTREET'] = implode(', ', $aAddress);
            }
        }

        // Add data from order and part of driver options
        foreach(
            array(
                'email'   => 'PAYMENTREQUEST_0_EMAIL',
                'contact' => 'PAYMENTREQUEST_0_SHIPTOPHONENUM',
                'phone'   => 'PAYMENTREQUEST_0_SHIPTOPHONENUM',

                'drv_site_logo'  => 'LOGOIMG',
                'drv_site_color' => 'CARTBORDERCOLOR'
            ) as $srcField => $destField
        ){
            if(isset($aData[$srcField]) && '' !== $aData[$srcField]){
                $aCart[$destField] = $aData[$srcField];
            }
        }
        if('' != $countryCode){
            if(!sizeof($aAddress) && isset($aData['street'])){
                $aCart['PAYMENTREQUEST_0_SHIPTOSTREET'] = $aData['street'];
            }
        }

        // Override shipping address
        if('' != $countryCode){
            $doOverrideShippingAddress = TRUE;
            foreach(
                array(
                    'PAYMENTREQUEST_0_SHIPTONAME',
                    'PAYMENTREQUEST_0_SHIPTOSTREET',
                    'PAYMENTREQUEST_0_SHIPTOCITY',
                    'PAYMENTREQUEST_0_SHIPTOZIP',
                ) as $obligatoryShippingField
            ){
                if(empty($aCart[$obligatoryShippingField])){
                    $this->reportError("Missing shipping obligatory parameter '" . $obligatoryShippingField . "'");
                    $doOverrideShippingAddress = FALSE;
                    break;
                }
            }
            if($doOverrideShippingAddress){
                $aCart['PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE'] = $countryCode;
                $aCart['ADDROVERRIDE'] = 1;
            }
        }

        // Add data from order products
        $oOrderProductList =
            AMI::getResourceModel('eshop_order_item/table', array(array('doRemapListItems' => TRUE)))
            ->getList()
            ->addColumn('*')
            ->addSearchCondition(array('id_order' => $orderId))
            ->load();

        $sum = 0;
        $productIndex = 0;
        foreach($oOrderProductList as $oProduct){
            $aProduct = $oProduct->data;
            $aProduct = $aProduct['item_info'];
            $aCart['L_PAYMENTREQUEST_0_NAME' . $productIndex] = $aProduct['name'];
            $aCart['L_PAYMENTREQUEST_0_NUMBER' . $productIndex] = $aProduct['sku'];
            $aCart['L_PAYMENTREQUEST_0_AMT' . $productIndex] = $aProduct['price'];
            $aCart['L_PAYMENTREQUEST_0_QTY' . $productIndex] = $oProduct->qty;
            $sum += $oProduct->qty * $aProduct['price'];
            $productIndex++;
        }
        $aCart['PAYMENTREQUEST_0_HANDLINGAMT'] = $aData['amount'] - $oOrder->shipping - $oOrder->tax - $sum;
        $aCart['PAYMENTREQUEST_0_ITEMAMT'] = $sum;

        $aRequest = $aCart + $aRequest;

        $aResponse = $this->sendRequest(
            $aData['drv_request_url'],
            $aRequest,
            $aRes
        );
        if(!$aResponse){
            return FALSE;
        }

        $aOrderData = $oOrder->data;
        $aOrderData['drv_token'] = $aResponse['TOKEN'];
        $aOrderData['drv_cart'] = $aCart;
        $oOrder->data = $aOrderData;
        $oOrder->save();
        $aData['drv_payment_url'] .= '?cmd=_express-checkout&token=' . $aResponse['TOKEN'];

        return parent::getPayButtonParams($aData, $aRes);
    }

    /**
     * Verify the order from user back link. In success case 'accepted' status will be setup for order.
     *
     * @param array $aGet        HTTP GET variables
     * @param array $aPost       HTTP POST variables
     * @param array &$aRes       Reserved array reference
     * @param array $aCheckData  Data that provided in driver configuration
     * @param array $aOrderData  Order data that contains such fields as id, total, order_date, status
     * @return bool  TRUE if order is correct and FALSE otherwise
     */
    public function payProcess(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData){
        $aRes = array(
            'error' => 'Success',
            'errno' => 0
        );

        $aGet = $aGet + array('status' => 'fail', 'item_number' => 0, 'token' => '', 'PayerID' => '');

        $orderId = (int)$aGet['item_number'];
        $res = $orderId > 0;
        if($res){
            $oOrder =
                AMI::getResourceModel('eshop_order/table')
                ->find($orderId);
            $res = $orderId == $oOrder->id;
            if($res){
                $aOrderData = $oOrder->data;
                if($aGet['token'] !== $aOrderData['drv_token']){
                    $message = "Invalid token '" . $aGet['token'] . "' instead of '" . $aOrderData['drv_token'] . "'";
                    $this->reportError($message);
                    $aRes['error'] = $message;
                    $aRes['errno'] = self::ERROR_INVALID_TOKEN;

                    return FALSE;
                }
            }
        }
        if(!$res){
            $message = "Invalid order id '" . $aGet['item_number'] . "'";
            $this->reportError($message);
            $aRes['error'] = $message;
            $aRes['errno'] = self::ERROR_INVALID_ORDER_ID;

            return FALSE;
        }
        if('ok' !== $aGet['status']){
            return FALSE;
        }

        // Do GetExpressCheckoutDetails request
        $aRequest =
            array(
                'USER'      => $aCheckData['drv_login'],
                'PWD'       => $aCheckData['drv_password'],
                'SIGNATURE' => $aCheckData['drv_signature'],
                'METHOD'    => 'GetExpressCheckoutDetails',
                'VERSION'   => self::EXPRESS_CHECKUPUT_PROTOCOL_VERSION,
                'TOKEN'     => $aGet['token']
            );

        $aResponse = $this->sendRequest(
            $aCheckData['drv_request_url'],
            $aRequest,
            $aRes
        );
        if(!$aResponse){
            return FALSE;
        }

        // Do DoExpressCheckoutPayment request
        $aRequest = $aOrderData['drv_cart'] + array(
            'METHOD'                         => 'DoExpressCheckoutPayment',
            'PAYERID'                        => $aGet['PayerID'],
            'PAYMENTREQUEST_0_PAYMENTACTION' => 'Sale',
            'PAYMENTREQUEST_0_AMT'           => $aResponse['PAYMENTREQUEST_0_AMT'],
            'PAYMENTREQUEST_0_CURRENCYCODE'  => $aResponse['PAYMENTREQUEST_0_CURRENCYCODE']
        ) + $aRequest;

        $aResponse = $this->sendRequest(
            $aCheckData['drv_request_url'],
            $aRequest,
            $aRes
        );

        return
            (bool)$aResponse &&
            'Success' === $aResponse['ACK'] &&
            'Success' === $aResponse['PAYMENTINFO_0_ACK'];
    }

    /**
     * Sends request.
     *
     * @param  string $url       Request URL
     * @param  array  $aRequest  Request data
     * @param  array  $aRes      Error data
     * @return bool|array
     */
    protected function sendRequest($url, array $aRequest, array &$aRes){
        $oHTTPRequest = new AMI_HTTPRequest();

        $response = $oHTTPRequest->send(
            $url,
            $aRequest,
            AMI_HTTPRequest::METHOD_POST
        );

        if($this->logAll){
            trigger_error(
                "PayPal Express Checkout: request to " . $url . "\nData:\n" .
                var_export($aRequest, TRUE)
            );
        }

        if('' != $response){
            $aResponse = array();
            parse_str($response, $aResponse);

            if($this->logAll){
                trigger_error(
                    "PayPal Express Checkout: response from " . $url . "\nData:\n" .
                    var_export($aResponse, TRUE)
                );
            }

            if(sizeof($aResponse)){
                if('Success' !== $aResponse['ACK']){
                    $this->reportError(
                        "Request to " . $url . " failed:\nrequest data:\n" . var_export($aRequest, TRUE) .
                        "\nresponse data:\n" . var_export($aResponse, TRUE)
                    );
                    $aRes['error'] = $aResponse['ACK'];
                    $aRes['errno'] = self::ERROR_RESPONSE_FAILED;

                    return FALSE;
                }

                return $aResponse;
            }else{
                $message =
                    "Request to " . $url . " failed:\nrequest data:\n" . var_export($aRequest, TRUE) .
                    "\ncannot parse response:\n" . var_export($response, TRUE);
                $this->reportError($message);
                $aRes['error'] = $message;
                $aRes['errno'] = self::ERROR_RESPONSE_FAILED;

                return FALSE;
            }
        }else{
            if($this->logAll){
                trigger_error(
                    "PayPal Express Checkout: invalid response from " . $url . "\nData:\n" .
                    var_export($response, TRUE)
                );
            }
        }

        $this->reportError(
            "\nrequest to " . $aData['url1'] . ":\n" . var_export($aRequest, TRUE) .
            "\ncURL errpr:" . $oHTTPRequest->getError()
        );
        $aRes['error'] = $oHTTPRequest->getError();
        $aRes['errno'] = self::ERROR_REQUEST_FAILED;

        return FALSE;
    }


    /**
     * Writes error to log.
     *
     * @param  string $message  Message
     * @return void
     */
    protected function reportError($message){
        if("\n" !== $message['0']){
            $message = ' ' . $message;
        }
        trigger_error(
            "PayPal Express Checkout:" . $message,
            E_USER_WARNING
        );
    }
}
