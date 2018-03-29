<?php
/**
 * Script executing on hard uninstalling.
 *
 * @copyright @copyright Amiro.CMS. All rights reserved.
 * @category  AMI
 * @package   Config_AmiFake_AmiroPayDrvExample
 */

$oStorage = AMI::getResource('storage/fs');
$oTplStorage = AMI::getResource('storage/tpl');

$destPath = AMI_Registry::get('path/root') . '_local/eshop/pay_drivers/comepay/';
$targetPath = AMI_Registry::get('path/root') . '_local/';

foreach(
    array(
        'driver.php',
        'driver.tpl',
        'driver.lng',
        'CmsappComepayPaymentSystem.php'
    ) as $file
){
    $this->aTx['storage']->addCommand(
        'storage/clean',
        new AMI_Tx_Cmd_Args(
            array(
                'modId'      => $this->oArgs->modId,
                'mode'       => $this->oArgs->mode,
                'target'     => $destPath . $file,
                'oStorage'   => $oStorage,
                'rmEmptyDir' => TRUE
            )
        )
    );
}


foreach(
    array(
        AMI_iTemplate::LNG_PATH       . '/eshop_purchase.lng',
        AMI_iTemplate::LOCAL_LNG_PATH . '/eshop_order.lng'
    ) as $target
){
    $this->aTx['storage']->addCommand(
        'tpl/uninstall',
        new AMI_Tx_Cmd_Args(
            array(
                'mode'     => $this->oArgs->mode,
                'modId'    => $this->oArgs->modId,
                'target'   => $target,
                'oStorage' => $oTplStorage
            )
        )
    );
}

foreach(array('common_functions', 'front_functions') as $file){
    $oArgs = new AMI_Tx_Cmd_Args(
        array(
            'hypermod' => $this->oArgs->hypermod,
            'config'   => $this->oArgs->config,
            'pkgId'   => $this->oArgs->pkgId,
            'modId'    => $this->oArgs->modId,
            'mode'     => $this->oArgs->mode,
            'target'   => $targetPath . $file . '.php',
            'oStorage' => $oStorage
        )
    );
    $this->aTx['storage']->addCommand('pkg/handlers/uninstall', $oArgs);
}
