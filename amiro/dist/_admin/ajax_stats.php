<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       3093 xkqwlssmtliwuiunxkiypkswgqtgulszkipnniqlnszttgtimntnuukpgsixptsmirutpnir
 */ ?><?php foreach(array(20142=>'~',20143=>'uDQr',20144=>'WID',20145=>'OBGQrsZtZ',20146=>'uDQrzPQnt',20147=>'rQfQrrQr',20148=>'+') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} define('AMI_60', true); error_reporting(CMS_ERROR_REPORTING); $l1IIllI =!empty($GLOBALS['sys']['disable_user_scripts']); foreach(array( $HOST_PATH .'_shared/code/const/_local/local_start.php' => false, )as $_path => $l1IIlll){ if($l1IIlll && $l1IIllI){ continue; }if(file_exists($_path)){ require_once $_path; }}unset($_path, $l1IIlll, $l1IIllI); function TlITlII(array &$fields, $delimiter =';', $enclosure ='"', $l1IILLI =false, $l1IILLl =true){ $l1IILLL =preg_quote($delimiter, '/'); $l1IILL1 =preg_quote($enclosure, I20142); $output =array(); foreach($fields as $field){ if($field === null && $l1IILLl){ $output[] ='-'; continue; }if($l1IILLI || preg_match( "/(?:${delimiter_esc}|${enclosure_esc}|\s)/", $field)){ $output[] =$enclosure .str_replace($enclosure, $enclosure .$enclosure, $field) .$enclosure; }else{ $output[] =$field; }}return implode( $delimiter, $output );}AMI::addResourceMapping(require($CLASSES_PATH .'60/resourceMapping.php')); $data =AMI::getSingleton('env/request')->get('data'); $l1IIL1I =json_decode($data); $oSess =admSession(); $userId =intval($oSess->Data[I20143]['id']); if(!$userId){ die('Forbidden'); }$l1IIL1I->cms->userId =$userId; $l1IIL1I->cms->site =$GLOBALS['ROOT_PATH_WWW']; $l1IIL1I->cms->ip =$_SERVER['REMOTE_ADDR']; $l1IIL1l =array(); $aFields =array( I20144 => array('site', 'userId', 'ip', 'modId', I20145, 'action', 'elementId'), 'browser' => array( 'browser', I20146, 'screenRes', 'windowRes', 'scrollOffset', 'mousePos', I20147, 'currentURL', 'hash', 'targetURL', 'targetEl', ));foreach($aFields as $type => $aFieldNames){ if(is_object($l1IIL1I->{$type})){ $l1IIL1L =$l1IIL1I->{$type}; foreach($aFieldNames as $field){ if(isset($l1IIL1L->{$field})){ $l1IIL1l[] =$l1IIL1L->{$field}; }else{ $l1IIL1l[] =I20148; }}}}if(isset($GLOBALS['BENCH_LOG_FILE']) && $GLOBALS['BENCH_LOG_FILE']){ AMI_Service::log(TlITlII($l1IIL1l), $GLOBALS['BENCH_LOG_FILE'] .'.statistic.csv', $GLOBALS['BENCH_LOG_FILE_SIZE']); }