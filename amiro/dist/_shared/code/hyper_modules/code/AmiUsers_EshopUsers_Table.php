<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiUsers_EshopUsers 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2789 xkqwstzrtwnpmkspwrnyyiqigisgmttiqwlsgrgxsqwninuiiupngruixxnzqrnuqrltpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiUsers/EshopUsers configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiUsers_EshopUsers
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiUsers_EshopUsers_Table extends Hyper_AmiUsers_Table{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_es_users';

    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        $this->setDependence('users', 'u', "i.id_member = u.id", 'JOIN');
        $this->setActiveDependence('u');

        parent::__construct($aAttributes);

        $aRemap = array(
            'id' => 'id'
        );
        $this->addFieldsRemap($aRemap);
    }

    /**
     * Sets new table name for a model.
     *
     * @param string $tableName  New table name
     * @return void
     * @amidev Temporary
     */
    public function setTableName($tableName){
    }
}

/**
 * AmiUsers/EshopUsers configuration table item model.
 *
 * @package    Config_AmiUsers_EshopUsers
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiUsers_EshopUsers_TableItem extends Hyper_AmiUsers_TableItem{
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
 * AmiUsers/EshopUsers configuration table list model.
 *
 * @package    Config_AmiUsers_EshopUsers
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiUsers_EshopUsers_TableList extends Hyper_AmiUsers_TableList{
}
