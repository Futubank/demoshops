<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module_AMI_Module 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1278 xkqwwzkyqqgsmywqtrmywqgsklukslwlutzzsksqztwwpzkunkurlmxktwzwxwlllzyqpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Module front async component view.
 *
 * @package    Module_AMI_Module
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
class AMI_Module_AsyncViewFrn extends AMI_View{
    /**
     * Template file name
     *
     * @var string
     */
    protected $tplFileName = '_shared/code/templates/modules/_mod.tpl';

    /**
     * Template block name
     *
     * @var string
     */
    protected $tplBlockName = 'async';

    /**
     * Returns view data.
     *
     * @return string
     */
    public function get(){
        $aScope = $this->getScope('mod_page');
        $aScope['head_scripts'] = AMI_Registry::get('oGUI')->getScripts();
        return $this->getTemplate()->parse($this->tplBlockName, $aScope);
    }
}
