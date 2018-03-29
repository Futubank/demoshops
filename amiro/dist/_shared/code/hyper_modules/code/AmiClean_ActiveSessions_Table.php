<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module_ActiveSessions 
 * @version    $Id$ 
 * @size       4909 xkqwiklwztsxrzkrmyrrtgmuplskrtrxllsuzumigxngmwqlsyxsrznmurukupntiqmmpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Module Manager module table model.
 *
 * See {@link AMI_ArrayIterator::getAvailableFields()} for common fields description.
 *
 * @package    Module_ActiveSessions
 * @subpackage Model
 * @amidev
 */
class AmiClean_ActiveSessions_Table extends AMI_ArrayIterator{
    /**
     * Table fields and field types as result of DESCRIBE
     *
     * @var array
     */
    protected $aFields = array('id', 'type', 'expired', 'nickname', 'username', 'email', 'ip');

    /**
     * Returns item model object and load data for primary key field param.
     *
     * @param  mixed $id       Primary key value
     * @param  array $aFields  Fields to load
     * @return ActiveSessions_TableItem
     * @see    ActiveSessions_TableItem::addFields() for $aFields parameter explanation
     */
    public function find($id, array $aFields = array()){
        $aConditions = array('id' => $id);
        $oItem = $this->findByFields($aConditions, $aFields);
        if($oItem){
            $oItem->addSearchCondition($aConditions);
            $oItem->load();
        }
        return $oItem;
    }
}

/**
 * Module Manager module table list model.
 *
 * Full environment is requred.
 *
 * @package    Module_ActiveSessions
 * @subpackage Model
 * @amidev
 */
class AmiClean_ActiveSessions_TableList extends AMI_ArrayIteratorList{
    /**
     * Loads registered modules list and init recordset.
     *
     * @return ActiveSessions_TableItem
     */
    public function load(){
        global $Core;
        $aEvent = array(
            'modId' => $this->getModId(),
            'oList' => $this,
        );
        /**
         * -----------------
         *
         * @event      on_list_recordset $modId
         * @eventparam string modId  Module id
         * @eventparam ModManager_TableList oList  Table list object
         */
        AMI_Event::fire('on_list_recordset', $aEvent, $this->getModId());
        $aSessions = array();
        if(isset($Core) && is_object($Core) && $Core instanceof CMS_Core){
            $aSessions = $Core->getSessions();
        }else{
            $aSessions = AMI::getSingleton('core')->getSessions();
        }

        $this->aRaw = array();
        foreach($aSessions as $aSessionData) {
            $aUserData = unserialize($aSessionData['data']);
            $IlIl1IL = isset($aUserData['user']) ? 'user' : 'user_';
            if(is_string($aUserData[$IlIl1IL])) {
                $aUserData[$IlIl1IL] = unserialize($aUserData[$IlIl1IL]);
            }
            $this->aRaw[] = array(
                'id' => $aSessionData['id'],
                'type' => isset($aUserData['loginType']) ? 'admin' : 'front',
                'expired' => $aSessionData['expired'],
                'nickname' => isset($aUserData[$IlIl1IL]['nickname']) ? $aUserData[$IlIl1IL]['nickname'] : '',
                'username' => isset($aUserData[$IlIl1IL]['username']) ? $aUserData[$IlIl1IL]['username'] : '',
                'email' => isset($aUserData[$IlIl1IL]['email']) ? $aUserData[$IlIl1IL]['email'] : '',
                'ip' => $aSessionData['ip']
            );
        }

        $sortField = $this->getSortField() == 'taborder' ? 'sort_taborder' : $this->getSortField();
        $sortDirection = $this->sortDirection;
        $this->sortDirection = $sortDirection;
        $this->filterByConditions();
        $this->total = sizeof($this->aRaw);
        $this->sortList($sortField, $sortField != 'order' ? null : SORT_NUMERIC);
        $this->storeKeys('id');
        $this->loadCurrentPage();
        $this->seek($this->start);
        $this->aRaw = FALSE;
        return $this;
    }
}

/**
 * Module Manager module table item model.
 *
 * @package    Module_ActiveSessions
 * @subpackage Model
 * @amidev
 */
class AmiClean_ActiveSessions_TableItem extends AMI_ArrayIteratorItem{

    /**
     * Returns primary key field name.
     *
     * @return string
     */
    public function getPrimaryKeyField(){
        return 'id';
    }

    /**
     * Loads data.
     *
     * @return ActiveSessions_TableItem
     */
    public function load(){
        return $this;
    }

    public function delete() {
        global $Core;
        if(isset($Core) && is_object($Core) && $Core instanceof CMS_Core){
            $Core->expireUserSession($this->id);
        }else{
            AMI::getSingleton('core')->expireUserSession($this->id);
        }
        $this->id = null;
        return $this;
    }
}
