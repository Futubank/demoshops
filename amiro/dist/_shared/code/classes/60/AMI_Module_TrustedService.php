<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    ModuleComponent 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       4754 xkqwkpplruxqluyyplggqtwskswquwitqwtuxgqgnnlgsgsklxyqtkrkurxwtruuipzgpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Module trusted service action controller.
 *
 * @package    ModuleComponent
 * @subpackage Controller
 * @since      x.x.x
 * @amidev
 */
abstract class AMI_Module_TrustedService{
    const ACCESS_FREE              = 0x0000;
    const ACCESS_AUTHORIZED        = 0x0001;
    const ACCESS_EDIT_DATA         = 0x0003;
    const ACCESS_EDIT_DATA_ENABLED = 0x0007;
    const ACCESS_SYS_USER          = 0x0009;

    /**
     * Access mode
     *
     * @var int
     */
    protected $accessMode = self::ACCESS_EDIT_DATA;

    /**
     * Validates user auth depends on passed access mode
     * and sends appropriate headers in case of auth required.
     *
     * @param  int  $accessMode  Access mode, see AMI_Module_TrustedService::ACCESS_* constants
     * @return void
     */
    public static function validateAccess($accessMode = self::ACCESS_EDIT_DATA){
        $oSession = AMI::getSingleton('env/session');
        $oUser = $oSession->getUserData();
        if(
            (self::ACCESS_AUTHORIZED & $accessMode) &&
            !is_object($oUser)
        ){
            trigger_error('Access denied for ACCESS_AUTHORIZED mode');
            self::send(
                '[' . sprintf('%04x', $accessMode) .
                '] Auth required!',
                '401 Unauthorized'
            );
        }

        if(
            (self::ACCESS_EDIT_DATA & $accessMode) &&
            !$oUser->ami_efa
        ){
            trigger_error('Access denied for ACCESS_EDIT_DATA mode');
            self::send(
                '[' . sprintf('%04x', $accessMode) .
                '] User allowed to edit at front auth required!',
                '403 Forbidden'
            );
        }

        if(
            (self::ACCESS_EDIT_DATA_ENABLED & $accessMode) >= self::ACCESS_EDIT_DATA_ENABLED &&
            !$oSession->ami_efe
        ){
            trigger_error('Access denied for ACCESS_EDIT_DATA_ENABLED mode');
            self::send(
                '[' . sprintf('%04x', $accessMode) .
                '] Front editing mode must be enabled!',
                '403 Forbidden'
            );
        }

        if(self::ACCESS_SYS_USER == (self::ACCESS_SYS_USER & $accessMode)){
            global $Core;

            if(!is_object($Core) || !($Core instanceof CMS_Module)){
                trigger_error('Full environment required for ACCESS_SYS_USER mode');
                self::send(
                    '[' . sprintf('%04x', $accessMode) .
                    '] Full environment required!',
                    '400 Bad Request'
                );
            }
            if(!$Core->IsSysUser()){
                trigger_error('Access denied for ACCESS_SYS_USER mode');
                self::send(
                    '[' . sprintf('%04x', $accessMode) .
                    '] System user auth required!',
                    '403 Forbidden'
                );
            }
        }
    }

    /**
     * Dispatches action.
     *
     * @return void
     */
    public function dispatchAction(){
        self::validateAccess($this->accessMode);
    }

    /**
     * Sends content to response and exits.
     *
     * @param  string $message      Content to send
     * @param  string $errorHeader  Error header to send
     * @return void
     */
    protected static function send($message = '', $errorHeader = ''){
        $oResponse = AMI::getSingleton('response');
        if(!$oResponse->isStarted()){
            $oResponse->start();
        }
        if('' !== $errorHeader){
            global $conn;

            if(is_object($conn)){
                $conn->Headers = array();
                if(is_callable(array($conn, 'DelHeader'))){
                    $conn->DelHeader('HTTP/1.x 404 Not Found');
                }
                $conn->SetSkip200Status(TRUE);
            }
            $oResponse->HTTP->deleteHeader200();
            $protocol = @getenv('SERVER_PROTOCOL');
            if(!$protocol){
                $protocol = 'HTTP/1.1';
            }
            $oResponse->HTTP->addHeader($protocol . ' ' . $errorHeader);
            $oResponse->HTTP->addHeader('Status: ' . $errorHeader);
        }
        if('' !== $message){
            $oResponse->write($message);
        }
        $oResponse->send();
    }
}
