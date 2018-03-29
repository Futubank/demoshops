<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiClean_AmiSkinTools 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2387 xkqwlznuuyzuxumtqlmwpglzmytirwplrsumxmltrgntwwyxtzzklqzqxrzkmtnpzwykpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiClean/EditInPlace configuration metadata.
 *
 * @package    Config_AmiClean_AmiSkinTools
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_AmiSkinTools_Meta extends AMI_HyperConfig_Meta{
    /**
     * Version
     *
     * @var string
     */
    protected $version = '1.0';

    /**
     * Only one instance per config allowed
     *
     * @var bool
     */
    protected $isSingleInstance = TRUE;

    /**
     * Flag specifies to display configuraration in Module Manager
     *
     * @var bool
     * @amidev
     */
    protected $isVisible = FALSE;

    /**
     * Exact instance modId
     *
     * @var string
     */
    protected $instanceId = 'ami_skin_tools';

    /**
     * Flag speficies impossibility of instance deinstallation
     *
     * @var bool
     * @amidev
     */
    protected $permanent = TRUE;

    /**
     * Flag specifies possibility of instace editing
     *
     * @var    bool
     * @amidev Temporary
     */
    protected $editable = FALSE;

    /**
     * Flag specifies possibility of local PHP-code generation
     *
     * @var   bool
     */
    protected $canGenCode = FALSE;

    /**
     * Array having locales as keys and captions as values
     *
     * @var array
     */
    protected $aTitle = array(
        'en' => 'Skin Tools',
        'ru' => 'Интструменты оформления'
    );

    /**
     * Array having locales as keys and meta data as values
     *
     * @var array
     */
    protected $aInfo = array(
        'en' => array(
            'description' => 'Skin Tools',
            'author'      => '<a href="http://www.amirocms.com" target="_blank">Amiro.CMS</a>'
        ),
        'ru' => array(
            'description' => 'Skin Tools',
            'author'      => '<a href="http://www.amiro.ru" target="_blank">Amiro.CMS</a>'
        )
    );
}
