<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module_Catalog 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2263 xkqwukgsiwxzruippugtlmkkirnsimtqsqxpyipzqsgttlsnnkyuwksqxwskzsqrikyzpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * EshopItem service class for EshopOrder.
 *
 * @package    Module_Catalog
 * @subpackage Controller
 * @resource   eshop_item/serve/eshop_order <code>AMI::getResource('eshop_item/serve/eshop_order')</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class EshopItem_Serve_EshopOrder extends AMI_ModServant{
    /**
     * Calls on module controller constructor starts.
     *
     * Replaces appropriate module resources.
     *
     * @return EshopItem_Serve_EshopOrder
     */
    public function onModConstructorStart(){
        // Disable all extension except image/category related
        $bShowImage = AMI::getSingleton('env/request')->get('show_image_in_order_details', 1);
        AMI::setOption(
            $this->modId,
            'extensions',
            (in_array('ext_images', AMI::getOption($this->modId, 'extensions')) || $bShowImage) ? array('ext_images') : array()
        );
        AMI::setOption($this->modId, 'use_categories', TRUE);
        $aUsedExtensions = AMI::getOption($this->modId, 'extensions');

        if($bShowImage){
            AMI::setOption($this->modId, 'col_picture_type', 'small_picture');
        }

        // Resource replacement
        AMI::addResource($this->modId . '/filter/model/adm', 'EshopItem_FilterModelAdm_Serve_EshopOrder');
        AMI::addResource($this->modId . '/list/controller/adm', 'EshopItem_ListAdm_Serve_EshopOrder');
        AMI::addResource($this->modId . '/list/view/adm', 'EshopItem_ListViewAdm_Serve_EshopOrder');

        return $this;
    }

    /**
     * Calls on module controller constructor ends.
     *
     * @return EshopItem_Serve_EshopOrder
     */
    public function onModConstructorEnd(){
        return $this;
    }
}
