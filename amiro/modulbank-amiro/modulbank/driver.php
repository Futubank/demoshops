<?php

require_once "fpayments.php";


class Modulbank_PaymentSystemDriver extends AMI_PaymentSystemDriver{
    /**
     * Get checkout button HTML form
     *
     * @param array $aRes Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @param array $aData The data list for button generation
     * @param bool $bAutoRedirect If form autosubmit required (directly from checkout page)
     * @return bool true if form is generated, false otherwise
     */
    public function getPayButton(array &$aRes, array $aData, $bAutoRedirect = false){
        foreach(Array("return", "description") as $fldName){
            $aData[$fldName] = htmlspecialchars($aData[$fldName]);
        }

        $hiddens = '';
        foreach ($aData as $key => $value) {
            $hiddens .= '<input type="hidden" name="' . $key . '" value="' . (is_null($value) ? $aData[$key] : $value) .'" />' . "\n";
        }
        $aData['hiddens'] = $hiddens;
        $aData["disabled"] = "disabled";
        
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
    public function payProcess(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData){
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
    public function payCallback(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData){
        return parent::payCallback($aGet, $aPost, $aRes, $aCheckData, $aOrderData);
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
    public function getProcessOrder(array $aGet, array $aPost, array &$aRes, array $aAdditionalParams){
        return parent::getProcessOrder($aGet, $aPost, $aRes, $aAdditionalParams);
    }
}
