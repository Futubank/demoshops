<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiMultifeeds_Articles 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       7306 xkqwrgtrluqprslluntsuzgyxnnsgxyxgrmgpkrmtnqqswylzpkkkkkximxsninxsiumpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds/Articles configuration metadata.
 *
 * @package    Config_AmiMultifeeds_Articles
 * @subpackage Model
 * @since      6.0.2
 */
class AmiMultifeeds_Articles_Meta extends AMI_HyperConfig_Meta{
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
    // protected $isSingleInstance = TRUE;

    /**
     * Flag speficies impossibility of instance deinstallation
     *
     * @var  bool
     * @amidev
     * @todo Remove flag after mod_manager publication
     */
    // protected $permanent = TRUE;

    /**
     * Import instructions
     *
     * @var array
     * @amidev
     */
    protected $aImport = array(
        'sourceModIds'  => array('articles'),
        'allowedTypes'  => array('data', 'options', 'templates')
    );

    /**
     * Array having locales as keys and titles as values
     *
     * @var array
     */
    protected $aTitle = array(
        'en' => 'Articles',
        'ru' => 'Статьи'
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
          'header' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Top header',
                'caption' => 'Articles',
              ),
              'ru' => array(
                'name' => 'Название (в шапке)',
                'caption' => 'Статьи',
              ),
            ),
          ),
          'menu_group' => array(
            'obligatory' => FALSE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
                'en' => array(
                    'name' => 'Group menu caption',
                    'caption' => 'Articles',
                ),
                'ru' => array(
                    'name' => 'Заголовок группы в меню',
                    'caption' => 'Статьи',
                )
            )
          ),
          'menu' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Menu caption',
                'caption' => 'Items',
              ),
              'ru' => array(
                'name' => 'Заголовок для меню',
                'caption' => 'Элементы',
              ),
            ),
          ),
          'description' => array(
            'obligatory' => FALSE,
            'type' => self::CAPTION_TYPE_TEXT,
            'locales' => array(
              'en' => array(
                'name' => 'Admin interface start page module description',
                'caption' => '',
              ),
              'ru' => array(
                'name' => 'Описание модуля для стартовой страницы интерфейса администратора',
                'caption' => 'Модуль «Статьи» служит для удобного управления списком тематических статей, публикаций и любой другой текстовой информации. Состоит из списка анонсов, сгруппированного по категориям, с многостраничным выводом, отображением даты публикации, источника, присоединенных изображений, рейтинга, комментариев и т.п., при нажатии на ссылку «далее» отображается полная версия любой статьи.',
              ),
            ),
          ),
          'specblock' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Specblock caption for site manager',
                'caption' => 'Articles announce',
              ),
              'ru' => array(
                'name' => 'Название спецблока для менеджера сайта',
                'caption' => 'Анонс статей',
              ),
            ),
          ),
          'specblock_desc' => array(
            'obligatory' => FALSE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Specblock description for site manager',
                'caption' => 'Articles announce strip',
              ),
              'ru' => array(
                'name' => 'Описание спецблока для менеджера сайта',
                'caption' => 'Лента анонса статей',
              ),
            ),
          ),
        ),
        '_cat' => array(
          'header' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Categories header',
                'caption' => 'Articles : Categories',
              ),
              'ru' => array(
                'name' => 'Заголовок категорийного подмодуля',
                'caption' => 'Статьи : Категории',
              ),
            ),
          ),
          'menu' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Categories menu caption',
                'caption' => 'Categories',
              ),
              'ru' => array(
                'name' => 'Заголовок категорийного подмодуля для меню',
                'caption' => 'Категории',
              ),
            ),
          ),
        ),
      );
}
