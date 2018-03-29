<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds5_Blog 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3839 xkqwrrmrwwiysynnsskwsiggkizmzwsrgyzkwrqrgygrxzywxtlgkrqsumxsiyzknzwxpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds5/Blog configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiMultifeeds5_Blog
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev
 */
class AmiMultifeeds5_Blog_Table extends Hyper_AmiMultifeeds5_Table{
    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        $this->tableName = 'cms_' . $this->getModId();
        $this->setDependence($this->getModId() . '_cat', 'cat', 'cat.id=i.id_cat');

        parent::__construct($aAttributes);

        $aRemap = array(
            'id'               => 'id',
            'public'           => 'public',
            'date'             => 'date',

            'sublink'          => 'sublink',
            'id_page'          => 'id_page',
            'lang'             => 'lang',

            'sticky'           => 'urgent',
            'date_sticky_till' => 'urgent_date',
            'hide_in_list'     => 'public_direct_link',
            'date_created'     => 'date',
            'date_modified'    => 'modified_date',
            // 'ext_tags'         => 'tags',
            'ext_dsc_disable'  => 'disable_comments'
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiMultifeeds5/Blog configuration table item model.
 *
 * @package    Config_AmiMultifeeds5_Blog
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev
 */
class AmiMultifeeds5_Blog_TableItem extends Hyper_AmiMultifeeds5_TableItem{
    /**
     * Initializing table item data.
     *
     * @param AMI_ModTable $oTable  Module table model
     * @param DB_Query     $oQuery  Required for load or save operations
     */
    public function __construct(AMI_ModTable $oTable, DB_Query $oQuery = null){
        parent::__construct($oTable, $oQuery);
        $this->oTable->addValidators(
            array(
                'lang'         => array('filled'),
                'header'       => array('filled', 'stop_on_error'),
                'announce'     => array('filled', 'stop_on_error'),
                'date_created' => array('date_time', 'filled', 'stop_on_error'),
                'body'         => array('required')
            )
        );
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
 * AmiMultifeeds5/Blog configuration table list model.
 *
 * @package    Config_AmiMultifeeds5_Blog
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev
 */
class AmiMultifeeds5_Blog_TableList extends Hyper_AmiMultifeeds5_TableList{
}
