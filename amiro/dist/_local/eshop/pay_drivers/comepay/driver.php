<?php
/**
 * @copyright CMSApp. All rights reserved.
 */

require_once __DIR__ . '/CmsappComepayPaymentSystem.php';

/**
 * Comepay wallet pay driver.
 * 
 * @package Driver_PaymentSystem
 */
class Comepay_PaymentSystemDriver extends AMI_PaymentSystemDriver{

    /**
     * Get checkout button HTML form
     *
     * @param array $aRes Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @param array $aData The data list for button generation
     * @param bool $bAutoRedirect If form autosubmit required (directly from checkout page)
     * @return bool true if form is generated, false otherwise
     */
    public function getPayButton(&$aRes, $aData, $bAutoRedirect = false){
        $aRes['errno'] = 0;
        $aRes['error'] = 'Success';

        $aData['hiddens'] = $this->getScopeAsFormHiddenFields($aData);

        // Set your fields of $aData here
        return parent::getPayButton($aRes, $aData, $bAutoRedirect);
    }
    
    /**
     * Get the form that will be autosubmitted to payment system. This step is required for some shoping cart actions.
     *
     * @param array $aData The data list for button generation
     * @param array $aRes Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @return bool true if form is generated, false otherwise
     */
    public function getPayButtonParams($aData, &$aRes){
        $oDrv = new CmsappComepayPaymentSystem();

        $aData['url'] = $oDrv->getServerAddr() . 'Order/external/main.action';
        $aData += array(
            'shop'          => $aData['comepay_id'],
            'transaction'   => $aData['order'],
            'successUrl'    => $aData['return'],
            'failUrl'       => $aData['cancel'],
        );
        return parent::getPayButtonParams($aData, $aRes);
    }

    /**
     * Verify the order from user back link. In success case 'accepted' status will be setup for order.
     *
     * @param array $aGet $_GET data
     * @param array $aPost $_POST data
     * @param array $aRes reserved array reference
     * @param array $aCheckData Data that provided in driver configuration
     * @param array $aOrderData order data that contains such fields as id, total, order_date, status
     * @return bool true if order is correct and false otherwise
     * @see AMI_PaymentSystemDriver::payProcess(...)
     */
    public function payProcess($aGet, $aPost, &$aRes, $aCheckData, $aOrderData){
        // See implplementation of this method in parent class
        
        return parent::payProcess($aGet, $aPost, $aRes, $aCheckData, $aOrderData);
    }

    /**
     * Verify the order by payment system background responce. In success case 'confirmed' status will be setup for order.
     *
     * @param array $aGet $_GET data
     * @param array $aPost $_POST data
     * @param array $aRes reserved array reference
     * @param array $aCheckData Data that provided in driver configuration
     * @param array $aOrderData order data that contains such fields as id, total, order_date, status
     * @return int -1 - ignore post, 0 - reject(cancel) order, 1 - confirm order
     * @see AMI_PaymentSystemDriver::payCallback(...)
     */
    public function payCallback($aGet, $aPost, &$aRes, $aCheckData, $aOrderData){
        if(!@is_array($aGet)){
            $aGet = array();
        }
        if(!@is_array($aPost)){
            $aPost = array();
        }

        $oDrv = new CmsappComepayPaymentSystem();

        $orderId = isset($aPost['bill_id']) ? $aPost['bill_id'] : 0;
        $amount = isset($aPost['amount']) ? $aPost['amount'] : 0;
        $error = isset($aPost['error']) ? $aPost['error'] : 0;
        $cStatus = isset($aPost['status']) ? $aPost['status'] : 0;
        $result = 0;
        $code = 0;
        $status = 'rejected';
        if(!$orderId || !$amount){
            $code = 1;
        }else{
            // Check Authorization
            if($oDrv->checkCallbackAuth()){
                $oOrder = AMI::getResourceModel('eshop_order/table')->find($orderId);
                if($oOrder->total == $amount && $cStatus=='paid'){
                    $status = 'confirmed';
                    $result = 1;
                }else{
                    $code = 3;
                }
            }else{
                $code = 2;
            }
        }
        AMI_Registry::set('cmsapp/pay_drv/comepay/code', $code);
        AMI_Registry::set('cmsapp/pay_drv/comepay/order_id', $orderId);
        $this->sendXMLResponse($oDrv, $aPost, $aResponse, $status);
        return $result;
    }

    /**
     * Return real system order id from data that provided by payment system.
     *
     * @param array $aGet $_GET data
     * @param array $aPost $_POST data
     * @param array $aRes reserved array reference
     * @param array $aAdditionalParams reserved array
     * @return int order Id
     * @see AMI_PaymentSystemDriver::getProcessOrder(...)
     */
    public function getProcessOrder($aGet, $aPost, &$aRes, $aAdditionalParams){
        return isset($aPost['bill_id']) ? $aPost['bill_id'] : 0;
    }

    /**
     * 
     * @global type $conn
     * @global type $cms
     * @global type $oEshop
     * @global type $billServices
     * @param array $aData
     * @param array $aResponse
     * @param type $status
     */
    protected function sendXMLResponse($oDrv, array $aData, array $aResponse, $status = ''){
        global $conn, $CONNECT_OPTIONS;
        $CONNECT_OPTIONS['disable_cache_warn'] = TRUE;
        $code = AMI_Registry::get('cmsapp/pay_drv/comepay/code', -1);
        $orderId = AMI_Registry::get('cmsapp/pay_drv/comepay/order_id', 0);
        $response = $oDrv->getCallbackResponse($code);
        if(in_array($status, array('confirmed', 'rejected'))){
            global $cms, $oEshop, $oOrder;
            $oEshop->initByOwnerName('eshop');
            $oOrder->updateStatus($cms, $orderId, 'auto', $status);
            if('confirmed' === $status){
                $this->onPaymentConfirmed($orderId);
            }
        }
        echo $response;
        $conn->Out();
        die;
    }

    /**
     * 
     * @return string
     */
    public static function getOrderIdVarName(){
        return 'bill_id';
    }
}
