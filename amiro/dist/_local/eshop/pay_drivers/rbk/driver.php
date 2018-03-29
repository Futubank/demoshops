<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Driver_PaymentSystem 
 * @version    $Id$ 
 * @since      5.10.0 
 * @size       8835 JHyFge9qNWtCovBkEbHYQNPmewly3FCW9d1DSnevsw0b5h673UpmnrwS+fa9iKROR8f5oUm+0+SkXZIaHKQfmycT6/RHDsRE1J0SKmXJY3PmaI1m8t75xef4Fo9aHqjutbz7k0Be7nVI50gckPnWEhyiGpi77BMrI429c1Z/UCc=
 */
?><?php


/**
 * RBK MONEY pay driver
 *
 * @package Driver_PaymentSystem
 */
class Rbk_PaymentSystemDriver extends AMI_PaymentSystemDriver{
    protected $driverName = 'rbk';
    
    /**
     * Get checkout button HTML form.
     *
     * @param  array  &$aRes          Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @param  array  $aData          The data list for button generation
     * @param  bool   $bAutoRedirect  If form autosubmit required (directly from checkout page)
     * @return bool  TRUE if form is generated, FALSE otherwise
     */
    public function getPayButton(array &$aRes, array $aData, $bAutoRedirect = false){
        $res = TRUE;
        $aRes['error'] = 'Success';
        $aRes['errno'] = 0;

        // Check the required fields
        if(empty($aData["process_url"])){
            $aRes["errno"] = 1;
            $aRes["error"] = "process_url is missed";
            $res = false;
        }elseif(empty($aData["return"])){
            $aRes["errno"] = 2;
            $aRes["error"] = "return url is missed";
            $res = false;
        }elseif(empty($aData["eshop_id"])){
            $aRes["errno"] = 3;
            $aRes["error"] = "eshop id is missed";
            $res = false;
        }elseif(empty($aData["amount"])){
            $aRes["errno"] = 4;
            $aRes["error"] = "amount is missed";
            $res = false;
        }elseif(empty($aData["description"])){
            $aRes["errno"] = 5;
            $aRes["error"] = "description is missed";
            $res = false;
        }elseif(empty($aData["button_name"]) && empty($aData["button"])){
            $aRes["errno"] = 6;
            $aRes["error"] = "button is missed";
            $res = false;
        }

        // Format amount and fields
        $this->formatAmount($aData["amount"]);

        foreach(array('return', 'description', 'button_name') as $field){
            $aData[$field] = htmlspecialchars($aData[$field]);
        }

        $aHiddenData = $aData;
        foreach(array('process_url', 'return', 'callback', 'cancel', 'eshop_id', 'amount', 'description', 'button_name', 'button') as $var){
            unset($aHiddenData[$var]);
        }
        $aData['hiddens'] = $this->getScopeAsFormHiddenFields($aHiddenData);

        $aData['button'] = trim($aData['button']);
        if(!empty($aData['button'])){
            $aData['_button_html'] = 1;
        }
        if(!$res) {
            $aData['disabled'] = 'disabled';
        }

        return parent::getPayButton($aRes, $aData, $bAutoRedirect);
    }
    
    /**
     * Get the form that will be autosubmitted to payment system. This step is required for some shooping cart actions.
     *
     * @param  array $aData  The data list for button generation
     * @param  array &$aRes  Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @return bool  TRUE if form is generated, FALSE otherwise
     */
    public function getPayButtonParams(array $aData, array &$aRes){
        $aRes['error'] = 'Success';
        $aRes['errno'] = 0;

        // Check the required fields
        if(empty($aData['return'])){
            $aRes['errno'] = 1;
            $aRes['error'] = 'return url is missed';
            return FALSE;
        }else if(empty($aData['amount'])){
            $aRes['errno'] = 2;
            $aRes['error'] = 'amount is missed';
            return FALSE;
        }else if(empty($aData['eshop_id'])){
            $aRes['errno'] = 3;
            $aRes['error'] = 'eshop_id is missed';
            return FALSE;
        }else if(empty($aData['description'])){
            $aRes['errno'] = 4;
            $aRes['error'] = 'description is missed';
            return FALSE;
        }

        $this->formatAmount($aData['amount']);
        foreach(array('return_url', 'cancel_url', 'description', 'button_name') as $field){
            if(isset($aData[$field])){
                $aData[$field] = htmlspecialchars($aData[$field]);
            }
        }

        return parent::getPayButtonParams($aData, $aRes);
    }
    
