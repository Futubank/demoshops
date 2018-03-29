<?php
/**
* @copyright 2000-2013 Amiro.CMS. All rights reserved.
* @version $ Id: rules.php 61118 2012-12-25 19:49:50  Artem $
* @package   Plugin_AJAXResponder
* @filesource
* @size 1964 xkqwnllqnlyixkpiuxnntpurntwnxmltktpguqngqlzurxuxllzmklqszrmlqplsnxwgpnir
*/
?>
<?php


$api->addRule('spl_plugin', RLT_SPLITTER, RLC_NONE, false);

/**
 * Plugin module id
 */
$oDeclarator = AMI_ModDeclarator::getInstance();
$oServiceAdm = new AMI_Service_Adm();
$aCaptions = array();
$aAvailableModules = array('articles', 'blog', 'news', 'files', 'photoalbum', 'eshop_item', 'kb_item', 'portfolio_item', 'stickers');
foreach(
    array(
        'ami_multifeeds' => array('articles', 'news', 'photoalbum', 'stickers'),
        'ami_files'      => array('files'),
        'ami_catalog'    => array('items')
    ) as $hyper => $aConfigs
){
    foreach($aConfigs as $config){
        $aInstanceMoIds = $oDeclarator->getRegistered($hyper, $config);
        foreach($aInstanceMoIds as $modId){
            if(!preg_match('/_cat$/', $modId)){
                $aAvailableModules[] = $modId;
                $aModCaption = $oServiceAdm->getModulesCaptions(array($modId), false);
                $aCaptions['module_' . strtoupper($modId)] = $aModCaption[$modId];
            }
        }
    }
}
$aAvailableModules = array_unique($aAvailableModules);
$api->addRule('module', RLT_ENUM, $aAvailableModules, 'news', $aCaptions);

/**
 * Sorting order
 */
$api->addRule('order', RLT_CHAR, array('length_min' => 2), 'id');

/**
 * Sorting order direction
 */
$api->addRule('dir', RLT_ENUM, array('A', 'D', ''), 'D');

/**
 * Items limit per page
 */
$api->addRule('limit', RLT_UINT, array('min' => 1), 3);

/**
 * Items list start offset
 */
$api->addRule('offset', RLT_UINT, array(), 0);

/**
 * Default page id
 */
$api->addRule('id_page', RLT_CHAR, array(), 0);

/**
 * Default template name
 */
$api->addRule('template', RLT_CHAR, array(), 'front.tpl');
