<?php
/**
* @copyright 2000-2013 Amiro.CMS. All rights reserved.
* @version $ Id: ami_server.php 58955 2013-02-15 16:59:30  Artem $
* @package   Plugin_AJAXResponder
* @filesource
* @size 11463 xkqwkytnzymkrsmxqpkputwlqyrmqtkwpwuzqilwiyzkunspwqlmpzwiplkqplxxpymypnir
*/
?>
<?php


/**
 * @var AMI_Response
 */
$oResponse = AMI::getSingleton('response');

// To avoid server overload and flood
$oResponse->sleep(100000);

/**
 * @var AMI_Request
 */
$oRequest = AMI::getSingleton('env/request');

// Loading allowed modules list from ini-file {

$pluginId = $oRequest->get('id_plugin', 'ami_ajax_responder');
$path = AMI::getPluginDataPath($pluginId) . 'config_server.php';
$aConfig = @parse_ini_file($path);
AMI_Registry::push('disable_error_mail', TRUE);
if(!is_array($aConfig)){
    trigger_error('Cannot load config file "' . $path . "'", E_USER_ERROR);
}
AMI_Registry::pop('disable_error_mail');
if(!isset($aConfig['allowed_modules'])){
    trigger_error('Missing parameter "allowed_modules" in config file "' . $path . "'", E_USER_ERROR);
}

/**
 * Allowed modules list
 *
 * @var array
 * @see config_server.php
 */
$aAllowedModules = empty($aConfig['allowed_modules']) ? array() : explode(',', $aConfig['allowed_modules']);

// } Loading allowed modules list from ini-file

if(!sizeof($aAllowedModules) || !in_array($oRequest->get('module'), $aAllowedModules)){
    // Forbidden module, exitpoint
    $oResponse->setMessage($oRequest->get('module'), -1);
    $oResponse->send();
}

