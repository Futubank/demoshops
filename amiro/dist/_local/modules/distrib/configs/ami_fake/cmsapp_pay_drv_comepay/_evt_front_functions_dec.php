<?php

// {{}}
if (!function_exists('comepayWebserviceStartHandelr')){
    function comepayWebserviceStartHandelr($name, array $aEvent, $handlerModId, $srcModId){
        $oWS = $aEvent['oWebService'];
        $oWS->setPublicAccess('comepay.bill');
        AMI_Registry::set('cmsapp/pay_drv/comepay/ws', $oWS);
        return $aEvent;
    }
}

if (!function_exists('comepayBillHandelr')){
    function comepayBillHandelr($name, array $aEvent, $handlerModId, $srcModId){
        $oWS = AMI_Registry::get('cmsapp/pay_drv/comepay/ws', FALSE);
        if($oWS !== FALSE){
            $oRequest = AMI::getSingleton('env/request');
            $orderId = $oRequest->get('order_id', FALSE);
            $phone = $oRequest->get('phone', FALSE);
            if(($orderId !== FALSE) && ($phone !== FALSE)){
                $lngFile = AMI_Registry::get('path/root') . '_local/eshop/pay_drivers/comepay/driver.lng';
                if(file_exists($lngFile) && AMI_Lib_FS::validatePath($lngFile)){
                    $oTpl = AMI::getResource('env/template');
                    $oTpl->setLocale(AMI_Registry::get('lang_data', 'en'));
                }
                $oOrder = AMI::getResourceModel('eshop_order/table')->find($orderId);
                if(!$oOrder->getId()){
                    $this->error(AmiClean_Webservice_Service::ERR_FAIL, $aLang['error_invalid_order']);
                }

                require_once __DIR__ . '/eshop/pay_drivers/comepay/CmsappComepayPaymentSystem.php';
                $oDrv = new CmsappComepayPaymentSystem();

                $lifetime = time() + 3600 * 24;
                $aRequestData = array(
                    'user'      => 'tel:+7' . $phone,
                    'amount'    => $oOrder->total,
                    'ccy'       => 'RUB',
                    'comment'   => 'Оплата заказа N' .$orderId,
                    'lifetime'  => date('Y-m-d', $lifetime) . 'T' . date('H:i:s', $lifetime),
                    'prv_name'  => $oDrv->getShopName()
                );

                $result = $oDrv->send('bill', $orderId, $aRequestData);
                if((int)$result == -1){
                    $oWS->error(AmiClean_Webservice_Service::ERR_FAIL, $aLang['error_server_error']);
                }
                $aEvent['result'] = $result;
            }
        }
        $oWS->ok($aEvent);
        return $aEvent;
    }
}
