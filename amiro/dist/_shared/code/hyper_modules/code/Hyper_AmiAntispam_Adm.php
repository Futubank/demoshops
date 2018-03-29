<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiAntispam 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3461 xkqwrzimtnuzktmwmzzumwtrxupgzlmzxxsxuqwzitqmzmiynxlrmltlmwlxqutumnsipnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiAntispam hypermodule admin action controller.
 *
 * @package    Hyper_AmiAntispam
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAntispam_Adm extends AMI_Mod{
}

/**
 * AmiAntispam hypermodule model.
 *
 * @package    Hyper_AmiAntispam
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAntispam_State extends AMI_ModState{
}

/**
 * AmiAntispam hypermodule admin filter component action controller.
 *
 * @package    Hyper_AmiAntispam
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAntispam_FilterAdm extends AMI_ModFilter{
}

/**
 * AmiAntispam hypermodule item list component filter model.
 *
 * @package    Hyper_AmiAntispam
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAntispam_FilterModelAdm extends AMI_Filter{
}

/**
 * AmiAntispam hypermodule admin filter component view.
 *
 * @package    Hyper_AmiAntispam
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAntispam_FilterViewAdm extends AMI_ModFilterViewAdm{
}

/**
 * AmiAntispam hypermodule admin form component action controller.
 *
 * @package    Hyper_AmiAntispam
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAntispam_FormAdm extends AMI_ModFormAdm{
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
 * AmiAntispam hypermodule admin form component view.
 *
 * @package    Hyper_AmiAntispam
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAntispam_FormViewAdm extends AMI_ModFormViewAdm{
}

/**
 * AmiAntispam hypermodule admin list component action controller.
 *
 * @package    Hyper_AmiAntispam
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAntispam_ListAdm extends AMI_ModListAdm{
}

/**
 * AmiAntispam hypermodule admin list component view.
 *
 * @package    Hyper_AmiAntispam
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAntispam_ListViewAdm extends AMI_ModListView_JSON{
}

/**
 * AmiAntispam hypermodule list action controller.
 *
 * @package    Hyper_AmiAntispam
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiAntispam_ListActionsAdm  extends AMI_ModListActions{
}

/**
 * AmiAntispam hypermodule list group action controller.
 *
 * @package    Hyper_AmiAntispam
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiAntispam_ListGroupActionsAdm  extends AMI_ModListGroupActions{
}
