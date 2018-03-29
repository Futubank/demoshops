<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiLoginHistory_LoginHistory 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2718 xkqwpiltysxnrzgmwxknlpmgqxzwtrumzzrtpmsyqryzrpwxpupnrrgpslpskqnqwqqgpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiJobs/LoginHistory configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiLoginHistory_LoginHistory
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiLoginHistory_LoginHistory_Table extends Hyper_AmiLoginHistory_Table{
    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){

        // select id, login, domain, status, ip, date_format(date, '%d.%m.%Y %H:%i:%s' ) as fdate from cms_host_login_history where ( `ip` not in ( '92.125.152.98' , '92.125.152.101', '89.189.185.215', '37.194.252.244' ) and (date>= '1980-01-01 00:00:00' ) and (date<= '2034-12-31 23:59:59' ) ) order by id, id desc limit 10

        $this->tableName = 'cms_host_login_history';

        parent::__construct($aAttributes);

        $aRemap = array(
            'id' => 'id',
        );
        $this->addFieldsRemap($aRemap);
    }

    /**
     * Sets new table name for a model.
     *
     * @param string $tableName  New table name
     * @return void
     * @amidev Temporary
     */
    public function setTableName($tableName){
        // do nothing!
    }
}

/**
 * AmiJobs/LoginHistory configuration table item model.
 *
 * @package    Config_AmiLoginHistory_LoginHistory
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiLoginHistory_LoginHistory_TableItem extends Hyper_AmiLoginHistory_TableItem{
}

/**
 * AmiJobs/LoginHistory configuration table list model.
 *
 * @package    Config_AmiLoginHistory_LoginHistory
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiLoginHistory_LoginHistory_TableList extends Hyper_AmiLoginHistory_TableList{
}
