<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiClean_Pages 
 * @version    $Id$ 
 * @size       21252 xkqwlwsqlwkgiltlmztitgiwgkqtzgigynungxlwyzpuqsystixwlymtrxwppimnipxwpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiClean/Pages configuration front action controller.
 *
 * @package    Config_AmiClean_Pages
 * @subpackage Controller
 * @resource   {$modId}/module/controller/frn <code>AMI::getResource('{$modId}/module/controller/frn')*</code>
 * @amidev     temporary
 */
class AmiClean_Pages_Frn extends Hyper_AmiMultifeeds_Frn{
    /**
     * Constructor.
     *
     * @param AMI_Request  $oRequest   Request
     * @param AMI_Response $oResponse  Response
     */
    public function __construct(AMI_Request $oRequest, AMI_Response $oResponse){
        // Old sites has 'ext_images' extension turned on (god mode only)
        $aExt = AMI::getOption('pages', 'extensions');
        if(is_array($aExt)){
            $index = array_search('ext_images', $aExt);
            if(FALSE !== $index){
                unset($aExt[$index]);
                AMI::setOption('pages', 'extensions', $aExt);
            }
        }

        parent::__construct($oRequest, $oResponse);
    }
}

/**
 * AmiClean/Pages configuration EDP mode form component controller.
 *
 * @package    Config_AmiClean_Pages
 * @subpackage Controller
 * @resource   {$modId}/form/controller/frn <code>AMI::getResource('{$modId}/form/controller/frn')*</code>
 * @amidev     temporary
 */
class AmiClean_Pages_FormFrn extends Hyper_AmiMultifeeds_FormFrn{
    /**
     * Save action dispatcher.
     *
     * @param  array &$aEvent  Event data
     * @return void
     */
    protected function _save(array &$aEvent){
        $oRequest = AMI::getSingleton('env/request');
        $id = $oRequest->get('id', 0);
        $sourcePageId = $oRequest->get('source_page_id', 0);
        if(!$id && !$sourcePageId){
            trigger_error('Main page cannot be created in EDP mode', E_USER_ERROR);
            /*
            $oResponse = $aEvent['oResponse'];
            $oResponse->setMessage('form_item_not_created', self::SAVE_FAILED);
            $oResponse->addStatusMessage('status_create_main_page_forbidden', array(), AMI_Response::STATUS_MESSAGE_ERROR);
            AMI_Event::fire('dispatch_mod_action_form_edit', $aEvent, $this->getModId());

            return;
            */
        }

        $aDefaultPageIds = AMI_PageManager::getDefaultPageIds();

        // always 'pages' (static page) module
        // $oRequest->set('id_mod', 'pages');

        // always public for main pages
        if(in_array($id, $aDefaultPageIds)){
            $oRequest->set('public', 1);
        }

        if(!$id && $sourcePageId){
            $oTable = AMI::getResourceModel($this->getModId() . '/table');
            $oParentItem = $oTable->find($sourcePageId);
            if(!$oParentItem){
                trigger_error('Source page having Id ' . $sourcePageId . ' not found', E_USER_ERROR);
            }
            $isParentMain = in_array($sourcePageId, $aDefaultPageIds);

            // copy layot blocks
            for($layBlockIndex = 1; $layBlockIndex <= 10; ++$layBlockIndex){
                $field = 'lay_f' . $layBlockIndex . '_body';
                $oRequest->set($field, $oParentItem->{$field});
            }

            // make parent Id & all parent Ids fields
            $addMode = $oRequest->get('add_mode', '');
            switch($addMode){
                case 'neighbor':
                    if($isParentMain){
                        trigger_error('Main page cannot have neighbors', E_USER_ERROR);
                    }
                    foreach(array('id_parent', 'all_parents') as $field){
                        $oRequest->set($field, $oParentItem->$field);
                    }

                    // patch position
                    AMI_Event::addHandler(
                        'on_after_save_model_item',
                        array($this, 'handleAfterSaveItemModelOnCreate'),
                        $this->getModId()
                    );
                    break; // case 'neighbor'
                case 'child':
                    $oRequest->set('id_parent', $sourcePageId);
                    $aParents = $oParentItem->all_parents ? explode(',', $oParentItem->all_parents) : array();
                    $aParents[] = $sourcePageId;
                    $aParents = array_unique(array_map('intval', $aParents));
                    $oRequest->set('all_parents', implode(',', $aParents));
                    break; // case 'child'
                default:
                    trigger_error('Unknown mode to add "' . $addMode . '"', E_USER_ERROR);
            }
            foreach(array('id_layout', 'sb_data') as $field){
                $oRequest->set($field, $oParentItem->$field);
            }
        }

        parent::_save($aEvent);
    }

