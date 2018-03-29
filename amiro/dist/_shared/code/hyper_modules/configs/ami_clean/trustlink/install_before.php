<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiClean_Trustlink 
 * @size       705 xkqwnxxyzrgxrpxtzxlugummrzkwssiguksqxiqwlptmrlgwkiknixmlkrztqqstxwpzpnir
 */
?><?php


$oQuery =
    DB_Query::getSnippet(
        "SELECT `id` " .
        "FROM `cms_plugins` " .
        "WHERE `plugin_id` = %s AND `is_installed` = 1"
    )->q('trustlink');
if(AMI::getSingleton('db')->fetchValue($oQuery)){
     throw new AMI_Package_Exception(
         'obsolete_plugin_detected',
         AMI_Package_Exception::CUSTOM_ERROR,
         NULL
     );
}
