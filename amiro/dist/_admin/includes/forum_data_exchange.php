<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1563 xkqwygnmlxtkipzslgngwptuwirmpxsxqikpxiytgkxiquuzqziwqmsurqqmslxptpkqpnir
 */ ?><?php foreach(array(21060=>'IHSuJQD',21061=>'run',21062=>'MS') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl =I21060; $ENABLE_BUFFERING =!(isset($_GET['action']) && $_GET['action'] == I21061) && !(isset($_POST['action']) && $_POST['action'] == I21061); require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath. 'init.php'; $mModule =&$adm->Core->GetModule('forum_data_exchange'); $mModule->InitEngine($adm, $db); $aTemplates =array( 'forum_data_exchange_subform' => 'templates/forum_data_exchange_form.tpl', 'forum_data_exchange_form' => 'templates/form.tpl' );$mModule->Engine->Init( $aTemplates, 'templates/lang/_forum_data_exchange_msgs.lng', 'templates/lang/forum_data_exchange.lng' );if(DAEMON_LOGIN_OK === true){ $mModule->Engine->SetRedirect(false); $mModule->Engine->II1lILl =1; $mModule->Engine->ProcessAction($adm->Vars['action'], $adm->Vars['id']); echo $adm->GetStatusMessages(); $conn->TT1I1lT(); die; }else{ $mModule->Engine->ProcessAction($adm->Vars['action'], $adm->Vars[I21062]); $html += $mModule->Engine->GetHtml($NONE); }require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; 