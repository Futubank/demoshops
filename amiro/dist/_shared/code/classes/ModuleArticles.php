<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       38983 xkqwzmglmigtxyixultuqqrnxtsxzupgmgutgqisnpmlurwxrnmukxmpiqpzggwqygrgpnir
 */ ?><?php foreach(array(6643=>"ZrWOMvQ|GQrMHS",6644=>"GuYJMDO|Hff",6645=>"PQn|KQBCHrSD",6646=>"Zr",6647=>'|WZt',6648=>"|izNUzj|zRwomVq",6649=>"|JMDt",6650=>"IZnuZJ",6651=>"ZrWOMvQ|tBGQ",6652=>"fJt|WZt|MS",6653=>"",6654=>"SZtQ|frHI",6655=>"SZtQ",6656=>'100:',6657=>"SY",6658=>"DQJQWt",6659=>'LHMnD',6660=>'tZYJQD',6661=>"fJZPMWHn",6662=>"|JMDt%GuYJMW|Hn",6663=>"vZJuQ",6664=>"ZWtMHn",6665=>"DMAQ",6666=>"ZWtMHn|QSMt",6667=>"Hff",6668=>"|JMDt%SQJ",6669=>"ZSS",6670=>"nHtGuYJMDOQS",6671=>"JQP|QSMt",6672=>'YHSB|WZtD',6673=>'YHSB|urPQnt|WZtD',6674=>"GZPQ|MtQI|tBGQ",6675=>'DQJQWt',6676=>'Qxt|rDD',6677=>"ZnnHunWQ",6678=>"'{?zd?fSZtQ?",6679=>"COQrQ",6680=>"DMIGJQ|DQt|fMQJSD",6681=>"MtQI|fMJtQrQS",6682=>"IQtOHS",6683=>"?zd?Zr?",6684=>'',6685=>'WZt|ZSv|GJZWQ',6686=>'WZt|ZSv|WHuntQr',6687=>"MtQIs",6688=>"ZutOHr",6689=>"'",6690=>"YHSB",6691=>"QrrnH",6692=>"DHurWQ",6693=>"SQtZMJD|JMnK",6694=>"MtQI",6695=>"MtQI|GMWturQD",6696=>"'{",6697=>"MS",6698=>"OQZSQr",6699=>"DuYJMnK",6700=>"DuYMtQI",6701=>"ZSv",6702=>"VDGJMttQr",6703=>"nZIQ|fMQJS|nZIQ",6704=>"DIZJJ|nuIYQr|MtQID",6705=>"WZtD|MSD",6706=>"JMDt|SZtZ",6707=>"?",6708=>'Zt|DGQW|YJHWK',6709=>'W',6710=>'GHG',6711=>"nH|WZtD",6712=>"LHMn",6713=>'Zr`urPQnt?sqdw',6714=>"'{?ZD?fSZtQ?",6715=>"?zd?Zr?mNNqR?lhmN?",6716=>"MS|WZt",6717=>"fMQJSD",6718=>"GrQvwZtmS",6719=>"uDQ|MS|GZPQ",6720=>"fSZtQ",6721=>"IHrQ",6722=>"frHnt|JMnK",6723=>"WZt|SQtZMJ",6724=>"ZSv|WHuntQr|MS") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ModuleArticles extends CMS_ActModule {public $I1LIIlL; public $archivePeriod; public $IlIllI1; public $I1LIIl1; public $I1LIILI; public $I1LIILl; public $I1LIILL; public $I1LIIL1; public $II1lllI; public $I1LII1I; function ModuleArticles(&$cms, &$db, &$cModule) {parent::CMS_ActModule($cms, $db, $cModule); $this->I1LIIlL =($this->module->GetOption("archive_type")=="manual"); $this->archivePeriod =$this->module->GetOption(I6643); $this->II1lllI =Array(); }function _Init($IIll1l1 =Array(), $IIll1LI ="", $IIll1Ll ="", $aOptions =Array()) {$IIIIL11["group_operations"] =Array("publish_on", I6644, "archive_on", "archive_off", "del", "gen_sublink", I6645, "index_details", "no_index_details", "move_position"); $IIIIL11["default_prefix"] =I6646; $IIIIL11["use_id_page"] =true; $IIIIL11["use_options_form"] =true; $IIIIL11["name_field_name"] ="header"; $IIIIL11["description_field_name"] ="body"; $IIIIL11["picture_cat"] =$this->module->GetProperty('picture_cat'); $IIIIL11["use_positions"] =true; $aOptions += $IIIIL11; $catModuleName =$this->module->Name .I6647; $this->I1LII1I =$this->cms->Core->IsInstalled($catModuleName) && $this->module->IssetAndTrueOption("use_categories"); if ($this->I1LII1I) {$this->IlIllI1 =new CMS_CategoriesFunctions($this->cms, $this, $catModuleName); }else {$this->IlIllI1 =new CMS_CategoriesFunctionsStub($this->cms, $this, $catModuleName); }$this->TTITTI1( AMI::getResourceModel($this->moduleName .'/table') ->hasField('public_direct_link') );parent::_Init($IIll1l1, $IIll1LI, $IIll1Ll, $aOptions); $this->IlIllI1->_Init(); $this->IlIllI1->TTIT1IT("_ApplyCatFilters"); }function _InitAdmin() {parent::_InitAdmin(); if($this->I1LIIlL){ $this->cms->Gui->addGlobalVars(Array(mb_strtoupper($this->moduleName).I6648=>"1")); }}function TTTlTI1() {parent::TTTlTI1(); $this->I1LIIl1 =$this->module->GetOption("show_subitems"); $this->I1LIILl =$this->module->GetOption("subitems_splitter_period"); $this->I1LIILL =$this->module->GetOption("subitems_cols"); $this->cms->SetsTemplate =$this->moduleName.I6649; $this->I1LIIL1 =""; $I1LII1l =DateTools::toMysqlDate(strtotime($this->module->GetOption(I6643))); switch($this->module->GetOption("show_type")) {case "active": $this->I1LIIL1 .= ($this->module->GetOption("archive_type") == I6650) ?"AND ar.archive<>1" :"AND (ar.archive<>1 AND ar.date>='".$I1LII1l."')"; break; case "archive": $this->I1LIIL1 .= ($this->module->GetOption(I6651) == I6650) ?"AND ar.archive=1" :"AND (ar.archive=1 OR ar.date<'".$I1LII1l."')"; break; }}function TTTlITT($IIIL11l, $cId, $cModule ="") {parent::TTTlITT($IIIL11l, $cId, $cModule); }function GetHtml(&$aCustom) {return parent::GetHtml($aCustom); }function TTTlIII() {parent::TTTlIII(); if($this->IlIllI1->TTTlIII(I6652)) {$this->filter->MoveField(I6652, _MOVE_START); }$this->filter->AddField("flt_header", "text", isset($this->cms->Vars["flt_header"]) ?stripslashes(unhtmlentities($this->cms->Vars["flt_header"])) :null, I6653, " like ", "header"); }function _ApplyCatFilters($prefix ='', $bodyType ='', $IIlLLl1 =true) {$res =parent::_ApplyFilters($prefix, $bodyType, $IIlLLl1); return $res; }function TTTlIIl($IIlLlLI, $IIlLlLl, $defaultValue) {switch($IIlLlLI) {case I6654: if($IIlLlLl != I6653) {$this->filter->AddField($IIlLlLI, "date", $IIlLlLl, I6653, ">=", "date"); }break; case "date_to": if($IIlLlLl != I6653) {$this->filter->AddField($IIlLlLI, I6655, $IIlLlLl, I6653, "<=", I6655); }break; default: }}function _ApplyFilters($prefix ='', $bodyType ='', $IIlLLl1 =true) {$res =parent::_ApplyFilters($prefix, $bodyType, $IIlLLl1).$this->I1LIIL1; return $res; }function TTTlI1I(&$vData) {parent::TTTlI1I($vData); $vData['form_width'] =I6656; }function TTTlI1l() {$res =false; if(parent::TTTlI1l()) {$res =$this->IlIllI1->TTTlI1l(); }return $res; }function TTTlI11(&$vData, &$aCustom) {$aCatSql =Array(); $aCatSql["join_to_alias"] =I6646; $this->IlIllI1->TTIT1lT("item_list", $aCatSql); $this->browser->InitSQL("ar.id, ar.public, ar.header, ar.announce, ". "DATE_FORMAT(ar.date,'".$this->cms->DFMT[I6657]."') AS fdate, ". (($this->I1LIIlL) ?"archive " :"(ar.archive or (ar.date < '".DateTools::toMysqlDate(strtotime($this->archivePeriod))."')) AS archive").$aCatSql[I6658], Array('tables'=>Array('ar'=>$this->module->GetTableName()) +$aCatSql['tables'], 'joins'=>$aCatSql[I6659]), "WHERE 1 ".$this->_ApplyFilters().$this->TTTlIl1(), I6653, "name", "ar.id desc", $aCatSql["order_replace"] );if(!empty($aCatSql[I6660])) {$this->browser->AddSQLJoinedTables($this->cms->Core, 'ar', $aCatSql[I6660]); }$aCustom["fields"] += Array( "public"=>Array("action"=>I6661, "value"=>1, "id"=>"pub_id", "on"=>$this->moduleName.I6662,"off"=>$this->moduleName."_list:public_off"), "archive"=>Array("action"=>I6661, I6663=>1, "id"=>"arch_id", "on"=>($this->I1LIIlL) ?$this->moduleName."_list:archive_on": $this->moduleName."_list:icon_archive_on", "off"=>($this->I1LIIlL) ?$this->moduleName."_list:archive_off": $this->moduleName."_list:icon_archive_off", ),"cname"=>Array(I6664=>"stripline", "size"=>35), "author"=>Array(I6664=>"stripline", I6665=>35), "header"=>Array(I6664=>"stripline", I6665=>35), "announce"=>Array(I6664=>"stripline", I6665=>145), I6666=>Array(I6664=>I6661, I6663=>I6653, "id"=>"edit_id", "on"=>$this->moduleName."_list:edit",I6667=>I6653), "action_del"=>Array(I6664=>I6661, I6663=>I6653, "id"=>"del_id", "on"=>$this->moduleName.I6668,I6667=>I6653), );$aCustom["applied_id"] ="ar.id"; $aCustom["form_data"]["buttons"] =Array(I6669, "apply", "cancel", "save"); $this->IlIllI1->TTTlI11($vData, $aCustom); parent::TTTlI11($vData, $aCustom); }function TTT11Tl(&$IILILII) {$IILILII[] ="published"; $IILILII[] =I6670; $IILILII[] ="onarchive"; $IILILII[] ="notarchive"; $IILILII[] ="leg_yellow"; $IILILII[] ="leg_blue"; $IILILII[] =I6671; $IILILII[] ="leg_del"; parent::TTT11Tl($IILILII); }function _ActionArchive($cId, $cModule) {if($this->I1LIIlL) {parent::_ActionArchive($cId, $cModule); }}function TTTllTI(&$aCustom) {$flag =true; $I1LII1L =false; $cat =$this->IlIllI1->TTTllTI($aCustom); if($cat != -1) {if($this->id >0) {$this->SetBodyType("body_itemD"); $flag =false; $I1LII1L =true; }else {if($cat === 0) {$this->SetBodyType('body_urgent_cats'); $this->SetBodyType("body_cats"); $this->bodyType =I6672; $flag =false; }else {if($this->id != -1) {$this->SetBodyType("body_items"); $this->SetBodyType('body_urgent_items'); }else {$this->SetBodyType("body_itemD"); $flag =false; $I1LII1L =true; }}}if($cat !== false) {if($flag && $this->module->GetOption("multicat")) {$this->SetBodyType(I6673); $this->SetBodyType("body_cats"); if ($this->bodyType == I6673) {$this->bodyType =I6672; }}if($I1LII1L && $this->module->GetOption("multicat_in_body_details")) {$this->SetBodyType(I6673); $this->SetBodyType("body_cats"); if ($this->bodyType == I6673) {$this->bodyType =I6672; }}}}parent::TTTllTI($aCustom); }function TTTlllT(&$vData) {parent::TTTlllT($vData); }function TTTll1T(&$vData, &$aCustom) {$aDefault =Array(); $this->TTT11ll(); foreach($this->IIllIL1 as $IIlL1L1 => $tmp) {$this->lIlLL11 =false; $IIlL1Ll =$this->TTITTT1($aCustom, $IIlL1L1, false); switch($IIlL1L1) {case "body_cats": case I6673: $IIlL1Ll[I6674] =$IIlL1L1; $IIlL1Ll['show_urgent_elements'] =$this->cms->Core->getModOption($this->IlIllI1->catModuleName, 'show_urgent_elements'); if(!isset($IIlL1Ll['_sql'])){ $IIlL1Ll['_sql'] =array(I6675 => ''); }$IIlL1Ll["_sql"][I6658] .= ", c.adv_place AS cat_adv_place"; if (isset($this->ext['ext_rss'])) {$I1LII11 =$this->ext[I6676]->IL1LI11; $this->ext[I6676]->IL1LI11 =false; }$this->IlIllI1->TTTll1T($vData, $IIlL1Ll); break; case "body_itemD": $aDefault[I6674] ="body_itemD"; $IIlL1Ll += $aDefault; $IIlL1Ll["simple_set_fields"] =Array("header", I6677, "body"); $this->IlIllI1->TTTll1T($vData, $IIlL1Ll); $aCatSql =Array(); $this->IlIllI1->TTIT1lT("item_details", $aCatSql); $sql ="SELECT ar.*, ". "DATE_FORMAT(ar.date, '".$this->cms->DFMT[I6657].I6678. "FROM " .$this->module->GetTableName() ." AS ar ". "WHERE ar.id='".$this->id."'".$aCatSql[I6679].$this->_ApplyFilters(); $this->db->query($sql); $vData["id"] =$this->id; break; case "body_items": case 'body_urgent_items': case "body_filtered": $aDefault[I6674] =$IIlL1L1; $aDefault[I6680] =Array(I6677, "header", "body"); $IIlL1Ll += $aDefault; $this->TTTllll($vData, $IIlL1Ll); $aCatSql =Array(); $IIL1II1 ="item_list"; if($IIlL1L1 == "body_filtered") {$IIL1II1 =I6681; }$IIlL1Ll["fields"]["detials"] =Array(I6664=>"callback", "object"=>&$this, I6682=>"_GetItemCB"); $this->IlIllI1->TTIT1lT($IIL1II1, $aCatSql); $this->browser->InitSQL("ar.id, ar.author, ar.source, ar.announce, ar.sublink, ar.adv_place, ". "ar.body, ar.header, ar.modified_date, ". "(LENGTH(ar.body) > 0) AS body_notempty, ". "DATE_FORMAT(ar.date, '".$this->cms->DFMT[I6657]."') AS fdate".$aCatSql[I6658].", ". "ar.modified_date as m_date, date as c_date, `disable_comments` ", "FROM " .$this->module->GetTableName() .I6683.$aCatSql["join"], "WHERE 1 ".$aCatSql[I6679].$this->_ApplyFilters('', $IIlL1L1 == 'body_urgent_items' ?$IIlL1L1 :I6684).$this->TTTlIl1(), I6653, $this->browser->TI1TTlT() );$this->browser->AddSQLJoinedTables($this->cms->Core, 'ar', $aCatSql["tables"]); $this->lIlLL11 =true; $IIlL1Ll["isAdvertisementSupported"] =true; if(!$this->IlIllI1->TTTll1T($vData, $IIlL1Ll)) {$IIlL1Ll[I6674] ="body_empty"; }else{ $this->TTTlll1($this->IlIllI1->catModuleName); $this->TTT11ll(); $procData =array( I6685 => isset($vData[I6685]) ?$vData[I6685] :null, 'id' => isset($vData['cat_id']) ?$vData['cat_id'] :null );$this->_getCatAdvPlaceCB($procData, $procData, "details"); $vData[I6685] =isset($procData[I6685]) ?$procData[I6685] :I6684; $vData[I6686] =isset($procData[I6686]) ?$procData[I6686] :I6684; $this->TTTlll1($this->moduleName); $this->TTT11ll(); }break; }$this->lIlLL11 =false; parent::TTTll1T($vData, $IIlL1Ll); if (isset($I1LII11)) {$this->ext[I6676]->IL1LI11 =$I1LII11; unset($I1LII11); }}}function TTT1lTl($IIl1II1, &$record, &$vData, &$aData) {parent::TTT1lTl($IIl1II1, $record, $vData, $aData); switch($IIl1II1) {case "body_itemD": $vData["item_link"] =$this->cms->Gui->get($this->moduleName."_list:itemD_item_link", $vData); $this->IlIllI1->TTT1lTl($IIl1II1, $record, $vData, $aData); $vData["top_link"] =$this->cms->TTITI1l(I6687, "top_link", $vData); $vData[I6655] =$this->cms->TTITI1l(I6687, I6655, $record["fdate"]); if(!empty($record["author"])) {$vData["author"] =$this->cms->TTITI1l(I6687, I6688, $record); }if(!empty($record["source"])) {$vData["source"] =$this->cms->TTITI1l(I6687, "source", $record["source"]); }break; }}function TTTl1Tl($cId, $cModule) {parent::TTTl1Tl($cId, $cModule); $sql ="SELECT ar.*, DATE_FORMAT(ar.date,'".$this->cms->DFMT[I6657]."') AS fdate, ". "IF(ar.public > 0, 'checked', '') AS public ". "FROM " .$this->module->GetTableName() .I6683. "WHERE ar.id='".$cId.I6689.$this->_ApplyFilters(); $this->db->query($sql); if($this->db->next_record()) {$this->itemData =$this->db->Record; unset($this->itemData["archive"]); if($this->I1LIIlL) {$this->itemData["archive"] =($this->db->Record["archive"] == 1) ?"checked" :I6653; }$this->itemData[I6677] =$this->cms->htmlchars($this->itemData[I6677]); $this->itemData[I6690] =$this->cms->htmlchars($this->itemData[I6690]); }}function _ActionDel($cId, $cModule) {$sql ="SELECT public, id_cat FROM " .$this->module->GetTableName() ." WHERE id='".$cId.I6689; $this->db->query($sql); if($this->db->next_record()){ $this->IlIllI1->TTIT1ll($cId, $cModule, $this->db->Record["public"], $this->db->Record["id_cat"]); parent::_ActionDel($cId, $cModule); $err =$this->GetLastError(); if(empty($err[I6691])) {$this->IlIllI1->_ActionDel($cId, $cModule); }}}function TTTll11($cId, $cModule) {parent::TTTll11($cId, $cModule); if(empty($this->errno) && $this->appliedId >0) {$this->IlIllI1->TTTll11($cId, $cModule); }}function TTTl1lI($cId, $cModule) {parent::TTTl1lI($cId, $cModule); if(empty($this->errno)) {$this->IlIllI1->TTTl1lI($cId, $cModule); }}function _ActionPublish($cId, $cModule) {$this->IlIllI1->TTIT1ll($cId, $cModule); parent::_ActionPublish($cId, $cModule); $this->IlIllI1->_ActionPublish($cId, $cModule); }function TTT1Tl1($cType, $cModule, $condition =I6684) {$res =$this->IlIllI1->TTT1Tl1($cType, $cModule); if(!$res) {parent::TTT1Tl1($cType, $cModule, $condition); }}function TTT1IlI($aSql =Array(), $cId =0) {$announce =$this->cms->VarsPost[I6677]; $I1LIlII =$this->cms->VarsPost["header"]; $udate =DateTools::getCorrectUDate($this->cms->VarsPost[I6655], $this->cms->DFMT["conf"]); $date =date($this->cms->DFMT["php"], $udate); if(!empty($announce) && !empty($I1LIlII)) {$aSql =Array( I6655=>DateTools::toMysqlDate($udate), "header"=>$I1LIlII, I6677=>$announce, I6690=>$this->cms->VarsPost[I6690], I6688=>$this->cms->VarsPost[I6688], I6692=>$this->cms->VarsPost[I6692], "public"=>$this->cms->VarsPost["public"], "archive"=>intval(!empty($this->cms->VarsPost["archive"])) );}$this->IlIllI1->TTT1IlI($aSql, $cId); $aSql =parent::TTT1IlI($aSql, $cId); return $aSql; }function _GetDetailsLinkCB(&$aItem, &$aData) {if(!empty($aItem[I6690])) {$aItem[I6693] =1; }}function TIITIll(&$aItem, &$aData, $setPrefix =I6653) {$aItem[I6655] =$aItem["fdate"]; $aItem[I6655] =$this->cms->TTITI1l("item", I6655, $aItem); if($aItem["body_notempty"]) {$aItem["more"] =$this->cms->TTITI1l(I6694, "more", $aItem); }if(!empty($aItem[I6688])) {$aItem[I6688] =$this->cms->TTITI1l(I6694, I6688, $aItem); }if(!empty($aItem[I6692])) {$aItem[I6692] =$this->cms->TTITI1l(I6694, I6692, $aItem); }}function _GetItemCB(&$aItem, &$aData) {$this->TIITIll($aItem, $aData); }function TIITIl1(&$IIL1lLI, $IIl1II1 =I6684) {$this->lIlLL11 =false; $II11L1L =" ar.urgent DESC, ar.".$this->module->GetOption("front_subitem_sort_col")." ".$this->module->GetOption("front_subitem_sort_dim"); $fields ="SELECT ar.id, ar.id_cat, ar.author, ar.source, ar.announce, ar.sublink, ar.body, ar.header, ". "(LENGTH(ar.body) > 0) AS body_notempty, ". "DATE_FORMAT(ar.date, '".$this->cms->DFMT[I6657]."') AS fdate, ar.adv_place, ar.urgent "; foreach($this->options[I6695] as $fieldName) {if(!empty($fieldName) && $fieldName != 'null' && $fieldName != -222222){ $fields .= ", ar.ext_".$fieldName; }}$fields .= " FROM " .$this->module->GetTableName() ." AS ar WHERE "; $this->_forceHideFutureItems =true; if($this->I1LIIl1 >0) {$sql =$fields."ar.id_cat='__id_cat__'".$this->_ApplyFilters(I6684, $IIl1II1, false)." ORDER BY ".$II11L1L." LIMIT ".$this->I1LIIl1; }else {$sql =$fields."ar.id_cat IN('".implode("','", $IIL1lLI).I6696.$this->_ApplyFilters(I6684, $IIl1II1, false)." ORDER BY ar.id_cat ASC, ".$II11L1L; }unset($this->_forceHideFutureItems); $this->I1LIILI =$this->IlIllI1->TTIITTI($sql, $IIL1lLI, "__id_cat__"); $this->lIlLL11 =true; }function _DrawSubItemsCB(&$aItem, &$aData) {$aItem["item_list"] =I6653; if(isset($this->I1LIILI[$aItem["id"]]) && is_array($I1LIlIl =$this->I1LIILI[$aItem[I6697]])){ $k =0; $numRows =sizeof($I1LIlIl); $vData["simple_prefix"] ="subitem_"; $I1LIlIL =$this->options["name_field_name"]; $this->options["name_field_name"] =I6698; $IIllLII =$this->TTT11ll(); foreach($I1LIlIl as $index=>$aSubItem) {$k++; $aTmp["active_item_type"] ="body_items"; $aTmp["cat_id"] =$aItem[I6697]; $aTmp["cat_sublink"] =$aItem[I6699]; $this->_GetNavDataCB($aSubItem, $aTmp); $aSubItem += $this->IIllllL; $IIlLIIL =Array(I6664=>"_GetPicturesCB", "data"=> $_data =array(&$aSubItem, &$aData)); $this->TTT1lI1($IIlLIIL, array('ext_images')); $aSubItem[I6698] =$this->cms->TTITI1l("subitem", I6698, $aSubItem); $aSubItem[I6677] =$this->cms->TTITI1l(I6700, I6677, $aSubItem); $IIlLIIL =Array(I6664=>"add_subitem_data", "item_data"=>&$aSubItem); $this->TTT1lI1($IIlLIIL); $this->TIITIll($aSubItem, $aData, "subitem_"); if(isset($aSubItem["adv_place"])){ if($IIllLII) $this->TTT111l($aSubItem, I6701, $aSubItem[I6697]); else unset($aSubItem["adv_place"]); }$aItem["item_list"] .= $this->cms->TTITI1l(I6700, "row", $aSubItem); if($k >0 && $k != $numRows) {if((($k %$this->I1LIILL) == 0)) {$aItem["item_list"] .= $this->cms->TTITI1l(I6700, I6702, $aItem); }elseif($k >1) {$aItem["item_list"] .= $this->cms->TTITI1l(I6700, "Hsplitter", $aItem); }if($this->I1LIILl && $k%$this->I1LIILl == 0 ){$aItem["item_list"] .= $this->cms->TTITI1l(I6700, "nSplitter", I6653); }}}$this->options[I6703] =$I1LIlIL; $aItem["item_list"] =$this->cms->TTITI1l(I6700, "list", $aItem); }}function TTTlIT1(&$aCustom, $cType ="small", $IIlLI11 =I6653, $IIlLlII ="_small") {$this->IlIllI1->TTTlITl($aCustom, $cType, $IIlLI11, $IIlLlII, true); $html =parent::TTTlIT1($aCustom, $cType, $IIlLI11, $IIlLlII); $this->IlIllI1->TTTlITl($aCustom, $cType, $IIlLI11, $IIlLlII, false); return $html; }function TTTll1I(&$vRes, &$aCustom, $cType, $IIlLlII) {$I1LIlI1 =$this->module->GetOption(I6704); $I1LIllI =$this->module->GetOption("small_category_ids"); $I1LIlll =$this->module->GetOption("small_number_categories"); $this->TTT11ll(); $this->TTT11ll($this->IlIllI1->catModuleName); $mode ="no_cats"; if( $this->cms->Core->IsInstalled($this->IlIllI1->catModuleName) && $this->module->issetAndTrueOption('use_categories') ){$mode =I6705; $I1LIllL =is_array($I1LIllI); if(!$I1LIllL || ($I1LIllL && sizeof($I1LIllI) == 0)) {if(empty($I1LIllI)) {if(empty($I1LIlll)) {$mode ="no_cats"; }else {$mode ="cats_num"; }}else {$I1LIllI =Array($I1LIllI); }}}$I1LIll1 =" "; if(!empty($I1LIlI1)) {$I1LIll1 =" LIMIT ".$I1LIlI1; }$aDefault =Array(); $aDefault[I6680] =Array(I6677); $aCustom += $aDefault; $aDefault[I6706]["splitter_prefix"] ="small_"; $aCustom[I6706] += $aDefault[I6706]; $I1LIlLI =" ar.".$this->module->GetOption("small_items_sort_col").I6707.$this->module->GetOption("small_items_sort_dim"); if ($this->I1LII1I && ($mode == 'cats_num' || $mode == 'cats_ids')) {$this->TTITTTI('push'); $I1LIlLl =in_array(I6708, $this->IlIllI1->IILI1LI->GetAOption('show_urgent_elements')); $sql ="SELECT c.id AS cat_id, c.sublink AS cat_sublink, c.name AS cat_name, c.announce AS cat_announce, c.urgent " ."FROM " .$this->IlIllI1->IILLLl1 ." AS c WHERE 1". $this->_ApplyCatFilters(I6709, I6684, !$I1LIlLl); $I1LIlLL =" ORDER BY " .($I1LIlLl ?'c.urgent DESC, ' :I6684) ."c.".$this->module->GetOption("small_categories_sort_col").I6707.$this->module->GetOption("small_categories_sort_dim"); if($mode == "cats_num") {$sql .= $I1LIlLL." LIMIT ".$I1LIlll; }else {$sql .= " AND id IN('".implode("','", $I1LIllI).I6696.$I1LIlLL; }$this->TTITTTI(I6710); $this->db->query($sql); $aCatIds =Array(); while($this->db->next_record()) {$aCatIds[] =$this->db->Record["cat_id"]; $this->II1lllI["aCats"][$this->db->Record["cat_id"]] =$this->db->Record; }}$I1LIlL1 =in_array(I6708, $this->module->GetAOption('show_urgent_elements')); if($mode == I6711) {$aCatSql =Array(); $this->IlIllI1->TTIT1lT('small_list', $aCatSql); }$IILL1ll =$this->options["use_id_page"]; $this->options["use_id_page"] =false; $this->_forceHideFutureItems =true; switch($mode) {case I6711: $this->options['use_id_page'] =$IILL1ll; $this->browser->InitSQL("ar.id, ar.id as adv_counter_id, ar.header, ar.announce, ar.source, ar.author, ar.sublink, ar.urgent, ar.disable_comments " .$aCustom["sql_addon"][I6658] .", date_format(ar.date,'".$this->cms->DFMT[I6657]."') as fdate ".$aCatSql[I6658], "FROM " .$this->module->GetTableName() .I6683.$aCatSql[I6712], "WHERE 1 ".$this->_ApplyFilters(I6684, I6684, !$I1LIlL1).$aCatSql[I6679], I6653, $I1LIlLI );$this->browser->SetForceRules('ORDER BY ' .$I1LIlLI, $I1LIll1); $this->browser->AddSQLJoinedTables($this->cms->Core, 'ar', $aCatSql["tables"]); if ($I1LIlL1) {$this->browser->TI1TII1(array (I6713)); }if($this->TTT11ll()) $aCustom["fields"]["adv_counter_id"] =Array(I6664=>"callback", "object"=>&$this, I6682=>"_GetSmallAdvCounter"); break; case "cats_num": case I6705: $aItems =Array(); if(sizeof($aCatIds) >0) {$ILLILlL ="SELECT ar.id, ar.id as adv_counter_id, ar.id_cat, c.id_page, ar.header, ar.announce, ar.source, ar.author, ar.sublink, ar.disable_comments " .$aCustom["sql_addon"][I6658] .", date_format(ar.date,'".$this->cms->DFMT[I6657].I6714; foreach($this->options[I6695] as $fieldName) {if(!empty($fieldName) && $fieldName != 'null' && $fieldName != -222222){ $ILLILlL .= ", ar.ext_".$fieldName; }}if ($I1LIlL1) {$I1LIlLI =' ar.urgent DESC, ' .$I1LIlLI; }foreach($aCatIds as $catId) {$sql =$ILLILlL." FROM " .$this->module->GetTableName() .I6715 .$this->IlIllI1->IILLLl1 ." AS c ON c.id=ar.id_cat WHERE ar.id_cat='".$catId."' ".$this->_ApplyFilters(I6684, I6684, !$I1LIlL1)." ORDER BY ".$I1LIlLI.$I1LIll1; $this->db->query($sql); while($this->db->next_record()) {$aItems[] =$this->db->Record +$this->II1lllI["aCats"][$this->db->Record[I6716]]; }}}require_once $GLOBALS['CLASSES_PATH'] .'CMS_IteratorArray.php'; $I1LIl1I =true; $this->db =new CMS_IteratorArray($this->module); $this->db->SetArray($aItems); $this->browser->InitSQL(I6697, "FROM " .$this->IlIllI1->IILLLl1 .I6707, "WHERE 1 " );$this->browser->SetForceRules(I6653, I6707); $aCustom[I6717] += Array("cat_detials" => Array(I6664=>"callback", "object"=>&$this, I6682=>"_GetSmallCatDetailsCB")); $this->II1lllI[I6718] =-1; if($this->TTT11ll()) $aCustom[I6717]["adv_counter_id"] =Array(I6664=>"callback", "object"=>&$this, I6682=>"_GetSmallAdvCounter"); break; }unset($this->_forceHideFutureItems); $this->options[I6719] =$IILL1ll; $aCustom[I6717] += Array("detials" => Array(I6664=>"callback", "object"=>&$this, I6682=>"_GetSmallDetailsCB")); parent::TTTll1I($vRes, $aCustom, $cType, $IIlLlII); if(isset($I1LIl1I)) {$this->db =new DB_si; }}function _GetSmallDetailsCB(&$aItem, &$aData) {$aItem[I6655] =$aItem[I6720]; $aItem[I6655] =$this->cms->TTITI1l("small", I6655, $aItem); $aItem["front_link"] =$aData["front_link"]; $aItem[I6698] =$this->cms->TTITI1l("small", I6698, $aItem); $aItem[I6721] =$this->cms->TTITI1l("small", I6721, $aItem); }function _GetSmallCatDetailsCB(&$aItem, &$aData) {if($this->II1lllI[I6718] != $aItem[I6716]) {$this->II1lllI[I6718] =$aItem[I6716]; $tmp =Array("active_item_type"=>"body_cats"); $tmp2 =Array(I6697=>$aItem[I6716], I6699=>$aItem["cat_sublink"]); $this->_GetNavDataCB($tmp2, $tmp); $aItem[I6722] =$aData[I6722]; $aItem["cat_nav_data"] =$tmp2["nav_data"]; $aItem["cat_detail"] =$this->cms->TTITI1l("small", I6723, $aItem); if($this->TTT11ll($this->IlIllI1->catModuleName)){ $I1LIl1l =$this->IIllII1; $I1LIl1L =$aItem["adv_counter_id"]; $this->IIllII1 =$this->IlIllI1->catModuleName; $aData["adv_counter_prefix"] ="cat_"; $aItem["adv_counter_id"] =$aItem[I6716]; $this->_GetSmallAdvCounter($aItem, $aData); $aItem[I6724] =$I1LIl1L; unset($aData["adv_counter_prefix"]); $this->IIllII1 =$I1LIl1l; }}else {$aItem[I6723] =I6653; }}function TTT11IT($IILILIL) {$navData =parent::TTT11IT($IILILIL); $navData += $this->IlIllI1->TTT11IT($IILILIL); return $navData; }function correctStopArgNames($cData, $IIL1lL1, &$res, &$aData, $IIL1l1I ="getallvalues"){ return $this->IlIllI1->correctStopArgNames($cData, $IIL1lL1, $res, $aData, $IIL1l1I); }function TTT1II1(&$db, &$aParams) {$aVars =parent::TTT1II1($db, $aParams) +$this->IlIllI1->TTT1II1($db, $aParams); return $aVars; }function TTT1TTI(&$IIl1ll1, $prefix) {if ($this->I1LII1I) {$IIl1ll1[I6675] .= ", id_cat"; }}function TTT1TTl(&$record) {if ($this->I1LII1I) {$this->IlIllI1->catId =$record['id_cat']; }}}