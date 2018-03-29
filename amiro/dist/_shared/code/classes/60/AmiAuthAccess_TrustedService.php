<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Service 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2396 xkqwqrtrrxnrstuyrqkpuilrqqmwqwltwlxxyrrtwysnmqlniymqymimiixnlmnykzxkpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Auto auth access from admin side service.
 *
 * @package    Service
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 * @task       CMS-11873
 */
class AmiAuthAccess_TrustedService extends AmiLookup_TrustedService{
    /**
     * Redirecs visitor by passed URL.
     *
     * @return void
     */
    protected function _dispatchAction(){
        if(!AMI::getOption('core', 'allow_edit_at_front')){
            parent::_dispatchAction();
            return;
        }
        $GLOBALS['CONNECT_OPTIONS']['disable_cache_warn'] = TRUE;
        $oSession = AMI::getSingleton('env/session');
        $oUser = $oSession->getUserData();
        if(is_object($oUser)){
            // Already authorized
            $this->redirect();
        }

        // Validate request
        $sid = $this->oRequest->get('sid', FALSE);
        if(FALSE === $sid){
            $message = "Missing required argument 'sid'";
            trigger_error($message);
            self::send(
                $message,
                '400 Bad Request'
            );
        }
        if('full' != $this->oRequest->get('ami_env', '')){
            // Authorization is possible in full environment only
            $aRequest = $this->oRequest->getScope('g');
            $aRequest['ami_env'] = 'full';
            unset($aRequest['lookup_mod_id'], $aRequest['lookup_id']);
            $this->oRequest->set(
                'url',
                'ami_strict.php?' . http_build_query($aRequest)
            );
            $this->redirect();
        }
        if($GLOBALS['Core']->authByHash($sid)){
            $aRequest = $this->oRequest->getScope('g');
            $this->redirect();
        }
        $message = 'Authorization failed';
        trigger_error($message);
        /*
        self::send(
            $message,
            '400 Bad Request'
        );
        */
        $this->redirect();
    }
}
