<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds5_ClassifiedsCat 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3228 xkqwkislyxzsqwnguyqynlulzlpykixkzlwgnqzxxmqypuiyipukislpgprpzugriuzypnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds5/Classifieds configuration category table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiMultifeeds5_ClassifiedsCat
 * @subpackage Model
 * @resource   {$modId}_cat/table/model <code>AMI::getResourceModel('{$modId}_cat/table')*</code>
 * @since      x.x.x
 * @amidev
 */
class AmiMultifeeds5_ClassifiedsCat_Table extends Hyper_AmiMultifeeds5_Cat_Table{
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
            'id' => 'id',
            'header' => 'name',

            'sticky'           => 'urgent',
            'date_sticky_till' => 'urgent_date',
            'hide_in_list'     => 'public_direct_link',
            // 'date_created'     => 'date',
            'date_modified'    => 'modified_date'
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiMultifeeds5/Classifieds configuration table item model.
 *
 * @package    Config_AmiMultifeeds5_ClassifiedsCat
 * @subpackage Model
 * @resource   {$modId}_cat/table/model/item <code>AMI::getResourceModel('{$modId}_cat/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev
 */
class AmiMultifeeds5_ClassifiedsCat_TableItem extends Hyper_AmiMultifeeds5_Cat_TableItem{
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
 * AmiMultifeeds5/Classifieds configuration table list model.
 *
 * @package    Config_AmiMultifeeds5_ClassifiedsCat
 * @subpackage Model
 * @resource   {$modId}_cat/table/model/list <code>AMI::getResourceModel('{$modId}_cat/table')->getList()*</code>
 * @since      x.x.x
 * @amidev
 */
class AmiMultifeeds5_ClassifiedsCat_TableList extends Hyper_AmiMultifeeds5_Cat_TableList{
}
