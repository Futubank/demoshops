<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiSearch 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3489 xkqwuriipkyxqrxmsinpwlpqskuirqplupwzrmkwyyrzpznzqtgupltsguqytgkxgiwipnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiSearch hypermodule admin action controller.
 *
 * @package    Hyper_AmiSearch
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSearch_Adm extends AMI_Module_Adm{
}

/**
 * Module model.
 *
 * @package    Hyper_AmiSearch
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSearch_State extends AMI_ModState{
}

/**
 * AmiSearch hypermodule admin filter component action controller.
 *
 * @package    Hyper_AmiSearch
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSearch_FilterAdm extends AMI_Module_FilterAdm{
}

/**
 * AmiSearch hypermodule item list component filter model.
 *
 * @package    Hyper_AmiSearch
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSearch_FilterModelAdm extends AMI_Module_FilterModelAdm{
}

/**
 * AmiSearch hypermodule admin filter component view.
 *
 * @package    Hyper_AmiSearch
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSearch_FilterViewAdm extends AMI_Module_FilterViewAdm{
}

/**
 * AmiSearch hypermodule admin form component action controller.
 *
 * @package    Hyper_AmiSearch
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSearch_FormAdm extends AMI_Module_FormAdm{
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
 * AmiSearch hypermodule admin form component view.
 *
 * @package    Hyper_AmiSearch
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSearch_FormViewAdm extends AMI_Module_FormViewAdm{
}

/**
 * AmiSearch hypermodule admin list component action controller.
 *
 * @package    Hyper_AmiSearch
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSearch_ListAdm extends AMI_Module_ListAdm{
}

/**
 * AmiSearch hypermodule admin list component actions controller.
 *
 * @package    Hyper_AmiSearch
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSearch_ListActionsAdm extends AMI_Module_ListActionsAdm{
}

/**
 * AmiSearch hypermodule admin list component group actions controller.
 *
 * @package    Hyper_AmiSearch
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSearch_ListGroupActionsAdm extends AMI_Module_ListGroupActionsAdm{
}

/**
 * AmiSearch hypermodule admin list component view.
 *
 * @package    Hyper_AmiSearch
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSearch_ListViewAdm extends AMI_Module_ListViewAdm{
}
