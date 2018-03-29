<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiClean_ActiveSessions 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2863 xkqwwzqrnsgskszplqxggxklmqtzikupzpwyyxquirxpkyxxqytwzmzzznkukknngnpgpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiClean/ActiveSessions configuration metadata.
 *
 * @package    Config_AmiClean_ActiveSessions
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_ActiveSessions_Meta extends AMI_HyperConfig_Meta{
    /**
     * Version
     *
     * @var string
     */
    protected $version = '1.0';

    /**
     * Instance can not be edited
     *
     * @var bool
     */
    protected $editable = FALSE;

    /**
     * Only one instance per config allowed
     *
     * @var bool
     */
    protected $isSingleInstance = TRUE;

    /**
     * Flag specifies possibility of local PHP-code generation
     *
     * @var   bool
     */
    protected $canGenCode = FALSE;

    /**
     * Flag speficies impossibility of instance deinstallation
     *
     * @var bool
     * @amidev
     */
    protected $permanent = TRUE;

    /**
     * Array having locales as keys and titles as values
     *
     * @var array
     */
    protected $aTitle = array(
        'en' => 'Active sessions',
        'ru' => 'Активные сессии'
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
     * Array containing captions struct
     *
     * @var array
     */
    protected $aCaptions = array(
        '' => array(
            'menu' => array(
                'obligatory' => TRUE,
                'type'       => self::CAPTION_TYPE_STRING,
                'locales'    => array(
                    'en' => array(
                        'name'    => 'Menu caption',
                        'caption' => 'Active sessions'
                    ),
                    'ru' => array(
                        'name'    => 'Заголовок для меню',
                        'caption' => 'Активные сессии'
                    )
                )
            )
        )
    );
}
