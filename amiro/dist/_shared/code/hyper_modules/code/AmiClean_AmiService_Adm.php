<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiClean_AmiService 
 * @subpackage Controller 
 * @since      x.x.x 
 * @size       31246 xkqwxgiszyyulwwgnzisqzkqlqiyqpigkgwiwlmmzmpttqtqglzqrygrtxmnlzpsqzmnpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 

class AmiClean_AmiService_Adm extends Hyper_AmiClean_Adm{
    /**
     * Constructor.
     *
     * @param AMI_Request  $oRequest   Request object
     * @param AMI_Response $oResponse  Response object
     */
    public function __construct(AMI_Request $oRequest, AMI_Response $oResponse){
        // System user access only
        /*
        global $Core;

		if(is_object($Core) && $Core instanceof CMS_Core){
            $isSysUser = $Core->isSysUser();
        }else{
            $isSysUser = AMI::getSingleton('core')->isSysUser();
        }
        if(!$isSysUser){
            return;
        }
		*/

        parent::__construct($oRequest, $oResponse);

        $aComponents = array('form');
        $service = $oRequest->get('service', '');
        switch($service){
            case 'repair':
                $aComponents = array('repair');
                break;
        }

        $this->addComponents($aComponents);
    }
}

/**
 * AmiClean/AmiService configuration model.
 *
 * @package    Config_AmiClean_AmiService
 * @subpackage Model
 * @resource   {$modId}/module/model <code>AMI::getResourceModel('{$modId}/module')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_AmiService_State extends Hyper_AmiClean_State{
}

/**
 * AmiClean/AmiService configuration form component controller.
 *
 * @package    Config_AmiClean_AmiService
 * @subpackage Controller
 * @resource   {$modId}/form/controller/adm <code>AMI::getResource('{$modId}/form/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_AmiService_FormAdm extends Hyper_AmiClean_FormAdm{
    /**
     * Specifies whether component has a model or not
     *
     * @var bool
     */
    protected $useModel = FALSE;

    /**#@-*/

    /**
     * Save action handler.
     *
     * @param  array &$aEvent  Event data
     * @return array
     */
    public function _save(array &$aEvent){
        $this->displayView();
        $oResponse = AMI::getSingleton('response');
        $oRequest = AMI::getSingleton('env/request');
        require_once($GLOBALS["FUNC_INCLUDES_PATH"]."func_file_system.php");

        $action = $oRequest->get('service_action', NULL);
        switch($action){
            case 'delete_generated':
                $this->deleteGenerated();
                $message = 'status_generated_deleted';
                break;
            case 'delete_demo_content':
                $this->deleteDemoContent();
                $message = 'status_demo_content_deleted';
                break;
            case 'cache_truncate':
                $this->truncateCache();
                $message = 'status_cache_truncated';
                break;
        }

        $oRequest->set('id', 0);
        $this->oItem = NULL;
        $oResponse->addStatusMessage($message);
        AMI_Event::fire('dispatch_mod_action_form_edit', $aEvent, $this->getModId());

        return $aEvent;
    }

    /**
     * Deletes files from "generated" folders.
     *
     * @return void
     */
    protected function deleteGenerated(){
        $generatedRootPath = AMI_Registry::get('path/root') . AMI_Registry::get('CUSTOM_PICTURES_HTTP_PATH');
        $list = getDirFileList($generatedRootPath, '*', false, true);
        foreach($list as $dir){
            $curGeneratedDir = $generatedRootPath.$dir.'/generated/';
            if(is_dir($curGeneratedDir)){
                $generatedDir = dir($curGeneratedDir);
                if(is_object($generatedDir)){
                    while(false !== ($entry = $generatedDir->read())){
                        if(is_file($curGeneratedDir.$entry) && ($entry != "." && $entry != "..")){
                            @unlink($curGeneratedDir.$entry);
                        }
                    }
                }
            }
        }
    }

    /**
     * Deletes demo content.
     *
     * @return void
     */
    protected function truncateCache(){
        $oDB = AMI::getSingleton('db');
        $oDB->query(DB_Query::getSnippet("TRUNCATE `cms_cache`"));
        $oDB->query(DB_Query::getSnippet("TRUNCATE `cms_cache_content`"));
        $oDB->query(DB_Query::getSnippet("TRUNCATE `cms_cache_blocks`"));
    }

    /**
     * Deletes demo content.
     *
     * @return void
     */
    protected function deleteDemoContent(){
        $oDB = AMI::getSingleton('db');
         // $oDB->displayQueries();###

        // `cms_pages`
        @set_time_limit(28);
        trigger_error("[DEMO CONTENT CLEANUP] Cleaning up Site Manager static pages...");
        $oQuery =
            DB_Query::getSnippet(
                "UPDATE `cms_pages` " .
                "SET `body` = %s " .
                "WHERE `module_name` = %s"
            )->q('')->q('pages');
        $oDB->query($oQuery);
        trigger_error("[DEMO CONTENT CLEANUP] " . $oDB->getAffectedRows() . " static pages cleaned up.");

        // `cms_site_search` / `cms_site_search_index`
        @set_time_limit(28);
        trigger_error("[DEMO CONTENT CLEANUP] Cleaning up site search info...");
        $sql = "SELECT COUNT(`id`) FROM `cms_site_search`";
        $qty = $oDB->fetchValue($sql);
        $sql = "SELECT COUNT(`id`) FROM `cms_site_search_index`";
        $qty += $oDB->fetchValue($sql);
        $sql = "TRUNCATE `cms_site_search`";
        $oDB->query($sql);
        $sql = "TRUNCATE `cms_site_search_index`";
        $oDB->query($sql);
        trigger_error("[DEMO CONTENT CLEANUP] " . $qty . " records cleaned up.");

        // `cms_cache` / `cms_cache_blocks` / `cms_cache_content`
        @set_time_limit(28);
        trigger_error("[DEMO CONTENT CLEANUP] Cleaning system cache...");
        $sql = "SELECT COUNT(`id`) FROM `cms_cache`";
        $qty = $oDB->fetchValue($sql);
        $sql = "SELECT COUNT(`id`) FROM `cms_cache_blocks`";
        $qty += $oDB->fetchValue($sql);
        $sql = "SELECT COUNT(`id_page`) FROM `cms_cache_content`";
        $qty += $oDB->fetchValue($sql);
        $this->truncateCache();
        trigger_error("[DEMO CONTENT CLEANUP] " . $qty . " records cleaned up.");

        @set_time_limit(28);
        trigger_error("[DEMO CONTENT CLEANUP] Cleaning JS/CSS cache...");
        $oFileCache = AMI::getResource('env/file_cache');
        $oFileCache->reset();
        unset($oFileCache);
        trigger_error("[DEMO CONTENT CLEANUP] JS/CSS cache cleaned up.");

        @set_time_limit(28);
        $oDeclarator = AMI_ModDeclarator::getInstance();
        $aModIds = $oDeclarator->getRegistered('ami_multifeeds');
        $aModIds += $oDeclarator->getRegistered('ami_multifeeds5');
        $aModIds += $oDeclarator->getRegistered('ami_datasets');
        $aModIds += $oDeclarator->getRegistered('ami_files');
        $aModIds += $oDeclarator->getRegistered('ami_jobs');
        $aModIds += $oDeclarator->getRegistered('ami_subscribe');
        $aModIds += $oDeclarator->getRegistered('ami_votes');
        $aModIds += $oDeclarator->getRegistered('ami_discussion');
        $aModIds += $oDeclarator->getRegistered('ami_forum');
        $aModIds += $oDeclarator->getRegistered('ami_relations');
        $aModIds += $oDeclarator->getRegistered('ami_clean', 'templates');
        $aModIds += $oDeclarator->getRegistered('ami_catalog');
        $aModIds += $oDeclarator->getRegistered('ami_data_exchange', 'catalog');
        $aModIds += $oDeclarator->getRegistered('ami_eshop_discounts');
        $aModIds += $oDeclarator->getRegistered('ami_eshop_shipping');
        $aModIds += $oDeclarator->getRegistered('ami_tags');

        @set_time_limit(28);
        $aImageFolders = array(
            AMI_Registry::get('path/root') . '_mod_files/ce_images/inst',
            AMI_Registry::get('path/root') . '_mod_files/ftpfiles',
            AMI_Registry::get('path/root') . '_mod_files/es_files'
        );
        $aDBData = array(
            'eshop_datasets' => array(
                'dataSource'  => 'eshop_datasets',
                'tableName' => 'cms_es_datasets'
            ),
            'eshop_custom_types' => array(
                'dataSource'  => 'eshop_custom_types',
                'tableName' => 'cms_es_custom_types'
            ),
            'kb_datasets' => array(
                'dataSource'  => 'kb_datasets',
                'tableName' => 'cms_kb_datasets'
            ),
            'kb_custom_types' => array(
                'dataSource'  => 'kb_custom_types',
                'tableName' => 'cms_kb_custom_types'
            ),
            'portfolio_datasets' => array(
                'dataSource'  => 'portfolio_datasets',
                'tableName' => 'cms_po_datasets'
            ),
            'portfolio_custom_types' => array(
                'dataSource'  => 'portfolio_custom_types',
                'tableName' => 'cms_po_custom_types'
            )
        );
        foreach($aModIds as $modId){
            if(!$GLOBALS['Core']->IsInstalled($modId)){
                continue;
            }
            $dataSource = $oDeclarator->getAttr($modId, 'data_source');
            $dbTable = $oDeclarator->getAttr($modId, 'db_table');
            $aDBData[$modId] = array(
                'dataSource'  => $dataSource,
                'tableName' => $dbTable ? $dbTable : 'cms_' . $modId
            );
            if(AMI::issetProperty($modId, 'picture_cat')){
                $folder =
                    AMI_Registry::get('path/root') . '_mod_files/ce_images/' .
                    AMI::getProperty($modId, 'picture_cat');
            }else{
                $folder =
                    AMI_Registry::get('path/root') . '_mod_files/ce_images/' . $modId;
            }
            if(file_exists($folder) && is_dir($folder)){
                $aImageFolders[] = $folder;
            }
        }

        $aImageFolders = array_unique($aImageFolders);
        trigger_error("[DEMO CONTENT CLEANUP] Cleaning up modules images...");
        foreach($aImageFolders as $folder){
            @set_time_limit(28);
            $aFiles = AMI_Lib_FS::scan($folder);
            trigger_error("[DEMO CONTENT CLEANUP] Cleaning up folder '" . $folder . "'...");
            $count = 0;
            foreach($aFiles as $file){
                if(
                    file_exists($file) &&
                    !is_dir($file) &&
                    '.' !== mb_substr(basename($file), 0, 1)
                ){
                    unlink($file);
                    $count++;
                }
            }
            trigger_error("[DEMO CONTENT CLEANUP] " . $count . " files deleted");
        }

        trigger_error("[DEMO CONTENT CLEANUP] Cleaning up modules tables...");
        foreach($aDBData as $modId => $aDBModData){
            @set_time_limit(28);
            $tableName = $aDBModData['tableName'];
            if($modId !== $aDBModData['dataSource']){
                $tableName = $aDBData[$aDBModData['dataSource']]['dataSource'];
            }
            $oQuery =
                DB_Query::getSnippet("SHOW TABLES LIKE %s")
                ->q($tableName);
            if($oDB->fetchValue($oQuery)){
                trigger_error("[DEMO CONTENT CLEANUP] " . $modId . ": cleaning up `" . $tableName . "'`...");
                $common = TRUE;
                $hyper  = '';
                $config = '';
                if($oDeclarator->isRegistered($modId)){
                    list($hyper, $config) = $oDeclarator->getHyperData($modId);
                }
                if(
                    (
                        $hyper &&
                        in_array(
                            $oDeclarator->getSection($modId),
                            array('eshop', 'kb', 'portfolio')
                        )
                    ) || (
                        'ami_datasets' === $hyper &&
                        'datasets' === $config
                    )/* || preg_match('/^(eshop|kb|portfolio)_datasets$/', $modId) */
                ){
                    if(
                        preg_match('/_shipping_fields$/', $tableName) ||
                        preg_match('/_datasets$/', $tableName)
                    ){
                        $oQuery =
                            DB_Query::getSnippet(
                                "DELETE FROM `%s` " .
                                "WHERE `is_sys` = 0"
                            )
                            ->plain($tableName);
                        $oDB->query($oQuery);
                        $this->alterAutoIncrement($oDB, $tableName);
                        $common = FALSE;
                    }elseif(
                        preg_match('/_shipping_methods$/', $tableName)
                    ){
                        $oQuery =
                            DB_Query::getSnippet(
                                "DELETE FROM `%s` " .
                                "WHERE `name` NOT IN (%s, %s)"
                            )
                            ->plain($tableName)
                            ->q('')
                            ->q('Самовывоз');
                        $oDB->query($oQuery);
                        $this->alterAutoIncrement($oDB, $tableName);
                        $common = FALSE;
                    }elseif(
                        preg_match('/_shipping_types$/', $tableName)
                    ){
                        $oQuery =
                            DB_Query::getSnippet(
                                "DELETE FROM `%s` " .
                                "WHERE `is_default` = 0 AND `name` != %s"
                            )
                            ->plain($tableName)
                            ->q('По-умолчанию');
                        $oDB->query($oQuery);
                        $this->alterAutoIncrement($oDB, $tableName);
                        $common = FALSE;
                    }
                }

                if($common){
                    $oQuery =
                        DB_Query::getSnippet("TRUNCATE `%s`")
                        ->plain($tableName);
                    $oDB->query($oQuery, AMI_DB::QUERY_TRUSTED);
                }
            }
        }

        // eshop/kb/portfolio references
        foreach(
            array(
                'eshop'     => 'es',
                'kb'        => 'kb',
                'portfolio' => 'po'
            ) as $section => $tablePart
        ){
            $modId = $section . '_reference_types';
            if(!$GLOBALS['Core']->IsInstalled($modId)){
                continue;
            }
            $refTableMask = 'cms\\_' . $tablePart . '\\_reference\\_%';
            $oQuery =
                DB_Query::getSnippet("SHOW TABLES LIKE %s")
                ->q($refTableMask);
            $aCol = $oDB->fetchCol($oQuery);
            foreach($aCol as $tableName){
                if(
                    preg_match(
                        '/^' . preg_quote('cms_' . $tablePart . '_reference_') . '(\d{4})$/',
                        $tableName,
                        $aMatches
                    ) &&
                    '0001' !== $aMatches[1]
                ){
                    $oQuery =
                        DB_Query::getSnippet("DROP TABLE IF EXISTS `%s`")
                        ->plain($tableName);
                    $oDB->query($oQuery, AMI_DB::QUERY_TRUSTED);
                }
            }
            $tableName = 'cms_' . $tablePart . '_ref_types';
            $oQuery =
                DB_Query::getSnippet("TRUNCATE `%s`")
                ->plain($tableName);
            $oDB->query($oQuery, AMI_DB::QUERY_TRUSTED);
        }
    }

    /**
     * Sets minimum auto increment to databaase table.
     *
     * @param  AMI_DB $oDB        DB object
     * @param  string $tableName  Table name
     * @param  string $idField    Id field name
     * @return void
     */
    protected function alterAutoIncrement(AMI_DB $oDB, $tableName, $idField = 'id'){
        $oQuery =
            DB_Query::getSnippet("SELECT MAX(`%s`) FROM `%s`")
            ->plain($idField)
            ->plain($tableName);
        $id = (int)$oDB->fetchValue($oQuery) + 1;
        $oQuery =
            DB_Query::getSnippet("ALTER TABLE `%s` AUTO_INCREMENT = %s")
            ->plain($tableName)
            ->plain($id);
        $oDB->query($oQuery, AMI_DB::QUERY_TRUSTED);
    }
}

