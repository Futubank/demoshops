<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiRelations 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3533 xkqwlqnntktkziqpustrinktrkxwpltkgkiisiyuxgznqztmiipgtlyisnxxmqkmmtrtpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiRelations hypermodule admin action controller.
 *
 * @package    Hyper_AmiRelations
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiRelations_Adm extends AMI_Mod{
}

/**
 * AmiRelations hypermodule model.
 *
 * @package    Hyper_AmiRelations
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiRelations_State extends AMI_ModState{
}

/**
 * AmiRelations hypermodule admin filter component action controller.
 *
 * @package    Hyper_AmiRelations
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiRelations_FilterAdm extends AMI_ModFilter{
}

/**
 * AmiRelations hypermodule item list component filter model.
 *
 * @package    Hyper_AmiRelations
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiRelations_FilterModelAdm extends AMI_Filter{
}

/**
 * AmiRelations hypermodule admin filter component view.
 *
 * @package    Hyper_AmiRelations
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiRelations_FilterViewAdm extends AMI_ModFilterViewAdm{
}

/**
 * AmiRelations hypermodule admin form component action controller.
 *
 * @package    Hyper_AmiRelations
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiRelations_FormAdm extends AMI_ModFormAdm{
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
 * AmiRelations hypermodule admin form component view.
 *
 * @package    Hyper_AmiRelations
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiRelations_FormViewAdm extends AMI_ModFormViewAdm{
}

/**
 * AmiRelations hypermodule admin list component action controller.
 *
 * @package    Hyper_AmiRelations
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiRelations_ListAdm extends AMI_ModListAdm{
}

/**
 * AmiRelations hypermodule admin list component view.
 *
 * @package    Hyper_AmiRelations
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiRelations_ListViewAdm extends AMI_ModListView_JSON{
}

/**
 * AmiRelations hypermodule list action controller.
 *
 * @category   AMI
 * @package    Hyper_AmiRelations
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiRelations_ListActionsAdm extends AMI_ModListActions{
}

/**
 * AmiRelations hypermodule list group action controller.
 *
 * @category   AMI
 * @package    Hyper_AmiRelations
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiRelations_ListGroupActionsAdm extends AMI_ModListGroupActions{
}
