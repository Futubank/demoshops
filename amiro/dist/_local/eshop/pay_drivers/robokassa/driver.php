<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Driver_PaymentSystem 
 * @version    $Id$ 
 * @since      5.8.6 
 * @size       10107 A0soUvEcAjhjyZ9HidG7kPmnI+3Rksn6pJgXMhYYqgVDnuW4OGhIJoK1LbaEzbzTd1Bc83Pi0tBuz01wrK1NGXsUimWwWSI1FDjEW1A48e75vaMs+RY9UvDVuf1QKoMohvKJ2c+waAB1bcfj5RyDF5Lk9gJdWMgQdBsOBV3nRSk=
 */
?><?php


/**
 * ROBOKASSA checkout pay driver
 *
 * @package Driver_PaymentSystem
 */
class Robokassa_PaymentSystemDriver extends AMI_PaymentSystemDriver{ ###BILL_driver_robokassa
    protected $driverName = 'robokassa';
    
    /**
     * Get checkout button HTML form.
     *
     * @param  array  &$aRes          Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @param  array  $aData          The data list for button generation
     * @param  bool   $bAutoRedirect  If form autosubmit required (directly from checkout page)
     * @return bool  TRUE if form is generated, FALSE otherwise
     */
    public function getPayButton(array &$aRes, array $aData, $bAutoRedirect = false){
        $bRes = true;
        $aTemplateData = array(); // "return" => $this->classFunctionality->parameters["DEFAULT_RETURN_ADDRESS"]);
        if(is_array($aData)){
            $aTemplateData = array_merge($aTemplateData, $aData);
        }
        $aRes['error'] = 'Success';
        $aRes['errno'] = 0;

        // Check the required fields
        if(empty($aTemplateData['process_url'])){
            $aRes['errno'] = 1;
            $aRes['error'] = 'process_url is missed';
            $bRes = false;
        }elseif(empty($aTemplateData['merchant_id'])){
            $aRes['errno'] = 2;
            $aRes['error'] = 'merchant purse is missed';
            $bRes = false;
        }elseif(empty($aTemplateData['amount'])){
            $aRes['errno'] = 3;
            $aRes['error'] = 'amount is missed';
            $bRes = false;
        }elseif(empty($aTemplateData['item_number'])){
            $aRes['errno'] = 4;
            $aRes['error'] = 'item_number is missed';
            $bRes = false;
        }elseif(empty($aTemplateData['description'])){
            $aRes['errno'] = 5;
            $aRes['error'] = 'description is missed';
            $bRes = false;
        }elseif(empty($aTemplateData['button_name']) && empty($aTemplateData['button'])){
            $aRes['errno'] = 6;
            $aRes['error'] = 'button is missed';
            $bRes = false;
        }

        foreach(array('return', 'description', 'button_name') as $fldName) {
            $data[$fldName] = htmlspecialchars($data[$fldName]);
        }

        $aHiddenData = $aTemplateData;
        foreach(
            array(
                'process_url', 'return', 'callback', 'cancel', 'merchant_id', 'amount',
                'description', 'order', 'button_name', 'button', 'password1', 'password2'
            ) as $var
        ){
            unset($aHiddenData[$var]);
        }
        $aTemplateData['hiddens'] = $this->getScopeAsFormHiddenFields($aHiddenData);
        
        $aTemplateData['button'] = trim($aTemplateData['button']);
        if(!empty($aTemplateData['button'])){
            $aTemplateData['_button_html'] = 1;
        }

        if(!$bRes){
            $aTemplateData['disabled'] = 'disabled';
        }

        // Draw the pay button using $aTemplateData data. Return $aRes['form'] as result.
        return parent::getPayButton($aRes, $aTemplateData, $bAutoRedirect);
    }
    
