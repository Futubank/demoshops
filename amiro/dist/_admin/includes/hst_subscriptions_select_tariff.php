<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1625 xkqwkrlgxqiqwkwuktqkzstumpuxrliigzyugwwrxutrwqtrlizmqmkxxqwstxsptypspnir
 */ ?><?php foreach(array(21354=>'MnMt`GOG',21355=>'SHnQ`GOG') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl ="wizard"; $I11I1LI =1; $popup =true; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .I21354; require_once $GLOBALS['FUNC_INCLUDES_PATH'] .'func_format.php'; $l1lLILL =&$adm->Core->GetModule("hst_subscriptions_select_tariff"); $l1lLILL->InitEngine($adm, $db); $aTemplates =Array( 'hst_subscriptions_select_tariff_list' => 'templates/hst_subscriptions_select_tariff_list.tpl', 'hst_subscriptions_select_tariff_subform' => 'templates/hst_subscriptions_select_tariff_form.tpl', 'hst_subscriptions_select_tariff_form' => 'templates/empty_form.tpl' );$l1lLILL->Engine->Init($aTemplates, 'templates/lang/_hst_subscriptions_msgs.lng', 'templates/lang/hst_subscriptions.lng'); $l1lLILL->Engine->ProcessAction($adm->Vars['action'], $adm->Vars['id']); $html += $l1lLILL->Engine->GetHtml($NONE); require $GLOBALS['DEFAULT_INCLUDES_PATH'] .I21355; ?>