<?php
/**
* @copyright 2000-2011 Amiro.CMS. All rights reserved.
* @version $ Id: PlgAJAXRespFront.php 54811 2011-01-19 15:29:25  Oleg $
* @package   Plugin_AJAXResponder
* @subpackage   View
* @filesource
* @size 2617 xkqwqmipmtrwmkrsqtrlzmqixzunlulmygsulmksmuymmrqkmxgzsyugqwllxqxygtzypnir
* @since   5.10.0
*/
?>
<?php


/**
 * Plugin front side (CMS context).
 *
 * @package    Plugin_AJAXResponder
 * @subpackage View
 * @see        plg_ami_ajax_responder.php
 */
class PlgAJAXRespFront{
    /**
     * @var array
     */
    private $aParams;

    /**
     * @var AMI_PluginState
     */
    private $oPlgAPI;

    /**
     * @var AMI_iTemplate
     */
    private $oTpl;

    /**
     * @var string
     */
    private $tplBlock = 'plg_ami_ajax_responder';

    /**
     * Unique plugin id
     *
     * @var string
     */
    private $id;

    /**
     * Constructor
     *
     * @param array $aPluginParams  $pluginParams array
     */
    public function __construct($aPluginParams){
        $this->aParams = $aPluginParams;
        $this->oTpl = new AMI_Template;
        $this->oTpl->setLocale($this->aParams['lang_data']);
        $this->id = $this->aParams['plugin_id'] . str_replace(array(' ', '.'), '', microtime());
        $aLocale = $this->oTpl->parseLocale(
            $this->aParams['templates_path'] .
            preg_replace('/\.[^\.]+$/', '', AMI::getPluginOption($this->aParams['plugin_id'], 'template')) .
            '.lng'
        );
        $this->oTpl->addBlock(
            $this->tplBlock, $this->aParams['templates_path'] .
            AMI::getPluginOption($this->aParams['plugin_id'], 'template')
        );
        $this->oTpl->setBlockLocale($this->tplBlock, $aLocale);
    }

    /**
     * Returns plugin HTML
     *
     * @return string
     */
    public function getHTML(){
        $aScope = array(
            'locale'    => $this->aParams['lang_data'],
            'id_block'  => $this->id,
            'id_plugin' => $this->aParams['plugin_id']
        );
        foreach(array('module', 'order', 'dir', 'limit', 'offset', 'id_page') as $option){
            $aScope[$option] = AMI::getPluginOption($this->aParams['plugin_id'], $option);
        }
        $aScope['mod_link'] = AMI_PageManager::getModLink($aScope['module'], $this->aParams['lang_data'], $aScope['id_page']);
        $aScope['locale'] = $this->aParams['lang_data'];
        $aScope['render_row'] = $this->oTpl->parse($this->tplBlock . ':render_row', $aScope);
        $aScope['js'] = $this->oTpl->parse($this->tplBlock . ':js', $aScope);
        return $this->oTpl->parse($this->tplBlock . ':body', $aScope);
    }
}
