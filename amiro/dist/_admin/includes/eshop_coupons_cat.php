<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1347 xkqwlrqzikizzxxqpkwswpriwwuumimmilukrrilwxlsyngnxgpupplpkugtipzqmrszpnir
 */ ?><?php foreach(array(20911=>'Qnv~ZDBnW50',20912=>'|JMDt`tGJ',20913=>'tQIGJZtQD~fHrI`tGJ',20914=>'ZWtMHn') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl =$ownerName; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath. 'init.php'; AMI::getSingleton(I20911)->init($ownerName .'_coupons_cat', $adm); $mName =$ownerName .'_coupons_cat'; $mModule =&$adm->Core->GetModule($mName); $aTemplates =array ($mName .'_list' => 'templates/' .$mName .I20912, $mName .'_subform' => 'templates/' .$mName .'_form.tpl', $mName .'_form' => I20913 );$mModule->InitEngine($adm, $db); $mModule->Engine->Init( $aTemplates, 'templates/lang/_' .$mName .'_msgs.lng', 'templates/lang/' .$mName .'.lng' );$mModule->Engine->ProcessAction($adm->Vars[I20914], $adm->Vars['id']); $html += $mModule->Engine->GetHtml($NONE); AMI::getSingleton(I20911)->finalize($adm, $mModule, $html); require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; ?>
