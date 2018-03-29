<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiExt_Category 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2626 xkqwsrkliissurlyppxywtikmslxzyunwkpwxpgmywqiuxllszzkquknuptuigunuxtwpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiExt/Category extension configuration metadata.
 *
 * @package    Config_AmiExt_Category
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_Category_Meta extends AMI_HyperConfig_Meta{
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
     * Exact instance modId
     *
     * @var string
     */
    protected $instanceId = 'ext_category';

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
        'en' => 'Category',
        'ru' => 'Категорийность'
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
                'caption' => 'Categories extension',
              ),
              'ru' => array(
                'name' => 'Заголовок для меню',
                'caption' => 'Расширение категорий',
              ),
            ),
          ),
        ),
      );
}
