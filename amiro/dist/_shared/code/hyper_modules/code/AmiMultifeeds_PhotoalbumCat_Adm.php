<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds_PhotoGallery 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       6221 xkqwrwuzqwzixrwgyywxkmypxgkgumyigylnsmkrsklqiikqmrktgxpgnigkmsxumurupnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds/PhotoGallery configuration admin action controller.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}_cat/module/controller/adm <code>AMI::getResource('{$modId}_cat/module/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_PhotoalbumCat_Adm extends Hyper_AmiMultifeeds_Cat_Adm{
    /**
     * Constructor.
     *
     * @param AMI_Request  $oRequest   Request
     * @param AMI_Response $oResponse  Response
     */
    public function __construct(AMI_Request $oRequest, AMI_Response $oResponse){
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
 * AmiMultifeeds/PhotoGallery configuration category module model.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @resource   {$modId}_cat/module/model <code>AMI::getResourceModel('{$modId}_cat/module')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_PhotoalbumCat_State extends Hyper_AmiMultifeeds_Cat_State{
}

/**
 * AmiMultifeeds/PhotoGallery configuration admin filter component action controller.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}_cat/filter/controller/adm <code>AMI::getResource('{$modId}_cat/filter/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_PhotoalbumCat_FilterAdm extends Hyper_AmiMultifeeds_Cat_FilterAdm{
}

/**
 * AmiMultifeeds/PhotoGallery configuration item list component filter model.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Model
 * @resource   {$modId}_cat/filter/model/adm <code>AMI::getResource('{$modId}_cat/filter/model/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_PhotoalbumCat_FilterModelAdm extends Hyper_AmiMultifeeds_Cat_FilterModelAdm{
}

/**
 * AmiMultifeeds/PhotoGallery configuration admin filter component view.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage View
 * @resource   {$modId}_cat/filter/view/adm <code>AMI::getResource('{$modId}_cat/filter/view/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_PhotoalbumCat_FilterViewAdm extends Hyper_AmiMultifeeds_Cat_FilterViewAdm{
}

/**
 * AmiMultifeeds/PhotoGallery configuration admin form component action controller.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}_cat/form/controller/adm <code>AMI::getResource('{$modId}_cat/form/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_PhotoalbumCat_FormAdm extends Hyper_AmiMultifeeds_Cat_FormAdm{
    /**
     * Initialization.
     *
     * @return PhotoalbumCat_FormAdm
     */
    public function init(){
        AMI::setProperty($this->getModId(), 'picture_cat', 'photoalbum');
        return parent::init();
    }
}

/**
 * AmiMultifeeds/PhotoGallery configuration form component view.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage View
 * @resource   {$modId}_cat/form/view/adm <code>AMI::getResource('{$modId}_cat/form/view/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_PhotoalbumCat_FormViewAdm extends Hyper_AmiMultifeeds_Cat_FormViewAdm{
}

/**
 * AmiMultifeeds/PhotoGallery configuration admin list component action controller.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}_cat/list/controller/adm <code>AMI::getResource('{$modId}_cat/list/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_PhotoalbumCat_ListAdm extends Hyper_AmiMultifeeds_Cat_ListAdm{
    /**
     * Initialization.
     *
     * @return PhotoalbumCat_ListAdm
     */
    public function init(){
        parent::init();
        $this->dropActions(self::ACTION_GROUP, array('seo_section'));
        return $this;
    }
}

/**
 * AmiMultifeeds/PhotoGallery configuration admin list component view.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage View
 * @resource   {$modId}_cat/list/view/adm <code>AMI::getResource('{$modId}_cat/list/view/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_PhotoalbumCat_ListViewAdm extends Hyper_AmiMultifeeds_Cat_ListViewAdm{
}

/**
 * Photo Gallery module admin list actions controller.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}_cat/list_actions/controller/adm <code>AMI::getResource('{$modId}_cat/list_actions/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_PhotoalbumCat_ListActionsAdm extends Hyper_AmiMultifeeds_Cat_ListActionsAdm{
}

/**
 * Photo Gallery module admin list group actions controller.
 *
 * @package    Config_AmiMultifeeds_PhotoGallery
 * @subpackage Controller
 * @resource   {$modId}_cat/list_group_actions/controller/adm <code>AMI::getResource('{$modId}_cat/list_group_actions/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_PhotoalbumCat_ListGroupActionsAdm extends Hyper_AmiMultifeeds_Cat_ListGroupActionsAdm{
}
