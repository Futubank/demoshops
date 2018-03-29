<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiJobs_Employer 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2408 xkqwgrpqlpqtkwxmmtwknuzryirmlnuqtzzlnxpwgpipwpxxkkxwkwgtslikzmqigrwxpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiJobs/Employer configuration table model.
 *
 * See {@link AMI_ModTable::getAvailableFields()} for common fields description.
 *
 * @package    Config_AmiJobs_Employer
 * @subpackage Model
 * @resource   {$modId}/table/model <code>AMI::getResourceModel('{$modId}/table')*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiJobs_Employer_Table extends Hyper_AmiJobs_Table{
    /**
     * Initializing table data.
     *
     * @param array $aAttributes  Attributes of table model 
     */
    public function __construct(array $aAttributes = array()){
        $this->tableName = 'cms_' . $this->getModId();
        $this->setDependence('jobs_resume', 'resume', 'resume.id_jobs_history=i.id', 'LEFT JOIN');
        $this->setActiveDependence('resume');

        parent::__construct($aAttributes);

        $aRemap = array(
            'id'               => 'id',
            'date'             => 'date',
            'sublink'          => 'sublink',
            'id_page'          => 'id_page',
            'lang'             => 'lang',
            'date_created'     => 'date'
        );
        $this->addFieldsRemap($aRemap);
    }
}

/**
 * AmiJobs/Employer configuration table item model.
 *
 * @package    Config_AmiJobs_Employer
 * @subpackage Model
 * @resource   {$modId}/table/model/item <code>AMI::getResourceModel('{$modId}/table')->getItem()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiJobs_Employer_TableItem extends Hyper_AmiJobs_TableItem{
}

/**
 * AmiJobs/Employer configuration table list model.
 *
 * @package    Config_AmiJobs_Employer
 * @subpackage Model
 * @resource   {$modId}/table/model/list <code>AMI::getResourceModel('{$modId}/table')->getList()*</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiJobs_Employer_TableList extends Hyper_AmiJobs_TableList{
}
