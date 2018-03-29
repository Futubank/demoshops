<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiClean_Trustlink 
 * @since      7.0.0 
 * @size       3706 xkqwmgirskllkuminxkutuwklitgtlitskmqxsuktqprswnpwrmqkmqrgxzkgqkrqysgpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiClean/Trustlink configuration metadata.
 *
 * @package    Config_AmiClean_Trustlink
 * @subpackage Meta
 * @since      7.0.0
 */
class AmiClean_Trustlink_Meta extends AMI_HyperConfig_Meta{
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
     * Array having locales as keys and captions as values
     *
     * @var array
     */
    protected $aTitle = array(
        'en' => 'TRUSTLINK.RU link exchanger',
        'ru' => 'Отображение ссылок с TRUSTLINK.RU'
    );

    /**
     * Array having locales as keys and meta data as values
     *
     * @var array
     */
    protected $aInfo = array(
        'en' => array(
            'description' => 'TRUSTLINK.RU link exchanger',
            'author'      => '<a href="http://www.amirocms.com" target="_blank">Amiro.CMS</a>'
        ),
        'ru' => array(
            'description' => 'Плагин предназначен для отображения ссылок, предоставляемых интернет-сервисом TRUSTLINK.RU.
ВНИМАНИЕ! Все действия по установке программного кода, которые описаны на сайте trustlink.ru выполнять не нужно.
Требуется только правильно сконфигурировать данный плагин.
После установки плагина, в менеджере сайта появиться специальный блок "Отображение ссылок с TRUSTLINK.RU".',
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
                'type' => self::CAPTION_TYPE_STRING,
                'locales' => array(
                    'en' => array(
                        'name' => 'Menu caption',
                        'caption' => 'TRUSTLINK.RU',
                    ),
                    'ru' => array(
                        'name' => 'Заголовок для меню',
                        'caption' => 'Отображение ссылок с TRUSTLINK.RU',
                    ),
                ),
            ),
            'specblock' => array(
                'obligatory' => TRUE,
                'type' => self::CAPTION_TYPE_STRING,
                'locales' => array(
                    'en' => array(
                        'name' => 'Specblock caption for Site Manager',
                        'caption' => 'TRUSTLINK.RU',
                    ),
                    'ru' => array(
                        'name' => 'Название спецблока для менеджера сайта',
                        'caption' => 'TRUSTLINK.RU',
                    ),
                ),
            ),
        ),
    );
}
