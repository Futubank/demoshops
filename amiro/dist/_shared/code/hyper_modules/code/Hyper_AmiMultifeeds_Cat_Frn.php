<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiMultifeeds 
 * @version    $Id$ 
 * @since      7.0.0 
 * @size       1947 xkqwpssnqzpqqiwixtympygqlptpziuquswqztkimipqkmqwzqmqwusqplpkgwqqmguzpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds hypermodule category edit-in-place controller.
 *
 * @package    Hyper_AmiMultifeeds
 * @subpackage Controller
 * @since      7.0.0
 */
abstract class Hyper_AmiMultifeeds_Cat_Frn extends Hyper_AmiMultifeeds_Frn{
}

/**
 * AmiMultifeeds hypermodule category module model.
 *
 * @package    Hyper_AmiMultifeeds
 * @subpackage Model
 * @since      7.0.0
 */
abstract class Hyper_AmiMultifeeds_Cat_State extends AMI_ModState{
}

/**
 * AmiMultifeeds hypermodule category edit-in-place form component action controller.
 *
 * @package    Hyper_AmiMultifeeds
 * @subpackage Controller
 * @since      7.0.0
 */
abstract class Hyper_AmiMultifeeds_Cat_FormFrn extends Hyper_AmiAsync_FormFrn{
    /**
     * Returns true if component needs to be started always in full environment.
     *
     * @return bool
     */
    public function isFullEnv(){
        return FALSE;
    }

    /**
     * Initialization.
     */
    public function init(){
        AMI::setProperty($this->getModId(), 'picture_cat', 'photoalbum');
        return parent::init();
    }
}

/**
 * AmiMultifeeds hypermodule category form component view.
 *
 * @package    Hyper_AmiMultifeeds
 * @subpackage View
 * @since      7.0.0
 */
abstract class Hyper_AmiMultifeeds_Cat_FormViewFrn extends Hyper_AmiMultifeeds_FormViewFrn{
    /**
     * Initialization.
     */
    public function init() {
        parent::init();
        $this->dropField('date_created');
    }
}
