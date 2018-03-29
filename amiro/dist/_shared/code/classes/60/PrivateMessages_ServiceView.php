<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiAsync_PrivateMessages 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1720 xkqwqtkwygkiuqntkkwnlyutwpksmtzqgqyppzrmqtsnsktirxmzqtzqkunrriumsryrpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Private Messages service view.
 *
 * @package    Config_AmiAsync_PrivateMessages
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
class PrivateMessages_ServiceView extends AMI_View{
    /**
     * Main block name
     *
     * @var string
     */
    protected $tplFileName = null;

    /**
     * Locale file name
     *
     * @var string
     */
    protected $localeFileName = null;

    /**
     * Stub function.
     *
     * @return null
     */
    public function get(){
        return null;
    }

    /**
     * Returns link to message page to user by user's id.
     *
     * @param  int    $memberId  Member ID
     * @param  string $locale    Locale
     * @return string
     */
    public function getUserSendMessageLink($memberId, $locale = 'en'){
        if($memberId){
    	    $isMultilang = AMI::getOption('core', 'allow_multi_lang');
    	    $string =
                ($isMultilang ? $locale . '/' : '') .
                AMI_PageManager::getModLink('private_messages', $locale) .
                '?recipient=' . $memberId;
        }else{
            $string = '';
        }
        return $string;
    }
}
