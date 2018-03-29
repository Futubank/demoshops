<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds5_Stickers 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3468 xkqwnuitxmrmkztzxmygslguszqlzltkkiyylskmglnsxgmpxkwnilzgxxnmzlpgmgswpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds5/Stickers configuration category table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiMultifeeds5_Stickers
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev
 */
class AmiMultifeeds5_StickersCat_Table extends Hyper_AmiMultifeeds5_Cat_Table{
    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        $this->tableName = 'cms_' . $this->getModId();
        $this->disableHTMLFields();

        parent::__construct($aAttributes);

        $aRemap = array(
            'id'               => 'id',
            'public'           => 'public',
            'hide_in_list'     => AMI_ModTable::FIELD_DOESNT_EXIST,

            'sublink'          => 'sublink',
            'id_page'          => AMI_ModTable::FIELD_DOESNT_EXIST,
            'lang'             => 'lang',

            'header'           => 'name',
            'date_modified'    => 'modified_date',
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiMultifeeds5/Stickers configuration table item model.
 *
 * @package    Config_AmiMultifeeds5_Stickers
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev
 */
class AmiMultifeeds5_StickersCat_TableItem extends Hyper_AmiMultifeeds5_Cat_TableItem{
    /**
     * Common fields validators
     *
     * @var array
     */
    protected $aCommonFieldsValidators =
        array(
            'lang'         => array('filled'),
            'header'       => array('filled'),
            'announce'     => array('required'),
        );

    /**
     * Initializing table item data.
     *
     * @param AMI_ModTable $oTable  Module table model
     * @param DB_Query     $oQuery  Required for load or save operations
     */
    public function __construct(AMI_ModTable $oTable, DB_Query $oQuery = null){
        parent::__construct($oTable, $oQuery);

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
 * AmiMultifeeds5/Stickers configuration table list model.
 *
 * @package    Config_AmiMultifeeds5_Stickers
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev
 */
class AmiMultifeeds5_StickersCat_TableList extends Hyper_AmiMultifeeds5_Cat_TableList{
}