    /**
     * Verify the order from user back link. In success case 'accepted' status will be setup for order.
     *
     * @param  array $aGet        HTTP GET variables
     * @param  array $aPost       HTTP POST variables
     * @param  array &$aRes       Reserved array reference
     * @param  array $aCheckData  Data that provided in driver configuration
     * @param  array $aOrderData  Order data that contains such fields as id, total, order_date, status
     * @return bool  TRUE if order is correct, FALSE otherwise
     */
    public function payProcess(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData){
        $status = 'fail';
        if(!empty($cGet['status'])){
            $status = $cGet['status'];
        }
        if(!empty($cPost['status'])){
            $status = $cPost['status'];
        }

        return 'ok' == $status;
    }
    
    /**
     * Verify the order by payment system background responce. In success case 'confirmed' status will be setup for order.
     *
     * @param  array $aGet        HTTP GET variables
     * @param  array $aPost       HTTP POST variables
     * @param  array &$aRes       Reserved array reference
     * @param  array $aCheckData  Data that provided in driver configuration
     * @param  array $aOrderData  Order data that contains such fields as id, total, order_date, status
     * @return int  -1 - ignore post, 0 - reject(cancel) order, 1 - confirm order
     */
    public function payCallback(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData){
        $status = $aPost['rbk_action'] != 'sys' ? 'fail' : 'inner';
        // Merge Get and Post
        if(!@is_array($aGet)){
            $aGet = array();
        }
        if(!@is_array($aPost)){
            $aPost = array();
        }
        $aParams = array_merge($aGet, $aPost);
        
        // Check the sign presence
        /*
        if(isset($aParams['hash'])){
            $sign = mb_strtolower(md5(
                $aParams['eshopId'] . '::'.
                $aParams['orderId'] . '::'.
                $aParams['serviceName'] . '::'.
                $aParams['eshopAccount'] . '::'.
                $aParams['recipientAmount'] . '::'.
                $aParams['recipientCurrency'] . '::'.
                $aParams['paymentStatus'] . '::' .
                $aParams['userName'] . '::' .
                $aParams['userEmail'] . '::' .
                $aParams['paymentData'] . '::' .
                $aCheckData['secret_key']
            ));
            if(!strcasecmp($aParams['rbk_hash'], $sign)){
                $status = 'ok';
            }else{
                $aRes['error'] = 'Hashes do not match';
            }
        }else{
            $aRes['error'] = 'Hash not found';
        }
        */
        
        if('inner' == $status){
            // skip
            $res = -1;
        }elseif('ok' == $status){
            // ok
            $res = 1;
        }else{
            // fail
            $res = 0;
        }

        return $res;
    }
    
    /**
     * Return real system order id from data that provided by payment system.
     *
     * @param  array $aGet               HTTP GET variables
     * @param  array $aPost              HTTP POST variables
     * @param  array &$aRes              Reserved array reference
     * @param  array $aAdditionalParams  Reserved array
     * @return int  Order Id
     */
    public function getProcessOrder(array $aGet, array $aPost, array &$aRes, array $aAdditionalParams){
        $orderId = 0;

        // Merge Get and Post
        if(!empty($aGet['order_id'])){
            $orderId = $aGet['order_id'];
        }
        if(!empty($aPost['order_id'])){
            $orderId = $aPost['order_id'];
        }

        return (int)$orderId;
    }
    
    /**
     * Formats amount.
     * 
     * @param  double $amount  Amount
     * @return double
     */
    protected function formatAmount(&$amount){
        $amount = number_format($amount, 2, '.', '');
    }
}
