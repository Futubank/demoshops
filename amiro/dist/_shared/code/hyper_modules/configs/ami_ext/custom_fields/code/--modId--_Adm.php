<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module_##modId## 
 * @version    $Id$ 
 * @size       1192 xkqwlpqqpuwgqtglygxpyqrkrxntqkktgngsulximmukrpsnrlrgriukqqwwmuqtkwszpnir
 */
?><?php


/**
 * ##modId## module admin action controller.
 *
 * @package    Module_##modId##
 * @subpackage Controller
 * @amidev     Temporary
 */
class ##modId##_Adm extends AmiExt_CustomFields_Adm{
}

/**
 * ##modId## module admin view.
 *
 * @package    Module_##modId##
 * @subpackage View
 * @amidev     Temporary
 */
class ##modId##_ViewAdm extends AmiExt_CustomFields_ViewAdm{
}

/**
 * ##modId## module service class.
 *
 * @package    Module_##modId##
 * @amidev     Temporary
 */
class ##modId##_Service extends AmiExt_CustomFields_Service{
    /**
     * Returns ##modId##_Service instance.
     *
     * @return ##modId##_Service
     */
    public static function getInstance(){
        if(self::$oInstance == null){
            self::$oInstance = new self;
        }
        return self::$oInstance;
    }
}
