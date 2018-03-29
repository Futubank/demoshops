<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds_ClassifiedsCat 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3282 xkqwysnsyiqispttkspzmmqnuzrskxksxrqmuwrppuswliwywsuluypsqtgggtwtrigmpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds/Classifieds configuration category table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage Model
 * @resource   {$modId}_cat/table/model <code>AMI::getResourceModel('{$modId}_cat/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_Table extends Hyper_AmiMultifeeds_Cat_Table{
    /**
     * Category items resource table string.
     *
     * @var string
     */
    protected $subItemsTableResource = 'classifieds/table';

    /**
     * Category items module.
     *
     * @var string
     */
    protected $subItemsModuleName = 'classifieds';

    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        $this->tableName = 'cms_' . $this->getModId();

        parent::__construct($aAttributes);

        $aRemap = array(
            'id'               => 'id',
            'header'           => 'header',

            'sticky'           => 'sticky',
            'date_sticky_till' => 'date_sticky_till',
            'hide_in_list'     => 'hide_in_list',
            // 'date_created'     => 'date',
            'date_modified'    => 'date_modified'
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiMultifeeds/Classifieds configuration table item model.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage Model
 * @resource   {$modId}_cat/table/model/item <code>AMI::getResourceModel('{$modId}_cat/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_TableItem extends Hyper_AmiMultifeeds_Cat_TableItem{
    /**
     * Initializing table item data.
     *
     * @param AMI_ModTable $oTable  Module table model
     * @param DB_Query     $oQuery  Required for load or save operations
     */
    public function __construct(AMI_ModTable $oTable, DB_Query $oQuery = null){
        parent::__construct($oTable, $oQuery);

        $this->setFieldCallback('author', array($this, 'fcbHTMLEntities'));
        $this->setFieldCallback('source', array($this, 'fcbHTMLEntities'));
    }
}

/**
 * AmiMultifeeds/Classifieds configuration table list model.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage Model
 * @resource   {$modId}_cat/table/model/list <code>AMI::getResourceModel('{$modId}_cat/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_TableList extends Hyper_AmiMultifeeds_Cat_TableList{
}
