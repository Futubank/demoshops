<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiAsync 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3703 xkqwuppxqiptrgkrxsmuixktrugumqqzqynxsqppuyimiqsuguqllnzqupxrstzipgulpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Front async hypermodule admin action controller.
 *
 * @package    Hyper_AmiAsync
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAsync_Adm extends AMI_Mod{
}

/**
 * Front async hypermodule model.
 *
 * @package    Hyper_AmiAsync
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAsync_State extends AMI_ModState{
}

/**
 * Front async hypermodule admin filter component action controller.
 *
 * @package    Hyper_AmiAsync
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAsync_FilterAdm extends AMI_ModFilter{
}

/**
 * Front async hypermodule item list component filter model.
 *
 * @package    Hyper_AmiAsync
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAsync_FilterModelAdm extends AMI_Filter{
}

/**
 * Front async hypermodule admin filter component view.
 *
 * @package    Hyper_AmiAsync
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAsync_FilterViewAdm extends AMI_ModFilterViewAdm{
}

/**
 * Front async hypermodule admin form component action controller.
 *
 * @package    Hyper_AmiAsync
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAsync_FormAdm extends AMI_ModFormAdm{
}

/**
 * Front async hypermodule admin form component view.
 *
 * @package    Hyper_AmiAsync
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAsync_FormViewAdm extends AMI_ModFormViewAdm{
}

/**
 * Front async hypermodule admin list component action controller.
 *
 * @package    Hyper_AmiAsync
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAsync_ListAdm extends AMI_ModListAdm{
}

/**
 * Front async hypermodule admin list component view.
 *
 * @package    Hyper_AmiAsync
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAsync_ListViewAdm extends AMI_ModListView_JSON{
}

/**
 * Front async hypermodule list action controller.
 *
 * @package    Hyper_AmiAsync
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiAsync_ListActionsAdm  extends AMI_ModListActions{
}

/**
 * Front async hypermodule list group action controller.
 *
 * @package    Hyper_AmiAsync
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiAsync_ListGroupActionsAdm  extends AMI_ModListGroupActions{
}

/**
 * Front async hypermodule front component controller.
 *
 * @package    Hyper_AmiAsync
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAsync_ComponentAdm extends AMI_CustomComponent{
}

/**
 * Front async hypermodule front component view.
 *
 * @package    Hyper_AmiAsync
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAsync_ComponentViewAdm extends AMI_CustomComponentView{
}
