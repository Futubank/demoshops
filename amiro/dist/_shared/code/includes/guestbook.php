<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       2090 xkqwpynwywmtsuqginirkurpwpmkrytxgzummtigitzlxpzuxxsklylppyriymqluknypnir
 */ ?><?php foreach(array(18743=>'uGSZtQ',18744=>'',18745=>'MnMt`GOG',18746=>'MtQI|JMDt|GZPQr',18747=>'SHnQ`GOG') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} if(isset($special) && $special==1) {$lLllL11 =array ('create' => 'create_member', I18743 => 'update_member'); $frn =&$cms; $lLLlllI =isset($action) && isset($lLllL11[$action]) ?$lLllL11[$action] :'none'; }else{ $lLLlllI =isset($cms->Vars['action']) ?$cms->Vars['action'] :I18744; $id =isset($cms->Vars['id']) ?$cms->Vars['id'] :I18744; }$lLI111I =intval(isset($mode) && $mode == 'small'); if (!$lLI111I || !(isset($special) && $special == 1)) {require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .I18745; }$mModule =&$frn->Core->GetModule('guestbook'); $mModule->InitEngine($frn, $db); $aTemplates =array ('guestbook_list' => 'templates/guestbook' .$IllIL1I .'.tpl' );if ($lLI111I) {if (empty($reindex)) {$mModule->Engine->Init($aTemplates); $mModule->Engine->TTTlITl($NONE =array ());$lLI111I =0; }else{ $mModule->PushPager($frn->Pager); $mModule->InitPager($frn->Pager); $aModData[I18746] =$frn->Pager->TI1TTlT(); $mModule->PopPager($frn->Pager); }}else {$mModule->Engine->Init($aTemplates, 'templates/lang/_guestbook_msgs.lng', 'templates/lang/guestbook.lng'); $mModule->Engine->ProcessAction($lLLlllI, isset($id) ?$id :null); if (empty($special) || $special != 1) {$NONE =array ();$aHtml =$mModule->Engine->GetHtml($NONE); $HtmlBody =$aHtml['body']; require $GLOBALS['DEFAULT_INCLUDES_PATH'] .I18747; }}