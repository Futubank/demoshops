<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiAsync_PrivateMessages 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1783 xkqwuylxmrqmtmrgtgitwsxrqwqwmwnpumkmqrwrtnigirxntxnzrxgtmnxwnszlxrylpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiAsync/PrivateMessages configuration email notification view.
 *
 * @package    Config_AmiAsync_PrivateMessages
 * @subpackage View
 * @resource   private_messages/mail/view <code>AMI::getResource('private_messages/mail/view')</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class PrivateMessages_EmailView extends AMI_View{
    /**
     * Template file name
     *
     * @var string
     */
    protected $tplFileName = '_local/_admin/templates/letters/private_messages.tpl';

    /**
     * Template block name
     *
     * @var string
     */
    protected $tplBlockName = 'private_message';

    /**
     * Locale file name
     *
     * @var string
     */
    protected $localeFileName = '_local/_admin/templates/lang/private_messages.lng';

    /**
     * Returns view data.
     *
     * @return null
     */
    public function get(){
        return null;
    }

    /**
     * Returns view data.
     *
     * @param  string $part  Subject/Body ('subject'|'body')
     * @return string
     */
    public function getPart($part){
        $oTpl = $this->getTemplate();
        $aScope = $this->getScope($part);
        return $oTpl->parse($this->tplBlockName . ':' . $part, $aScope);
    }
}
