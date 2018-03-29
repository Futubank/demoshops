<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiFiles 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       1094 xkqwukqxqygrnzktqskpurywnrikkusklnkikslsqxymuwgiqmqwtusmlxszxklywyuxpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiFiles hypermodule table model.
 *
 * @package    Hyper_AmiFiles
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiFiles_Table extends AMI_ModTable{
}

/**
 * AmiFiles hypermodule table item model.
 *
 * @package    Hyper_AmiFiles
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiFiles_TableItem extends AMI_Module_TableItem{
}

/**
 * AmiFiles hypermodule table list model.
 *
 * @package    Hyper_AmiFiles
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiFiles_TableList extends AMI_ModTableList{
}