/**
 * AmiClean/AmiService configuration form component view.
 *
 * @package    Config_AmiClean_AmiService
 * @subpackage View
 * @resource   {$modId}/form/view/adm <code>AMI::getResource('{$modId}/form/view/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_AmiService_FormViewAdm extends Hyper_AmiClean_FormViewAdm{
    /**
     * Form view placeholders
     *
     * @var array
     */
    protected $aPlaceholders = array('#form', '#first', 'first', '#tabset', 'tabset', 'form');

    /**
     * Initialization.
     *
     * @return AMI_View
     */
    public function init(){
        global $db;
		require_once($GLOBALS["FUNC_INCLUDES_PATH"]."func_file_system.php");

        // get id
        $oRequest = AMI::getSingleton('env/request');
        $itemId = $oRequest->get('id', null);

        // time info
        $serverTimezone = date_default_timezone_get();
        date_default_timezone_set('Etc/GMT');
        $curTime = date(AMI::getDateFormat(AMI_Registry::get('lang', 'en'), AMI_Lib_Date::FMT_BOTH_ZONE));
        date_default_timezone_set($serverTimezone);
        $serverTime = date(AMI::getDateFormat(AMI_Registry::get('lang', 'en'), AMI_Lib_Date::FMT_BOTH_ZONE));
        $this
            ->addField(array('name' => 'time', 'value' => '', 'position' => 'first.after'))
            ->addField(array('name' => 'server_time', 'value' => $serverTime));

        // make tabs
        $this->addTabContainer('tabset', 'server_time.after');
		$this->addTab('cache', 'tabset', self::TAB_STATE_ACTIVE, 'tabset.end');
        $this->addTab('service', 'tabset', self::TAB_STATE_COMMON, 'tabset.end');
        // $this->addTab('gr_op', 'tabset', self::TAB_STATE_COMMON, 'tabset.end');

        // service tab
        $oUser = AMI::getSingleton('env/session')->getUserData();
        $aCookiesData = AMI::getSingleton('db')->fetchValue(DB_Query::getSnippet("SELECT data FROM cms_cookies WHERE id_member = %s")->plain($GLOBALS['_h']['uid']));
        //d::pr($aCookiesData);
        $cookiesDataSize = mb_strlen($aCookiesData, '8bit');
        $cookiesDataSize = number_format($cookiesDataSize/1024, 2, '.', '') . " Kb";

        $generatedFilesSize = 0;
        $generatedRootPath = AMI_Registry::get('path/root').AMI_Registry::get('CUSTOM_PICTURES_HTTP_PATH');
        $list = getDirFileList($generatedRootPath, '*', false, true);
        foreach($list as $dir){
            $curGeneratedDir = $generatedRootPath.$dir.'/generated/';
            if(is_dir($curGeneratedDir)){
                $generatedDir = dir($curGeneratedDir);
                if(is_object($generatedDir)){
                    while(false !== ($entry = $generatedDir->read())){
                        if(is_file($curGeneratedDir.$entry) && ($entry != "." && $entry != "..")){
                            $generatedFilesSize += filesize($curGeneratedDir.$entry);
                        }
                    }
                }
            }
        }
        if($generatedFilesSize/1024 < 1024){
                $generatedFilesSize = number_format($generatedFilesSize/1024, 2, '.', '') . " Kb";
        }else{
                $generatedFilesSize = number_format($generatedFilesSize/1048576, 2, '.', '') . " Mb";
        }

        $this
            ->addField(array('name' => 'service_action', 'type' => 'hidden', 'value' => ''))
            ->addField(array('name' => 'drop_user_cookie_data', 'value' => $cookiesDataSize, 'position' => 'service.end'))
            ->addField(array('name' => 'delete_generated', 'value' => $generatedFilesSize, 'position' => 'service.end'))
            ->addField(array('name' => 'repair', 'position' => 'service.end'))
            ->addField(array('name' => 'delete_demo_content', 'position' => 'service.end'))
            ->addField(array('name' => 'options_data', 'value' => '', 'position' => 'service.end'));

        // cache tab
        $oCore = $GLOBALS['Core'];
        $aInfo = $db->GetTableInfo("cms_cache_content");
        $vRows = $aInfo["rows"];
        $vAvgSize = $aInfo["avg_row_size"]/1048576;
        $vSize = number_format(($vAvgSize*$aInfo["rows"]), 2, '.', '');
        $vAvgSize = number_format($vAvgSize*1024, 2, '.', '');
        $limit = 0;
        $storageLimit = $oCore->Cache->StorageLimit;
        if($storageLimit){
            $limit = $storageLimit;
        }elseif(isset($GLOBALS['CONNECT_OPTIONS']['cache_storage_size'])){
            $limit = $GLOBALS['CONNECT_OPTIONS']['cache_storage_size'];
        }

        $expiredPages = AMI::getSingleton('db')->fetchValue(DB_Query::getSnippet('SELECT count(id) as expired FROM cms_cache WHERE date_expire < NOW()'));

        $cacheSize = ($vSize > 0 ? ' ~ ' : '') . $vSize . " Mb " . ($storageLimit > 0 ? (" (" . number_format($vSize/$storageLimit*100, 2, '.', '') . "%)" ) : "") . ', ' . $this->aLocale['cache_max_size'] . ":";
        $cachePages = $vRows . ", " . $this->aLocale['cache_expired'] . ": " . (int)$expiredPages . " (" .
            ($vRows > 0 ? number_format($expiredPages / $vRows * 100, 2, '.', '') : 0) . "%)";
        $cacheSizeInfo = $vAvgSize . " Kb";

        $this
            ->addField(array('name' => 'cache_size', 'value' => $cacheSize, 'position' => 'cache.end'))
            ->addField(array('name' => 'cache_size_link', 'value' => $storageLimit, 'position' => 'cache.end'))
            ->addField(array('name' => 'cache_pages', 'value' => $cachePages, 'position' => 'cache.end'))
            ->addField(array('name' => 'cache_size_info', 'value' => $cacheSizeInfo, 'position' => 'cache.end'));

        // get cache L3 info
        $aInfo = $db->GetTableInfo("cms_cache_blocks");
        $vRows = $aInfo["rows"];
        $vAvgSize = $aInfo["avg_row_size"]/1048576;
        $vSize = number_format(($vAvgSize*$aInfo["rows"]), 2, '.', '');
        $vAvgSize = number_format($vAvgSize*1024, 2, '.', '');

        $expiredBlocks = AMI::getSingleton('db')->fetchValue(DB_Query::getSnippet('SELECT count(id) as expired FROM cms_cache_blocks WHERE date_expire < NOW()'));

        $cacheL3Size = ($vSize > 0 ? ' ~ ' : '') . $vSize . " Mb " . ($limit > 0 ? ("(".(number_format($vSize/$limit*100, 2, '.', ''))."%)") : "");
        $cacheL3Pages = $vRows . ", " . $this->aLocale['cache_expired'] . ": " . $expiredBlocks . " (" .
            ($vRows > 0 ? number_format($expiredBlocks / $vRows * 100, 2, '.', '') : 0) . "%)";
        $cacheL3SizeInfo = $vAvgSize . " Kb";

        $this
            ->addField(array('name' => 'cache_l3_size', 'value' => $cacheL3Size, 'position' => 'cache.end'))
            ->addField(array('name' => 'cache_l3_pages', 'value' => $cacheL3Pages, 'position' => 'cache.end'))
            ->addField(array('name' => 'cache_l3_size_info', 'value' => $cacheL3SizeInfo, 'position' => 'cache.end'))
            ->addField(array('name' => 'cache_truncate', 'position' => 'cache.end'));

        $this->addField(
            array(
            'name'  => 'mod_action',
            'value' => 'form_save',
            'type'  => 'hidden'
            )
        );

		$this->addScriptCode($this->parse('javascript', $aScope = array('date_format' => AMI::getDateFormat(AMI_Registry::get('lang', 'en'), AMI_Lib_Date::FMT_BOTH_ZONE))));
        $this->addScriptFile('_admin/skins/vanilla/_js/ami_service.js');

        return parent::init();
    }
}