    /**
     * Event handler.
     *
     * Updates new page position.
     *
     * @param  string $name          Event name
     * @param  array  $aEvent        Event data
     * @param  string $handlerModId  Handler module id
     * @param  string $srcModId      Source module id
     * @return array
     * @see    AMI_Event::addHandler()
     * @see    AMI_Event::fire()
     * @see    AMI_ModTableItemModifier::save()
     */
    public function handleAfterSaveItemModelOnCreate($name, array $aEvent, $handlerModId, $srcModId){
        if($aEvent['onCreate']){
            $oParentItem =
                $aEvent['oTable']
                ->find(
                    $aEvent['oItem']->id_parent,
                    array('id', 'position', 'all_parents')
                );
            $aParentIds = explode(',', $oParentItem->all_parents);
            if(sizeof($aParentIds) < 2){
                $mainNodeId = $aEvent['oItem']->id_parent;
            }else{
                $mainNodeId = $aParentIds[0] ? $aParentIds[0] : $aParentIds[1];
            }
            if($mainNodeId != $aEvent['oItem']->id_parent){
                $oList =
                    $aEvent['oTable']
                    ->getList()
                    ->addColumns(array('id', 'position'))
                    ->addSearchCondition(array('id_parent' => $mainNodeId))
                    ->addWhereDef('AND `position` > ' . $oParentItem->position)
                    ->addOrder('position', 'DESC')
                    ->load();
                $aPositions = Array();
                foreach($oList as $oItem){
                    $aPositions[$oItem->id] = $oItem->position;
                    $newPosition = $oItem->position;
                }
                $oDB = AMI::getSingleton('db');
                foreach($aPositions as $id => $position){
                    $oQuery = DB_Query::getUpdateQuery(
                        $aEvent['oTable']->getTableName(),
                        array('position' => $newPosition),
                        'WHERE `id` = ' . $id
                    );
                    $newPosition = $position;
                    $oDB->query($oQuery);
                }
            }
        }

        return $aEvent;
    }
}

/**
 * AmiClean/Pages configuration EDP mode form component view.
 *
 * @package    Config_AmiClean_Pages
 * @subpackage View
 * @resource   {$modId}/form/view/frn <code>AMI::getResource('{$modId}/form/view/frn')*</code>
 * @amidev     temporary
 */
class AmiClean_Pages_FormViewFrn extends Hyper_AmiMultifeeds_FormViewFrn{
    /**
     * Used tabs list
     *
     * @var array
     */
    protected $aUsedTabs = array('body', 'options');

    /**
     * Form default elements template (placeholders)
     *
     * @var array
     */
    protected $aPlaceholders = array(
        '#form',
            'add_mode',
            'id_mod',
            'header',
            'sublink',

            '#default_tabset',

                '#body_tab', 'body', 'body_tab',

                '#navi_tab',

                    '#common',
                        'is_section',
                        'is_printable',
                        'skip_search',
                    'common',

                    '#navigation',
                        'show_in_sitemap',
                        'show_at_parent',
                        'show_siblings',
                    'navigation',

                    '#menu',
                        'menu_main',
                        'menu_top',
                        'menu_bottom',
                    'menu',

                    '#extra',
                        'noindex_link',
                    'extra',

                'navi_tab',

                '#options_tab',
                    'html_title_inherit',
                    'disable_comments',
                    'html_title', 'html_keywords', 'html_description',
                    'html_head_code',
                    'noindex_page',
                'options_tab',

            'default_tabset',
            'public',
        'form'
    );

