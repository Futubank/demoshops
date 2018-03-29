<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiExt_EshopCustomFields 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1770 xkqwtkppllqssqrwxptxltutriqryxsmgukzwminmwgxmlsssiswgrimswruksltpxrupnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiExt/EshopCustomFields extension configuration.
 *
 * Common admin/front code.
 *
 * @package    Config_AmiExt_EshopCustomFields
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_EshopCustomFields_Common extends Hyper_AmiExt{
    /**
     * Pre init event handler.
     *
     * @param  string $name          Event name
     * @param  array  $aEvent        Event data
     * @param  int    $handlerModId  Handler module id
     * @param  int    $srcModId      Sources module id
     * @return array
     */
    public function handlePreInit($name, array $aEvent, $handlerModId, $srcModId){
        return $aEvent;
    }

    /**
     * Get all admin filter fields.
     *
     * @return null|object
     */
    public function getFields(){
        return
            AMI::getResourceModel('ext_eshop_custom_fields/table')
            ->getList()
            ->addColumns(array('id', 'name', 'fnum', 'ftype', 'value_type', 'default_gui_type'))
            ->addWhereDef(
                DB_Query::getSnippet("AND i.`default_params` LIKE %s")
                ->q('%admin_filter";s:1:"1"%')
            )
            ->addOrder('name', 'asc')
            ->load();
    }
}
