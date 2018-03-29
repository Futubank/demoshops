<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    AmiExt_UserRating 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1577 xkqwyurrttkxgupsuiktpqsspzluqinuskypnugsrxiklwuwklqwzgukkpxqpmxirsszpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * User rating history table model.
 *
 * @package    AmiExt_UserRating
 * @subpackage Model
 * @resource   users/rating/table/model <code>AMI::getResourceModel('users/rating/table')</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class UserRatingHistory_Table extends AMI_ModTable{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_members_rating_history';
}

/**
 * News module table item model.
 *
 * @package    Users
 * @subpackage Model
 * @resource   users/rating/table/model/item <code>AMI::getResourceModel('users/rating/table')->getItem()</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class UserRatingHistory_TableItem extends AMI_ModTableItem{
}

/**
 * News module table list model.
 *
 * @package    Users
 * @subpackage Model
 * @resource   users/rating/table/model/list <code>AMI::getResourceModel('users/rating/table')->getList()</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class UserRatingHistory_TableList extends AMI_ModTableList{
}
