<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiExt_Reindex 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2280 xkqwuzutqxwpkgnyrryiswlnyygksprqrikuquuxwwxmugsssuprptnzgnqlupnwwzmrpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiExt/Reindex extension configuration front controller.
 *
 * @package    Config_AmiExt_Reindex
 * @subpackage Controller
 * @resource   ext_reindex/module/controller/frn <code>AMI::getResource('ext_reindex/module/controller/frn')</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_Reindex_Frn extends Hyper_AmiExt{

    /**
     * Extension object.
     */
    protected $oRealExt;

    /**
     * Constructor.
     *
     * @param string  $modId        Module id
     * @param string  $optSrcId     Options source module id
     * @param AMI_Mod $oController  Controller
     */
    public function __construct($modId, $optSrcId = '', AMI_Mod $oController = null) {
        parent::__construct($modId, $optSrcId, $oController);
        if(AMI_Skin::isModuleSpecialMode($this->getModId())){
            $this->oRealExt = AMI::getResource('ext_reindex/module/controller/skin', array($modId, $optSrcId, $oController));
        }
    }

    /**
     * Extension initialization.
     *
     * @param  string $name          Event name
     * @param  array  $aEvent        Event data
     * @param  string $handlerModId  Handler module id
     * @param  string $srcModId      Source module id
     * @return array
     * @see    AMI_Ext::__construct()
     * @see    AMI_Mod::init()
     */
    public function handlePreInit($name, array $aEvent, $handlerModId, $srcModId){
        if(AMI_Skin::isModuleSpecialMode($this->getModId())){
            return $this->oRealExt->handlePreInit($name, $aEvent, $handlerModId, $srcModId);
        }
        return $aEvent;
    }
}

/**
 * AmiExt/Reindex extension configuration front controller for Skin mode.
 * 
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_Reindex_Skin extends AmiExt_Reindex_Adm{
}
