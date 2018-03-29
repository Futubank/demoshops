<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds_Articles 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       2468 xkqwiuqikkrnwiyylxznliqpyqypulqgslylxqnsrzzuzsrmwtkkyqtxguxwksslwnsrpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds/Articles configuration category table model.
 *
 * @package    Config_AmiMultifeeds_Articles
 * @subpackage Model
 * @resource   {$modId}_cat/table/model <code>AMI::getResourceModel('{$modId}_cat/table')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_ArticlesCat_Table extends Hyper_AmiMultifeeds_Cat_Table{
    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model
     */
    public function __construct(array $aAttributes = array()){
        $this->tableName = 'cms_' . $this->getModId();

        parent::__construct($aAttributes);

        $aRemap = array(
            'id'      => 'id',
            'public'  => 'public',
            'sublink' => 'sublink',
            'id_page' => 'id_page',
            'lang'    => 'lang'
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiMultifeeds/Articles configuration category table item model.
 *
 * @package    Config_AmiMultifeeds_Articles
 * @subpackage Model
 * @resource   {$modId}_cat/table/model/item <code>AMI::getResourceModel('{$modId}_cat/table')->getItem()*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_ArticlesCat_TableItem extends Hyper_AmiMultifeeds_Cat_TableItem{
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
 * AmiMultifeeds/Articles configuration category table list model.
 *
 * @package    Config_AmiMultifeeds_Articles
 * @subpackage Model
 * @resource   {$modId}_cat/table/model/list <code>AMI::getResourceModel('{$modId}_cat/table')->getList()*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_ArticlesCat_TableList extends Hyper_AmiMultifeeds_Cat_TableList{
}
