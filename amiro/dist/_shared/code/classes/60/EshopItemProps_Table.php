<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module_Catalog 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       2763 xkqwsqwkixxqlrsxsrwzylrkrqwsriuwsgzrnlgllutptntgppzmnyizgngxwqwpgnpzpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Eshop props table model.
 *
 * @package    Module_Catalog
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      6.0.2
 */
class EshopItemProps_Table extends AMI_ModTable{
    /**
     * Properties fields
     *
     * @var array
     */
    protected $aPropFields = array();

    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        parent::__construct($aAttributes);

        $this->tableName = 'cms_es_props';

        $aRemap = array(
            'id'            => 'id',
            'public'        => 'public',

            'id_item'       => 'id_item',
            'id_cat'        => 'id_category',

            'price'         => 'price',
            'rest'          => 'rest',
            'weight'        => 'weight',
            'size'          => 'size',
            'mask'          => 'mask',
            'lang'          => 'lang',

            'date_modified' => 'modified_date',
            'stop'          => 'stop'
        );

        $oDB = AMI::getSingleton('db');
        $oRS = $oDB->select('DESCRIBE ' . $this->tableName);
        foreach($oRS as $oItem){
            if(mb_strpos($oItem['Field'], 'prop_') === 0){
                $aPropFields[$oItem['Field']] = $oItem['Field'];
            }
        }

        $this->addFieldsRemap($aRemap);
    }
}

/**
 * Eshop props table item model.
 *
 * @package    Module_Catalog
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      6.0.2
 */
class EshopItemProps_TableItem extends AMI_Module_TableItem{
    /**
     * Allow to save model flag.
     *
     * @var    bool
     * @amidev Temporary
     */
    protected $bAllowSave = false;
}

/**
 * Eshop props table list model.
 *
 * @package    Module_Catalog
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      6.0.2
 */
class EshopItemProps_TableList extends AMI_ModTableList{
}
