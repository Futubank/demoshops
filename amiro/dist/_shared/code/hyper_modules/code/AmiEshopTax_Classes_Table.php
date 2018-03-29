<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiEshopTax_Classes 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3061 xkqwpyqpzrswtzltpxgrswuwsqnqzrpsniyuqtztzwztpqinkzqlltwnnmsmxuutpgwspnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiEshopTax/Classes configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiEshopTax_Classes
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiEshopTax_Classes_Table extends Hyper_AmiEshopTax_Table{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_es_tax_classes';

    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        parent::__construct($aAttributes);

        $aRemap = array(
            'header' => 'name'
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
        $this->tableName = $this->tableName;
    }
}

/**
 * AmiEshopTax/Classes configuration table item model.
 *
 * @package    Config_AmiEshopTax_Classes
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiEshopTax_Classes_TableItem extends Hyper_AmiEshopTax_TableItem{
    /**
     * Common fields validators
     *
     * @var array
     */
    protected $aCommonFieldsValidators =
        array(
            'lang'     => array('filled'),
            'header'   => array('filled', 'stop_on_error'),
            'tax_rate' => array('float', 'filled', 'stop_on_error')
        );

    /**
     * Initializing table item data.
     *
     * @param AMI_ModTable $oTable  Module table model
     * @param DB_Query     $oQuery  Required for load or save operations
     */
    public function __construct(AMI_ModTable $oTable, DB_Query $oQuery = null){
        parent::__construct($oTable, $oQuery);
    }
}

/**
 * AmiEshopTax/Classes configuration table list model.
 *
 * @package    Config_AmiEshopTax_Classes
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiEshopTax_Classes_TableList extends Hyper_AmiEshopTax_TableList{
}
