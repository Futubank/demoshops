<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       19483 xkqwtixuysnyyymwymzrsxsttnmypmytsmgxygqipprknmyusinkutszlzlnpwypmwgxpnir
 */ ?><?php foreach(array(8141=>"",8142=>'',8143=>'QDOHG',8144=>"IuJtM|DMtQD",8145=>"DGJMttQr|GQrMHS",8146=>"frHI",8147=>"ZWtMHn",8148=>"WuDtHI",8149=>"DQJQWt",8150=>'WZJJYZWK',8151=>'fMQJSD',8152=>"CQJWHIQ",8153=>"nDGJMttQr|GrQfMx",8154=>"ZnnHunWQ",8155=>"DGQWMZJ|",8156=>'ZWtMvQ|DGQW|YJHWKD',8157=>"COQrQ",8158=>"MtQI|SZtZ",8159=>"YZWKUrJ",8160=>'HYLQWt',8161=>"WZJJYZWK",8162=>"DIZJJ|DGQWMZJ|rHC",8163=>"DIZJJ|DGQWMZJ|",8164=>"DGQWMZJ|ZnnHunWQ",8165=>"MS",8166=>"DuYJMnK",8167=>"DGQWMZJ",8168=>"WZt|MS",8169=>"OZD|GrHGD",8170=>"urJ",8171=>"DIZJJ|DGQWMZJ",8172=>"fMJtQr|fJZPD|IHSQ",8173=>"M",8174=>"MtQI|JMDt",8175=>"SZtZ",8176=>"'{?ZD?fSZtQ",8177=>"nZIQ",8178=>"WZWOQ|QxGMrQ|fHrWQ",8179=>"rZnS",8180=>"ZDW",8181=>"|",8182=>"DQJQWtQS",8183=>"WHrrQWtvZJuQ",8184=>"PQtZJJvZJuQD",8185=>"SZtQ",8186=>"vZJuQ") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ModuleEshopHome extends CMS_ActModule {public $IIllILI; public $I1IL1Ll; public $oEshop; public $I1LLl1I; public $lIIIl11; function ModuleEshopHome(&$cms, &$db, &$cModule) {parent::CMS_ActModule($cms, $db, $cModule); $this->I1IL1Ll =""; $this->I1LLl1I =""; $this->lIIIl11 =I8141; if($this->cms->Core->Side == "admin") {require_once $GLOBALS['CLASSES_PATH'] .'EshopAdmin.php'; $this->oEshop =new EshopAdmin($this->cms, $this->words); $this->oEshop->init($this->moduleName); }else {CreateEshop($cms); $this->oEshop =&$cms->Eshop; }}function _Init($IIll1l1 =Array(), $IIll1LI ='', $IIll1Ll =I8142, $aOptions =Array()) {$IIIIL11['default_prefix'] ='i'; $IIIIL11['multi_sites'] =true; $IIIIL11['picture_cat'] =I8143; $IIIIL11['hide_future_items'] =$this->cms->Core->GetModOption($this->oEshop->ownerName .'_item', 'hide_future_items'); $aOptions += $IIIIL11; parent::_Init($IIll1l1, $IIll1LI, $IIll1Ll, $aOptions); }function _InitAdmin() {parent::_InitAdmin(); $this->oEshop->init($this->moduleName); $this->oEshop->TT1l11l($this->options["multi_sites"], $this->siteId); }function TTTlTI1() {parent::TTTlTI1(); $this->oEshop->init($this->moduleName); $this->oEshop->TT1l11l($this->options[I8144], $this->siteId); $this->cms->SetsTemplate ="eshop_home_list"; }function TTTllTI(&$aCustom) {$this->SetBodyType("body_items"); }function TTTlllT(&$vData) {parent::TTTlllT($vData); $this->oEshop->TITTIIl($vData, $this->cms->SetsTemplate); }function TTTll1T(&$vData, &$aCustom) {$this->TTTlll1($this->oEshop->ownerName."_item"); foreach($this->IIllIL1 as $IIlL1L1 => $tmp) {$IIlL1Ll =$aCustom; $this->oEshop->ILLlllI =$IIlL1L1; switch($IIlL1L1) {case "body_items": $this->IIllILI =$this->oEshop->ILlLL1l->GetOption(I8145); $this->oEshop->ILLllI1 =$this->oEshop->ILlLL1l->GetOption("show_currency_signs"); $aDefault =Array(); $aDefault['page_item_type'] ='body_items'; $IIlL1Ll += $aDefault; $this->browser->PageSize =0; $addSql =Array("select"=>I8141, I8146=>I8141, "join"=>I8141, "where"=>I8141, "group"=>I8141, "order"=>I8141); $IIlLIIL =Array(I8147=>"add_extention_sql", "id"=>0, "item_data"=>I8141, "data"=>&$addSql, I8148=>&$IIlL1Ll); $this->TTT1lI1($IIlLIIL); $this->TIIlTIT($lIIILII, "front_page_sort_col", "front_page_sort_dim", "special_limit", ", i.description".$addSql[I8149].", i.adv_place"); $IIlL1Ll['fields']['other'] =Array('action'=>I8150, 'object'=>&$this, 'method'=>'_getRowCB'); if(is_array($lIIILII["fields"])) {$IIlL1Ll[I8151] += $lIIILII["fields"]; }$IIlL1Ll['row_set'] ="special_row"; $IIlL1Ll['list_set'] =I8152; $IIlL1Ll['list_data']["splitter_prefix"] ="special_"; $IIlL1Ll['list_data'][I8153] ="special_"; $IIlL1Ll['simple_set_fields'] =Array("fdate", "name", I8154, "description", "sku"); $IIlL1Ll['list_data']['simple_prefix'] =I8155; break; }parent::TTTll1T($vData, $IIlL1Ll); }}function TTTlIT1(&$aCustom, $cType ='small', $IIlLI11 =I8142, $IIlLlII ='_small') {if($this->module->issetOption('cache_l3_enable') && !$this->module->GetOption('cache_l3_enable')){ $this->cms->Core->Cache->TT1Tl1l($this->module->GetProperty(I8156)); }$this->cms->SetsTemplate ="eshop_home_list"; $this->TTTlll1($this->oEshop->ownerName."_item"); CreateCart($this->cms, $GLOBALS["oSession"]); $this->IIllILI =$this->oEshop->ILlLL1l->GetOption("small_splitter_period"); $this->oEshop->ILLllI1 =$this->oEshop->ILlLL1l->GetOption("small_show_currency_signs"); $this->TTT1I11(); $this->options["stop_use_sublinks"] =false; $res =parent::TTTlIT1($aCustom, $cType, $IIlLI11, $IIlLlII); $this->TTT1lTT(); return $res; }function TTTll1I(&$vRes, &$aCustom, $cType, $IIlLlII) {$this->oEshop->ILLlllI ='small_special_row'; $addSql =Array(I8149=>", i.id as adv_counter_id", I8146=>I8141, "join"=>I8141, I8157=>I8141, "group"=>I8141, "order"=>I8141); $IIlLIIL =Array(I8147=>"add_extention_sql", "id"=>0, I8158=>I8141, "data"=>&$addSql, I8148=>&$aCustom); $this->TTT1lI1($IIlLIIL); $this->TIIlTIT($aCustom, "small_items_sort_col", "small_items_sort_dim", "small_special_limit", $addSql[I8149]); $this->I1IL1Ll[I8159] =base64_encode($GLOBALS["vGlobVars"]["script_full_link"]); $aCustom[I8151]['other'] =Array('action'=>I8150, I8160=>&$this, 'method'=>'_getSmallRowCB'); if($this->TTT11ll($this->moduleName)) $aCustom["fields"]["adv_counter_id"] =Array(I8147=>I8161, "object"=>&$this, "method"=>"_GetSmallAdvCounter"); $aCustom['row_set'] =I8162; $aCustom['list_set'] ="on_special"; $aCustom['list_data']["splitter_prefix"] =I8163; $aCustom['list_data'][I8153] =I8163; $aCustom['simple_set_fields'] =Array("fdate", "name", I8154, I8164); $aCustom['list_data']['simple_prefix'] =I8163; $this->oEshop->TITTIIl($aCustom['list_data'], $this->cms->SetsTemplate); parent::TTTll1I($vRes, $aCustom, $cType, $IIlLlII); $this->I1IL1Ll =I8141; }function TTT1I1l() {return $this->IIllILI; }function _getRowCB(&$aItem, &$aData) {$aItem["itemid"] =$aItem[I8165]; $vNavData["catid"] =$aItem["cat_id"]; $vNavData["catid_sublink"] =$aItem["cat_sublink"]; $I11IllI =array ();$IIlLIIL =Array(I8147=>"get_if_dataset_has_props", I8165=>$aItem["dataset_id"], I8158=>&$I11IllI); $this->TTT1lI1($IIlLIIL); if($I11IllI["has_props"]) $this->oEshop->TITTT11(); if($this->oEshop->showDetailLink || !$aItem["descr_empty"]) {$vNavData[I8165] =$aItem[I8165]; $vNavData["id_sublink"] =$aItem[I8166]; }$vNavData =$this->cms->ApplyNav($vNavData); $aItem =array_merge($aItem, $vNavData); $aItem["base_price"] =$this->oEshop->TITTITI($aItem, $aItem, "special", "special"); $aItem["other_prices"] =$this->oEshop->TITTITl($aItem, $aItem, I8167, I8167); $this->oEshop->TT1111T("body_welcome", $aItem, $aItem); if($I11IllI["has_props"]) $this->oEshop->TITTITT(); }function _getSmallRowCB(&$aItem, &$aData) {$aItem["itemid"] =$aItem[I8165]; $vNavData["catid"] =$aItem[I8168]; $vNavData["catid_sublink"] =$aItem["cat_sublink"]; $I11IllI =array ();$IIlLIIL =Array(I8147=>"get_if_dataset_has_props", I8165=>$aItem["dataset_id"], I8158=>&$I11IllI); $this->TTT1lI1($IIlLIIL); if($I11IllI[I8169]) $this->oEshop->TITTT11(); if($this->oEshop->showDetailLink || !$aItem["descr_empty"]) {$vNavData[I8165] =$aItem[I8165]; $vNavData["id_sublink"] =$aItem[I8166]; }$vNavData =$this->cms->ApplyNav($vNavData); $aItem =array_merge($aItem, $vNavData); $aItem += array('tax_class_type' => null, 'id_tax_class' => null); $aItem[I8170] =$this->I1IL1Ll[I8159]; $aItem["base_price"] =$this->oEshop->TITTITI($aItem, $aItem, "small_special", "small_special"); $aItem["other_prices"] =$this->oEshop->TITTITl($aItem, $aItem, I8171, I8171); $this->oEshop->TT1111T("spec_body_welcome", $aItem, $aItem); if($I11IllI[I8169]) $this->oEshop->TITTITT(); }function TIIlTIT(&$lIIILII, $lIIILIl, $lIIILIL, $lIIILI1, $ILLILII =I8141) {$filter =I8141; $lIIILlI =$this->module->GetOption("num_extra_special_flags"); $lIIILll =((1 << ($lIIILlI +1)) -1); if($lIIILlI >0) {$lIIILlL =$this->module->GetOption("filter_flags"); $mask =0; foreach($lIIILlL as $i => $value) {$value =intval($value); $mask += (1 << $value); }$mask =sprintf("%u", $mask &$lIIILll); switch ($this->module->GetOption(I8172)) {case "like": $filter .= " AND (i.on_special& ".$mask.") <> 0"; break; case "equal": $filter .= " AND (i.on_special & ".$lIIILll.")=".$mask; break; case "have": $filter .= " AND (i.on_special & ".$mask.")=".$mask; break; }}else {$filter =" AND i.on_special=1"; }$lIIILl1 =$this->cms->Core->IsInstalled('ext_rating') ?"i.rate_opt, i.votes_rate, i.votes_count, i.votes_weight, " :I8142; $lIIILLI =$this->_ApplyFilters(I8142, I8142, !in_array('at_spec_block', $this->module->GetAOption('show_urgent_elements'))) .$filter .$this->oEshop->TITTIII(I8173); $addSql =Array(I8149=>I8141, I8146=>I8141, "join"=>I8141, I8157=>I8141, "group"=>I8141, "order"=>I8141); $lIIILLl =array('page_item_type' => I8174, "sql_type" => "home_fields", "sql_filter" => $lIIILLI); $IIlLIIL =Array(I8147=>"add_extention_sql", I8165=>0, I8158=>I8141, I8175=>&$addSql, I8148=>&$lIIILLl); $this->TTT1lI1($IIlLIIL); unset($lIIILLl); $lIIILII =$addSql; $this->browser->InitSQL("i.id, i.on_special, i.public, i.urgent, i.name, i.rest,i.weight,i.size, i.position, i.sublink, i.announce, i.special_announce, ". "i.price, i.price AS price0".$addSql[I8149]. ", date_format(i.date,'".$this->cms->DFMT["db"].I8176. $this->oEshop->getPriceFields("i.price%d, c.price_caption%d, SUBSTRING(c.price%d, INSTR(c.price%d, '#')+1, 3) AS currency%d, SUBSTRING(c.price%d, INSTR(c.price%d, ':')+1, 3) AS db_currency%d"). ", i.tax, i.tax_type, i.charge_tax_type, i.discount, i.discount_type, i.id_owner, ". "i.ext_small_picture, i.ext_picture, i.ext_popup_picture, i.lang, i.item_type, i.num_files, i.files_size, i.sku,".$lIIILl1. "c.id AS cat_id, c.sublink AS cat_sublink, c.id_discount, c.name AS category_name, c.has_props cat_has_props, ". "(LENGTH(i.description) = 0) AS descr_empty, c.public AS cat_public, c.dataset_id, c.dataset_data, c.adv_campaign_type".$ILLILII, "FROM ".$this->oEshop->dbTablePrefix."_items i INNER JOIN ".$this->oEshop->dbTablePrefix."_cats AS c ON i.id_category=c.id ", "WHERE i.id_source=0".$lIIILLI, I8141, I8177 );$this->browser->AddSQLJoinedTables($this->cms->Core, 'i', Array('c'=>$this->oEshop->dbTablePrefix."_cats")); $sortCol =$this->oEshop->ILlLL1l->GetOption($lIIILIl); $sortDim =$this->oEshop->ILlLL1l->GetOption($lIIILIL); if($sortCol == "rand" && $this->module->GetOption(I8178) == I8141) {$this->cms->Core->Cache->SetForceExpireTime($this->moduleName, strtotime("+1 minute")); }$lIIILLL =$this->isSmallMode && in_array('at_spec_block', $this->module->GetAOption('show_urgent_elements')) ?'i.urgent DESC, ' :I8142; if($sortCol == I8179) {$this->browser->SetForceRules("HAVING cat_public=1 ORDER BY RAND()", "LIMIT ".$this->oEshop->ILlLL1l->GetOption($lIIILI1)); }else {$lIIILL1 =$this->oEshop->ILlLL1l->TTlT1T1(); if(!in_array($sortCol, $lIIILL1)) {$sortCol =I8177; }if(!in_array($sortDim, array("asc", "desc"))) {$sortDim =I8180; }$this->browser->SetForceRules("HAVING cat_public=1 ORDER BY " .$lIIILLL .$sortCol." ".$sortDim, "LIMIT ".$this->oEshop->ILlLL1l->GetOption($lIIILI1)); }if($this->isSmallMode) {$specName =$this->module->GetProperty("active_spec_blocks"); }else {$specName =$this->oEshop->ownerName; }$this->cms->Core->Cache->TT1TI1T($specName.I8181.$lIIILIl, $sortCol); }function getOptionsModColsCB($cData, $IIL1lL1, &$res, &$aData, $IIL1l1I ="getallvalues"){ $lIIILlI =$this->module->GetOption("num_extra_special_flags"); switch($IIL1l1I){ case "getallvalues": $res =Array(); if(!is_array($this->I1LLl1I)) {$this->I1LLl1I =$this->cms->Gui->ParseLangFile($GLOBALS["LOCAL_FILES_REL_PATH"]."_admin/templates/lang/".$this->oEshop->ownerName."_home.lng"); $this->I1LLl1I += $this->cms->Gui->ParseLangFile("templates/lang/".$this->oEshop->ownerName."_home.lng"); }$res[] =array( I8177 => 0, "caption" => $this->I1LLl1I[I8167], I8182 => (in_array(0, $cData["value"]) ?I8182 :I8141) );for($i =1; $i <= $lIIILlI; $i++) {$res[] =array( I8177 => $i, "caption" => $this->I1LLl1I["special_flag_".$i], I8182 => (in_array($i, $cData["value"]) ?I8182 :I8141) );}break; case I8183: $lIIIL1I =Array(); for($i =0; $i <= $lIIILlI; $i++) {$lIIIL1I[] =$i; }if(is_array($cData["value"])) {$res =array_intersect($cData["value"], $lIIIL1I); }else {$res =Array(); }break; case "getvalue": $res =$cData["value"]; break; }return true; }function getOptionsSortColCB($cData, $IIL1lL1, &$res, &$aData, $IIL1l1I =I8184){ $lIIILlI =$this->module->GetOption("num_extra_special_flags"); switch($IIL1l1I){ case I8184: $res =Array(); if(!is_array($this->lIIIl11)) {$this->lIIIl11 =$this->cms->Gui->ParseLangFile("templates/lang/options/".$this->oEshop->ownerName."_home_rules_values.lng"); $this->lIIIl11 += $this->cms->Gui->ParseLangFile("templates/lang/options/default_rules_values.lng"); }foreach(Array(I8185, I8177, "price", "sku", "position", I8179) as $field) {if(array_key_exists($field, $this->lIIIl11)) {$caption =$this->lIIIl11[$field]; }$res[] =array( I8177 => $field, "caption" => $this->lIIIl11[$field], I8182 => ($field == $cData[I8186]) ?I8182 :I8141 );}break; case I8183: $res =$cData[I8186]; break; case "getvalue": $res =$cData[I8186]; break; case "apply": if($cData[I8186] == I8179) {$this->module->SetOption(I8178, "+1 minute"); }else {$this->module->SetOption(I8178, I8141); }break; }return true; }function TTTlll1($moduleName) {if ($this->isSmallMode) {$moduleName =$this->oEshop->ownerName .'_item'; }parent::TTTlll1($moduleName); }}