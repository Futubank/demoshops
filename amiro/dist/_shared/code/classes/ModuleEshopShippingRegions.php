<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       7578 xkqwunmwkminzlnxwikruiqlwpyxwxtzptlyyxwykmymikyyysptzzxiqtrnmypryuulpnir
 */ ?><?php foreach(array(9136=>'qDOHGzSIMn`GOG',9137=>"JZnP|SZtZ",9138=>"ZJJHCQS|ZWtMHnD",9139=>"SQJ",9140=>"SZtQfrHI",9141=>"fJt|nZIQ",9142=>"|DOMGGMnP|IQtOHSD",9143=>"uDQ|DOMGGMnP|IHSuJQ",9144=>"CZrn|DOMGGMnP|IHSuJQ|MD|SMDZYJQS",9145=>"nZIQ",9146=>".",9147=>"I2r_r",9148=>"r`MS",9149=>"r",9150=>"DtrMGJMnQ",9151=>"ZWtMHn|QSMt",9152=>"MS",9153=>"",9154=>"SQJ|MS",9155=>"JQP|rQS",9156=>"fHrI|SZtZ",9157=>"DZvQ",9158=>"dqjqwT?r`[?",9159=>"'") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ModuleEshopShippingRegions extends CMS_ActModule {public $oEshop; public $lIlLLIl; public $_popup; public $lIlLLIL; function ModuleEshopShippingRegions(&$cms, &$db, &$cModule) {parent::CMS_ActModule($cms, $db, $cModule); if($this->cms->Core->Side == "admin") {require_once $GLOBALS['CLASSES_PATH'] .I9136; $this->oEshop =new EshopAdmin($this->cms, $this->words); $this->oEshop->init($this->moduleName); }else {CreateEshop($cms); $this->oEshop =&$cms->Eshop; }}function _Init($IIll1l1 =array (),$IIll1LI ='', $IIll1Ll ='', $aOptions =array ()){$this->_popup =intval(isset($this->cms->Vars["method_id"])); $IIIIL11 =array ("stop_use_sublinks" => false, I9137 => true, "check_public" => false, "default_prefix" => "r", "use_positions" => !$this->_popup, I9138 => array ("add", "edit", "apply", "save", I9139), "group_operations" => array (I9139) );if (!$this->_popup) {$IIIIL11["group_operations"][] ="move_position"; }$aOptions += $IIIIL11; parent::_Init($IIll1l1, $IIll1LI, $IIll1Ll, $aOptions); }function _InitAdmin() {$this->lIlLLIL =$this->_popup ?intval($this->cms->Vars["method_id"]) :0; $this->lIlLLIl =false; parent::_InitAdmin(); }function TTTlIII() {parent::TTTlIII(); if ($this->filter->issetField(I9140)) {$this->filter->TITI1l1(I9140); }if ($this->filter->issetField("dateto")) {$this->filter->TITI1l1("dateto"); }$this->filter->AddField("method_id", "hidden", $this->lIlLLIL); $this->filter->AddField(I9141, "text", stripslashes(unhtmlentities($this->cms->Vars[I9141])), "", " LIKE ", "name"); $this->filter->MoveField(I9141, _MOVE_START); }function TTTlI1I(&$vData) {if (!$this->cms->Core->GetModOption($this->oEshop->ownerName .I9142, I9143)) {$this->cms->AddStatusMsg(I9144, "red"); }parent::TTTlI1I($vData); if (!$this->cms->Core->GetModOption($this->oEshop->ownerName .I9142, I9143)) {$this->cms->AddStatusMsg(I9144, "red"); }if (count($this->itemData) == 0) {$vData["name"] =isset($this->cms->VarsPost["name"]) && !$this->lIlLLIl ?$this->cms->VarsPost[I9145] :""; }else {$vData[I9145] =$this->itemData[I9145]; }}function TTTlI11(&$vData, &$aCustom) {if ($this->_popup) {parent::TTTlI11($vData, $aCustom); return; }$this->browser->InitSQL( "r.*, COUNT(m2r.id_method) methods_count", array ("tables" => array ("r" => I9146 .$this->module->GetTableName() ."` ", "m2r" => I9146 .$this->oEshop->dbTablePrefix ."_shipping_methods_regions` " ),"joins" => array (I9147 => "m2r.id_region = r.id"), "joins_types" => array (I9147 => "LEFT OUTER") ),"WHERE 1 " .$this->_ApplyFilters() .$this->TTTlIl1(), I9148, "", "r.id DESC", array ("methods_count" => "COUNT(m2r.id_method)" ));$this->browser->AddSQLJoinedTables($this->cms->Core, I9149, array ("m2r" => I9146 .$this->oEshop->dbTablePrefix ."_shipping_methods_regions` ")); $aCustom["fields"] += array (I9145 => array ("action" => I9150, "size" => 64), "methods_count" => array ("action" => I9150, "size" => 10), I9151 => array ("action" => "flagicon", "value" => "", I9152 => "edit_id", "on" => $this->moduleName ."_list:edit", "off" => I9153 ),"action_del" => array ("action" => "flagicon", "value" => I9153, I9152 => I9154, "on" => $this->moduleName ."_list:del", "off" => I9153 ));$aCustom["legend"] =array (I9155, "leg_yellow", "leg_blue", "leg_edit", "leg_del"); $aCustom[I9156]["buttons"] =array ("add", "apply", "cancel", I9157); $aCustom["applied_id"] =I9148; parent::TTTlI11($vData, $aCustom); }function TTT1IlI($aSql =array (),$cId =0) {$aSql =array ();$name =trim($this->cms->VarsPost[I9145]); if (empty($name)) {$this->SetLastError(1000, "Missing name"); $this->cms->AddStatusMsg("warn_missing_name", "red"); }else {$aSql[I9145] =$name; }$aSql =parent::TTT1IlI($aSql, $cId); return $aSql; }function TTTll11($cId, $cModule) {parent::TTTll11($cId, $cModule); if ($this->id) {$this->appliedId =$this->id; }if (!$this->errno) {$this->lIlLLIl =true; }}function TTTl1Tl($cId, $cModule) {parent::TTTl1Tl($cId, $cModule); $sql =I9158 ."FROM `" .$this->module->GetTableName() ."` " ." r " ."WHERE r.id = '" .$cId .I9159 .$this->_ApplyFilters(); $this->db->query($sql); if ($this->db->next_record()) {$this->itemData =$this->db->Record; }}function _ActionDel($cId, $cModule) {$sql ="DELETE FROM `" .$this->oEshop->dbTablePrefix ."_shipping_methods_regions` " ."WHERE id_region = '" .$cId .I9159; $this->db->query($sql); parent::_ActionDel($cId, $cModule); }}?>