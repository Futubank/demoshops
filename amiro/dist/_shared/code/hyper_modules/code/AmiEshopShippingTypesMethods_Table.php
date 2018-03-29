<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiEshopShipping_TypesMethods 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2448 xkqwsxmwpwgzgzwignqituygsukntzrkuuwzztuzqgsknqxrnzsiwqiiynitgywkqtxrpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiEshopShipping/TypesMethods configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiEshopShipping_TypesMethods
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiEshopShippingTypesMethods_Table extends AMI_ModTable{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_es_shipping_types_methods';

    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        parent::__construct($aAttributes);

        $aRemap = array(
            'methods_count' => 'id_method'
        );
        $this->addFieldsRemap($aRemap);
    }

    /**
     * Sets new table name for a model.
     *
     * @param string $tableName  New table name
     * @return void
     * @amidev Temporary
     */
    public function setTableName($tableName){
    }
}

/**
 * AmiEshopShipping/TypesMethods configuration table item model.
 *
 * @package    Config_AmiEshopShipping_TypesMethods
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiEshopShippingTypesMethods_TableItem extends AMI_ModTableItem{
}

/**
 * AmiEshopShipping/TypesMethods configuration table list model.
 *
 * @package    Config_AmiEshopShipping_TypesMethods
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiEshopShippingTypesMethods_TableList extends AMI_ModTableList{
}
