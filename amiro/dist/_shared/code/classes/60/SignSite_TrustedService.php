<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Service 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       4554 xkqwylukuwqnlruylmglrprugitpxszirsyxsrlmxkmtpzplqggqmsqkpsgwtnnyznnmpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Signing site service.
 *
 * @package    Service
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 * @task       CMS-11846
 */
class SignSite_TrustedService extends AMI_Module_TrustedService{
    /**
     * Access mode
     *
     * @var int
     */
    protected $accessMode = self::ACCESS_FREE;

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
     * Localized messages
     *
     * @var array
     */
    protected $aLocale;

    /**
     * Dispatches action.
     *
     * @return void
     */
    public function dispatchAction(){
        parent::dispatchAction();

        $this->aLocale =
            AMI::getResource('env/template_sys')
            ->parseLocale('_shared/code/templates/lang/sign_site_service.lng');
        $this->oRequest  = AMI::getSingleton('env/request');
        $this->oResponse = AMI::getSingleton('response');
        $this->oResponse->setType('HTML');###

        $this->validateArgs();

        $code = $this->oRequest->get('code', FALSE, 'p');
        $aIds = AMI::getOption('core', 'default_ids');
        $updatedPagesCount = 0;
        if(sizeof($aIds)){
            $oDB = AMI::getSingleton('db');
            $oList =
                AMI::getResourceModel('pages/table')
                ->getList()
                ->addColumns(array('id', 'html_head_code'))
                ->addWhereDef(
                    DB_Query::getSnippet("AND `id` IN (%s)")
                    ->implode($aIds)
                )->load();
            foreach($oList as $oItem){
                //d::vd($oItem->getData(), '', array('html_ent' => TRUE));###
                $head = $oItem->html_head_code;
                $update = FALSE;
                if(preg_match(
                    '/<meta\s+name="cmsmagazine"\s+content="([^"]+)"/s',
                    $head,
                    $aMatches
                )){
                    if($aMatches[1] != $code){
                        // replace code
                        $head = str_replace(
                            $aMatches[0],
                            '<meta name="cmsmagazine" content="' . $code . '"',
                            $head
                        );
                        $update = TRUE;
                    }
                }else{
                    $head = trim($head . "\r\n" . '<meta name="cmsmagazine" content="' . $code . '" />');
                    $update = TRUE;
                }
                if($update){
                    $oQuery = DB_Query::getUpdateQuery(
                        'cms_pages',
                        array('html_head_tail' => $head),
                        "WHERE `id` = " . $oItem->id
                    );
                    $oDB->query($oQuery);
                }
                $updatedPagesCount++;
            }
        }
        $this->oResponse->write(
            sprintf($this->aLocale['pages_updated'], $updatedPagesCount)
        );
    }

    /**
     * Validates passed arguments.
     *
     * @return void
     */
    protected function validateArgs(){
        $message = '';

        do{
            $externalService = $this->oRequest->get('external_service', FALSE, 'p');
            if(!is_string($externalService) || 'cms_magazine' != $externalService){
                $message = sprintf($this->aLocale['unsupported_external_service'], $externalService);
                break;
            }
            $code = $this->oRequest->get('code', FALSE, 'p');
            if(
                !is_string($code) ||
                mb_strlen($code) > 100 ||
                !preg_match('/^[0-9a-f]+$/', $code)
            ){
                $message = sprintf($this->aLocale['invalid_code'], $code);
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
}
