<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiClean_Pages 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       23775 xkqwwtywgmllxpmqzmlkzsgklylkngssgxkxnumkmppitrykgumuutgwrxxmiskirsgmpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiClean/Pages configuration table item model modifier.
 *
 * @package    Config_AmiClean_Pages
 * @subpackage Model
 * @resource   {$modId}/table/model/item/modifier <code>AMI::getResourceModel('{$modId}/table')->getItem()->getModifier()*</code>
 * @since      x.x.x
 * @amidev     temporary
 */
class Pages_TableItemModifier extends Hyper_AmiMultifeeds_TableItemModifier{
    /**
     * Constructor.
     *
     * @param AMI_ModTable     $oTable      Module table model
     * @param AMI_ModTableItem $oTableItem  Module table item model
     */
    public function __construct(AMI_ModTable $oTable, AMI_ModTableItem $oTableItem){
        $this->metaResId = 'pages/' . $this->metaResId;

        parent::__construct($oTable, $oTableItem);

        AMI_Event::addHandler(
            'on_before_save_model_item',
            array($this, 'handleBeforeSaveItemModel'),
            $this->oTableItem->getModId()
        );
    }

    /**#@+
     * Event handler.
     *
     * @see AMI_Event::addHandler()
     * @see AMI_Event::fire()
     * @see AMI_ModTableItemModifier::save()
     */

    /**
     * Creates/updates module table item model meta data.<br />
     * Manipulates layout related data.
     *
     * @param  string $name          Event name
     * @param  array  $aEvent        Event data
     * @param  string $handlerModId  Handler module id
     * @param  string $srcModId      Source module id
     * @return array
     */
    public function handleBeforeSaveItemModel($name, array $aEvent, $handlerModId, $srcModId){
        if($aEvent['onCreate']){
            $this->handleBeforeSaveItemModelOnCreate($aEvent);
        }else{
            $this->handleBeforeSaveItemModelOnUpdate($aEvent);
            /*
            trigger_error('Model saving temporary forbidden!');###
            $aEvent['_discard'] = TRUE;###
            $aEvent['_break_event'] = TRUE;###
            */
        }

        return $aEvent;
    }

    /**
     * Updates new page position.
     *
     * @param  string $name          Event name
     * @param  array  $aEvent        Event data
     * @param  string $handlerModId  Handler module id
     * @param  string $srcModId      Source module id
     * @return array
     */
    public function handleAfterSaveItemModelOnCreate($name, array $aEvent, $handlerModId, $srcModId){
        // drop handlers, arguments affect nothing
        $this->handleRollbackSaveItemModelOnCreate($name, $aEvent, $handlerModId, $srcModId);

        $aEvent['oItem']->position = $aEvent['oItem']->getId();
        $aEvent['oItem']->save();

        return $aEvent;
    }

    /**
     * Drops 'on_after_save_model_item', 'on_rollback_save_model_item' event handlers.<br />
     * Manipulates layout related data.
     *
     * @param  string $name          Event name
     * @param  array  $aEvent        Event data
     * @param  string $handlerModId  Handler module id
     * @param  string $srcModId      Source module id
     * @return array
     */
    public function handleRollbackSaveItemModelOnCreate($name, array $aEvent, $handlerModId, $srcModId){
        AMI_Event::dropHandler('on_after_save_model_item', $this);
        AMI_Event::dropHandler('on_rollback_save_model_item', $this);

        return $aEvent;
    }

    /**#@-*/

