<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiFeedback_Feedback 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2616 xkqwqtuymrzzwnnpyluriztxmipzpxmzkkrgmilltpiyqixzggxmuqnrqkqqqwmugslqpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiFeedback/Feedback configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiFeedback_Feedback
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiFeedback_Feedback_Table extends Hyper_AmiFeedback_Table{
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
            'public'           => 'public',
            'date'             => 'date',
            'header'           => 'info',
            'id_page'          => 'id_page',
            'lang'             => 'lang',
            'date_created'     => 'date'
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiFeedback/Feedback configuration table item model.
 *
 * @package    Config_AmiFeedback_Feedback
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiFeedback_Feedback_TableItem extends Hyper_AmiFeedback_TableItem{
    /**
     * Common fields validators
     *
     * @var array
     */
    protected $aCommonFieldsValidators =
        array(
            'lang'         => array('filled'),
            'date_created' => array('filled', 'stop_on_error'),
        );
}

/**
 * AmiFeedback/Feedback configuration table list model.
 *
 * @package    Config_AmiFeedback_Feedback
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiFeedback_Feedback_TableList extends Hyper_AmiFeedback_TableList{
}
