<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds_PhotoGallery 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       9673 xkqwgttpqypkpqrmwqgmmkwrupsgispgpzmssxulzsglguypwtinkzqkukwszlnzyignpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds/PhotoGallery configuration front action controller.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}/module/controller/frn <code>AMI::getResource('{$modId}/module/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_Frn extends Hyper_AmiMultifeeds_Frn{
    /**
     * Constructor.
     *
     * @param AMI_Request $oRequest    Request object
     * @param AMI_Response $oResponse  Response object
     */
    public function  __construct(AMI_Request $oRequest, AMI_Response $oResponse){
        $aExtensions = $this->getModState()->getOption('extensions');
        if(!is_array($aExtensions)){
            $aExtensions = array();
        }
        if(!in_array('ext_images', $aExtensions)){
            $aExtensions[] = 'ext_images';
            AMI::setOption($this->getModId(), 'extensions', $aExtensions);
        }

        parent::__construct($oRequest, $oResponse);
    }
}

/**
 * AmiMultifeeds/Photoalbum configuration EDP mode form component controller.
 *
 * @package    Config_AmiMultifeeds_Photoalbum
 * @subpackage Controller
 * @resource   {$modId}/form/controller/frn <code>AMI::getResource('{$modId}/form/controller/frn')*</code>
 * @since      7.0.0
 */
class AmiMultifeeds_Photoalbum_FormFrn extends Hyper_AmiMultifeeds_FormFrn{
}

/**
 * AmiMultifeeds/Photoalbum configuration list component view.
 *
 * @package    Config_AmiMultifeeds_Photoalbum
 * @subpackage View
 * @resource   {$modId}/list/view/frn <code>AMI::getResource('{$modId}/list/view/frn')*</code>
 * @since      7.0.0
 */
class AmiMultifeeds_Photoalbum_ListFrn extends Hyper_AmiMultifeeds_ListFrn{
}

/**
 * AmiMultifeeds/Photoalbum configuration EDP mode form component controller.
 *
 * @package    Config_AmiMultifeeds_Photoalbum
 * @subpackage Controller
 * @resource   {$modId}/form/controller/frn <code>AMI::getResource('{$modId}/form/controller/frn')*</code>
 * @since      7.0.0
 */
class AmiMultifeeds_Photoalbum_ListViewFrn extends Hyper_AmiMultifeeds_ListViewFrn{
}

/**
 * AmiMultifeeds/Photoalbum configuration EDP mode form component view.
 *
 * @package    Config_AmiMultifeeds_Photoalbum
 * @subpackage View
 * @resource   {$modId}/form/view/frn <code>AMI::getResource('{$modId}/form/view/frn')*</code>
 * @since      7.0.0
 */
class AmiMultifeeds_Photoalbum_FormViewFrn extends Hyper_AmiMultifeeds_FormViewFrn{
    /**
     * Form default elements template (placeholders)
     *
     * @var array
     */
    protected $aPlaceholders = array(
        '#form',
            'header',
            'ext_image',
            '#ext_custom_fields_top', 'ext_custom_fields_top',
            '#default_tabset',
                '#announce_tab', 'announce', 'announce_tab',
                '#body_tab', 'body', 'body_tab',
                '#ext_custom_fields_tab', 'ext_custom_fields_tab',
                '#options_tab',
                    'disable_comments',
                    'sublink', 'html_title', 'html_keywords', 'html_description', 'og_image', 'details_noindex',
                    '#ext_rating_values' ,'ext_rating_values',
                'options_tab',
            'default_tabset',
            'public', 'id_dataset', 'id_page', 'id_cat', 'ext_custom_fields_addon', 'date_created', 'ext_adv', 'ext_tags', 'ext_relations',
            '#ext_custom_fields_bottom', 'ext_custom_fields_bottom',
        'form'
    );
}

