<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiFake_Users 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1540 xkqwtkysruxqullksrryniqqwrwwnimyzzptkzxuikulziqgptwnuqqsyyrkglkqqntrpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiFake/GoogleSitemap configuration metadata.
 *
 * @package    Config_AmiFake_Users
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiFake_Users_Meta extends AMI_HyperConfig_Meta{
    /**
     * Version
     *
     * @var string
     */
    protected $version = '1.0';

    /**
     * Flag specifying that hypermodule configs can have only one instance per config
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
     * Flag specifies to display configuraration in Module Manager
     *
     * @var bool
     * @amidev
     */
    protected $isVisible = FALSE;

    /**
     * Array having locales as keys and captions as values
     *
     * @var array
     */
    protected $aTitle = array(
        'en' => 'Users',
        'ru' => 'Пользователи'
    );
}
