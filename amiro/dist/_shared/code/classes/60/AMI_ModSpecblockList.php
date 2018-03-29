<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    ModuleComponent 
 * @version    $Id$ 
 * @since      5.14.8 
 * @size       1731 xkqwxyzysqqlmslrtqyumkimipmxmsgknlrtxxuitkgpgnnwizusnxgrrgrnlgisxriypnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Module specblock list component controller.
 *
 * @package    ModuleComponent
 * @subpackage Controller
 * @since      5.14.8
 */
abstract class AMI_ModSpecblockList extends AMI_ModList{
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
}

/**
 * Module specblock list component view abstraction.
 *
 * @package    ModuleComponent
 * @subpackage View
 * @since      5.14.8
 */
abstract class AMI_ModSpecblockListView extends AMI_ModListView{
    /**
     * Constructor.
     */
    public function __construct(){
        // Specblock template, blockname and locale filename
        $this->tplBlockName   = $this->getModId() . '_specblock';
        $this->tplFileName    = AMI_iTemplate::TPL_MOD_PATH . '/' . $this->getModId() . '_specblock.tpl';
        $this->localeFileName = AMI_iTemplate::LNG_MOD_PATH . '/' . $this->getModId() . '_specblock.lng';

        parent::__construct();
    }
}
