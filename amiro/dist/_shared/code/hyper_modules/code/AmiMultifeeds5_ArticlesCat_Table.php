<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds5_Articles 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2815 xkqwuyxwpkgnqktlgyrgpnzmiwmmskiznnyqnttptzzpyxupugwzmtwmryutkzmustlipnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds5/Articles configuration category table model.
 *
 * @package    Config_AmiMultifeeds5_Articles
 * @subpackage Model
 * @resource   {$modId}_cat/table/model <code>AMI::getResourceModel('{$modId}_cat/table')*</code>
 * @since      x.x.x
 * @amidev
 */
class AmiMultifeeds5_ArticlesCat_Table extends Hyper_AmiMultifeeds5_Cat_Table{
    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        $this->tableName = 'cms_' . $this->getModId();

        parent::__construct($aAttributes);

        $aRemap = array(
            'id'               => 'id',
            'public'           => 'public',

            'sublink'          => 'sublink',
            'id_page'          => 'id_page',
            'lang'             => 'lang',

            'header'           => 'name',
            'sticky'           => 'urgent',
            'date_sticky_till' => 'urgent_date',
            'hide_in_list'     => 'public_direct_link',
            'date_modified'    => 'modified_date',
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiMultifeeds5/Articles configuration category table item model.
 *
 * @package    Config_AmiMultifeeds5_Articles
 * @subpackage Model
 * @resource   {$modId}_cat/table/model/item <code>AMI::getResourceModel('{$modId}_cat/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev
 */
class AmiMultifeeds5_ArticlesCat_TableItem extends Hyper_AmiMultifeeds5_Cat_TableItem{
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
 * AmiMultifeeds5/Articles configuration category table list model.
 *
 * @package    Config_AmiMultifeeds5_Articles
 * @subpackage Model
 * @resource   {$modId}_cat/table/model/list <code>AMI::getResourceModel('{$modId}_cat/table')->getList()*</code>
 * @since      x.x.x
 * @amidev
 */
class AmiMultifeeds5_ArticlesCat_TableList extends Hyper_AmiMultifeeds5_Cat_TableList{
}
