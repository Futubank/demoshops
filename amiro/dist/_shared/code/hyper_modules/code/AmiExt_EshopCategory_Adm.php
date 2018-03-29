<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiExt_EshopCategory 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2058 xkqwzqsppnxtznwuirigxntuxmstuqzklnksryugkpsrzwtqilwsuqzglwuxswluiulspnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


class_exists('AmiExt_Category_Adm');

/**
 * AmiExt/EshopCategory extension configuration admin controller.
 *
 * @package    Config_AmiExt_EshopCategory
 * @subpackage Controller
 * @resource   ext_eshop_category/module/controller/adm <code>AMI::getResource('ext_eshop_category/module/controller/adm')</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_EshopCategory_Adm extends AmiExt_EshopCategory{
}

/**
 * AmiExt/EshopCategory extension configuration admin view.
 *
 * @package    Config_AmiExt_EshopCategory
 * @subpackage View
 * @resource   ext_eshop_category/view/adm <code>AMI::getResource('ext_eshop_category/view/adm')</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_EshopCategory_ViewAdm extends AmiExt_Category_ViewAdm{
    /**
     * Event handler.
     *
     * Adds category column to admin list view, patch order column.
     *
     * @param  string $name          Event name
     * @param  array  $aEvent        Event data
     * @param  string $handlerModId  Handler module id
     * @param  string $srcModId      Source module id
     * @return array
     * @see    AMI_Event::addHandler()
     * @see    AMI_Event::fire()
     * @see    AMI_ModListView_JSON::get()
     */
    public function handleListColumns($name, array $aEvent, $handlerModId, $srcModId){
        $this->showColumn = !AMI_Filter::getFieldValue('category', 0);

        parent::handleListColumns($name, $aEvent, $handlerModId, $srcModId);

        return $aEvent;
    }
}
