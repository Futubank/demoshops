<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1140 xkqwiqnuxnnqpspswpzzqzngsrwtunpsqlwtuqlwgnqwqlixyytgwnuptwgiqgpnimitpnir
 */ ?><?php foreach(array(20931=>"|SMPMtZJD",20932=>'tQIGJZtQD~JZnP~|',20933=>'SHnQ`GOG') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl =$ownerName; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath. 'init.php'; $lIIII1L =&$adm->Core->GetModule($ownerName.I20931); $lIIII1L->InitEngine($adm, $db); $aTemplates =Array( $ownerName.'_digitals_list'=>'templates/'.$ownerName.'_digitals.tpl', );$lIIII1L->Engine->Init($aTemplates, 'templates/lang/_files_import_msgs.lng', I20932.$ownerName.'_digitals_msgs.lng'); $lIIII1L->Engine->ProcessAction($adm->Vars['action'], $adm->Vars['id']); $html += $lIIII1L->Engine->GetHtml($NONE); require $GLOBALS['DEFAULT_INCLUDES_PATH'] .I20933; ?>
