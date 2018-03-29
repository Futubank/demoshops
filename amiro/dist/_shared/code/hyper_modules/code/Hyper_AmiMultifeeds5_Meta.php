<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiMultifeeds5 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1555 xkqwrniqulwglxxwrynynsyryknqzxirzmymiuqglqxkmrrmrywxkwnylkkiyrrmylptpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiMultifeeds5 hypermodule metadata.
 *
 * @package    Hyper_AmiMultifeeds5
 * @subpackage Model
 * @since      x.x.x
 * @amidev
 */
class Hyper_AmiMultifeeds5_Meta extends AMI_Hyper_Meta{
    /**
     * Version
     *
     * @var string
     */
    protected $version = '1.0';

    /**
     * Array having locales as keys and captions as values
     *
     * @var array
     */
    protected $aTitle = array(
        'en' => 'Multifeeds (deprecated)',
        'ru' => 'Информационные ленты (устаревшие)'
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
}
