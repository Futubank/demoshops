<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiExt_CustomFields 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2461 xkqwpzursnkpprxymgzwurzppltptkwznwtqtqkmkxiqzwksuwnzlrqzprgryinsyqgkpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiExt/CustomFields extension configuration metadata.
 *
 * @package    Config_AmiExt_CustomFields
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_CustomFields_Meta extends AMI_HyperConfig_Meta{
    /**
     * Version
     *
     * @var string
     */
    protected $version = '1.0';

    /**
     * Exact instance modId
     *
     * @var string
     */
    protected $instanceId = 'ext_custom_fields';

    /**
     * Array having locales as keys and captions as values
     *
     * @var array
     */
    protected $aTitle = array(
        'en' => 'Custom Fields',
        'ru' => 'Наборы полей'
    );

    /**
     * Array having locales as keys and meta data as values
     *
     * @var array
     */
    protected $aInfo = array(
        'en' => array(
            // 'description' => '',
            'author'      => '<a href="http://www.amirocms.com" target="_blank">Amiro.CMS</a>'
        ),
        'ru' => array(
            // 'description' => '',
            'author'      => '<a href="http://www.amiro.ru" target="_blank">Amiro.CMS</a>'
        )
    );


    /**
     * Array having locales as keys and array of instance default captions as values
     *
     * @var array
     */
    protected $aDefaultCaptions = array(
        'en' => array(
            'root' => array(
                'header'      => '',
                'menu'        => '',
                'description' => '',
                'specblock'   => ''
            )
        ),
        'ru' => array(
            'root' => array(
                'header'      => '',
                'menu'        => '',
                'description' => '',
                'specblock'   => ''
            )
        )
    );

    /**
     * Only one instance per config allowed
     *
     * @var bool
     */
    protected $isSingleInstance = TRUE;
}
