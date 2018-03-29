<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiFiles_Files 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1628 xkqwliiiynyxrgtlyusyyqixmlynttkunlxpltpmizktmukyrtnpkuxlrtkmnmmymqstpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * File type table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiFiles_Files
 * @subpackage Model
 * @resource   file_type/table/model <code>AMI::getResourceModel('file_type/table')</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class FileType_Table extends AMI_ModTable{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_ftypes';
}

/**
 * File type table item model.
 *
 * @package    Config_AmiFiles_Files
 * @subpackage Model
 * @resource   file_type/table/model/item <code>AMI::getResourceModel('file_type/table')->getItem()</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class FileType_TableItem extends AMI_ModTableItem{
}

/**
 * File type table list model.
 *
 * @package    Config_AmiFiles_Files
 * @subpackage Model
 * @resource   file_type/table/model/list <code>AMI::getResourceModel('file_type/table')->getList()</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class FileType_TableList extends AMI_ModTableList{
}
