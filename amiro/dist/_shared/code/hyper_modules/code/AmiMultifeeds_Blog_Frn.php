<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds_Blog 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       7341 xkqwxkrzrppnwrsggnyiixpmgstswlrpnilzstnnurmkymlxxxzgqizrnzgusgkspizqpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds/Blog configuration front action controller.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage Controller
 * @resource   {$modId}/module/controller/frn <code>AMI::getResource('{$modId}/module/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_Frn extends Hyper_AmiMultifeeds_Frn{
}

/**
 * AmiMultifeeds/Blog configuration form component controller.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage Controller
 * @resource   {$modId}/form/controller/frn <code>AMI::getResource('{$modId}/form/controller/frn')*</code>
 * @since      7.0.0
 */
class AmiMultifeeds_Blog_FormFrn extends Hyper_AmiMultifeeds_FormFrn{
}

/**
 * AmiMultifeeds/Blog configuration form component view.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage View
 * @resource   {$modId}/form/view/frn <code>AMI::getResource('{$modId}/form/view/frn')*</code>
 * @since      7.0.0
 */
class AmiMultifeeds_Blog_FormViewFrn extends Hyper_AmiMultifeeds_FormViewFrn{
}

/**
 * AmiMultifeeds/Blog configuration list component controller.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage Controller
 * @resource   {$modId}/list/controller/frn <code>AMI::getResource('{$modId}/list/controller/frn')*</code>
 * @since      7.0.0
 */
class AmiMultifeeds_Blog_ListFrn extends Hyper_AmiMultifeeds_ListFrn{
}

/**
 * AmiMultifeeds/Blog configuration list component view.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage View
 * @resource   {$modId}/list/view/frn <code>AMI::getResource('{$modId}/list/view/frn')*</code>
 * @since      7.0.0
 */
class AmiMultifeeds_Blog_ListViewFrn extends Hyper_AmiMultifeeds_ListViewFrn{
}

/**
 * AmiMultifeeds/Blog configuration front items component.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage Controller
 * @resource   {$modId}/items/controller/frn <code>AMI::getResource('{$modId}/items/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_ItemsFrn extends Hyper_AmiMultifeeds_ItemsFrn{
}

/**
 * AmiMultifeeds/Blog configuration items component view.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage View
 * @resource   {$modId}/items/view/frn <code>AMI::getResource('{$modId}/items/view/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_ItemsViewFrn extends Hyper_AmiMultifeeds_ItemsViewFrn{
    /**
     * Array of simple set fields
     *
     * @var array
     */
    protected $aSimpleSetFields = array('announce', 'header', 'fdate', 'ftime');
}

/**
 * AmiMultifeeds/Blog configuration front sticky items component.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage Controller
 * @resource   {$modId}/sticky_items/controller/frn <code>AMI::getResource('{$modId}/sticky_items/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_StickyItemsFrn extends Hyper_AmiMultifeeds_StickyItemsFrn{
}

/**
 * AmiMultifeeds/Blog configuration front sticky items component view.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage View
 * @resource   {$modId}/sticky_items/view/frn <code>AMI::getResource('{$modId}/sticky_items/view/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_StickyItemsViewFrn extends Hyper_AmiMultifeeds_StickyItemsViewFrn{
}

/**
 * AmiMultifeeds/Blog configuration front details component.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage Controller
 * @resource   {$modId}/details/controller/frn <code>AMI::getResource('{$modId}/details/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_DetailsFrn extends Hyper_AmiMultifeeds_DetailsFrn{
}

/**
 * AmiMultifeeds/Blog configuration front details component view.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage Controller
 * @resource   {$modId}/details/view/frn <code>AMI::getResource('{$modId}/details/view/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_DetailsViewFrn extends Hyper_AmiMultifeeds_DetailsViewFrn{
}

/**
 * AmiMultifeeds/Blog configuration front filter component view.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage Controller
 * @resource   {$modId}/filter/controller/frn <code>AMI::getResource('{$modId}/filter/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_FilterFrn extends Hyper_AmiMultifeeds_FilterFrn{
}

/**
 * AmiMultifeeds/Blog configuration front filter component model.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage Controller
 * @resource   {$modId}/filter/model/frn <code>AMI::getResource('{$modId}/filter/model/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_FilterModelFrn extends Hyper_AmiMultifeeds_FilterModelFrn{
}

/**
 * AmiMultifeeds/Blog configuration front specblock component.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage Controller
 * @resource   {$modId}/specblock/controller/frn <code>AMI::getResource('{$modId}/specblock/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_SpecblockFrn extends Hyper_AmiMultifeeds_SpecblockFrn{
}

/**
 * AmiMultifeeds/Blog configuration front specblock component view.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage View
 * @resource   {$modId}/specblock/view/frn <code>AMI::getResource('{$modId}/specblock/view/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_SpecblockViewFrn extends Hyper_AmiMultifeeds_SpecblockViewFrn{
}

/**
 * AmiMultifeeds/Blog configuration front browse items component.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage Controller
 * @resource   {$modId}/browse/controller/frn <code>AMI::getResource('{$modId}/browse/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_BrowseItemsFrn extends Hyper_AmiMultifeeds_BrowseItemsFrn{
}

/**
 * AmiMultifeeds/Blog configuration front browse items component view.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage View
 * @resource   {$modId}/browse/view/frn <code>AMI::getResource('{$modId}/browse/view/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_BrowseItemsViewFrn extends Hyper_AmiMultifeeds_BrowseItemsViewFrn{
}


/**
 * AmiMultifeeds/Blog configuration front category details component.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage Controller
 * @resource   {$modId}/details/controller/frn <code>AMI::getResource('{$modId}/details/controller/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_CatDetailsFrn extends Hyper_AmiMultifeeds_CatDetailsFrn{
}

/**
 * AmiMultifeeds/Blog configuration front category details component view.
 *
 * @package    Config_AmiMultifeeds_Blog
 * @subpackage Controller
 * @resource   {$modId}/cat_details/view/frn <code>AMI::getResource('{$modId}/cat_details/view/frn')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_Blog_CatDetailsViewFrn extends Hyper_AmiMultifeeds_CatDetailsViewFrn{
}
