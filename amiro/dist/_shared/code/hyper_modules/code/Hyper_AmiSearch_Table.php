<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiSearch 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       1104 xkqwwwtzyyzmpnwpskgrnspzluwywztsnlgixgizsxmiqkqtwlkpqpznsyiqlizstigupnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiSearch hypermodule table model.
 *
 * @package    Hyper_AmiSearch
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiSearch_Table extends AMI_ModTable{
}

/**
 * AmiSearch hypermodule table item model.
 *
 * @package    Hyper_AmiSearch
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiSearch_TableItem extends AMI_Module_TableItem{
}

/**
 * AmiSearch hypermodule table list model.
 *
 * @package    Hyper_AmiSearch
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiSearch_TableList extends AMI_ModTableList{
}
