<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1837 xkqwgqgwsmxywzzpzuimisymrnxkmwnxmizwyrzyzqmxkuuqzrtgzwrkmpzyxzxxnzqtpnir
 */ ?><?php foreach(array(22143=>'IHSuJQD',22144=>'GHGuG',22145=>'Qnv~ZDBnW50',22146=>'IHSuJQD|WuDtHI|fMQJSD',22147=>'IHSuJQD|WuDtHI|fMQJSD|JMDt',22148=>'tQIGJZtQD~IHSuJQD|WuDtHI|fMQJSD|JMDt`tGJ',22149=>'IHSuJQD|WuDtHI|fMQJSD|DuYfHrI',22150=>'tQIGJZtQD~IHSuJQD|WuDtHI|fMQJSD|fHrI`tGJ',22151=>'IHSuJQD|WuDtHI|fMQJSD|fHrI',22152=>'tQIGJZtQD~JZnP~|IHSuJQD|WuDtHI|fMQJSD|IDPD`JnP',22153=>'tQIGJZtQD~JZnP~IHSuJQD|WuDtHI|fMQJSD`JnP',22154=>'SHnQ`GOG') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl =I22143; $popup =isset($_REQUEST['mode']) && $_REQUEST['mode'] == I22144; if($popup){ $I11I1LI =1; }require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath .'init.php'; if('free' === AMI::getEdition()){ unset($adm->Filter); $adm->Gui->addBlock('disfunc', 'templates/disabled_functionality.tpl'); $aScope =array(); $html['form'] =$adm->Gui->get('disfunc:body', $aScope); require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; }AMI::getSingleton(I22145)->init(I22146, $adm); $l1I11Il =&$adm->Core->GetModule(I22146); $l1I11Il->InitEngine($adm, $db); $aTemplates =array( I22147 => I22148, I22149 => I22150, I22151 => 'templates/form.tpl' );$l1I11Il->Engine->Init($aTemplates, I22152, I22153); $l1I11Il->Engine->ProcessAction($adm->Vars['action'], $adm->Vars['id']); $html += $l1I11Il->Engine->GetHtml($NONE); AMI::getSingleton(I22145)->finalize($adm, $l1I11Il, $html); require $GLOBALS['DEFAULT_INCLUDES_PATH'] .I22154; 