    /**
     * Runs on creating page.
     *
     * @param  array &$aEvent  Event data
     * @return void
     */
    protected function handleBeforeSaveItemModelOnCreate(array &$aEvent){
        global $Core;

        $aData = $aEvent['aData'];
        $parentId = empty($aData['id_parent']) ? 0 : (int)$aData['id_parent'];
        $layoutId = empty($aData['id_layout']) ? 0 : (int)$aData['id_layout'];
        $siteId = 0;
        $body = '';
        $modId = empty($aData['id_mod']) ? 'pages' : $aData['id_mod'];
        // Load parent sublink
        if($parentId){
            $oParentItem = $this->oTable->find(
                $parentId,
                array('id', 'lang', 'all_parents')
            );
        }else{
            $oParentItem = $this->oTable->findByFields(
                array(
                    'lang'      => AMI_Registry::get('lang_data'),
                    'id_parent' => 0
                ),
                array('id', 'lang', 'all_parents')
            );
        }
        if($oParentItem->getId()){
            $parentId = $oParentItem->getId();
            $locale = $oParentItem->lang;
        }else{
            $this->oValidatorException =
                new AMI_ModTableItemException(
                    $parentId
                        ? 'Parent id ' . $parentId . ' not found'
                        : "Default parent page for locale '" . $locale . "' not found",
                    AMI_ModTableItemException::ACTION_DISCARDED
                );
            throw $this->oValidatorException;
        }

        // set site Id
        if($Core->IsInstalled('srv_multi_sites')){
            $sideId = empty($aData['id_side']) ? $oItem->id_site : (int)$aData['id_side'];
        }
        // Set default body content
        if($Core->IsFrontAllowed($modId)){
            if('pages' != $modId){
                $body = '##spec_module_body##';
            }
        }else{
            $modId = 'pages';
        }

        // find layout
        $oLayoutItem = NULL;
        $oQuery = DB_Query::getSnippet(
            "SELECT * " .
            "FROM `cms_layouts` " .
            "WHERE " .
                "`lang` = %s AND " .
            ($layoutId
                ? "`id` = " . $layoutId
                :
                    "`hidden` = 0 " .
                    "ORDER BY `is_default` DESC " .
                    "LIMIT 1"
            )
        )
        ->q($locale);
        $aRecord = AMI::getSingleton('db')->fetchRow($oQuery);
        if($aRecord){
            $oLayoutItem =
                AMI::getResourceModel('layouts/table')
                ->getItem()
                ->setData($aRecord);
            $layoutId = (int)$aRecord['id'];
        }else{
            $this->oValidatorException =
                new AMI_ModTableItemException(
                    'Layout ' . $layoutId . ' not found',
                    $layoutId
                        ? 'Layout having Id ' . $layoutId . ' not found'
                        : "Default layout for locale '" . $locale . "' not found",
                    AMI_ModTableItemException::ACTION_DISCARDED
                );
            throw $this->oValidatorException;
        }

        // calculate protected layout blocks
        if(isset($aData['block_mask'])){
            $mask = (int)$aData['block_mask'];
            $blocksNumber = AMI::getProperty('pages', 'template_blocks_number');
            for($i = 0; $i < $blocksNumber; ++$i){
                $field = 'lay_f' . ($i + 1) . '_body';
                if((1 << $i) & $mask){
                    if(!isset($aData[$field])){
                        $aData[$field] = $oLayoutItem->{$field};
                    }
                }else{
                    $aData[$field] = $oLayoutItem->{$field};
                }
            }
        }

        // get all parents
        $aParents = $oParentItem->all_parents ? explode(',', $oItem->all_parents) : array();
        $aParents[] = $parentId;
        $aParents = array_unique(array_map('intval', $aParents));
        $aData['all_parents'] = implode(',', $aParents);

        // patch data
        $aEvent['aData'] =
            array(
                'id_parent' => $parentId,
                'id_layout' => $layoutId,
                'id_site'   => $siteId,
                'id_mod'    => $modId,
                'data'      => $this->getLayoutSpecblocskData($layoutId)
            ) +
            $aData +
            array(
                'tpl_addon' => '',
                'dest_link' => ''
            );
        if(isset($aEvent['aData']['body'])){
            if($body && FALSE === mb_strpos($aEvent['aData']['body'], $body)){
                $aEvent['aData']['body'] .= $body;
            }
        }else{
            $aEvent['aData']['body'] = $body;
        }

        // add handler to setup position after saving
        if(empty($aData['position'])){
            AMI_Event::addHandler(
                'on_after_save_model_item',
                array($this, 'handleAfterSaveItemModelOnCreate'),
                $this->oTableItem->getModId(),
                AMI_Event::PRIORITY_HIGH
            );
            AMI_Event::addHandler(
                'on_rollback_save_model_item',
                array($this, 'handleRollbackSaveItemModelOnCreate'),
                $this->oTableItem->getModId()
            );
        }
    }