/**
 * AmiClean/AmiService configuration Repair Service component controller.
 *
 * @package    Config_AmiClean_AmiService
 * @subpackage Controller
 * @resource   {$modId}/form/controller/adm <code>AMI::getResource('{$modId}/service_repair/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_AmiService_RepairAdm extends Hyper_AmiClean_ComponentAdm{
    protected $useModel = FALSE;

    public function getType(){
        return 'repair';
    }

    /**
     * Returns true if component needs to be started always in full environment.
     *
     * @return bool
     */
    public function isFullEnv(){
        return TRUE;
    }
}

/**
 * AmiClean/AmiService configuration Repair Service component view.
 *
 * @package    Config_AmiClean_AmiService
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_AmiService_RepairViewAdm extends Hyper_AmiClean_ComponentViewAdm{
    /**
     * Initialize, processing after setting model.
     *
     * @return AMI_View
     */
    public function init(){
        return $this;
    }

    public function get(){
        $oRequest = AMI::getSingleton('env/request');
        $action = $oRequest->get('mod_action');
        $oRequest->set('action', $action);

        AMI::getSingleton('response')->setType('JSON');

        $aResult = array();
        switch($action){
            case 'repair':
            case 'grp_gen_keywords':
            case 'grp_gen_sublink':
                $aResult = $this->repair();
                break;
            case 'get_mod_actions':
                $aResult = $this->getModActions();
                break;
            default:
                trigger_error('Unknown action "' . $action . "'", E_USER_ERROR);
        }

        return $aResult;
    }

    /**
     * Runs 5.0 repair/generating actions.
     *
     * @return array
     */
    protected function repair(){
        global $Core, $adm, $db;

        $oRequest = AMI::getSingleton('env/request');
        $oRequest->set('action', $oRequest->get('mod_action'));
        $oResponse = AMI::getSingleton('response');

        $modId = $oRequest->get('target_mod_id', FALSE);
        if(!$Core->IsInstalled($modId)){
            trigger_error("Unknown module '" . $modId . "'", E_USER_ERROR);
        }

        $oModule = &$Core->GetModule($modId);
        $oModule->InitEngine($adm, $db);
        // trigger_error("Engine class is '" . get_class($oModule->Engine) . "'");###
        $oModule->Engine->suppressUrgency = TRUE;
        ### $oModule->Engine->setMappingUsage($hyper == 'ami_multifeeds5');

        $oModule->Engine->Init();
        $oModule->Engine->redirect = FALSE;

        foreach(
            array('_common_msgs.lng', '_categories_msgs.lng', '_categories_items_msgs.lng') as $locale
        ){
            $adm->AddMessages($adm->Gui->ParseLangFile('templates/lang/' . $locale));
        }

        $oModule->Engine->ProcessAction($adm->Vars['action'], 0);

        $aSysMessages = array();
        $aMessages = array();
        $adm->getStatusMsgArrays($aSysMessages, $aMessages);
        // d::vd($aMessages);###
        // $oResponse->write(json_encode($aMessages));###
        return array('messages' => $aMessages);
    }

    /**
     * Creates list of modules and supported actions.
     *
     * @return array
     */
    protected function getModActions(){
        global $Core, $adm, $db;

        $oDB = AMI::getSingleton('db');
        $aSupportedActions = array();
        $aTables = array();
        $aModIds = $Core->GetInstalledModuleNames();
        foreach($aModIds as $modId){
            if(preg_match('/_popup$/', $modId)){
                continue;
            }
            $oMod = $Core->getModule($modId);
            if(!$oMod->issetProperty('engine_classes')){
                continue;
            }
            $table = $oMod->GetTableName();
            if(FALSE === $table){
                continue;
            }
            if(isset($Tables[$table])){
                continue;
            }
            $Tables[$table] = TRUE;
            $oQuery =
                DB_Query::getSnippet(
                    "SHOW TABLES LIKE %s"
                )
                ->q($table);
            $aRecord = $oDB->fetchRow($oQuery);
            if(!is_array($aRecord)){
                continue;
            }
            $aSupportedActions[$modId] = array();
            $aFields = array();
            $sql = "DESCRIBE `" . $table . "`";
            $oRS = $oDB->select($sql, MYSQL_ASSOC, DBC_RAW_QUERY);
            foreach($oRS as $aItem){
                // var_dump($aItem);die;###
                $aFields[$aItem['Field']] = TRUE;
            }
            // trigger_error($table . "\n" . print_r($aFields, TRUE));###
            if(isset($aFields['position'])){
                $aSupportedActions[$modId][] = array(
                    'action' => 'repair',
                    'type'   => 'positions'
                );
            }
            if(
                isset($aFields['count_childs']) ||
                isset($aFields['num_items'])
            ){
                $aSupportedActions[$modId][] = array(
                    'action' => 'repair',
                    'type'   => 'counters'
                );
            }
            if(isset($aFields['hs_cat'])){
                $aSupportedActions[$modId][] = array(
                    'action' => 'repair',
                    'type'   => 'search_hash'
                );
            }
            if(isset($aFields['sm_data'])){
                $aSupportedActions[$modId][] = array(
                    'action'     => 'grp_gen_keywords',
                    'grp_target' => 'all'
                );
            }
            if(isset($aFields['sublink'])){
                $aSupportedActions[$modId][] = array(
                    'action'     => 'grp_gen_sublink',
                    'grp_target' => 'all'
                );
            }
            if(!sizeof($aSupportedActions[$modId])){
                unset($aSupportedActions[$modId]);
            }###
            /*
            else{
                $aSupportedActions[$modId][] = $table;###
            }
            */
        }
        foreach(array(
            'eshop_files', 'eshop_view',
            'kb_files', 'kb_view',
            'portfolio_files', 'portfolio_view',
            'files_import', 'forum_data_exchange', 'pay_drivers'
        ) as $modId){
            unset($aSupportedActions[$modId]);
        }
        $aCaptions = AMI_Service_Adm::getModulesCaptions(
            array_keys($aSupportedActions),
            TRUE,
            array(),
            TRUE,
            TRUE
        );
        $aResult = array();
        foreach($aCaptions as $modId => $caption){
            $aResult[] = array(
                'modId'   => $modId,
                'caption' => $caption,
                'actions' => $aSupportedActions[$modId]
            );
        }

        // d::vd($aSupportedActions);###
        // AMI::getSingleton('response')->write(json_encode($aSupportedActions));###
        return array('supportedActions' => $aResult);
    }
}

