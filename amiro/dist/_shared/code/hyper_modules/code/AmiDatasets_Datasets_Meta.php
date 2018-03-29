<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiDatasets_Datasets 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       4898 xkqwztiyqmsrpiknssswtgszrutszzpkixwmswkyulsqqitiqxnmznpnpxnlpsiurkilpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiDatasets/Datasets configuration metadata.
 *
 * @package    Config_AmiDatasets_Datasets
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiDatasets_Datasets_Meta extends AMI_HyperConfig_Meta{
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
        'en' => 'Datasets',
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
                'caption' => 'DATASETS',
              ),
              'ru' => array(
                'name' => 'Название (в шапке)',
                'caption' => 'НАБОРЫ ПОЛЕЙ',
              ),
            ),
          ),
          'menu' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Menu caption',
                'caption' => 'Datasets',
              ),
              'ru' => array(
                'name' => 'Заголовок для меню',
                'caption' => 'Наборы полей',
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
                'caption' => 'Модуль «Наборы полей» позволяет добавлять в модули наборы дополнительных полей различных типов, что позволяет существенно расширять возможности модулей без программирования.',
              ),
            ),
          ),
        ),
        '_custom_fields' => array(
          'header' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Top header',
                'caption' => 'CUSTOM FIELDS',
              ),
              'ru' => array(
                'name' => 'Название (в шапке)',
                'caption' => 'ДОПОЛНИТЕЛЬНЫЕ ПОЛЯ',
              ),
            ),
          ),
          'menu' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Menu caption',
                'caption' => 'Custom fields',
              ),
              'ru' => array(
                'name' => 'Заголовок для меню',
                'caption' => 'Дополнительные поля',
              ),
            ),
          ),
        ),
      );
}
