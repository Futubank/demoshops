<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @size       618 xkqwutniktukkriinpmnrmksxyxsumyqzgwyrxuutxpnpywngzrswxzmsiwkxlnkwzrnpnir
 */
?>
<?php
// {{}}
if($oDeclarator->isRegistered('##modId##')){
    $oMod = $oDeclarator->getModule('##modId##');
    $oMod->setOption('engine_version', '0600');

    $oMod->setOption('sape_id', '');

    $oMod->setOption('domain', '');

    $oMod->setOption('cache_expire_force', '');

    $oMod->setOption('cache_l3_enable', TRUE);
}