    /**
     * Get the form that will be autosubmitted to payment system. This step is required for some shooping cart actions.
     *
     * @param  array $aData  The data list for button generation
     * @param  array &$aRes  Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @return bool  TRUE if form is generated, FALSE otherwise
     */
    public function getPayButtonParams(array $aData, array &$aRes){
        $aTemplateData = $aData;
        $aRes["error"] = "Success";
        $aRes["errno"] = 0;

        if(empty($aTemplateData["merchant_id"])){
            $aRes["errno"] = 1;
            $aRes["error"] = "merchant purse is missed";
            return false;
        }else if(empty($aTemplateData["amount"])){
            $aRes["errno"] = 3;
            $aRes["error"] = "amount is missed";
            return false;
        }

        // Format amount and fields
        foreach(array('description') as $fldName){
            if(isset($aTemplateData[$fldName])){
                $aTemplateData[$fldName] = htmlspecialchars($aTemplateData[$fldName]);
            }
        }

        $aTemplateData['signatureValue'] = md5(
            $aData['merchant_id'] . ':' .
            $aData['amount']  . ':' .
            $aData['order_id']  . ':' .
            $aData['password1']  . ':shpitem_number=' . $aData['order_id']
        );

        return parent::getPayButtonParams($aTemplateData, $aRes);
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
        $this->clearCartOnPayProcess = TRUE;

        $aRes["error"] = "";
        $bAccepted = false;
        $aParams = $aPost + $aGet;

        if(!empty($aParams['status']) && $aParams['status'] == 'fail'){
            return false;
        }

        if(isset($aParams['SignatureValue'])){
            $signature = md5($aParams['OutSum'] . ':' . $aParams['InvId'] . ':' . $aCheckData['password1'] . ':shpitem_number=' . $aParams['InvId']);
            if(strcasecmp($aParams['SignatureValue'], $signature) == 0){
                $bAccepted = true;
            }else{
                $aRes['error'] = 'Hashes do not match';
            }
        }else{
            $aRes['error'] = 'Hash not found';
        }
        /*
        if($aRes['error'] != ''){
            $aRes['method payProcess'] = array(
                'aOrderData' => $aOrderData,
                'aCheckData' => $aCheckData,
                'aParams'    => $aParams
            );
        }
        */
        return $bAccepted;
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
        $aRes["error"] = "";
        $returnVal = 0;
        $aParams = $aPost + $aGet;
        $customData = unserialize($aOrderData[0]);
        $feePercent = floatval($customData['fee_percent']);
        if(floatval(($aOrderData['order_amount'] + $aOrderData['shipping']) * (1 + $feePercent/100)) != floatval($aParams['OutSum'])) {
            $aRes['error'] = 'Wrong order amount';
        }else if(isset($aParams['SignatureValue'])){
            $signature = md5($aParams['OutSum'] . ':' . $aParams['InvId'] . ':' . $aCheckData['password2'] . ':shpitem_number=' . $aParams['InvId']);
            if(strcasecmp($aParams['SignatureValue'], $signature) == 0){
                $returnVal = 1;
            }else{
                $aRes['error'] = 'Hashes do not match';
            }
        }else{
            $aRes['error'] = 'Hash not found';
        }
        /*
        if($aRes['error'] != ''){
            $aRes['method payCallback'] = array(
                'aOrderData' => $aOrderData,
                'aCheckData' => $aCheckData,
                'aParams'    => $aParams
            );
        }
        */
        return $returnVal;
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

        if(!empty($aGet["InvId"])){
            $orderId = $aGet["InvId"];
        }
        if(!empty($aPost["InvId"])){
            $orderId = $aPost["InvId"];
        }

        return intval($orderId);
    }
    
    /**
     * Do required operations after the payment is confirmed with payment system call.
     *
     * @param  int $orderId  Id of order in the system will be passed to this function
     * @return void
     */
    public function onPaymentConfirmed($orderId){
        while(ob_get_level()){
            $aStatus = ob_get_status();
            if('ob_gzhandler' === $aStatus['name']){
                break;
            }
            ob_end_clean();
        }
        header('Status: 200 OK');
        header('HTTP/1.0 200 OK');
        echo 'OK', $orderId;
        exit;
    }
}
