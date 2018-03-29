<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiClean_EshopOrder 
 * @version    $Id$ 
 * @size       2816 xkqwnprkwkswlkmyppssxtnpxyntmppyrnwqsyyupggsgximrumrgsmnxulwqtnrgztspnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


class_exists('AmiClean_EshopOrder_Adm');

/**
 * AmiClean/EshopOrder configuration front action controller.
 *
 * @package    Config_AmiClean_EshopOrder
 * @subpackage Controller
 * @resource   {$modId}/module/controller/frn <code>AMI::getResource('{$modId}/module/controller/frn')*</code>
 * @amidev     temporary
 */
class AmiClean_EshopOrder_Frn extends Hyper_AmiClean_Frn{
}

/**
 * AmiClean/EshopOrder configuration form component controller.
 *
 * @package    Config_AmiClean_EshopOrder
 * @subpackage Controller
 * @resource   {$modId}/form/controller/frn <code>AMI::getResource('{$modId}/form/controller/frn')*</code>
 * @amidev     temporary
 */
class AmiClean_EshopOrder_FormFrn extends AmiClean_EshopOrder_FormAdm{
}

/**
 * AmiClean/EshopOrder configuration form component view.
 *
 * @package    Config_AmiClean_EshopOrder
 * @subpackage View
 * @resource   {$modId}/form/view/frn <code>AMI::getResource('{$modId}/form/view/frn')*</code>
 * @amidev     temporary
 */
class AmiClean_EshopOrder_FormViewFrn extends AmiClean_EshopOrder_FormViewAdm{
    /**
     * Prepares templates paths and blockname.
     *
     * @return void
     * @amidev
     */
    protected function prepareTemplates(){
        parent::prepareTemplates();

        $oTpl = $this->getTemplate();
        $oTpl->mergeBlock($this->tplBlockName, dirname($this->tplFileName) . '/eshop_order_form.tpl');
        $this->aLocale = $oTpl->parseLocale(dirname($this->localeFileName) . '/eshop_order_form.lng') + $this->aLocale;
        $this->aFormButtons = array('cancel', 'add', 'save');
        $this->aExcludedButtons = array(
            'new'  => array('save'),
            'edit' => array('add')
        );
    }
}

/**
 * AmiClean/EshopOrder configuration front list component.
 *
 * @package    Config_AmiClean_EshopOrder
 * @subpackage Controller
 * @resource   {$modId}/items/controller/frn <code>AMI::getResource('{$modId}/items/controller/frn')*</code>
 */
class AmiClean_EshopOrder_ListFrn extends AmiClean_EshopOrder_ListAdm{
}

/**
 * AmiClean/EshopOrder configuration front list component view.
 *
 * @package    Config_AmiClean_EshopOrder
 * @subpackage View
 * @resource   {$modId}/items/view/frn <code>AMI::getResource('{$modId}/items/view/frn')*</code>
 */
class AmiClean_EshopOrder_ListViewFrn extends AmiClean_EshopOrder_ListViewAdm{
}
