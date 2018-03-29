<?php
/**
* @copyright 2000-2013 Amiro.CMS. All rights reserved.
* @version $ Id: PlgAJAXRespAdmin.php 61118 2012-12-25 19:49:50  Artem $
* @package   Plugin_AJAXResponder
* @subpackage   Mixed
* @filesource
* @size 7153 xkqwkmmynlpzmguttkigmttzuxpwpnulnxgwnzywwwrgygrysuxynykpmtkzrimrltxipnir
* @since   5.10.0
*/
?>
<?php


/**
 * Admin side script displaing select box with available modules (CMS context).
 *
 * @package    Plugin_AJAXResponder
 * @subpackage Mixed
 * @see        admin.php
 */
class PlgAJAXRespAdmin{
    /**
     * Template block name
     *
     * @var string
     */
    private $tplBlock = 'plg_ami_ajax_responder';

    /**
     * @var AMI_iTemplate
     */
    private $oTpl;

    /**
     * Path to the plugin config file
     *
     * @var string
     */
    private $configPath;

    /**
     * @var array
     */
    private $aConfig = array(
        'available_modules' => array(),
        'allowed_modules'   => array()
    );

    /**
     * @var array
     */
    private $aStatusMessages = array('error' => array(), 'notice' => array());

    /**
     * Parsed locales
     *
     * @var array
     */
    private $aLocale;

    /**
     * Constructor
     *
     * @param array $aParams  Plugin parameters passed by CMS
     */
    public function __construct(array $aParams){
        $this->oTpl = AMI::getSingleton('env/template_sys');

        $this->aLocale = $this->oTpl->parseLocale($aParams['templates_path'] . 'admin.lng');
        $this->oTpl->addBlock($this->tplBlock, $aParams['templates_path'] . 'admin.tpl');

        $this->configPath = $aParams['config_file'];
        if(!is_file($this->configPath)){
            $this->addStatusMessage(sprintf($this->aLocale['error_missing_config_file'], $this->configPath), 'error');
            return;
        }

        // {

        $oDeclarator = AMI_ModDeclarator::getInstance();
        $aConfig = @parse_ini_file($this->configPath);
        $aAvailableModules = explode(',', $aConfig['available_modules']);
        $aModIds = array('blog', 'search_history');
        foreach(
            array(
                'ami_multifeeds' => array('articles', 'news', 'photoalbum', 'stickers'),
                'ami_files'      => array('files'),
                'ami_catalog'    => array('items')
            ) as $hyper => $aConfigs
        ){
            foreach($aConfigs as $config){
                $aInstanceMoIds = $oDeclarator->getRegistered($hyper, $config);
                foreach($aInstanceMoIds as $modId){
                    if(!preg_match('/_cat$/', $modId)){
                        $aAvailableModules[] = $modId;
                    }
                }
            }
        }

        $aConfig['available_modules'] = implode(',', array_unique($aAvailableModules));

        // }

        if(!is_array($aConfig)){
            $this->addStatusMessage(sprintf($this->aLocale['error_invalid_config_file'], $this->configPath), 'error');
            return;
        }
        foreach(array('available_modules', 'allowed_modules') as $key){
            if(!isset($aConfig[$key])){
                $this->addStatusMessage(sprintf($this->aLocale['error_missing_config_file_parameter'], $key, $this->configPath), 'error');
                return;
            }
            $this->aConfig[$key] = mb_strlen($aConfig[$key]) ? explode(',', $aConfig[$key]) : array();
        }
        // drop available modules that aren't in allowed modules list
        $this->aConfig['allowed_modules'] = array_intersect(
            $this->aConfig['allowed_modules'],
            $this->aConfig['available_modules']
        );

        /**
         * @var AMI_Request
         */
        $oRequest = AMI::getSingleton('env/request');
        /**
         * Sent from form alloved modules list
         *
         * @var array
         */
        $aAllovedModules = $oRequest->get('alloved_modules', array());
        if($oRequest->get('save', false)){
            // drop available modules that aren't in allowed modules list
            $aAllovedModules = array_intersect($aAllovedModules, $this->aConfig['available_modules']);
            if($this->aConfig['allowed_modules'] != $aAllovedModules){
                $configContent = file_get_contents($this->configPath);
                $configContent = preg_replace('/(\sallowed_modules\s*=\s*")([^"]*)"/', '\\1' . implode(',', $aAllovedModules) . '"', $configContent);
                if(@file_put_contents($this->configPath, $configContent)){
                    @chmod($this->configPath, 0777);
                    $this->addStatusMessage($this->aLocale['message_saved']);
                    $this->aConfig['allowed_modules'] = $aAllovedModules;
                }else{
                    $this->addStatusMessage(sprintf($this->aLocale['error_cant_save'], $this->configPath), 'error');
                }
            }
        }
    }

    /**
     * Returns admin interface HTML.
     *
     * @return string
     */
    public function getResponse(){
        $html = $this->getStatusMessages();
        if(sizeof($this->aConfig['available_modules'])){
            $list = '';
            $oService = new AMI_Service_Adm();
            $aModCaptions = $oService->getModulesCaptions($this->aConfig['available_modules'], FALSE);
            foreach($aModCaptions as $modId => $caption){
                $this->aLocale['mod_' . $modId] = $caption;
            }
            foreach($this->aConfig['available_modules'] as $module){
                $caption = 'mod_' . $module;
                $modCaption = isset($this->aLocale[$caption]) ? $this->aLocale[$caption] : '[' . $module . ']';
                $list .= $this->oTpl->parse($this->tplBlock . ':option_row', array(
                    'value'    => $module,
                    'selected' => in_array($module, $this->aConfig['allowed_modules']),
                    'caption'  => $modCaption
                ));
            }
            $html .= $this->oTpl->parse($this->tplBlock . ':body', array('alloved_modules' => $list));
        }
        return $html;
    }

    /**
     * Adds notification message to admin interface.
     *
     * @param string $message
     * @param string $type  'notice'|'error'
     * @return void
     */
    private function addStatusMessage($message, $type = 'notice'){
        if(isset($this->aStatusMessages[$type])){
            $this->aStatusMessages[$type][] = $message;
        }else{
            trigger_error("Unknown message type '" . $type . "'", E_USER_WARNING);
        }
    }

    /**
     * Returns admin interface messages.
     *
     * @return string
     */
    private function getStatusMessages(){
        $html = '';
        if(sizeof($this->aStatusMessages['error']) || sizeof($this->aStatusMessages['notice'])){
            $messages = '';
            foreach($this->aStatusMessages as $type => $aMessages){
                foreach($aMessages as $message){
                    $messages .= $this->oTpl->parse($this->tplBlock . ':status_' . $type, array('message' => $message));
                }
            }
            $html = $this->oTpl->parse($this->tplBlock . ':status_messages', array('messages' => $messages));
        }
        return $html;
    }
}
