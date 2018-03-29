<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiClean 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       3621 xkqwsynwsulmlrwztrzliitgrkpqixkirgpuikkpktqruqznlkptinuymimsrrwqguxxpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Base hypermodule front action controller.
 *
 * @package    Hyper_AmiClean
 * @subpackage Controller
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_Frn extends AMI_Module_Frn{
    /**
     * Dispathes default action.
     *
     * @return void
     */
    protected function dispatchDefaultAction(){
    }
}

/**
 * Base hypermodule front items component.
 *
 * @package    Hyper_AmiClean
 * @subpackage Controller
 * @since      6.0.2
 */
class Hyper_AmiClean_ItemsFrn extends AMI_ModItemsFrn{
}

/**
 * Base hypermodule front items body type view.
 *
 * @package    Hyper_AmiClean
 * @subpackage View
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_ItemsViewFrn extends AMI_ModItemsView{
    /**
     * Returns view data.
     *
     * @return string
     */
    public function get(){
        $aData = parent::get();
        AMI_Event::fire('on_list_view', $aData, $this->getModId());
        $aData['body'] = $this->oCommonView->parseTpl('body', $aData);
        return $this->oTpl->parse($this->getModId(), $aData);
    }
}

/**
 * Base hypermodule front details component.
 *
 * @package    Hyper_AmiClean
 * @subpackage Controller
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_DetailsFrn extends AMI_ModDetails{
    /**
     * Initialization.
     *
     * @return AMI_ModComponentStub
     */
    public function init(){
        $this->bDispayView = true;
        return $this;
    }

    /**
     * Returns component view.
     *
     * @return AMI_ViewEmpty
     */
    public function getView(){
        $oView = $this->_getView('/' . $this->getType() . '/view/frn');
        return $oView;
    }
}

/**
 * Base hypermodule front details body type view.
 *
 * @package    Hyper_AmiClean
 * @subpackage View
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_DetailsViewFrn extends AMI_ModDetailsView{
    /**
     * Constructor.
     */
    public function __construct(){
        $modId = $this->getModId();
        $this->tplFileName = AMI_iTemplate::TPL_MOD_PATH . '/' . $modId . '.tpl';
        $this->tplBlockName = $modId . '_details';
        $this->localeFileName = AMI_iTemplate::LNG_MOD_PATH . '/' . $modId . '.lng';
        parent::__construct();
    }

    /**
     * Returns view data.
     *
     * @return string
     */
    public function get(){
        $this->prepareFieldCallbacks();
        $aData = parent::get();
        $aData['body'] = $this->oTpl->parse($this->tplBlockName.':body_itemD', $aData);
        $aData['body'] = $this->oTpl->parse($this->tplBlockName, $aData);
        return $aData['body'];
    }
}

/**
 * Base hypermodule front component controller.
 *
 * @package    Hyper_AmiClean
 * @subpackage Controller
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_ComponentFrn extends AMI_CustomComponent{
}

/**
 * Base hypermodule front component view.
 *
 * @package    Hyper_AmiClean
 * @subpackage View
 * @since      6.0.2
 */
abstract class Hyper_AmiClean_ComponentViewFrn extends AMI_CustomComponentView{
}
