<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       17823 xkqwugwxqnzgqnpmrxpzuzqmuzzgxmluylrtnnmynsrkktnlymqwspmxytmlpspzswwwpnir
 */ ?><?php foreach(array(11049=>'',11050=>'PrHuG|HGQrZtMHnD',11051=>"ZJJHCQS|ZWtMHnD",11052=>"DZvQ",11053=>'wjzddqd|gzTo',11054=>"ZWtMvZtQ",11055=>"MIGHrt",11056=>"SZtQtH",11057=>"?JMKQ?",11058=>"",11059=>"I`QIZMJ",11060=>"WOQWK|fHrI",11061=>"I",11062=>"Or_I",11063=>'jqFT',11064=>"ZWtMvQ",11065=>"ZWtMHn",11066=>"Hn",11067=>"DtrMGJMnQ",11068=>"WZJJYZWK",11069=>"ZWtMHnD",11070=>"SQJ|MS",11071=>"HnZWtMvQ",11072=>"JQP|QSMt",11073=>"ZSS",11074=>"zSSMnP?fZMJQS",11075=>"CQYDMtQ",11076=>"rQDQJJQrD|HGtMHnD",11077=>"OQZSQr",11078=>"tBGQ",11079=>'MS|nQC|rQDQJJQr',11080=>"uDQrnZIQ",11081=>"MS",11082=>"zGGJB?fZMJQS",11083=>"DtZtuD|ZWtMvZtQ",11084=>"Hff",11085=>"DtZtuD|PrG|rQDQt",11086=>'MS') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} require_once $GLOBALS['CLASSES_PATH'] .'Reseller.php'; class ModuleHstResellers extends ModuleHst {public $user; function ModuleHstResellers(&$cms, &$db, &$cModule) {parent::ModuleHst($cms, $db, $cModule); }function _Init($IIll1l1 =Array(), $IIll1LI =I11049, $IIll1Ll =I11049, $aOptions =Array()) {$IIIIL11['default_prefix'] ='m'; $IIIIL11["lang_data"] =false; $IIIIL11['check_public'] =false; $IIIIL11[I11050] =Array("active_on", "active_off", "reset", "del"); $IIIIL11[I11051] =Array("activate", "add", "edit", "apply", I11052, "del", "reset"); $aOptions += $IIIIL11; parent::_Init($IIll1l1, $IIll1LI, $IIll1Ll, $aOptions); }function _InitAdmin() {parent::_InitAdmin(); require_once $GLOBALS['CLASSES_PATH'] .'CMS_Member.php'; require_once $GLOBALS[I11053] .'Reseller.php'; $none =""; $this->user =new Reseller($none); }function TTTlITT($IIIL11l, $cId, $cModule ="") {switch ($IIIL11l) {case "del_confirm": $this->TIIITlT($cId, $cModule); break; case I11054: $this->_ActionActivate($cId, $cModule); break; case "reset": $this->_ActionReset($cId, $cModule); break; case "grp_active_on": $this->TIITTl1($this->aGroupIds, $cModule); break; case "grp_active_off": $this->TIITT1T($this->aGroupIds, $cModule); break; case "grp_reset": $this->TIITT1I($this->aGroupIds, $cModule); break; case I11055: $this->redirect =false; $this->TTIITT1($cId, $cModule); break; case 'export': $this->redirect =false; break; default: parent::TTTlITT($IIIL11l, $cId, $cModule); break; }}function TTTlIII() {parent::TTTlIII(); if($this->filter->issetField("datefrom")) $this->filter->TITI1l1("datefrom"); if($this->filter->issetField("dateto")) $this->filter->TITI1l1(I11056); $this->filter->AddField("flt_username", "text", stripslashes(unhtmlentities($this->cms->Vars["flt_username"])), "", I11057, "m.username"); $this->filter->AddField("flt_resellername", "text", stripslashes(unhtmlentities($this->cms->Vars["flt_resellername"])), I11058, I11057, "CONCAT_WS(' ', m.lastname, m.firstname)"); $this->filter->AddField("flt_email", "text", stripslashes(unhtmlentities($this->cms->Vars["flt_email"])), I11058, I11057, I11059); }function TTTlI1I(&$vData) {$I1lLII1 =$this->user->getScripts($this->cms, "hst_resellers"); $vData["header_memeber_script"] =$I1lLII1["header"]; $vData["check_member_script"] =$I1lLII1[I11060]; if($this->action != "add") {$vData["on_change_member_script"] =$I1lLII1["on_change"]; }$vData["member_form"] =$this->user->getForm($this->cms, $this->db, $this->itemData); parent::TTTlI1I($vData); }function TTTlI11(&$vData, &$aCustom) {$this->browser->InitSQL("hr.id, hr.id_member, m.username, CONCAT_WS(' ', m.lastname, m.firstname) as reseller_name, ". "m.email, (m.active & hr.is_active) as active, count(distinct hc.id) as clients_count ", Array("tables"=>Array("hr"=>"cms_hst_resellers", I11061=>"cms_members", "hc"=>"cms_hst_clients"), "joins"=>Array(I11062=>"hr.id_member=m.id", "m|hc"=>"hc.id_reseller=hr.id"), "joins_types"=>Array(I11062=>I11063, 'm|hc'=>I11063) ),"WHERE 1 ".$this->_ApplyFilters().$this->TTTlIl1(), "hr.id", "name", I11058, Array(I11064=>"(m.active & hr.is_active)"), _DB_STRAIGHT_JOIN );$this->browser->AddSQLJoinedTables($this->cms->Core, I11061, Array("hr"=>"cms_hst_resellers")); $aCustom["fields"] += Array( I11064=>Array(I11065=>"flagicon", "value"=>1, "id"=>"act_id", I11066=>$this->moduleName."_list:active_on","off"=>$this->moduleName."_list:active_off"), "username"=>Array(I11065=>I11067, "size"=>50), "reseller_name"=>Array(I11065=>I11067, "size"=>100), "clients_count" => Array(I11065=>I11068, "object"=>&$this, "method"=>"_FormatClientsCount"), "actions"=>Array(I11065=>I11069, "set"=>$this->moduleName."_list:icons_edit_reset_delconfirm", "id"=>Array("edit_id", I11070, "reset_id")), );$aCustom["applied_id"] ="m.id"; $aCustom["legend"] =Array(I11071, "notactive", "leg_red", "leg_yellow", "leg_blue", I11072, "leg_reset", "leg_del"); $aCustom["form_data"]["buttons"] =Array(I11073, "apply", "cancel", I11052); parent::TTTlI11($vData, $aCustom); }function TTTll11($cId, $cModule) {$IlIl1LI =$this->cms->VarsPost; $id_user =$this->user->TI1ITlT($this->cms, $this->db, $IlIl1LI, false, false); if($id_user >0) {$this->appliedId =$id_user; $this->browser->SetApplied($this->db, $asql, $this->langData); $this->SetLastError(); $this->cms->AddStatusMsg("status_add"); }else {$this->itemData =removeSpecial($IlIl1LI, "slashes"); $this->SetLastError(1, I11074); $this->cms->AddStatusMsg("status_add_fail", "red"); }}function TTTl1Tl($cId, $cModule) {parent::TTTl1Tl($cId, $cModule); $sql ="SELECT m.* FROM cms_hst_resellers hr ". "INNER JOIN cms_members m ON m.id = hr.id_member ". "WHERE hr.id='$cId'".$this->_ApplyFilters(); $this->db->query($sql); if($this->db->next_record()) {$this->itemData =$this->db->Record; $this->itemData[I11075] =$this->itemData["companyweb"]; }$this->cms->Gui->AddGlobalVars(Array("EMPTY_PASSWORD" => "1")); }function _ActionDel($cId, $cModule) {$form =Array(); $form["id"] =$cId; $lILILIl =$this->TIlTT1I($this->langData); $form[I11076] =I11058; if(count($lILILIl)) {foreach ($lILILIl as $lIL1l11) {if($lIL1l11['id'] != $cId) {$form[I11076] .= $this->cms->Gui->getAbs($this->moduleName."_subform:reseller_option", $lIL1l11); }}}$ILLILI1 =Array(); $I1L1l1l =Array(); $I1L1l1L =I11058; $form["content"] =$this->cms->Gui->getAbs($this->moduleName."_subform:del_popup_form", $form +$ILLILI1); $form[I11077] =$this->cms->Words["choose_delete_type"]; $form["form_align"] ="align=center"; $IILIIIL ="del_popup"; parent::TTT1I1I($form, $IILIIIL); }function TIIITlT($cId) {$res =true; if($cId >0) {if ($this->cms->Vars[I11078] == "del") {$lI1ll1I =$this->TIlII1T($cId); if(count($lI1ll1I)) {$type =$this->cms->Vars[I11078]; $IIlIII1 =$this->cms->VarsPost; $IIlIIlI =$this->cms->VarsGet; $oldVars =$this->cms->Vars; $lI1ll1l =$this->cms->Core->GetModule('hst_clients'); $lI1ll1l->InitEngine($this->cms, $this->db); $lI1ll1l->Engine->side =$this->side; $lI1ll1l->Engine->realSide =$this->realSide; $lI1ll1l->Engine->Init(); $lI1ll1l->Engine->SetRedirect(false); foreach ($lI1ll1I as $idMember) {$lI1ll1L =true; $this->cms->VarsPost =array('type' => $this->cms->Vars[I11078]); $this->cms->VarsGet =array(); $this->cms->Vars =$this->cms->VarsPost; $lI1ll1l->Engine->SetLastError(); $lI1ll1l->Engine->ProcessAction('del_confirm', $idMember); if($lI1ll1l->Engine->errno) {$res =false; }}$this->cms->VarsPost =$IIlIII1; $this->cms->VarsGet =$IIlIIlI; $this->cms->Vars =$oldVars; if (!$res) {}}}else {$newId =intval($this->cms->Vars[I11079]); if($newId) {$sql ="update cms_hst_clients set id_reseller='$newId' where id_reseller='$cId'"; if (!$this->db->execute($sql)) {$res =false; }}else {$res =false; }}if ($res) {$this->user->TI1ITll($this->cms, $this->db, $cId); }}if ($res) {$this->cms->AddStatusMsg("status_del"); $this->SetLastError(); }else {$this->cms->AddStatusMsg("status_del_fail", "red"); $this->SetLastError(3, "Deleting failed"); }}function TTTl1lI($cId, $cModule) {$IlIl1LI =$this->cms->VarsPost; if ($IlIl1LI[I11080] == I11058) {unset($IlIl1LI[I11080]); $this->user->SetObligatory(I11080); }$id_user =$this->user->TI1ITlI($this->cms, $this->db, $cId, $IlIl1LI, true); if($id_user >0) {$is_hash =!empty($this->cms->VarsPost["password_hash"]); if($is_hash || (!empty($this->cms->VarsPost["password"]) && $this->cms->VarsPost["password"]==$this->cms->VarsPost["password2"])) {$this->user->TTI1I1l(I11080, $this->cms->VarsPost[I11080]); $this->user->TTI1I1l(I11081, $cId); $this->user->setPass($this->db, $is_hash ?$this->cms->VarsPost["password_hash"] :$this->cms->VarsPost["password"], $is_hash); }$this->appliedId =$id_user; $this->browser->SetApplied($this->db, $asql, $this->langData); $this->SetLastError(); $this->cms->ClearMessages(); $this->cms->AddStatusMsg("status_apply"); }else {$this->itemData =removeSpecial($IlIl1LI, "slashes"); $this->SetLastError(2, I11082); $this->cms->AddStatusMsg("status_apply_fail", "red"); }}function _ActionActivate($cId, $cModule) {$active ="0"; if (isset($this->cms->VarsGet[I11054]) && $this->cms->VarsGet[I11054] == I11066) {$active ="1"; }if($this->user->TT1I1Tl($this->cms, $this->db, $cId, $active)) {$this->cms->AddStatusMsg(I11083); }else {$this->cms->AddStatusMsg("status_activate_fail", "red"); }$this->appliedId =$cId; $this->browser->SetApplied($this->db, $asql, $this->langData); }function TIITTl1(&$aGroupIds, $cModule) {$this->cms->VarsGet[I11054] =I11066; $this->TTTl1II($aGroupIds, $cModule, "_ActionActivate", "status_grp_activate"); }function TIITT1T(&$aGroupIds, $cModule) {$this->cms->VarsGet[I11054] =I11084; $this->TTTl1II($aGroupIds, $cModule, "_ActionActivate", "status_grp_unactivate"); }function _ActionReset($cId, $cModule) {$this->user->TTI1lIl($this->cms, $this->db, $cId, true); $this->cms->AddStatusMsg("status_reset"); $this->appliedId =$cId; $this->browser->SetApplied($this->db, $asql, $this->langData); }function TIITT1I(&$aGroupIds, $cModule) {$this->TTTl1II($aGroupIds, $cModule, "_ActionReset", I11085); }function _FormatClientsCount(&$vItem, &$vData) {$vItem['clients_count'] =FormatNumber($vItem['clients_count'], 0, 0); }function TIlTT1I($langData =I11049) {$lILILIl =Array(); $sql ="SELECT hr.id, hr.id_member, CONCAT_WS(' ', m.lastname, m.firstname) as name, hr.is_active FROM cms_hst_resellers hr INNER JOIN cms_members m ". "WHERE m.id=hr.id_member ".(empty($langData) ?I11058 :" and m.lang='$langData'"); $this->db->query($sql); while ($this->db->next_record()) {$lILILIl[intval($this->db->Record[I11086])] =$this->db->Record; }return $lILILIl; }function TIlII1T($cId) {$aRes =Array(); if($cId >0) {$sql ="SELECT id_member FROM cms_hst_clients WHERE id_reseller='$cId'"; $res =&$this->db->select($sql); while ($record =$res->nextRecord()) {$aRes[] =$record['id_member']; }}return $aRes; }}?>