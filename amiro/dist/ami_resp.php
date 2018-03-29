<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Plugin 
 * @filesource  
 * @version    $Id$ 
 * @size       780 xkqwzylppxwktxsuygpisuwlrtpuiiglzqwrzglututllqtrwrmuuwmnplnqqyqwptszpnir
 */
?><?php


/**
 * Initialize minimum CMS environment
 */
$AMI_ENV_SETTINGS = array(
    'response_mode' => 'JSON',
);
require 'ami_env.php';

AMI::getSingleton('response')->start();

/**
 * Include responder plugin code
 */
$path = AMI::getPluginPath(AMI::getSingleton('env/request')->get('id_plugin', 'ami_ajax_responder')) . 'code/';
AMI_Service::addAutoloadPath($path);
require $path . 'ami_server.php';

AMI::getSingleton('response')->send();
