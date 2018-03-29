<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1062 xkqwwqipuxmukztpsslixrmszzmpilnqxiglnkqrpwupuipmniqnypmmttknimkyukuqpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


$INSTALLED_PRODUCTS = Array("services","modules","pmanager","eshop", "system", "wizard", "sample", "plugins","kb","portfolio");

$INSTALLER_VER_MIN = '6.10';

$BENCH_LOG_FILE = '';
$BENCH_LOG_FILE_SIZE = 200000000;
//$BACKGROUND_BENCH_LOG_FILE_SIZE = 50 * 1024 * 1024;

$CGI_BIN_PATH_WWW = "/_admin/cgi-bin/";

// Enable/Disable (true/false) L3 cache
$CONNECT_OPTIONS["host_cache_frontsideL3"] = true;

// Enable/Disable (true/false) import locks
$DISABLE_IMPORT_LOCKS = false;

// Disable user scripts if any

$GLOBALS["sys"]["disable_user_scripts"] = !empty($CONFIG_INI['sys']['disable_user_scripts']);
