<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiEshopShipping_Fields 
 * @version    $Id$ 
 * @since      6.0.6 
 * @size       2935 xkqwyzxpkpppkmrmixrykyszkgkwrlqxugrtkwsnsxmikisikpywxlwzxgxzplwkwsukpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiEshopShipping/Fields configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.<br /><br />
 * Fields description:
 * - <b>postfix</b> - template set name postfix (string);
 * - <b>is_sys</b> - if 1, field cannot be deleted from interface (int).
 *
 * @package    Config_AmiEshopShipping_Fields
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      6.0.6
 */
class AmiEshopShipping_Fields_Table extends Hyper_AmiEshopShipping_Table{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_es_shipping_fields';

    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model
     */
    public function __construct(array $aAttributes = array()){
        parent::__construct($aAttributes);

        $aRemap = array(
            'id' => 'id'
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
 * AmiEshopShipping/Fields configuration table item model.
 *
 * @package    Config_AmiEshopShipping_Fields
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      6.0.6
 */
class AmiEshopShipping_Fields_TableItem extends Hyper_AmiEshopShipping_TableItem{
    /**
     * Initializing table item data.
     *
     * @param AMI_ModTable $oTable  Module table model
     * @param DB_Query     $oQuery  Required for load or save operations
     */
    public function __construct(AMI_ModTable $oTable, DB_Query $oQuery = null){
        $this->aCommonFieldsValidators['postfix'] = array('filled', 'alphanum', 'stop_on_error');

        parent::__construct($oTable, $oQuery);
    }
}

/**
 * AmiEshopShipping/Fields configuration table list model.
 *
 * @package    Config_AmiEshopShipping_Fields
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      6.0.6
 */
class AmiEshopShipping_Fields_TableList extends Hyper_AmiEshopShipping_TableList{
}
