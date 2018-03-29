<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiExt_EshopCustomFields 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1618 xkqwsyksipuliizyqwqqxpwnkxyysgllsmtqxxktuztsitwssrnyrllpilmpwykwuqlqpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiExt/EshopCustomFields configuration table model.
 *
 * @package    Config_AmiExt_EshopCustomFields
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_EshopCustomFields_Table extends AMI_ModTable{
    /**
     * Set up table to cms_es_custom_types
     *
     * @var string
     */
    protected $tableName = 'cms_es_custom_types';

    /**
     * Overload table name setter.
     *
     * @param string $tableName  Table name
     * @return void
     */
    public function setTableName($tableName){
    }
}

/**
 * AmiExt/EshopCustomFields configuration table list model.
 *
 * @package    Config_AmiExt_EshopCustomFields
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_EshopCustomFields_TableList extends AMI_ModTableList{
}

/**
 * AmiExt/EshopCustomFields configuration table item model.
 *
 * @package    Config_AmiExt_EshopCustomFields
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_EshopCustomFields_TableItem extends AMI_ModTableItem{
}
