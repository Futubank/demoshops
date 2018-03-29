<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiForum 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3521 xkqwlnpynqgiuruqkmzrqglmyytttmggxuupqiyuzruyqiwriwtnywpkywqugzgtnqutpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiForum hypermodule admin action controller.
 *
 * @package    Hyper_AmiForum
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_Adm extends Hyper_AmiMultifeeds_Adm{
}

/**
 * AmiForum hypermodule model.
 *
 * @package    Hyper_AmiForum
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_State extends Hyper_AmiMultifeeds_State{
}

/**
 * AmiForum hypermodule admin filter component action controller.
 *
 * @package    Hyper_AmiForum
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_FilterAdm extends Hyper_AmiMultifeeds_FilterAdm{
}

/**
 * AmiForum hypermodule item list component filter model.
 *
 * @package    Hyper_AmiForum
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_FilterModelAdm extends Hyper_AmiMultifeeds_FilterModelAdm{
}

/**
 * AmiForum hypermodule admin filter component view.
 *
 * @package    Hyper_AmiForum
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_FilterViewAdm extends Hyper_AmiMultifeeds_FilterViewAdm{
}

/**
 * AmiForum hypermodule admin form component action controller.
 *
 * @package    Hyper_AmiForum
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_FormAdm extends Hyper_AmiMultifeeds_FormAdm{
    /**
     * Returns true if component needs to be started always in full environment.
     *
     * @return bool
     */
    public function isFullEnv(){
        return FALSE;
    }
}

/**
 * AmiForum hypermodule admin form component view.
 *
 * @package    Hyper_AmiForum
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_FormViewAdm extends Hyper_AmiMultifeeds_FormViewAdm{
}

/**
 * AmiForum hypermodule admin list component action controller.
 *
 * @package    Hyper_AmiForum
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_ListAdm extends Hyper_AmiMultifeeds_ListAdm{
}

/**
 * AmiForum hypermodule admin list component view.
 *
 * @package    Hyper_AmiForum
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_ListViewAdm extends Hyper_AmiMultifeeds_ListViewAdm{
}

/**
 * AmiForum hypermodule list action controller.
 *
 * @package    Hyper_AmiForum
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiForum_ListActionsAdm extends Hyper_AmiMultifeeds_ListActionsAdm{
}

/**
 * AmiForum hypermodule list group action controller.
 *
 * @package    Hyper_AmiForum
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiForum_ListGroupActionsAdm extends Hyper_AmiMultifeeds_ListGroupActionsAdm{
}
