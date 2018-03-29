<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       8245 OVw8G6LWtYbyDyQdh476wvA3c4gzRPlmqiaDfpOb/+bYvKV3pQwHP9PZznfAv0no5skWbacVPm/Be183E2OVq//Xd6F4tnDp3l1ogexrt/WVJebVzd4Ul7Ju9Otk6CoAWCW3Flmj3TISUUQsBykJM9AHma5/jQEzRGgO/QD90cg=
 */
?><?php


class Payanyway_PaymentSystemDriver extends AMI_PaymentSystemDriver{

    function format_amount(&$amount)
    {
        $amount = number_format($amount, 2, ".", "");
    }
    
    /**
     * Get checkout button HTML form
     *
     * @param array $aRes Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @param array $aData The data list for button generation
     * @param bool $bAutoRedirect If form autosubmit required (directly from checkout page)
     * @return bool true if form is generated, false otherwise
     */
    public function getPayButton(array &$aRes, array $aData, $bAutoRedirect = false){
        $res =true;
        $aRes["error"] = "Success";
        $aRes["errno"] = 0;
        $data = $aData;
        if(empty($data["process_url"])){
            $aRes["errno"] = 1;
            $aRes["error"] = "process_url is missed";
            $res =false;
        }
        else if(empty($data["mnt_id"])){
            $aRes["errno"] = 2;
            $aRes["error"] = "mnt_id is missed";
            $res =false;
        }
        else if(empty($data["payment_url"])){
            $aRes["errno"] = 3;
            $aRes["error"] = "payment_url is missed";
            $res =false;
        }
        else if(empty($data["amount"])){
            $aRes["errno"] = 4;
            $aRes["error"] = "amount is missed";
            $res =false;
        }
        else if(empty($data["button_name"]) && empty($data["button"])){
            $aRes["errno"] = 5;
            $aRes["error"] = "button is missed";
            $res =false;
        }

        $this->format_amount($data["amount"]);
        foreach(Array("return", "cancel", "description", "button_name", "payment_url") as $fldName){
            $data[$fldName] = htmlspecialchars($data[$fldName]);
        }
        if(isset($data["process_url"]))
            unset($data["process_url"]);
        if(isset($data["return"]))
            unset($data["return"]);
        if(isset($data["callback"]))
            unset($data["callback"]);
        if(isset($data["cancel"]))
            unset($data["cancel"]);
        if(isset($data["amount"]))
            unset($data["amount"]);
        if(isset($data["description"]))
            unset($data["description"]);
        if(isset($data["button_name"]))
            unset($data["button_name"]);
        if(isset($data["button"]))
            unset($data["button"]);
        foreach($data as $key => $value){
            $aData["hiddens"] .= "<input type=\"hidden\" name=\"$key\" value=\"$value\">\r\n";
        }
        $aData["button"] = trim($aData["button"]);
        if(!empty($aData["button"]))
        {
            $aData["_button_html"] =1;
        }
        if(!$res)
        {
            $aData["disabled"] ="disabled";
        }

        return parent::getPayButton($aRes, $aData, $bAutoRedirect);
    }
    
    /**
     * Get the form that will be autosubmitted to payment system. This step is required for some shooping cart actions.
     *
     * @param array $aData The data list for button generation
     * @param array $aRes Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @return bool true if form is generated, false otherwise
     */
    public function getPayButtonParams(array $aData, array &$aRes){
        // Check parameters and set your fields here
        $data =$aData;
        $aRes["error"] ="Success";
        $aRes["errno"] =0;
        if(empty($data["mnt_id"])){
            $aRes["errno"] = 2;
            $aRes["error"] = "mnt_id is missed";
            $res =false;
        }
        else if(empty($data["payment_url"])){
            $aRes["errno"] = 3;
            $aRes["error"] = "payment_url is missed";
            $res =false;
        }
        else if(empty($data["amount"])){
            $aRes["errno"] = 4;
            $aRes["error"] = "amount is missed";
            $res =false;
        }

        $data['payment_url'] = "https://".$data['payment_url']."/assistant.htm";
        if ($data['currency'] == 'RUR')
        {
            $data['currency'] = 'RUB';
        }
        if (empty($data['mnt_test_mode']))
        {
            $data['mnt_test_mode'] = 0;
        }
        $data['mnt_signature'] = md5($data['mnt_id'].$data['order'].$data['amount'].$data['currency'].$data['mnt_test_mode'].$data['mnt_dataintegrity_code']);
        foreach(Array("payment_url", "return", "cancel") as $fldName){
            $data[$fldName] = htmlspecialchars($data[$fldName]);
        }

        return parent::getPayButtonParams($data, $aRes);
    }

