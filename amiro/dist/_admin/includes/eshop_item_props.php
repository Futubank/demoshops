<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1110 xkqwusmtstpttlrguyirlqlkxlrizpprwxuylwluknruppxlmrzqpqugplpymylxssqipnir
 */ ?><?php foreach(array(20954=>"|MtQI|GrHGD") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl =$ownerName; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath. 'init.php'; $lILlI11 =&$adm->Core->GetModule($ownerName.I20954); $lILlI11->InitEngine($adm, $db); $aTemplates =Array( $ownerName.'_item_props'=>'templates/'.$ownerName.'_item_props.tpl', );$lILlI11->Engine->Init($aTemplates, 'templates/lang/_'.$ownerName.'_item_props_msgs.lng', 'templates/lang/'.$ownerName.'_item_props.lng'); $lILlI11->Engine->ProcessAction($adm->Vars['action'], $adm->Vars['id']); $html += $lILlI11->Engine->GetHtml($NONE); require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; ?>
