<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1982 xkqwtsxmllmrxnqqnlukigntymmpgngtupwmnipmrqwkxsuzmrzsiwsrpynuqrttrgyrpnir
 */ ?><?php foreach(array(15108=>'yzdq|sRmVqR',15109=>'Qxt|ZWtMHn',15110=>'fZMJ',15111=>'ZWtMHn',15112=>'DtZtuD',15113=>'ZutH') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} require_once $GLOBALS['CLASSES_PATH'] .$GLOBALS['lLIll1I'][I15108] .'.php'; require_once $GLOBALS['CLASSES_PATH'] .'bill_yandex.php'; $oTpl =AMI::getSingleton('env/template_sys'); $BILL_driver_yandex =new BILL_driver_yandex($oTpl); if(!empty($_GET[I15109])){ $status =!empty($_GET['status']) ?$_GET['status'] :'fail'; if($status != 'ok' && $status != I15110){ $status =I15110; }$location =$ROOT_PATH_WWW .'pages.php?action=process&status=' .$status .'&order_id=' .(int)($_GET['order_id']); AMI::getSingleton('response')->HTTP->setRedirect($location, 301); die; }elseif(!empty($_POST[I15111]) && ($_POST[I15111] == 'checkOrder')){ $aResult['status'] =I15110; $aResult['response'] =''; $BILL_driver_yandex->TlTT1lT($aResult); if($aResult[I15112] == 'ok'){ ob_start(); $ActiveModule ="eshop_final"; $skip_detect_page =1; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath .'detector.php'; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .'init.php'; require_once $GLOBALS['CLASSES_PATH'] .'EshopOrder.php'; $oOrder =new EshopOrder(); $oOrder->updateStatus($frn, $_POST['order_id'], I15113, 'accepted'); ob_end_clean(); }while(ob_get_level()){ ob_end_clean(); }header('Status: 200 OK'); header('HTTP/1.0 200 OK'); echo $aResult['response']; die; }require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .'eshop_final.php'; 