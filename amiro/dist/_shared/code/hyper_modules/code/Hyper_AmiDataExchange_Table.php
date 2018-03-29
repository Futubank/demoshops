<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiDataExchange 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1513 xkqwkziwtygitpwltmkurpmlwpwlpuysxlpwntqlstmkxylwsxyqkmwztyytpkurxmywpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiDataExchange hypermodule table model.
 *
 * @package    Hyper_AmiDataExchange
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiDataExchange_Table extends AMI_ModTable{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = '';

    /**
     * Returns table fields structure.
     *
     * @return array
     */
    public function getTableFieldsData(){
        return array();
    }
}

/**
 * AmiDataExchange hypermodule table item model.
 *
 * @package    Hyper_AmiDataExchange
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiDataExchange_TableItem extends AMI_Module_TableItem{
}

/**
 * AmiDataExchange hypermodule table list model.
 *
 * @package    Hyper_AmiDataExchange
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiDataExchange_TableList extends AMI_ModTableList{
}
