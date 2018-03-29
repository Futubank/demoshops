<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    ModuleComponent 
 * @version    $Id$ 
 * @since      5.14.6 
 * @size       3263 xkqwnkkzpwxqmsqwnnssgrtpnrpkgpnqprggylzzrxmuuiitqzqrpyiuwkwgkzkmsuilpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Abstract custom component controller.
 *
 * @package    ModuleComponent
 * @subpackage Controller
 * @since      5.14.6
 */
abstract class AMI_CustomComponent extends AMI_ModComponent{
    /**
     * Initialization.
     *
     * @return AMI_CustomComponent
     * @see    AMI_ModComponent::init()
     */
    public function init(){
        $this->displayView();
        return $this;
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
        return $this->_getView('/' . $type . '/view/' . AMI_Registry::get('side'));
    }
}

/**
 * Abstract custom component view.
 *
 * @package    ModuleComponent
 * @subpackage View
 * @since      5.14.6
 */
abstract class AMI_CustomComponentView extends AMI_View{
    /**
     * Component type
     *
     * @var string
     * @amidev Temporary
     */
    protected $type;

    /**
     * Constructor.
     */
    public function __construct(){
    }

    /**
     * Returns component type.
     *
     * @param string $type  Component type
     * @return void
     * @amidev Temporary
     */
    public function setType($type){
        $this->type = $type;
    }

    /**
     * Returns component type.
     *
     * @return string
     * @amidev Temporary
     */
    public function getType(){
        return $this->type;
    }

    /**
     * Initialize, processing after setting model.
     *
     * @return AMI_View
     */
    public function init(){
        $name = $this->getModId() . '_' . $this->getType();
        $isAdmin = (AMI_Registry::get('side') == 'adm');
        $filename = $isAdmin ? $name : $this->getModId();
        $tplPath = $isAdmin ? AMI_iTemplate::LOCAL_TPL_MOD_PATH : AMI_iTemplate::TPL_MOD_PATH;
        $lngPath = $isAdmin ? AMI_iTemplate::LOCAL_LNG_MOD_PATH : AMI_iTemplate::LNG_MOD_PATH;

        if(empty($this->tplBlockName)){
            $this->tplBlockName   = $name;
        }
        if(empty($this->tplFileName)){
            $this->tplFileName    = $tplPath . '/' . $filename . '.tpl';
        }
        if(empty($this->localeFileName)){
            $this->localeFileName = $lngPath . '/' . $filename . '.lng';
        }

        $this->getTemplate()->addBlock($this->tplBlockName, $this->tplFileName);
        $this->aLocale = $this->getTemplate()->parseLocale($this->localeFileName);

    	return $this;
    }

    /**
     * Returns view data.
     *
     * @return string
     */
    public function get(){
        return $this->parse('body', array());
    }
}