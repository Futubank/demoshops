<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       32543 xkqwxwwssrkqiwrmisyuprqsunplnnzlkwtixupuxrkrktllppquxuyzplgpzltwqnnspnir
 */ ?><?php foreach(array(18638=>'MnMt`GOG',18639=>"tQIGJZtQD~",18640=>"HffDQt",18641=>"MS",18642=>"'!'",18643=>"|HrSQrD?H?",18644=>'ZSI|WHIIQntD',18645=>"SZtQ",18646=>"HrSQr|SQtZMJD",18647=>"YZDQ|WurrQnWB",18648=>"DOMGGMnP",18649=>"tHtZJ",18650=>"tZx",18651=>"dqjqwT?",18652=>"|HrSQr|MtQID?HM",18653=>"MS|GrHSuWt",18654=>'Qxt|MIZPQD',18655=>'MS',18656=>'Qxt|MIP|GHGuG',18657=>"HrSQr|MS",18658=>"EtB",18659=>"GrMWQ",18660=>"nZIQ",18661=>"GrHG|MnfH",18662=>"GrMWQ|tHtZJ",18663=>"GrMWQ|WZGtMHn",18664=>"HCnQr|nZIQ",18665=>"DMAQ",18666=>"CQMPOt",18667=>"tHtZJ|CQMPOt",18668=>'MIZPQ',18669=>"ZYDHJutQ|SMDWHunt",18670=>"HrMPMnZJ|GrMWQ",18671=>"rHC",18672=>"MtQI",18673=>"YHSB|SQtZMJD",18674=>"",18675=>"uDQr|YZJZnWQ",18676=>'qDOHGhrSQr`GOG',18677=>"JZDtnZIQ",18678=>'',18679=>'Qnv~DQDDMHn',18680=>'JMDt',18681=>'WHnf',18682=>':b+:I+:S',18683=>'SZtQfrHI',18684=>'SZtQtH',18685=>'izX',18686=>'DQJQWt',18687=>'DQZrWO|tQxt',18688=>'H`nZIQ',18689=>":'?",18690=>'JZB|MS',18691=>"MS|IQIYQr='",18692=>" HffDQt=*dTzRT&",18693=>"FRhi?",18694=>"HrSQr",18695=>"Qxt|SZtZ",18696=>"GZPQ|tHtZJ",18697=>"ZIHunt",18698=>"vMQC|JMnK",18699=>'IHSmS',18700=>"HrSQr|HCnQr|",18701=>"HrSQr|HCnQr|JMDt",18702=>"JMDt",18703=>"HrSQr|OMDtHrB") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLI111I =0; if (isset($mode) && $mode == "small") {$lLI111I =1; }if (!$lLI111I) {$eshop =1; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .I18638; }else {$lLI111l =$frn->SetsTemplate; }$oEshop =&$frn->Eshop; $lLLI1LI =&$frn->Core->GetModule($oEshop->ownerName ."_order_history"); if ($lLLI1LI->GetOption("engine_version") >"0302") {}else {$frn->Gui->addBlock("order_history", I18639 .$frn->Eshop->ownerName ."_order_history.tpl"); $frn->SetsTemplate ="order_history"; $lIIII1L =&$frn->Core->GetModule($oEshop->ownerName ."_digitals"); $eshopDigitalsOn =($lIIII1L->IsInstalled()); $lLLI1Ll =(sizeof($oEshop->aCloneOwners) >1); if (!$lLI111I) {$mMembers =&$frn->Core->GetModule("members"); $frn->Member->requireLogin($ROOT_PATH_WWW .$mMembers->GetFrontLink(), $ROOT_PATH_WWW .$lLLI1LI->GetFrontLink(), "eshop_order_history"); $oUser =&$frn->Member; if ($oUser->isLoggedIn()) {$userId =$oUser->getUserInfo("id"); $frn->Words =array_merge($frn->Words, $frn->Gui->ParseLangFile("_local/_admin/templates/lang/" .$frn->Eshop->ownerName ."_order_history.lng")); $offset =""; if (isset($frn->Vars[I18640])) {$offset =$frn->Vars[I18640]; }$lLLI1LL =$lLLI1LI->GetOption("allowed_order_status"); if (!is_array($lLLI1LL)) {$lLLI1LL =Array($lLLI1LL); }if (isset($frn->Vars["id"]) && $frn->Vars["id"] >0) {if (empty($II111lL)) $II111lL ="body_order_details"; $orderId =intval($frn->Vars[I18641]); $filter ="WHERE id='" .$orderId ."' AND lang='" .$lang ."' AND id_member='" .$userId ."' AND o.status IN('" .implode(I18642, $lLLI1LL) ."') AND o.show_in_admin=1"; $sql ="SELECT " ."o.id, o.tax, o.shipping, o.total, (o.total+o.tax+o.shipping) AS amount, " ."o.ext_data, o.status, o.name, " ."DATE_FORMAT(o.order_date,'" .$frn->DFMT["db"] ."') AS fdate, " ."UNIX_TIMESTAMP(order_date) AS order_date, o.status, o.owners, o.`adm_comments` " ."FROM " .$oEshop->dbTablePrefix .I18643 .$filter ." ORDER BY " .$frn->Pager->TI1TTlT() .", id asc  "; $db->query($sql); if ($db->next_record()) {$lLLI1L1 =Array(); $aData =$db->Record; $lLLI11I['adm_comments'] =$frn->TTITI1l('order_details', I18644, $db->Record[I18644]); $lLLI11I[I18641] =$db->Record[I18641]; $lLLI11I["name"] =$frn->TTITI1l("order_details", "name", $db->Record["name"]); $lLLI11I[I18645] =$frn->TTITI1l("order_details", I18645, $db->Record["fdate"]); $status =$frn->Words[$db->Record["status"]]; $lLLI11I["status"] =$frn->TTITI1l(I18646, "status", $status); $oExtData =unserialize($db->Record["ext_data"]); $currency =$oExtData["buy_currency"]["code"]; $lLLI11l =$oExtData[I18647]["code"]; $oEshop->pushCurrencyData($oExtData["currency"], $lLLI11l); $lLLI11I["tax"] =$oEshop->convertCurrency($db->Record["tax"], $lLLI11l, $currency); $lLLI11I[I18648] =$oEshop->convertCurrency($db->Record[I18648], $lLLI11l, $currency); $lLLI11I["total"] =$oEshop->convertCurrency($db->Record["total"], $lLLI11l, $currency); $lLLI11I["amount"] =$oEshop->convertCurrency($db->Record["amount"], $lLLI11l, $currency); $lLLI11I[I18649] =$oEshop->formatMoney($lLLI11I[I18649], $currency); $lLLI11I["tax"] =$oEshop->formatMoney($lLLI11I["tax"], $currency); $lLLI11I[I18648] =$oEshop->formatMoney($lLLI11I[I18648], $currency); $lLLI11I["amount"] =$oEshop->formatMoney($lLLI11I["amount"], $currency); $lLLI11I[I18649] =$frn->TTITI1l(I18646, I18649, $lLLI11I[I18649]); $lLLI11I[I18650] =$frn->TTITI1l(I18646, I18650, $lLLI11I[I18650]); $lLLI11I[I18648] =$frn->TTITI1l(I18646, I18648, $lLLI11I[I18648]); $lLLI11I["amount"] =$frn->TTITI1l(I18646, "amount", $lLLI11I["amount"]); $lLLI11L =true; $lLLI111 =$oEshop->TT11lII("order_history_list"); $sql =I18651 ."oi.id_product, oi.price, oi.qty, oi.price_number, oi.owner_name, " ."oi.owner_name, oi.ext_data" .$lLLI111["select"] ." FROM " .$oEshop->dbTablePrefix .I18652 .$lLLI111["join"] ." WHERE id_order='" .$orderId ."'"; $db->query($sql); if ($db->num_rows() >0) {$lII111L =false; $itemIds =Array(); while ($db->next_record()) {$oEshop->TT11lTT($db->Record["item_type"]); $itemIds[] =$db->Record[I18653]; }$db->seek(); $aTmpExt =AMI::getOption('eshop_item', 'extensions'); AMI::setOption('eshop_item', 'extensions', array(I18654)); AMI::initModExtensions('eshop_item'); AMI::setOption('eshop_item', 'extensions', $aTmpExt); $lLLlIII =array(); $lLLlIIl =AMI::getResourceModel('eshop_item/table')->getList(); $lLLlIIl ->addColumns(array(I18655, 'ext_img', 'ext_img_small', 'ext_img_popup')) ->addWhereDef(DB_Query::getSnippet('AND i.`id` IN (%s)')->implode($itemIds, FALSE)) ->load(); foreach($lLLlIIl as $lLLlIIL){ if($lLLlIIL->ext_img_small){ $lLLlIII[$lLLlIIL->id] =array( I18656 => $lLLlIIL->ext_img_popup, 'ext_img_small' => $lLLlIIL->ext_img_small, 'ext_img' => $lLLlIIL->ext_img );}}unset($lLLlIIl, $lLLlIIL); $aData += Array("itemIds" => implode(I18642, $itemIds), "oExtData" => &$oExtData, I18657 => $orderId); $lIIl11I =Array(); if ($lLLI1Ll) {$lIIl11I["item_owner_header"] =$frn->TTITI1l("item", "owner_header", ""); }if ($lLLI11L) {$lIIl11I["item_gallery_header"] =$frn->TTITI1l("item", "gallery_header", ""); }$oEshop->TT11lT1("order_history_list", $lIIl11I, $aData); $ILLl1L1 =&createEshopExtensionObject($frn); $grandDiscount =0; $ILLl11I =0; while ($db->next_record()) {$qty =$db->Record[I18658]; $itemData =Array(); $itemId =$db->Record[I18653]; $itemData[I18641] =$itemId; $priceNumber =$db->Record["price_number"]; $db->Record["ext_data"] =$extData =unserialize($db->Record["ext_data"]); $priceCaptions =$extData["price_captions"]; $caption =$priceCaptions[$itemId][$priceNumber -1]; $price =$db->Record[I18659]; $_price =$extData['item_info']['original_price']; $priceTotal =$db->Record[I18659] *$qty; $price =$oEshop->formatMoney($price, $currency); $priceTotal =$oEshop->formatMoney($priceTotal, $currency); $itemData["name"] =$frn->TTITI1l("item", I18660, $extData[I18660]); $itemData["property_caption"] =TlTll11($extData["item_info"]["id_prop"], $ILLl1L1, $extData["item_info"][I18661], $frn->SetsTemplate); $itemData["quantity"] =$frn->TTITI1l("item", "quantity", $qty); $itemData[I18659] =$frn->TTITI1l("item", I18659, $price); $itemData[I18662] =$frn->TTITI1l("item", I18662, $priceTotal); if ($caption != "") {$itemData["price_caption"] =$frn->TTITI1l("item", I18663, $caption); }$itemData["owner_name"] =$db->Record["owner_name"]; if ($lLLI1Ll) {$itemData["owner"] =$frn->Words["order_owner_" .$db->Record[I18664]]; $itemData["owner"] =$frn->TTITI1l("item", "owner", $itemData); }if (isset($extData["item_info"][I18665])) {$itemData[I18665] =$frn->TTITI1l("item", I18665, $extData["item_info"][I18665]); }if (isset($extData["item_info"]["weight"])) {$itemData[I18666] =$frn->TTITI1l("item", I18666, $extData["item_info"][I18666]); $itemData["total_weight"] =$frn->TTITI1l("item", I18667, $extData["item_info"][I18666] *$qty); $ILLl11I += $extData["item_info"][I18666] *$qty; }if ($lLLI11L) {if(!empty($lLLlIII[$itemId])){ $aImage =$lLLlIII[$itemId]; $itemData['item_gallery_col'] =$frn->TTITI1l('item', I18668, $aImage); }else{ $itemData['item_gallery_col'] =$frn->TTITI1l('item', 'not_gallery_row', $itemData); }}if (isset($extData["item_info"][I18669])) {$d =$extData["item_info"][I18669]; $ad =$d; $grandDiscount += $ad; $op =$oEshop->formatNumber($_price, true, true); $itemData[I18669] =$oEshop->formatMoney($ad, $currency); $itemData["original_price"] =$oEshop->formatMoney($op, $currency); $itemData["percentage_discount"] =empty($extData["item_info"]["percentage_discount"]) ?"&nbsp;" :$extData["item_info"]["percentage_discount"]; $priceTotal =$_price *$qty -$d; $priceTotal =$oEshop->formatMoney($priceTotal, $currency); $itemData[I18662] =$frn->TTITI1l("item", I18662, $priceTotal); }else {$itemData[I18669] =$oEshop->formatMoney(0, $currency); $itemData[I18670] =$itemData[I18659]; $itemData["percentage_discount"] =0; }$oEshop->TT11lIT("order_history_list", $itemData, $db->Record); $lIIl11I["item_rows"] .= $frn->TTITI1l("item", I18671, $itemData); }$lLl1II1["item_list"] =$frn->TTITI1l("item", "list", $lIIl11I); }else {$lLl1II1["item_list"] =$frn->TTITI1l(I18672, "list_empty", ""); }$lLLI11I["grand_total_weight"] =$ILLl11I; $lLLI11I["grand_discount"] =$oEshop->formatMoney($grandDiscount, $currency); EventApplyVars($frn, I18673, $lLLI11I); $lLl1II1[I18646] =$frn->TTITI1l("order", "details", $lLLI11I); $oEshop->TT11T1T(); }else {$lLl1II1["item_list"] =$frn->TTITI1l(I18646, "empty", I18674); }$lLl1II1[I18640] =$offset; $lLl1II1["order_list_link"] =$frn->TTITI1l("order", "list_link", $lLl1II1); }else {if (empty($II111lL)) $II111lL ="body_order_list"; $lLl1II1[I18675] =$frn->Eshop->formatMoney(doubleval($frn->Member->getUserInfo("balance")), $frn->Eshop->baseCurrency, true, false); $ILLLIII["page_total"] =0; if ($frn->Core->IsInstalled("adv_places")) {if (!is_object($oOrder)) {require_once $GLOBALS['CLASSES_PATH'] .I18676; $oOrder =new EshopOrder(); $oOrder->aCurrency =&$frn->Eshop->aCurrency; }$lLLlII1 =array(); $sql ="select id, price, description, date from cms_adv_cash where lang='$lang' and id_member='$userId'"; $db->query($sql); while ($db->next_record()) {$lLLlII1[] =$db->Record[I18641]; $oOrder->create($frn, $oUser->GetUserInfo(I18641), $oUser->GetUserInfo("username"), 'user', 'accepted', $oUser->GetUserInfo("firstname"), $oUser->GetUserInfo(I18677), $oUser->GetUserInfo("company"), $oUser->GetUserInfo("email"), '', '', I18678, I18678, I18678, 0, 0, $db->Record[I18659], $lang, I18674, $db->Record["description"], false, $db->Record[I18645], true); }if (count($lLLlII1) >0) {$sql ="delete from cms_adv_cash where id in (" .implode(",", $lLLlII1) .")"; $db->query($sql); }}$lLLlIlI =AMI::getSingleton(I18679)->__get('ami_efe', FALSE) && AMI::checkAccessRights('eshop_order', 0, array('edit')); if($lLLlIlI){ $frn->Gui->mergeBlock( 'order_history', AMI_Skin::getPath('templates/eshop_order_list.tpl'), TRUE );$frn->Gui->mergeBlock( 'order_history', AMI_Skin::getPath('templates/list_icons.tpl'), FALSE );$frn->Gui->addGlobalVars(array('SKIN_TOOLS_USED' => TRUE)); $lLLlIll =empty($frn->Vars['ami_mod_view_type']) || I18680 != $frn->Vars['ami_mod_view_type']; if($lLLlIll){ $frn->Gui->addBlock( 'minimum_layout', AMI_Skin::getPath('templates/mod.tpl') );$aScope =array('mod_id' => 'eshop_order_history'); $IlL1lll['layout_body'] ="##init##\r\n" ."<body leftmargin=\"0\" topmargin=\"0\">\r\n" .$frn->Gui->get('minimum_layout:minimum_layout', $aScope) ."##lay_body_body##\r\n" ."</body>\r\n" ."##end##\r\n"; }$oFilter =new Filter( $frn, 'templates/filter_box.tpl', 'templates/filter_form_skin_tools.tpl' );$oFilter->SetDateFormat( array( I18681 => 'YYYY-MM-DD', 'php' => 'Y-m-d', 'db' => I18682 ));$aCaptions =$frn->Gui->ParseLangFile('templates/lang/filter.lng'); $oFilter->SetCaptions($aCaptions); $oFilter->AddField( 'datefrom', 'date', isset($frn->Vars['datefrom']) ?$frn->Vars[I18683] :I18678, $GLOBALS['ILllLII'], '>=', 'order_date', 'MIN' );$oFilter->AddField( I18684, 'date', isset($frn->Vars[I18684]) ?$frn->Vars[I18684] :I18678, $GLOBALS['ILllLIl'], '<=', 'order_date', I18685 );$value =isset($frn->Vars['flt_status']) ?$frn->Vars['flt_status'] :I18678; $aData =array(); $aData =$oFilter->TITI1TT( $aData, array($aCaptions['flt_status_all'] => I18678), 35 );foreach($lLLI1LL as $status){ $aData =$oFilter->TITI1TT($aData, array($frn->Words[$status] => $status),35); }$oFilter->AddField( 'flt_status', I18686, $value, I18678, '=', 'o.status', $aData );if(I18678 == $value){ $oFilter->DisableFieldSql('flt_status'); }$value =isset($frn->Vars['search_text']) ?$frn->Vars[I18687] :I18678; if(I18678 != $value){ $oFilter->AddField( $lLLlIll ?'other_search' :I18687, $lLLlIll ?'search' :'text', $value, I18678, 'like', I18688 );$oFilter->TITI1II( $lLLlIll ?'other_search' :I18687, " OR o.name LIKE '%" .addslashes($value) ."%' " ." OR o.firstname LIKE '%" .addslashes($value) .I18689 ." OR o.lastname LIKE '%" .addslashes($value) .I18689 ." OR o.username LIKE '%" .addslashes($value) .I18689 ." OR o.email LIKE '%" .addslashes($value) .I18689 ." OR o.custinfo LIKE '%" .addslashes($value) .I18689 ." OR o.sysinfo LIKE '%" .addslashes($value) .I18689 ." OR o.adm_comments LIKE '%" .addslashes($value) .I18689, 'force' );}$oFilter->AddField( 'ami_mod_view_type', 'hidden', I18680 );$oFilter->AddField( I18690, 'hidden', 100 );if($lLLlIll){ $ILLLIII['filter'] =$oFilter->GetFilterHtml(TRUE); }else{ $frn->Gui->isPrintable =FALSE; }}$filter ="WHERE " .($lLLlIlI ?"1" .$oFilter->GetFilterSql() :I18691 .$userId ."' AND o.status IN('" .implode(I18642, $lLLI1LL) ."')" );$sql ="SELECT o.id FROM " .$oEshop->dbTablePrefix .I18643 .$filter; $db->query($sql); $frn->Pager->MaxCount =$db->num_rows(); $lLLlIlL =$lLLlIlI ?'&' .$oFilter->GetFieldsAsUrlParams() :I18678; $frn->Pager->TI1TT1I(); $lll1lII =$frn->Pager->GetPager(); $pager =$frn->Pager->GetPagerHtml($lll1lII, $frn->ActiveScript .I18692 .$lLLlIlL); if ($frn->Pager->MaxCount) {if ($lLLI1Ll && !$lLLlIlI) {$ILLLIII["order_owner_header"] =$frn->TTITI1l("order", "owner_header", I18674); }if(!$lLLlIlI || !$lLLlIll){ $lLl1II1["pager"] =$pager; }$sql =I18651 ."o.id, (o.total+o.tax+o.shipping) AS amount, o.ext_data, o.status, o.name, " ."DATE_FORMAT(o.order_date,'" .$frn->DFMT["db"] ."') AS fdate, " ."o.adm_comments, owners, show_in_admin, `firstname`, `lastname`, `email` " .I18693 .$oEshop->dbTablePrefix .I18643 .$filter ." ORDER BY " .$frn->Pager->TI1TTlT() .", id asc  " .$frn->Pager->TI1TTlI(); $db->query($sql); $oEshop->pushCurrencyData(); $lLLlIl1 =0; while ($db->next_record()) {$lLLI11I =Array(); $lLLI11I[I18641] =$db->Record[I18641]; $lLLI11I['order_customer'] =$frn->Gui->get('order_history:order_customer', $db->Record); $lLLI11I[I18660] =$frn->TTITI1l(I18694, I18660, $db->Record[I18660]); $lLLI11I[I18645] =$frn->TTITI1l(I18694, I18645, $db->Record["fdate"]); $status =$frn->Words[$db->Record["status"]]; $lLLI11I["status"] =$frn->TTITI1l(I18694, "status", $status); $oExtData =unserialize($db->Record[I18695]); $currency =$oExtData["buy_currency"]["code"]; $lLLI11l =$oExtData[I18647]["code"]; $oEshop->setCurrencyData($oExtData["currency"], $lLLI11l); $ILLLIII[I18696] += $oEshop->convertCurrency($db->Record["amount"], $lLLI11l, $frn->Eshop->baseCurrency); $lLLI11I["amount"] =$oEshop->convertCurrency($db->Record["amount"], $lLLI11l, $currency); $lLLI11I["amount"] =$oEshop->formatMoney($lLLI11I[I18697], $currency, true, $db->Record["show_in_admin"]); $lLLI11I[I18697] =$frn->TTITI1l(I18694, I18697, $lLLI11I[I18697]); $lLLI11I["comments"] =$frn->TTITI1l(I18694, "comments", nl2br($db->Record["adm_comments"])); $lLLI11I[I18640] =$offset; $lLLI11I[I18698] =$frn->TTITI1l(I18694, I18698, $lLLI11I); $lLLI11I["has_details"] =$db->Record["show_in_admin"]; if($lLLlIlI){ $lLLlILI =array( I18655 => $db->Record[I18655], 'isCat' => 'false', I18699 => 'eshop_order', 'header' => AMI_Lib_String::jParse($db->Record['name']) );$lLLI11I['skin_tools_actions'] =$frn->Gui->get( 'order_history:icons_table', $lLLlILI );}if ($lLLI1Ll && !$lLLlIlI) {$aCloneOwners =explode(";", $db->Record["owners"]); $lLLlILl =sizeof($aCloneOwners) -2; $lLLI11I["order_owner_list"] =I18674; if ($lLLlILl >0) {$lLLlILL =true; $lLLI11I["order_owners"] =I18674; for ($lII11LL =1; $lII11LL <= $lLLlILl; $lII11LL++) {$aCloneOwners[$lII11LL] =$frn->Words[I18700 .$aCloneOwners[$lII11LL]]; $lLLI11I["order_owners"] .= $frn->TTITI1l(I18694, "owner", $aCloneOwners[$lII11LL]); if ($lLLlILL) {$lLLlILL =false; }else {$lLLI11I["order_owners"] .= $frn->TTITI1l(I18694, "owner_splitter", I18674); }}$lLLI11I[I18701] .= $frn->TTITI1l(I18694, "owner_list", $lLLI11I); }}EventApplyVars($frn, "body_order_list", $lLLI11I); $ILLLIII["order_rows"] .= $frn->TTITI1l(I18694, I18671, $lLLI11I); }$oEshop->TT11T1T(); $ILLLIII[I18696] =$oEshop->formatMoney($ILLLIII[I18696], $frn->Eshop->baseCurrency); $lLl1II1["order_list"] =$frn->TTITI1l(I18694, I18702, $ILLLIII); }else {$lLl1II1["order_list"] .= $frn->TTITI1l(I18694, "empty_list", I18674); }}}$lLlLlLI =$frn->Gui->get("order_history:$II111lL", $lLl1II1); $HtmlBody =I18680 != AMI::getSingleton('env/request')->get('ami_mod_view_type', FALSE) ?$frn->Gui->getAbs(I18703, "body", $lLlLlLI) :$lLlLlLI; require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; }}