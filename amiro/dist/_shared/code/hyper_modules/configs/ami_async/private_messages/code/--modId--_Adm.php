<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module_##modId## 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3082 xkqwkygqmgkrlslpiyrllprxtxnmkntwpzyzulximmukrpsnrlrgriukqqwwmuqtkwszpnir
 */
?><?php


class_exists('##modId##_Frn');

/**
 * Private Messages module admin action controller.
 *
 * @package    Module_##modId##
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class ##modId##_Adm extends AmiAsync_PrivateMessages_Adm{
}

/**
 * Private Messages module admin list component action controller.
 *
 * @category   AMI
 * @package    Module_##modId##
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class ##modId##_ListAdm extends ##modId##_ListFrn{
}

/**
 * Private Messages module admin list actions controller.
 *
 * @category   AMI
 * @package    Module_##modId##
 * @subpackage Controller
 * @amidev    Temporary
 */
class ##modId##_ListActionsAdm extends ##modId##_ListActionsFrn{
}

/**
 * Private Messages module admin list group actions controller.
 *
 * @category   AMI
 * @package    Module_##modId##
 * @subpackage Controller
 * @amidev    Temporary
 */
class ##modId##_ListGroupActionsAdm extends ##modId##_ListGroupActionsFrn{
}

/**
 * Private Messages module admin list component view.
 *
 * @package    AmiAsync/##modId##
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
class ##modId##_ListViewAdm extends ##modId##_ListViewFrn{
}

/**
 * Private Messages module admin form component action controller.
 *
 * @package    Module_##modId##
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class ##modId##_FormAdm extends ##modId##_FormFrn{
}

/**
 * Private Messages module form component view.
 *
 * @package    Module_##modId##
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
class ##modId##_FormViewAdm extends AmiAsync_PrivateMessages_FormViewAdm{
}

/**
 * Module model.
 *
 * @category   AMI
 * @package    Module_##modId##
 * @since      x.x.x
 * @amidev     Temporary
 */
class ##modId##_State extends Hyper_AmiAsync_State{
}

/**
 * Private Messages module admin filter component action controller.
 *
 * @package    AmiAsync/##modId##
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class ##modId##_FilterAdm extends ##modId##_FilterFrn{
}

/**
 * Private Messages module item list component filter model.
 *
 * @package    AmiAsync/##modId##
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class ##modId##_FilterModelAdm extends ##modId##_FilterModelFrn{
}

/**
 * Private Messages module admin filter component view.
 *
 * @package    Module_##modId##
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
class ##modId##_FilterViewAdm extends ##modId##_FilterViewFrn{
}