<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1691 xkqwzgnuwxpyrmwmkkygzqwgklzqrwnssuyzrsyxsumtnlsgwllugqzrmgxygtqgxywzpnir
 */ ?><?php foreach(array(18726=>'MnMt`GOG',18727=>"Drv|tZPD|JMDt",18728=>'SHnQ`GOG') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLI111I =0; if (isset($mode) && ($mode == "small")) {$lLI111I =1; }if (!$lLI111I) {require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .I18726; }$lLLllIL =&$frn->Core->GetModule("srv_tags"); $lLLllIL->InitEngine($frn, $db); $aTemplates =Array( "srv_tags_list" => "templates/tags".$IllIL1I.".tpl" );if ($lLI111I) {if (empty($reindex)) {$NONE =Array(); $frn->SetsTemplate =I18727; $lLLllIL->Engine->Init($aTemplates, '', 'templates/lang/tags.lng'); $lLLllIL->Engine->TTTlITl($NONE); $lLI111I =0; }else {$lLLllIL->PushPager($frn->Pager); $lLLllIL->InitPager($frn->Pager); $aModData['item_list_pager'] =$frn->Pager->TI1TTlT(); $lLLllIL->PopPager($frn->Pager); }}else {$lLLllIL->Engine->Init($aTemplates, '', 'templates/lang/tags.lng'); $lLLllIL->Engine->ProcessAction($frn->Vars['action'], $frn->Vars['id']); $aHtml =$lLLllIL->Engine->GetHtml($NONE); $HtmlBody =$aHtml['body']; require $GLOBALS['DEFAULT_INCLUDES_PATH'] .I18728; }$lLI111I =0; ?>