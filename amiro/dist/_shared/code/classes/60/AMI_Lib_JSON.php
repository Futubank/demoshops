<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Library 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3015 xkqwkliqspiuukuigrkupwntkplnywtrqxwlsrypupyttqgigrsqxmqqngtiktzsrimnpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Poor JSON functionality.
 *
 * @package Library
 * @static
 * @since   x.x.x
 * @amidev  Temporary
 */
class AMI_Lib_JSON{
    /**
     * Converts entity to JSON string representation.
     *
     * @param  mixed $entity  Entity
     * @return string
     */
    public static function encode($entity){
        return function_exists('json_encode') ? json_encode($entity) : self::_encode($entity);
    }

    /**
     * Decodes a JSON string.
     *
     * @param  string $json         JSON string
     * @param  bool   $assoc        When TRUE, returned objects will be converted into associative arrays
     * @param  bool   $fromRequest  When TRUE, the JSON data will be stripslashed
     * @param  int    $depth        Recursion depth
     * @return mixed
     */
    public static function decode($json, $assoc = TRUE, $fromRequest = FALSE, $depth = 512){
        return json_decode($fromRequest ? stripslashes($json) : $json, $assoc);
    }

    /**
     * Encodes entity.
     *
     * @param  mixed $entity  Entity
     * @return string
     * @todo   Objects support
     */
    private static function _encode($entity){
        if(is_array($entity)){
            $regularArray = true;
            foreach(array_keys($entity) as $i => $index){
                if(is_numeric($index)){
                    $index = (int)$index;
                }
                if($i !== $index){
                    $regularArray = false;
                    break;
                }
            }
            $res = $regularArray ? '[' : '{';
            foreach($entity as $key => $value){
                $res .= ($regularArray ? '' : self::_quote($key) . ':') . self::_encode($value) . ',';
            }
            if(sizeof($entity)){
                $res = mb_substr($res, 0, -1);
            }
            $res .= $regularArray ? ']' : '}';
        }elseif(gettype($entity) == 'string'){
            $res = self::_quote($entity);
        }elseif(is_numeric($entity)){
            $res = $entity;
        }elseif(is_bool($entity)){
            $res = $entity ? 'true' : 'false';
        }else{
            $res = 'null';
        }
        return $res;
    }

    /**
     * Quotes JSON string.
     *
     * @param  string $string  String
     * @return string
     */
    private function _quote($string){
        return '"' . str_replace(array('\\', '/', '"', "\r", "\n"), array('\\\\', '\\/', '\\"', '\\r', '\\n'), $string) . '"';
    }
}
