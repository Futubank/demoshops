<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       41981 xkqwzpsnlnwplsltuqnytugzupztpltwssnguiysswwzlntsppiplmtsiwmugqkrkuyypnir
 */ ?><?php foreach(array(4426=>"FUNw|mNwjUsqd|gzTo",4427=>"QxWMDQ|tZx",4428=>"QxWOZnPQ",4429=>"DOMGGMnP|WHnDt",4430=>'OQZSQr',4431=>'ZYD|tZx',4432=>"'!'",4433=>"'",4434=>'Hn|HrSQr|WrQZtQ',4435=>"DtZtuD",4436=>'SHRQIZGjMDtmtQID',4437=>'ZgZrZID',4438=>'MS|WHuGHn',4439=>'+',4440=>"'?coqRq?MS='",4441=>'-',4442=>'DtZtuD',4443=>"DtZtuDQD|OMDtHrB='",4444=>'rQWMGMQnt',4445=>'DQnSQr|ZSSrQDD',4446=>'JZnP',4447=>'MnDtruWtMHn',4448=>'QIZMJ',4449=>'DOHC|DtZtuD',4450=>"QDOHG|ZSIMn|QIZMJ",4451=>"tBGQ|rQWMGMQnt",4452=>'QDOHG|HrSQr',4453=>'rQZJ|MS',4454=>"Qxt|SZtZ",4455=>'QDOHG|MtQI',4456=>'nZIQ',4457=>'WHIGZnB|nZIQ',4458=>'MnDtruWt',4459=>'MnDtruWtMHn|YHSB',4460=>'fMrDtnZIQ',4461=>"WHSQ",4462=>"rQWMGMQnt",4463=>'',4464=>'IQDDZPQ|tBGQ',4465=>"funW|trZnDJMt`GOG",4466=>"nZIQ",4467=>'ZSI|WHIIQntD',4468=>"ZIHunt",4469=>'qdohg|TzX|hN',4470=>"DOMGGMnP",4471=>"ZSIMn",4472=>"|ZSI",4473=>"YZDQ|WurrQnWB",4474=>'FUNw|mNwjUsqd|gzTo',4475=>"GrMWQ|WZGtMHnD",4476=>"Wur|GrMWQ|tZx",4477=>'DKu',4478=>"MtQI|MnfH",4479=>"MtQI|ZIHunt|GrMWQ",4480=>"ZYDHJutQ|SMDWHunt",4481=>"tHtZJ|CQMPOt",4482=>"MtQI|tBGQ",4483=>"",4484=>"WuDtHI|",4485=>'ZSIMn',4486=>"vZJuQ",4487=>'GZBIQnt|IQtOHS|fQQ',4488=>"WHIGZnB|nZIQ",4489=>"RqihTq|zssR",4490=>"tHtZJ",4491=>"IQIYQrD",4492=>"HrSQr|nHtMfB|QIZMJ",4493=>"DuYLQWt",4494=>'DOMGGMnP',4495=>"OtIJ",4496=>'wjzddqd|gzTo',4497=>'%',4498=>"QxGHrt",4499=>"QxGHrt|GZrZID",4500=>"QxGHrt|IHSuJQ",4501=>"QxGHrt|DZvQ|IQtOHS",4502=>"HrSQr`WDv",4503=>"'{?") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class EshopOrder {public $aCurrency; public $IllILlL; public $ILLlLIl; public $ILLlLIL; function EshopOrder() {$this->ILLlLIl =new AMI_EshopDiscount(); $this->ILLlLIL =new AMI_EshopSMS(); require_once($GLOBALS["CLASSES_PATH"]."Mailer.php"); require_once($GLOBALS[I4426]."func_format.php"); $this->aCurrency =Array(); $this->IllILlL =Array(); }function create(&$cms, $id_member, $username, $ILLlLI1, $status, $firstname, $lastname, $company, $email, $custinfo, $sysinfo, $card, $ILLlLlI, $comments, $tax, $shipping, $total, $lang, $ILLlLll, $orderName ="", $ILLlLlL =true, $ILLlLl1 ="NOW()", $ILLlLLI =false) {global $MULTI_SITE_ID; $db =new DB_si(); if(!empty($card)) $card =base64_encode($ILLlLLl); if(!empty($ILLlLlI)) $card =base64_encode($ILLlLlI); if(is_array($tax)){ $abs_tax =$tax["tax"]; $excise_tax =$tax[I4427]; $shipping_tax =$tax["shipping_tax"]; }else{ $abs_tax =$tax; $excise_tax =0; $shipping_tax =0; }$extData =Array(); if($ILLlLll != $cms->Eshop->baseCurrency) {$abs_tax =$cms->Eshop->convertCurrency($abs_tax, $ILLlLll, $cms->Eshop->baseCurrency); $excise_tax =$cms->Eshop->convertCurrency($excise_tax, $ILLlLll, $cms->Eshop->baseCurrency); $shipping =$cms->Eshop->convertCurrency($shipping, $ILLlLll, $cms->Eshop->baseCurrency); $total =$cms->Eshop->convertCurrency($total, $ILLlLll, $cms->Eshop->baseCurrency); }if($cms->Eshop->baseCurrency != "") {$extData["base_currency"] =Array("code"=>$cms->Eshop->baseCurrency, I4428=>$cms->Eshop->getCurrencyRate($cms->Eshop->baseCurrency)); }if($ILLlLll != "") {$extData["buy_currency"] =Array("code"=>$ILLlLll, I4428=>$cms->Eshop->getCurrencyRate($ILLlLll)); }$extData["shipping_const"] =doubleval($cms->Eshop->mEshop->GetOption(I4429)); $siteId =0; if($MULTI_SITE_ID >= 0){ $siteId =$MULTI_SITE_ID; }$extData["currency"] =$cms->Eshop->aCurrency; $extData["discountForUser"] =$cms->Eshop->TT11ITT(); $extData =serialize($extData); if($ILLlLl1 != "NOW()") $ILLlLl1 ="'$ILLlLl1'"; $aEvent =array( 'status' => &$status, I4430 => &$orderName, 'firstname' => &$firstname, 'lastname' => &$lastname, 'company' => &$company, 'comments' => &$comments, I4431 => &$abs_tax, 'excise_tax' => &$excise_tax, 'shipping_tax' => &$shipping_tax, 'shipping' => &$shipping, 'total' => &$total );AMI_Event::fire('on_order_before_create', $aEvent, AMI_Event::MOD_ANY); $sql ="INSERT INTO cms_es_orders (".($ILLlLLI ?"status, " :"")."name, id_member, id_site, username, order_date,modified_date,firstname,lastname,". "company,email,custinfo,sysinfo,card,card_exp,comments,tax, excise_tax, shipping_tax, shipping,total,lang, ext_data, show_in_admin) ". "VALUES (".($ILLlLLI ?"'$status', " :"")."'".addslashes($orderName)."', '".intval($id_member).I4432.intval($siteId).I4432.$username."', $ILLlLl1, $ILLlLl1,". "'".$firstname.I4432.$lastname.I4432.$company.I4432.$email.I4432.$custinfo.I4432.$sysinfo."',". "'".$card.I4432.$ILLlLlI."',".I4433.$comments.I4432.$abs_tax.I4432.$excise_tax.I4432.$shipping_tax.I4432.$shipping.I4432.$total.I4432.$lang."', '".addslashes($extData)."', '".intval($ILLlLlL)."')"; $db->query($sql); $order_id =$db->lastInsertId(); if(!$ILLlLLI){ $this->updateStatus($cms, $order_id, $ILLlLI1, $status); }$aEvent =array( 'id' => $order_id );AMI_Event::fire(I4434, $aEvent, AMI_Event::MOD_ANY); return $order_id; }function updateStatus(&$cms, $order_id, $ILLlLI1, $status, $extra_params =Array(), $ILLlLLL =null) {global $ROOT_PATH, $lang_data; $res =false; $db =new DB_si; $sql ="SELECT date_format(order_date,'".$cms->DFMT["db"]."') as fdate, id_member, firstname, lastname, username, ". "company, email, statuses_history, comments, tax, shipping, total, ext_data, custinfo, sysinfo, adm_comments, status, lang ". "FROM cms_es_orders WHERE id='$order_id'"; $db->query($sql); $res =$db->next_record(); $ILLlLL1 =($db->Record[I4435] == "confirmed" && ($status == "accepted" || $status == "checkout")); if($res && !empty($status) && !$ILLlLL1) {$aOrderData =$db->Record; $oItem =AMI::getResourceModel( 'eshop_order/table', array(array(I4436 => TRUE, 'keepOldDataOnRemap' => TRUE) ))->find($order_id) ->setData($aOrderData, TRUE, TRUE); $aEvent =array( 'status' => &$status, 'oTableItem' => $oItem, 'oItem' => $oItem, I4437 => &$extra_params, '_discard' => FALSE );AMI_Event::fire('on_order_before_status_change', $aEvent, AMI_Event::MOD_ANY); if(!empty($aEvent['_discard'])){ return false; }$aCustInfo =unserialize($aOrderData['custinfo']); if (isset($aCustInfo[I4438]) && $cms->Core->IsInstalled('eshop_coupons')) {$prevStatus =is_null($ILLlLLL) ?$aOrderData['status'] :$ILLlLLL; $ILLlL1I =$cms->Core->GetModOption('eshop_coupons', 'order_statuses_unused'); if ((in_array($status, $ILLlL1I) && !in_array($prevStatus, $ILLlL1I)) || (!in_array($status, $ILLlL1I) && in_array($prevStatus, $ILLlL1I)) ){$couponId =intval($aCustInfo[I4438]); $delta =(in_array($status, $ILLlL1I) ?I4439 :'+') .'1'; if (intval($delta) >0) {$sql ="SELECT `activations_left` FROM `cms_es_coupons` WHERE `id` = " .$couponId; $ILLIlLl =$db->getValue($sql); if (!is_null($ILLIlLl) && intval($ILLIlLl) == 0) {if (!is_null($ILLlLLL)) {$sql ="UPDATE `cms_es_orders` SET `status`='" .$ILLlLLL. I4440 .$order_id. I4433; $db->execute($sql); }$cms->Messages += $cms->Gui->ParseLangFile($GLOBALS['LOCAL_FILES_REL_PATH'] .'_admin/templates/lang/_eshop_purchase_msgs.lng'); $cms->AddStatusMsg('warn_coupon_no_activations_left', 'red'); return false; }}$ILLlL1l =(intval($delta) >0 ?I4439 :I4441) .'1'; $sql ="UPDATE `cms_es_coupons` SET " ."`activation_count` = `activation_count`" .$delta .", " ."`activations_left` = IF(`activations_left` IS NULL, NULL, `activations_left`" .$ILLlL1l .") " ."WHERE `id` = " .$couponId; $db->execute($sql); }}$history =unserialize($db->Record['statuses_history']); if(!is_array($history)){ $history =array(); }$history[time()] =Array('type'=>$ILLlLI1, I4442=>$status, 'ip'=>getenv("REMOTE_ADDR"), "comments"=>$db->Record['adm_comments']); $sql ="UPDATE cms_es_orders SET status='$status', ". I4443.addslashes(serialize($history))."' WHERE id='$order_id'"; $db->query($sql); $aActions =$cms->Core->GetModOption('eshop_order', 'statuses_actions'); if(is_array($aActions[$status]) && sizeof($aActions[$status])>0) {$cms->Eshop->TT11lIl($aActions[$status], $order_id, $ILLlLI1, $aOrderData, $extra_params); if(empty($aOrderData['firstname']) && empty($aOrderData['lastname'])) {$aOrderData[I4444] =$aOrderData['company']; }else {$aOrderData[I4444] =$aOrderData['firstname']." ".$aOrderData['lastname']; }$aOrderData[I4445] =$cms->Core->GetOption("company_robot_email"); $aOrderData['sender_name'] =$cms->Core->GetOption("company_name"); $aOrderData[I4442] =$status; $aOrderData['user_type'] =$ILLlLI1; $ILLlL1L =$db->Record[I4446]; if(!$ILLlL1L){ $ILLlL1L =$lang_data; }$cms->Gui->addBlock("es_order_mail", $GLOBALS["LOCAL_FILES_REL_PATH"]."_admin/templates/letters/_order_letters_" .$ILLlL1L .".tpl"); $cms->Messages += $cms->Gui->ParseLangFile($GLOBALS["LOCAL_FILES_REL_PATH"]."_admin/templates/lang/_eshop_purchase_msgs.lng"); $this->IllILlL =TlTl1I1($cms, '', $GLOBALS["LOCAL_FILES_REL_PATH"]."_admin/templates/lang/eshop_order_statuses.lng"); foreach($aActions[$status] as $action) {switch ($action) {case I4447: $ILlLLLL =&$cms->Core->GetModule("eshop_cat"); if(empty($extra_params['dontNotifyUser']) && $ILlLLLL->GetOption("instructions_on")){ $this->TITTIll($cms, $order_id, $aOrderData, $extra_params); }break; case 'status_changed_adm_sms': $extra_params[I4448] =$cms->Core->GetModOption('eshop_order', "eshop_admin_sms_email"); $extra_params['user_type'] ='admin'; $extra_params[I4449] =false; $extra_params['message_type'] ='sms'; $this->TITTIl1($cms, $order_id, $aOrderData, $extra_params); break; case 'status_changed_adm': $extra_params[I4448] =$cms->Core->GetModOption('eshop_order', I4450); $extra_params['user_type'] ='admin'; $extra_params[I4449] =false; $this->TITTIl1($cms, $order_id, $aOrderData, $extra_params); break; case 'status_changed_user': $extra_params[I4448] =$aOrderData[I4448]; $extra_params[I4449] =true; if(empty($extra_params['dontNotifyUser'])){ $this->TITTIl1($cms, $order_id, $aOrderData, $extra_params); }break; case 'order_details_adm_with_export': $extra_params["export_params"] =$cms->Core->TTlI1TI('eshop_order', "attach_exported_order"); case 'order_details_adm': $extra_params[I4451] ="admin"; $this->TITTI1T($cms, $order_id, $aOrderData, $extra_params); break; case 'order_details_user': $extra_params[I4451] ="user"; if(empty($extra_params['dontNotifyUser'])){ $this->TITTI1T($cms, $order_id, $aOrderData, $extra_params); }break; case 'add_discount_to_user': break; case 'send_sms_order_status_changed': break; case 'send_products': break; case 'set_eshop_digitals_expire': $this->TITTIlI($cms, $order_id, $aOrderData, $extra_params); break; default: if(mb_substr($action, 0, 7) == 'custom_') {$ILLlL11 =$cms->Core->GetModOption(I4452, 'custom_handler'); $func =$ILLlL11[mb_substr($action, 7)]; if(!empty($func)) {if (function_exists($func)) {$func($cms, $db, $order_id, $status, $aOrderData, $extra_params); }else {trigger_error("EshopOrder::updateStatus: Function $func not exists for action $action", E_USER_WARNING); }}else {trigger_error("EshopOrder::updateStatus: Function not exists for action $action in option custom_handler", E_USER_WARNING); }}elseif(mb_substr($action, 0, 4) != 'ext_') {trigger_error("EshopOrder::updateStatus: Unknown action '$action'", E_USER_WARNING); }break; }}}AMI_Event::fire('on_order_after_status_change', $aEvent, AMI_Event::MOD_ANY); }return $res; }function TITTIlT(&$vRes, $dbTablePrefix, $ILLl1II) {$res =false; if($ILLl1II >0) {$db =new DB_si; $sql ="SELECT id, instruction, instruct, id_parent FROM cms_es_cats WHERE id='$ILLl1II'"; $db->query($sql); if($db->next_record()) {if($db->Record['instruct'] == 1) {$vRes[I4453] =$db->Record['id']; $vRes[I4447] =$db->Record[I4447]; $res =true; }else {$vRes['ids'][] =$ILLl1II; $res =$this->TITTIlT($vRes, $dbTablePrefix, $db->Record['id_parent']); }}}return $res; }function TITTIlI(&$cms, $ILLIll1, &$ILLl1Il, &$ILLl1IL) {$eshopDigitals =&$cms->Core->GetModule("eshop_digitals"); if($eshopDigitals->IsInstalled()) {$extData =unserialize($ILLl1Il[I4454]); $extData["eshop_digitals"]["expire"] =strtotime($eshopDigitals->GetOption("download_lifetime"),time()); $sql ="UPDATE cms_es_orders SET ext_data='".addslashes(serialize($extData)).I4440.$ILLIll1.I4433; $db =new DB_si; $db->query($sql); }}function TITTIll(&$cms, $ILLIll1, &$ILLl1Il, &$ILLl1IL) {global $lang_data; $db =new DB_si; $ILLl1I1 =&$cms->Core->GetModule(I4455); $ILlLLLL =&$cms->Core->GetModule('eshop_cat'); $ILLl1I1->PushPager($cms->Pager); $ILLl1I1->InitPager($cms->Pager); $cms->Pager->SortCol ='name'; $ILLl1lI =Array(); $sql ="SELECT i.name, i.id_category FROM cms_es_order_items oi ". "LEFT JOIN ".$cms->Eshop->dbTablePrefix."_items i ON oi.id_product=i.id ". "WHERE oi.id_order='$ILLIll1' GROUP BY i.id_category, i.name ORDER BY ".$cms->Pager->TI1TTlT().",i.id asc"; $db->query($sql); while($db->next_record()) {$ILLl1lI[$db->Record['id_category']] .= '<br>'.$db->Record['name']; }$ILlLLLL->InitPager($cms->Pager); $cms->Pager->SortCol =I4456; $sql ="SELECT c.id, c.name, c.instruction, c.instruct, c.id_parent FROM cms_es_order_items oi ". "LEFT JOIN ".$cms->Eshop->dbTablePrefix."_items i ON oi.id_product=i.id ". "LEFT JOIN ".$cms->Eshop->dbTablePrefix."_cats c ON i.id_category=c.id ". "WHERE oi.id_order='$ILLIll1' ". "GROUP BY i.id_category ORDER BY c.".$cms->Pager->TI1TTlT().",i.id asc"; $db->query($sql); $aMailData =Array( 'instruction_rows'=>'', I4457=>$cms->Core->GetOption(I4457), 'company_url'=>$cms->Core->GetOption("company_url"), I4456=>$ILLl1Il[I4444], 'num'=>$ILLIll1 );$rows =0; while($db->next_record()) {$aRowData =Array(); $aRowData['catname'] =$db->Record[I4456]; $instruct =true; if($db->Record[I4458]==1) {$aRowData['instruction_body'] =$db->Record[I4447]; $aRowData['items'] =mb_substr($ILLl1lI[$db->Record['id']], 0); }else {if($instruct =$this->TITTIlT($vRes, $cms->Eshop->dbTablePrefix, $db->Record['id_parent'])) {$aRowData[I4459] =$vRes[I4447]; $aRowData['items'] =mb_substr($ILLl1lI[$db->Record['id']], 0); }}if($instruct) {$rows++; $aMailData['instruction_rows'] .= $cms->Gui->get("es_order_mail:instruction_row", $aRowData); }}if($rows >0) {$ILLl1ll =$cms->Gui->get("es_order_mail:instruction", $aMailData); $oMail =new Mailer(); $oMail->RecipientAddress =$ILLl1Il[I4448]; $oMail->RecipientName =$ILLl1Il[I4444]; $oMail->SenderAddress =$cms->Core->GetOption("company_robot_email"); $oMail->SenderName =$cms->Core->GetOption("company_name"); $oMail->Subject =$cms->Gui->get("es_order_mail:instruction_mail_subject", $aMailData); $oMail->Body =$ILLl1ll; $oMail->BodyFormat ="html"; $oMail->Prepare(); if(!$oMail->Send()){ trigger_error("EshopOrder::_SendInstructions: sending email to $email failed", E_USER_WARNING); $cms->AddStatusMsg("es_order_instructions_sent_error", "red", "", "", array("email"=>$ILLl1Il[I4448])); }else {$cms->AddStatusMsg("es_order_instructions_sent", "", "", "", array("email"=>$ILLl1Il[I4448])); }}$ILLl1I1->PopPager($cms->Pager); }function TITTIl1(&$cms, $ILLIll1, &$ILLl1Il, &$ILLl1IL) {global $lang_data; $email =$ILLl1IL[I4448]; $order_firstname =$ILLl1Il[I4460]; $order_lastname =$ILLl1Il['lastname']; $ILLl1lL =$ILLl1Il[I4448]; $extData =unserialize($ILLl1Il[I4454]); $currency =$extData["buy_currency"]["code"]; $baseCurrency =$extData["base_currency"][I4461]; $total =$cms->Eshop->convertCurrency($ILLl1Il["total"], $baseCurrency, $currency); $shipping =$cms->Eshop->convertCurrency($ILLl1Il["shipping"], $baseCurrency, $currency); $tax =$cms->Eshop->convertCurrency($ILLl1Il["tax"], $baseCurrency, $currency); $ILLl1l1 =Array( "num"=>$ILLIll1, I4462=>$ILLl1Il[I4444], "ip"=>getenv("REMOTE_ADDR"), "email"=>$ILLl1Il[I4448] );$ILLl1IL += array('message_type' => I4463); $subject =$cms->Gui->getAbs( "es_order_mail:notify_subject" .($ILLl1IL['user_type'] == 'admin' ?'_adm' :I4463) .($ILLl1IL[I4464] == 'sms' ?'_sms' :I4463), $ILLl1l1 );$order_status =$this->IllILlL[$ILLl1Il[I4442]]; $ILLl1LI =$cms->Eshop->formatMoney($total +$tax +$shipping, $currency, false); if ($ILLl1IL[I4464]=='sms' && $lang_data!="en"){ require_once($GLOBALS[I4426].I4465); $order_status =cms_transliterate($order_status, $lang_data); $ILLl1LI =cms_transliterate($ILLl1LI, $lang_data); $order_firstname =cms_transliterate($order_firstname, $lang_data); $order_lastname =cms_transliterate($order_lastname, $lang_data); }$ILLl1Ll =Array("company_name"=>$cms->Core->GetOption("company_name"), "company_url"=>$cms->Core->GetOption("company_url"), I4466=>$ILLl1Il[I4444], "num"=>$ILLIll1, "date"=>$ILLl1Il['fdate'], "comments"=>$ILLl1Il[I4467], "firstname"=>$order_firstname, "lastname"=>$order_lastname, "email"=>$ILLl1lL, I4435=>$order_status, "status_orig"=>$ILLl1Il[I4442], I4468=>$ILLl1LI); $ILLl1Ll += unserialize($ILLl1Il['custinfo']); $mbody =$cms->Gui->getAbs("es_order_mail:notify" .($ILLl1IL[I4464] == 'sms' ?'_sms' :I4463), $ILLl1Ll); $oMail =new Mailer(); $oMail->RecipientAddress =$email; $oMail->RecipientName =$ILLl1Il[I4444]; $oMail->SenderAddress =$cms->Core->GetOption("company_robot_email"); $oMail->SenderName =$cms->Core->GetOption("company_name"); $oMail->Subject =$subject; $oMail->Body =$mbody; if ($ILLl1IL[I4464]=='sms'){ $oMail->BodyFormat ="plain"; }else{ $oMail->BodyFormat ="html"; }$oMail->Prepare(); $res =$oMail->Send(); if($ILLl1IL[I4449]) {if(!$res){ trigger_error("EshopOrder::_SendStatusChangedUserEmail: sending email to $email failed", E_USER_WARNING); $cms->AddStatusMsg("es_order_status_sent_error", "red", "", "", array("email"=>$email)); }else {$cms->AddStatusMsg("es_order_status_sent", "", "", "", array("email"=>$email)); }}}function TITTI1T(&$cms, $order_id, &$aOrderData, $extra_params) {global $lang_data, $ROOT_PATH_WWW, $ROOT_PATH; $res =false; $db =new DB_si; $cms->Words =array_merge($cms->Words, $cms->Gui->ParseLangFile($GLOBALS["LOCAL_FILES_REL_PATH"]."_admin/templates/lang/eshop_order_letters.lng")); $aData =Array(); if($cms->Core->GetModOption("eshop_tax_classes", "tax_scheme") != "no") {$cms->Gui->AddGlobalVars(Array(I4469 => '1')); }else {$cms->Gui->AddGlobalVars(Array(I4469 => '0')); }if($cms->Eshop->mEshop->GetOption("shipping_scheme") != "no" && $aOrderData[I4470] != 0) {$cms->Gui->AddGlobalVars(Array('ESHOP_SHIPPING_ON' => '1')); }else {$cms->Gui->AddGlobalVars(Array('ESHOP_SHIPPING_ON' => '0')); }if($extra_params[I4451] == I4471) {$recipientName =""; $mEshopOrder =&$cms->Core->GetModule("eshop_order"); $email =$mEshopOrder->GetOption(I4450); $ILLl1LL ="_adm"; $aData["templatePostfix"] =I4472; }elseif($extra_params[I4451] == "user") {$ILLl1LL =I4463; $recipientName =$aOrderData[I4444]; $email =$aOrderData[I4448]; $aData["templatePostfix"] =""; }$extData =unserialize($aOrderData[I4454]); $currency =$extData["buy_currency"][I4461]; $baseCurrency =$extData[I4473][I4461]; $total =$cms->Eshop->convertCurrency($aOrderData["total"], $baseCurrency, $currency); $shipping =$cms->Eshop->convertCurrency($aOrderData[I4470], $baseCurrency, $currency); $tax =$cms->Eshop->convertCurrency($aOrderData["tax"], $baseCurrency, $currency); $sql ="SELECT i.id, oi.price, oi.price_number, oi.qty, oi.ext_data, i.name, i.item_type, i.sku FROM cms_es_order_items oi LEFT JOIN ".$cms->Eshop->dbTablePrefix."_items AS i ON i.id=oi.id_product WHERE id_order='".$order_id.I4433; $db->query($sql); require_once $GLOBALS[I4474] .'func_eshop.php'; $order_items =I4463; $index =1; $ILLl1L1 =&createEshopExtensionObject($cms); $grandDiscount =0; $ILLl11I =0; while($db->next_record()) {$ILLl11l =Array(); $id =$db->Record["id"]; $priceNumber =$db->Record["price_number"]; $qty =$db->Record["qty"]; $extData =unserialize($db->Record[I4454]); $priceCaptions =$extData[I4475]; $ILLl11L =$extData["price_currency"]; $price =$extData["item_info"]["cur_price"]; if($price == "") {$price =$cms->Gui->getAbs("es_order_mail:price_null", ""); $itemPrice =$price; $ILLl111 =$cms->Gui->getAbs("es_order_mail:price_null", ""); }else {$itemPrice =$cms->Eshop->formatMoney($price, $currency); $ILLl111 =$cms->Eshop->formatNumber($extData["item_info"][I4476], true, true); $ILLl111 =$cms->Eshop->formatMoney($ILLl111 *$qty, $currency); }if($priceNumber >0 && $priceCaptions[$id][$priceNumber] != "") {$price =$cms->Gui->getAbs("es_order_mail:order_other_price".$ILLl1LL, Array("price_caption"=>$priceCaptions[$id][$priceNumber], "price"=>$price)); }$ILLLIII =Array(); $ILLLIII[I4477] =$db->Record[I4477]; $ILLLIII["item_name"] =$db->Record[I4466]; $ILLLIII["item_property_caption"] =TlTll11($extData["item_info"]["id_prop"], $ILLl1L1, $extData[I4478]["prop_info"], "es_order_mail"); $ILLLIII["item_quantity"] =$qty; $ILLLIII["item_price"] =$itemPrice; $ILLLIIl =$cms->Eshop->formatNumber($price, true, true) *$qty; $ILLLIII[I4479] =$cms->Eshop->formatMoney($ILLLIIl, $currency); $ILLLIII["item_amount_price_tax"] =$ILLl111; $ILLLIII["number"] =$index; if (isset($extData[I4478]["absolute_discount"])) {$d =$extData[I4478]["absolute_discount"]; $grandDiscount += ($d); $extData[I4478][I4480] =$cms->Eshop->formatMoney($d, $currency); $extData[I4478]["original_price"] =$cms->Eshop->formatMoney($cms->Eshop->formatNumber($price +($d /$qty), true, true), $currency); }else {$extData[I4478]["percentage_discount"] =0; $extData[I4478][I4480] =$cms->Eshop->formatMoney(0, $currency); $extData[I4478]["original_price"] =$itemPrice; }$ILLLIII += $extData[I4478]; if(isset($extData[I4478]["weight"])){ $ILLLIII[I4481] =$extData[I4478]["weight"] *$qty; $ILLl11I += $ILLLIII[I4481]; }$order_items .= $cms->Gui->get("es_order_mail:order_item".$ILLl1LL, $ILLLIII); if(isset($ILLLIIL[$db->Record["item_type"]])) {$ILLLIIL[$db->Record["item_type"]] =true; }$cms->Eshop->TT11lTT($db->Record[I4482]); $index++; }$ILLLII1 =$aOrderData; $ILLLII1["cust_info"] =I4463; $aCustInfo =unserialize($aOrderData["custinfo"]); if(array_key_exists('country', $aCustInfo)){ $aCountries =$cms->Gui->ParseLangFile($GLOBALS["LOCAL_FILES_REL_PATH"]."_admin/templates/lang/country.lng"); }if(is_array($aCustInfo)) {$form["customer_inn"] =empty($aCustInfo['inn']) ?I4463 :$aCustInfo['inn']; foreach($aCustInfo as $name => $val) {if ($name != "shipping_conflicts") {if($val != I4483 && !empty($cms->Words[$name])) {if($name == 'country' && isset($aCountries[$val])){ $val =$aCountries[$val]; }$ILLLII1["cust_info"] .= $cms->Words[$name].': '.nl2br($val)."<br>"; $ILLLII1[I4484.$name] =nl2br($val); }}}}$paymentMethodFee =0; $aSysInfo =unserialize($aOrderData["sysinfo"]); if(is_array($aSysInfo)) {if(isset($aSysInfo['fee_percent'])){ $ILLLIlI =AMI::getSingleton(I4452); $ILLLIll =AMI::getResourceModel('eshop_order/table')->find($order_id); $paymentMethodFee =$ILLLIlI->getTotal($ILLLIll, 'payment_method_fee'); if($paymentMethodFee >0){ if((I4485 == $extra_params['type_recipient'])){ $paymentMethodFee =0; }$aSysInfo['payment_method_fee'] =$ILLLIlI->getTotal($ILLLIll, 'payment_method_fee', AMI_EshopOrder::FMT_MONEY); }unset($ILLLIlI, $ILLLIll); }foreach($aSysInfo as $name => $val) {if ($name != "payment_type" && isset($cms->Words[$name])) {$aSysData =Array(I4456=>$cms->Words[$name]); if(!empty($cms->Words[$val])) {$aSysData[I4486] =$cms->Words[$val]; }else if($name == 'driver' && isset($GLOBALS['BILLING_DRIVERS_ALIASES'][$val]) && !empty($cms->Words[$GLOBALS['BILLING_DRIVERS_ALIASES'][$val]])) {$aSysData[I4486] =$cms->Words[$GLOBALS['BILLING_DRIVERS_ALIASES'][$val]]; }else {if(I4487 == $name) $aSysData[I4486] =nl2br($val); }$ILLLII1["sys_info"] .= $cms->Gui->get("es_order_mail:order_additional_info_sys".$ILLl1LL, $aSysData); }}}$ILLLIlL =$cms->Gui->get("es_order_mail:order_additional_info".$ILLl1LL, $ILLLII1); $mailData =Array("company_name"=>$cms->Core->GetOption(I4488), "company_url"=>$cms->Core->GetOption("company_url"), I4466=>$aOrderData[I4444], "num"=>$order_id, "ip"=>getenv(I4489), "email"=>$aOrderData[I4448], "order_items"=>$order_items, "comments"=>nl2br($aOrderData['comments']), I4490=>$cms->Eshop->formatMoney($total, $currency), "grand_discount" => $cms->Eshop->formatMoney($grandDiscount, $currency), "tax"=>$cms->Eshop->formatMoney($tax, $currency), I4470=>$cms->Eshop->formatMoney($shipping, $currency), I4468=>$cms->Eshop->formatMoney($total +$tax +$shipping +$paymentMethodFee, $currency), "additional_info"=>$ILLLIlL); $mailData["grand_total_weight"] =$ILLl11I; $mMembers =&$cms->Core->GetModule(I4491); $mailData["login_url"] =$ROOT_PATH_WWW.$mMembers->GetFrontLink()."?username=".rawurlencode($aOrderData["username"]); $words =$cms->Gui->ParseLangFile($GLOBALS["LOCAL_FILES_REL_PATH"]."_admin/templates/lang/eshop_order_history.lng"); $mailData["view_order_history"] =$words["view_order_history"]; $mailData["view_order"] =$words["view_order"]; $mailData += $aData; $cms->Eshop->TT11lIT(I4492, $mailData, $mailData); $cms->Eshop->TT11lTI(); $III1LlL =$cms->Gui->get("es_order_mail:order_subject".$ILLl1LL, $mailData); if(function_exists("EventApplyVars")) {$ILLLIl1 =Array( "recipient_email" => &$email, "recipient_name" => &$recipientName, I4493 => &$III1LlL, I4451 => $extra_params[I4451], 'data' => &$mailData, 'currency' => $currency, 'total' => $total, 'tax' => $tax, I4494 => $shipping, 'cms' => &$cms, );EventApplyVars($this, "eshop_order_mail", $ILLLIl1); }$mbody =$cms->Gui->get("es_order_mail:order_body".$ILLl1LL, $mailData); $oMail =new Mailer(); $oMail->RecipientAddress =$email; $oMail->RecipientName =$recipientName; $oMail->SenderAddress =$cms->Core->GetOption("company_robot_email"); $oMail->SenderName =$cms->Core->GetOption(I4488); $oMail->Subject =$III1LlL; $oMail->Body =$mbody; $oMail->BodyFormat =I4495; if($extra_params[I4451] == I4471 && isset($extra_params["export_params"]["export_driver"]) && isset($extra_params["export_params"]["export_recipient"])) {$side =$cms->Core->Side; $cms->Core->Side =I4471; require_once $GLOBALS[I4496] .'Admin.php'; $adm =new Admin($cms->Core); $adm->constructorPostActions(); $ILLLILI =is_array($cms->Gui->debug) ?implode('|', $cms->Gui->debug) :$cms->Gui->debug; $adm->Gui->SetDebug(I4483, true); $adm->lang_data =$cms->lang_data; $adm->setLang($cms->lang_data); $filename =md5(getenv('REMOTE_ADDR').':'.rand(0, 1000000).I4497.microtime()).".csv"; $adm->VarsPost =Array(); $adm->VarsPost =Array( "action" => "run", "exchange_type" => I4498, "export_driver" => $extra_params["export_params"]["export_driver"], "export_recipient" => $extra_params[I4499]["export_recipient"], I4500 => Array("eshop_order"), "export_data_type" => Array("new"), I4501 => "file", "export_save_filename" => $filename, );$adm->Vars =$adm->VarsPost; $adm->SuppressStatusErrors =true; $ILLLILl =&$adm->Core->GetModule("eshop_data_exchange"); $ILLLILl->InitEngine($adm, $db); $ILLLILl->Engine->Init(); $ILLLILl->Engine->SetRedirect(false); $ILLLILl->Engine->II1lILl =2; $ILLLILl->Engine->II1lILL =false; $ILLLILl->Engine->ProcessAction($adm->Vars['action'], I4483); $adm->Gui->SetDebug($ILLLILI, true); $adm->Core->Side =$side; $II11IIl[0] =$adm->ReadFileExtended($ILLLILl->Engine->TTIlTTl(), $filename, I4502); $II11IIl["ftype"] ="application/octet-stream"; $oMail->AddAttachments($II11IIl); $adm->TTITlTT($filename, $ILLLILl->Engine->TTIlTTl()); unset($adm); $ILLLILl->TTlITl1(); }$oMail->Prepare(); $res =$oMail->Send(); if(!$res){ trigger_error("ESHOP-ORDER: sending email failed. Rcpt:".$oMail->RecipientAddress, E_USER_WARNING); }return $res; }function TITTI1I(&$cms) {$aExpire =$cms->Core->GetModOption(I4452, 'statuses_expire'); if(is_array($aExpire)) {$where =I4463; foreach($aExpire as $status => $format) {$udate =strtotime($format); if(!empty($format) && $udate != -1) {$where .= " OR (status='$status' AND order_date<'".DateTools::toMysqlDate($udate).I4503; }}if(!empty($where)) {$db =new DB_si; $ids =I4463; $sql ="SELECT id FROM cms_es_orders WHERE 0 $where"; $db->query($sql); while ($db->next_record()) {$ids .= ','.$db->Record['id']; }$ILLLILL ="(0 $ids)"; $sql ="DELETE FROM cms_es_order_items WHERE id_order IN $ILLLILL"; $db->query($sql); $sql ="DELETE FROM cms_es_orders WHERE id IN $ILLLILL"; $db->query($sql); }}}}