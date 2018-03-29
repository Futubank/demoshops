<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds_ClassifiedsCat 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       6610 xkqwitrnknkwxulwnqgmyxsspzppzqqzxrkypylpggmupxnqsxrtwstzmznnwkxqwkprpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds/Classifieds configuration admin action controller.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage Controller
 * @resource   {$modId}_cat/module/controller/adm <code>AMI::getResource('{$modId}_cat/module/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_Adm extends Hyper_AmiMultifeeds_Cat_Adm{
}

/**
 * AmiMultifeeds/Classifieds configuration model.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage Model
 * @resource   {$modId}_cat/module/model <code>AMI::getResourceModel('{$modId}_cat/module')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_State extends Hyper_AmiMultifeeds_Cat_State{
}

/**
 * AmiMultifeeds/Classifieds configuration admin filter component action controller.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage Controller
 * @resource   {$modId}_cat/filter/controller/adm <code>AMI::getResource('{$modId}_cat/filter/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_FilterAdm extends Hyper_AmiMultifeeds_Cat_FilterAdm{
}

/**
 * AmiMultifeeds/Classifieds configuration item list component filter model.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage Model
 * @resource   {$modId}_cat/filter/model/adm <code>AMI::getResource('{$modId}_cat/filter/model/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_FilterModelAdm extends Hyper_AmiMultifeeds_Cat_FilterModelAdm{
}

/**
 * AmiMultifeeds/Classifieds configuration admin filter component view.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage View
 * @resource   {$modId}_cat/filter/view/adm <code>AMI::getResource('{$modId}_cat/filter/view/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_FilterViewAdm extends Hyper_AmiMultifeeds_Cat_FilterViewAdm{
}

/**
 * AmiMultifeeds/Classifieds configuration admin form component action controller.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage Controller
 * @resource   {$modId}_cat/form/controller/adm <code>AMI::getResource('{$modId}_cat/form/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_FormAdm extends Hyper_AmiMultifeeds_Cat_FormAdm{
}

/**
 * AmiMultifeeds/Classifieds configuration form component view.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage View
 * @resource   {$modId}_cat/form/view/adm <code>AMI::getResource('{$modId}_cat/form/view/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_FormViewAdm extends Hyper_AmiMultifeeds_Cat_FormViewAdm{
    /**
     * Initialize fields.
     *
     * @see    AMI_View::init()
     * @return AMI_View
     */
    public function init(){
        return parent::init();
    }
}

/**
 * AmiMultifeeds/Classifieds configuration admin list component action controller.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage Controller
 * @resource   {$modId}_cat/list/controller/adm <code>AMI::getResource('{$modId}_cat/list/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_ListAdm extends Hyper_AmiMultifeeds_Cat_ListAdm{
    /**
     * Initialization.
     *
     * @return AmiMultifeeds_ClassifiedsCat_ListAdm
     */
    public function init(){
        parent::init();

        $this->dropActions(AMI_ModListAdm::ACTION_ALL, array('index_details', 'no_index_details'));

        return $this;
    }
}

/**
 * AmiMultifeeds/Classifieds configuration admin list component view.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage View
 * @resource   {$modId}_cat/list/view/adm <code>AMI::getResource('{$modId}_cat/list/view/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_ListViewAdm extends Hyper_AmiMultifeeds_Cat_ListViewAdm{

    /**
     * List default elemnts template (placeholders)
     *
     * @var array
     * @see AMI_ModPlaceholderView::addPlaceholders()
     * @see AMI_ModPlaceholderView::putPlaceholder()
     */
    protected $aPlaceholders = array(
        '#list_header',
            '#flags', 'position', 'public', 'flags',
            '#common', 'cat_header', 'common',
            '#columns', 'header', 'announce', 'num_items', 'id_page', 'columns',
            '#actions', 'front_view', 'edit', 'actions',
        'list_header'
    );

    /**
     * Order column
     *
     * @var string
     */
    protected $orderColumn = 'header';

    /**
     * Init columns.
     *
     * @see    AMI_View::init()
     * @return AmiMultifeeds_ClassifiedsCat_ListViewAdm
     */
    public function init(){
        parent::init();

        $this->setColumnTensility('header', false);

        return $this;
    }
}

/**
 * AmiMultifeeds/Classifieds configuration module admin list actions controller.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage Controller
 * @resource   {$modId}_cat/list_actions/controller/adm <code>AMI::getResource('{$modId}_cat/list_actions/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_ListActionsAdm extends Hyper_AmiMultifeeds_Cat_ListActionsAdm{
}

/**
 * AmiMultifeeds/Classifieds configuration module admin list group actions controller.
 *
 * @package    Config_AmiMultifeeds_ClassifiedsCat
 * @subpackage Controller
 * @resource   {$modId}_cat/list_group_actions/controller/adm <code>AMI::getResource('{$modId}_cat/list_group_actions/controller/adm')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_ClassifiedsCat_ListGroupActionsAdm extends Hyper_AmiMultifeeds_Cat_ListGroupActionsAdm{
}
