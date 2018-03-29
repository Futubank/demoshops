<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_##modId## 
 * @version    $Id$ 
 * @since      5.14.4 
 * @size       1366 xkqwynzkmppwwxkppzssmigssslxmrmxngsslptzzynmyryskilsugmtittiinywwtmqpnir
 */
?><?php


/**
 * AmiFiles/Files configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_##modId##
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      5.14.4
 */
class ##modId##_Table extends Hyper_AmiFiles_Table{
}

/**
 * AmiFiles/Files configuration table item model.
 *
 * @package    Config_##modId##
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      5.14.4
 */
class ##modId##_TableItem extends Hyper_AmiFiles_TableItem{
}

/**
 * AmiFiles/Files configuration table list model.
 *
 * @package    Config_##modId##
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      5.14.4
 */
class ##modId##_TableList extends Hyper_AmiFiles_TableList{
}
