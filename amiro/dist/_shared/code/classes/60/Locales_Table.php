<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module_Locales 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1580 xkqwrmmwpyyzzxlizryzgwmnlglnlwlkznrtpzwxzqynuslsutmlypkirtnmpursxywppnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Locales table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Module_Locales
 * @subpackage Model
 * @resource   locales/table/model <code>AMI::getResourceModel('locales/table')</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class Locales_Table extends AMI_ModTable{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_locales';
}

/**
 * Locales table item model.
 *
 * @package    Module_Locales
 * @subpackage Model
 * @resource   locales/table/model/item <code>AMI::getResourceModel('locales/table')->getItem()</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class Locales_TableItem extends AMI_ModTableItem{
}

/**
 * Locales table list model.
 *
 * @package    Module_Locales
 * @subpackage Model
 * @resource   locales/table/model/list <code>AMI::getResourceModel('locales/table')->getList()</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class Locales_TableList extends AMI_ModTableList{
}
