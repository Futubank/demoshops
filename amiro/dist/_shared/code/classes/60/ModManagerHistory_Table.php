<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module_ModManager 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1923 xkqwzgzqytnlrgutyuitsusxnrynnkwxwzstgppgnzzknilunyxqnklkyginxkmqwqippnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Module Manager history table model.
 *
 * @package    Module_ModManager
 * @subpackage Model
 * @resource   mod_manager_history/table/model <code>AMI::getResourceModel('mod_manager_history/table')</code>
 * @since      x.x.x
 * @amidev
 */
class ModManagerHistory_Table extends AMI_ModTable{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_mod_manager_history';
}

/**
 * Module Manager history table item model.
 *
 * @package    Module_ModManager
 * @subpackage Model
 * @resource   mod_manager_history/table/model/item <code>AMI::getResourceModel('mod_manager_history/table')->getItem()</code>
 * @since      x.x.x
 * @amidev
 */
class ModManagerHistory_TableItem extends AMI_ModTableItem{
    /**
     * Saves current item data.
     *
     * @return bool
     */
    public function save(){
        if(isset($GLOBALS['AMI_ENV_SETTINGS']['mode']) && $GLOBALS['AMI_ENV_SETTINGS']['mode'] == 'full'){
            $this->bAllowSave = TRUE;
        }
        return parent::save();
    }
}

/**
 * Module Manager history list model.
 *
 * @package    Module_ModManager
 * @subpackage Model
 * @resource   mod_manager_history/table/model/list <code>AMI::getResourceModel('mod_manager_history/table')->getList()</code>
 * @since      x.x.x
 * @amidev
 */
class ModManagerHistory_TableList extends AMI_ModTableList{
}
