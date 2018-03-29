<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiMultifeeds5 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1190 xkqwnxmkqggmpgnlgmwtwmwmlkgtikwkuuzsguupspwgziulgztkixlqmwzrmunmllmypnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds5 hypermodule table model.
 *
 * @package    Hyper_AmiMultifeeds5
 * @subpackage Model
 * @since      x.x.x
 * @amidev
 */
abstract class Hyper_AmiMultifeeds5_Table extends AMI_ModTable{
}

/**
 * AmiMultifeeds5 hypermodule table item model.
 *
 * @package    Hyper_AmiMultifeeds5
 * @subpackage Model
 * @since      x.x.x
 * @amidev
 */
abstract class Hyper_AmiMultifeeds5_TableItem extends AMI_Module_TableItem{
}

/**
 * AmiMultifeeds5 hypermodule table list model.
 *
 * @package    Hyper_AmiMultifeeds5
 * @subpackage Model
 * @since      x.x.x
 * @amidev
 */
abstract class Hyper_AmiMultifeeds5_TableList extends AMI_ModTableList{
}
