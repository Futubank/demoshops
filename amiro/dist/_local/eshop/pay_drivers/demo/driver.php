<?php
/**
 * @copyright  2000-2015 Amiro.CMS. All rights reserved. 
 * @package    Driver_PaymentSystem 
 * @version    $Id$ 
 * @size       1900 atoDfQOWZAKiBftzRdDbjgtHZLTYTWFM/jKvucmzu4CFLMAq8OIVOawi5uIlyvNLADbegYJQUowyG/wqfJP0WsPBk69eZFnIjgKfRMiHI0otvn8RxNuACUWJSdgDFatqqCPeQpkhUE5/mqnnG9im1wkhEuGEk/jIuIK70QSETJI=
 */
?><?php


/**
 * Demo payment driver.
 *
 * @package Driver_PaymentSystem
 */
class Demo_PaymentSystemDriver extends AMI_PaymentSystemDriver{
    /**
     * Get checkout button HTML form.
     *
     * @param  array &$aRes          Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @param  array $aData          The data list for button generation
     * @param  bool  $bAutoRedirect  If form autosubmit required (directly from checkout page)
     * @return bool TRUE if form is generated, FALSE otherwise
     */
    public function getPayButton(array &$aRes, array $aData, $bAutoRedirect = FALSE){
        $vRes['errno'] = 0;
        $vRes['error'] = 'Success';

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

        return parent::getPayButtonParams($aData, $aRes);
    }
}
