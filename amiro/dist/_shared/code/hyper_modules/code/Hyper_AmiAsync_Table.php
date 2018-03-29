<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiAsync 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1367 xkqwystlyxrkkiqitzmqlkpilryzlrwgzgqsxzrmpnpwlitlmpiikmrunzwyngslpirppnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Front async hypermodule table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * Articles fields description:
 * - <b>author</b> - article author (string),
 * - <b>source</b> - article source (string).
 *
 * @package    Hyper_AmiAsync
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiAsync_Table extends AMI_ModTable{
}

/**
 * Front async hypermodule table item model.
 *
 * @package    Hyper_AmiAsync
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiAsync_TableItem extends AMI_ModTableItem{
}

/**
 * Front async hypermodule table list model.
 *
 * @package    Hyper_AmiAsync
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiAsync_TableList extends AMI_ModTableList{
}
