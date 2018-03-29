<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiCatalog 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       1158 xkqwpnlywsmwzwglwzszygzgitusimsxiuxiimymmnqnnmkstisimikzumxqngnznwmgpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiCatalog hypermodule category table model.
 *
 * @package    Hyper_AmiCatalog
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiCatalog_Cat_Table extends AMI_CatModTable{
}

/**
 * AmiCatalog hypermodule category table item model.
 *
 * @package    Hyper_AmiCatalog
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiCatalog_Cat_TableItem extends AMI_CatModTableItem{
}

/**
 * AmiCatalog hypermodule category table list model.
 *
 * @package    Hyper_AmiCatalog
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiCatalog_Cat_TableList extends AMI_CatModTableList{
}
