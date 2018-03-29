<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiForum_Cat 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3697 xkqwiyqnywnzxzisgmnkxgrwlssmxgxplxiwqtimmmmwkxkzpgzmspmgwnxqruszmssppnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiForum hypermodule admin action controller.
 *
 * @package    Hyper_AmiForum_Cat
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_Cat_Adm extends Hyper_AmiMultifeeds_Cat_Adm{
}

/**
 * AmiForum hypermodule model.
 *
 * @package    Hyper_AmiForum_Cat
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_Cat_State extends Hyper_AmiMultifeeds_Cat_State{
}

/**
 * AmiForum hypermodule admin filter component action controller.
 *
 * @package    Hyper_AmiForum_Cat
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_Cat_FilterAdm extends Hyper_AmiMultifeeds_Cat_FilterAdm{
}

/**
 * AmiForum hypermodule item list component filter model.
 *
 * @package    Hyper_AmiForum_Cat
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_Cat_FilterModelAdm extends Hyper_AmiMultifeeds_Cat_FilterModelAdm{
}

/**
 * AmiForum hypermodule admin filter component view.
 *
 * @package    Hyper_AmiForum_Cat
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_Cat_FilterViewAdm extends Hyper_AmiMultifeeds_Cat_FilterViewAdm{
}

/**
 * AmiForum hypermodule admin form component action controller.
 *
 * @package    Hyper_AmiForum_Cat
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_Cat_FormAdm extends Hyper_AmiMultifeeds_Cat_FormAdm{
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
 * @package    Hyper_AmiForum_Cat
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_Cat_FormViewAdm extends Hyper_AmiMultifeeds_Cat_FormViewAdm{
}

/**
 * AmiForum hypermodule admin list component action controller.
 *
 * @package    Hyper_AmiForum_Cat
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_Cat_ListAdm extends Hyper_AmiMultifeeds_Cat_ListAdm{
}

/**
 * AmiForum hypermodule admin list component view.
 *
 * @package    Hyper_AmiForum_Cat
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiForum_Cat_ListViewAdm extends Hyper_AmiMultifeeds_Cat_ListViewAdm{
}

/**
 * AmiForum hypermodule list action controller.
 *
 * @category   AMI
 * @package    Hyper_AmiForum_Cat
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiForum_Cat_ListActionsAdm extends Hyper_AmiMultifeeds_Cat_ListActionsAdm{
}

/**
 * AmiForum hypermodule list group action controller.
 *
 * @category   AMI
 * @package    Hyper_AmiForum_Cat
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiForum_Cat_ListGroupActionsAdm extends Hyper_AmiMultifeeds_Cat_ListGroupActionsAdm{
}
