<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1148 xkqwttqlxxlyumquitlxizgsqznpqxklnpnttlqklsgszizrugtxxzymwrkuplqwpyukpnir
 */ ?><?php foreach(array(22329=>'MnMt`GOG') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl ="services"; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath. I22329; $l1LIIll =&$adm->Core->GetModule("srv_host_payments_add"); $l1LIIll->InitEngine($adm, $db); $aTemplates =Array( "srv_host_payments_add_form" => "templates/form.tpl", "srv_host_payments_add_subform"=>"templates/srv_host_payments_add_form.tpl" );$l1LIIll->Engine->Init($aTemplates, 'templates/lang/_srv_host_payments_add_msgs.lng', 'templates/lang/srv_host_payments_add.lng'); $l1LIIll->Engine->ProcessAction($adm->Vars['action'], $adm->Vars['id']); $html += $l1LIIll->Engine->GetHtml($NONE); require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; ?>
