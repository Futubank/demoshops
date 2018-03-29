<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    ModuleComponent 
 * @version    $Id$ 
 * @since      5.12.0 
 * @size       1939 xkqwqnktzmwqzikgsurizqzxgztpkxstyzrpgumrumzglznmynmwxgulrtzplilwinpmpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Module admin form component view abstraction.
 *
 * @package    ModuleComponent
 * @subpackage View
 * @see        AmiSample_FormViewAdm
 * @since      5.12.0
 */
class AMI_ModFormViewFrn extends AMI_ModFormView{
    /**
     * Template file name
     *
     * @var string
     */
    protected $tplFileName = 'templates/modules/_form.tpl';

    /**
     * Template block name
     *
     * @var string
     */
    protected $tplBlockName = 'admin_form';

    /**
     * Locale file name
     *
     * @var string
     */
    protected $localeFileName = 'templates/lang/modules/_form.lng';

    /**
     * Returns view data.
     *
     * @return string
     */
    public function get(){
        $html = parent::get();
        /**
         * AMI_Response
         */
        $oResponse = AMI::getSingleton('response');
        if($oResponse->getType() == 'JSON'){

            $aFieldsData = $this->getFieldsData();
            extract($aFieldsData);

            /**
             * @var AMI_RequestHTTP
             */
            $oRequest = AMI::getSingleton('env/request');
            return array(
                'fields'     => $aFields,
                'id'         => $this->oItem->getId(),
                'appliedId'  => $oRequest->get('applied_id'),
                'htmlCode'   => $html
            );
        }else{
            return $html;
        }
    }
}
