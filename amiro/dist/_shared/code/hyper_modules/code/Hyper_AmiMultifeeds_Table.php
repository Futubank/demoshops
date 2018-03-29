<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiMultifeeds 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       1144 xkqwwktgtzttrpuxqqzwwiywlypxumztpinrkgyiiikstsyyixrumklnqswlrxsyniixpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds hypermodule table model.
 *
 * @package    Hyper_AmiMultifeeds
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiMultifeeds_Table extends AMI_ModTable{
}

/**
 * AmiMultifeeds hypermodule table item model.
 *
 * @package    Hyper_AmiMultifeeds
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiMultifeeds_TableItem extends AMI_Module_TableItem{
}

/**
 * AmiMultifeeds hypermodule table list model.
 *
 * @package    Hyper_AmiMultifeeds
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiMultifeeds_TableList extends AMI_ModTableList{
}
