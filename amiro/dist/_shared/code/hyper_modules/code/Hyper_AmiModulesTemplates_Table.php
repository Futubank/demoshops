<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiModulesTemplates 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2610 xkqwgynssgszikpurnnwywiqzkxrnmlgqxtqukwgyysnpmlgyyylwsumgygwyutlykgqpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiModulesTemplates hypermodule table model.
 *
 * @package    Hyper_AmiModulesTemplates
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiModulesTemplates_Table extends AMI_ModTable{
    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        $this->tableName = 'cms_' . $this->getModId();

        parent::__construct($aAttributes);

        $aRemap = array(
            'id'        => 'id',
            'header'    => 'name'
        );
        $this->addFieldsRemap($aRemap);
    }

    /**
     * Checks if table has a field.
     *
     * @param  string $name  Field name in table
     * @param  bool $bAppendEventFields  Fire 'on_get_available_fields' event to append extension fields
     * @return bool
     */
    public function hasField($name, $bAppendEventFields = false){
        // Hack to make expression column sortable
        if(($name == 'content_length') || ($name == 'content_not_default')){
            return true;
        }

        return parent::hasField($name, $bAppendEventFields);
    }
}

/**
 * AmiModulesTemplates hypermodule table item model.
 *
 * @package    Hyper_AmiModulesTemplates
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiModulesTemplates_TableItem extends AMI_Module_TableItem{
    /**
     * Common fields validators
     *
     * @var array
     */
    protected $aCommonFieldsValidators =
        array(
            'lang'         => array('filled'),
            'header'       => array('filled', 'tplname', 'stop_on_error'),
            'date_created' => array('filled', 'stop_on_error'),
        );
}

/**
 * AmiModulesTemplates hypermodule table list model.
 *
 * @package    Hyper_AmiModulesTemplates
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiModulesTemplates_TableList extends AMI_ModTableList{
}
