<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiClean_Templates 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2203 xkqwrlrnzsrnnritmlzrymynwymmrzqqwyymplsknktrkqqlpxqnzkxyisirmsmprrlypnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiPageManager/Templates configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiClean_Templates
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_Templates_Table extends Hyper_AmiClean_Table{
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
            'date_created' => 'date',
            'header' => 'name',
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiPageManager/Templates configuration table item model.
 *
 * @package    Config_AmiClean_Templates
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_Templates_TableItem extends Hyper_AmiClean_TableItem{
}

/**
 * AmiPageManager/Templates configuration table list model.
 *
 * @package    Config_AmiClean_Templates
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_Templates_TableList extends Hyper_AmiClean_TableList{
}