    /**
     * Prepares templates paths and blockname.
     *
     * @return void
     * @amidev
     */
    protected function prepareTemplates(){
        parent::prepareTemplates();

        $oTpl = $this->getTemplate();
        $oTpl->mergeBlock($this->tplBlockName, dirname($this->tplFileName) . '/pages_form.tpl');
        $this->aLocale = $oTpl->parseLocale(dirname($this->localeFileName) . '/pages_form.lng') + $this->aLocale;
    }

    /**
     * Initialization.
     */
    public function init(){
        parent::init();

        // form

        $this->addField(array('name' => 'header', 'validate' => array('filled', 'stop_on_error')));

        $oRequest = AMI::getSingleton('env/request');
        $aDefaultPageIds = AMI_PageManager::getDefaultPageIds();
        $pageId =$oRequest->get('pageId');
        /*
        if(!$pageId){
            $pageId = AMI::getSingleton('env/request')->get('id');
        }
        */
        $singleRow = in_array($pageId, $aDefaultPageIds);
        if($singleRow){
            if(in_array($oRequest->get('id', FALSE), $aDefaultPageIds)){
                $this->addField(array(
                    'name'       => 'public',
                    'type'       => 'checkbox',
                    'attributes' => array('disabled' => 'yes')
                ));
            }
            $this->addField(array(
                'name'  => 'add_mode',
                'type'  => 'hidden',
                'value' => 'child'
            ));
        }else{
            $aRadio = array();
            $aRadio[]  = array(
                'id'       => 'radio_add_mode_neighbor',
                'value'    => 'neighbor',
                'caption'  => 'add_mode_neighbor'
            );
            $aRadio[] = array(
                'id'       => 'radio_add_mode_child',
                'value'    => 'child',
                'caption'  => 'add_mode_child'
            );
            $this->addField(array(
                'name'              => 'add_mode',
                'display_by_action' => 'new',
                'type'              => 'radio',
                'data'              => $aRadio,
                'value'             => $singleRow ? 'child' : 'neighbor'
            ));
        }

        $modId = $oRequest->get('id_mod');
        if(!$oRequest->get('id', FALSE) || !$modId){
            $modId = 'pages';
        }
        $this->addField(array(
            'name'  => 'id_mod',
            'type'  => 'select',
            'data'  => $this->getModList('admin_menu_caption', ' : ', $modId),
            'value' => $modId /*,
            'not_selected' => array(
                'id'   => 'pages',
                'name' => $this->aLocale['static_page']
            ), */
        ));

        $this->addField(array(
            'name'  => 'source_page_id',
            'type'  => 'hidden',
            'value' => $pageId
        ));

        // navi tab
        $this->addTab('navi_tab', 'default_tabset', self::TAB_STATE_COMMON, 'options_tab.before');

        $this->addSection('common');
        $this->addField(array('name' => 'is_section',      'type' => 'checkbox', 'position' => 'common.end', 'marker' => 'navigation'));
        $this->addField(array('name' => 'is_printable',    'type' => 'checkbox', 'position' => 'common.end', 'marker' => 'navigation'));
        $this->addField(array('name' => 'skip_search',     'type' => 'checkbox', 'position' => 'common.end', 'marker' => 'navigation'));

        $this->addSection('navigation');
        $this->addField(array('name' => 'show_in_sitemap', 'type' => 'checkbox', 'position' => 'navigation.end', 'default_checked' => TRUE, 'marker' => 'navigation'));
        $this->addField(array('name' => 'show_at_parent',  'type' => 'checkbox', 'position' => 'navigation.end', 'marker' => 'navigation'));
        $this->addField(array('name' => 'show_siblings',   'type' => 'checkbox', 'position' => 'navigation.end', 'marker' => 'navigation'));

        $this->addSection('menu');
        $this->addField(array('name' => 'menu_main',       'type' => 'checkbox', 'position' => 'menu.end', 'marker' => 'navigation'));
        $this->addField(array('name' => 'menu_top',        'type' => 'checkbox', 'position' => 'menu.end', 'marker' => 'navigation'));
        $this->addField(array('name' => 'menu_bottom',     'type' => 'checkbox', 'position' => 'menu.end', 'marker' => 'navigation'));

        $this->addSection('extra');
        $this->addField(array('name' => 'noindex_link',    'type' => 'checkbox', 'position' => 'extra.end', 'marker' => 'navigation'));

        // options and seo tab
        $this->addField(array(
            'name' => 'html_title_inherit',
            'type' => 'checkbox'
        ));
        $this->dropField('date_created');

        $this->addField(array(
            'name' => 'html_head_code',
            'type' => 'textarea'
        ));
        $this->addField(array('name' => 'noindex_page', 'type' => 'checkbox', 'position' => 'html_head_code.after'));

        $this->dropField('details_noindex');
    }

