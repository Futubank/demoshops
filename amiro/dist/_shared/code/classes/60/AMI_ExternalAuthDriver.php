<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Service 
 * @version    $Id$ 
 * @since      5.12.4 
 * @size       1669 xkqwklgulkwmqptxpsumtpqqkpkikywuyztpwxwnltxqsrqsgmsmmrqnzzxwzgxswwmgpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * External auth driver abstract class.
 *
 * See {@link VBulletin_ExternalAuthDriver} for usage example.
 *
 * @package Service
 * @since   5.12.4
 */
abstract class AMI_ExternalAuthDriver{
    /**
     * Error 1001: wrong user object (invalid object type or null)
     *
     * @var int
     */
    const ERR_WRONG_OBJECT = 1001;

    /**
     * Error 1001: message
     *
     * @var string
     */
    const MSG_WRONG_OBJECT = 'Wrong user object';

    /**
     * Instance
     *
     * @var AMI_ExternalAuthDriver
     */
    protected static $oInstance = null;

    /**
     * Settings array
     *
     * @var array
     */
    protected $aSettings = array();

    /**
     * Initialize settings.
     *
     * @param array $aSettings  Settings
     * @return void
     */
    public function init(array $aSettings = array()){
        $this->aSettings = array_merge($this->aSettings, $aSettings);
    }

    /**
     * Object could be created, through getInstance only.
     */
    protected function __construct(){
    }

    /**
     * Object could be cloned.
     */
    protected function __clone(){
    }
}
