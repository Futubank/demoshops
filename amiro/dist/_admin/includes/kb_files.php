<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1315 xkqwztxqmwgnpsqiyqkrzyzymunmytynngyugmglxlqtlmqzztpwxpqtxgpukmukimttpnir
 */ ?><?php foreach(array(21953=>"|fMJQD",21954=>'tQIGJZtQD~',21955=>'tQIGJZtQD~fHrI`tGJ',21956=>'ZWtMHn') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl =$ownerName; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath. 'init.php'; $l1I11lI =&$adm->Core->GetModule($ownerName.I21953); $l1I11lI->InitEngine($adm, $db); $aTemplates =Array( $ownerName.'_files'=>'templates/'.$ownerName.'_files.tpl', $ownerName.'_files_list'=>I21954.$ownerName.'_files_list.tpl', $ownerName.'_files_subform'=>I21954.$ownerName.'_files_form.tpl', $ownerName.'_files_form'=>I21955 );$l1I11lI->Engine->Init($aTemplates, 'templates/lang/_'.$ownerName.'_files_msgs.lng', 'templates/lang/'.$ownerName.'_files.lng'); $l1I11lI->Engine->ProcessAction($adm->Vars[I21956], $adm->Vars['id']); $html += $l1I11lI->Engine->GetHtml($NONE); require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; ?>