<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    ModuleComponent 
 * @version    $Id: AMI_ModFormViewAdm.php 51114 2014-06-11 10:24:44Z Kolesnikov Artem $ 
 * @since      5.12.0 
 * @size       3774 xkqwytnwimwwpkitupsxskippkytkwssnrkiknppzkrysnnrglqmwziqykzyyznsnimqpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Module admin form component view abstraction.
 *
 * @package    ModuleComponent
 * @subpackage View
 * @see        AmiSample_FormViewAdm
 * @since      5.12.0
 */
class AMI_ModFormViewAdm extends AMI_ModFormView{
    /**
     * Constructor.
     */
    public function  __construct(){
        if(AMI_Registry::get('side') == 'frn'){
            $this->tplFileName = AMI_Skin::getPath('templates/_form.tpl');
            $this->localeFileName = AMI_Skin::getPath('templates/lang/_form.lng');
        }

        parent::__construct();
    }

    /**
     * Returns view data.
     *
     * @return string
     */
    public function get(){
        $html = parent::get();
        /**
         * AMI_Response
         */
        $oResponse = AMI::getSingleton('response');
        if($oResponse->getType() == 'JSON'){

            $aFieldsData = $this->getFieldsData();
            extract($aFieldsData);

            /**
             * @var AMI_RequestHTTP
             */
            $oRequest = AMI::getSingleton('env/request');
            return array(
                'fields'     => $aFields,
                'id'         => is_object($this->oItem) ? $this->oItem->getId() : '',
                'appliedId'  => $oRequest->get('applied_id'),
                'htmlCode'   => $html
            );
        }else{
            return $html;
        }
    }

    /**
     * Adds Options and SEO tab on the form.
     *
     * @param string $subItemsModId  Subitems module id
     * @return AMI_ModFormViewAdm
     * @since 6.0.4
     */
    protected function addOptionsTab($subItemsModId = false){
        $this->addTab('options_tab', 'default_tabset');
        $this->addField(array('name' => 'sublink', 'validate' => array('sublink', 'stop_on_error')));
        $this->addField(array('name' => 'html_title'/*, 'skipHTMLEncoding' => TRUE*/));
        $this->addField(array('name' => 'html_keywords', 'type' => 'textarea', 'cols' => 40, 'rows' => 4));
        $this->addField(array('name' => 'is_kw_manual', 'type' => 'hidden'));
        $this->addField(array('name' => 'html_description', 'type' => 'textarea', 'cols' => 40, 'rows' => 4));
        if(strpos($this->getModId(), 'inst_') === 0){
            $this->addField(array('name' => 'og_image'), 'html_description.after');
        }
        $this->addField(array('name' => 'details_noindex', 'type' => 'checkbox'));

        // sticky, hide_in_list
        if(AMI::issetAndTrueProperty($this->getModId(), "use_special_list_view") || ($subItemsModId && AMI::issetAndTrueProperty($subItemsModId, 'use_special_list_view'))){
            $this->putPlaceholder('sticky_fields', 'options_tab.begin');
            $this->addField(array('name' => 'hide_in_list', 'type' => 'checkbox', 'default_checked' => false, 'position' => 'sticky_fields.begin'));
            $this->addField(array('name' => 'sticky', 'type' => 'checkbox', 'default_checked' => false, 'position' => 'hide_in_list.after'));
            $this->addField(array('name' => 'date_sticky_till', 'type' => 'date', 'position' => 'sticky.after', 'validate' => array('date')));
        }
        return $this;
    }
}
