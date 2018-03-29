<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiClean_AmiSeopult 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       4609 xkqwkmimqgxkqyxlsyrrynixwzgxyngmgzzwtypulntlnnwxzpqulszlwikwtygqgllxpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Seopult service class.
 *
 * @package    Config_AmiClean_AmiSeopult
 * @subpackage Controller
 * @resource   ami_seopult/service
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_AmiSeopult_Service extends AMI_Module_Service{
    /**
     * Instance
     *
     * @var AmiClean_AmiSeopult_Service
     */
    private static $oInstance;

    /**
     * Returns AmiSeopult_Service instance.
     *
     * @return AmiSeopult_Service
     */
    public static function getInstance(){
        if(self::$oInstance == null){
            self::$oInstance = new self;
        }
        return self::$oInstance;
    }

    /**
     * Destroys instance.
     *
     * @return void
     * @todo   Use when all business logic processed or detect usage necessity
     */
    public static function destroyInstance(){
        self::$oInstance = null;
    }

    /**
     * Dispatches module action.
     *
     * @param  AMI_Request  $oRequest   Request
     * @param  AMI_Response $oResponse  Response
     * @return void
     */
    public function dispatchAction(AMI_Request $oRequest, AMI_Response $oResponse){
        AMI_Service::hideDebug();
        $aSets = array(
            'msg01' => 'balance_warning',
            'msg02' => 'new_message',
            'msg03' => 'top_on',
            'msg04' => 'top_off',
            'msg05' => 'got_words',
        );
        $oRequest = AMI::getSingleton('env/request');
        switch($oRequest->get('action')){
            case 'informer':
                $set = $oRequest->get('msg', '');
                if(!isset($aSets[$set])){
                    $this->send('invalid message');
                }
                $hash = $GLOBALS['Core']->getModOption('ami_seopult', 'hash');
                if(md5($hash) == $oRequest->get('hash', '')){
                    $sql = "SELECT id_member FROM cms_host_users WHERE sys_user=1 LIMIT 1";
                    $sysUserId = AMI::getSingleton('db')->fetchValue(DB_Query::getSnippet($sql));
                    if($sysUserId){
                        $oTpl = AMI::getResource('env/template_sys');
                        $oTpl->setLocationSource('templates', 'db');
                        $oTpl->addBlock('seopult', AMI_iTemplate::TPL_MOD_PATH . '/seopult.tpl');
                        $aScope = array(
                            'var1'  => $oRequest->get('var1', ''),
                            'var2'  => $oRequest->get('var2', ''),
                            'var3'  => $oRequest->get('var3', '')
                        );
                        $message = $oTpl->parse('seopult:' . $aSets[$set], $aScope);
                        $header = $oTpl->parse('seopult:' . $aSets[$set] . '_header', $aScope);
                        AMI_Registry::set('ami_allow_model_save', true);
                        $oMsg = AMI::getResourceModel('private_messages/table')->getItem();
                        $oMsg->setValues(
                            array(
                                'id_owner'      => $sysUserId,
                                'id_sender'     => 0,
                                'id_recipient'  => $sysUserId,
                                'is_read'       => 0,
                                'header'        => $header,
                                'b_body'        => $message,
                                'is_broadcast'  => 1,
                            )
                        );
                        $oMsg->save();

                        PrivateMessages_EmailNotifier::send($oMsg->getId());

                        $this->send('ok');
                    }else{
                        $this->send('user not found');
                    }
                }else{
                    $this->send('invalid hash');
                }
                break;
            default:
                $this->send('unknown action');
                break;
        }
    }

    /**
     * Singleton cloning.
     */
    private function __clone(){
    }
}
