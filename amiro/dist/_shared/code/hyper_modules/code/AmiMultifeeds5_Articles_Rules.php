<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds5_Articles 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1980 xkqwyumtxmuzmnwklpztpqwryqswpgqpziqkusisnimqxwpyknliszplnkysqlwuxtqupnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds5/Articles configuration rules.
 *
 * @package    Config_AmiMultifeeds5_Articles
 * @subpackage Controller
 * @since      x.x.x
 * @amidev
 */
class AmiMultifeeds5_Articles_Rules extends Hyper_AmiMultifeeds5_Rules{
    /*
    public static function ruleTest($callbackData, $optionsData, $callbackMode,
$result, array $aData){
        switch($callbackMode){
            case 'getvalue':
                $result = $callbackData['value'];
                break;
            case 'getallvalues':
                if(!is_array($callbackData['value'])){
                    $callbackData['value'] = array();
                }
                $result = array(
                    array(
                        'name'      => 'r1',
                        'caption'   => 'Value 1',
                        'selected'  => in_array('r1', $callbackData['value'])
                    ),
                    array(
                        'name'      => 'r2',
                        'caption'   => 'Value 2',
                        'selected'  => in_array('r2', $callbackData['value'])
                    ),
                    array(
                        'name'      => 'r3',
                        'caption'   => 'Value 3',
                        'selected'  => in_array('r3', $callbackData['value'])
                    )
                );
                break;
        }
        return true;
    }
    */
}
