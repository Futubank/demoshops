<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       2981 xkqwutzumyypqqmqgwqksnlitiiunkmyngkutrgpwmkgkqrzulntlpiunxlninkmxrqipnir
 */ ?><?php foreach(array(20945=>"vMQCMS",20946=>'MnMt`GOG',20947=>"iHSuJQqDOHGmtQIVMQC",20948=>'tQIGJZtQD~',20949=>"iHSuJQqDOHGdQJQWtRQJZtQS",20950=>'|MtQI|DuYfHrI',20951=>'|MtQI|JMDt`tGJ',20952=>'|IDPD`JnP',20953=>"QnPMnQ|WJZDDQD") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLLlI1l =0; $l1I1L11 =0; if(isset($_GET["viewid"]) && ($_GET["viewid"] >0 || $_GET[I20945] == -1)) {$lLLlI1l =1; }if(isset($_GET["mode"]) && $_GET["mode"] == "select_related") {$l1I1L11 =1; }if($lLLlI1l || $l1I1L11) {$I11I1LI=1; $popup =true; }$lLIlIIl =$ownerName; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath. I20946; $ILLl1I1 =&$adm->Core->GetModule($ownerName."_item"); if($lLLlI1l) {$lLLlI11 =$ILLl1I1->TTlTTTI("engine_classes"); $lLLllII =$lLLlI11; $lLLllII[] =I20947; $ILLl1I1->SetProperty("engine_classes", $lLLllII); $aTemplates =Array( $ownerName.'_item_list'=>I20948.$ownerName.'_item_view_list.tpl', $ownerName.'_item_subform'=>'templates/empty_pager_form.tpl', $ownerName.'_item_form'=>'templates/empty_form.tpl' );}elseif($l1I1L11) {$lLLlI11 =$ILLl1I1->TTlTTTI("engine_classes"); $lLLllII =$lLLlI11; $lLLllII[] =I20949; $ILLl1I1->SetProperty("engine_classes", $lLLllII); $aTemplates =Array( $ownerName.'_item_list'=>I20948.$ownerName.'_item_select_related_list.tpl', $ownerName.I20950=>'templates/empty_pager_form.tpl', $ownerName.'_item_form'=>'templates/empty_form.tpl' );}else {$aTemplates =Array( $ownerName.'_item_list'=>I20948.$ownerName.I20951, $ownerName.I20950=>I20948.$ownerName.'_item_form.tpl', $ownerName.'_item_form'=>'templates/form.tpl' );}$ILLl1I1->InitEngine($adm, $db); $ILLl1I1->Engine->Init($aTemplates, 'templates/lang/_'.$ownerName.I20952, 'templates/lang/'.$ownerName.'_item.lng'); $ILLl1I1->Engine->ProcessAction($adm->Vars['action'], $adm->Vars['id']); $html += $ILLl1I1->Engine->GetHtml($NONE); if($lLLlI1l) {$ILLl1I1->SetProperty(I20953, $lLLlI11); }require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; 