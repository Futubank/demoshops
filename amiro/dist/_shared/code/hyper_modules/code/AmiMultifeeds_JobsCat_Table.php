<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds_JobsCat 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2855 xkqwupnmstwrtzwitinqtkzlyplssnwqqpxtxpystmkqrkitggpmpqmypnigzizqzlyppnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds/Jobs configuration category table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiMultifeeds_JobsCat
 * @subpackage Model
 * @resource   {$modId}_cat/table/model <code>AMI::getResourceModel('{$modId}_cat/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_JobsCat_Table extends Hyper_AmiMultifeeds_Cat_Table{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_jobs_cat';

    /**
     * Category items resource table string.
     *
     * @var string
     */
    protected $subItemsTableResource = 'jobs/table';

    /**
     * Category items module.
     *
     * @var string
     */
    protected $subItemsModuleName = 'jobs';

    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        parent::__construct($aAttributes);

        $aRemap = array(
            'id'               => 'id',
            'public'           => 'public',
            'header'           => 'header',
            'sublink'          => 'sublink',
            'id_page'          => 'id_page',
            'lang'             => 'lang',
            'date_modified'    => 'date_modified',
            'sticky'           => 'sticky',
            'date_sticky_till' => 'date_sticky_till'
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiMultifeeds/Jobs configuration table item model.
 *
 * @package    Config_AmiMultifeeds_JobsCat
 * @subpackage Model
 * @resource   {$modId}_cat/table/model/item <code>AMI::getResourceModel('{$modId}_cat/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_JobsCat_TableItem extends Hyper_AmiMultifeeds_Cat_TableItem{
}

/**
 * AmiMultifeeds/Jobs configuration table list model.
 *
 * @package    Config_AmiMultifeeds_JobsCat
 * @subpackage Model
 * @resource   {$modId}_cat/table/model/list <code>AMI::getResourceModel('{$modId}_cat/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_JobsCat_TableList extends Hyper_AmiMultifeeds_Cat_TableList{
}
