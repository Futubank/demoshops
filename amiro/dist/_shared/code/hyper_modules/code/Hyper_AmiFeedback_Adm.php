<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiFeedback 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3555 xkqwttuyultyqyyqmymlsxpgmtsmlqwsrqzpstkkzpxmrsxttxnyrgtwtpzmkzxrzlyzpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiFeedback hypermodule admin action controller.
 *
 * @package    Hyper_AmiFeedback
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiFeedback_Adm extends AMI_Module_Adm{
}

/**
 * Module model.
 *
 * @package    Hyper_AmiFeedback
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiFeedback_State extends AMI_ModState{
}

/**
 * AmiFeedback hypermodule admin filter component action controller.
 *
 * @package    Hyper_AmiFeedback
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiFeedback_FilterAdm extends AMI_Module_FilterAdm{
}

/**
 * AmiFeedback hypermodule item list component filter model.
 *
 * @package    Hyper_AmiFeedback
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiFeedback_FilterModelAdm extends AMI_Module_FilterModelAdm{
}

/**
 * AmiFeedback hypermodule admin filter component view.
 *
 * @package    Hyper_AmiFeedback
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiFeedback_FilterViewAdm extends AMI_Module_FilterViewAdm{
}

/**
 * AmiFeedback hypermodule admin form component action controller.
 *
 * @package    Hyper_AmiFeedback
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiFeedback_FormAdm extends AMI_Module_FormAdm{
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
 * AmiFeedback hypermodule admin form component view.
 *
 * @package    Hyper_AmiFeedback
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiFeedback_FormViewAdm extends AMI_Module_FormViewAdm{
}

/**
 * AmiFeedback hypermodule admin list component action controller.
 *
 * @package    Hyper_AmiFeedback
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiFeedback_ListAdm extends AMI_Module_ListAdm{
}

/**
 * AmiFeedback hypermodule admin list component actions controller.
 *
 * @package    Hyper_AmiFeedback
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiFeedback_ListActionsAdm extends AMI_Module_ListActionsAdm{
}

/**
 * AmiFeedback hypermodule admin list component group actions controller.
 *
 * @package    Hyper_AmiFeedback
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiFeedback_ListGroupActionsAdm extends AMI_Module_ListGroupActionsAdm{
}

/**
 * AmiFeedback hypermodule admin list component view.
 *
 * @package    Hyper_AmiFeedback
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiFeedback_ListViewAdm extends AMI_Module_ListViewAdm{
}
