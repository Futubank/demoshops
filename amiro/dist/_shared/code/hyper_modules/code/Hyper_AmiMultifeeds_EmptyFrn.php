<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiMultifeeds 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       1322 xkqwuzguxwtxgksplgmzswmyzmnttkkspykykwwuutsnmgknnyrznrtrzsqmrwxlxxgrpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Multifeeds hypermodule front empty body type action controller.
 *
 * @package    Hyper_AmiMultifeeds
 * @subpackage Controller
 * @since      6.0.2
 */
class Hyper_AmiMultifeeds_EmptyFrn extends AMI_ModEmptyFrn{
}

/**
 * Multifeeds hypermodule front cats body type view.
 *
 * @package    Hyper_AmiMultifeeds
 * @subpackage View
 * @since      6.0.2
 */
class Hyper_AmiMultifeeds_EmptyViewFrn extends AMI_ModEmptyView{
    /**
     * Constructor.
     */
    public function __construct(){
        $modId = $this->getModId();

        $this->tplFileName = AMI_iTemplate::TPL_MOD_PATH . '/' . $modId . '.tpl';;
        $this->tplBlockName = $modId . '_empty';
        $this->localeFileName = AMI_iTemplate::LNG_MOD_PATH . '/' . $modId . '.lng';

        parent::__construct();
    }
}
