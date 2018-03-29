<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiForum_Forum 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3026 xkqwnggznguqtptgplzpsummxnnrspzuqqikypkstnqqusqxytmgsikslmymluqkwzgupnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiForum/Forum configurationtable model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiForum_Forum
 * @subpackage Model
 * @resource   {$modId}_cat/table/model <code>AMI::getResourceModel('{$modId}_cat/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiForum_ForumCat_Table extends Hyper_AmiForum_Cat_Table{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_forum_cat';

    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        parent::__construct($aAttributes);

        $aRemap = array(
            'id'     => 'id',
            'public'           => 'public',

            'sublink'          => 'sublink',
            'lang'             => 'lang',

            'header'           => 'name',
            'sticky'           => 'urgent',
            'date_sticky_till' => 'urgent_date',
            'hide_in_list'     => 'public_direct_link',
            'date_modified'    => 'modified_date'
        );
        $this->addFieldsRemap($aRemap);
    }

    /**
     * Sets new table name for a model.
     *
     * @param string $tableName  New table name
     * @return void
     */
    public function setTableName($tableName){
    }
}

/**
 * AmiForum/Forum configurationtable item model.
 *
 * @package    Config_AmiForum_Forum
 * @subpackage Model
 * @resource   {$modId}_cat/table/model/item <code>AMI::getResourceModel('{$modId}_cat/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiForum_ForumCat_TableItem extends Hyper_AmiForum_Cat_TableItem{
    /**
     * Initializing table item data.
     *
     * @param AMI_ModTable $oTable  Module table model
     * @param DB_Query     $oQuery  Required for load or save operations
     */
    public function __construct(AMI_ModTable $oTable, DB_Query $oQuery = null){
        parent::__construct($oTable, $oQuery);
    }
}

/**
 * AmiForum/Forum configurationtable list model.
 *
 * @package    Config_AmiForum_Forum
 * @subpackage Model
 * @resource   {$modId}_cat/table/model/list <code>AMI::getResourceModel('{$modId}_cat/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiForum_ForumCat_TableList extends Hyper_AmiForum_Cat_TableList{
}
