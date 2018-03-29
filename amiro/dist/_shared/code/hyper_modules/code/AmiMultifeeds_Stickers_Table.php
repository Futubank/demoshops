<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds_Stickers 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       3611 xkqwtlrnsqmnuuxgiskuyusmmpwtkzmpgqztwmwyumnrwyzpgznuzsrqsipysqiqmuigpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds/Stickers configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiMultifeeds_Stickers
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Stickers_Table extends Hyper_AmiMultifeeds_Table{
    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        $this->disableHTMLFields();
        $this->tableName = 'cms_' . $this->getModId();
        $this->setDependence($this->getModId() . '_cat', 'cat', 'cat.id=i.id_cat');

        parent::__construct($aAttributes);

        $aRemap = array(
            'id'               => 'id',
            'public'           => 'public',
            'hide_in_list'     => AMI_ModTable::FIELD_DOESNT_EXIST,

            'sublink'          => AMI_ModTable::FIELD_DOESNT_EXIST,
            'id_page'          => AMI_ModTable::FIELD_DOESNT_EXIST,
            'lang'             => 'lang',

            'date_created'     => 'date_created',
            'date_modified'    => 'date_modified'
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiMultifeeds/Stickers configuration table item model.
 *
 * @package    Config_AmiMultifeeds_Stickers
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Stickers_TableItem extends Hyper_AmiMultifeeds_TableItem{
    /**
     * Common fields validators
     *
     * @var array
     */
    protected $aCommonFieldsValidators =
        array(
            'lang'         => array('filled'),
            'header'       => array('filled', 'stop_on_error'),
            'announce'     => array('filled', 'stop_on_error'),
        );

    /**
     * Initializing table item data.
     *
     * @param AMI_ModTable $oTable  Module table model
     * @param DB_Query     $oQuery  Required for load or save operations
     */
    public function __construct(AMI_ModTable $oTable, DB_Query $oQuery = null){
        parent::__construct($oTable, $oQuery);
        $this->setFieldCallback('header', array($this, 'fcbHTMLEntities'));
    }

    /**
     * Saves current item data.
     *
     * @return bool
     */
    public function save(){

        if(isset($GLOBALS['AMI_ENV_SETTINGS']['mode']) && $GLOBALS['AMI_ENV_SETTINGS']['mode'] == 'full'){
            $this->bAllowSave = true;
        }

        return parent::save();
    }
}

/**
 * AmiMultifeeds/Stickers configuration table list model.
 *
 * @package    Config_AmiMultifeeds_Stickers
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Stickers_TableList extends Hyper_AmiMultifeeds_TableList{
}
