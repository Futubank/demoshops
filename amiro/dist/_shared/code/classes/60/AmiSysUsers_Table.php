<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiAccessRights_Groups 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3745 xkqwpzrzqlsnqkwrtxyqrwqutqsggyqkpqgkqkiktuqpzwrpprlrmismqqgmrtpzmswtpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Real sys users table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiAccessRights_Groups
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSysUsers_Table extends AMI_ModTable{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_sys_users';
}

/**
 * AmiAccessRights configuration table item model.
 *
 * @package    Config_AmiAccessRights_Groups
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSysUsers_TableItem extends AMI_ModTableItem{
}

/**
 * AmiAccessRights configuration table list model.
 *
 * @package    Config_AmiAccessRights_Groups
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSysUsers_TableList extends AMI_ModTableList{
}

/**
 * Real sys users table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiAccessRights_Groups
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSysUsersJoinedGroups_Table extends AmiSysUsers_Table{
    /**
     * Initializing table data. (describe, field rules).
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        $this->setDependence('sys_groups', 'g', "`i`.`id_group` = `g`.`id`", 'LEFT JOIN');
        $this->setActiveDependence('g');

        parent::__construct($aAttributes);
    }
}

/**
 * AmiAccessRights configuration table item model.
 *
 * @package    Config_AmiAccessRights_Groups
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSysUsersJoinedGroups_TableItem extends AmiSysUsers_TableItem{
}

/**
 * AmiAccessRights configuration table list model.
 *
 * @package    Config_AmiAccessRights_Groups
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSysUsersJoinedGroups_TableList extends AmiSysUsers_TableList{
    /**
     * Initializing table list data.
     *
     * @param AMI_ModTable $oTable  Table model
     * @param DB_Query     $oQuery  DB_Query object, required for load or save operations
     * @todo  Add sys user check?
     */
    public function __construct(AMI_ModTable $oTable, DB_Query $oQuery){
        parent::__construct($oTable, $oQuery);
        $this->addExpressionColumn('admin', 'IF(SUM(`g`.`login`) > 0, 1, 0)', 'g');
        $this->addGrouping('`i`.`id`');
    }
}
