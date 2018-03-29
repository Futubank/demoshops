<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3636 xkqwpzlikyrkipmyiwkkqgzmingkrugrgwqixmkmzuqynktqzpgrwkiwnpuxqmqtqptzpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Module service functions.
 *
 * @package    Module
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Module_TrustedService extends AMI_Module_TrustedService{
    /**
     * Dispatches front module action.
     *
     * @return void
     */
    public function dispatchAction(){
        global $AMI_ENV_SETTINGS, $CLASSES_PATH;

        $oRequest = AMI::getSingleton('env/request');
        $oResponse = AMI::getSingleton('response');

        $modId = $oRequest->get('mod_id');
        $modAction = $oRequest->get('mod_action');

        $this->accessMode = self::ACCESS_EDIT_DATA_ENABLED;
        parent::dispatchAction();


        define('AMI_60', TRUE);
        AMI::addResourceMapping(require($CLASSES_PATH . '60/resourceMapping.php'));
        AMI::addResourceMapping(require($CLASSES_PATH . '60/resourceMapping.60.php'));

        if(
            $AMI_ENV_SETTINGS['mode'] == 'fast' &&
            'full' != $oRequest->get('ami_env', FALSE)
        ){
            AMI::getSingleton('core')->init();
        }

        // Language

        $lang = $oRequest->get('ami_locale', 'en');
        AMI::getSingleton('env/session', AMI::getOption('core', 'allow_multi_lang') ? array('locale' => $lang) : array());
        AMI_Registry::set('lang_data', $lang);
        AMI_Registry::set('lang', $lang);
        AMI::getResource('env/template_sys')->setLocale(in_array($lang, array('en', 'ru')) ? $lang : 'en');
        $aDateFormats = AMI::getOption('core', 'dateformat_front');
        AMI_Registry::get('oGUI')->addGlobalVars(
            array(
                'active_lang' => $lang,
                'date_format' => preg_replace('/ .*$/', '', isset($aDateFormats[$lang]) ? $aDateFormats[$lang] : $aDateFormats['en'])
            )
        );
        AMI_Registry::set('ami_allow_model_save', TRUE);
        AMI_GlobalFilters::setGlobalFilter('side');

        if(in_array($modAction, array('list_view', 'form_save'))){
            $oResponse->setType('JSON');
        }
        AMI_Registry::set('ami_request_type', 'ajax');

        $aAllowedExtensions = array();
        $aPossibleExtensions = array('ext_reindex', 'ext_images');
        $aOriginExtensions = AMI::getOption($modId, 'extensions');
        if(!is_array($aOriginExtensions)){
            $aOriginExtensions = $aOriginExtensions ? array($aOriginExtensions) : array();
        }
        foreach($aPossibleExtensions as $extId){
            if(in_array($extId, $aOriginExtensions)){
                $aAllowedExtensions[] = $extId;
            }
        }
        AMI::setOption($modId, 'extensions', $aAllowedExtensions);
        $oController = AMI::getResource($modId . '/module/controller/frn', array($oRequest, $oResponse));
        $oController->init();

        $aEvent = array();
        /**
         * Request processing controller module.
         *
         * @event      dispatch_request $modId
         */
        AMI_Event::fire('dispatch_request', $aEvent, $modId);

        $aViews = $oController->getViews();
        foreach($aViews as $oView){
            $oResponse->write($oView->get());
        }

        self::send();
    }
}
