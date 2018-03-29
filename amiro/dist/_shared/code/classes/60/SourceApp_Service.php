<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Service 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1664 xkqwqgpttyqnzxyylzkrgsptprzqzyywgiuyrwrlwlyprzkikrikykrztszzxkypqxqlpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * User source app service functions.
 *
 * @package    Service
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class SourceApp_Service extends AMI_Module_Service{
    /**
     * Dispatches  module action.
     *
     * @param AMI_Request  $oRequest   Request
     * @param AMI_Response $oResponse  Response
     * @return void
     */
    public function dispatchAction(AMI_Request $oRequest, AMI_Response $oResponse){
        global $cms;

        $lang = $oRequest->get('ami_locale', false);
        if($lang){
            AMI_Registry::set('lang_data', $lang);
            AMI_Registry::set('lang', $lang);
        }

        if(isset($cms) && is_object($cms)){
            $cms->Core->Cache->Disable();
        }

        if($oRequest->get('driver') && $oRequest->get('driver_action')){
            $oResponse->write(
                AMI::getResource('user_source_app')
                ->dispatchDriverAction($oRequest->get('driver'), $oRequest->get('driver_action'))
            );
        }else{
            throw new Exception('No driver or no driver action given', E_USER_ERROR);
        }
    }
}
