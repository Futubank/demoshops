<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       13136 xkqwlqtwuttsxkkxxmkggkxtsmgrsgrrrwgktktwlsmqwprwyqiywrqsnqutptpmrlytpnir
 */ ?><?php foreach(array(14920=>"",14921=>"QrrnH",14922=>"QrrHr",14923=>"YuttHn",14924=>"YuttHn|nZIQ",14925=>"WZJJYZWK",14926=>"ZIHunt",14927=>"SMDZYJQS",14928=>"QDOHG|MS",14929=>"WZnWQJ|urJ",14930=>'HK',14931=>"OZDO",14932=>"DQrvMWQNZIQ",14933=>'%%',14934=>"GZBIQntsZtZ",14935=>'MnnQr') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} if(!class_exists("BILL_driver_rbk", false)){ class BILL_driver_rbk extends BILL_driver_base {function TlTT1Il(&$lLIILll){ $lLIILll =number_format($lLIILll, 2, ".", I14920); }function getPayButton(array &$vRes, array $cData, $ll11ILL =false){ $res =true; $data =$cData; $vRes["error"] ="Success"; $vRes["errno"] =0; if(empty($data["process_url"])){ $vRes[I14921] =1; $vRes["error"] ="process_url is missed"; $res =false; }else if(empty($data["return"])){ $vRes[I14921] =2; $vRes["error"] ="return url is missed"; $res =false; }else if(empty($data["eshop_id"])){ $vRes[I14921] =3; $vRes["error"] ="eshop id is missed"; $res =false; }else if(empty($data["amount"])){ $vRes[I14921] =4; $vRes[I14922] ="amount is missed"; $res =false; }else if(empty($data["description"])){ $vRes[I14921] =5; $vRes[I14922] ="description is missed"; $res =false; }else if(empty($data["button_name"]) && empty($data[I14923])){ $vRes[I14921] =6; $vRes[I14922] ="button is missed"; $res =false; }$this->TlTT1Il($data["amount"]); foreach(Array("return", "description", I14924) as $fldName) $data[$fldName] =htmlspecialchars($data[$fldName]); $ll11IL1 =$data; if(isset($ll11IL1["process_url"])) unset($ll11IL1["process_url"]); if(isset($ll11IL1["return"])) unset($ll11IL1["return"]); if(isset($ll11IL1[I14925])) unset($ll11IL1[I14925]); if(isset($ll11IL1["cancel"])) unset($ll11IL1["cancel"]); if(isset($ll11IL1["eshop_id"])) unset($ll11IL1["eshop_id"]); if(isset($ll11IL1[I14926])) unset($ll11IL1[I14926]); if(isset($ll11IL1["description"])) unset($ll11IL1["description"]); if(isset($ll11IL1[I14924])) unset($ll11IL1[I14924]); if(isset($ll11IL1[I14923])) unset($ll11IL1[I14923]); foreach($ll11IL1 as $key => $value) $data["hiddens"] .= "<input type=\"hidden\" name=\"$key\" value=\"$value\">\r\n"; $data[I14923] =trim($data[I14923]); if(!empty($data[I14923])) {$data["_button_html"] =1; }if(!$res) {$data[I14927] =I14927; }return parent::getPayButton($vRes, $data, $ll11ILL); }function getPayButtonParams(array $cData, array &$vRes){ $data =$cData; $vRes[I14922] ="Success"; $vRes[I14921] =0; if(empty($data["return"])){ $vRes[I14921] =1; $vRes[I14922] ="return url is missed"; return false; }else if(empty($data[I14926])){ $vRes[I14921] =2; $vRes[I14922] ="amount is missed"; return false; }else if(empty($data[I14928])){ $vRes[I14921] =3; $vRes[I14922] ="eshop_id is missed"; return false; }else if(empty($data["description"])){ $vRes[I14921] =4; $vRes[I14922] ="description is missed"; return false; }$this->TlTT1Il($data[I14926]); foreach(Array("return_url", I14929, "description", I14924) as $fldName) if(isset($data[$fldName])) $data[$fldName] =htmlspecialchars($data[$fldName]); return parent::getPayButtonParams($data, $vRes); }function payProcess(array $cGet, array $cPost, array &$vRes, array $ll11I1I, array $aOrderData){ $status ='fail'; if(!@is_array($cGet)) $cGet =Array(); if(!@is_array($cPost)) $cPost =Array(); $params =array_merge($cGet, $cPost); if(!empty($params['status'])) $status =$params['status']; return ($status == I14930); }function payCallback(array $cGet, array $cPost, array &$vRes, array $ll11I1I, array $aOrderData){ $status =$cPost["rbk_action"] != 'sys' ?'fail' :'inner'; if(!@is_array($cGet)) $cGet =Array(); if(!@is_array($cPost)) $cPost =Array(); $params =array_merge($cGet, $cPost); if(isset($params[I14931])){ $sign =mb_strtolower(md5($params["eshopId"].'::'. $params["orderId"].'::'. $params[I14932].'::'. $params["eshopAccount"].'::'. $params["recipientAmount"].I14933. $params["recipientCurrency"].I14933. $params["paymentStatus"].I14933. $params["userName"].I14933. $params["userEmail"].I14933. $params[I14934].I14933. $ll11I1I["secret_key"])); if(!strcasecmp($params["rbk_hash"], $sign)) $status =I14930; else $vRes[I14922] ="Hashes do not match"; }else{ $vRes[I14922] ="Hash not found"; }return ($status == I14935 ?-1 :($status == I14930 ?1 :0)); }function getProcessOrder(array $cGet, array $cPost, array &$vRes, array $additionalParams){ $orderId =0; if(!empty($cGet["order_id"])) $orderId =$cGet["order_id"]; if(!empty($cPost["order_id"])) $orderId =$cPost["order_id"]; return intval($orderId); }}}?>