<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    ModuleComponent 
 * @version    $Id$ 
 * @since      5.14.8 
 * @size       1374 xkqwxswlkglgguzmrzmstpglttrgmgslzlsiwgrnznqylyqtpnwwwznptwsqqkqquitzpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Module specblock component controller.
 *
 * @package    ModuleComponent
 * @subpackage Controller
 * @since      5.14.8
 */
abstract class AMI_ModSpecblock extends AMI_ModComponent{
    /**
     * Initialization.
     *
     * @return AMI_iModComponent
     * @see    AMI_Mod::init()
     */
    public function init(){
        $this->displayView();
        return $this;
    }

    /**
     * Returns component type.
     *
     * @return string
     */
    public function getType(){
        return 'specblock';
    }

    /**
     * Returns component view.
     *
     * @return AMI_View
     */
    public function getView(){
        $type = $this->getType();
        if($this->getPostfix() != ''){
            $type .= ('_' . $this->getPostfix());
        }
        return $this->_getView('/' . $type . '/view/frn');
    }
}
