<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       3314 xkqwpzllllpmzlmkmzztztgyqquxxpygwgmxpmpuzirsgxpuzutkpuwusrwsrgztnuxrpnir
 */ ?><?php foreach(array(18833=>'wjzddqd|gzTo',18834=>'rQEuMrQS|fMQJSD',18835=>"",18836=>"MnMt|QDOHG`GOG") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} function CreateMember(&$frn, &$oSession, $lLLllL1 ="CMS_Member", $lLLll1I =false) {global $sess_user_name, $sysUser; $mMembers =&$frn->Core->GetModule("members"); $lLLll1l =is_object($frn->Member); if (!$lLLll1l || mb_strtolower(get_class($frn->Member)) != mb_strtolower($lLLllL1)) {require_once $GLOBALS[I18833] .'CMS_Member.php'; if ($lLLllL1 != "CMS_Member") {require_once $GLOBALS[I18833] .$lLLllL1 .'.php'; }$oSession->Start(0, $lLLll1I); $frn->Member =new $lLLllL1($oSession, $sess_user_name); if($oSession->IssetVar($sess_user_name)){ $frn->Member->init($oSession->GetVar($sess_user_name)); TlT1T11($oSession); }$frn->Member->setUsed($mMembers->GetOption('used_fields'), true, true); $frn->Member->setObligatory($mMembers->GetOption(I18834), true, true); if ($frn->Member->isLoggedIn()) {$frn->Gui->addGlobalVars(Array("MEMBER_LOGGED_IN" => "1")); $sysUser =intval($frn->Member->getUserInfo("id")); }}if ($mMembers->IsPresentInPMandPublic()) {$lLLll1L =$mMembers->GetFrontLink(); $frn->Gui->addGlobalVars(Array("member_script" => $lLLll1L)); }}if (!empty($GLOBALS['AMI_FRONT_ENTRY_POINT'])) {$lang_data =AMI::getSingleton('env/request')->get('ami_locale', 'en'); }$oSession =new CMS_Session($frn, (($Core->GetOption("allow_multi_lang")) ?$lang_data :I18835)); $sess_user_name ="user"; $sysUser =0; if ($frn->Core->IsFrontAllowed("members")) {CreateMember($frn, $oSession); unset($member); }if ($frn->Core->IsOwnerInstalled('eshop')) {$frn->TTITT1l(I18835); $lLLllLL =true; require_once($GLOBALS["lLI1IIl"] .I18836); unset($lLLllLL); }