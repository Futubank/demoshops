<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1183 xkqwzumntsrxtitmpgtqztmuwiizqpiyrxinlnrlntqzptukrlizpiszurnkymzzmnpmpnir
 */ ?><?php foreach(array(22139=>'MnMt`GOG',22140=>'ZWtMHn') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl ="services"; $I11I1LI =1; $popup =true; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath. I22139; $mModule =&$adm->Core->GetModule('members_popup'); $mModule->InitEngine($adm, $db); $aTemplates =Array( "members_popup_list" => "templates/members_popup_list.tpl", "members_popup_subform" => "templates/members_popup_form.tpl", "members_popup_form" => "templates/empty_form.tpl" );$mModule->Engine->Init($aTemplates, 'templates/lang/_members_msgs.lng', 'templates/lang/members.lng'); $mModule->Engine->ProcessAction($adm->Vars[I22140], $adm->Vars['id']); $html += $mModule->Engine->GetHtml($NONE); require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; ?>