    /**
     * Verify the order from user back link. In success case 'accepted' status will be setup for order.
     *
     * @param array $aGet $_GET data
     * @param array $aPost $_POST data
     * @param array $aRes reserved array reference
     * @param array $aCheckData Data that provided in driver configuration
     * @return bool true if order is correct and false otherwise
     * @see AMI_PaymentSystemDriver::payProcess(...)
     */
    public function payProcess(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData){
        // See implplementation of this method in parent class
        $status ='fail';
        if(!@is_array($aGet))
            $aGet =Array();
        if(!@is_array($aPost))
            $aPost =Array();
        $aParams =array_merge($aGet, $aPost);
        if(!empty($aParams['status']))
            $status =$aParams['status'];
        return ($status == "ok");
    }

    /**
     * Verify the order by payment system background responce. In success case 'confirmed' status will be setup for order.
     *
     * @param array $aGet $_GET data
     * @param array $aPost $_POST data
     * @param array $aRes reserved array reference
     * @param array $aCheckData Data that provided in driver configuration
     * @return int -1 - ignore post, 0 - reject(cancel) order, 1 - confirm order
     * @see AMI_PaymentSystemDriver::payCallback(...)
     */
    public function payCallback(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData){
        // See implplementation of this method in parent class
        if(!@is_array($aGet))
            $aGet =Array();
        if(!@is_array($aPost))
            $aPost =Array();
        $aParams =array_merge($aGet, $aPost);

        if(isset($aParams['MNT_ID']) && isset($aParams['MNT_TRANSACTION_ID']) && isset($aParams['MNT_OPERATION_ID'])
           && isset($aParams['MNT_AMOUNT']) && isset($aParams['MNT_CURRENCY_CODE']) && isset($aParams['MNT_TEST_MODE'])
           && isset($aParams['MNT_SIGNATURE']))
        {
            $mnt_dataintegrity_code = $aCheckData['mnt_dataintegrity_code'];
            $mnt_signature = md5("{$aParams['MNT_ID']}{$aParams['MNT_TRANSACTION_ID']}{$aParams['MNT_OPERATION_ID']}{$aParams['MNT_AMOUNT']}{$aParams['MNT_CURRENCY_CODE']}{$aParams['MNT_TEST_MODE']}".$mnt_dataintegrity_code);

            if ($aParams['MNT_SIGNATURE'] == $mnt_signature) {
                $status = 'ok';
            } else {
                $status = 'fail';
            }
        } else {
            $status = 'fail';
        }
        
        return ($status == "ok" ?1 :0);
    }

    public function getProcessOrder(array $aGet, array $aPost, array &$aRes, array $aAdditionalParams){
        $orderId =0;
        if(!empty($aGet["MNT_TRANSACTION_ID"]))
            $orderId =$aGet["MNT_TRANSACTION_ID"];
        if(!empty($aPost["MNT_TRANSACTION_ID"]))
            $orderId =$aPost["MNT_TRANSACTION_ID"];
        return intval($orderId);
    }

    public static function getOrderIdVarName(){
        return 'MNT_TRANSACTION_ID';
    }

    public function onPaymentConfirmed($orderId)
    {
        header('Status: 200 OK');
        header('HTTP/1.0 200 OK');
        die('SUCCESS');
    }

}
