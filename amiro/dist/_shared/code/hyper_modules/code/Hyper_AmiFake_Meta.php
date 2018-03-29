<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiFake 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1489 xkqwlxlutqzxqtkqnzmsmpxznznxygtutuilqrguxnpxltzkkznitkqgpqqyllgnrnmxpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiFake hypermodule metadata.
 *
 * @package    Hyper_AmiFake
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class Hyper_AmiFake_Meta extends AMI_Hyper_Meta{
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
        'en' => 'Stub',
        'ru' => 'Без гипермодуля'
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
