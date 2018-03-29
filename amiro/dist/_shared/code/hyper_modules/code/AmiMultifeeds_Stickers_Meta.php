<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds_Stickers 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       5630 xkqwlxwslqyprwgsypkwzyllsgmtyilkyqpunzwxkurlnizyqgqkruttgkylpyntulqtpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds/Stickers configuration metadata.
 *
 * @package    Config_AmiMultifeeds_Stickers
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiMultifeeds_Stickers_Meta extends AMI_HyperConfig_Meta{
    /**
     * Version
     *
     * @var string
     */
    protected $version = '1.0';

    /**
     * Only one instance per config allowed
     *
     * @var  bool
     * @todo Remove flag after mod_manager publication
     */
    protected $isSingleInstance = TRUE;

    /**
     * Flag speficies impossibility of instance deinstallation
     *
     * @var  bool
     * @amidev
     * @todo Remove flag after mod_manager publication
     */
    protected $permanent = TRUE;

    /**
     * Array having locales as keys and titles as values
     *
     * @var array
     */
    protected $aTitle = array(
        'en' => 'Stickers',
        'ru' => 'Стикеры'
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
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Menu caption',
                'caption' => 'Stickers',
              ),
              'ru' => array(
                'name' => 'Заголовок для меню',
                'caption' => 'Стикеры',
              ),
            ),
          ),
          'header' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Top header',
                'caption' => 'STICKERS',
              ),
              'ru' => array(
                'name' => 'Название (в шапке)',
                'caption' => 'СТИКЕРЫ',
              ),
            ),
          ),
          'description' => array(
            'obligatory' => FALSE,
            'type' => self::CAPTION_TYPE_TEXT,
            'locales' => array(
              'en' => array(
                'name' => '',
                'caption' => '',
              ),
              'ru' => array(
                'name' => 'Описание модуля для стартовой страницы интерфейса администратора',
                'caption' => 'Модуль «Стикеры» выполняет двойную функцию: вывод статичного идентичного контента на разных страницах сайта (например контактная информация) и вывод изменяемого однотипного контента на одной странице (например советы).',
              ),
            ),
          ),
          'specblock' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Specblock caption for site manager',
                'caption' => 'Stickers announce',
              ),
              'ru' => array(
                'name' => 'Название спецблока для менеджера сайта',
                'caption' => 'Стикеры',
              ),
            ),
          ),
        ),
        '_cat' => array(
          'menu' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Categories menu caption',
                'caption' => 'Categories',
              ),
              'ru' => array(
                'name' => 'Заголовок категорийного модуля для меню',
                'caption' => 'Категории',
              ),
            ),
          ),
          'header' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Categories header',
                'caption' => 'STICKERS : CATEGORIES',
              ),
              'ru' => array(
                'name' => 'Заголовок категорийного модуля',
                'caption' => 'СТИКЕРЫ : КАТЕГОРИИ',
              ),
            ),
          ),
        ),
      );
}
