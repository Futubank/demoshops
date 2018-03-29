<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiAccessRights_UsersPopup 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1695 xkqwplstyxxiulpkzwqwrqqikpwxzwwzztztytmizngnwqnwxrtysulktypqwiyqurkspnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiAccessRights configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiAccessRights_UsersPopup
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiAccessRights_UsersPopup_Table extends AmiUsers_Users_Table{
}

/**
 * AmiAccessRights configuration table item model.
 *
 * @package    Config_AmiAccessRights_UsersPopup
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiAccessRights_UsersPopup_TableItem extends AmiUsers_Users_TableItem{
}

/**
 * AmiAccessRights configuration table list model.
 *
 * @package    Config_AmiAccessRights_UsersPopup
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiAccessRights_UsersPopup_TableList extends AmiUsers_Users_TableList{
}
