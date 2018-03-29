<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module_AMI_Module 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2125 xkqwytupxrpxlrynzmtwrussqlmqpmlgwswitixkwkslkxtitpwzxwgqxkgmmplxlmsgpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AMI_Module module form component view.
 *
 * @package    Module_AMI_Module
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class AMI_Module_FormViewFrn extends AMI_ModFormViewFrn{
    /**
     * Main block name.
     *
     * @var string
     */
    protected $tplBlockName = 'ami_module_admin_form';

    /**
     * Locale filename.
     *
     * @var string
     */
    protected $localeFileName = 'templates/lang/modules/_form.lng';

    /**
     * Initialize fields.
     *
     * @see    AMI_View::init()
     * @return AMI_View
     */
    public function init(){
    	$this->addField(array('name' => 'id', 'type' => 'hidden'));
        $this->addField(array('name' => 'mod_action', 'value' => 'form_save', 'type' => 'hidden')); // Why in news module but not in general form?
        $this->addField(array('name' => 'public', 'type' => 'checkbox', 'default_checked' => true));
        $this->addField(
            array(
                'name' => 'id_page',
                'type' => 'select',
                'data' => array(),
                'not_selected'  => array('id' => 0, 'caption' => 'common_item')
            )
        );
        $this->addField(array('name' => 'date_created', 'type' => 'datetime', 'validate' => array('date')));
        $this->addField(array('name' => 'header'));
        $this->addField(array('name' => 'announce', 'type' => 'textarea', 'cols' => 80, 'rows' => 10));
        $this->addField(array('name' => 'body', 'type' => 'textarea', 'cols' => 80, 'rows' => 10));

    	return parent::init();
    }
}
