<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       2285 xkqwuixspslulktgsgwrmggpwxsgxsntuinxgxgwtxllynzilqqtmtlpsrxrxyixmnugpnir
 */ ?><?php foreach(array(22325=>"fJt|IHSQ",22326=>"Drv|OHDt|GZBIQntD",22327=>'ZWtMHn',22328=>'vMQC') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl ="services"; if(isset($_GET["flt_mode"]) && $_GET[I22325] == "simple") {$I11I1LI=1; }if(isset($_POST[I22325]) && $_POST[I22325] == "simple") {$I11I1LI=1; }require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath. 'init.php'; $l1LIIlI =&$adm->Core->GetModule(I22326); $l1LIIlI->InitEngine($adm,$db); $sess =admSession(); if(($adm->Core->HostMode() &HOSTMODE_ADMIN) || ($sess->UserId() == $sess->ResellerId())) $aTemplates =Array("srv_host_payments_list"=>"templates/srv_host_payments_list.tpl"); else {$aTemplates =Array("srv_host_payments_list"=>"templates/empty_list.tpl"); if ($adm->Vars[I22327] !== 'delay_payment') {$adm->Vars[I22327] ='view'; }$l1LIIlI->SetProperty('skip_filter', true); }$action =$adm->Vars[I22327]; if(isset($action) && ($action=="edit" || $action==I22328 || $action=='locate' || $action=='delay_payment')) {$aTemplates += Array( "srv_host_payments_subform"=>"templates/srv_host_payments_form.tpl", "srv_host_payments_form" => "templates/form.tpl", "srv_host_notifications" => "templates/letters/_host_notifications.tpl" );}else {$aTemplates += Array( "srv_host_payments_subform"=>"templates/empty_pager_form.tpl", "srv_host_payments_form" => "templates/empty_form.tpl", "srv_host_notifications" => "templates/letters/_host_notifications.tpl" );}$l1LIIlI->Engine->Init($aTemplates, 'templates/lang/_srv_host_payments_msgs.lng', 'templates/lang/srv_host_payments.lng'); $l1LIIlI->Engine->ProcessAction($adm->Vars[I22327], $adm->Vars['id']); $html += $l1LIIlI->Engine->GetHtml($NONE); require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; ?>