    /**
     * Runs on updating page.
     *
     * @param  array &$aEvent  Event data
     * @return void
     */
    protected function handleBeforeSaveItemModelOnUpdate(array &$aEvent){
        global $Core;

        $aData = $aEvent['aData'];
        $layoutId = isset($aData['id_layout']) ? (int)$aData['id_layout'] : 0;

        // validate module Id
        if(!empty($aData['id_mod'])){
            $modId = $aData['id_mod'];
            if('redirect' == $aData['id_mod']){
                $modId = 'pages';
            }
            if(!$Core->IsFrontAllowed($modId)){
                // Module not allowed at front
                unset($aData['id_mod']);
                trigger_error("Module '" . $modId . "' isn't allowed at front, changing discarded");
            }else{
                $aData['id_mod'] = $modId;
            }
        }

        // check for main page
        if(isset($aData['id_parent'])){
            $parentId = (int)$aData['id_parent'];
            if(!$parentId){
                $aData['public'] = 1;
                $aData['show_at_parent'] = 1;
            }
        }

        // specblocks data, 'data' and 'block_mask' both must be present to correct update
        /*
         * @todo: Менять незащищенные опции / блоки всем шаблонам макета
         */

        $blocksNumber = AMI::getProperty('pages', 'template_blocks_number');
        if(isset($aData['id_layout']) && isset($aData['block_mask'])){
            $layoutId = (int)$aData['id_layout'];
            $oLayoutItem =
                AMI::getResourceModel('layouts/table')
                ->findByFields(
                    array(
                        'id'   => $layoutId,
                        'lang' => AMI_Registry::get('lang_data')
                    )
                );
            if(!$oLayoutItem->getId()){
                $this->oValidatorException =
                    new AMI_ModTableItemException(
                        'Layout having id ' . $layoutId . ' not found',
                        AMI_ModTableItemException::ACTION_DISCARDED
                    );
                throw $this->oValidatorException;
            }
            $aOriginFieldsStruct = $aEvent['oItem']->getOriginFieldsStruct();
            $aOriginData = $aEvent['oItem']->getOriginData();
            $aChangedFields = array();
            foreach($aOriginFieldsStruct as $field => $isHashed){
                if(
                    isset($aData[$field]) &&
                    (
                        $isHashed
                            ? $aOriginData[$field] !== md5($aData[$field])
                            : $aOriginData[$field] != $aData[$field]
                    )
                ){
                    $aChangedFields[] = $field;
                }
            }
            $mask = (int)$aData['block_mask'];
            $aLayoutSpecblocksData = $this->getLayoutSpecblocskData($layoutId);
            if(isset($aData['data'])){
                $aData['data'] = unserialize($aData['data']);
                if(!is_array($aData['data'])){
                    $aData['data'] = array();
                }
                $aPageSpecblocksData = $aData['data'];
            }
            $aPageSpecBlocks = array();
            $aLayoutSpecBlocks = array();
            $aForceOptions = array();
            $layoutModifed = FALSE;
            $aNewBlocks = array();
            for($i = 0; $i < $blocksNumber; ++$i){
                $field = 'lay_f' . ($i + 1) . '_body';
                if(
                    !((1 << $i) & $mask) && // common block
                    (
                        !in_array($field, $aChangedFields) || // not modified
                        ($aOriginData['block_mask'] & (1 << $i)) // was protected
                    )
                ){
                    $aData[$field] = $oLayoutItem->{$field};

                    foreach($aLayoutSpecblocksData as $aOptionsKey => $aOptionsValue){
                        $specblock = mb_ereg_replace('(_[0-9]+)', '', $aOptionsKey);
                        $sBlockNum = mb_substr($aOptionsKey, mb_strlen($specblock) + 4, 3);
                        $iBlockNum = intval($sBlockNum);
                        if($iBlockNum == $i){
                            $aForceOptions[$aOptionsKey] = $aLayoutSpecblocksData[$aOptionsKey];
                        }
                    }
                }
                if(
                    in_array($field, $aChangedFields) || // modified
                    !($mask & (1 << $i))                 // common block
                ){
                    $layoutModifed = $layoutModifed || in_array($field, $aChangedFields);
                    $aNewBlocks[$field] = $aData[$field];
                }
                if(
                    isset($aData['lay_f' . $i . '_body']) &&
                    preg_match_all(
                        '/##(spec_.*?)##/i',
                        $aData['lay_f' . $i . '_body'],
                        $aSpecBlocks
                    )
                ){
                    if(!($mask & (1 << $i))){ // common block
                        $aLayoutSpecBlocks = array_merge($aLayoutSpecBlocks, $aSpecBlocks[1]);
                    }
                    $aPageSpecBlocks = array_merge($aPageSpecBlocks, $aSpecBlocks[1]);
                }
            }
            if(
                isset($aData['body']) &&
                preg_match_all('/##(spec_.*?)##/i', $aData['body'], $aSpecBlocks)
            ){
                $aPageSpecBlocks = array_merge($aPageSpecBlocks, $aSpecBlocks[1]);
            }

            $aLayoutSpecBlocksRemove = array();
            $aPageSpecBlocksRemove = array();
            $aSBData = isset($aData['data']) ? $aData['data'] : array();
            if(isset($aOriginData['data'])){
                $aOriginData['data'] = unserialize($aOriginData['data']);
                if(is_array($aOriginData['data'])){
                    foreach($aOriginData['data'] as $aSBDataKey => $aSBDataValue){
                        if(!in_array($aSBDataKey, $aPageSpecBlocks)){
                            $specblock = mb_ereg_replace('(_[0-9]+)', '', $aSBDataKey);
                            $sSpecNum = mb_substr($aSBDataKey, mb_strlen($specblock) + 1, 3);
                            $sBlockNum = mb_substr($aSBDataKey, mb_strlen($specblock) + 4, 3);
                            if($sBlockNum == '000'){
                                // unset in body
                                $aPageSpecBlocksRemove[] = $aSBDataKey;
                            }else{
                                $iBlockNum = intval($sBlockNum);
                                $bBlockProtected = ($aData['block_mask'] & ( 1 << ($iBlockNum - 1)));
                                if(!$bBlockProtected){
                                    // unset in block
                                    $aLayoutSpecBlocksRemove[] = $aSBDataKey;
                                } else {
                                    // unset in protected block
                                    $aPageSpecBlocksRemove[] = $aSBDataKey;
                                }
                            }
                            unset($aSBData[$aSBDataKey]);
                        }
                    }
                }
            }
            // @todo: detect isset & is_array usage necessity,
            // probably should define $aForceOptions at appropriate place
            if(isset($aForceOptions) && is_array($aForceOptions)){
                $aSBData = array_merge($aSBData, $aForceOptions);
            }
        }else{
            $aDiscardedFields = array();
            $aFields = array('data');
            for($i = 1; $i <= $blocksNumber; ++$i){
                $aFields[] = 'lay_f' . $i . '_body';
            }
            foreach($aFields as $field){
                if(isset($aData[$field])){
                    $aDiscardedFields[] = $field;
                    unset($aData[$field]);
                }
            }
            if(sizeof($aDiscardedFields)){
                trigger_error(
                    "Changing following fields forbidden without passing 'block_mask' field: '" .
                    implode("', '", $aDiscardedFields) . "'"
                );
            }
            unset($aFields, $aDiscardedFields);
        }

        if(isset($aData['data'])){
            if(isset($aData['block_mask'])){
                $aLayoutSpecblocksData = $this->getLayoutSpecblocskData($layoutId);
                $aPageSpecblocksData = $aData['data'];
                $mask = (int)$aData['block_mask'];
                $blocksNumber = AMI::getProperty('pages', 'template_blocks_number');
                for($i = 0; $i < $blocksNumber; ++$i){
                    $field = 'lay_f' . ($i + 1) . '_body';
                    if(!((1 << $i) & $mask)){
                        // common field, take data from layout
                        if(isset($aData[$field])){
                            $aData[$field] = $oLayoutItem->{$field};
                        }
                        //$aPageSpecblocksData[]
                    }
                }
                $aData['data'] = serialize($aData['data']);
            }else{
                unset($aData['data'], $aData['block_mask']);
            }
        }else{
            unset($aData['block_mask']);
        }

        $aEvent['aData'] = $aData;
    }

