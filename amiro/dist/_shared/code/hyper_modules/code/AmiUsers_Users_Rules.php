<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiUsers_Users 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       4727 xkqwlkuyyquutiplqtlmplzxzgqinzwwnturgwugnrwmygxluuxuwkttgqmqkgqkkkripnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiUsers/Users configuration rules.
 *
 * @package    Config_AmiUsers_Users
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiUsers_Users_Rules extends Hyper_AmiUsers_Rules{
    /**
     * Handler for ##modId##:ruleFrnEditableModulesCB callback.
     *
     * @param  mixed  $callbackData  Data for callback
     * @param  mixed  &$optionsData  Options data
     * @param  string $callbackMode  Callback mode
     * @param  mixed  &$result       Result data
     * @param  array  &$aData        Data
     * @return bool
     */
    public function ruleFrnEditableModulesCB($callbackData, &$optionsData, $callbackMode, &$result, array &$aData){
        $oDeclarator = AMI_ModDeclarator::getInstance();
        $aAllowedValues = $oDeclarator->getRegistered('ami_multifeeds');
        $aAllowedValues[] = 'pages';
        $aAllowedValues[] = 'eshop_item';
        $aAllowedValues[] = 'eshop_order';
        // $aAllowedValues[] = 'kb_item';
        // s$aAllowedValues[] = 'portfolio_item';

        $passedValue = $callbackData['value'];

        switch($callbackMode){
            case self::GET_ALL:
                static $aLocales = NULL;

                if(is_null($aLocales)){
                    $aLocales = array();
                    if(sizeof($aAllowedValues)){
                        $oTpl = AMI::getSingleton('env/template_sys');
                        $aLocale = $oTpl->parseLocale('templates/lang/_menu_all.lng');
                        $aHeaderLocale = $oTpl->parseLocale('templates/lang/_headers.lng');
                        foreach($aAllowedValues as $modId){
                            if(
                                (
                                    AMI::issetAndTrueProperty($modId, 'support_rights') ||
                                    in_array($modId, array('pages', 'eshop_order'))
                                ) &&
                                AMI::isModInstalled($modId)
                            ){
                                if(isset($aHeaderLocale[$modId])){
                                    $caption = $aHeaderLocale[$modId];
                                    if('modules' === $oDeclarator->getSection($modId)){
                                        $pos = mb_strpos($caption, ':');
                                        if($pos !== FALSE){
                                            $caption = mb_substr($caption, $pos + 1);
                                        }
                                    }
                                }elseif($aLocale[$modId]){
                                    $caption = $aLocale[$modId];
                                }else{
                                    $caption = $modId;
                                }
                                $aLocales[$modId] = mb_convert_case($caption, MB_CASE_TITLE);
                            }
                        }
                    }
                }
                $result = array();
                foreach($aLocales as $modId => $caption){
                    $result[] = array(
                        'name'     => $modId,
                        'caption'  => $caption,
                        'selected' => in_array($modId, $passedValue) ? 'selected' : ''
                    );
                }
                if(sizeof($result)){
                    require_once $GLOBALS['FUNC_INCLUDES_PATH'] . 'func_array.php';
                    sortMultiArray($result, 'caption');
                }
                $aData['allow_empty'] = TRUE;
                break; // case 'getallvalues'
            case self::CORRECT:
                $result = array();
                foreach($passedValue as $value){
                    if(in_array($value, $aAllowedValues)){
                        $result[] = $value;
                    }
                }
                break; // case 'correctvalue'
            case self::GET_VAL:
                $result = $passedValue;
                break; // case 'getvalue'
            case self::SET_VAL:
                break; // case 'apply'
        }
        return true;
    }
}
