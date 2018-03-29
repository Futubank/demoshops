<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiDatasets_Datasets 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2486 xkqwznimukswszkwuutnpwgtiyuzlltmwtmqkmkgysuzzittiimqimssgskiizqwpxwxpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiDatasets/Datasets configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiDatasets_Datasets
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiDatasets_Datasets_Table extends Hyper_AmiDatasets_Table{
    /**
     * Database table name, must be declared in child classes
     *
     * @var string
     */
    protected $tableName = 'cms_modules_datasets';

    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        parent::__construct($aAttributes);

        $aRemap = array(
            'id'     => 'id',
            'name'   => 'name',
            'module' => 'module_name',
            'lang'   => 'lang'
        );
        $this->addFieldsRemap($aRemap);
    }

    /**
     * Sets new table name for a model.
     *
     * @param string $tableName  New table name
     * @return void
     */
    public function setTableName($tableName){
    }
}

/**
 * AmiDatasets/Datasets configuration table item model.
 *
 * @package    Config_AmiDatasets_Datasets
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiDatasets_Datasets_TableItem extends Hyper_AmiDatasets_TableItem{
}

/**
 * AmiDatasets/Datasets configuration table list model.
 *
 * @package    Config_AmiDatasets_Datasets
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiDatasets_Datasets_TableList extends Hyper_AmiDatasets_TableList{
}
