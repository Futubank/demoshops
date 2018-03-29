<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiClean 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       3316 xkqwpwzlqsuxxkuzkxwtgtniymwqpwsnsxkuiuwttkiplgzliwtuwwlllxqsnuqynlzzpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Base hypermodule admin action controller.
 *
 * @package    Hyper_AmiClean
 * @subpackage Controller
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_Adm extends AMI_Mod{
}

/**
 * Base hypermodule model.
 *
 * @package    Hyper_AmiClean
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_State extends AMI_ModState{
}

/**
 * Base hypermodule admin filter component action controller.
 *
 * @package    Hyper_AmiClean
 * @subpackage Controller
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_FilterAdm extends AMI_ModFilter{
}

/**
 * Base hypermodule item list component filter model.
 *
 * @package    Hyper_AmiClean
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_FilterModelAdm extends AMI_Filter{
}

/**
 * Base hypermodule admin filter component view.
 *
 * @package    Hyper_AmiClean
 * @subpackage View
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_FilterViewAdm extends AMI_ModFilterViewAdm{
}

/**
 * Base hypermodule admin form component action controller.
 *
 * @package    Hyper_AmiClean
 * @subpackage Controller
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_FormAdm extends AMI_ModFormAdm{
}

/**
 * Base hypermodule admin form component view.
 *
 * @package    Hyper_AmiClean
 * @subpackage View
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_FormViewAdm extends AMI_ModFormViewAdm{
}

/**
 * Base hypermodule admin list component action controller.
 *
 * @package    Hyper_AmiClean
 * @subpackage Controller
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_ListAdm extends AMI_ModListAdm{
}

/**
 * Base hypermodule admin list component view.
 *
 * @package    Hyper_AmiClean
 * @subpackage View
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_ListViewAdm extends AMI_ModListView_JSON{
}

/**
 * Base hypermodule list action controller.
 *
 * @category   AMI
 * @package    Hyper_AmiClean
 * @subpackage Controller
 * @since      6.0.2
 */
class Hyper_AmiClean_ListActionsAdm  extends AMI_ModListActions{
}

/**
 * Base hypermodule list group action controller.
 *
 * @category   AMI
 * @package    Hyper_AmiClean
 * @subpackage Controller
 * @since      6.0.2
 */
class Hyper_AmiClean_ListGroupActionsAdm  extends AMI_ModListGroupActions{
}

/**
 * Base hypermodule custom component controller.
 *
 * @package    Hyper_AmiClean
 * @subpackage Controller
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_ComponentAdm extends AMI_CustomComponent{
}

/**
 * Base hypermodule custom component view.
 *
 * @package    Hyper_AmiClean
 * @subpackage View
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_ComponentViewAdm extends AMI_CustomComponentView{
}
