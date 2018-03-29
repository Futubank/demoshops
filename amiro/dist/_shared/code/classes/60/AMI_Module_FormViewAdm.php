<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    ModuleComponent 
 * @version    $Id$ 
 * @since      5.14.4 
 * @size       6633 xkqwzixrwmkrqiytkpwyyrszkyngpsuzrtmnzyxlslxgwusuwknxgsmktgxukslkztwmpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AMI_Module module form component view.
 *
 * @package    ModuleComponent
 * @subpackage View
 * @since      5.14.4
 */
abstract class AMI_Module_FormViewAdm extends AMI_ModFormViewAdm{
    /**
     * Used tabs list
     *
     * @var array
     */
    protected $aUsedTabs = array('announce', 'body', 'options');

    /**
     * Common fields validators
     *
     * @var array
     */
    protected $aCommonFieldsValidators =
        array(
            'announce' => array('filled', 'stop_on_error')
        );

    /**
     * Flag specifying to skip AMI_Module_FormViewAdm::init(),
     * but call AMI_ModFormViewAdm::init().
     *
     * @var  bool
     * @since 6.0.2
     */
    protected $skipInit = FALSE;

    /**
     * Initialize fields.
     *
     * @see    AMI_View::init()
     * @return AMI_View
     */
    public function init(){
        if($this->skipInit){
            return parent::init();
        }

    	$this->addField(array('name' => 'id', 'type' => 'hidden'));
        $this->addField(array('name' => 'mod_action', 'value' => 'form_save', 'type' => 'hidden'));

        $modId = $this->getModId();
        if(
            AMI_Skin::isModuleSpecialMode($modId) &&
            (
                (AMI::doFilterFrn($modId) && AMI::isCategoryModule($modId)) ||
                in_array($modId, array('pages', 'eshop_cat'))
            )
        ){
            // #CMS-11748, #CMS-11922
            // Add multifeeds categories for non moderators,
            // eshop categories and pages auto-published
            $aField = array(
                'name'  => 'public',
                'type'  => 'hidden',
                'value' => 1
            );
        }else{
            $aField = array(
                'name' => 'public',
                'type' => 'checkbox',
                'default_checked' => TRUE
            );
        }
        $this->addField($aField);

        // Categories module checking
        $subItemsModId = false;
        if(is_callable(array($this->oModel, 'getSubItemsModId'))){
            $subItemsModId = $this->oModel->getSubItemsModId();
        }

        if(
            AMI::issetAndTrueOption('core', 'multi_page_allowed') &&
            (
                (
                    AMI::issetAndTrueOption($this->getModId(), "multi_page") &&
                    !AMI::issetAndTrueOption($this->getModId(), "use_categories")
                ) || ($subItemsModId && AMI::issetAndTrueOption($subItemsModId, 'multi_page'))
            )
        ){
            $aModulePages = array();
            if($subItemsModId){
                $aPages = AMI_PageManager::getModPages($subItemsModId, AMI_Registry::get('lang_data'));
            }else{
                $aPages = AMI_PageManager::getModPages($this->getModId(), AMI_Registry::get('lang_data'));
            }
            foreach($aPages as $aPage){
                $aModulePages[] = array(
                    'name'  => $aPage['name'],
                    'value' => $aPage['id']
                );
            }
            $this->addField(
                array(
                    'name' => 'id_page',
                    'type' => 'select',
                    'data' => $aModulePages,
                    'not_selected'  => array('id' => 0, 'caption' => 'common_item')
                )
            );
        }
        if(empty($this->aFields['date_created'])){
            $this->addField(array('name' => 'date_created', 'type' => 'datetime', 'validate' => array('date')));
        }
        $this->addField(array('name' => 'header'));

        if(sizeof($this->aUsedTabs)){
            // Add tabs
            $this->addTabContainer('default_tabset', 'header.after');

            if(in_array('announce', $this->aUsedTabs)){
                $this->addTab('announce_tab', 'default_tabset', self::TAB_STATE_ACTIVE);
                $aField = array('name' => 'announce', 'type' => 'htmleditor');
                $aField['validate'] = empty($this->aCommonFieldsValidators['announce']) ? array() : $this->aCommonFieldsValidators['announce'];
                $this->addField($aField);
            }

            if(in_array('body', $this->aUsedTabs)){
                $this->addTab(
                    'body_tab',
                    'default_tabset',
                    in_array('announce', $this->aUsedTabs) ? self::TAB_STATE_COMMON : self::TAB_STATE_ACTIVE
                );
                $this->addField(array('name' => 'body', 'type' => 'htmleditor'));
            }

            if(in_array('options', $this->aUsedTabs)){
                $this->addOptionsTab($subItemsModId);
            }
        }

    	return parent::init();
    }
}

/**
 * AMI_CatModule module form component view.
 *
 * @package    ModuleComponent
 * @subpackage View
 * @since      5.14.4
 */
abstract class AMI_CatModule_FormViewAdm extends AMI_Module_FormViewAdm{
    /**
     * Common fields validators
     *
     * @var array
     */
    protected $aCommonFieldsValidators = array();

    /**
     * Initialize.
     *
     * @return AMI_CatModule_FormViewAdm
     */
    public function init(){
        if($this->checkUsage()){
            parent::init();

            $this->dropField('date_created');
            $this->dropField('details_noindex');
        }else{
            $this->skipInit = TRUE;
            $this->aScope['form_type'] = 'none';
            $this->addField(array('name' => 'no_categories_usage', 'type' => 'hint'));

            parent::init();
        }

        return $this;
    }

    /**
     * Checks if category usage is turned on in parent module.
     *
     * @return bool  TRUE if categories used
     * @since 6.0.2
     */
    protected function checkUsage(){
        $modId = $this->getModId();
        $oDeclarator = AMI_ModDeclarator::getInstance();
        $parentModId = $oDeclarator->getParent($modId);
        return
            AMI::issetAndTrueOption($parentModId, 'use_categories');
    }
}
