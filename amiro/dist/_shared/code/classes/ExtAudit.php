<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       32122 xkqwzxklurzqyzytxttnypsqrguqluutpgsxltryzxzgmmittqnyuqirpqwxrlqylpxgpnir
 */ ?><?php foreach(array(4563=>"ZGGJB",4564=>"nHt|GuYJMDO",4565=>'zuSMthYLQWt`GOG',4566=>"qXTqNdmhN|zUsmT",4567=>"|DuYfHrI",4568=>"dqjqwT|dTzTUd",4569=>"ZuSMt|WOQWK|fHrI",4570=>"tGJ|YJHWK",4571=>"%ZuSMt|HCnQr|rHC",4572=>"JZDt|QSMtQS|MS",4573=>'WID|IQIYQrD',4574=>"HCnQrD|JMDt|DMAQ",4575=>"fMQJS|",4576=>"rQEuMrQS|MtQID",4577=>"ZuSMt|OMDtHrB",4578=>"IQtOHS",4579=>"nHnQ",4580=>"Qxt|ZWtMHn",4581=>"GurPQ",4582=>"ZGGrHvQ",4583=>"MS|HCnQr",4584=>"OtIJ|nZIQ",4585=>"IHSuJQ",4586=>"IHSuJQ|nZIQ",4587=>"ihsUjq|zsimN|URj",4588=>"ihsUjq|FRhNT|URj",4589=>"RhhT|gzTo|ccc",4590=>"ZuSMt|nHtMfMWZtMHn",4591=>"fHHtQr",4592=>"IHSuJQ|DQt|GZrt",4593=>"DtZtuD|DQt|GZrt",4594=>"DQt|GZrZID",4595=>"'",4596=>"DQnS|nHtMfMWZtMHn",4597=>"|",4598=>"JZDtnZIQ",4599=>"?fZMJQS",4600=>"GMWturQ",4601=>"{?pRhUg?yb?MS|MtQI",4602=>"MS",4603=>"uDQrnZIQ",4604=>"ZWtMHn",4605=>"ZuSMt|DtZtuD",4606=>"<ZnWOHr'@",4607=>"ZuSMt|WHIIQntD",4608=>"HCnQr",4609=>"MS|ZWtHr",4610=>"GuYJMW",4611=>"ZD|MD",4612=>"QnZYJQS",4613=>"",4614=>"RhhT|gzTo",4615=>"fMQJSD",4616=>"ZSIMn") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ExtAudit extends CMS_ExtModule {public $realSide; public $ILLLLlI; public $ILLLLll; public $ILLLLlL; public $ILLLLl1; public $ILLLLLI; public $offset; public $words; public $ILLLLLl; public $II1lIl1; public $ILLLLLL; function ExtAudit() {$this->ILLLLlI =null; $this->ILLLLlL =false; $this->offset =0; $this->words =Array(); parent::CMS_ExtModule(); }function Init(&$cms, &$IlIlIl1, &$IlIlILI) {$this->realSide =$cms->Core->Side; $this->ILLLLlL =$cms->Core->IsModerator($IlIlIl1->GetName(), intval($cms->Core->GetUserId())); $ILLLLL1 =&$cms->Core->GetModule('srv_audit'); $this->ILLLLl1 =$ILLLLL1->GetAdminLink(); $this->ILLLLll =Array(); $this->ILLLLLl =Array(); $this->II1lIl1 =Array("add", I4563, "edit", "del", "publish"); $this->ILLLLLL =Array("add" => I4564, I4563 => I4564, "del" => I4564); $cms->Gui->AddGlobalVars(Array("EXT_AUDIT" => '1')); parent::Init($cms, $IlIlIl1, $IlIlILI); require_once $GLOBALS['CLASSES_PATH'] .I4565; $this->ILLLLlI =new AuditObject($this->cms, $this->mod->db); }function GetModuleName() {return "ext_audit"; }function ProcessAction(&$IIIL11l, $cId, &$aItemData, &$vData, &$IILIILl) {if($this->activeModule->IssetOption("audit_actions_handling")) {$this->ILLLLLL =$this->activeModule->GetAOption("audit_actions_handling"); }$this->ILLLLLL["edit"] =$this->ILLLLLL[I4563]; parent::ProcessAction($IIIL11l, $cId, $aItemData, $vData, $IILIILl); }function TTIlI11($cId, &$vItemData, &$vData, &$IILIILl) {$this->cms->Gui->addGlobalVars(Array(I4566=>"1")); parent::TTIlI11($cId, $vItemData, $vData, $IILIILl); }function TTIllIl($cId, &$vItemData, &$vData, &$IILIILl) {if($this->realSide == "admin") {}else {$this->mod->browser->ShowPageSizeBox =false; }}function TTIllI1($cId, &$vItemData, &$vData, &$IILIILl) {if($this->realSide == "admin") {$this->TITTlI1($cId, $vItemData, $vData, $IILIILl); }else {$this->TITTllT($cId, $vItemData, $vData, $IILIILl); }}function TITTlIl(){ return "templates/_mod_audit_form.tpl"; }function TITTlI1($cId, &$vItemData, &$vData, &$IILIILl){ if($this->ILLLLlL) {$this->cms->Gui->copyBlock($this->mod->moduleName.I4567, "audit_form"); $this->cms->Gui->mergeBlock("audit_form", $this->TITTlIl(), false); $this->words =$this->cms->Gui->parseLangFile("templates/lang/audit_form.lng"); if(!$this->ILLLLlI->TTTT1Il()) {if(!$this->ILLLLlI->Init(0, $this->activeModule->GetName())) {trigger_error("Audit object was not initialized",E_USER_ERROR); }}if($this->ILLLLlI->TTTT1lT() || $this->ILLLLlI->TTTT1lI()) {$vData[I4568] =1; $vData["select_".$this->ILLLLlI->GetStatus()] ="selected"; $vData["audit_comments"] =$this->ILLLLlI->GetComment(); $vData["audit_select_status"] =$this->cms->Gui->get("audit_form:audit_select_status", $vData); $vData["audit_history"] =$this->TITT1TT(); $vData["audit_admin_link"] =$this->ILLLLl1; $vData["audit_record_id"] =$this->ILLLLlI->id; }else {$vData["audit_status"] =$this->mod->words[$this->ILLLLlI->GetStatus()]; }$vData[I4569] =$this->cms->Gui->get("audit_form:audit_check_form", $vData); $aListData =Array( "audit_current_owner" => $this->ILLLLlI->TTTT11I(), "audit_current_owner_name" => $this->ILLLLLl[$this->ILLLLlI->TTTT11I()]["username"], );$aCustom =Array( I4570 => "audit_form", "tpl_hidden_field_postfix" => ":audit_owner_hidden", "tpl_row_postfix" => I4571, "tpl_list_postfix" => ":audit_owner_list", "tpl_single_item_postfix" => ":audit_owner_single", I4572 => $this->ILLLLlI->TTTT11I(), "list_data" => $aListData, );$this->activeModule->PushPager($this->mod->browser); $this->mod->browser->InitSQL("id, username, firstname, lastname", Array('tables'=>Array('m'=>I4573)), "WHERE 1"); $this->mod->browser->SetForceRules("order by username asc"); $vData["audit_owner"] =$this->mod->TTT1lII($this->mod->db, $this->cms->Core->GetModOption("srv_audit", I4574), $aCustom); $this->activeModule->PopPager($this->mod->browser); $vData["audit_form"] =$this->cms->Gui->get("audit_form", $vData); $this->TITTl1I($IILIILl); }}function TITTllT($cId, &$vItemData, &$vData, &$IILIILl){ $this->words =&$this->mod->words; $ILLLL1I =$this->activeModule->TTlTTTI("required_fields"); foreach($ILLLL1I as $key => $name) {$ILLLL1I[$key] ="field_".$name; }$aRequiredFields =$ILLLL1I; $ILLLL1l =$this->activeModule->GetAOption("audit_displayed_fields"); foreach($ILLLL1l as $field => $status) {if($status == "visible") {$ILLLL1I[] =$field; }}$ILLLL1L =$this->activeModule->GetAOption("audit_required_fields"); foreach($ILLLL1L as $num => $field) {if(!in_array($field, $aRequiredFields) && in_array($field, $ILLLL1I)) {$aRequiredFields[] =$field; }}$aPictures =$this->TITTl1T(); foreach($aPictures["disabled"] as $key => $val) {$aPictures["disabled"][$key] =I4575.$val; }$ILLLL1I =array_diff($ILLLL1I, $aPictures["disabled"]); foreach($ILLLL1I as $key => $name) {$vData["is_required"] =intval(in_array($name, $aRequiredFields)); $vData[$name] =$this->cms->Gui->get($this->mod->moduleName."_subform:".$name, $vData); }$vData["items"] =$this->cms->Gui->get($this->mod->moduleName."_subform:form_layout", $vData); $vData["required_items"] =""; foreach($aRequiredFields as $key => $name) {$vData["item"] =str_replace(I4575, "", $name); $vData[I4576] .= $this->cms->Gui->getDefPostf($this->mod->moduleName."_subform:required_item", "_".$vData["item"], $vData); }if($this->mod->action == "edit") {$vData[I4577] =$this->TITT1TT(); }$this->offset =$this->mod->browser->TI1TTll() -1; array_unshift($IILIILl["fields"], Array("action"=>"callback", "object"=>&$this, I4578=>"_GetOffsetCB")); $this->TITTl1I($IILIILl); $vData["audit_post_form"] =$this->cms->Gui->get($this->mod->moduleName."_subform:audit_post_form", $vData); }function TTIl1Il($cId, &$vItemData, &$vData, &$IILIILl){ $action =$IILIILl["ext_action"]; if(!$this->ILLLLlL && !in_array($action, $this->II1lIl1)) {$action =I4579; $this->mod->action =I4579; }if(!$this->ILLLLlL && $this->ILLLLLL[$action] == "reject") {$this->cms->AddStatusMsg("status_audit_reject", "red"); $action =I4579; $this->mod->action =I4579; }switch ($action) {case "del": if(!$this->ILLLLlL) {if(!$this->ILLLLlI->Init($cId, $this->activeModule->GetName())) {trigger_error("Audit object was not initialized",E_USER_ERROR); }$this->ILLLLlI->TTTT11T(intval($this->cms->Core->GetUserId())); $ILLLL11 =false; if(!$this->ILLLLlI->TTTT1lT()) {$ILLLL11 =true; }$this->ILLLLlI->TTTT1l1($action); if($ILLLL11) {$this->TITTll1("moderator"); }if($this->mod->options["check_public"] && $this->ILLLLLL[$action] == I4564) {$this->mod->forceRedirect =false; $this->mod->ProcessAction($a ="publish", $cId); }$this->mod->action =I4579; $this->cms->AddStatusMsg("status_audit_del"); }break; }}function TTIl1I1($cId, &$vItemData, &$vData, &$IILIILl){ $action =$IILIILl[I4580]; if(in_array($action, Array("add", I4563, "del", "edit"))) {if(!$this->ILLLLlI->Init((empty($this->mod->appliedId))? $cId: $this->mod->appliedId, $this->activeModule->GetName(), $this->mod->cms->VarsPost[$this->mod->options["name_field_name"]])) {trigger_error("Audit object was not initialized",E_USER_ERROR); }}if(!$this->ILLLLlL) {unset($this->mod->cms->VarsPost["audit_status"]); }switch ($action) {case "add": case I4563: case "del": $IIIL1Ll =intval($this->cms->Core->GetUserId()); $this->ILLLLlI->TTTT11T($IIIL1Ll); if($this->ILLLLlL) {if($action == "del") {$this->ILLLLlI->TTTT1l1(I4581); $this->TITTll1("user"); }else {$this->ILLLLlI->SetComment($this->mod->cms->VarsPost["audit_comments"]); $ILLL1II =$this->TITTllI(); if($ILLL1II >0) {$this->ILLLLlI->SetOwner($ILLL1II, true); }$ILLL1Il =$this->mod->cms->VarsPost["audit_status"]; if(empty($ILLL1Il)) {if($this->activeModule->GetOption("audit_admin_changes")) {$this->ILLLLlI->TTTT1l1($action); $this->ILLLLlI->TTTT1l1(I4582); }else {if($ILLL1II >0) {$this->ILLLLlI->TTTT1l1(I4582); }}}else {$this->ILLLLlI->TTTT1l1($ILLL1Il); $this->TITTll1("user"); }}}else {$ILLLL11 =false; if(!$this->ILLLLlI->TTTT1lT()) {$ILLLL11 =true; }if($action == "add") {$this->ILLLLlI->SetOwner($IIIL1Ll); }$this->ILLLLlI->SetComment($this->mod->cms->VarsPost["audit_comments"]); $this->ILLLLlI->TTTT1l1($action); if($ILLLL11) {$this->TITTll1("moderator"); }}$this->ILLLLlI->Free(); break; }}function TTIllII($cId, &$vItemData, &$vData, &$IILIILl) {$ILLL1II =intval($this->TITTllI()); if($ILLL1II >0) {$vItemData[I4583] =$ILLL1II; }}function TITTllI() {$res =0; if(!empty($this->mod->cms->VarsPost["audit_new_owner"]) && $this->mod->cms->VarsPost["audit_new_owner"] != $this->ILLLLlI->TTTT11I()) {$res =$this->mod->cms->VarsPost["audit_new_owner"]; }return $res; }function TITTlll($ILLL1IL, $IIIII1L) {$ILLL1I1 =Array( "item_id" => $this->ILLLLlI->GetItemId(), I4584 => $this->ILLLLlI->TTTT11l(), "name" => stripslashes($this->ILLLLlI->TTTT11l()), I4585 => $this->activeModule->GetName(), I4586 => $this->words[$this->activeModule->GetName()], "audit_status" => $this->ILLLLlI->GetStatus(), "audit_status_name" => $this->mod->words[$this->ILLLLlI->GetStatus()], I4587 => $GLOBALS["ADMIN_PATH_WWW"].$this->activeModule->GetAdminLink(), I4588 => $GLOBALS[I4589].$this->TITT1TI($this->cms, $this->activeModule->GetName()), "note" => nl2br($this->ILLLLlI->GetComment()), "SITE" => $this->cms->Core->GetOption("company_url"), );foreach($this->cms->VarsPost as $name => $val) {if(!is_array($val)) {$ILLL1I1["post_".$name] =nl2br(stripslashes($val)); }}$bSend =($this->cms->VarsPost[I4590] == "force") || ($this->cms->VarsPost[I4590] != "dont" && $this->activeModule->issetOption(I4590) && $this->activeModule->GetOption(I4590)); $aData =Array( "send_notification" => $bSend, "template" => $GLOBALS["LOCAL_FILES_REL_PATH"]."_admin/templates/letters/audit_" .$this->mod->langData .".tpl", "header" => "mail_header", I4591 => "mail_footer", "common" => "mail", "recipient_set_part" => $ILLL1IL, I4592 => $this->activeModule->GetName(), I4593 => $IIIII1L, "from" => $this->cms->Core->GetOption("company_robot_email"), "from_name" => $this->cms->Core->GetOption("company_name"), I4594 => $ILLL1I1 );if($ILLL1IL == "moderator") {$aData["to"] =$this->cms->Core->GetOption("company_email"); }else {$recipientId =intval($this->ILLLLlI->TTTT11I()); $sql ="SELECT firstname, lastname, email as `to` FROM cms_members WHERE id='".$recipientId.I4595; $this->mod->db->query($sql); if($this->mod->db->next_record()) {$aData["to"] =$this->mod->db->Record["to"]; $aData[I4594] += $this->mod->db->Record; }}return $aData; }function TITTll1($ILLL1IL, $IIIII1L =false) {if($IIIII1L === false) {$IIIII1L =$this->ILLLLlI->GetStatus(); }$this->words += $this->cms->Gui->parseLangFile($GLOBALS["LOCAL_FILES_REL_PATH"]."_admin/templates/lang/audit.lng"); $ILLL1lI =$this->TITTlll($ILLL1IL, $IIIII1L); if($ILLL1lI[I4596]) {require_once($GLOBALS["CLASSES_PATH"]."Mailer.php"); $this->cms->Gui->addBlock(I4590, $ILLL1lI["template"]); $ILLL1ll =Array( $ILLL1lI["recipient_set_part"].I4597.$ILLL1lI[I4593].I4597.$ILLL1lI[I4592], $ILLL1lI["recipient_set_part"].I4597.$ILLL1lI[I4592], $ILLL1lI["recipient_set_part"].I4597.$ILLL1lI[I4593], $ILLL1lI["recipient_set_part"], );$ILLL1lL =$ILLL1ll; foreach(array_keys($ILLL1ll) as $key) {$ILLL1lL[$key] .= "_subject"; }$body =$this->cms->Gui->get("audit_notification:".$ILLL1lI["header"], $ILLL1lI[I4594]). $this->cms->Gui->getDefPostf("audit_notification:".$ILLL1lI["common"].I4597, $ILLL1ll, $ILLL1lI[I4594]). $this->cms->Gui->get("audit_notification:".$ILLL1lI[I4591], $ILLL1lI[I4594]); $subj =$this->cms->Gui->getDefPostf("audit_notification:".$ILLL1lI["common"].I4597, $ILLL1lL, $ILLL1lI[I4594]); $oMail =new Mailer(); $oMail->RecipientAddress =$ILLL1lI["to"]; $oMail->RecipientName =trim($ILLL1lI["firstname"]." ".$ILLL1lI[I4598]); $oMail->SenderAddress =$ILLL1lI["from"]; $oMail->SenderName =$ILLL1lI["from_name"]; $oMail->Subject =$subj; $oMail->Body =$body; $oMail->BodyFormat ="html"; $oMail->Prepare(); if(!$oMail->Send()){ trigger_error("ExtAudit:SendNotification sending email to ".$oMail->RecipientAddress.I4599, E_USER_WARNING); }}}function TITTl1T() {$aRes =Array(); $aRes["enabled"] =($this->activeModule->IssetOption("item_pictures"))? $this->activeModule->GetAOption("item_pictures"): Array(); $aRes["disabled"] =array_diff(Array(I4600, "popup_picture", "small_picture"), $aRes["enabled"]); return $aRes; }function TITTl1I(&$IILIILl){ $IlIlILl =$this->TTIlI1T(); if(!empty($IlIlILl)) {$sql ="SELECT max(id) as mid FROM cms_srv_audit WHERE id_item IN (".$IlIlILl.I4601; $this->mod->db->query($sql); $ids =""; while($this->mod->db->next_record()) {$ids .= ",".$this->mod->db->Record["mid"]; }$sql ="SELECT a.id, a.id_item, a.audit_status, a.comments, a.id_actor, m.username ". "FROM cms_srv_audit a LEFT JOIN cms_members m ON a.id_actor=m.id ". "WHERE a.id IN (0".$ids.")"; $this->mod->db->query($sql); while($this->mod->db->next_record()) {$this->ILLLLll[$this->mod->db->Record["id_item"]] =Array( "id" => $this->mod->db->Record[I4602], "audit_status" => $this->mod->db->Record["audit_status"], "role" => $this->words[$this->cms->Core->TTllIII($this->activeModule->GetName(), $this->mod->db->Record["id_actor"])], I4603 => $this->mod->db->Record[I4603], "audit_comments" => $this->mod->db->Record["comments"], );}}$IILIILl["fields"]["audit"] =Array(I4604=>"callback", "object"=>&$this, I4578=>"_GetAuditStatusCB"); }function _GetAuditStatusCB(&$aItem, &$aData) {$aItem["audit_status"] =empty($this->ILLLLll[$aItem[I4602]][I4605])? $this->mod->words["unknown"]: (($this->realSide == "admin")? "<a href='".$this->ILLLLl1."?action=locate&id=".$this->ILLLLll[$aItem[I4602]][I4602].I4606. $this->mod->words[$this->ILLLLll[$aItem[I4602]][I4605]]. "</a>": $this->mod->words[$this->ILLLLll[$aItem[I4602]][I4605]]); $aItem["audit_role"] =$this->ILLLLll[$aItem[I4602]]["role"]; $aItem["audit_username"] =$this->ILLLLll[$aItem[I4602]][I4603]; $aItem[I4607] =$this->cms->stripLine($this->ILLLLll[$aItem[I4602]][I4607], 30, true); }function _GetHistoryRowCB(&$vItem, &$vData) {$vItem["status"] =$this->words[$vItem["status"]]; $vItem["changed_by"] =$this->words[$this->cms->Core->TTllIII($this->activeModule->GetName(), $vItem["id_actor"])]; $vItem[I4608] =$this->ILLLLLl[$vItem[I4583]][I4603]; $vItem["firstname"] =$this->ILLLLLl[$vItem["id_actor"]]["firstname"]; $vItem[I4598] =$this->ILLLLLl[$vItem["id_actor"]][I4598]; $vItem[I4603] =$this->ILLLLLl[$vItem[I4609]][I4603]; $vItem["comments_short"] =$this->cms->stripLine($vItem["comments"], 30, true); }function _GetOffsetCB(&$aItem, &$aData) {$aItem["offset"] =$this->offset; }function TITTlII(&$cms, &$module, &$db) {return true; }function TITTl1l(&$modEngine){ if(is_object($modEngine)) $modEngine->realSide =$this->realSide; $this->TITTl11(); }function TITTl11() {switch($this->ILLLLLL[$this->cms->Vars[I4604]]) {case I4564: $this->cms->Vars["public"] =0; $this->cms->VarsPost[I4610] =0; $this->cms->Vars["publish"] =""; $this->cms->VarsPost["publish"] =""; break; case I4611: $sql ="SELECT public FROM ".$this->activeModule->GetTableName()." WHERE id='".$this->cms->Vars[I4602].I4595; $this->mod->db->query($sql); $this->mod->db->next_record(); $public =$this->mod->db->Record[I4610]; $this->cms->Vars[I4610] =intval($public); $this->cms->VarsPost[I4610] =intval($public); $this->cms->Vars["publish"] =$public; $this->cms->VarsPost["publish"] =$public; break; }$aPictures =$this->TITTl1T(); foreach($aPictures[I4612] as $ILLL1l1) {$ILLL1LI ="file_".$ILLL1l1; if(!empty($this->cms->VarsPost["delete_".$ILLL1l1])) {$this->cms->VarsPost[$ILLL1l1] =""; }elseif($_FILES[$ILLL1LI]["name"] != I4613) {$ILLL1Ll =$GLOBALS["CUSTOM_PICTURES_HTTP_PATH"]."z_".sprintf("%06d",$this->cms->Core->GetUserId())."/"; $ILLL1LL =$GLOBALS[I4614].$ILLL1Ll; if(!is_dir($ILLL1LL)) {if(!mkdir($ILLL1LL, 0777, true)) {trigger_error("Unable to create user pictures dir: ".$ILLL1LL, E_USER_WARNING); break; }else {chmod($ILLL1LL, 0777); }}$filename =$this->cms->TTITI11(stripslashes($_FILES[$ILLL1LI]["name"])); if($this->cms->doUploadImage($_FILES[$ILLL1LI], $ILLL1LL.$filename)) {$this->cms->Vars[$ILLL1l1] =$ILLL1Ll.$filename; $this->cms->VarsPost[$ILLL1l1] =$this->cms->Vars[$ILLL1l1]; }}}}function TITT1TT() {$aHistory =$this->ILLLLlI->TTTT111(); $ILLL1L1 =Array( "items" => I4613, "tpl_list_postfix" => ":audit_history_list", "tpl_row_postfix" => ":audit_history_row", "tpl_empty_list_postfix" => ":audit_history_list_empty", I4615 => Array( "history" => Array(I4604 => "callback", "object"=>&$this, I4578=>"_GetHistoryRowCB"), ),);if($this->realSide == I4616) {$ILLL1L1[I4570] ="audit_form"; }$ILLL11I ="0"; foreach($aHistory as $key=>$val) {$ILLL11I .= ",".$val[I4609].",".$val[I4583]; }$sql ="SELECT id, firstname, lastname, username FROM cms_members WHERE id IN (".$ILLL11I.")"; $this->mod->db->query($sql); while($this->mod->db->next_record()) {$this->ILLLLLl[$this->mod->db->Record[I4602]] =$this->mod->db->Record; }return $this->mod->TTT1lT1(serialize($aHistory), $ILLL1L1); }function TITT1TI(&$cms, $IIIL1LL) {$res =$cms->Core->GetModFrontLink("srv_audit_".$IIIL1LL); return $res; }}