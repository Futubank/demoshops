<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @size       628 xkqwykwwwqnrsnryzmrxxqnqygtiwgnmgnlznzgqwnxnnukxpptuwuinwyigrsyqsttlpnir
 */
?>
<?php
// {{}}
if($oDeclarator->isRegistered('##modId##')){
    $oMod = $oDeclarator->getModule('##modId##');
    $oMod->setProperty('taborder', $oDeclarator->getTabOrder('##modId##'));

    // Front specblocks
    $oMod->setProperty('spec_blocks', array('spec_small_##modId##'));
    $oMod->setProperty('front_request_types', array('plain'));
}
