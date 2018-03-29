<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiLoginHistory 
 * @version    $Id$ 
 * @size       3839 xkqwrzzqipmixkzwqntwrgxyplmpymwsptqypmqurrqskkqipmzrwmkwwgzllwzgqgwmpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiLoginHistory hypermodule admin action controller.
 *
 * @package    Hyper_AmiLoginHistory
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiLoginHistory_Adm extends AMI_Mod{
}

/**
 * AmiLoginHistory hypermodule model.
 *
 * @package    Hyper_AmiLoginHistory
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiLoginHistory_State extends AMI_ModState{
}

/**
 * AmiLoginHistory hypermodule admin filter component action controller.
 *
 * @package    Hyper_AmiLoginHistory
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiLoginHistory_FilterAdm extends AMI_ModFilter{
}

/**
 * AmiLoginHistory hypermodule item list component filter model.
 *
 * @package    Hyper_AmiLoginHistory
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiLoginHistory_FilterModelAdm extends AMI_Filter{
}

/**
 * AmiLoginHistory hypermodule admin filter component view.
 *
 * @package    Hyper_AmiLoginHistory
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiLoginHistory_FilterViewAdm extends AMI_ModFilterViewAdm{
}

/**
 * AmiLoginHistory hypermodule admin form component action controller.
 *
 * @package    Hyper_AmiLoginHistory
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiLoginHistory_FormAdm extends AMI_ModFormAdm{
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
 * AmiLoginHistory hypermodule admin form component view.
 *
 * @package    Hyper_AmiLoginHistory
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiLoginHistory_FormViewAdm extends AMI_ModFormViewAdm{
}

/**
 * AmiLoginHistory hypermodule admin list component action controller.
 *
 * @package    Hyper_AmiLoginHistory
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiLoginHistory_ListAdm extends AMI_ModListAdm{
}

/**
 * AmiLoginHistory hypermodule admin list component view.
 *
 * @package    Hyper_AmiLoginHistory
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiLoginHistory_ListViewAdm extends AMI_ModListView_JSON{
    /**
     * Order column
     *
     * @var string
     */
    protected $orderColumn = 'date';

    /**
     * Order column direction
     *
     * @var bool
     */
    protected $orderDirection = 'desc';
}

/**
 * AmiLoginHistory hypermodule list action controller.
 *
 * @category   AMI
 * @package    Hyper_AmiLoginHistory
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiLoginHistory_ListActionsAdm  extends AMI_ModListActions{
}

/**
 * AmiLoginHistory hypermodule list group action controller.
 *
 * @category   AMI
 * @package    Hyper_AmiLoginHistory
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiLoginHistory_ListGroupActionsAdm  extends AMI_ModListGroupActions{
}