$aModulesSettings = array(
    'articles' => array(
        'classes' => array(
            'PlgAJAXResp_Articles_State'          => 'PlgAJAXResp_Articles',
            'PlgAJAXResp_Articles_ListView'       => 'PlgAJAXResp_Articles'
        ),
        'resources' => array(
            // Plugin Articles module model
            'plg_ajax_resp/articles/state/model'       => 'PlgAJAXResp_Articles_State',
            // Plugin Articles module view
            'plg_ajax_resp/articles/list/view'         => 'PlgAJAXResp_Articles_ListView',
            // Plugin controller
            'plg_ajax_resp/module/controller'          => 'PlgAJAXResp'
        )
    ),
    'blog' => array(
        'classes' => array(
            'PlgAJAXResp_Blog_State'              => 'PlgAJAXResp_Blog',
            'PlgAJAXResp_Blog_ListView'           => 'PlgAJAXResp_Blog'
        ),
        'resources' => array(
            // Plugin Blog module model
            'plg_ajax_resp/blog/state/model'           => 'PlgAJAXResp_Blog_State',
            // Plugin Blog module view
            'plg_ajax_resp/blog/list/view'             => 'PlgAJAXResp_Blog_ListView',
            // Plugin controller
            'plg_ajax_resp/module/controller'          => 'PlgAJAXResp'
        )
    ),
    'eshop_item' => array(
        'classes' => array(
            'PlgAJAXResp_EshopItem_State'         => 'PlgAJAXResp_EshopItem',
            'PlgAJAXResp_EshopItem_ListView'      => 'PlgAJAXResp_EshopItem'
        ),
        'resources' => array(
            // Plugin E-shop Product module model
            'plg_ajax_resp/eshop_item/state/model'     => 'PlgAJAXResp_EshopItem_State',
            // Plugin E-shop Product module view
            'plg_ajax_resp/eshop_item/list/view'       => 'PlgAJAXResp_EshopItem_ListView',
            // Plugin controller
            'plg_ajax_resp/module/controller'          => 'PlgAJAXResp'
        )
    ),
    'files' => array(
        'classes' => array(
            'PlgAJAXResp_Files_State'             => 'PlgAJAXResp_Files',
            'PlgAJAXResp_Files_ListView'          => 'PlgAJAXResp_Files'
        ),
        'resources' => array(
            // Plugin Files module model
            'plg_ajax_resp/files/state/model'          => 'PlgAJAXResp_Files_State',
            // Plugin Files module view
            'plg_ajax_resp/files/list/view'            => 'PlgAJAXResp_Files_ListView',
            // Plugin controller
            'plg_ajax_resp/module/controller'          => 'PlgAJAXResp'
        )
    ),
    'kb_item' => array(
        'classes' => array(
            'PlgAJAXResp_KbItem_State'            => 'PlgAJAXResp_KbItem',
            'PlgAJAXResp_KbItem_ListView'         => 'PlgAJAXResp_KbItem'
        ),
        'resources' => array(
            // Plugin Knowledge Base Item module model
            'plg_ajax_resp/kb_item/state/model'        => 'PlgAJAXResp_KbItem_State',
            // Plugin Knowledge Base Item module view
            'plg_ajax_resp/kb_item/list/view'          => 'PlgAJAXResp_KbItem_ListView',
            // Plugin controller
            'plg_ajax_resp/module/controller'          => 'PlgAJAXResp'
        )
    ),
    'news' => array(
        'classes' => array(
            'PlgAJAXResp_News_State'              => 'PlgAJAXResp_News',
            'PlgAJAXResp_News_ListView'           => 'PlgAJAXResp_News'
        ),
        'resources' => array(
            // Plugin News module model
            'plg_ajax_resp/news/state/model'           => 'PlgAJAXResp_News_State',
            // Plugin News module view
            'plg_ajax_resp/news/list/view'             => 'PlgAJAXResp_News_ListView',
            // Plugin controller
            'plg_ajax_resp/module/controller'          => 'PlgAJAXResp'
        )
    ),
    'photoalbum' => array(
        'classes' => array(
            'PlgAJAXResp_Photoalbum_State'        => 'PlgAJAXResp_Photoalbum',
            'PlgAJAXResp_Photoalbum_ListView'     => 'PlgAJAXResp_Photoalbum'
        ),
        'resources' => array(
            // Plugin Photo Gallery module model
            'plg_ajax_resp/photoalbum/state/model'     => 'PlgAJAXResp_Photoalbum_State',
            // Plugin Photo Gallery module view
            'plg_ajax_resp/photoalbum/list/view'       => 'PlgAJAXResp_Photoalbum_ListView',
            // Plugin controller
            'plg_ajax_resp/module/controller'          => 'PlgAJAXResp'
        )
    ),
    'portfolio_item' => array(
        'classes' => array(
            'PlgAJAXResp_PortfolioItem_State'     => 'PlgAJAXResp_PortfolioItem',
            'PlgAJAXResp_PortfolioItem_ListView'  => 'PlgAJAXResp_PortfolioItem'
        ),
        'resources' => array(
            // Plugin PortfolioItem module model
            'plg_ajax_resp/portfolio_item/state/model' => 'PlgAJAXResp_PortfolioItem_State',
            // Plugin PortfolioItem module view
            'plg_ajax_resp/portfolio_item/list/view'   => 'PlgAJAXResp_PortfolioItem_ListView',
            // Plugin controller
            'plg_ajax_resp/module/controller'          => 'PlgAJAXResp'
        )
    ),
    'stickers' => array(
        'classes' => array(
            'PlgAJAXResp_Stickers_State'          => 'PlgAJAXResp_Stickers',
            'PlgAJAXResp_Stickers_ListView'       => 'PlgAJAXResp_Stickers'
        ),
        'resources' => array(
            // Plugin Stickers module model
            'plg_ajax_resp/stickers/state/model'       => 'PlgAJAXResp_Stickers_State',
            // Plugin Stickers module view
            'plg_ajax_resp/stickers/list/view'         => 'PlgAJAXResp_Stickers_ListView',
            // Plugin controller
            'plg_ajax_resp/module/controller'          => 'PlgAJAXResp'
        )
    ),
    'search_history' => array(
        'classes' => array(
            'PlgAJAXResp_SearchHistory'           => 'PlgAJAXResp_SearchHistory',
            'PlgAJAXResp_SearchHistory_State'     => 'PlgAJAXResp_SearchHistory',
            'PlgAJAXResp_SearchHistory_ListView'  => 'PlgAJAXResp_SearchHistory',
            'PlgAJAXResp_Search_State'            => 'PlgAJAXResp_Search',
            'PlgAJAXResp_Search_ListView'         => 'PlgAJAXResp_Search'
        ),
        'resources' => array(
            // Plugin SearchHistory module model
            'plg_ajax_resp/search_history/state/model' => 'PlgAJAXResp_SearchHistory_State',
            // Plugin SearchHistory module view
            'plg_ajax_resp/search_history/list/view'   => 'PlgAJAXResp_SearchHistory_ListView',
            // Plugin Search module model
            'plg_ajax_resp/search/state/model'         => 'PlgAJAXResp_Search_State',
            // Plugin Search module view
            'plg_ajax_resp/search/list/view'           => 'PlgAJAXResp_Search_ListView',
            // Plugin SearchHistory controller
            'plg_ajax_resp/module/controller'          => 'PlgAJAXResp_SearchHistory'
        )
    )
);

$moduleName = $oRequest->get('module');
$oDeclarator = AMI_ModDeclarator::getInstance();
if($oDeclarator->isRegistered($moduleName)){
    list($hyper, $config) = $oDeclarator->getHyperData($moduleName);
    $moduleName = $config;
}
$response = '';
if(isset($aModulesSettings[$moduleName])){
    /**
     * Plugin class mapping
     *
     * @see AMI_Service::addClassMapping()
     */
    AMI_Service::addClassMapping($aModulesSettings[$moduleName]['classes']);

    /**
     * Plugin modules resource mapping.
     *
     * Uncomment appropriate module resource mapping.
     *
     * @see PlgAJAXResp::__construct()
     * @see AMI::getResource()
     */
    AMI::addResourceMapping($aModulesSettings[$moduleName]['resources']);


    AMI_Service::addClassMapping(array(
        'PlgAJAXResp_ListViewLinks' => 'PlgAJAXResp_ListView'
    ));


    $oPluginController = AMI::getResource('plg_ajax_resp/module/controller', array($oRequest, $aAllowedModules));

    $response = $oPluginController->getResponse();
}else{
    trigger_error('Unknown module name for AJAX Responder plugin', E_USER_WARNING);
}
/**
 * @exitpoint
 */
$oResponse->write($response);
