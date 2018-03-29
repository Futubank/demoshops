<?php
/* ====================================================================================================================
  Application:    Amiro.CMS
  File:           Common functions
  Version:        5

  Copyright:      XXI, Amiro.CMS, All rights reserved.
=====================================================================================================================*/

// DO NOT REMOVE THIS LINE! Registering handlers {

// Do not delete this comment! [ami_fake_cmsapp_pay_drv_comepay] {
AMI_Registry::set('cmsapp/pay_drv/comepay/debug', TRUE);
AMI_Event::addHandler('on_before_delete_model_item', 'comepayCancelBillHandler', 'eshop_order');
AMI_Event::addHandler('on_order_before_status_change', 'comepayCancelBillHandler', AMI_Event::MOD_ANY);
// } Do not delete this comment! [ami_fake_cmsapp_pay_drv_comepay]

// DO NOT REMOVE THIS LINE! } Registering handlers

// DO NOT REMOVE THIS LINE! Declaration of handlers {

// Do not delete this comment! [ami_fake_cmsapp_pay_drv_comepay] {
if (!function_exists('comepayCancelBillHandler')){
    function comepayCancelBillHandler($name, array $aEvent, $handlerModId, $srcModId){
        $cancel = FALSE;
        $oItem =
            isset($aEvent['oItem']->data)
                ? $aEvent['oItem']
                : $aEvent['oItem']->getTable()->find($aEvent['oItem']->getId(), array('data'));

        $aData = $oItem->data;
        if(empty($aData['comepay'])){
            return $aEvent;
        }
        switch($name){
            case 'on_before_delete_model_item':
                $cancel = TRUE;
                break;
            case 'on_order_before_status_change':
                $status = $aEvent['status'];
                if(in_array($status, array('cancelled', 'rejected'))){
                    $cancel = TRUE;
                }
                break;
        }
        if($cancel){
            $oPayDrivers = AMI::getResourceModel('payment_drivers/table');
            $oPayDriver =
                $oPayDrivers
                    ->getItem()
                    ->addFields(array('id', 'header', 'settings'))
                    ->addSearchCondition(
                        array(
                            'header'        => 'comepay',
                            'is_installed'  => 1
                        )
                    )
                    ->load();
            if($oPayDriver->getId()){
                $aSettings = unserialize($oPayDriver->settings);
                require_once __DIR__ . '/eshop/pay_drivers/comepay/CmsappComepayPaymentSystem.php';
                $oDrv = new CmsappComepayPaymentSystem($aSettings);
                $result = $oDrv->send('cancel', $oItem->getId(), array('status' => 'rejected'));
            }
        }

        return $aEvent;
    }
}
// } Do not delete this comment! [ami_fake_cmsapp_pay_drv_comepay]

// DO NOT REMOVE THIS LINE! } Declaration of handlers

