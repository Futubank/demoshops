<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       28264 xkqwwplsyzixxtxprrskunxlzqxltgtzgxlirqkywqruqlntqxgtpltpxztwmpggxqyupnir
 */ ?><?php foreach(array(10490=>'SQfZuJt|GrQfMx',10491=>"ZWtMvQ|Hn",10492=>"ZWtMvZtQ",10493=>"SQJ",10494=>'OW',10495=>"",10496=>"PrG|ZWtMvQ|Hff",10497=>"SZtQfrHI",10498=>"fJt|uDQrnZIQ",10499=>"fJt|WJMQntnZIQ",10500=>"fJt|QIZMJ",10501=>'MS',10502=>'DQJQWtQS',10503=>"I",10504=>"I_OW",10505=>"ZWtMHn",10506=>"Hn",10507=>"WZJJYZWK",10508=>"WJMQnt|nZIQ",10509=>"IQtOHS",10510=>"ZGGJMQS|MS",10511=>"JQP|rQS",10512=>"JQP|SQJ",10513=>"WZnWQJ",10514=>'IQIYQr|SZtZ',10515=>"1",10516=>"DtZtuD|SQJ",10517=>"uDQrnZIQ",10518=>"MS",10519=>"zGGJB?fZMJQS",10520=>"|zWtMHnzWtMvZtQ",10521=>'tDtZIG',10522=>'YZWKurJ',10523=>'MS|rQDQJJQr',10524=>'MD|rQDQJJQr',10525=>'MS|IQIYQr',10526=>'rQDQJJQr|nZIQ',10527=>"zWWQDD?vMHJZtMHn`") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ModuleHstClients extends ModuleHst {public $user; public $lILILIl; function ModuleHstClients(&$cms, &$db, &$cModule) {$this->user =false; $this->lILILIl =Array(); parent::ModuleHst($cms, $db, $cModule); }function _Init($IIll1l1 =Array(), $IIll1LI ='', $IIll1Ll ='', $aOptions =Array()) {$IIIIL11[I10490] ='m'; $IIIIL11["lang_data"] =false; $IIIIL11['check_public'] =false; $IIIIL11['group_operations'] =Array(I10491, "active_off", "reset", "del"); $IIIIL11["allowed_actions"] =Array(I10492, "add", "edit", "apply", "save", I10493, "reset"); $IIIIL11["reseller_field"] ="hc.id_reseller"; $IIIIL11["filter_client_table"] =I10494; $aOptions += $IIIIL11; parent::_Init($IIll1l1, $IIll1LI, $IIll1Ll, $aOptions); require_once $GLOBALS['CLASSES_PATH'] .'CMS_Member.php'; require_once $GLOBALS['CLASSES_PATH'] .'Client.php'; $none =I10495; $this->user =new Client($none); $this->lILILIl =$this->TIlTT1I($this->db); $this->TIlTT11(false, '', $this->lILILIl); }function _InitAdmin() {parent::_InitAdmin(); }function TTTlITT($IIIL11l, $cId, $cModule =I10495) {switch ($IIIL11l) {case "del_confirm": $this->TIIITlT($cId, $cModule); break; case I10492: $this->_ActionActivate($cId, $cModule); break; case "reset": $this->_ActionReset($cId, $cModule); break; case "grp_active_on": $this->TIITTl1($this->aGroupIds, $cModule); break; case I10496: $this->TIITT1T($this->aGroupIds, $cModule); break; case "grp_reset": $this->TIITT1I($this->aGroupIds, $cModule); break; case "import": $this->redirect =false; $this->TTIITT1($cId, $cModule); break; case 'export': $this->redirect =false; case "special": $this->TIlTTIl($cId,$cModule); break; default: parent::TTTlITT($IIIL11l, $cId, $cModule); break; }}function TTTlIII() {parent::TTTlIII(); if($this->filter->issetField(I10497)) $this->filter->TITI1l1(I10497); if($this->filter->issetField("dateto")) $this->filter->TITI1l1("dateto"); if(!$this->TTTTlTI()) {$this->filter->AddField("flt_username", "text", stripslashes(unhtmlentities($this->cms->Vars[I10498])), I10495, " like ", "m.username"); $this->filter->AddField("flt_clientname", "text", stripslashes(unhtmlentities($this->cms->Vars[I10499])), I10495, " like ", "CONCAT_WS(' ', m.lastname, m.firstname)"); $this->filter->AddField("flt_email", "text", stripslashes(unhtmlentities($this->cms->Vars[I10500])), I10495, " like ", "m.email"); }}function TTTlI1I(&$vData) {$vars =array( 'IS_ADMIN' => intval($this->TTTTIIl()), );$this->cms->Gui->addGlobalVars($vars); $I1lLII1 =$this->user->getScripts($this->cms, "hst_clients"); $vData["header_memeber_script"] =$I1lLII1["header"]; $vData["check_member_script"] =$I1lLII1["check_form"]; if($this->action != "add") {$vData["on_change_member_script"] =$I1lLII1["on_change"]; }$vData["member_form"] =$this->user->getForm($this->cms, $this->db, $this->itemData); $vData["resellers_options"] =I10495; if (count($this->lILILIl)) {foreach ($this->lILILIl as $lIL1l11) {if($lIL1l11['id_member'] != $this->itemData[I10501]) {$lIL1l11['selected'] =0; if(isset($this->itemData['id_reseller']) && $this->itemData['id_reseller'] == $lIL1l11['id_member']) {$lIL1l11[I10502] =1; }$vData["resellers_options"] .= $this->cms->Gui->get($this->moduleName."_subform:reseller_option", $lIL1l11); }}}parent::TTTlI1I($vData); }function TTTlI11(&$vData, &$aCustom) {$aCustom += array("custom_filter" => I10495); $tables =Array("tables"=>Array(I10503=>"cms_members", "hc"=>"cms_hst_clients"), "joins"=>Array(I10504=>"hc.id_member=m.id"), "joins_types"=>Array(I10504=>'INNER') );$lIL1LIl =I10495; if($this->TTTTII1()) {}$this->browser->InitSQL("m.id, hc.is_reseller, hc.id_reseller as reseller_name, m.username, CONCAT_WS(' ', m.lastname, m.firstname) as client_name, ". "m.email, (m.active & hc.is_active) as active, (m.active & hc.is_active) as is_active ", $tables, "WHERE 1 ".$this->_ApplyFilters().$aCustom["custom_filter"].$lIL1LIl.$this->TTTlIl1(), I10495, "name", I10495, Array("active"=>"(m.active & hc.is_active)"), _DB_STRAIGHT_JOIN );$this->browser->AddSQLJoinedTables($this->cms->Core, I10503, Array("hc"=>"cms_hst_clients")); $aCustom["fields"] += Array( "active"=>Array(I10505=>"flagicon", "value"=>1, "id"=>"act_id", I10506=>$this->moduleName."_list:active_on","off"=>$this->moduleName."_list:active_off"), "username"=>Array(I10505=>I10507, "size"=>50, "object"=>&$this, "method"=>'_LoginCB'), I10508=>Array(I10505=>"stripline", "size"=>100), "proseed_fields" => Array(I10505=>I10507, "object"=>&$this, I10509=>"_ApplyFieldsCB"), "actions"=>Array(I10505=>"actions", "set"=>$this->moduleName."_list:icons_edit_reset_del", "id"=>Array("edit_id", "del_id", "reset_id")), );$aCustom[I10510] ="m.id"; $aCustom["legend"] =Array("onactive", "notactive", I10511, "leg_yellow", "leg_blue", "leg_edit", "leg_reset", I10512); $aCustom["form_data"]["buttons"] =Array("add", "apply", I10513, "save"); parent::TTTlI11($vData, $aCustom); }function TTTll11($cId, $cModule) {$lIL1LIL =Array( 'item_data' => $this->TTT1IlI(Array(), $cId), 'member_data' => $this->cms->VarsPost, );$id_user =$this->user->TT1Il1l($this->cms, $this->db, $lIL1LIL, false, false); if($id_user >0) {$this->appliedId =$id_user; $this->browser->SetApplied($this->db, $asql, $this->langData); $this->SetLastError(); $this->cms->AddStatusMsg("status_add"); }else {$this->itemData =removeSpecial($lIL1LIL[I10514], "slashes"); $this->SetLastError(1, "Adding failed"); $this->cms->AddStatusMsg("status_name_exist", "red"); }}function TTTl1Tl($cId, $cModule) {$this->TIlTITI($cId); parent::TTTl1Tl($cId, $cModule); $sql ="SELECT hc.id_reseller, hc.is_reseller, m.* FROM cms_hst_clients hc ". "INNER JOIN cms_members m ON m.id=hc.id_member ". "WHERE hc.id_member='$cId'".$this->_ApplyFilters(); $this->db->query($sql); if($this->db->next_record()) {$this->itemData =$this->db->Record; $this->itemData["website"] =$this->itemData["companyweb"]; }$this->cms->Gui->AddGlobalVars(Array("EMPTY_PASSWORD" => I10515)); $lIL1LI1 =0; if($this->itemData['is_reseller']) {if($this->TIlTITT($this->itemData[I10501])) {$lIL1LI1 =1; }}$this->cms->Gui->addGlobalVars(Array('HAVE_CLIENTS' => $lIL1LI1)); }function _ActionDel($cId, $cModule) {$this->TIlTITI($cId); $res =true; if(isset($this->lILILIl[$cId])) {if($this->TIlTITT($cId)) {$res =false; $this->cms->AddStatusMsg("have_clients_alert", "red"); $this->cms->AddStatusMsg("status_del_reseller_fail", "red"); }else {$this->user->TT1I1TT($this->cms, $this->db, $cId); $this->cms->AddStatusMsg("status_del_reseller"); }}else {$sql ="SELECT id FROM cms_hst_subscription WHERE id_member='$cId'"; $this->db->query($sql); if($this->db->next_record()) {$res =false; $this->cms->AddStatusMsg("status_del_fail", "red"); }else {$this->user->TT1I1TT($this->cms, $this->db, $cId); $this->cms->AddStatusMsg(I10516); }if ($res) {$this->SetLastError(); }else {$this->SetLastError(3, "Delete failed"); }}}function TTTl1lI($cId, $cModule) {$this->TIlTITI($cId); $lIL1LIL =Array( 'item_data' => $this->TTT1IlI(Array(), $cId), I10514 => $this->cms->VarsPost, );if ($lIL1LIL[I10514]["username"] == I10495) {unset($lIL1LIL[I10514]["username"]); $this->user->SetObligatory(I10517); }$id_user =$this->user->TT1Il11($this->cms, $this->db, $cId, $lIL1LIL, true); if($id_user >0) {$is_hash =!empty($this->cms->VarsPost["password_hash"]); if($is_hash || (!empty($this->cms->VarsPost["password"]) && $this->cms->VarsPost["password"]==$this->cms->VarsPost["password2"])) {$this->user->TTI1I1l(I10517, $this->cms->VarsPost[I10517]); $this->user->TTI1I1l(I10518, $cId); $this->user->setPass($this->db, $is_hash ?$this->cms->VarsPost["password_hash"] :$this->cms->VarsPost["password"], $is_hash); }$this->appliedId =$id_user; $this->browser->SetApplied($this->db, $asql, $this->langData); $this->SetLastError(); $this->cms->AddStatusMsg("status_apply"); }else {$this->itemData =removeSpecial($lIL1LIL[I10514], "slashes"); $this->SetLastError(2, I10519); $this->cms->AddStatusMsg("status_apply_fail", "red"); }}function _ActionActivate($cId, $cModule) {$this->TIlTITI($cId); $active ="0"; if (isset($this->cms->VarsGet[I10492]) && $this->cms->VarsGet[I10492] == I10506) {$active =I10515; }if($this->user->TT1I1TI($this->cms, $this->db, $cId, $active)) {$this->cms->AddStatusMsg("status_activate"); }else {$this->cms->AddStatusMsg("status_activate_fail", "red"); }$this->appliedId =$cId; $this->browser->SetApplied($this->db, $asql, $this->langData); }function TIITTl1(&$aGroupIds, $cModule) {$this->cms->VarsGet[I10492] =I10506; $this->TTTl1II($aGroupIds, $cModule, "_ActionActivate", "status_grp_activate"); }function TIITT1T(&$aGroupIds, $cModule) {$this->cms->VarsGet[I10492] ="off"; $this->TTTl1II($aGroupIds, $cModule, I10520, "status_grp_unactivate"); }function _ActionReset($cId, $cModule) {$this->TIlTITI($cId); $this->user->TTI1lIl($this->cms, $this->db, $cId, true); $this->cms->AddStatusMsg("status_reset"); $this->appliedId =$cId; $this->browser->SetApplied($this->db, $asql, $this->langData); }function TIITT1I(&$aGroupIds, $cModule) {$this->TTTl1II($aGroupIds, $cModule, "_ActionReset", "status_grp_reset"); }function TIlTTIl($cId, $cModule) {global $conn; if (!$this->TTTTIIl() && !$this->TTTTII1()){ trigger_error("SECURITY: attempt to login to account ".$this->cms->VarsPost[I10501]." by user ID: ".$this->TTTTlII().", domain=".$this->TTTTIlT(),E_USER_WARNING); return; }$hash ='a208'; $time =time(); $sql ="SELECT m.* FROM cms_members m WHERE m.id=".$this->cms->VarsPost[I10501]; $member =$this->db->GetRecord($sql); if(empty($member)) {trigger_error('Cannot find member '.$this->cms->VarsPost[I10501], E_USER_ERROR); }$hsid =md5($member['password'].$hash.$time); $vars =array('admin_url'=>'', 'hsid'=>$hsid, I10521=>$time, 'loginname'=>$member['username'], 'domain'=>'_client_', I10522=>htmlspecialchars($this->cms->Vars['script_link'])); echo $this->cms->Gui->get("hst_clients_list:login_form", $vars); $conn->Out(); die(); }function TTT1IlI($aSql =Array(), $cId =0) {if($this->resellerId == 0) {$id_reseller =intval($this->cms->VarsPost['reseller']); if(!isset($this->lILILIl[$id_reseller])) {$id_reseller =0; }$aSql['id_reseller'] =$id_reseller; }else {$aSql[I10523] =$this->resellerId; }if($this->cms->VarsPost[I10501]) {$is_reseller =1; if($this->cms->VarsPost['is_reseller'] != 'on' && $this->TIlTITT($this->cms->VarsPost[I10501]) == 0) {$is_reseller =0; }}else {if($this->cms->VarsPost['is_reseller'] == 'on') {$is_reseller =1; }else {$is_reseller =0; }}$aSql += array(I10524 => $is_reseller); $aSql =parent::TTT1IlI($aSql, $cId); return $aSql; }function TIlTITT($idMember) {$sql ="select id from cms_hst_clients where id_reseller='$idMember'"; $res =$this->db->select($sql); $cnt =0; while ($res->nextRecord()) {$cnt++; }return $cnt; }function TIlTT1I(&$db, $langData ='') {$lILILIl =Array(); $sql ="SELECT hc.id_member, CONCAT_WS(' ', m.lastname, m.firstname) as name, hc.is_active FROM cms_hst_clients hc INNER JOIN cms_members m ON m.id=hc.id_member ". "WHERE hc.is_reseller=1 ".(empty($langData) ?I10495 :" and m.lang='$langData'")." ORDER BY m.lastname, m.firstname"; $db->query($sql); while ($db->next_record()) {$lILILIl[intval($db->Record[I10525])] =$db->Record; }return $lILILIl; }function _ApplyFieldsCB(&$vItem, &$vData) {if($vItem['reseller_name'] >0) {$vItem['reseller_name'] =$this->lILILIl[$vItem['reseller_name']]['name']; }else {$vItem[I10526] =$this->words['none']; }if($vItem[I10524] == 1) {$vItem['clients_count'] =FormatNumber($this->TIlTITT($vItem[I10501]), 0, 0); }else {$vItem['clients_count'] ="-"; }$vItem['encoded_client_name'] =urlencode($vItem['client_name']); }function _LoginCB(&$vItem, &$vData) {$vItem["username_simple"] =$vItem[I10517]; $vItem[I10517] =$this->cms->Gui->getAbs("hst_clients_list:username_login", $vItem); }function TIlTITI($cId) {$res =false; $sql ="select 1 from cms_members m INNER JOIN cms_hst_clients hc ON hc.id_member=m.id WHERE m.id=".intval($cId).$this->_ApplyFilters(); $this->db->query($sql); if($this->db->numRows() >0) {$res =true; }if(!$res) {trigger_error(I10527, E_USER_ERROR); }}}?>