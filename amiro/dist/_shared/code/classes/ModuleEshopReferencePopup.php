<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       32124 xkqwputqqmukrqrywummtxxuwwnuqzgqxuxqrmskzslsksnyymzrnnsswrslxmixmstppnir
 */ ?><?php foreach(array(8912=>'',8913=>"fMQJS|MS",8914=>"rQfrQf",8915=>"rQfQrQnWQD",8916=>"iHSuJQqDOHGRQfQrQnWQgHGuG%%mnMt%?MIGHDDMYJQ?rQfQrQnWQ?MS%?*",8917=>"|rQfQrQnWQ",8918=>"tZYJQ|nZIQ",8919=>"fJZPIZG|SZtZ",8920=>"SQDWrMYQ?WID|",8921=>"fJZPIZG",8922=>"'",8923=>"",8924=>"{?JMKQ?'",8925=>"?ZnS?JZnP='",8926=>"ZGGJB",8927=>'wjzddqd|gzTo',8928=>"SZtQfrHI",8929=>"fJt|nZIQ",8930=>"|rQfQrQnWQ|",8931=>"rQfQrQnQ|nZIQ",8932=>"SMDZYJQS",8933=>"rQfQrQnWQ|MS",8934=>"nuI",8935=>"vZJuQ",8936=>"MS",8937=>"nZIQ",8938=>"GOG",8939=>"vZJuQ|1",8940=>"1",8941=>"vZJuQ|fMQJS",8942=>"'{?ZD?fSZtQ?",8943=>"SZtQ",8944=>"?",8945=>"%DQJQWtQS|rHC",8946=>"^",8947=>"coqRq?1?",8948=>'nZIQ',8949=>'ZWtMHn',8950=>'ZGGJMQS|MS',8951=>'JQP|YJuQ',8952=>"DZvQ",8953=>"YPWHJHr",8954=>"MD|DQJQWtQS|Mn|uDQ",8955=>"!?whNwzT}",8956=>"?FRhi?WID|",8957=>'IHSQ',8958=>"dqjqwT?.nZIQ.?",8959=>'MS',8960=>'zggjmqs|wozNpqd',8961=>"whNV}vZJuQ|",8962=>"FRhi?WID|",8963=>'WOQWKQS',8964=>"dqjqwT?",8965=>"coqRq?MS='",8966=>"!",8967=>"vZJuQ|",8968=>"fJHZt",8969=>"MS|QxtQrnZJ") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ModuleEshopReferencePopup extends CMS_ActModule {public $oEshop; public $lIllIIl; public $I11LLII; public $itemId; public $fieldId; public $lIlllLL; public $lIlllL1; public $lIlll1I; public $lIlll1l; public $lIllIlI; public $lIlll1L; public $lIllIll; public $ILLIL1l; public $Illl1II; function ModuleEshopReferencePopup(&$cms, &$db, &$cModule) {parent::CMS_ActModule($cms, $db, $cModule); $this->lIlll1l =new ModuleEshopReference($cms, $db, $cModule); $this->lIllIlI ="char"; $this->lIlll1L =1; $this->lIllIll =array(); $this->ILLIL1l =array(); $this->Illl1II =$cModule->GetOwnerName(); }function Init($IIll1l1 =Array(), $IIll1LI ='', $IIll1Ll =I8912, $aOptions =Array()) {if(isset($this->cms->Vars["itemId"]) && $this->cms->Vars["itemId"] != "") $this->itemId =$this->cms->Vars["itemId"]; else $this->itemId =0; if(isset($this->cms->Vars[I8913]) && $this->cms->Vars[I8913] != "") $this->fieldId =$this->cms->Vars[I8913]; else $this->fieldId =""; if(isset($this->cms->Vars["refmulti"]) && $this->cms->Vars["refmulti"]) $this->lIlllLL =true; else $this->lIlllLL =false; if(isset($this->cms->Vars[I8914]) && $this->cms->Vars[I8914]) $this->lIlllL1 =true; else $this->lIlllL1 =false; if(isset($this->cms->Vars["references"]) && $this->cms->Vars["references"] != "") $this->lIlll1I =$this->lIlllLL ?explode(";", $this->cms->Vars[I8915]) :Array($this->cms->Vars[I8915]); else $this->lIlll1I =Array(); if(isset($this->cms->Vars["reference_id"]) && $this->cms->Vars["reference_id"]) $this->I11LLII =intval($this->cms->Vars["reference_id"]); else $this->I11LLII =0; if($this->I11LLII <= 0){ trigger_error(I8916.$this->I11LLII."]...", E_USER_ERROR); }$this->lIllIIl =$this->cms->Core->GetModOption($this->Illl1II.I8917, "table_name").sprintf("%04d", $this->I11LLII); $this->module->SetTableName($this->lIllIIl); $lIlll11 =str_replace("_reference_", "", $this->cms->Core->GetModOption($this->Illl1II.I8917, I8918)); $sql ="select ftype, flagmap_data from cms_".$lIlll11."_ref_types where table_num='".intval($this->I11LLII)."'"; $this->db->query($sql); if($this->db->next_record()){ $this->lIllIlI =$this->db->Record["ftype"]; $this->ILLIL1l =unserialize($this->db->Record[I8919]); if(!is_array($this->ILLIL1l)){ $this->ILLIL1l =array(); }$this->cms->Gui->addGlobalVars(array("REFERENCE_TYPE" => $this->db->Record["ftype"])); }if(empty($this->lIllIlI)) $this->lIllIlI ="char"; $this->lIllIll =array(); $this->db->setSafeSQLOptions("describe"); $sql =I8920.$this->cms->Core->GetModOption($this->Illl1II.I8917, I8918).sprintf("%04d", $this->I11LLII); $this->db->query($sql); while($this->db->next_record()){ if(mb_strpos($this->db->Record["Field"], "value_") === 0){ $this->lIllIll[] =$this->db->Record["Field"]; if($this->lIllIlI == I8921) $this->lIlll1L =max($this->lIlll1L, intval(mb_substr($this->db->Record["Field"], 6))); }}$count =count($this->lIlll1I); for($i =0; $i <$count; $i++){ if($this->lIlllLL || $this->lIlllL1){ $sql ="select count(*) as count from cms_".$this->lIllIIl." where id=".intval($this->lIlll1I[$i])." and lang='".$this->langData.I8922; }else{ if($this->lIllIlI == "date") $condition ="DATE_FORMAT(value_1,'".$this->cms->DFMT["db"]."') like '".addslashes($this->lIlll1I[$i]).I8922; else if($this->lIllIlI == I8921){ $this->lIlll1L; $IL1IIlL =array(); $condition =I8923; for($j =1; $j <= $this->lIlll1L; $j++){ $IL1IIlL[] ="RPAD(REVERSE(CONV(value_".$j.", 10, 2)), 64, '0')"; }$condition ="CONCAT(".implode(",", $IL1IIlL).I8924.str_pad(TlTllT1($this->lIlll1I[$i]), 64*$this->lIlll1L, "0").I8922; }else $condition ="value_1 like '".addslashes($this->lIlll1I[$i]).I8922; $sql ="select count(*) as count from cms_".$this->lIllIIl." where ".$condition.I8925.$this->langData.I8922; }$this->db->query($sql); if($this->db->next_record()){ if($this->db->Record["count"] == 0) $this->lIlll1I[$i] =I8923; }}$IIlLLLL =$this->lIlll1I; $this->lIlll1I =Array(); for($i =0; $i <count($IIlLLLL); $i++){ if(!empty($IIlLLLL[$i])) array_push($this->lIlll1I, $IIlLLLL[$i]); }$IIIIL11["allowed_actions"] =Array("add", "edit", I8926, "save", "del", "move", "remove"); $aOptions += $IIIIL11; parent::Init($IIll1l1, $IIll1LI, $IIll1Ll, $aOptions); }function _InitAdmin() {parent::_InitAdmin(); require_once $GLOBALS[I8927] .'EshopAdmin.php'; $this->oEshop =new EshopAdmin($this->cms, $this->words); $this->oEshop->init($this->moduleName); $this->oEshop->TT1l11l($this->options["multi_sites"], $this->siteId); }function TTTlITT($IIIL11l, $cId, $cModule =I8912) {$id =intval($cId); switch ($IIIL11l) {case 'move': $this->_ActionMove($cId, $cModule); break; case 'remove': $this->TIIlTTT($cId, $cModule); break; default: parent::TTTlITT($IIIL11l, $cId, $cModule); break; }}function TTTlIII() {parent::TTTlIII(); if($this->filter->issetField(I8928)) $this->filter->TITI1l1(I8928); if($this->filter->issetField("dateto")) $this->filter->TITI1l1("dateto"); $this->filter->AddField("flt_name", "text", stripslashes(unhtmlentities($this->cms->Vars[I8929])), I8923, " like ", "name"); $this->filter->MoveField(I8929,_MOVE_START); }function &TTTlI1T(&$aCustom){ $data =parent::TTTlI1T($aCustom); $data["js_functions"] =$this->cms->Gui->get($this->module->GetName().":js_references", $data); $data["selected_reference_list"] =$this->cms->Gui->get($this->module->GetName().":selected_reference_list", $data); $data["scripts"] =$this->cms->Gui->getScripts(); $data["metas"] =$this->cms->Gui->getMetas(); $data["status"] =$this->cms->GetStatusMessages(); $lIlll11 =str_replace(I8930, I8923, $this->cms->Core->GetModOption($this->Illl1II.I8917, I8918)); $sql ="select name from cms_".$lIlll11."_ref_types where table_num='".intval($this->I11LLII).I8922; $this->db->query($sql); if($this->db->next_record()){ $this->lIllIlI =$this->db->Record["ftype"]; $ILLI1lI =unserialize($this->db->Record["name"]); $data[I8931] =isset($ILLI1lI[$this->langData]) ?$ILLI1lI[$this->langData] :$this->words["unknown"]; }else $data[I8931] =$this->words["unknown"]; global $conn, $adm; $out =$this->cms->Gui->get($this->module->GetName(), $data); $adm->Core->TTlllTT($out); print $out; $conn->Out(); die(); }function TTTlI1I(&$vData) {$vData["submit_add"] =I8923; $vData["submit_apply"] =I8932; $vData["action"] ="add"; $vData["item_id"] =$this->itemId; $vData["refmulti"] =$this->lIlllLL ?1 :0; $vData[I8914] =$this->lIlllL1 ?1 :0; $vData[I8933] =$this->I11LLII; $vData[I8913] =$this->fieldId; parent::TTTlI1I($vData); $lIllI11 =array(); switch($this->lIllIlI){ case I8921: if(isset($this->ILLIL1l[$this->langData]["map"])){ for($i =0; $i <mb_strlen($this->ILLIL1l[$this->langData]["map"]); $i++){ if($this->ILLIL1l[$this->langData]["map"][$i] == "1") $lIllI11[] =array(I8934 => $i+1, "name" => $this->ILLIL1l[$this->langData]["name"][$i+1], "checked" => I8923); }}break; case "date": $lIllI11[I8935] =date($this->cms->DFMT["php"], time()); break; case "int": case "float": default: $lIllI11[I8935] =I8923; break; }$vData["custom_control_data"] =$lIllI11; }function TTTlI11(&$vData, &$aCustom) {$lIllI11 =array(); if($this->itemData[I8936] >0){ switch($this->lIllIlI){ case I8921: if(isset($this->ILLIL1l[$this->langData]["map"])){ for($i =0; $i <mb_strlen($this->ILLIL1l[$this->langData]["map"]); $i++){ if($this->ILLIL1l[$this->langData]["map"][$i] == "1") $lIllI11[] =array(I8934 => $i+1, I8937 => $this->ILLIL1l[$this->langData][I8937][$i+1], "checked" => $this->itemData[I8921][$i] == "1" ?"checked" :I8923); }}break; case "date": $lIllI11[I8935] =date($this->cms->DFMT[I8938], strtotime($this->itemData["value_1"])); break; case "int": $lIllI11[I8935] =intval($this->itemData["value_1"]); break; case "float": $lIllI11[I8935] =floatval($this->itemData[I8939]); break; default: $lIllI11[I8935] =$this->itemData[I8939]; break; }}else $lIllI11 =$vData["custom_control_data"]; $vData["is_autofill"] ="0"; if($this->lIllIlI == I8921){ for($i =0; $i <sizeof($lIllI11); $i++) $vData["value_field"] .= $this->cms->Gui->getAbs($this->moduleName."_subform:value_field_flagmap", $lIllI11[$i]); }elseif($this->lIllIlI == "date"){ $vData["value_field"] =$this->cms->Gui->getAbs($this->moduleName."_subform:value_field_date", $lIllI11); $vData["is_autofill"] =I8940; }elseif($this->lIllIlI == "text"){ $vData["value_field"] =$this->cms->Gui->getAbs($this->moduleName."_subform:value_field_text", $lIllI11); $vData["is_autofill"] =I8940; }else{ $vData[I8941] =$this->cms->Gui->getAbs($this->moduleName."_subform:value_field_base", $lIllI11); if($this->lIllIlI != "related_items" && $this->lIllIlI != "related_cats") $vData["is_autofill"] =I8940; }$sql =I8923; $lIllLII =Array(); if($this->lIlllLL && count($this->lIlll1I) >0) $sql ="select id, name, value_1, description, date_format(date,'".$this->cms->DFMT["db"]."') as fdate ". "from cms_".$this->lIllIIl." ". "WHERE 1 AND id in('".implode("','", $this->lIlll1I)."') ".$this->_ApplyFilters().$this->TTTlIl1(); else if($this->lIlllL1 && count($this->lIlll1I) >0) $sql ="select id, name, value_1, description, date_format(date,'".$this->cms->DFMT["db"].I8942. "from cms_".$this->lIllIIl." ". "WHERE 1 AND id='".intval($this->lIlll1I[0])."' ".$this->_ApplyFilters().$this->TTTlIl1(); else if(count($this->lIlll1I) >0){ if($this->lIllIlI == I8943) $condition ="DATE_FORMAT(value_1,'".$this->cms->DFMT["db"]."') like '".addslashes($this->lIlll1I[0]).I8922; else if($this->lIllIlI == I8921){ $this->lIlll1L; $IL1IIlL =array(); $condition =I8923; for($j =1; $j <= $this->lIlll1L; $j++){ $IL1IIlL[] ="RPAD(REVERSE(CONV(value_".$j.", 10, 2)), 64, '0')"; }$condition ="CONCAT(".implode(",", $IL1IIlL).I8924.str_pad(TlTllT1($this->lIlll1I[0]), 64*$this->lIlll1L, "0").I8922; }else $condition ="value_1 like '".addslashes($this->lIlll1I[0]).I8922; $sql ="select id, name, value_1, description, date_format(date,'".$this->cms->DFMT["db"].I8942. "from cms_".$this->lIllIIl." ". "WHERE 1 AND ".$condition.I8944.$this->_ApplyFilters().$this->TTTlIl1(); }else $vData["selected_reference"] =$this->cms->Gui->getAbs($this->module->GetName().":selected_reference_list_empty"); if(!empty($sql)){ $this->db->query($sql); if($this->db->num_rows() >0) {$this->ILLlI1I =Array(); while($this->db->next_record()){ $lIllLIl =$this->db->Record; $lIllLIl["is_selected_in_use"] =true; $lIllLII[] =$lIllLIl[I8936]; $this->_FormatDescription($lIllLIl, $vData); $vData["selected_reference"] .= $this->cms->Gui->get($this->module->GetName().I8945, $lIllLIl); if(!$this->lIlllLL) break; }$vData["selected_reference_header"] =$this->cms->Gui->getAbs($this->module->GetName().":selected_reference_header", I8923); }else{ $vData["selected_reference"] =$this->cms->Gui->getAbs($this->module->GetName().":selected_reference_list_empty"); }}if($this->lIlllLL){ $vData[I8915] =implode(I8946, $this->lIlll1I); if(mb_strlen($vData[I8915]) >0) $vData[I8915] =I8946.$vData[I8915].I8946; else $vData[I8915] =I8946; }else $vData[I8915] =$this->lIlll1I[0]; $this->browser->InitSQL("id, name, description, date_format(date,'".$this->cms->DFMT["db"]."') as fdate", "FROM cms_".$this->lIllIIl.I8944, I8947.(count($lIllLII) >0 ?"AND id NOT IN ('".implode("','", $lIllLII)."') " :I8923).$this->_ApplyFilters().$this->TTTlIl1(), I8923, I8937 );$aCustom['fields'] =array( I8948 => array('action' => 'stripline', 'size' => 75), 'description' => array(I8949 => 'callback', 'object' => &$this, 'method'=>'_FormatDescription') );$aCustom[I8950] ='id'; $aCustom['legend'] =Array('leg_red', 'leg_yellow', I8951); $aCustom["form_data"]["buttons"] =Array("add", I8926, "cancel", I8952); parent::TTTlI11($vData, $aCustom); }function _FormatDescription(&$aItem, &$aData) {static $i =0; static $j =0; if($this->cms->Vars["action"] == "edit" && $this->cms->Vars[I8936] == $aItem[I8936]) {$aItem["bgcolor"] ='#FFF2D9'; }elseif($aItem[I8936] == $this->appliedId) {$aItem[I8953] ='#DDE7F8'; }elseif(($aItem["is_selected_in_use"] && $j%2) || (!$aItem["is_selected_in_use"] && $i%2)){ $aItem[I8953] ='#F0F0F0'; }else {$aItem[I8953] =I8912; }$aItem[I8954] ?$j++ :$i++; $aItem['description'] =$this->cms->stripLine($aItem['description'], 200); }function _ActionMove($cId, $cModule, $lIllLIL =TRUE){ $lIllLI1 =I8923; if($this->lIllIlI == I8921){ $lIllLlI =array(); for($i =1; $i <= $this->lIlll1L; $i++) $lIllLlI[] ="RPAD(REVERSE(CONV(value_".$i.", 10, 2)), 64, '0')"; $lIllLI1 =I8955.implode(",", $lIllLlI).") as value_1"; }else{ $lIllLI1 =", value_1"; }$sql ="SELECT id, name".$lIllLI1.I8956.$this->lIllIIl." WHERE id='".$cId."' AND lang='".$this->langData.I8922; $this->db->query($sql); if($this->db->next_record()){ $lIllLll =false; if($this->lIlllLL){ if(in_array($cId, $this->lIlll1I)) $lIllLll =true; }else if($this->lIlllL1){ if(isset($this->lIlll1I[0]) && $this->db->Record[I8936] == $this->lIlll1I[0]) $lIllLll =true; }if(!$lIllLll){ if($this->lIlllLL) array_push($this->lIlll1I, $cId); else if($this->lIlllL1) $this->lIlll1I =Array($this->db->Record[I8936]); else{ if($this->lIllIlI == I8943) $this->lIlll1I =Array(date($this->cms->DFMT[I8938], strtotime($this->db->Record[I8939]))); else if($this->lIllIlI == I8921){ $this->lIlll1I =Array("0x".TlTllIT($this->db->Record[I8939], true, true)); }else $this->lIlll1I =Array($this->db->Record[I8939]); }if($lIllLIL){ $this->cms->Gui->addGlobalVars( array( 'APPLIED_CHANGES' => addslashes( json_encode( array( I8957 => 'select', 'id' => $this->db->Record['id'], I8948 => AMI_Lib_String::unhtmlEntities($this->db->Record[I8948]) )))));}}}$this->cms->AddStatusMsg("status_add_to_list"); $this->appliedId =$cId; }function TIIlTTT($cId, $cModule, $deleted =FALSE, $name =I8912){ if($this->lIlllLL){ if(in_array($cId, $this->lIlll1I)){ $key =array_search($cId, $this->lIlll1I); unset($this->lIlll1I[$key]); }}else{ $this->lIlll1I =array(); }if(I8912 == $name){ $sql =I8958 ."FROM cms_" .$this->lIllIIl .I8944 ."WHERE id='" .$cId .I8922; $this->db->query($sql); if($this->db->next_record()){ $name =$this->db->Record[I8948]; }}$this->cms->Gui->addGlobalVars( array( 'APPLIED_CHANGES' => addslashes( json_encode( array( I8957 => 'remove', I8959 => $cId, I8948 => AMI_Lib_String::unhtmlEntities($name), 'deleted' => $deleted )))));$this->cms->AddStatusMsg("status_remove_from_list"); }function TTTll11($cId, $cModule) {parent::TTTll11($cId, $cModule); $lIllLlL =$this->GetLastError(); if(empty($lIllLlL['errno'])){ $lIllLl1 =1 == $this->cms->VarsPost['add_to_list']; $this->cms->Gui->addGlobalVars( array( I8960 => addslashes( json_encode( array( I8957 => 'create', I8959 => $this->appliedId, I8948 => AMI_Lib_String::unhtmlEntities($this->cms->VarsPost[I8948]), 'selected' => $lIllLl1 )))));if($lIllLl1){ $this->_ActionMove($this->appliedId, $cModule, FALSE); }}}function TTTl1Tl($cId, $cModule) {parent::TTTl1Tl($cId, $cModule); $lIlllII =array(); if($this->lIllIlI == I8921){ $lIlllIl =0; if(isset($this->ILLIL1l[$this->langData]["map"])){ $lIlllIl =ceil(mb_strlen($this->ILLIL1l[$this->langData]["map"])/63); }for($i =$lIlllIl; $i >0; $i--){ $lIlllII[] =I8961.$i.", 10, 2) as value_converted_".$i; }}$sql ="SELECT * ".(sizeof($lIlllII) >0 ?",".implode(",", $lIlllII) :I8923).I8944. I8962.$this->lIllIIl.I8944. "WHERE id='".$cId.I8922.$this->_ApplyFilters(); $this->db->query($sql); if($this->db->next_record()) {$this->itemData["action"] =I8926; $this->itemData["submit_add"] =I8932; $this->itemData["submit_apply"] =I8923; $this->itemData[I8936] =$this->db->Record[I8936]; $this->itemData[I8937] =$this->db->Record[I8937]; $this->itemData[I8963] =empty($this->cms->Vars['selected']) ?I8912 :' checked="checked"'; for($i =0; $i <sizeof($this->lIllIll); $i++){ $this->itemData[$this->lIllIll[$i]] =$this->db->Record[$this->lIllIll[$i]]; }if($this->lIllIlI == I8921 && $lIlllIl >0){ $this->itemData[I8921] =I8923; for($i =1; $i <= $lIlllIl; $i++){ $this->itemData[I8921] .= str_pad(strrev($this->db->Record["value_converted_".$i]), 63, "0"); }}}}function TTTl1lI($cId, $cModule) {$oldValues =array(); $sql =I8964.implode(",", $this->lIllIll).I8944. I8962.$this->lIllIIl.I8944. "WHERE id='".$cId.I8922; $this->db->query($sql); if($this->db->next_record()){ for($i =0; $i <count($this->lIllIll); $i++) $oldValues[$this->lIllIll[$i]] =$this->db->Record[$this->lIllIll[$i]]; }parent::TTTl1lI($cId, $cModule); $lIllLlL =$this->GetLastError(); if(empty($lIllLlL['errno'])){ $lIlllIL =array(); $sql =I8964.implode(",", $this->lIllIll).I8944. I8962.$this->lIllIIl.I8944. I8965.$cId.I8922; $this->db->query($sql); if($this->db->next_record()){ for($i =0; $i <count($this->lIllIll); $i++) $lIlllIL[$this->lIllIll[$i]] =$this->db->Record[$this->lIllIll[$i]]; }$this->lIlll1l->TIIll1l($this->db, $this->oEshop->dbTablePrefix, $this->I11LLII, $this->lIllIll, $cId, $oldValues, $lIlllIL, I8926); $lIllLl1 =1 == $this->cms->VarsPost['add_to_list']; $this->cms->Gui->addGlobalVars( array( I8960 => addslashes( json_encode( array( I8957 => 'update', I8959 => $cId, I8948 => AMI_Lib_String::unhtmlEntities($this->cms->VarsPost[I8948]), 'selected' => $lIllLl1 )))));if($lIllLl1){ $this->_ActionMove($cId, $cModule, FALSE); }}}function _ActionDel($cId, $cModule) {$oldValues =array(); $sql ="SELECT `name`, ".implode(I8966, $this->lIllIll).I8944. I8962.$this->lIllIIl.I8944. I8965.$cId.I8922; $this->db->query($sql); if($this->db->next_record()){ for($i =0; $i <count($this->lIllIll); $i++) $oldValues[$this->lIllIll[$i]] =$this->db->Record[$this->lIllIll[$i]]; }parent::_ActionDel($cId, $cModule); $lIllLlL =$this->GetLastError(); if(empty($lIllLlL['errno'])){ $this->lIlll1l->TIIll1l($this->db, $this->oEshop->dbTablePrefix, $this->I11LLII, $this->lIllIll, $cId, $oldValues, array(), "delete"); $this->TIIlTTT($cId, $cModule, TRUE, $this->db->Record[I8948]); }}function TTT1IlI($aSql =Array(), $cId =0) {$name =$this->cms->VarsPost[I8937]; if($name != I8912) {$aSql =Array( I8937 => $name, );if(in_array(I8939, $this->lIllIll)){ switch($this->lIllIlI){ case I8921: $lIlllIl =0; if(isset($this->ILLIL1l[$this->langData]["map"])){ for($i =0; $i <mb_strlen($this->ILLIL1l[$this->langData]["map"]); $i++){ $lIlllIl =ceil(($i+1)/63); $aSql[I8967.$lIlllIl] .= $this->cms->VarsPost[I8967.($i+1)] == I8940 ?I8940 :"0"; }}for($i =$lIlllIl; $i >0; $i--){ $aSql[I8967.$i] ="=|CONV('".strrev($aSql[I8967.$i])."', 2, 10)"; }break; case "int": $aSql[I8939] =intval($this->cms->VarsPost[I8935]); break; case I8968: $aSql[I8939] =floatval($this->cms->VarsPost[I8935]); break; case I8943: $aSql[I8939] =DateTools::toMysqlDate(DateTools::getCorrectUDate($this->cms->VarsPost[I8935], $this->cms->DFMT["conf"])); break; default: $aSql[I8939] =$this->cms->VarsPost[I8935]; break; }}if($cId == 0) {$aSql[I8943] =DateTools::toMysqlDate(time()); $asql["position"] =TlT1Ill($this->db, "cms_".$this->lIllIIl); }if(isset($this->cms->VarsPost["id_external"])) {$aSql[I8969] =$this->cms->VarsPost[I8969]; }}$aSql =parent::TTT1IlI($aSql, $cId); return $aSql; }}