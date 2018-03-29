<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiAccessRights 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       4001 xkqwzgztgmwktrkqxklzwnmqmininzqxxtwxlngqxksykxxqyrzguqxkwtnzxmquzltmpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiAccessRights hypermodule admin action controller.
 *
 * @package    Hyper_AmiAccessRights
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAccessRights_Adm extends AMI_Mod{
    /**
     * Constructor.
     *
     * @param AMI_Request  $oRequest   Request object
     * @param AMI_Response $oResponse  Response object
     */
    public function __construct(AMI_Request $oRequest, AMI_Response $oResponse){
        parent::__construct($oRequest, $oResponse);
        $this->addComponents(array('filter', 'list', 'form'));
    }
}

/**
 * AmiAccessRights hypermodule model.
 *
 * @package    Hyper_AmiAccessRights
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAccessRights_State extends AMI_ModState{
}

/**
 * AmiAccessRights hypermodule admin filter component action controller.
 *
 * @package    Hyper_AmiAccessRights
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAccessRights_FilterAdm extends AMI_ModFilter{
}

/**
 * AmiAccessRights hypermodule item list component filter model.
 *
 * @package    Hyper_AmiAccessRights
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAccessRights_FilterModelAdm extends AMI_Filter{
}

/**
 * AmiAccessRights hypermodule admin filter component view.
 *
 * @package    Hyper_AmiAccessRights
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAccessRights_FilterViewAdm extends AMI_ModFilterViewAdm{
}

/**
 * AmiAccessRights hypermodule admin form component action controller.
 *
 * @package    Hyper_AmiAccessRights
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAccessRights_FormAdm extends AMI_ModFormAdm{
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
 * AmiAccessRights hypermodule admin form component view.
 *
 * @package    Hyper_AmiAccessRights
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAccessRights_FormViewAdm extends AMI_ModFormViewAdm{
}

/**
 * AmiAccessRights hypermodule admin list component action controller.
 *
 * @package    Hyper_AmiAccessRights
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAccessRights_ListAdm extends AMI_ModListAdm{
}

/**
 * AmiAccessRights hypermodule admin list component view.
 *
 * @package    Hyper_AmiAccessRights
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiAccessRights_ListViewAdm extends AMI_ModListView_JSON{
}

/**
 * AmiAccessRights hypermodule list action controller.
 *
 * @category   AMI
 * @package    Hyper_AmiAccessRights
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiAccessRights_ListActionsAdm  extends AMI_ModListActions{
}

/**
 * AmiAccessRights hypermodule list group action controller.
 *
 * @category   AMI
 * @package    Hyper_AmiAccessRights
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiAccessRights_ListGroupActionsAdm  extends AMI_ModListGroupActions{
}
