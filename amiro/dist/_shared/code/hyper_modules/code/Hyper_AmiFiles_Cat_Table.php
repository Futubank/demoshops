<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiFiles 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       3062 xkqwmntggsygkyiigmknrirsmgsizksknlulkknntpwkpgnrrkxuuzpyurlrpklwrtizpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiFiles hypermodule category table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Hyper_AmiFiles
 * @subpackage Model
 * @since      6.0.2
 */
class Hyper_AmiFiles_Cat_Table extends AMI_CatModTable{
    /**
     * Database table name
     *
     * @var string
     */
    protected $tableName = 'cms_files_cat';

    /**
     * Category items resource table string.
     *
     * @var string
     */
    protected $subItemsTableResId = 'files/table';

    /**
     * Category items module.
     *
     * @var string
     */
    protected $subItemsModId = 'files';

    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        parent::__construct($aAttributes);

        $aRemap = array(
            'id'               => 'id',
            'public'           => 'public',

            'sublink'          => 'sublink',
            'id_page'          => 'id_page',
            'lang'             => 'lang',

            'header'           => 'name',
            'sticky'           => 'urgent',
            'date_sticky_till' => 'urgent_date',
            'hide_in_list'     => 'public_direct_link',
            'date_modified'    => 'modified_date'
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiFiles hypermodule category table item model.
 *
 * @package    Hyper_AmiFiles
 * @subpackage Model
 * @since      6.0.2
 */
class Hyper_AmiFiles_Cat_TableItem extends AMI_CatModTableItem{
    /**
     * Initializing table item data.
     *
     * @param AMI_ModTable $oTable  Module table model
     * @param DB_Query     $oQuery  Required for load or save operations
     */
    public function __construct(AMI_ModTable $oTable, DB_Query $oQuery = null){
        parent::__construct($oTable, $oQuery);

        $this->oTable->addValidators(
            array(
                'lang'     => array('filled'),
                'header'   => array('filled'),
                'announce' => array('required'),
                'body'     => array('required')
            )
        );
        $this->setFieldCallback('header', array($this, 'fcbHTMLEntities'));
    }
}

/**
 * AmiFiles hypermodule category table list model.
 *
 * @package    Hyper_AmiFiles
 * @subpackage Model
 * @since      6.0.2
 */
class Hyper_AmiFiles_Cat_TableList extends AMI_CatModTableList{
}
