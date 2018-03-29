<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiEshopDiscounts 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       4268 xkqwgmgxkikzmtirwmsyxtrixrnqgpwmrnplmgqnzknikxsqmrpgtrpygytpxlwlzmlupnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiEshopDiscounts hypermodule admin action controller.
 *
 * @package    Hyper_AmiEshopDiscounts
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiEshopDiscounts_Adm extends AMI_Module_Adm{
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
 * Module model.
 *
 * @package    Hyper_AmiEshopDiscounts
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiEshopDiscounts_State extends AMI_ModState{
}

/**
 * AmiEshopDiscounts hypermodule admin filter component action controller.
 *
 * @package    Hyper_AmiEshopDiscounts
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiEshopDiscounts_FilterAdm extends AMI_Module_FilterAdm{
}

/**
 * AmiEshopDiscounts hypermodule item list component filter model.
 *
 * @package    Hyper_AmiEshopDiscounts
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiEshopDiscounts_FilterModelAdm extends AMI_Module_FilterModelAdm{
}

/**
 * AmiEshopDiscounts hypermodule admin filter component view.
 *
 * @package    Hyper_AmiEshopDiscounts
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiEshopDiscounts_FilterViewAdm extends AMI_Module_FilterViewAdm{
}

/**
 * AmiEshopDiscounts hypermodule admin form component action controller.
 *
 * @package    Hyper_AmiEshopDiscounts
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiEshopDiscounts_FormAdm extends AMI_Module_FormAdm{
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
 * AmiEshopDiscounts hypermodule admin form component view.
 *
 * @package    Hyper_AmiEshopDiscounts
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiEshopDiscounts_FormViewAdm extends AMI_Module_FormViewAdm{
}

/**
 * AmiEshopDiscounts hypermodule admin list component action controller.
 *
 * @package    Hyper_AmiEshopDiscounts
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiEshopDiscounts_ListAdm extends AMI_Module_ListAdm{
    /**
     * Initialization.
     *
     * @return AMI_Module_FormAdm
     */
    public function init(){
        parent::init();
        // Drop full-env action, replace with fast-env
        $this->dropActions('common', array('edit'));
        $this->addActions(array('edit'));
        return $this;
    }
}

/**
 * AmiEshopDiscounts hypermodule admin list component actions controller.
 *
 * @package    Hyper_AmiEshopDiscounts
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiEshopDiscounts_ListActionsAdm extends AMI_Module_ListActionsAdm{
}

/**
 * AmiEshopDiscounts hypermodule admin list component group actions controller.
 *
 * @package    Hyper_AmiEshopDiscounts
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiEshopDiscounts_ListGroupActionsAdm extends AMI_Module_ListGroupActionsAdm{
}

/**
 * AmiEshopDiscounts hypermodule admin list component view.
 *
 * @package    Hyper_AmiEshopDiscounts
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiEshopDiscounts_ListViewAdm extends AMI_Module_ListViewAdm{
}
