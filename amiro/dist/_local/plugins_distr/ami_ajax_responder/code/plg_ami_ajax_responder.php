<?php
/**
* @copyright 2000-2011 Amiro.CMS. All rights reserved.
* @version $ Id: plg_ami_ajax_responder.php 54741 2010-11-25 12:18:50  Anton $
* @package   Plugin_AJAXResponder
* @filesource
* @size 605 xkqwrwnqxsiskzggklmuglqylnrgzpnkypngzywgtikplilggmiqytumltliqglymkrgpnir
* @since   5.10.0
*/
?>
<?php


/**
 * Specblock class
 */
require_once 'PlgAJAXRespFront.php';

$oPlgFront = new PlgAJAXRespFront($pluginParams);

/**
 * CMS expects $resultHtml variable contatining plugin specblock HTML
 *
 * @var string
 */
$resultHtml = $oPlgFront->getHTML();
