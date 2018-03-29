<?php
/**
 * @copyright  2000-2015 Amiro.CMS. All rights reserved. 
 * @package    Driver_PaymentSystem 
 * @version    $Id$ 
 * @since      5.10.0 
 * @size       5199 SlwL2yPIUvZ0AFxHY1XaEoFmIj0za5BHmfEmNKhefRUhroigz0kfo+Br45VfEiZggv0Ri9+XJNEkaVyml20iqMMkkwyLJAMpCskcFvIpB7sZaxLutDg3KfzUSoFqD/ub9nUm0pH1Swhpp6Xi1sCKLCeid+irjFfUqmshuRL0cDk=
 */
?><?php


/**
 * Print order pay driver
 *
 * @package Driver_PaymentSystem
 */

class ____Print_PaymentSystemDriver extends BILL_driver_print{
    protected $driverName = 'print';
}

class Print_PaymentSystemDriver extends AMI_PaymentSystemDriver{
    protected $driverName = 'print';
    
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
        if(empty($aData['order'])){
            $aRes['errno'] = 1;
            $aRes['error'] = 'order is missed';
            $res = FALSE;
        }elseif(empty($aData['return'])){
            $aRes['errno'] = 2;
            $aRes['error'] = 'return is missed';
            $res = FALSE;
        }elseif(empty($aData['button_name']) && empty($aData['button'])){
            $aRes['errno'] = 3;
            $aRes['error'] = 'button_name is missed';
            $res = FALSE;
        }
        
        $aHiddenData = $aData;
        foreach(array('order', 'return', 'button_name', 'button') as $var){
            unset($aHiddenData[$var]);
        }
        $aData['hiddens'] = $this->getScopeAsFormHiddenFields($aHiddenData);

        $aData['button'] = trim($aData['button']);
        if(!empty($aData['button'])){
            $aData['_button_html'] = 1;
        }
        if($bAutoRedirect){
            $aData['_BILL_AUTO_REDIRECT'] = 1;
        }
        if(!$res){
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
        if(empty($aData['url'])){
            $aRes['errno'] = 1;
            $aRes['error'] = 'url is missed';
            return FALSE;
        }elseif(empty($aData['order'])){
            $aRes['errno'] = 2;
            $aRes['error'] = 'order is missed';
            return FALSE;
        }elseif(empty($aData['hidden_name'])){
            $aRes['errno'] = 3;
            $aRes['error'] = 'hidden_name is missed';
            return FALSE;
        }elseif(empty($aData['print_value'])){
            $aRes['errno'] = 4;
            $aRes['error'] = 'print_value is missed';
            return FALSE;
        }elseif(empty($aData['process_value'])){
            $aRes['errno'] = 5;
            $aRes['error'] = 'process_value is missed';
            return FALSE;
        }

        $aHiddenData = $aData;
        foreach(array('item_number', 'url', 'hidden_name', 'print_value', 'process_value', $aData['hidden_name']) as $var){
            unset($aHiddenData[$var]);
        }
        $aData['hiddens'] = $this->getScopeAsFormHiddenFields($aHiddenData);
        
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
        if(!empty($aGet['status'])){ 
            $status = $aGet['status'];
        }
        if(!empty($aPost['status'])){
            $status = $aPost['status'];
        }

        return 'ok' == $status;
    }
}
