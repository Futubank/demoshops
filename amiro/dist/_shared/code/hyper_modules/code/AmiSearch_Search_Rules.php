<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiSearch_Search 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2486 xkqwmmwgzppkwrgwrtkgkgxzmtkziwqpzzuixrygrikpmxpmrltuurimgmlwqgssiukupnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiSearch/Search configuration rules.
 *
 * @package    Config_AmiSearch_Search
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSearch_Search_Rules extends Hyper_AmiSearch_Rules{
    /**
     * Handler for ##modId##:GetSearchPagesCB callback.
     *
     * @param mixed $callbackData   Data for callback
     * @param mixed &$optionsData    Options data
     * @param string $callbackMode  Callback mode
     * @param mixed &$result         Result data
     * @param array &$aData          Data
     * @return bool
     */
    public function GetSearchPagesCB($callbackData, &$optionsData, $callbackMode, &$result, array &$aData){
        $oTpl = AMI::getSingleton('env/template_sys');
        $aLocale = $oTpl->parseLocale('templates/lang/main.lng');
        switch($callbackMode){
            case self::GET_ALL:
                if(!$callbackData["value"]){
                    $callbackData["value"] = $callbackData["default_value"];
                }
                $result = Array();
                $result[] = array(
                    'name' => 'all',
                    'caption' => $aLocale['all_site_search'],
                    'selected' => in_array('all', $callbackData["value"]) ? 1 : 0
                );
                $oFilter = AMI::getResource('search/filter/model/adm');
                $aPages = $oFilter->getSearchPages();
                foreach($aPages as $aPage){
                    $result[] = array(
                        'name' => $aPage['value'],
                        'caption' => $aPage['name'],
                        'selected' => ($aPage['value'] == $callbackData['value']) ? 1 : 0
                    );
                }
                break;
            case self::CORRECT:
                break;
            case self::GET_VAL:
                $res = $callbackData["value"];
                break;
        }
        return true;
    }
}
