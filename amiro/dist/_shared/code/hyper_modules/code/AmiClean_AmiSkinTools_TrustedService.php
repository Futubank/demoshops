<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiClean_AmiSkinTools 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       6563 xkqwrxkimzqmuiyktrupwrggyzwwsguzumpxkplgytwuqngxuqlqkstgxiulxugzyustpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiClean/EditInPlace trusted service class.
 *
 * @package    Config_AmiClean_AmiSkinTools
 * @subpackage Controller
 * @resource   ami_skin_tools/service
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_AmiSkinTools_TrustedService extends AMI_Module_TrustedService{
    /**
     * Dispatches action.
     *
     * @return void
     */
    public function dispatchAction(){
        $aActionToAccessMode = array(
            'menu'              => self::ACCESS_EDIT_DATA,
            'toggle_edit_mode'  => self::ACCESS_EDIT_DATA,
            'empty'             => self::ACCESS_EDIT_DATA,
            'logout'            => self::ACCESS_EDIT_DATA,
            'edit'              => self::ACCESS_EDIT_DATA_ENABLED,
            'get_raw_data'      => self::ACCESS_EDIT_DATA_ENABLED,
            'auth_form'         => self::ACCESS_FREE
        );
        $oRequest = AMI::getSingleton('env/request');
        $action = (string)$oRequest->get('action', '');
        if(isset($aActionToAccessMode[$action])){
            $this->accessMode = $aActionToAccessMode[$action];
        }

        parent::dispatchAction();

        if(in_array($action, array('edit', 'get_raw_data'))){
            $oUser = AMI::getSingleton('env/session')->getUserData();
            $modId = (string)$oRequest->get('modId', '');
            if(!AMI::checkAccessRights(
                $modId,
                $oUser->id,
                array('edit')
            )){
                trigger_error('Access denied for module "' . $modId . "'");
                self::send(
                    '[' . sprintf('%04x', $this->accessMode) .
                    '] User allowed to edit at front module "' . $modId . '" required!',
                    '403 Forbidden'
                );
            }
        }

        $oTpl = AMI::getResource('env/template_sys');
        $oTpl->setLocationSource('templates', 'fs');
        $oTpl->addBlock('skin', AMI_Skin::getPath('templates/mod.tpl'));

        /* @var $oSession AMI_Session */
        $oSession = AMI::getSingleton('env/session');
        if(!$oSession->isStarted()){
            $oSession->start();
        }

        $username = '';
        $oUser = $oSession->getUserData();
        if($oUser){
            $username = $oUser->login;
        }

        $aScope = array(
            'www_root'      => AMI_Registry::get('path/www_root'),
            'hasForm'       => FALSE,
            'pageId'        => 0,
            'username'      => $username,
            'lessMode'      => AMI::getOption('common_settings', 'less_css_mode'),
            'cmsVersion'    => AMI::getVersion('cms', 'code'),
            'cssVersion'    => AMI::issetOption('common_settings', 'css_js_version') ? AMI::getOption('common_settings', 'css_js_version') : '',
            'aLocale'       => json_encode($oTpl->parseLocale(AMI_Skin::getPath('templates/lang/_client.lng')))
        );

        switch($oRequest->get('action')){
            case 'auth_form':
                $membersLink = AMI_PageManager::getModLink('members', AMI_Registry::get('lang'), 0, TRUE);
                if(!$membersLink){
                    $membersLink = '';
                }
                $aScope['membersLink'] = $membersLink;
                $body = $oTpl->parse('skin:auth_form', $aScope);
                break;
            case 'empty':
                $aScope['modId'] = $oRequest->get('modId', '');
                $body = $oTpl->parse('skin:mod', $aScope);
                break;
            case 'list':
                $body = $oTpl->parse('skin:list', $aScope);
                break;
            case 'edit':
                $aScope['pageId'] = $oRequest->get('pageId', '');
                $aScope['modId'] = $oRequest->get('modId', '');
                $aScope['itemId'] = $oRequest->get('id', 0);
                $aScope['hasForm'] = TRUE;
                if($aScope['itemId']){
                    $oItem = AMI::getResourceModel($aScope['modId'] . '/table')->find($aScope['itemId']);
                    if(!$oItem->getId() || !AMI::checkAccessRights($aScope['modId'], $oItem->id_owner, array('edit'))){
                        $oUser = AMI::getSingleton('env/session')->getUserData();
                        trigger_error(
                            'Access restricted to element (modId=' . $aScope['modId'] .
                            ', id=' . $aScope['itemId'] . ', userId=' . $oUser->id . ')',
                             E_USER_WARNING
                        );
                        $body = $oTpl->parse('skin:forbidden', $aScope);
                        break;
                    }
                }
                $body = $oTpl->parse('skin:mod', $aScope);
                break;
            case 'menu':
                AMI_Service::hideDebug();
                $aScope['is_shared'] = defined('AMIRO_HOST') && AMIRO_HOST;
                $aScope['aLocale'] = json_encode(
                    $oTpl->parseLocale(AMI_Skin::getPath('templates/lang/_client.lng')) +
                    $oTpl->parseLocale(AMI_Skin::getPath('templates/lang/toolbar.lng'))
                );
                $body = $oTpl->parse('skin:menu', $aScope);
                break;
            case 'toggle_edit_mode':
                $body = '';
                break;
            case 'logout':
                $oSession->logout();
                $body = '';
                break;
            case 'modules_list':
                $GLOBALS['adm'] = new Admin($GLOBALS['Core']);
                $GLOBALS['adm']->setLang($oRequest->get('ami_locale', 'en'));
                $body = $GLOBALS['adm']->fillModulesSelect(false, true);
                break;
            case 'get_raw_data':
                $oItem = AMI::getResourceModel(
                    $oRequest->get('mod_id') . '/table'
                )->find($oRequest->get('id'));
                $body = $oItem->getData();
                break;
            default:
                $body = 'unknown action';
                break;
        }
        $this->send($body);
    }
}
