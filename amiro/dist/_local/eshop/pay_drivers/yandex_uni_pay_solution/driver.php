<?php
/**
 * @copyright Amiro.CMS. All rights reserved.
 * @category  AMI
 * @package   Config_AmiFake_YandexUniPaySolution
 * @version   $Id: driver.php 61249 2013-08-05 11:20:24Z Leontiev Anton $
 */

/**
 * Yandex.Money Universal Payment Solution
 *
 * @package Config_AmiFake_YandexUniPaySolution
 */
class YandexUniPaySolution_PaymentSystemDriver extends AMI_PaymentSystemDriver{
    /**
     * Flag specifying to write debug to log file
     *
     * @var bool
     */
    protected $debug = FALSE;

    /**
     * Return var name for system order id from data that provided by payment system.
     *
     * @return string Var name
     */
    public static function getOrderIdVarName(){
        $result = '';

        $driverId = 'yandex_uni_pay_solution';
        $oDB = AMI::getSingleton('db');
        $settings =
            $oDB->fetchValue(
                DB_Query::getSnippet(
                    "SELECT `settings` " .
                    "FROM `cms_pay_drivers` " .
                    "WHERE `name` = %s AND `is_installed` = 1"
                )
                ->q($driverId)
            );
        if($settings){
            $aSettings = @unserialize($settings);
            if(is_array($aSettings) && isset($aSettings['drv_service_payment_method'])){
                $result =
                    'natural' === $aSettings['drv_service_payment_method']
                        ? 'label'
                        : 'orderNumber';
            }
        }

        return $result;
    }

