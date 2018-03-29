<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiRelations_Relations 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2519 xkqwqtztiuuwyustupkxgnrtyysmklprxwiqrkpzutprizpriszxrnpyyzqwywrmkwxtpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiRelations/Relations configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiRelations_Relations
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiRelations_Relations_Table extends Hyper_AmiRelations_Table{
    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        $this->tableName = 'cms_' . $this->getModId();
        // $this->setDependence($this->getModId() . '_cat', 'cat', 'cat.id=i.id_cat');

        parent::__construct($aAttributes);

        $aRemap = array(
            'id' => 'id'
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiRelations/Relations configuration table item model.
 *
 * @package    Config_AmiRelations_Relations
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiRelations_Relations_TableItem extends Hyper_AmiRelations_TableItem{
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
 * AmiRelations/Relations configuration table list model.
 *
 * @package    Config_AmiRelations_Relations
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiRelations_Relations_TableList extends Hyper_AmiRelations_TableList{
}
