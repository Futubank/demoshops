<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiSitemapHistory 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2362 xkqwnzzmnwyktyqunwmpsniyxznintlqissurxtgnixmgkxxnwxpmikwupgkmxprmmuzpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiSitemapHistory hypermodule table model.
 *
 * @package    Hyper_AmiSitemapHistory
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSitemapHistory_Table extends AMI_ModTable{
    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        $this->tableName = 'cms_google_sitemap';

        parent::__construct($aAttributes);

        $aRemap = array(
            'id' => 'id'
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
    }
}

/**
 * AmiSitemapHistory hypermodule table item model.
 *
 * @package    Hyper_AmiSitemapHistory
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSitemapHistory_TableItem extends AMI_Module_TableItem{
    /**
     * Initializing table item data.
     *
     * @param AMI_ModTable $oTable  Module table model
     * @param DB_Query     $oQuery  Required for load or save operations
     */
    public function __construct(AMI_ModTable $oTable, DB_Query $oQuery = null){
        parent::__construct($oTable, $oQuery);

        $this->setFieldCallback('author', array($this, 'fcbHTMLEntities'));
        $this->setFieldCallback('source', array($this, 'fcbHTMLEntities'));
    }
}

/**
 * AmiSitemapHistory hypermodule table list model.
 *
 * @package    Hyper_AmiSitemapHistory
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class Hyper_AmiSitemapHistory_TableList extends AMI_ModTableList{
}
