<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1524 xkqwlypxtmunmyutkimgrqmpimtpmrtyrtlmwlgxuiusgzzrmwyrllnpryyiwrzuwpzwpnir
 */ ?><?php foreach(array(21344=>'MnMt`GOG',21345=>'ZWtMHn') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl ="wizard"; $I11I1LI =1; $popup =true; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .I21344; $l1lLILI =&$adm->Core->GetModule("hst_res_inst_select_vhost_popup"); $l1lLILI->InitEngine($adm, $db); $aTemplates =Array( 'hst_res_inst_select_vhost_popup_list' => 'templates/hst_res_inst_select_vhost_popup_list.tpl', 'hst_res_inst_select_vhost_popup_subform' => 'templates/hst_res_inst_select_vhost_popup_form.tpl', 'hst_res_inst_select_vhost_popup_form' => 'templates/empty_form.tpl' );$l1lLILI->Engine->Init($aTemplates, 'templates/lang/_hst_res_inst_msgs.lng', 'templates/lang/hst_res_inst.lng'); $l1lLILI->Engine->ProcessAction($adm->Vars[I21345], $adm->Vars['id']); $html += $l1lLILI->Engine->GetHtml($NONE); require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; ?>