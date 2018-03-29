<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiExt_EshopCustomFields 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       3219 xkqwspnzsqttrqgqzyykuwmsyqrmpulyitryimitzipnsnnzrwxsktkkpksuxwxqmwrupnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiExt/EshopCustomFields extension configuration metadata.
 *
 * @package    Config_AmiExt_EshopCustomFields
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_EshopCustomFields_Meta extends AMI_HyperConfig_Meta{
    /**
     * Array having locales as keys and titles as values
     *
     * @var array
     */
    protected $aTitle = array(
        'en' => 'Eshop custrom fields',
        'ru' => 'Дополнительные поля каталога'
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
                'caption' => 'EshopCustomFields',
              ),
              'ru' => array(
                'name' => 'Заголовок для меню',
                'caption' => 'EshopCustomFields',
              ),
            ),
          ),
          'header' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Top header',
                'caption' => 'EshopCustomFields',
              ),
              'ru' => array(
                'name' => 'Название (в шапке)',
                'caption' => 'Eshop Custom Fields',
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
                'caption' => '',
              ),
            ),
          ),
        ),
      );
}
