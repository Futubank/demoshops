<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiCatalog 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       1114 xkqwzrlrlspyttnyrpgwnpnlzswlrtrisnmiyrusnrxwptzytixpzmtrnrgiullzltinpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiCatalog hypermodule table model.
 *
 * @package    Hyper_AmiCatalog
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiCatalog_Table extends AMI_ModTable{
}

/**
 * AmiCatalog hypermodule table item model.
 *
 * @package    Hyper_AmiCatalog
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiCatalog_TableItem extends AMI_Module_TableItem{
}

/**
 * AmiCatalog hypermodule table list model.
 *
 * @package    Hyper_AmiCatalog
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiCatalog_TableList extends AMI_ModTableList{
}
