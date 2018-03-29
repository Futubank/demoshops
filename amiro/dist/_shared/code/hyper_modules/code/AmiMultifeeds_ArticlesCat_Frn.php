<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds_Articles 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       2917 xkqwxmiiympyzpzsxgtwqsqswgzunpxmnsgukpkkrwwpzggmyrxwgggwtqtsrlmmtpgqpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds/Articles configuration category admin action controller.
 *
 * @package    Config_AmiMultifeeds_Articles
 * @subpackage Controller
 * @resource   {$modId}_cat/module/controller/adm <code>AMI::getResource('{$modId}_cat/module/controller/adm')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_ArticlesCat_Frn extends Hyper_AmiMultifeeds_Cat_Frn{
}

/**
 * AmiMultifeeds/Articles configuration category model.
 *
 * @package    Config_AmiMultifeeds_Articles
 * @subpackage Model
 * @resource   {$modId}_cat/module/model <code>AMI::getResourceModel('{$modId}_cat/module')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_ArticlesCat_State extends Hyper_AmiMultifeeds_Cat_State{
}

/**
 * AmiMultifeeds/Articles configuration category admin form component action controller.
 *
 * @package    Config_AmiMultifeeds_Articles
 * @subpackage Controller
 * @resource   {$modId}_cat/form/controller/adm <code>AMI::getResource('{$modId}_cat/form/controller/adm')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_ArticlesCat_FormFrn extends Hyper_AmiMultifeeds_Cat_FormFrn{
    /**
     * Initialization.
     *
     * @return AmiMultifeeds_ArticlesCat_FormAdm
     */
    public function init(){
        AMI::setProperty($this->getModId(), 'picture_cat', 'photoalbum');
        return parent::init();
    }
}

/**
 * AmiMultifeeds/Articles configuration category form component view.
 *
 * @package    Config_AmiMultifeeds_Articles
 * @subpackage View
 * @resource   {$modId}_cat/form/view/adm <code>AMI::getResource('{$modId}_cat/form/view/adm')*</code>
 * @since      6.0.2
 */
class AmiMultifeeds_ArticlesCat_FormViewFrn extends Hyper_AmiMultifeeds_Cat_FormViewFrn{
}

/**
 * AmiMultifeeds/Articles configuration category list component controller.
 *
 * @package    Config_AmiMultifeeds_Articles
 * @subpackage Controller
 * @resource   {$modId}/list/controller/frn <code>AMI::getResource('{$modId}/list/controller/frn')*</code>
 * @since      7.0.0
 */
class AmiMultifeeds_ArticlesCat_ListFrn extends Hyper_AmiMultifeeds_ListFrn{
}

/**
 * AmiMultifeeds/Articles configuration category list component view.
 *
 * @package    Config_AmiMultifeeds_Articles
 * @subpackage View
 * @resource   {$modId}/list/view/frn <code>AMI::getResource('{$modId}/list/view/frn')*</code>
 * @since      7.0.0
 */
class AmiMultifeeds_ArticlesCat_ListViewFrn extends Hyper_AmiMultifeeds_CatListViewFrn{
}
