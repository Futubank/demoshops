<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiSubscribe_Topic 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2067 xkqwxwnxumtpzzkktgwruiyglxqyxiglrwkzzutxnmlwuswgnuyzqsrmystuqkyqlguypnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiSubscribe/Topic configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiSubscribe_Topic
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSubscribe_Topic_Table extends Hyper_AmiSubscribe_Table{
    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        $this->tableName = 'cms_' . $this->getModId();

        parent::__construct($aAttributes);

        $aRemap = array(
            'header' => 'name'
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiSubscribe/Topic configuration table item model.
 *
 * @package    Config_AmiSubscribe_Topic
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSubscribe_Topic_TableItem extends Hyper_AmiSubscribe_TableItem{
}

/**
 * AmiSubscribe/Topic configuration table list model.
 *
 * @package    Config_AmiSubscribe_Topic
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSubscribe_Topic_TableList extends Hyper_AmiSubscribe_TableList{
}
