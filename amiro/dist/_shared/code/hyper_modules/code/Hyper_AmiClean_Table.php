<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiClean 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       1268 xkqwixtiszrlpuusggggnusmslmsprtutstiwliulprxgzqggunnmksqlixwywwugpnupnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Base hypermodule table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * Articles fields description:
 * - <b>author</b> - article author (string),
 * - <b>source</b> - article source (string).
 *
 * @package    Hyper_AmiClean
 * @subpackage Model
 * @since      6.0.2
 */
class Hyper_AmiClean_Table extends AMI_ModTable{
}

/**
 * Base hypermodule table item model.
 *
 * @package    Hyper_AmiClean
 * @subpackage Model
 * @since      6.0.2
 */
class Hyper_AmiClean_TableItem extends AMI_ModTableItem{
}

/**
 * Base hypermodule table list model.
 *
 * @package    Hyper_AmiClean
 * @subpackage Model
 * @since      6.0.2
 */
class Hyper_AmiClean_TableList extends AMI_ModTableList{
}
