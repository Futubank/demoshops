<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    ModuleComponent 
 * @version    $Id$ 
 * @since      5.14.8 
 * @size       2543 xkqwwmrurxszlyztnngxiqnpkguqkplztwtwruqpptkwtprmmlmwluywkxrzmxqzskrrpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Specblock array iterator model.
 *
 * @package    ModuleComponent
 * @subpackage Model
 * @resource   specblock_array_iterator/table/model <code>AMI::getResourceModel('specblock_array_iterator/table', array($aItems))</code>
 * @since      5.14.8
 */
class AMI_ModSpecblock_ArrayIterator extends AMI_ArrayIterator{
    /**
     * Returns module Id.
     *
     * @return string
     */
    public function getModId(){
        return 'specblock_array_iterator';
    }
}

/**
 * Specblock array iterator item model.
 *
 * @package    ModuleComponent
 * @subpackage Model
 * @resource   specblock_array_iterator/table/model/item <code>AMI::getResourceModel('specblock_array_iterator/table', array($IteratorTable))->getItem()</code>
 * @since      5.14.8
 */
class AMI_ModSpecblock_ArrayIteratorItem extends AMI_ArrayIteratorItem{
    /**
     * Returns module Id.
     *
     * @return string
     */
    public function getModId(){
        return 'specblock_array_iterator';
    }
}

/**
 * Specblock array iterator list model.
 *
 * @package    ModuleComponent
 * @subpackage Model
 * @resource   specblock_array_iterator/table/model/list <code>AMI::getResource('specblock_array_iterator/table/model/list', array($IteratorTable))</code>
 * @since      5.14.8
 */
class AMI_ModSpecblock_ArrayIteratorList extends AMI_ArrayIteratorList{
    /**
     * Returns module Id.
     *
     * @return string
     */
    public function getModId(){
        return 'specblock_array_iterator';
    }

    /**
     * Returns the pages number.
     *
     * @param  int $pageSize  Number of items per page
     * @return int
     */
    public function getPagesCount($pageSize = 10){
        return 1;
    }

    /**
     * Returns the active page number.
     *
     * @param  int $pageSize  Number of items per page
     * @param  int $position  List position
     * @return int
     */
    public function getActivePage($pageSize = 10, $position = 0){
        return 1;
    }
}
