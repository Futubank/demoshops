<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Service 
 * @since      6.0.6 
 * @size       1770 xkqwmlrpqmgzzxsspqwuukrkzulgyntygpinzusxgrrswrkwxskuwzzzmygtktrtxttkpnir
 */
?><?php

class AMI_BackgroundProcess{
    /**
     * Instance
     *
     * @var AMI_BackgroundProcess
     */
    protected static $oInstance;

    /**
     * CMS background process object
     *
     * @var CMS_BackgroundProcess
     * @amidev
     */
    protected $oBackgroundProcess;

    /**
     * Returns an instance of AMI_BackgroundProcess.
     *
     * @param  array $aArgs  Constructor arguments
     * @return AMI_BackgroundProcess
     * @amidev
     */
    public static function getInstance(array $aArgs = array()){
        if(is_null(self::$oInstance)){
            self::$oInstance = new AMI_BackgroundProcess();
        }
        return self::$oInstance;
    }

    /**
     * Constructor.
     */
    public function __construct(){
        require_once $GLOBALS['CLASSES_PATH'] . 'CMS_BackgroundProcess.php';
        $this->oBackgroundProcess = new CMS_BackgroundProcess();
    }

    /**
     * Register background handler.
     *
     * @param string $handler  Handler name like "className::methodName".
     * @return void
     */
    public function registerHandler($handler){
        $this->oBackgroundProcess->registerHandler($handler, '');
    }

    /**
     * Unregister background handler.
     *
     * @param string $handler  Handler name like "className::methodName".
     * @return void
     */
    public function unregisterHandler($handler){
        $this->oBackgroundProcess->unregisterHandler($handler);
    }
}
