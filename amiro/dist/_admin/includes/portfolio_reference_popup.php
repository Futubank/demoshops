<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1458 xkqwknmilullxxqmriyxsqxlxyluznnsrmksustrliuspwnywzlgtngqzwtslqzxgisrpnir
 */ ?><?php foreach(array(22275=>"|rQfQrQnWQ|GHGuG",22276=>'tQIGJZtQD~',22277=>'tQIGJZtQD~fHrI`tGJ',22278=>'ZWtMHn') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl =$ownerName; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath. 'init.php'; $l1I11l1 =&$adm->Core->GetModule($ownerName.I22275); $l1I11l1->InitEngine($adm, $db); $aTemplates =Array( $ownerName.'_reference_popup'=>'templates/'.$ownerName.'_reference_popup.tpl', $ownerName.'_reference_popup_list'=>I22276.$ownerName.'_reference_popup_list.tpl', $ownerName.'_reference_popup_subform'=>I22276.$ownerName.'_reference_popup_form.tpl', $ownerName.'_reference_popup_form'=>I22277 );$l1I11l1->Engine->Init($aTemplates, 'templates/lang/_'.$ownerName.'_reference_popup_msgs.lng', 'templates/lang/'.$ownerName.'_reference_popup.lng'); $l1I11l1->Engine->ProcessAction($adm->Vars[I22278], $adm->Vars['id']); $html += $l1I11l1->Engine->GetHtml($NONE); require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; ?>
