<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiJobs 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3423 xkqwyyrurzixtinslmpipmtiwipitnpqkkunyxnznmmtywgwgwwtptxqsntnwkyxwsmppnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiJobs hypermodule admin action controller.
 *
 * @package    Hyper_AmiJobs
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiJobs_Adm extends AMI_Module_Adm{
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
 * @package    Hyper_AmiJobs
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiJobs_State extends AMI_ModState{
}

/**
 * AmiJobs hypermodule admin filter component action controller.
 *
 * @package    Hyper_AmiJobs
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiJobs_FilterAdm extends AMI_Module_FilterAdm{
}

/**
 * AmiJobs hypermodule item list component filter model.
 *
 * @package    Hyper_AmiJobs
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiJobs_FilterModelAdm extends AMI_Module_FilterModelAdm{
}

/**
 * AmiJobs hypermodule admin filter component view.
 *
 * @package    Hyper_AmiJobs
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiJobs_FilterViewAdm extends AMI_Module_FilterViewAdm{
}

/**
 * AmiJobs hypermodule admin form component action controller.
 *
 * @package    Hyper_AmiJobs
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiJobs_FormAdm extends AMI_Module_FormAdm{
}

/**
 * AmiJobs hypermodule admin form component view.
 *
 * @package    Hyper_AmiJobs
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiJobs_FormViewAdm extends AMI_Module_FormViewAdm{
}

/**
 * AmiJobs hypermodule admin list component action controller.
 *
 * @package    Hyper_AmiJobs
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiJobs_ListAdm extends AMI_Module_ListAdm{
}

/**
 * AmiJobs hypermodule admin list component actions controller.
 *
 * @package    Hyper_AmiJobs
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiJobs_ListActionsAdm extends AMI_Module_ListActionsAdm{
}

/**
 * AmiJobs hypermodule admin list component group actions controller.
 *
 * @package    Hyper_AmiJobs
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiJobs_ListGroupActionsAdm extends AMI_Module_ListGroupActionsAdm{
}

/**
 * AmiJobs hypermodule admin list component view.
 *
 * @package    Hyper_AmiJobs
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiJobs_ListViewAdm extends AMI_Module_ListViewAdm{
}
