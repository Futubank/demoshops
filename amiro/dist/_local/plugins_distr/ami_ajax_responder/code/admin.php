<?php
/**
* @copyright 2000-2011 Amiro.CMS. All rights reserved.
* @version $ Id: admin.php 54702 2010-11-19 17:32:17  Anton $
* @package   Plugin_AJAXResponder
* @filesource
* @size 378 xkqwxsgppmnztymszsnimkpmglimnkmugutmxznlxzgmruzrimmlpnlrutizkrmsnwgmpnir
*/
?>
<?php


AMI_Service::addAutoloadPath($pluginParams['code_path']);
$oPlugin = new PlgAJAXRespAdmin($pluginParams);
$resultHtml = $oPlugin->getResponse();
