<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiSitemapHistory_SitemapHistory 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       4131 xkqwmupkxxnwpgtsustsliyqntiwzguwqusunqtqqqunttqqryzmgrgglulukuwyiltrpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiSitemapHistory/SitemapHistory configuration metadata.
 *
 * @package    Config_AmiSitemapHistory_SitemapHistory
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiSitemapHistory_SitemapHistory_Meta extends AMI_HyperConfig_Meta{
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
        'en' => 'SitemapHistory',
        'ru' => 'SitemapHistory'
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
                'caption' => 'SitemapHistory',
              ),
              'ru' => array(
                'name' => 'Заголовок для меню',
                'caption' => 'SitemapHistory',
              ),
            ),
          ),
          'header' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Top header',
                'caption' => 'SitemapHistory',
              ),
              'ru' => array(
                'name' => 'Название (в шапке)',
                'caption' => 'SitemapHistory',
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
          'specblock' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Specblock caption for site manager',
                'caption' => 'SitemapHistory announce',
              ),
              'ru' => array(
                'name' => 'Название спецблока для менеджера сайта',
                'caption' => 'Анонс SitemapHistory',
              ),
            ),
          ),
        ),
      );
}
