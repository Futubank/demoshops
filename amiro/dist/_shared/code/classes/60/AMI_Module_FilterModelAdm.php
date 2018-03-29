<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    ModuleComponent 
 * @version    $Id$ 
 * @since      5.14.4 
 * @size       3109 xkqwrttitmxitngszznrnwgtuzkgzrggkpwnrmgmrwkgglmzkwsyygkqunqirmriyyqlpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AMI_Module module item list component filter model.
 *
 * @package    ModuleComponent
 * @subpackage Model
 * @todo       Implement system wide filter for id_page
 * @since      5.14.4
 */
abstract class AMI_Module_FilterModelAdm extends AMI_Filter{
    /**
     * Common filter fields
     *
     * @var   array
     */
    protected $aCommonFields = array('datefrom', 'dateto', 'header');

    /**
     * Constructor.
     */
    public function __construct(){
        if(in_array('datefrom', $this->aCommonFields)){
            $this->addViewField(
                array(
                    'name'          => 'datefrom',
                    'type'          => 'datefrom',
                    'flt_type'      => 'date',
                    'flt_default'   => AMI_Lib_Date::formatUnixTime(AMI_Lib_Date::UTIME_MIN),
                    'flt_condition' => '>=',
                    'flt_column'    => 'date_created',
                    'validate' 		=> array('date','date_limits'),
                    'session_field' => true
                )
            );
        }
        if(in_array('dateto', $this->aCommonFields)){
            $this->addViewField(
                array(
                    'name'          => 'dateto',
                    'type'          => 'dateto',
                    'flt_type'      => 'date',
                    'flt_default'   => AMI_Lib_Date::formatUnixTime(AMI_Lib_Date::UTIME_MAX),
                    'flt_condition' => '<=',
                    'flt_column'    => 'date_created',
                    'validate' 		=> array('date','date_limits'),
                    'session_field' => true
                )
            );
        }
        if(in_array('header', $this->aCommonFields)){
            $this->addViewField(
                array(
                    'name'          => 'header',
                    'type'          => 'input',
                    'flt_type'      => 'text',
                    'flt_default'   => '',
                    'flt_condition' => 'like',
                    'flt_column'    => 'header'
                )
            );
        }
    }

    /**
     * Handle id_page filter custom logic.
     *
     * @param  string $field  Field name
     * @param  array  $aData  Filter data
     * @return array
     */
    protected function processFieldData($field, array $aData){
        if($field == 'id_page'){
            if($aData['value'] > 0){
                $aData['exception'] = " OR i.id_page = 0 ";
            }
        }
        return $aData;
    }
}