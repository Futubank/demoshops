<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiUsers_AccessRights 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1408 xkqwnrzpxqsttsxrlwqsgtuklmxmzypkgwgqnsmniutmqyrxswistnpxqtgiipxltuskpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiFake/GoogleSitemap configuration metadata.
 *
 * @package    Config_AmiUsers_AccessRights
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiUsers_AccessRights_Meta extends AMI_HyperConfig_Meta{
    /**
     * Version
     *
     * @var string
     */
    protected $version = '1.0';

    /**
     * Flag specifying that hypermodule configs can have only one instance per config
     *
     * @var bool
     */
    protected $isSingleInstance = TRUE;

    /**
     * Flag speficies impossibility of instance deinstallation
     *
     * @var bool
     * @amidev
     */
    protected $permanent = TRUE;

    /**
     * Array having locales as keys and captions as values
     *
     * @var array
     */
    protected $aTitle = array(
        'en' => 'Access Rights',
        'ru' => 'Права доступа'
    );
}