    /**
     * Get checkout button HTML form.
     *
     * @param  array &$aRes          Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @param  array $aData          The data list for button generation
     * @param  bool  $bAutoRedirect  If form autosubmit required (directly from checkout page)
     * @return bool TRUE if form is generated, FALSE otherwise
     */
    public function getPayButton(array &$aRes, array $aData, $bAutoRedirect = false){
        $vRes['errno'] = 0;
        $vRes['error'] = 'Success';

        $isNatural = 'natural' === $aData['drv_service_payment_method'];

        // validate driver settings {

        if(empty($aData['drv_service_payment_method'])){
            $vRes['errno'] = 1;
            $vRes['error'] = "Missing 'drv_service_payment_method' field in driver settings";
        }else{
            $aObligatoryFields =
                $isNatural
                    ? array('drv_service_payment_method',
                        'drv_account',
                        'drv_secret_key'
                    )
                    : array(
                        'drv_notification_email',
                        'drv_shop_password',
                        'drv_shop_id',
                        'drv_shop_scid'
                    );
            foreach($aObligatoryFields as $field){
                if(empty($aData[$field])){
                    $vRes['errno'] = 1;
                    $vRes['error'] = "Missing '" . $field . "' field in driver settings";
                }
            }
        }
        if($vRes['errno']){
            trigger_error('PAY DRV ' . $this->driverName . ': ' . $vRes['error'], E_USER_WARNING);
            $aData['disabled'] = TRUE;
            $aData['misconfigured'] = TRUE;
        }

        // } validate driver settings

        $aExclusions =
            $isNatural
                ? array('drv_service_payment_method', 'drv_account')
                : array('drv_service_payment_method', 'drv_shop_id', 'drv_shop_scid', 'drv_shop_shoparticleid', 'drv_payment_method');
        $aIndeces = array_keys($aData);
        foreach($aIndeces as $index){
            if(
                'drv_' === mb_substr($aData[$index], 0, 4) &&
                !in_array($aData[$index], $aExclusions)
            ){
                unset($aData[$index]);
            }
        }

        $aData['hiddens'] = $this->getScopeAsFormHiddenFields($aData);

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
    public function getPayButtonParams(array $aData, array &$aRes){
        $aRes['errno'] = 0;
        $aRes['error'] = 'Success';

        $oSession = AMI::getSingleton('env/session');
        $oSession->yandex_ups = $aData['order_id'];
        $oSession->store();

        $isNatural = 'natural' === $aData['drv_service_payment_method'];

        $currency = $aData['currency'];
        if(!in_array($currency, array('RUR', 'RUB'))){
            $aData['amount'] =
                number_format(
                    $GLOBALS['oEshop']
                        ->convertCurrency(
                            $aData['amount'],
                            $currency,
                            'RUR'
                        ),
                    2,
                    '.',
                    ''
                );
        }

        $isNatural
            ? $this->getPayButtonParamsNatural($aData, $aRes)
            : $this->getPayButtonParamsJuridical($aData, $aRes);

        return parent::getPayButtonParams($aData, $aRes);
    }

    protected function getPayButtonParamsNatural(array &$aData, array &$aRes){
        $aMapping = array(
            'receiver'    => 'drv_account',
            'formcomment' => 'item_name',
            'short_dest'  => 'item_name',
            'targets'     => 'item_name',
            'label'       => 'order_id',
            'comment'     => 'comments',
            'referrer'    => 'return'
        );
        foreach($aMapping as $to => $from){
            $aData[$to] = $aData[$from];
        }
        $aData['url'] = 'https://money.yandex.ru/quickpay/confirm.xml';
    }

    protected function getPayButtonParamsJuridical(array &$aData, array &$aRes){
        $aMethods = explode(',', $aData['drv_payment_method']);
        foreach($aMethods as $method){
            $aData['drv_payment_method_' . $method] = TRUE;
        }

        $aData['customer'] = AMI::getSingleton('env/session')->getUserData()->login;

        $aData['url'] = 'https://money.yandex.ru/eshop.xml';
    }

    /**
     * Verify the order by payment system background responce. In success case 'confirmed' status will be setup for order.
     *
     * @param  array $aGet        $_GET data
     * @param  array $aPost       $_POST data
     * @param  array &$aRes       Reserved array reference
     * @param  array $aCheckData  Data that provided in driver configuration
     * @param  array $aOrderData  Order data that contains such fields as id, total, order_date, status
     * @return int -1 - ignore post, 0 - reject(cancel) order, 1 - confirm order
     */
    public function payCallback(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData){
        return
            'natural' === $aCheckData['drv_service_payment_method']
                ? $this->payCallbackNatural($aGet, $aPost, $aRes, $aCheckData, $aOrderData)
                : $this->payCallbackJuridical($aGet, $aPost, $aRes, $aCheckData, $aOrderData);
    }

    /**
     * @see self::payCallback()
     */
    protected function payCallbackNatural($aGet, $aPost, &$aRes, $aCheckData, $aOrderData){
        $status = -1;
        $orderId = $aPost['label']; // CMS order id

        // Check sign
        // notification_type&operation_id&amount&currency&
        // datetime&sender&codepro&notification_secret&label
        $aSign = array(
            $aPost['notification_type'],
            $aPost['operation_id'],
            $aPost['amount'],
            $aPost['currency'],
            $aPost['datetime'],
            $aPost['sender'],
            $aPost['codepro'],
            $aCheckData['drv_secret_key'],
            $orderId
        );
        $sign = sha1(implode('&', $aSign));
        if($sign !== $aPost['sha1_hash']){
            trigger_error('Invalid hash', E_USER_WARNING);
        }else{
            // Ok
            $status = 1;
            // $this->cleanupCart($orderId);
        }

        return $status;
    }

    /**
     * @see self::payCallback()
     */
    protected function payCallbackJuridical($aGet, $aPost, &$aRes, $aCheckData, $aOrderData){
        $status = '';
        $aResponse = array();
        $md5 = mb_strtoupper(
            md5(
                $aPost['action'] . ';' .
                $aPost['orderSumAmount'] . ';' .
                $aPost['orderSumCurrencyPaycash'] . ';' .
                $aPost['orderSumBankPaycash'] . ';' .
                $aPost['shopId'] . ';' .
                $aPost['invoiceId'] . ';' .
                $aPost['customerNumber'] . ';' .
                $aCheckData['drv_shop_password']
            )
        );
        if($aPost['md5'] !== $md5){
            $aResponse = array(
                'code'    => 1, // Invalid md5 hash
                'message' => 'Invalid sign'
            );
        }else{
            switch($aPost['action']){
                case 'checkOrder':
                    ### customerNumber
                    if(
                        $aPost['shopId'] !== $aCheckData['drv_shop_id'] ||
                        $aPost['shopArticleId'] != $aCheckData['drv_shop_shoparticleid']
                    ){
                        $aResponse = array(
                            'code'    => 100, // Invalid data
                            'message' => 'Invalid shopId or shopArticleId'
                        );
                    }
                    break; // case 'checkOrder'

                case 'paymentAviso':
                    $status = 'confirmed';
                    break; // case 'paymentAviso'
            }
        }
        $this->sendXMLResponse($aPost, $aResponse, $status);
    }

    protected function sendXMLResponse(array $aData, array $aResponse, $status = ''){
        global $conn, $CONNECT_OPTIONS;

        $CONNECT_OPTIONS['disable_cache_warn'] = TRUE;
        $now = time();
        $oNow = new DateTime(gmdate('Y-m-d H:i:s', $now));
        $offset = (int)($oNow->getOffset() / 60);
        $minutes = (int)($offset % 60);
        $hours = (int)($offset / 60);
        $aResponse['performedDatetime'] =
            gmdate('Y-m-d', $now) . 'T' . gmdate('H:i:s', $now) . '+' . sprintf('%02d', $hours) . ':' . sprintf('%02d', $minutes);
        $aResponse['shopId'] = $aData['shopId'];
        $aResponse['invoiceId'] = $aData['invoiceId'];
        $aResponse += array('code' => 0);

        $response =
            '<?xml version="1.0" encoding="UTF-8"?>' .
            '<' . $aData['action'] . 'Response ';
        foreach($aResponse as $arg => $value){
            $response .= $arg . '="' . $value . '" ';
        }
        $response .= ' />';
        if(in_array($status, array('confirmed', 'rejected'))){
            global $cms, $oEshop, $oOrder;

            $oEshop->initByOwnerName('eshop');
            $oOrder->updateStatus($cms, $aData['orderNumber'], 'auto', $status);
            if('confirmed' === $status){
                $this->onPaymentConfirmed($aData['orderNumber']);
                // $this->cleanupCart($aData['orderNumber']);
            }
        }

        echo $response;

        $conn->Out();
        die;
    }

    /**
     * Cleanups user cart by passed order id.
     *
     * @param  int $orderId  Order id
     * @return void
     */
    protected function cleanupCart($orderId){
        // Clean up user cart
        global $cms, $oSession;

        $sessionCookieName = $oSession->CookieName;
        $oOrder =
            AMI::getResourceModel('eshop_order/table')
            ->find($orderId, array('id', 'id_user'));
        if($oOrder->id_user){
            $oSessions =
                AMI::getResourceModel('env/session/table')
                ->getList()
                ->addColumns(array('id', 'ip', 'data'))
                ->addWhereDef("AND `id_member` = " . $oOrder->id_user)
                ->load();
            foreach($oSessions as $oItem){
                $this->log($oItem->id . ' session found');
                $aData = unserialize($oItem->data);
                $noMarker = TRUE;
                foreach(array_keys($aData) as $key){
                    if(0 === mb_strpos($key, 'yandex_ups')){
                        if($orderId != unserialize($aData[$key])){
                            $this->log('Invalid order id (' . unserialize($aData[$key]) . ' instead of ' . $orderId . ')');
                            continue 2;
                        }
                        $noMarker = FALSE;
                        AMI::setOption('eshop_cart', 'store_cart_after_logout', '');
                        // AMI::setOption('session', 'force_store', TRUE);
                        $cms->VarsCookie[$sessionCookieName] = $oItem->id;
                        $ip = $_SERVER['REMOTE_ADDR'];
                        $_SERVER['REMOTE_ADDR'] = $oItem->ip;
                        $oSession = new CMS_Session(
                            $cms,
                            AMI::getOption('core', 'allow_multi_lang')
                                ? AMI_Registry::get('lang_data')
                                : ''
                        );
                        $oSession->Start();
                        AMI::getSingleton('eshop/cart')->clear();
                        $oSession->UnsetVar('yandex_ups');
                        $oSession->Store();
                        $_SERVER['REMOTE_ADDR'] = $ip;
                        $this->log('Cart cleaned up');
                        break;
                    }
                }
                if($noMarker){
                    $this->log('Missing marker, skipped');
                }
            }
        }
    }

    /**
     * Logs message.
     *
     * @param  string $message  Message
     * @param  int    $level    Error level
     * @return void
     */
    protected function log($message, $level = E_USER_NOTICE){
        if($this->debug){
            trigger_error('YM_UPS: ' . $message, $level);
        }
    }
}