/**
 * AmiMultifeeds/PhotoGallery configuration front items component.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}/items/controller/frn <code>AMI::getResource('{$modId}/items/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_ItemsFrn extends Hyper_AmiMultifeeds_ItemsFrn{
}

/**
 * AmiMultifeeds/PhotoGallery configuration front items component view.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage View
 * @resource   {$modId}/items/view/frn <code>AMI::getResource('{$modId}/items/view/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_ItemsViewFrn extends Hyper_AmiMultifeeds_ItemsViewFrn{
    /**
     * Array of simple set fields
     *
     * @var array
     */
    protected $aSimpleSetFields = array('announce', 'header', 'fdate', 'ftime');
}

/**
 * AmiMultifeeds/PhotoGallery configuration front sticky items component.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}/sticky_items/controller/frn <code>AMI::getResource('{$modId}/sticky_items/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_StickyItemsFrn extends Hyper_AmiMultifeeds_StickyItemsFrn{
}

/**
 * AmiMultifeeds/PhotoGallery configuration front sticky items component view.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage View
 * @resource   {$modId}/sticky_items/view/frn <code>AMI::getResource('{$modId}/sticky_items/view/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_StickyItemsViewFrn extends Hyper_AmiMultifeeds_StickyItemsViewFrn{
}

/**
 * AmiMultifeeds/PhotoGallery configuration front details component.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}/details/controller/frn <code>AMI::getResource('{$modId}/details/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_DetailsFrn extends Hyper_AmiMultifeeds_DetailsFrn{
}

/**
 * AmiMultifeeds/PhotoGallery configuration front details component view.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}/details/view/frn <code>AMI::getResource('{$modId}/details/view/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_DetailsViewFrn extends Hyper_AmiMultifeeds_DetailsViewFrn{
}

/**
 * AmiMultifeeds/PhotoGallery configuration front filter component view.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}/filter/controller/frn <code>AMI::getResource('{$modId}/filter/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_FilterFrn extends Hyper_AmiMultifeeds_FilterFrn{
}

/**
 * AmiMultifeeds/PhotoGallery configuration front filter component model.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}/filter/model/frn <code>AMI::getResource('{$modId}/filter/model/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_FilterModelFrn extends Hyper_AmiMultifeeds_FilterModelFrn{
}

/**
 * AmiMultifeeds/PhotoGallery configuration front specblock component.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}/specblock/controller/frn <code>AMI::getResource('{$modId}/specblock/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_SpecblockFrn extends Hyper_AmiMultifeeds_SpecblockFrn{
}

/**
 * AmiMultifeeds/PhotoGallery configuration front specblock component view.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage View
 * @resource   {$modId}/specblock/view/frn <code>AMI::getResource('{$modId}/specblock/view/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_SpecblockViewFrn extends Hyper_AmiMultifeeds_SpecblockViewFrn{
}

/**
 * AmiMultifeeds/PhotoGallery configuration front browse items component.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}/browse/controller/frn <code>AMI::getResource('{$modId}/browse/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_BrowseItemsFrn extends Hyper_AmiMultifeeds_BrowseItemsFrn{
}

/**
 * AmiMultifeeds/PhotoGallery configuration front browse items component view.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage View
 * @resource   {$modId}/browse/view/frn <code>AMI::getResource('{$modId}/browse/view/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_BrowseItemsViewFrn extends Hyper_AmiMultifeeds_BrowseItemsViewFrn{
}

/**
 * AmiMultifeeds/PhotoGallery configuration front category details component.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}/details/controller/frn <code>AMI::getResource('{$modId}/details/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_CatDetailsFrn extends Hyper_AmiMultifeeds_CatDetailsFrn{
}

/**
 * AmiMultifeeds/PhotoGallery configuration front category details component view.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}/cat_details/view/frn <code>AMI::getResource('{$modId}/cat_details/view/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Photoalbum_CatDetailsViewFrn extends Hyper_AmiMultifeeds_CatDetailsViewFrn{
}
