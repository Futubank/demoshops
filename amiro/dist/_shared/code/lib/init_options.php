<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       6552 xkqwntslmsxuigpmgxmwpiglkrgrpsxsqzlpmzmksuxtyqztqnrykkynwgryzpilmsqnpnir
 */ ?><?php foreach(array(19821=>'|mNdTjzjjqs|ihsUjqd',19822=>'`GOG',19823=>'|DOZrQS~WHSQ~OBGQr|IHSuJQD~SQWJZrZtMHn~',19824=>'zim|zjjhc|jhwzj|ihsUjqd',19825=>'Drv|HGtMHnD',19826=>"`GOG",19827=>'IHSuJQD',19828=>'SQWJZrZtMHn~',19829=>'RqyUjs|ihsUjqd|jmdT') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} if (RUN_UPDATE) {$IIII1LI =$Core->GetModNames(); $lL11LIl =Array(); foreach($IIII1LI as $IIII1Ll){ if($Core->isInstalled($IIII1Ll)){ $lL11LIl[$IIII1Ll] =1; }}define(I19821, serialize($lL11LIl)); unset($IIII1LI, $lL11LIl); }$IlLllIl =!$Core->TTllITI($IIII11I, $IlLllII, $IlLllIl) || FIRST_PLUGIN_RUN; if($IlLllIl){ $oDeclarator =AMI_ModDeclarator::getInstance(); require $CONST_PATH .'property_defaults.php'; foreach($INSTALLED_PRODUCTS as $vProduct){ if($Core->IsOwnerInstalled($vProduct)){ require $CONST_PATH .'property_' .$vProduct .I19822; }}$Core->setupHyperMod($HOST_PATH .I19823, $INSTALLED_PRODUCTS, 'properties'); $path =AMI_Registry::get('path/hyper_local') .'declaration/properties.php'; if( (empty($GLOBALS['sys']['disable_user_scripts']) || defined(I19824) )&& file_exists($path) ){$oDeclarator->setMode(TRUE); require $path; $oDeclarator->setMode(FALSE); }unset($path, $oDeclarator); }$RebuildFailedOnly =false; if(!$RebuildOptions){ $lL11LIL =!empty($_GET['_cms_first_start']) || (mb_strpos(getCurrentURL(), '_cms_first_start=1') !== false); if($lL11LIL){ $lL11LI1 =$Core->Debug; $Core->Debug =false; }$res =$Core->TTllT1l(); if($lL11LIL){ $Core->Debug =$lL11LI1; }unset($lL11LIL, $lL11LI1); if($res!==true){ $dbFailModules =$res; $RebuildOptions =true; $RebuildFailedOnly =true; }}if($RebuildOptions){ $Core->Options->TTlTI1l(TRUE); if($RebuildFailedOnly) {if(!$IIIlILL) {$Core->IlLIIl1 =$Core->GetModOption('srv_options', 'allowed_inheritance'); $Core->IlLIIlL =$Core->GetModOption(I19825, 'inheritance'); }$REBULD_MODULES_LIST =$dbFailModules; }foreach($INSTALLED_PRODUCTS as $vProduct){ if($Core->IsOwnerInstalled($vProduct)) {require $CONST_PATH."const_".$vProduct.".php"; $lL11LlI =$LOCAL_FILES_PATH."config_".$vProduct.I19826; if(empty($GLOBALS["sys"]["disable_user_scripts"]) && !in_array($vProduct, array('services', I19827)) && file_exists($lL11LlI)){ require $lL11LlI; }}}$Core->setupHyperMod( AMI_Registry::get('path/hyper_shared') .I19828, $INSTALLED_PRODUCTS, 'consts', array( I19829 => empty($REBULD_MODULES_LIST) ?array() :$REBULD_MODULES_LIST ));$path =AMI_Registry::get('path/hyper_local') .'declaration/options.php'; if( (empty($GLOBALS['sys']['disable_user_scripts']) || defined(I19824) )&& file_exists($path) ){$IIIlILl =empty($REBULD_MODULES_LIST); $oDeclarator =AMI_ModDeclarator::getInstance(); $IIIlILI =!empty($IIIlILl); $aRegistered =$oDeclarator->getRegistered(); if(!$IIIlILI){ $aRegistered =array_intersect($aRegistered, empty($REBULD_MODULES_LIST) ?array() :$REBULD_MODULES_LIST); $IIIlILI =sizeof($aRegistered) >0; }if($IIIlILI){ $oDeclarator->setAllowedOptions($IIIlILl ?null :$aRegistered); require $path; }unset($aRegistered, $IIIlILI, $path, $oDeclarator); }if (!(RUN_UPDATE || $IIIlILL)) {trigger_error( "Options are rebuilt" .($RebuildFailedOnly ?' (failed only)' :''), $RebuildFailedOnly ?E_USER_NOTICE :E_USER_WARNING );}}if($IlLllIl) {$IIII11I =$Core->TTlIlTT($IlLllII); $Core->IlLIIL1 =$IIIlILL; $Core->SaveCoreOptions("all", !$IIIlILL, false, $IIII11I); $Core->IlLIIL1 =false; $IIIlILL =0; }else {if($IIIlILL) {$Core->IlLIIL1 =true; $Core->SaveCoreOptions(); $Core->IlLIIL1 =false; $IIIlILL =0; }}if(file_exists($CONST_PATH."/_local/local_end.php")){ require $CONST_PATH."/_local/local_end.php"; }if($RebuildOptions){ $Core->IlLIIL1 =true; if($RebuildFailedOnly) {foreach($dbFailModules as $vModName){ $Core->SaveOptions($vModName, FALSE); }$Core->SaveOptions("srv_options"); }else {$Core->SaveOptions(); }$Core->IlLIIL1 =false; }