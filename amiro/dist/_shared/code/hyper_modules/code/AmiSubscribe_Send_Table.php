<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiSubscribe_Send 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2418 xkqwltyrqpwxusztlsklkqxyrixwkggguzwxrlrimmkuwrypzinruzlqxsmnpgqnnmkgpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiSubscribe/Send configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiSubscribe_Send
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSubscribe_Send_Table extends Hyper_AmiSubscribe_Table{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_subs_sent';

    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        parent::__construct($aAttributes);

        $aRemap = array(
            'date_created' => 'date',
			'header' => 'subject'
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
 * AmiSubscribe/Send configuration table item model.
 *
 * @package    Config_AmiSubscribe_Send
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSubscribe_Send_TableItem extends Hyper_AmiSubscribe_TableItem{
}

/**
 * AmiSubscribe/Send configuration table list model.
 *
 * @package    Config_AmiSubscribe_Send
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSubscribe_Send_TableList extends Hyper_AmiSubscribe_TableList{
}
