<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       45758 xkqwxussgzxguuugkptxlmztuwymptqwxkpuqnuiryytqxrizgurkwqywgssnwwtiwispnir
 */ ?><?php foreach(array(1312=>"MS|WZt",1313=>"|JMDt",1314=>"WZtMS|vZrnZIQ",1315=>"MS|GZPQ|GrQfMx",1316=>"WZt|IHSuJQ|nZIQ",1317=>"ZWtMHn",1318=>"frHnt",1319=>"`MS!?",1320=>'GuDO',1321=>'DtMWKB',1322=>"?coqRq?1",1323=>'GHG',1324=>"",1325=>'fWMS',1326=>"MS",1327=>'',1328=>'ZWtMHn',1329=>'fJt|fMQJS|nZIQ',1330=>'WZtQPHrB',1331=>"MS|GZPQD|rHCD",1332=>"MS|GZPQ|DQJQWtYHx",1333=>"`",1334=>"=",1335=>"frHnt|MtQI|JMDt",1336=>"`MS?zd?WZt|MS",1337=>"?jqFT?lhmN?",1338=>"uDQ|MS|GZPQ",1339=>"!?",1340=>"?zd?",1341=>"COQrQ",1342=>"WZt|MS",1343=>"'",1344=>"JZnP",1345=>"rQS",1346=>"YJuQ",1347=>"nZIQ",1348=>'WZtnZIQ',1349=>"ZSS",1350=>"ru",1351=>'wZtQPHrB?WrQZtMHn?fZMJQS?fHr?IHSuJQ%?',1352=>"-1",1353=>"GuYJMW",1354=>"Hn",1355=>"coqRq?MS='",1356=>"?coqRq?",1357=>"MS='",1358=>'|DEJ',1359=>'DMIGJQ|DQt|fMQJSD',1360=>"GZPQ|MtQI|tBGQ",1361=>"WZtD|IHSuJQ|nZIQ",1362=>'YHSB|urPQnt|WZtD',1363=>"`YHSB!?",1364=>"1?",1365=>"ZnnHunWQ",1366=>"WZJJYZWK",1367=>'SZtZ',1368=>"HYLQWt",1369=>"|mnMtyBiHSuJQNZIQwy",1370=>"IHSuJQ|nZIQ",1371=>"GZrZID",1372=>"MtQI|GMWturQD",1373=>'Qxt|rZtMnP',1374=>'!?',1375=>"WZt|YHSB",1376=>"WZt|DuYJMnK",1377=>'MtQI|',1378=>"nZIQ|fMQJS|nZIQ",1379=>'Qxt|MIZPQD',1380=>'Qxt|',1381=>"iHSuJQotIJ",1382=>"OQZSQrD",1383=>"WZt|JMnK",1384=>"|JMDt%WZt|JnZIQ",1385=>'YHSB',1386=>"-",1387=>"`MS='",1388=>"WZtMS|DuYJMnK",1389=>"dqjqwT?",1390=>"WZt|nZIQ") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class CMS_CategoriesFunctions extends CMS_CategoriesFunctionsStub{ public $moduleName; public $langData; public $IILLLl1; public $IILLLLI; public $catId; public $IILLLLl; public $IILLLLL; public $catSubLink; public $varName; public $IILLLL1; public $IILLL1I; public $IILLL1l; public $IILLL1L; public $IILLL11; public $IILL1II; public $IILL1Il; public $IILL1IL; public $IILL1I1; public $IILL1lI; public $IILL1ll; public $IILL1lL; public $IILL1l1; public $IILL1LI; public $IILL1Ll; public $IILL1LL; protected $IILL1L1; function CMS_CategoriesFunctions(&$cms, &$oModule, $IILL11I, $IILL11l ="_categories_items_list.tpl", $IILL11L ="_categories_items_form.tpl") {$this->IILL1L1 =FALSE; parent::CMS_CategoriesFunctionsStub($cms, $oModule, $IILL11I); $this->moduleName =$this->module->moduleName; $this->IILLL1I =I1312; $this->IILLL1l ="c"; $this->langData =$cms->lang_data; $this->IILLLl1 =$this->IILI1LI->GetTableName(); $this->IILL1IL =Array(); $this->IILL1I1 =false; $this->IILLL11 =false; $this->IILL1II =false; $this->IILL1Il ="_DrawSubItemsCB"; $this->IILL1lI ="_ApplyFilters"; if($this->cms->Core->Side == "admin") {$this->cms->Gui->mergeBlock($this->moduleName.I1313, $oModule->IIlll11.$IILL11l, true); $this->cms->Gui->mergeBlock($this->moduleName."_subform", $oModule->IIlll11.$IILL11L, true); }$this->IILL1LI =false; $this->IILL1Ll =$this->cms->Core->TTlI1IT($IILL11I, "use_special_list_view") && ('admin' != $this->module->side ?!$this->module->db->attr('multi_user') :TRUE); $this->IILL1LL =$this->IILL1Ll ?$this->cms->Core->getModOption($IILL11I, 'show_urgent_elements') :array ();$this->IILL1lL =false; $this->IILL1l1 =false; }function _Init() {$this->catId =$this->module->catId; $this->IILLLLl =$this->catId; $this->catSubLink =""; $this->IILLLL1 =""; if($this->cms->Core->Side == "admin") {$this->varName ="cat_id"; }else {$this->varName =$this->module->options[I1314]; $this->IILLL11 =$this->IILI1LI->GetOption("show_empty_cats"); }$this->IILLLLI =$this->module->module->GetTableName(); $this->IILL1ll =$this->module->options["use_id_page"]; $this->module->options["use_id_page"] =false; $this->IILLL1L =$this->module->options["default_prefix"]; $this->module->options[I1315] =$this->IILLL1l."."; $this->module->options["cat_default_prefix"] =$this->module->options[I1315]; $this->module->options["cat_name_field_name"] ="name"; $vData =Array(I1316 => $this->catModuleName); $IIlLIIL =Array(I1317=>"init_cat_functions", "item_data"=>&$vData); $this->module->TTT1lI1($IIlLIIL); $this->IILLLLL =0; }function TTIT1IT($methodName) {$this->IILL1lI =$methodName; }function TTIT1II($useSpecialListView) {$this->IILL1Ll =$useSpecialListView; }function _ApplyFilters($prefix ='', $bodyType ='', $IIlLLl1 =true) {$res =$this->module->{$this->IILL1lI}($this->IILLL1l, $bodyType, $IIlLLl1); if($this->module->side == I1318) {if(!$this->IILLL11) {$res .= " AND num_public_items>0"; }}else {}return $res; }function TTIT1Il() {if(!$this->IILL1I1) {$this->IILL1IL =Array(); $this->IILL1I1 =true; $db =new DB_si; $IILL111 =$this->IILI1LI->Engine ?$this->IILI1LI->Engine->IIll1lL['header'] :'name'; $sql ="SELECT ".$this->IILLL1l.I1319.$this->IILLL1l."." .$IILL111 ." name"; if($this->IILL1ll) {$sql .= ", ".$this->IILLL1l.".id_page"; }$this->module->TTITTTI(I1320); $IIL1III =''; if( $this->IILI1LI->IssetAndTrueProperty('use_special_list_view') && ('admin' != $this->module->side ?!$this->module->db->attr('multi_user') :TRUE) ){$order =$this->IILI1LI->Engine && $this->IILI1LI->Engine->IIll1lL[I1321] ?$this->IILI1LI->Engine->IIll1lL[I1321] :'urgent'; $order .= ' DESC,'; }$sql .= " FROM ".$this->IILLLl1." AS ".$this->IILLL1l.I1322.$this->_ApplyFilters('', 'cats_selectbox', false) ." ORDER BY " .$order .'name'; $this->module->TTITTTI(I1323); $db->query($sql); while($db->next_record()) {$this->IILL1IL[] =$db->Record; }}}function TTTlIII($fieldName) {$this->TTIT1Il(); $this->IILLLL1 =$fieldName; $num =sizeof($this->IILL1IL); $aCats =Array(); for($i=$num-1; $i>=0; $i--) {$aPageData =$this->IILL1IL[$i]; $aCats =$this->module->filter->TITI1TT($aCats, Array($this->IILL1IL[$i]["name"]=>$this->IILL1IL[$i]["id"]), 45, false); }$aCats =$this->module->filter->TITI1TT($aCats, Array($this->module->words["all"]=>0), 45, false); if(isset($this->cms->VarsPost[$this->varName]) && $this->cms->VarsPost[$this->varName] != $this->cms->VarsPost[$fieldName] && $this->cms->VarsPost[$fieldName] >0) {$IIL1IIl =0; }else {$IIL1IIl =isset($this->cms->Vars[$fieldName]) ?intval($this->cms->Vars[$fieldName]) :0; }$this->module->filter->AddField($fieldName, "select", $IIL1IIl, I1324, "=", $this->module->options["default_prefix"].$this->IILLL1I, $aCats); if(empty($IIL1IIl)) {$this->module->filter->DisableFieldSQL($fieldName); }return true; }function TTIT1I1(&$vData, $blockName =I1324) {if($blockName == I1324) {$blockName =$this->moduleName."_subform"; }$this->TTIT1Il(); $vData["categories_rows"] =I1324; $num =sizeof($this->IILL1IL); if(!empty($this->cms->Vars[I1325])){ $vData[$this->IILLL1I] =(int)$this->cms->Vars[I1325]; }$cid =isset($this->cms->Vars['cid']) ?(int)$this->cms->Vars['cid'] :0; if(isset($vData[$this->IILLL1I])){ $IIL1IIL =(int)$vData[$this->IILLL1I]; }elseif(!$cid){ $IIL1IIL =$this->IILLLL1 != '' ?$this->module->filter->GetFieldValue($this->IILLLL1) :0; }else{ $IIL1IIL =$cid; }if($num >0) {for($i=0; $i<$num; $i++) {$aPageData =$this->IILL1IL[$i]; $aPageData["selected"] =($IIL1IIL == $aPageData[I1326])? "selected": I1324; $vData["categories_rows"] .= $this->cms->Gui->get($blockName.":category_row", $aPageData); }$vData["categories_rows"] =$this->cms->Gui->get($blockName.":categories_selectbox", $vData); }else {$vData["categories_rows"] =$this->cms->Gui->get($blockName.":categories_empty_selectbox", $vData); }$vData['new_category_required'] =$num == 0 ?'*' :I1327; $vData["categories_field"] =$this->cms->Gui->get($blockName.":categories_field", $vData); $vData["categories_js"] =$this->cms->Gui->get($blockName.":categories_js", $vData); return $num; }function TTTlI11(&$vData, &$aCustom) {$IIlLIIL =array(I1328 => 'fill_cat_admin_data', 'data' => &$vData, 'custom' => &$aCustom); $this->module->TTT1lI1($IIlLIIL); $tmp =$vData +$aCustom["list_data"]; $tmp[I1329] =$this->IILLLL1; $aCustom["list_data"]["category_list_header"] =$this->cms->Gui->get($this->moduleName."_list:category_list_header", $tmp); $aCustom['fields'] += Array(I1330=>Array(I1328=>'callback', 'object'=>&$this, 'method'=>'_CategoryRowCB')); if($this->IILL1ll) {$vData[I1331] =$this->cms->Gui->getAbs($this->moduleName."_subform:id_page_row", Array(I1326=>0, "name"=>$this->module->words["common_item"])); foreach($this->module->IIllll1 as $pageId=>$aPageData) {$vData[I1331] .= $this->cms->Gui->get($this->moduleName."_subform:id_page_row", $aPageData); }$vData[I1332] =$this->cms->Gui->get($this->moduleName."_subform:id_page_selectbox", $vData); }$this->TTIT1I1($vData); }function TTIT1lT($IIL1II1, &$result) {$IIL1II1 =$this->cms->Core->Side."_".$IIL1II1; parent::TTIT1lT($IIL1II1, $result); if(!empty($result["join_to_alias"])) {$IIL1IlI =$result["join_to_alias"]; }else {$IIL1IlI =str_replace(I1333, I1324, $this->IILLL1L); }$result["tables"] =Array($this->IILLL1l=>$this->IILLLl1); switch($IIL1II1) {case "admin_item_list": $result["select"] =", ".$this->IILLL1l.".name AS category_name, " .$this->IILLL1l.".id" ." AS id_category"; $result["joins"] =Array($IIL1IlI."|".$this->IILLL1l=>$this->IILLL1L.$this->IILLL1I.I1334.$this->IILLL1l.".id"); $result["order_replace"] =Array("category_name"=>$this->IILLL1l.".name"); break; case I1335: case "front_item_details": $result["join"] =I1324; $result["where"] =" AND ".$this->IILLL1L.$this->IILLL1I.I1334.$this->catId; break; case "front_item_filtered": $result["select"] =", ".$this->IILLL1l.".name AS cat_name, ".$this->IILLL1l.".sublink AS cat_sublink, ".$this->IILLL1l.I1336; if($this->IILL1ll) {$result["select"] .= ", ".$this->IILLL1l.".id_page"; }$result["join"] =I1337.$this->IILLLl1." AS ".$this->IILLL1l." ON ".$this->IILLL1l.".id=".$this->IILLL1L.$this->IILLL1I; $tmp =$this->module->options["use_id_page"]; $this->module->options[I1338] =$this->IILL1ll; $result["where"] =$this->_ApplyFilters(I1324, "body_cats"); $this->module->options[I1338] =$tmp; break; case "front_small_list": $result["select"] =I1339.$this->IILLL1l.".name AS cat_name, ".$this->IILLL1l.".sublink AS cat_sublink, ".$this->IILLL1l.".id AS id_cat"; $result["join"] =I1337.$this->IILLLl1.I1340.$this->IILLL1l." ON ".$this->IILLL1l.".id=".$this->IILLL1L.$this->IILLL1I; $result["where"] =$this->_ApplyFilters(I1327, I1327, false); break; case "admin_import_files": $result[I1341] =" AND ".$this->IILLL1L.$this->IILLL1I.I1334.$this->catId; break; }}function _CategoryRowCB(&$aItem, &$aData) {$aItem["category_col"] =$this->cms->Gui->get($this->moduleName."_list:category_list_col", $aItem); }function TTT1Tl1($cType, $cModule) {$res =false; switch($cType) {case "move_to_cat": $IIL1IlI =str_replace(I1333, I1324, $this->IILLL1L); if(!empty($IIL1IlI)) {$IIL1IlI =I1340.$IIL1IlI; }$IIL1Ill =0; $IIL1IlL =0; $sql ="SELECT SUM(public) AS public_items, COUNT(id) AS all_items FROM ".$this->IILLLLI.$IIL1IlI." WHERE ".$this->IILLL1L.$this->IILLL1I."=0".$this->module->_ApplyFilters(); $this->module->db->query($sql); if($this->module->db->next_record()) {$IIL1IlL =$this->module->db->Record["all_items"]; $IIL1Ill =intval($this->module->db->Record["public_items"]); }if($IIL1IlL >0) {if(!isset($this->cms->Vars[I1342]) || (isset($this->cms->Vars[I1342]) && $this->cms->Vars[I1342] >0)) {$catId =$this->cms->Vars[I1342]; $sql ="SELECT ".$this->IILLL1l.I1319.$this->IILLL1l.".name FROM ".$this->IILLLl1.I1340.$this->IILLL1l." WHERE ".$this->IILLL1l.".id='".$catId.I1343.$this->_ApplyFilters($this->IILLL1l); $this->module->db->query($sql); $IIL1Il1 =false; if($this->module->db->next_record()) {$catName =$this->module->db->Record["name"]; }else {$catId =0; $catName =$this->module->words["repaired_items_cat"]; $aSql =Array( "name"=>$catName, "public"=>0, I1344=>$this->module->langData );$sql =$this->module->db->GenInsertSQL($this->IILLLl1, $aSql); if($this->module->db->query($sql)) {$catId =$this->module->db->lastInsertId(); $this->cms->AddStatusMsg("status_create_category", "blue", I1324, I1324, Array("name"=>$catName)); $IIL1Il1 =true; }else {$this->cms->AddStatusMsg("status_create_category_fail", I1345, I1324, I1324, Array("name"=>$catName)); }}if($catId >0) {$aSql =Array($this->IILLL1I=>$catId); $sql =$this->module->db->GenUpdateSQL($this->IILLLLI.$IIL1IlI, $aSql, "WHERE ".$this->IILLL1I."=0".$this->module->_ApplyFilters()); if($this->module->db->query($sql)) {$numItems =$this->module->db->affected_rows(); $this->cms->AddStatusMsg("status_items_moved", I1346, I1324, I1324, Array("name"=>$catName, "num_items"=>$numItems.I1324)); $all =I1324; $IIL1ILI =I1324; if($numItems >0) {$all ="+".$numItems; }if($IIL1Ill >0) {$IIL1ILI ="+".$IIL1Ill; }$this->TTIT11l($catId, $IIL1ILI, $all); }else {$this->cms->AddStatusMsg("status_items_moved_fail", I1345, I1324, I1324, Array("name"=>$catName)); if($IIL1Il1) {$sql ="DELETE FROM ".$this->IILLLl1." WHERE id='".$cat_id.I1343; }$this->cms->AddStatusMsg("status_delete_category", I1346, I1324, I1324, Array(I1347=>$catName)); }}}}else {$this->cms->AddStatusMsg("status_no_repair_items", I1346); }$res =true; break; }return $res; }function TTT1IlI(&$aSql, $cId, $IIL1ILl =true) {$this->IILLLLl =$this->catId =isset($this->cms->VarsPost[$this->varName]) ?intval($this->cms->VarsPost[$this->varName]) :0; if(!empty($this->cms->VarsPost["catname"])) {$field =$this->IILI1LI->Engine ?$this->IILI1LI->Engine->IIll1lL['header'] :'name'; $IIL1ILL =Array( $field => $this->cms->VarsPost[I1348], 'public' => 1, 'lang' => $this->langData );if($this->IILL1ll) {$IIL1ILL["id_page"] =$this->cms->VarsPost["id_page"]; }$tmp =&$this->module->module; $this->module->module =&$this->IILI1LI; $this->module->TTT11TT($IIL1ILL, 0, I1349); if (empty($this->IILL1lL)) {$IIL1ILL["position"] =$this->module->TTTl1TI(); }$this->module->module =&$tmp; $sql =$this->module->db->GenInsertSQL($this->IILI1LI->GetTableName(), $IIL1ILL); $this->catId =0; if($this->module->db->query($sql)) {$this->catId =$this->module->db->lastInsertId(); if($this->catId >0) {$this->IILL1LI =true; $this->cms->AddStatusMsg("status_create_category", I1346, I1324, I1324, Array(I1347=>$this->cms->VarsPost["catname"])); if (empty($this->IILL1l1)) {$this->catSubLink =$this->cms->TTTTllI($this->cms->VarsPost["catname"], $this->catId, I1324, ($this->langData==I1350)?true:false); $IIL1ILL =Array("sublink"=>$this->catSubLink); $sql =$this->module->db->GenUpdateSQL($this->IILI1LI->GetTableName(), $IIL1ILL, "WHERE id='".$this->catId.I1343); $this->module->db->query($sql); }}}}if($this->catId >0) {$aSql[$this->IILLL1I] =$this->catId; if($this->module->action == "apply") {$this->IILLLLL =$this->catId; $this->TTIT111($cId); }}else {trigger_error(I1351.$this->moduleName ,E_USER_WARNING); if($IIL1ILl) {$aSql =Array(); }}$this->TTIT1Il(); }function TTIT1lI($aSql, $cId) {$this->catId =intval($this->cms->VarsPost[$this->varName]); if($this->catId >0) {$aSql[$this->IILLL1I] =$this->catId; }return $aSql; }function TTIT1ll($cId, $cModule, $IIL1IL1 =I1324, $catId =I1324) {if($IIL1IL1 == I1324 || $catId == I1324) {$this->TTIT111($cId); }else {$this->catId =$catId; $this->IILL1II =$IIL1IL1; }}function TTIT1l1($catId) {$IIL1ILI =intval($this->cms->VarsPost["public"]); if($IIL1ILI) {$public =I1352; }$all =I1352; $this->TTIT11l($catId, $public, $all); }function TTIT11T($catId) {if($this->IILL1II) {$public ="-1"; }else {$public =I1324; }$this->TTIT11l($catId, $public, "-1"); }function TTTll11($cId, $cModule) {if ($this->module->options['check_public']) {$this->TTIT1l1($this->catId); }}function TTTl1lI($cId, $cModule) {if ($this->module->options['check_public']) {$public =intval($this->cms->VarsPost[I1353]); if ($this->IILLLLL) {$this->IILLLLl =$this->IILLLLL; $this->IILLLLL =0; }if($this->catId != $this->IILLLLl) {$this->TTIT11T($this->catId); $this->TTIT1l1($this->IILLLLl); }else {$this->TTIT11I($this->catId, $public, $this->IILL1II); }}}function TTIT11I($catId, $public, $oldPublic) {$IIL1I1I =I1327; if($public && !$oldPublic) {$IIL1I1I =I1352; }elseif(!$public && $oldPublic) {$IIL1I1I ="-1"; }$this->TTIT11l($catId, $IIL1I1I); }function _ActionDel($cId, $cModule, $IIL1IL1 =I1324) {if ($this->module->options['check_public']) {$this->TTIT11T($this->catId); }}function _ActionPublish($cId, $cModule) {if ($this->module->options['check_public']) {$public =($this->cms->Vars["publish"]==I1354); $this->TTIT11I($this->catId, $public, $this->IILL1II); }}function TTIT11l($catId, $public, $all =I1324) {if($catId >0) {$aSql =Array(); if(!empty($public)) {$aSql["num_public_items"] ="=|num_public_items".$public; }if(!empty($all)) {$aSql["num_items"] ="=|num_items".$all; }if(sizeof($aSql) >0) {$sql =$this->module->db->GenUpdateSQL($this->IILLLl1, $aSql, I1355.$catId.I1343); $this->module->db->query($sql); }}}function TTIT111($cId) {$IIL1IlI =str_replace(I1333, I1324, $this->IILLL1L); $sql ="SELECT ".($this->module->options['check_public'] ?$this->IILLL1L .'public, ' :I1327) .$this->IILLL1L.$this->IILLL1I." FROM ".$this->IILLLLI.I1340.$IIL1IlI.I1356.$this->IILLL1L."id='".$cId.I1343.$this->module->_ApplyFilters(); $this->module->db->query($sql); if($this->module->db->next_record()) {$this->catId =$this->module->db->Record[$this->IILLL1I]; $this->IILL1II =$this->module->options['check_public'] ?$this->module->db->Record[I1353] :1; }}function TTTllTI(&$aCustom) {if($this->catId == -2) {$IIL1IlI =str_replace(I1333, I1324, $this->IILLL1L); $sql ="SELECT ".$this->IILLL1L.$this->IILLL1I." FROM ".$this->IILLLLI.I1340.$IIL1IlI.I1356.$this->IILLL1L.I1357.$this->module->id.I1343.$this->module->_ApplyFilters(); $this->module->db->query($sql); if($this->module->db->next_record()) {$this->catId =$this->module->db->Record[$this->IILLL1I]; }}return $this->catId; }function TTTll1T(&$vData, &$aCustom) {$res =false; $select =empty($aCustom['_sql']['select']) ?I1327 :$aCustom['_sql']['select']; $join =empty($aCustom[I1358]['join']) ?I1327 :$aCustom[I1358]['join']; $group =empty($aCustom[I1358]['group']) ?I1327 :$aCustom[I1358]['group']; if(!isset($aCustom[I1359]) || !is_array($aCustom[I1359])){ $aCustom[I1359] =array(); }if(!isset($aCustom['fields']) || !is_array($aCustom['fields'])){ $aCustom['fields'] =array(); }$IIL1I1l =false; if(isset($aCustom["isAdvertisementSupported"]) && $aCustom["isAdvertisementSupported"]){ $IIL1I1l =true; }$IIL1I1L =$this->module->options['use_special_list_view'] && ('admin' != $this->module->side ?!$this->module->db->attr('multi_user') :TRUE); $this->module->options["use_special_list_view"] =$this->IILL1Ll; switch($aCustom[I1360]) {case "body_cats": case 'body_urgent_cats': $this->module->options[I1338] =$this->IILL1ll; $aCustom[I1361] =$this->IILI1LI->GetName(); $this->module->TTTllll($vData, $aCustom); $IIL1I11 =false; if ($this->module->options['use_special_list_view'] && $aCustom['page_item_type'] == I1362) {$IIL1I11 =$this->module->browser->getActivePage() ?!in_array('at_next_pages', $this->IILL1LL) :!in_array('at_first_page', $this->IILL1LL); }$this->module->browser->InitSQL($this->IILLL1l.I1319.$this->IILLL1l.".name, ". $this->IILLL1l.".announce, ".$this->IILLL1l.I1363. $this->IILLL1l.".sublink, ".$this->IILLL1l.".num_public_items AS num_items".$select, "FROM ".$this->IILLLl1.I1340.$this->IILLL1l.$join, "WHERE " .($IIL1I11 ?0 :I1364.$this->_ApplyFilters(I1327, $aCustom['page_item_type']).$this->module->TTTlIl1()), $group, I1324, I1326, Array("num_public_items"=>"num_items") );$aCustom["simple_set_fields"] += Array(I1365, "body", "num_items"); $aCustom["fields"] += Array("cat_name"=>Array(I1317=>I1366, "object"=>&$this, "method"=>"_GetCategoryCB")); if (is_object($this->IILI1LI->Engine) && $this->IILI1LI->Engine->IIL1LI1) {$IIlLIIL =array (I1328 => 'fill_front_data', I1367 => &$vData, 'custom' => &$aCustom); $this->IILI1LI->Engine->TTT1lI1($IIlLIIL); }if ($this->module->options['use_special_list_view'] && $aCustom['page_item_type'] == I1362) {$this->module->browser->lll1IIl =0; $this->module->browser->Position =0; $this->module->browser->PageSize =0; }if(isset($this->module->I1LIIl1) && $this->module->I1LIIl1 >-1) {$this->module->options[I1338] =false; $this->module->browser->ProcessSQL($this->module->db); $numRows =$this->module->db->num_rows(); if($numRows>0) {$IIL1lII =Array(); while($this->module->db->next_record()) {$IIL1lII[] =$this->module->db->Record[I1326]; }$this->module->options["use_special_list_view"] =$IIL1I1L; $this->module->TIITIl1($IIL1lII, $aCustom[I1360]); $this->module->options["use_special_list_view"] =$this->IILL1Ll; $aCustom["fields"] += Array("subitems"=>Array(I1317=>"acallback", "callbacks"=>Array( Array(I1368=>&$this->module, "method"=>I1369, "params"=>Array(I1370=>$this->moduleName)), Array(I1368=>&$this->module, "method"=>$this->IILL1Il), Array(I1368=>&$this->module, "method"=>I1369, I1371=>Array(I1370=>$this->IILI1LI->GetName())) )));}}break; case "body_browse": case "body_items": case 'body_urgent_items': case "body_itemD": $this->module->options[I1338] =$this->IILL1ll; $IIL1lIl =$this->module->options[I1372]; $this->module->options["use_special_list_view"] =false; if($this->IILI1LI->IssetOption(I1372)) {$this->module->options[I1372] =$this->IILI1LI->GetOption(I1372); foreach($this->module->options[I1372] as $picName) {if(!empty($picName) && $picName != 'null' && $picName != -222222){ $select .= I1339.$this->IILLL1l.".ext_".$picName; }}}else {$this->module->options[I1372] =Array(); }if(isset($this->module->ext['ext_rating']) && $this->module->ext[I1373]->catRatingsEnabled) {$IIL1lIL =array('rate_opt', 'votes_rate', 'votes_count', 'votes_weight'); foreach($IIL1lIL as $field){ $select .= I1374 .$this->IILLL1l .'.' .$field; }}$this->module->TTITTTI(I1320); $sql ="SELECT ".$this->IILLL1l.".id AS cat_id,".$this->IILLL1l.".sublink AS cat_sublink,".$this->IILLL1l.".name AS cat_name, ".$this->IILLL1l.".announce AS cat_announce, ".$this->IILLL1l.".body AS cat_body, ".$this->IILLL1l.".sm_data, ".$this->IILLL1l.".details_noindex ".$select.($IIL1I1l ?I1339.$this->IILLL1l.".adv_place as cat_adv_place" :I1324)." FROM ".$this->IILLLl1.I1340.$this->IILLL1l.$join." WHERE id='".$this->catId.I1343.$this->_ApplyFilters(); $this->module->TTITTTI(I1323); $this->module->options[I1338] =false; $this->module->db->query($sql); if($this->module->db->next_record()) {$res =true; $this->module->IIllILl =Array("cat_name", "cat_announce", I1375); $this->TTIITTT($this->module->db->Record, 'cat_'); $vData += $this->module->db->Record; $aCustom["list_data"][I1342] =$this->module->db->Record[I1342]; $aCustom["list_data"]["cat_sublink"] =$this->module->db->Record[I1376]; if(empty($aCustom["simple_prefix"])) {switch ($aCustom['page_item_type']) {case 'body_items': case 'body_urgent_items': $IIL1lI1 =I1377; break; default: $IIL1lI1 ='itemD_'; }}else {$IIL1lI1 =$aCustom["simple_prefix"]; }$aTmp["simple_prefix"] =$IIL1lI1."cat_"; $IIL1llI =$this->module->options[I1378]; $IIL1lll =isset($vData[$IIL1llI]); if($IIL1lll) {$IIL1llL =$vData[$IIL1llI]; }if($IIL1I1l) $aCustom["list_data"]["cat_adv_place"] =$this->module->db->Record["cat_adv_place"]; $vData[$IIL1llI] =$this->module->db->Record["cat_name"]; $IIL1ll1 =$this->module->IIllII1; $IIlLIIL =Array(I1317=>"_OverrideGenPicModName", "data"=> $_data =array($this->catModuleName)); $this->module->TTT1lI1($IIlLIIL, array('ext_images')); $IIlLIIL =Array(I1317=>"_GetPicturesCB", "data"=> $_data =array(&$vData, &$aTmp)); $this->module->TTT1lI1($IIlLIIL, array(I1379)); $IIlLIIL =Array(I1317=>"_OverrideGenPicModName", "data"=> $_data =array($IIL1ll1)); $this->module->TTT1lI1($IIlLIIL, array(I1379)); if(isset($this->module->ext[I1373]) && $this->module->ext[I1373]->catRatingsEnabled) {$this->module->ext[I1373]->_GetFrontItemCB($vData); foreach($IIL1lIL as $field){ unset($vData[$field]); }}if($IIL1lll) {$vData[$this->module->options[I1378]] =$IIL1llL; }else {unset($vData[$IIL1llI]); }if(!empty($IIL1llL)) {}foreach($this->module->options[I1372] as $picName) {if(!empty($picName) && $picName != 'null' && $picName != -222222){ if(isset($vData[$picName])) {$vData["cat_".$picName] =$vData[$picName]; unset($vData[$picName]); }if(isset($vData[I1380.$picName])) unset($vData[I1380.$picName]); }}$aTmp["simple_prefix"] =$IIL1lI1; if($this->IILL1L1){ $aSimpleSetFields =$this->module->IIllILl; $this->module->IIllILl =array_filter( $this->module->IIllILl, array( $this, 'cbFilterCatFields' ));}$this->module->_ApplySimpleSetsCB($vData, $aTmp); if($this->IILL1L1){ $this->module->IIllILl =$aSimpleSetFields; unset($aSimpleSetFields); }else{ $this->IILL1L1 =TRUE; }if($aCustom[I1360] == "body_items") {$IIl1IL1 =unserialize($this->module->db->Record["sm_data"]); $GLOBALS[I1381][I1382] =$this->cms->TITlTl1($GLOBALS[I1381][I1382], $IIl1IL1); if($this->module->db->Record['details_noindex']){ $this->module->TTTllT1(); }}$prefix =($aCustom[I1360] == "body_items") ?"item_" :"itemD_"; $vData[I1383] =$this->cms->Gui->getAbs($this->moduleName."_list:".$prefix.I1383, $vData); $this->module->options[I1372] =$IIL1lIl; }break; case "body_filtered": $this->module->options[I1338] =$this->IILL1ll; $res =true; break; }$this->module->options["use_special_list_view"] =$IIL1I1L; return $res; }function _GetCategoryCB(&$aItem, &$aData) {$this->TTIITTT($aItem); if($aItem["_num_items"] >0) {$aItem[I1347] =$this->cms->Gui->get($this->moduleName.I1384, $aItem); }else {$aItem[I1347] =$this->cms->Gui->get($this->moduleName."_list:cat_name", $aItem); }}function TTIITTT(&$record, $fieldPrefix =I1327){ if (!empty($record[$fieldPrefix .'announce']) && $this->IILI1LI->issetAndTrueOption('fill_empty_description') && mb_strlen(trim(strip_tags($record[$fieldPrefix .'announce']))) && !mb_strlen(trim(strip_tags($record[$fieldPrefix .I1385]))) ){$record[$fieldPrefix .I1385] =$record[$fieldPrefix .'announce']; }}function TTIITTI($sql, &$IIL1lLI, $IIL1lLl) {$aItems =Array(); if(isset($this->module->ext[I1373]) && is_object($this->module->ext[I1373])){ $sql =str_replace(" FROM", ", votes_count, votes_rate, rate_opt FROM", $sql); }if($this->module->I1LIIl1 >0) {foreach($IIL1lLI as $index => $val) {$this->module->db->query(str_replace($IIL1lLl, $val, $sql)); $aItems += $this->TTIITTl($this->module->db); }}else {$this->module->db->query($sql); $aItems =$this->TTIITTl($this->module->db); }return $aItems; }function TTIITTl(&$db) {$catId =-1; $aItems =Array(); $oldCatId =I1327; $aProduct =null; while($db->next_record()) {if($catId != $db->Record[$this->IILLL1I]) {$aItems[$catId.I1324] =$aProduct; $aProduct =Array(); $catId =$db->Record[$this->IILLL1I]; }$aProduct[] =$db->Record; $oldCatId =$db->Record[$this->IILLL1I]; }$aItems[$oldCatId .I1327] =$aProduct; return $aItems; }function TTIITT1($cId, $cModule, $IIL1lLL) {if($IIL1lLL >0) {$public =empty($this->cms->VarsPost['public']) ?null :I1386.$IIL1lLL; $all =I1386.$IIL1lLL; $this->TTIT11l($this->catId, $public, $all); }}function TTTlITl(&$aCustom, $cType, $IIlLI11, $IIlLlII, $isSmallMode) {$this->module->options[I1338] =($this->IILL1ll && $isSmallMode); }function TTT11IT($IILILIL) {$navData =Array(); if($this->catId >0) {if(!$this->IILL1LI) {$sql ="SELECT ".$this->IILLL1l.".sublink"; if($this->IILL1ll) {$sql .= I1339.$this->IILLL1l.".id_page"; }$sql .= " FROM ".$this->IILLLl1.I1340.$this->IILLL1l.I1356.$this->IILLL1l.I1387.$this->catId.I1343; $this->module->db->query($sql); if($this->module->db->next_record()) {$this->catSubLink =$this->module->db->Record["sublink"]; $this->module->IIlll1I =isset($this->module->db->Record["id_page"]) ?$this->module->db->Record["id_page"] :0; }else {$this->catSubLink =I1324; $this->module->IIlll1I =0; }}$navData["catid"] =$this->catId; $navData[I1388] =$this->catSubLink; }return $navData; }function TTT1lTl($IIl1II1, &$record, &$vData, &$aData) {$vData["item_link"] =$this->cms->Gui->get($this->moduleName."_list:itemD_cat_item_link", $vData); }function TTT1II1(&$db, &$aParams) {$IIL1IlI =str_replace(I1333, I1324, $this->IILLL1L); $field =$this->IILI1LI->Engine ?$this->IILI1LI->Engine->options['name_field_name'] :'name'; $sql =I1389 .$field ." " ."FROM `".$this->IILLLl1."` WHERE id = '".$this->catId.I1343; $db->query($sql); if($db->next_record()) {$res =Array("cat_name" => $db->Record[I1347]); }else {$res =Array(I1390 => I1324); }return $res; }function TTTlI1l() {return (intval($this->module->filter->GetFieldValue($this->IILLLL1)) >0); }protected function cbFilterCatFields($value){ return 0 != mb_strpos($value, 'cat_'); }}