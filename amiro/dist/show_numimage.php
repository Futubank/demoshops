<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       5763 xkqwrswqprzxylyyggwlixzxquzgqilqmtptszqzmttkgpzkuxzlpixzztulkwmmxywlpnir
 */ ?><?php foreach(array(253=>'DMS',254=>'sqFzUjT|ihsUjq',255=>'ZIM|Qnv`GOG',256=>'IHSuJQ',257=>".IHSuJQ|nZIQ.?mN}'",258=>"'!?'",259=>".IHSuJQ|nZIQ.?=?'",260=>"dqjqwT?.IHSuJQ|nZIQ.!?.vZJuQ.!?.YMP|vZJuQ.?",261=>'hGtMHnD',262=>'IHSuJQ|nZIQ',263=>"CZvQ|ZIGJMtuSQ",264=>'SMPMtD',265=>"nHMDQ|WHJHr",266=>'psJMY?MD?nHt?fHunS',267=>'nHMDQwHJHr',268=>'G',269=>'') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(empty($_GET[I253])){ die; }define('DEFAULT_OPTION_SOURCE', 'show_num_image'); define(I254, 'show_numimage'); $AMI_ENV_SETTINGS =array( 'skip_disable_user_scripts' => true );require I255; AMI_Service::hideDebug(); $oDB =new CMS_simpleDb; $oDB->connect(DB_Host, DB_User, DB_Password, DB_Database); $sid =$_GET[I253]; $l11Ill1 =isset($_GET['l']); $module =!empty($_GET[I256]) && mb_strlen(trim($_GET[I256])) ?$_GET[I256] :DEFAULT_MODULE; $l11IlLI =!empty($_GET['optionsSource']) && mb_strlen(trim($_GET['optionsSource'])); $l11IlLl =$l11IlLI ?I257 .mysql_real_escape_string($_GET['optionsSource'], $oDB->_dbLink) .I258 .mysql_real_escape_string(DEFAULT_OPTION_SOURCE, $oDB->_dbLink) ."')" :I259 .mysql_real_escape_string(DEFAULT_OPTION_SOURCE, $oDB->_dbLink) ."'"; $sql =I260 ."FROM `cms_options` " ."WHERE " .$l11IlLl ." AND `name` = 'options_dump'"; $oDB->query($sql); $aModuleOptions =array(); while($aRecord =$oDB->nextRecord()){ if($aRecord['value'] != mb_strlen($aRecord['big_value'])){ die; }$aOptions =@unserialize($aRecord['big_value']); if(!is_array($aOptions) || empty($aOptions['Options']) || !is_array($aOptions[I261])){ die; }$aModuleOptions[$aRecord[I262]] =$aOptions[I261]; }if(empty($aModuleOptions)){ die; }$aOptions =array(); $optionSource =$l11IlLI ?$_GET['optionsSource'] :DEFAULT_OPTION_SOURCE; foreach(array( "image_digits_qty", "image_symbols_set", "jitter_amplitude", I263, "type", "noise_level", "noise_color", )as $option){ $value =$aModuleOptions[ isset($aModuleOptions[$optionSource]) && isset($aModuleOptions[$optionSource][$option]) ?$optionSource :DEFAULT_OPTION_SOURCE ][$option]; if(!is_null($value)){ $aOptions[$option] =$value; }}$aOptions += array( 'image_symbols_set' => I264, 'image_digits_qty' => 4, 'jitter_amplitude' => 2, 'wave_amplitude' => 1, "noise_level" => 100, I265 => '808080' );$oCaptcha =AMI::getResource('captcha', array($module, $sid, $aOptions['image_digits_qty'], AMI_Captcha::getConstantCharset($aOptions['image_symbols_set']))); $oImageGenerator =$oCaptcha->getImageGenerator(); if(!$oImageGenerator->isGDLibInstalled()){ trigger_error(I266, E_USER_ERROR); }$oImageGenerator->setGenerateOption('digitJitterAmplitude', $aOptions['jitter_amplitude']); $oImageGenerator->setGenerateOption('waveAmplitude', $aOptions['wave_amplitude']); $oImageGenerator->setGenerateOption(I267, $aOptions['noise_color']); $oImageGenerator->setGenerateOption('noiseLevel', $aOptions['noise_level']); if(isset($_GET['p'])){ $_GET[I268]>1?$part =2:$part =1; if($l11Ill1){ $imageString =$oCaptcha->loadImageString(); }else{ if($part == 1){ $imageString =$oImageGenerator->generateRandomImageString(); $l11IlLL =substr($imageString,($part -1)*ceil((strlen($imageString)/2)),ceil((strlen($imageString)/2))); SetLocalCookie('captcha_' .$sid, md5($imageString), time() +600, '', true); }else{ for($c=0;$c<20;$c++){ $imageString =$oCaptcha->loadImageString(); if(!$imageString){ sleep(1); }else{ break; }}if(!$imageString){ trigger_error('Can\'t load captcha string', E_USER_ERROR); }$l11IlLL =substr($imageString,($part -1)*ceil((strlen($imageString)/2)),ceil((strlen($imageString)/2))); }}$oImageGenerator->setNumSymbols(strlen($l11IlLL)); $oImageGenerator->createImage($type, $l11IlLL); $oImageGenerator->setImageString($imageString); $oImageGenerator->setNumSymbols(strlen($imageString)); if(!$l11Ill1 && $part == 1){ $oCaptcha->saveImageString(); }}else{ if($l11Ill1){ $imageString =$oCaptcha->loadImageString(); }else{ $imageString =$oImageGenerator->generateRandomImageString(); SetLocalCookie('captcha_' .$sid, md5($imageString), time() +70 *60, I269, true); }$oImageGenerator->createImage($type, $imageString); if(!$l11Ill1 ){$oCaptcha->saveImageString(); }}$oImageGenerator->outToStream(); 