    /**
     * Returns layout specblocks options.
     *
     * @param  int $layoutId  Layout Id
     * @return array
     */
    protected function getLayoutSpecblocskData($layoutId){
        $aResult = array();
        if($layoutId){
            $oItem = $this->oTable->findByFields(
                array(
                    'id_layout'  => $layoutId,
                    'block_mask' => 0
                ),
                array('id', 'data')
            );
            if($oItem->getId()){
                if(is_array($oItem->data)){
                    foreach($oItem->data as $key => $value){
                        $specblock = mb_ereg_replace("(_[0-9]+)", "", $key);
                        $blockId = mb_substr($key, mb_strlen($specblock) + 4, 3);
                        if(
                            'spec_module_body' != $key &&
                            '000' != $blockId
                        ){
                            $aResult[$key] = $value;
                        }
                    }
                }
            }
        }

        return $aResult;
    }
}

/**
 * AmiClean/Pages configuration model meta data processor.
 *
 * @package    Config_AmiClean_Pages
 * @subpackage Model
 * @see        AMI_ModTableItem::save()
 * @resource   {$modId}/table/item/model/meta <code>AMI::getResource('{$modId}/table/item/model/meta')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class Pages_ModTableItemMeta extends AMI_ModTableItemMeta{
    /**
     * Falg specifying to store fields as DB snippet on during model saving.
     *
     * @var    bool
     * @amidev Temporary?
     */
    protected $storeAsSnippet = FALSE;

    /**
     * Event handler.
     *
     * Creates/updates module table item model meta data.
     *
     * @param  string $name          Event name
     * @param  array  $aEvent        Event data
     * @param  string $handlerModId  Handler module id
     * @param  string $srcModId      Source module id
     * @return array
     */
    public function handleSaveModelItem($name, array $aEvent, $handlerModId, $srcModId){
        $this->modId = $handlerModId;
        $this->processSublink($aEvent);
        $this->processHTMLMeta($aEvent);

        return $aEvent;
    }

    /**
     * Event handler.
     *
     * Update item model (stored in $aEvent['oItem']) by adding ID to sublink variable ('-36')
     * with additional check for default pages.
     *
     * @param  string $name          Event name
     * @param  array  $aEvent        Event data
     * @param  string $handlerModId  Handler module id
     * @param  string $srcModId      Source module id
     * @return array
     */
    public function addItemIdToSublink($name, array $aEvent, $handlerModId, $srcModId){
        if(
            !empty($aEvent['oItem']->id) &&
            in_array($aEvent['oItem']->id, AMI_PageManager::getDefaultPageIds()) &&
            empty($aEvent['oItem']->sublink)
        ){
            return $aEvent;
        }

        return parent::addItemIdToSublink($name, $aEvent, $handlerModId, $srcModId);
    }

    /**
     * Auto-generate sublink.
     *
     * @param  string $str                Source string for sublink generation
     * @param  string $langTransliterate  Locale for string transliteration
     * @param  string $forceLink          Force sublink
     * @param  array  $aItemData          Current item data
     * @return string
     */
    protected function genAutoLink($str, $langTransliterate = '', $forceLink = '', array $aItemData = array()){
        // $forcedLink = '';
        if(isset($aItemData['id_mod'])){
            $modId = $aItemData['id_mod'];
            $aVirtualLinks = AMI::getProperty('pages', 'virtual_links');
            $aUsedVirtualModules = AMI::getOption('pages', 'used_virtual_modules');
            foreach($aVirtualLinks as $masterModuleName => $aVirtualModules){
                if(isset($aVirtualModules[$modId])){
                    if(in_array($modId, $aUsedVirtualModules)){
                        $forcedLink = $aVirtualModules[$modId];
                    }
                    break;
                }
            }
        }

        if(
            !empty($aItemData['id']) &&
            in_array($aItemData['id'], AMI_PageManager::getDefaultPageIds()) &&
            empty($aItemData['sublink'])
        ){
            $sublink = '';
        }else{
            $sublink = parent::genAutoLink($str, $langTransliterate, $forceLink, $aItemData);
            if(
                isset($aItemData['id_mod']) &&
                'pages' == $aItemData['id_mod'] &&
                AMI::getOption('common_settings', 'slash_static_sublink')
            ){
                $sublink = rtrim($sublink, '/') . '/';
            }
        }

        if('' == $forceLink && !empty($aItemData['id_parent'])){
            $oItem = AMI::getResourceModel($this->modId . '/table')->find(
                $aItemData['id_parent'],
                array('id', 'sublink')
            );
            if($oItem->id && '' != $oItem->sublink){
                $sublink = rtrim($oItem->sublink, '/') . '/' . ltrim($sublink, '/');
            }
        }

        return $sublink;
    }
}