    protected function getModList($captionName = 'admin_menu_caption', $splitter = ' : ', $activeModId = ''){
        global $Core, $cms;

        $Core->OwnersAllSetOption('menu_name', $this->aLocale);

        $oTpl = $this->getTemplate();
        /*
        $Core->OwnersAllSetOption('admin_menu_caption', $MenuItemsAll);
        $oTpl = $this->getTemplate();
        $MenuItemsAll = $this->GetOwnersCustomLang('templates/%slang/_menu_all.lng');
        */
        $aMenuCaptions = $oTpl->parseLocale(AMI_Skin::getPath('templates/lang/_menu_all.lng'));
        $aMenuCaptions =
            $oTpl->parseLocale('_local/_admin/templates/lang/modules/_menu.lng') +
            $aMenuCaptions;
        $aMenuCaptions =
            $oTpl->parseLocale('_local/_admin/templates/lang/modules/_headers.lng') +
            $aMenuCaptions;
        foreach(array_keys($aMenuCaptions) as $key){
            $aMenuCaptions[$key] = mb_convert_case($aMenuCaptions[$key], MB_CASE_TITLE);
        }
        // d::vd($aMenuCaptions);
        $Core->ModAllSetOption('admin_menu_caption', $aMenuCaptions);

        $aMenu = array();
        $aFirstModule = array();
        $unknown = 'unknown';

        $aNoShowOwners = AMI::getOption('pages', 'dont_show_owners_in_list');
        $bShowUsed = AMI::getOption('pages', 'show_used_modules');
        $bShowNotInstalledButActive = true;
        $vFirstModName = AMI::getOption('pages', 'first_module');

        $modlist = &$Core->GetAllModules();

        // Get audit special mode type
        $useAuditModules = false;
        if($Core->IsInstalled('srv_audit')){
            $mAuditModule = &$Core->GetModule('srv_audit');
            if($mAuditModule->GetOption('audit_front')){
                $useAuditModules = true;
            }
        }

        $isMultiPageAllowed = AMI::issetAndTrueOption('core', 'multi_page_allowed');

        $oDeclarator = AMI_ModDeclarator::getInstance();
        foreach(array_keys($modlist) as $vModName){
            $vMod = &$modlist[$vModName];
            $isMultiPage = $vMod->IsInstalled() && $vMod->issetAndTrueOption('multi_page');
            $vFrontAllowed = $vMod->IsFrontAllowed();
            $vIsActive = ($vModName == $activeModId);
            $vItemData = array();

            $isMultiPageMod =
                $vMod->IsPresentInPM() &&
                !$vMod->IsVirtual() &&
                !$vMod->issetAndTrueProperty('allow_double_in_pm');
            if(
                (
                    !($vMod->IsInstalled() && $vFrontAllowed) ||
                    (
                        !$vIsActive && !$bShowUsed && $isMultiPageMod &&
                        !($isMultiPageAllowed && $isMultiPage)
                    )
                ) &&
                    !($vFrontAllowed && $bShowNotInstalledButActive && $vIsActive)
                ||
                    $vMod->issetAndTrueProperty('dont_show_in_pm') ||
                    (!$vIsActive && preg_match('/^(eshop|portfolio|kb)_home$/', $vModName))
            ){
                // #CMS-11373 {
                if(
                    $vMod->IsInstalled() &&
                    ($isMultiPage && $isMultiPageMod) &&
                    !$vMod->issetAndTrueProperty('dont_show_in_pm')
                ){
                    if(!$Core->GetOption('allow_multi_lang')){
                        $vItemData['disabled'] = 1;
                        continue;
                    }
                }elseif(!$vMod->IsInstalled() && $vFrontAllowed && $oDeclarator->isRegistered($vModName)){
                    list($hyper, ) = $oDeclarator->getHyperData($vModName);
                    if('ami_multifeeds' !== $hyper){
                        continue;
                    }
                    $vItemData['disabled'] = 1;
                    continue;

                    // } #CMS-11373
                }else{
                    continue;
                }
            }

            $parent = $vMod->GetParentName();

            if(
                !$useAuditModules &&
                ('srv_audit' == $parent || 'adv_campaign_types' == $vModName)
            ){
                continue;
            }

            $vItemData['id'] = $vModName;
            if('pages' == $vModName){
                continue;
            }
            $vItemData['name'] = $cms->GetModHeader($vMod, $captionName, $unknown);
            $owner = $vMod->GetOwnerName();
            // $owner = $vMod->GetOwnerName();
            // $vItemData['admin_link'] = $vMod->GetAdminLink();
            $vItemData['attributes'] = array('is_installed' => $vMod->IsInstalled());

            if(!empty($parent)){
                $tmpMod = &$modlist[$parent];
                if(
                    $tmpMod->IsInstalled() &&
                    $tmpMod->IsFrontAllowed() &&
                    !preg_match('/^(eshop|kb}|po)_view$/', $vModName)
                ){
                    $tmpCaption = ($tmpMod->issetOption($captionName) ? $tmpMod->GetOption($captionName) : $unknown);
                    if(FALSE === mb_strripos($vItemData['name'], $tmpCaption)){
                        $vItemData["name"] = $tmpCaption . $splitter . $vItemData['name'];
                    }
                    // $vItemData["owner"] = $tmpMod->GetOwnerName();
                }
            }
            if(!in_array($owner, $aNoShowOwners)){
                $tmpName = $this->aLocale[$owner];
                // $tmpName = $Core->OwnerGetData($owner, $captionName);
                if(empty($tmpName)){
                    // d::vd($tmpName, "{$owner}, {$captionName}");###
                    $tmpName = $unknown;
                }
                if(FALSE === mb_strripos($vItemData['name'], $tmpName)){
                    $vItemData['name'] = $tmpName . $splitter . $vItemData['name'];
                }
            }

            if($vItemData['name'] == $vFirstModName){
                $aFirstModule[] = $vItemData;
            } else {
                $aMenu[] = $vItemData;
            }
        } // foreach item
        if(sizeof($aMenu)){
            AMI_Lib_Array::sortMultiArray($aMenu, 'name');
        }

        if(sizeof($aFirstModule)){
            array_unshift($aMenu, $aFirstModule[0]);
        }
        array_unshift(
            $aMenu,
            array(
                'id' => 'pages',
                'name' => $this->aLocale['static_page']
            )
        );

        return $aMenu;
    }

    /*
    protected function GetOwnersCustomLang($cFormat){
        $oTpl = $this->getTemplate();
        $aRes = $oTpl->parseLocale(sprintf($cFormat, ''));
        $aOwners = AMI::getOption('core', 'custom_owners');
        if(!is_array($aOwners)){
            $aOwners = array($aOwners);
        }
        foreach ($aOwners as $owner){
            $aCustom = $oTpl->parseLocale(sprintf($cFormat, $owner . '/'));
            if(is_array($aCustom)){
                $aRes = array_merge($aRes, $aCustom);
            }
        }

      return $aRes;
    }
    */
}
