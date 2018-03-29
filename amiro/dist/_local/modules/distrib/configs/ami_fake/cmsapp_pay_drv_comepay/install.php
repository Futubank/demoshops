<?php
/**
 * Script executing on installing.
 *
 * @copyright @copyright Amiro.CMS. All rights reserved.
 * @category  AMI
 * @package   Config_AmiFake_AmiroPayDrvExample
 */

$srcPath = dirname(__FILE__) . '/';
$destPath = AMI_Registry::get('path/root') . '_local/eshop/';

$oStorage = AMI::getResource('storage/fs');
$oTplStorage = AMI::getResource('storage/tpl');

$oStorage->setMode(AMI_iStorage::MODE_MAKE_FOLDER_ON_COPY);
$srcPath  .=  'driver/';
$destPath .= 'pay_drivers/comepay/';

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
        'storage/copy',
        new AMI_Tx_Cmd_Args(
            array(
                'mode'     => $this->oArgs->mode,
                'source'   => $srcPath . $file,
                'target'   => $destPath . $file,
                'oStorage' => $oStorage
            )
        )
    );
}

foreach(
    array(
        __DIR__ . '/eshop_purchase.lng' => AMI_iTemplate::LNG_PATH . '/eshop_purchase.lng',
        __DIR__ . '/eshop_order.lng'    => AMI_iTemplate::LOCAL_LNG_PATH . '/eshop_order.lng'
    ) as $src => $dest
){
    $this->aTx['storage']->addCommand(
        'tpl/install',
        new AMI_Tx_Cmd_Args(
            array(
                'mode'      => $this->oArgs->mode,
                'modId'     => $this->oArgs->modId,
                'target'    => $dest,
                'content'   => $oStorage->load($src),
                'oStorage'  => $oTplStorage
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
            'handlerRegistrationSource' => __DIR__ . '/' . '_evt_' . $file . '_reg.php',
            'handlerDeclarationSource'  => __DIR__ . '/' . '_evt_' . $file . '_dec.php',
            'target'   => $targetPath . $file . '.php',
            'oStorage' => $oStorage
        )
    );
    $this->aTx['storage']->addCommand('pkg/handlers/install', $oArgs);
}

$htaccessContent = file_get_contents(AMI_Registry::get('path/root') . '/.htaccess');
if(strpos($htaccessContent, 'HTTP_AUTHORIZATION') === FALSE){
    $htaccessContent = '
<IfModule mod_rewrite.c>
RewriteEngine on
RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]
</IfModule>

' . $htaccessContent;
     file_put_contents(AMI_Registry::get('path/root') . '/.htaccess', $htaccessContent);
}
