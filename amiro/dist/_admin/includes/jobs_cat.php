<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1232 xkqwinlpupmxwgtwmkniuiygyymxullpystsqqqniqqkktskwgwkqnuutlxillnisstmpnir
 */ ?><?php foreach(array(21922=>"IHSuJQD",21923=>'Qnv~ZDBnW50',21924=>'LHYD|WZt|DuYfHrI') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl =I21922; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath. 'init.php'; AMI::getSingleton(I21923)->init("jobs_cat", $adm); $l1lL1L1 =&$adm->Core->GetModule("jobs_cat"); $l1lL1L1->InitEngine($adm, $db); $aTemplates =Array( 'jobs_cat_list'=>'templates/jobs_cat_list.tpl', I21924=>'templates/jobs_cat_form.tpl', 'jobs_cat_form'=>'templates/form.tpl' );$l1lL1L1->Engine->Init($aTemplates, 'templates/lang/_jobs_cat_msgs.lng', 'templates/lang/jobs_cat.lng'); $l1lL1L1->Engine->ProcessAction($adm->Vars['action'], $adm->Vars['id']); $html += $l1lL1L1->Engine->GetHtml($NONE); AMI::getSingleton(I21923)->finalize($adm, $l1lL1L1, $html); require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; ?>