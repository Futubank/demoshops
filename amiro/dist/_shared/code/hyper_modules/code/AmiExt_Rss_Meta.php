<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiExt_RSS 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2575 xkqwrnrgripiyixzsqlyuitgtnmpxzzpmwzitkqzqsxugxlryumntgxnnwtguutmluinpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiExt/RSS extension configuration metadata.
 *
 * @package    Config_AmiExt_RSS
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_Rss_Meta extends AMI_HyperConfig_Meta{
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
     */
    protected $permanent = TRUE;

    /**
     * Exact instance modId
     *
     * @var string
     */
    protected $instanceId = 'ext_rss';

    /**
     * Array having locales as keys and captions as values
     *
     * @var array
     */
    protected $aTitle = array(
        'en' => 'RSS',
        'ru' => 'RSS'
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
    protected $aCaptions = array(
        '' => array(
          'menu' => array(
            'obligatory' => TRUE,
            'type' => self::CAPTION_TYPE_STRING,
            'locales' => array(
              'en' => array(
                'name' => 'Menu caption',
                'caption' => 'Export to RSS',
              ),
              'ru' => array(
                'name' => 'Заголовок для меню',
                'caption' => 'Экспорт в RSS',
              ),
            ),
          ),
        ),
      );
}
