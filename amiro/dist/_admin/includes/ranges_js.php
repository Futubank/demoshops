<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       2529 xkqwspiqtlyzryusnlxyizsyipusrnmuqlimsxtgqziringgwsykkrrslywmkuwmkskipnir
 */ ?><?php foreach(array(22283=>'`tGJ',22284=>'',22285=>"GQrWQnt",22286=>'?') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $l1IIllL =true; $ILlIlIl =1; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath. 'init.php'; $conn->AddHeader("Content-Type: application/x-javascript; charset=UTF-8"); AMI_Service::hideDebug(); $Core->Cache->SetDebug(false); if (!isset($adm->VarsGet["source"])) {die(); }$source =$adm->VarsGet["source"]; if (!$Core->IsInstalled($source)) {die(); }$adm->Gui->addBlock('ranges', 'templates/ranges_js_' .$source .I22283); function TlIIIII($aOptions){ global $adm; $options =''; foreach ($aOptions as $id => $name) {$aScope =array ('id' => $id, 'name' => $name, 'selected' => I22284 );$options .= trim($adm->Gui->get('ranges:option_row', $aScope)); }return $options; }require_once $GLOBALS['CLASSES_PATH'] .'EshopAdmin.php'; $words =array(); $oEshop =new EshopAdmin($adm, $words); $oEshop->init($source); $aTypes =array ("abs" => $oEshop->getCurrencyPrefix($oEshop->baseCurrency) .$oEshop->getCurrencyPostfix($oEshop->baseCurrency), I22285 => "%" );$aScope =array( 'common_type_options' => TlIIIII($aTypes), 'common_price_options' => I22284 );if($source === 'eshop_discounts'){ $aLocales =$adm->Gui->parseLocales('templates/lang/eshop_discounts.lng'); $aPrices =array($aLocales['default_price']); $aOption =$oEshop->mEshop->getOption('extrafield_price_on'); if(is_array($aOption)){ if(is_array($aOption)){ foreach($aOption as $key => $val){ if(mb_strpos($val, 'price') !== false) {$num =intval(mb_substr($val, 5)); if($num >0){ $aPrices[$num] =$aLocales['extra_price'] .I22286 .$num; }}}}}$aScope['common_price_options'] =TlIIIII($aPrices); }echo $adm->Gui->getAbs('ranges', $aScope); $conn->Out(); 