<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Driver_PaymentSystem 
 * @since      5.8.6 
 * @version    $Id$ 
 * @size       5007 jtl7f+wYVDzqUdqINXw2ecC6oB8ZT0pwDocToBhVklhykRPX2i7xl+3LFN22UfatGPd8jf17FJzjGqBeFpWnNFJXeS5TV+S0Ni26L3GuukEGnClbnAPWNtWGdlAOUBUCzyyss2vfiU7ziTxFh2NotAlWKZitgtY+86QwIYnc5VU=
 */
?><?php


/**
 * Acquiropay.com pay driver.
 *
 * @package Driver_PaymentSystem
 */
class Acquiro_PaymentSystemDriver extends AMI_PaymentSystemDriver{

    protected $driverName = 'acquiro';

    /**
     * Get checkout button HTML form
     *
     * @param array $aRes Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @param array $aData The data list for button generation
     * @param bool $bAutoRedirect If form autosubmit required (directly from checkout page)
     * @return bool true if form is generated, false otherwise
     */
    public function getPayButton(array &$aRes, array $aData, $bAutoRedirect = false){
		$aRes['error'] = "Success";
		$aRes['errno'] = 0;

        // Format fields
        foreach(Array("return", "description", 'cancel') as $fldName){
            $aData[$fldName] = htmlspecialchars($aData[$fldName]);
        }

		$aData['amount'] = str_replace(',', '.', floatval($aData['amount']));

        // Disable to process order using example button
        //$aData["disabled"] = "disabled";

        // Set your fields of $aData here
		$aData['token'] = md5($aData['merchant_id'].$aData['product_id'].$aData['amount'].$aData['order'].$aData['sw']);
		//$bAutoRedirect = true;

		$post = $_POST;
		unset($post['get_type']);
		$post['action'] = 'askparams';
		$aData['hiddens'] = '';
		foreach($post as $key=>$val) {
			$aData['hiddens'] .= '<input type="hidden" name="'.$key.'" value="'.htmlspecialchars($val).'">';
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

		$aRes['error'] = "Success";
		$aRes['errno'] = 0;

		$aData['amount'] = str_replace(',', '.', floatval($aData['amount']));

        return parent::getPayButtonParams($aData, $aRes);
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

		$amount = str_replace(',', '.', floatval($aOrderData['total']));
		if($aGet['token']!=md5($aCheckData['merchant_id'].$aCheckData['product_id'].$amount.$aGet['order_id'].$aCheckData['sw'])) return false;

		return parent::payProcess($aGet, $aPost, $aRes, $aCheckData, $aOrderData);
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
        // See implplementation of this method in parent class

        return parent::getProcessOrder($aGet, $aPost, $aRes, $aAdditionalParams);
    }
}
