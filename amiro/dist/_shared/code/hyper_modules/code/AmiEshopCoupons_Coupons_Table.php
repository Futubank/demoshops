<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiEshopCoupons_Coupons 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3643 xkqwzgkmpkuummyrngkxuwztllwlpwizkuzkrmkwxmgiqilgzrxprsntsnnqsknuitmipnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiEshopCoupons/Coupons configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiEshopCoupons_Coupons
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since     x.x.x
 * @amidev     Temporary
 */
class AmiEshopCoupons_Coupons_Table extends Hyper_AmiEshopCoupons_Table{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_es_coupons';

    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        $this->setDependence('users', 'u', 'u.id=i.id_member', 'LEFT OUTER JOIN');
        $this->setActiveDependence('u');

        AMI_Registry::set('AMI/models/eshop_discounts/nojoin/eshop_cat', TRUE);
        $this->setDependence('eshop_discounts', 'd', 'd.id_coupon_cat=i.id', 'LEFT OUTER JOIN');
        $this->setActiveDependence('d');

        $this->setDependence($this->getModId() . '_cat', 'cat', '`cat`.`id` = `i`.`id_cat`');

        parent::__construct($aAttributes);

        $aRemap = array(
            'header' => 'coupon'
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
 * AmiEshopCoupons/Coupons configuration table item model.
 *
 * @package    Config_AmiEshopCoupons_Coupons
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiEshopCoupons_Coupons_TableItem extends Hyper_AmiEshopCoupons_TableItem{
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
 * AmiEshopCoupons/Coupons configuration table list model.
 *
 * @package    Config_AmiEshopCoupons_Coupons
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiEshopCoupons_Coupons_TableList extends Hyper_AmiEshopCoupons_TableList{
    /**
     * Initializing table list data.
     *
     * @param AMI_ModTable $oTable  Table model
     * @param DB_Query     $oQuery  DB_Query object, required for load or save operations
     */
    public function __construct(AMI_ModTable $oTable, DB_Query $oQuery){
        parent::__construct($oTable, $oQuery);
        $this->addExpressionColumn('discounts_count', 'COUNT(d.id)', 'd');
    }
}
