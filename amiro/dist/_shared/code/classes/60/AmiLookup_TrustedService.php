<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Service 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3539 xkqwygtlmtqtslxxqsruywqgsppngyisnrqxqqqpitxyuznxrqxpqkymqxlnkwgqsuuxpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Category/element front link opener.
 *
 * @package    Service
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 * @task       CMS-11893
 */
class AmiLookup_TrustedService extends AMI_Module_TrustedService{
    /**
     * HTTP Request object
     *
     * @var AMI_RequestHTTP
     */
    protected $oRequest;

    /**
     * Response object
     *
     * @var AMI_Response
     */
    protected $oResponse;

    /**
     * Dispatches action.
     *
     * @return void
     */
    public function dispatchAction(){
        $this->oRequest  = AMI::getSingleton('env/request');
        $this->oResponse = AMI::getSingleton('response');
        $this->oResponse->setType('HTML');

        $this->validateArgs();

        $modId = $this->oRequest->get('lookup_mod_id', '');
        $id = $this->oRequest->get('lookup_id', '');
        if('' !== $modId && '' !== $id){
            // Append categogy/element sublink to url
            $oItem =
                AMI::getResourceModel(
                    $modId . '/table',
                    array(
                        array(
                            'extModeOnConstruct' => 'common'
                        )
                    )
                )
                ->find($id);
            if($oItem->id){
                $url = rtrim($this->oRequest->get('url', '') , '/');
                $this->oRequest->set(
                    'url',
                    ltrim(
                        '' !== $url
                            ? $url . $oItem->getURL()
                            : $oItem->getFullURL(),
                        '/'
                    )
                );
            }
        }

        $this->_dispatchAction();
    }

    /**
     * Validates passed arguments.
     *
     * @return void
     */
    protected function validateArgs(){
        $message = '';
        do{
            $modId = $this->oRequest->get('lookup_mod_id', '');
            if('' !== $modId && !AMI_ModDeclarator::getInstance()->isRegistered($modId)){
                $message = "Invalid module Id '" . $modId . "'";
                break;
            }
            $id = $this->oRequest->get('lookup_id', '');
            if('' !== $id && !preg_match('/^[0-9]+$/', $id)){
                $message = "Invalid Id '" . $id . "'";
                break;
            }
        }while(FALSE);
        if('' != $message){
            trigger_error($message);
            self::send(
                $message,
                '400 Bad Request'
            );
        }
    }

    /**
     * Sends response.
     *
     * @return void
     */
    protected function _dispatchAction(){
        $this->redirect();
    }

    /**
     * Redirecs visitor by passed URL.
     *
     * @return void
     */
    protected function redirect(){
        $url = $this->oRequest->get('url', '');
        if(!is_string($url)){
            $url = '';
        }
        $url = AMI_Registry::get('path/www_root') . $url;
        $this->oResponse->HTTP->setRedirect($url, 303);
        die;
    }
}
