<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    ModuleComponent 
 * @version    $Id: AMI_ModForm.php 40175 2013-07-31 12:20:28Z Leontiev Anton $ 
 * @since      x.x.x 
 * @size       1450 xkqwuntgkywwptnzrqxslnytsmwwzyuzsmkxsmrutmzrsnqkttilqnqqkuppugnpltuspnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Module form component action controller.
 *
 * @package    ModuleComponent
 * @subpackage Controller
 * @since      x.x.x
 * @amidev
 */
abstract class AMI_ModFormOldEnvAdm extends AMI_ModFormAdm{
    /**
     * 
     * @return boolean
     */
    public function isFullEnv(){
        return TRUE;
    }
}

/**
 * Old environment form view.
 *
 * @package    ModuleComponent
 * @subpackage View
 * @since      x.x.x
 * @amidev
 */
class AMI_ModFormOldEnvViewAdm extends AMI_ModFormViewAdm{

    /**
     * Old env module id.
     *
     * @var string
     */
    protected $formModId;

    /**
     * Returns view data.
     *
     * @return null
     */
    public function get(){
        if($this->formModId){
            return  AMI_OldEnv::getAdmForm($this->formModId);
        }else{
            return parent::get();
        }
    }
}
