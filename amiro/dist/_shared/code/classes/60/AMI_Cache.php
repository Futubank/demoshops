<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Service 
 * @version    $Id$ 
 * @since      5.12.0 
 * @size       2925 xkqwiulqzkirywsnsmkqrilpwuiqgwuztnsyyyimuukksxwnypkgtupnmqximzkukixrpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Cache class for front-side pages.
 *
 * @package  Service
 * @since    5.12.0
 * @resource cache <code>AMI::getSingleton('cache')</code>
 */
class AMI_Cache{
    /**
     * Instance
     *
     * @var AMI_Cache
     */
    private static $oInstance;

    /**
     * Returns an instance of AMI_Cache.
     *
     * @param  array $aArgs  Constructor arguments
     * @return AMI_Cache
     * @amidev
     */
    public static function getInstance(array $aArgs = array()){
        if(is_null(self::$oInstance)){
            self::$oInstance = new AMI_Cache();
        }
        return self::$oInstance;
    }

    /**
     * Expires block.
     *
     * @param  string $blockId  Block id
     * @return AMI_Cache
     * @amidev Temporary?
     */
    public function expireBlock($blockId){
        if(AMI::validateModId($blockId)){
            /**
             * @var AMI_DB
             */
            $oDB = AMI::getSingleton('db');
            // Expires specblocks
            $oDB->query(
                DB_Query::getSnippet("UPDATE `cms_cache_blocks` SET `date_expire` = %s WHERE `spec_type` = %s")
                ->q('2000-01-01 00:00:00')
                ->q($blockId)
            );
            // Expire pages whith this specblock
            $oDB->query(
                DB_Query::getSnippet("UPDATE `cms_cache` SET `date_expire` = %s, `date_page_lock` = %s WHERE `page_spec_blocks` LIKE %s")
                ->q('2000-01-01 00:00:00')
                ->q('0000-00-00 00:00:00')
                ->q('%' . $blockId . '%')
            );
        }else{
            trigger_error("Invalid block id '" . $blockId . "'", E_USER_WARNING);
        }
        return $this;
    }

    /**
     * Expires plugin block.
     *
     * Example:
     * <code>
     * $oModelItem->save();
     * AMI::getSingleton('cache')->expirePluginBlock('ami_sample');
     * </code>
     *
     * @param  string $modId  Module id
     * @return AMI_Cache
     */
    public function expirePluginBlock($modId){
        if(AMI_Registry::exists('_source_mod_id')){
            $modId = AMI_Registry::get('_source_mod_id');
        }
        return $this->expireBlock('small_' . $modId);
    }

    /**
     * Constructor.
     */
    private function __construct(){
    }

    /**
     * Cloning is forbidden.
     */
    private function __clone(){
    }
}
