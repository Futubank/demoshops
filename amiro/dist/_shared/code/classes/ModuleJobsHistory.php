<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       40523 xkqwruusswlkgwkpyrwktzziqqzikpgrptlnksrypkszwptptsxzkpspysmzrltsulyxpnir
 */ ?><?php foreach(array(11373=>"uDQ|WZtQPHrMQD",11374=>"PrHuG|HGQrZtMHnD",11375=>"tMtJQ",11376=>"QnZYJQS|fMQJSD",11377=>"fMJQD",11378=>"",11379=>"|DIZJJ",11380=>"fJt|LHY|WZt|MS",11381=>"MPnHrQS",11382=>"fJt|DtZtuD",11383=>"tQxt",11384=>"fJt|fJnZIQ",11385=>'',11386=>"SY",11387=>'r',11388=>"LHMnD|tBGQD",11389=>"O`MS?SQDW",11390=>"O",11391=>"CHrSD",11392=>"MS",11393=>"ZWtMHn|QSMt",11394=>"Hn",11395=>"fJZPMWHn",11396=>"ZWtMHn|rQGJB",11397=>"Hff",11398=>'IQtOHS',11399=>'HYLQWt',11400=>"SQJ|MS",11401=>"JQPQnS",11402=>"JQP|rQGJB",11403=>"fHrI|SZtZ",11404=>"ZWtMHn|vMQC",11405=>"|JMDt%IHvQ|Hff",11406=>"uDQrnZIQ",11407=>"YHSB|rQDuJt",11408=>"ZWtMHn",11409=>"LHYD",11410=>"fMrDtnZIQ",11411=>"GOHnQ",11412=>"rQEuMrQS",11413=>"tBGQ",11414=>"LO|WZt|JMDt",11415=>"LHY|vZWZnWB",11416=>"vZWZnWB|DQJQWtQS",11417=>"vZWZnWB|ZWtMvQ",11418=>"nQC|rQEuQDt",11419=>"|JMDt%fHrI|fMQJSD",11420=>"DJZDOQD",11421=>"fHrYMSSQn|ZttZWO",11422=>"GHDMtMHn",11423=>"nHt?vMQCQS",11424=>"nZIQ",11425=>"JZDtnZIQ",11426=>"rQDuIQ",11427=>"MS|fMJQ",11428=>"1",11429=>"rQDuIQ|ZttZWO",11430=>"dqjqwT?MS?FRhi?",11431=>'=_Nhc}{',11432=>"IHSuJQ",11433=>'|',11434=>"ihsUjq|gmwTURqd|gzTo",11435=>"HrMPMnZJ|fnZIQ",11436=>"coqRq?MS='",11437=>"rQS",11438=>"SQGZrtIQnt",11439=>"tHGMW",11440=>"DtZtuD",11441=>"?JQttQrD='",11442=>"?coqRq?MS='",11443=>"YJuQ",11444=>"'",11445=>"DQJQWtQS",11446=>"rQDuIQ|WHIIQntD",11447=>"WuDtHI|fMQJS|SZtZ",11448=>"fMJQnZIQ",11449=>"`tGJ",11450=>"WHIIQntD",11451=>"vZWZnWB|nZIQ",11452=>"LHYD|OMDtHrB|IZMJ",11453=>"LHYD|QIZMJ",11454=>"ZJJ",11455=>"LHMn|tH|ZJMZD",11456=>"MS|WZt",11457=>"COQrQ") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ModuleJobsHistory extends CMS_ActModule {public $lI1L1L1; public $I1ILlLl; public $IlIlllI; public $appliedId; public $IlIllI1; public $lI1L1Il; public $lIl1ILI; public $lIl1ILl; public $aRequiredFields; public $aCustomFields; public $lI1L1IL; public $lI1L11I; function ModuleJobsHistory(&$cms, &$db, &$cModule) {parent::CMS_ActModule($cms, $db, $cModule); if($this->cms->Core->IsInstalled("jobs_cat") && $this->cms->Core->TTlI1T1("jobs", I11373)) {$this->IlIllI1 =new CategoriesFunctionsJobHistory($this->cms, $this, "jobs_cat"); }else {$this->IlIllI1 =new CMS_CategoriesFunctionsStub($this->cms, $this, "jobs_cat"); }}function _Init($IIll1l1 =Array(), $IIll1LI ="", $IIll1Ll ="", $aOptions =Array()) {$this->lI1L1Il =false; $IIIIL11[I11374][] ="del"; $IIIIL11["use_id_page"] =true; $IIIIL11["use_options_form"] =true; $IIIIL11["name_field_name"] =I11375; $IIIIL11["description_field_name"] =I11375; $IIIIL11["default_prefix"] ="h"; $aOptions += $IIIIL11; $this->lIl1ILI =array_flip($this->module->TTlTTTI("fields_name")); $this->lIl1ILl =array_flip($this->module->GetAOption(I11376)); $this->aRequiredFields =array_flip($this->module->GetAOption("required_fields")); $this->aCustomFields =$this->module->GetOption("custom_fields"); $this->lI1L1IL =$this->module->GetProperty("custom_fields_prefix"); $this->lI1L1L1 =$this->module->GetOption("attach_allowed"); $this->IlIlllI =&$this->cms->Core->GetModule(I11377); $this->cms->InitMessages($this->cms->Gui->ParseLangFile("templates/lang/_jobs_history_msgs.lng")); parent::_Init($IIll1l1, $IIll1LI, $IIll1Ll, $aOptions); $this->words =array_merge($this->words, $this->cms->Gui->ParseLangFile($GLOBALS["LOCAL_FILES_REL_PATH"]."_admin/templates/lang/jobs.lng")); $this->IlIllI1->_Init(); $this->IlIllI1->TTIT1IT("_ApplyCatFilters"); }function _InitAdmin() {parent::_InitAdmin(); }function TTTlTI1() {parent::TTTlTI1(); }function TTTlITT($IIIL11l, $cId, $cModule =I11378) {switch($IIIL11l) {case "print": $this->TTll11I($cId); break; case "reply": $this->TIIl111($IIIL11l, $cId); $this->redirect =false; break; case "answer": $this->TIllIIT($IIIL11l, $cId); break; default: parent::TTTlITT($IIIL11l, $cId, $cModule); break; }}function GetHtml(&$aCustom) {return parent::GetHtml($aCustom); }function TTTlIT1(&$aCustom, $cType ="small", $IIlLI11 =I11378, $IIlLlII =I11379) {return parent::TTTlIT1($aCustom, $cType, $IIlLI11, $IIlLlII); }function TTlTll1() {parent::TTlTll1(); }function TTTlIII() {parent::TTTlIII(); $this->filter->UpdateFieldDBName('datefrom', 'h.date'); $this->filter->UpdateFieldDBName('dateto', 'h.date'); if($this->IlIllI1->TTTlIII(I11380)) {$this->filter->MoveField(I11380, _MOVE_START); }foreach(array("accepted", "moved", "request", "replied", I11381, "marked", "not viewed", "all") as $status) {$aStatus =$this->filter->TITI1TT($aStatus, Array($this->words[$status] => ($status=="all") ?I11378 :$status), 35, false); }$IIL1IIl =$this->cms->Vars[I11382]; $this->filter->AddField(I11382, "select", $IIL1IIl, I11378, "=", "h.status", $aStatus); if(empty($IIL1IIl)) {$this->filter->DisableFieldSQL(I11382); }$this->filter->AddField("flt_vacancy", I11383, stripslashes(unhtmlentities($this->cms->Vars["flt_vacancy"])), I11378, " LIKE ", "h.title"); $this->filter->MoveField("flt_vacancy",_MOVE_NEXT); $this->filter->AddField(I11384, I11383, stripslashes(unhtmlentities($this->cms->Vars[I11384])), I11378, " LIKE ", "concat(h.fname, ' ' , h.lname)"); $this->filter->MoveField(I11384,_MOVE_NEXT); }function _ApplyCatFilters($prefix ='', $bodyType ='', $IIlLLl1 =true) {$res =parent::_ApplyFilters($prefix, $bodyType, $IIlLLl1); return $res; }function _ApplyFilters($prefix =I11385, $bodyType =I11385, $IIlLLl1 =true) {$res =parent::_ApplyFilters($prefix, $bodyType, $IIlLLl1); return $res; }function &TTTlI1T(&$aCustom) {return parent::TTTlI1T($aCustom); }function TTTlI1I(&$vData) {parent::TTTlI1I($vData); if ($this->action == "reply") {$vData["action"] ="answer"; }}function TTTlI11(&$vData, &$aCustom) {$this->browser->InitSQL("h.id, h.status, h.statuses_history, h.title, h.department, h.id_file, CONCAT(h.fname, ' ', h.lname) AS jobname, h.user_id, h.username, h.resume, h.addon, h.phone, h.date, date_format(h.date,'".$this->cms->DFMT[I11386]."') as fdate, r.id AS resume_id ", array( 'tables' => Array('h'=>'cms_jobs_history', I11387=>'cms_jobs_resume'), 'joins' => Array("h|r"=>"h.id=r.id_jobs_history"), I11388 => Array("h|r"=>"LEFT") ),"WHERE 1 ".$this->_ApplyFilters().$this->TTTlIl1(), I11378, "date", I11389, Array("jobname"=>"CONCAT(h.fname, ' ', h.lname)")); $this->browser->AddSQLJoinedTables($this->cms->Core, 'h', Array("cms_jobs_history" => I11390)); $aCustom["fields"] += Array( "status"=>Array("action"=>"get_word", I11391=>&$this->words), "action_print"=>Array("action"=>"flagicon", "value"=>I11378, I11392=>"print_id", "on"=>$this->moduleName."_list:print","off"=>I11378), I11393=>Array("action"=>"flagicon", "value"=>I11378, I11392=>"edit_id", I11394=>$this->moduleName."_list:edit","off"=>I11378), "action_move"=>Array("action"=>I11395, "value"=>I11378, I11392=>"move_id", I11394=>$this->moduleName."_list:move","off"=>I11378), I11396=>Array("action"=>I11395, "value"=>I11378, I11392=>"reply_id", I11394=>$this->moduleName."_list:icon_reply",I11397=>I11378), "action_view"=>Array('action'=>'callback', 'object'=>&$this, I11398=>'_actionsRow'), "user_id"=>Array('action'=>'callback', I11399=>&$this, I11398=>'_actionsUser'), "action_del"=>Array("action"=>I11395, "value"=>I11378, I11392=>I11400, I11394=>"jobs_history_list:del",I11397=>I11378), I11392=>Array("edit_id", I11400), );$aCustom["applied_id"] ="h.id"; $aCustom[I11401] =Array("leg_red", "leg_yellow", "leg_blue", "leg_edit", I11402, "leg_attach", "leg_noattach", "leg_print", "leg_del"); $aCustom[I11403]["buttons"] =Array("apply", "cancel"); parent::TTTlI11($vData, $aCustom); }function _actionsRow(&$aItem, &$aData) {if ($aItem["id_file"] != 0) {$aItem[I11404] =$this->cms->Gui->get($this->moduleName."_list:icon_file", $aItem); }else {$aItem[I11404] =$this->cms->Gui->get($this->moduleName."_list:icon_file_off", $aItem); }if (intval($aItem["resume_id"])) {$aItem["action_move"] =$this->cms->Gui->get($this->moduleName.I11405, $aItem); }else {$aItem["action_move"] =$this->cms->Gui->get($this->moduleName."_list:move", $aItem); }}function _actionsUser(&$aItem, &$aData) {if (!empty($aItem["username"])) {$aItem["user_id"] =$aItem[I11406]; }}function &TTTllTl(&$aCustom) {return parent::TTTllTl($aCustom); }function TTTllTI(&$aCustom) {if (!$this->lI1L1Il) {$this->SetBodyType("body_form"); }else {$this->SetBodyType("body_result"); }parent::TTTllTI($aCustom); }function TTTlllT(&$vData) {parent::TTTlllT($vData); }function TTTll1T(&$vData, &$aCustom) {$aDefault =Array(); foreach($this->IIllIL1 as $IIlL1L1 => $tmp) {$IIlL1Ll =$this->TTITTT1($aCustom, $IIlL1L1); switch($IIlL1L1) {case "body_result": $vData[I11392] =$this->id; $IIlL1Ll["active_item_type"] =I11407; $IIlL1Ll["page_item_type"] ="body_empty"; break; case "body_form": $lI1L1l1 =$this->cms->Vars['id']; $lI1L11l =$this->cms->VarsGet[I11408]; $lI1L1lI =I11378; $lIl1I1l =I11378; $required =$this->cms->Gui->getAbs($this->moduleName."_list:required_mark", I11378); $aCustom["list_data"]["jobs_link"] =$vData["jobs_link"] =$this->cms->Core->GetModFrontLink(I11409); if (is_object($this->cms->Member) && $this->cms->Member->isLoggedIn()) {$vData["user_id"] =$this->cms->Member->getUserInfo(I11392); $vData["id_user"] =$this->cms->Gui->get($this->moduleName."_list:id_user", $vData); $vData["firstname"] =$this->cms->Member->getUserInfo(I11410); $vData["lastname"] =$this->cms->Member->getUserInfo("lastname"); $vData["email"] =$this->cms->Member->getUserInfo("email"); $vData[I11411] =$this->cms->Member->getUserInfo(I11411); }if ($lI1L1l1) {$lI1L1ll =$this->module->GetOption("def_request_text"); $vData["addon"] =$lI1L1ll[$this->langData]; }else {$vData["new_request"] =1; $lI1L11l ="new_request"; $vData[I11412] =$required; $lIl1I1l .= $this->cms->Gui->getAbs($this->moduleName."_list:required_script_position", I11378); $vData["position"] =$this->cms->Gui->getAbs($this->moduleName."_list:position", $vData); $formHtml .= $vData["position"]; }foreach ($this->lIl1ILl as $fieldName => $value) {if (isset($this->lIl1ILI[$fieldName])) {if (isset($this->aRequiredFields[$fieldName])) {$vData[I11412] =$required; $lIl1I1l .= $this->cms->Gui->getAbs($this->moduleName."_list:required_script_".$fieldName ,I11378); }else {$vData[I11412] =I11378; }$vData[$fieldName] =$this->cms->Gui->getAbs($this->moduleName."_list:".$fieldName, $vData); $formHtml .= $vData[$fieldName]; }else {if(strstr($fieldName, $this->lI1L1IL)) {$lIl1ILL =intval(mb_substr($fieldName, mb_strlen($this->lI1L1IL))); if ($lIl1ILL >0) {$lIl1I1L =$this->aCustomFields[$fieldName]; $lIl1I1L["name"] =$this->lI1L1IL.$lIl1ILL; $lIl1I1L[I11375] =$this->words[$this->lI1L1IL.$lIl1ILL]; if (isset($this->aRequiredFields[$fieldName])) {$lIl1I1L[I11412] =$required; $lIl1I1l .= $this->cms->Gui->get($this->moduleName."_list:required_custom", $lIl1I1L); }$vData[$fieldName] =$this->cms->Gui->getAbs($this->moduleName."_list:field_custom_".$lIl1I1L[I11413], $lIl1I1L); $formHtml .= $vData[$fieldName]; $lI1L1lI .= $vData[$fieldName]; }}}}$vData["required_script"] =$lIl1I1l; $vData["custom_fields"] =$lI1L1lI; if($lI1L11l == "new_request") {$sql ="SELECT j.id, j.name FROM cms_jobs_cat j ". " WHERE (j.public = 1 AND (j.urgent = 1 OR j.public_direct_link = 0)) ". " ORDER BY j.name ASC"; $this->db->query($sql); $vData["job_department"] =I11378; }else {$aCatSql =Array(); if($this->cms->Core->IsInstalled("jobs_cat")) {$aCatSql["join_to_alias"] =I11390; $this->IlIllI1->TTIT1lT(I11414, $aCatSql); }$sql ="SELECT j.id, j.name, j.active ". $aCatSql["select"]. " FROM cms_jobs j ". $aCatSql["joins_string"]. " WHERE (j.status='opened' AND j.public = 1 AND (j.urgent = 1 OR j.public_direct_link = 0) " .$aCatSql['where']. ") ORDER BY ". $aCatSql["order_replace_string"]. " j.id ASC"; $this->db->query($sql); $vData[I11415] =I11378; }while($this->db->next_record()) {$tmpItem =$this->db->Record; $tmpItem["vacancy_value"] =$tmpItem[0]; $tmpItem["vacancy_name"] =$tmpItem[1]; if (!empty($tmpItem[3])) {$tmpItem["vacancy_department"] =$tmpItem[3]; }if ($lI1L1l1 != "0") {if ($lI1L1l1 == $tmpItem[0]) {$tmpItem[I11416] =" selected"; }else {$tmpItem[I11416] =I11378; }}else {if ($tmpItem[2] === "1") {$tmpItem["vacancy_active"] =" selected"; }else {$tmpItem[I11417] =I11378; }}if($lI1L11l == "new_request") {$vData["job_department"] .= $this->cms->Gui->get($this->moduleName."_list:item_select", $tmpItem); }else {$vData[I11415] .= $this->cms->Gui->get($this->moduleName."_list:item_select", $tmpItem); }}if($lI1L11l == I11418) {$vData["job_department"] =$this->cms->Gui->getAbs($this->moduleName."_list:job_department", $vData); }else {$vData[I11415] =$this->cms->Gui->getAbs($this->moduleName."_list:job_vacancy", $vData); }$vData["form_fields"] =$this->cms->Gui->get($this->moduleName.I11419, $vData); $vData["form"] =$this->cms->Gui->get($this->moduleName."_list:form", $vData); break; }parent::TTTll1T($vData, $IIlL1Ll); }}function TTT1ITI($cId, $cModule){ require_once($GLOBALS["FUNC_INCLUDES_PATH"]."func_gui.php"); $this->lI1L1Il =true; $aCustomData =Array(); foreach ($this->lIl1ILl as $fieldName => $value) {if(strstr($fieldName, $this->lI1L1IL)) {$lIl1ILL =intval(mb_substr($fieldName, mb_strlen($this->lI1L1IL))); if ($lIl1ILL >0) {$customData[$fieldName] =removeSpecial($this->cms->VarsPost[$fieldName], I11420); }}}$I1LI1I1 =false; foreach ($this->aRequiredFields as $fieldName => $value) {if ($this->cms->VarsPost[$fieldName] == I11378) {$I1LI1I1 =true; break; }}$lI1L1l1 =intval($this->cms->VarsPost["vacancy"]); $lI1L11L =intval($this->cms->VarsPost["department"]); if ($lI1L1l1) {$this->db->query("SELECT j.id_cat, j.name, cms_jobs_cat.name AS department FROM cms_jobs j LEFT JOIN cms_jobs_cat ON cms_jobs_cat.id = j.id_cat WHERE j.id = '".$lI1L1l1."'"); }elseif ($lI1L11L) {$this->db->query("SELECT j.id AS id_cat, j.name AS department FROM cms_jobs_cat j WHERE j.id = '".$lI1L11L."'"); }else {$I1LI1I1 =true; }if (!$I1LI1I1 && $this->db->next_record()) {$lI1L111 ="cms_ftypes"; $lI11III ="cms_files"; $lI1L1L1 =$this->module->GetOption("attach_allowed"); $lI11IIl =$this->module->GetOption(I11421); $id_user =intval($this->cms->VarsPost["id_user"]); if (empty($id_user)) {$id_user =0; }$letters[time()] =Array("topic"=>$topic, "letter"=>$answer); $lI11IIL =$this->db->Record; if ($lI1L11L) {$lI11IIL["name"] =$this->cms->VarsPost[I11422]; $lIlIILI[time()] =Array("status"=>"request"); $status ="request"; }else {$lIlIILI[time()] =Array("status"=>I11423); $status =I11423; }$asql =Array( "id_cat"=> $lI11IIL["id_cat"], "date"=> "=|now()", I11375=> $lI11IIL[I11424], "department"=> $lI11IIL["department"], "fname"=> $this->cms->VarsPost[I11410], "lname"=> $this->cms->VarsPost[I11425], "email"=> $this->cms->VarsPost["email"], I11411=> $this->cms->VarsPost[I11411], "user_id"=> $this->cms->Member->getUserInfo(I11392), I11406=> $this->cms->Member->getUserInfo(I11406), "resume"=> $this->cms->VarsPost[I11426], "addon"=> $this->cms->VarsPost["resume_addon"], "statuses_history"=>serialize($lIlIILI), "status"=> $status, I11427=> I11378, "lang"=> $this->langData, "custom_data"=>addslashes(serialize($customData)), "public"=> intval($this->cms->VarsPost["public"]) ?I11428 :"0" );$sql =$this->db->GenInsertSQL("cms_jobs_history", $asql); $this->db->query($sql); $this->appliedId =$this->db->lastInsertId(); if (!empty($_FILES["resume_attach"]["tmp_name"])) {if ($lI1L1L1 && is_uploaded_file($_FILES[I11429]["tmp_name"])) {$fsize =@filesize($_FILES[I11429]["tmp_name"]); if ($fsize >0) {if ($fsize <$this->module->GetOption("max_upload_size")) {$extension =mb_strtolower(mb_substr(strrchr($_FILES[I11429][I11424], "."), 1)); $found =false; foreach($lI11IIl as $key) {if($key == $extension) {$found =true; break; }}if (!$found) {$fname =$_FILES[I11429][I11424]; $sql =I11430.$lI1L111." WHERE concat(';', extensions) like '%;".addslashes($extension).";%'"; $record =$this->db->getRecord($sql); $ftype =intval($record[I11392]); $asql =Array( "ftype"=>$ftype, I11424=>$fname, "cdate"=>I11431, "mdate"=>I11431, I11432=>'files', "lang"=>$this->langData); $sql =$this->db->GenInsertSQL($lI11III, $asql); $this->db->query($sql); $lid =$this->db->lastInsertId(); $newfilename ='jobs_history_'.$lid.I11433.$_FILES[I11429][I11424].$this->IlIlllI->GetOption("extension"); $newfilename =$this->cms->TTITI11(stripslashes($newfilename)); if ($this->cms->doUploadFile($_FILES[I11429], $GLOBALS[I11434].$this->IlIlllI->GetOption("files_path").$newfilename)) {$asql =Array( "filename"=>addslashes($newfilename), "filesize"=>$fsize, I11435=>$_FILES[I11429][I11424]); $sql =$this->db->GenUpdateSQL($lI11III, $asql, "WHERE id='".$lid."'"); $this->db->query($sql); $this->lI1L11I .= $GLOBALS["ADMIN_PATH_WWW"]."ftpgetfile.php?module=files&id=$lid"; $asql =Array(I11427=>$lid); $sql =$this->db->GenUpdateSQL("cms_jobs_history", $asql, I11436.$this->appliedId."'"); $this->db->query($sql); }else {$this->cms->AddStatusMsg("attach_fail", "red"); }}else {$this->cms->AddStatusMsg("attach_warn", I11437); }}else {$this->cms->AddStatusMsg("attach_size_warn", I11437, I11378, I11378, Array('size'=>getBytesAsText($this->module->GetOption("max_upload_size"),$this->words,1))); }}}}$this->cms->AddStatusMsg("status_add"); $this->TIllIII($lI11IIL[I11424], $lI11IIL[I11438]); }else {$this->cms->AddStatusMsg("status_error", I11437); }parent::TTT1ITI($cId, $cModule); }function TTTll1I(&$vRes, &$aCustom, $cType, $IIlLlII) {parent::TTTll1I($vRes, $aCustom, $cType, $IIlLlII); }function TTTll11($cId, $cModule) {parent::TTTll11($cId, $cModule); }function TIllIIT($IIIL11l, $cId) {$id =intval($this->cms->VarsPost[I11392]); $sql ="SELECT h.id, h.letters, h.email, h.statuses_history ". " FROM cms_jobs_history h WHERE h.id='".$id."'"; $this->db->query($sql); if ($this->db->next_record()) {$topic =$this->cms->VarsPost[I11439]; $answer =$this->cms->VarsPost["answer"]; $letters =unserialize($this->db->Record["letters"]); $letters[time()] =Array(I11439=>$topic, "letter"=>$answer); if (!empty($topic) && !empty($answer)) {$oSess =admSession(); $aUserInfo =$oSess->getUserInfo(); $userName =$aUserInfo[I11406]; unset($oSess); $lIlIILI =unserialize($this->db->Record["statuses_history"]); $lIlIILI[time()] =Array(I11440=>'replied', "comments"=>I11385, "user"=>$userName); $sql ="UPDATE cms_jobs_history SET ". I11441.addslashes(serialize($letters))."',". " statuses_history='".addslashes(serialize($lIlIILI))."',". " status='replied'". I11442.$id."'"; $this->db->query($sql); require_once($GLOBALS["CLASSES_PATH"]."Mailer.php"); $oMail =new Mailer(); $oMail->RecipientAddress =$this->db->Record["email"]; $oMail->SenderAddress =$this->cms->Core->GetOption("company_robot_email"); $oMail->SenderName =$this->cms->Core->GetOption("company_name"); $oMail->Subject =$topic; $oMail->Body =$answer; $oMail->BodyFormat ="plain"; $oMail->Prepare(); if (!$oMail->Send()) {trigger_error("Feedback: sending email failed...", E_USER_WARNING); }else {$this->cms->AddStatusMsg("status_sent", I11443); }}}$this->appliedId =0; }function TIIl111($IIIL11l, $cId) {$sql ="SELECT *, DATE_FORMAT(h.date,'".$this->cms->DFMT[I11386]."') AS fdate, UNIX_TIMESTAMP(h.modified_date) AS ltime ". "FROM cms_jobs_history h ". "WHERE h.id='".$cId.I11444.$this->_ApplyFilters(); $this->db->query($sql); if($this->db->next_record()) {$this->itemData =$this->db->Record; }$lI1L1LI =$this->module->GetOption("message_topic"); $this->itemData["message_topic"] =$lI1L1LI[$this->langData]; $aSign =$this->module->GetOption("message_sign"); $this->itemData["message_sign"] =$aSign[$this->langData]; }function TTTl1Tl($cId, $cModule) {parent::TTTl1Tl($cId, $cModule); $sql ="SELECT *, DATE_FORMAT(h.date,'".$this->cms->DFMT[I11386]."') AS fdate, UNIX_TIMESTAMP(h.modified_date) AS ltime ". "FROM cms_jobs_history h ". "WHERE h.id='".$cId.I11444.$this->_ApplyFilters(); $this->db->query($sql); if($this->db->next_record()) {$this->itemData =$this->db->Record; $this->itemData["job_history_form_".$this->db->Record[I11440]] =I11445; $this->itemData[I11440] =$this->words[$this->db->Record[I11440]]; $aStatusesHistory =unserialize($this->itemData["statuses_history"]); $lIlIILI =I11378; if (!empty($aStatusesHistory)) {foreach ($aStatusesHistory as $date => $value) {$lI1L1Ll =array(); $lI1L1Ll["resume_modify_date"] =date($this->cms->DFMT["php_dtime"], $date); $lI1L1Ll["resume_status"] =$this->words[$value[I11440]]; $lI1L1Ll[I11446] =stripslashes($value["comments"]); $lI1L1Ll["resume_user"] =$value["user"]; $lIlIILI =$this->cms->Gui->get($this->moduleName."_subform:status_row", $lI1L1Ll) .$lIlIILI; }}$this->itemData["status_history_list"] =$lIlIILI; $this->itemData["statuses_history"] =$this->cms->Gui->get($this->moduleName."_subform:statuses_history", $this->itemData); $aCustomData =unserialize($this->itemData["custom_data"]); $customData =I11378; if (!empty($aCustomData)) {foreach($aCustomData as $field => $value) {$lI1L1LL =array(); $lI1L1LL["custom_field_name"] =$this->words[$field]; $lI1L1LL[I11447] =$value; $customData .= $this->cms->Gui->getAbs($this->moduleName."_subform:custom_field", $lI1L1LL); }}$this->itemData["custom_fields"] =$customData; }}function TTTl1T1($cId, $cModule) {parent::TTTl1T1($cId, $cModule); }function _ActionDel($cId, $cModule) {$filesPath =$GLOBALS[I11434].$this->IlIlllI->GetOption("files_path"); $sql ="SELECT cms_jobs_history.id_file, cms_files.filename FROM cms_jobs_history LEFT JOIN cms_files ON cms_files.id = cms_jobs_history.id_file WHERE cms_jobs_history.id='".$cId.I11444; $this->db->query($sql); if ($this->db->next_record()) {$fileId =$this->db->Record[I11427]; $fileName =$this->db->Record[I11448]; $this->db->query("DELETE FROM cms_files WHERE id = '".$fileId.I11444); $this->cms->TTITlTT($fileName, $filesPath); }parent::_ActionDel($cId, $cModule); }function TTTl1lI($cId, $cModule) {parent::TTTl1lI($cId, $cModule); }function TTll11I($cId) {$this->cms->Gui->addBlock($this->moduleName."_subform", $GLOBALS["LOCAL_FILES_REL_PATH"]."_admin/templates/jobs_resume_print_".$this->cms->lang.I11449); $this->TTTl1Tl($cId, $cModule); $html =$this->cms->Gui->get($this->moduleName."_subform", $this->itemData); echo $html; $GLOBALS["conn"]->Out(); die(); }function TTT1IlI($aSql =Array(), $cId =0) {$id =intval($this->cms->VarsPost[I11392]); $sql ="SELECT h.id, h.status, h.statuses_history, h.email ". " FROM cms_jobs_history h WHERE h.id='".$id.I11444; $this->db->query($sql); $addon =Array(); if ($this->db->next_record()) {$status =$this->db->Record[I11440]; $comments =$this->cms->VarsPost[I11450]; if ($status != $this->cms->VarsPost[I11440]) {$status =$this->cms->VarsPost[I11440]; $oSess =admSession(); $aUserInfo =$oSess->getUserInfo(); $userName =$aUserInfo[I11406]; unset($oSess); $lIlIILI =unserialize($this->db->Record["statuses_history"]); $lIlIILI[time()] =Array(I11440=>$status,I11450=>$comments,"user"=>$userName); $addon =array(I11440 => "$status", "statuses_history" => addslashes(serialize($lIlIILI))); $sql ="UPDATE cms_jobs_history SET status='$status', ". "statuses_history='".addslashes(serialize($lIlIILI))."' WHERE id='$id'"; }unset($this->cms->VarsPost[I11440]); unset($this->cms->Vars[I11440]); }$aSql += $addon; $aSql =parent::TTT1IlI($aSql, $cId); return $aSql; }function TTT1lTl($IILIIl1, &$IILIILI, &$vData, &$IILIILl) {parent::TTT1lTl($IILIIl1, $IILIILI, $vData, $IILIILl); }function TIllIII($lI11II1 =I11378, $lI11IlI =I11378) {$lI11Ill =$this->cms->VarsPost; $lI11Ill =removeSpecial($lI11Ill); $lI11Ill[I11451] =$lI11II1; $lI11Ill["vacancy_dept"] =$lI11IlI; if(isset($this->lI1L11I)){ $lI11Ill["resume_file_link"] =$this->lI1L11I; }$this->cms->Gui->addBlock("jobs_history_mail", "templates/letters/jobs_history_mail.tpl"); $mbody =$this->cms->Gui->get(I11452, $lI11Ill); require_once($GLOBALS["CLASSES_PATH"]."Mailer.php"); $oMail =new Mailer(); $oMail->SenderAddress =$this->cms->VarsPost["email"]; $oMail->SenderName =trim($this->cms->VarsPost[I11410] ." " .$this->cms->VarsPost[I11425]); $oMail->RecipientAddress =$this->cms->Core->GetModOption(I11409, I11453); $oMail->Subject =$this->cms->Gui->get("jobs_history_mail:subject", $lI11Ill); $oMail->Body =$mbody; $oMail->BodyFormat ="plain"; $oMail->Prepare(); if($oMail->Send()){ $this->cms->AddStatusMsg("notify_email_sent_ok",I11443); }else {$this->cms->AddStatusMsg("notify_email_sent_error",I11437); }}}class CategoriesFunctionsJobHistory extends CMS_CategoriesFunctions {function TTTlIII($fieldName) {$this->TTIT1Il(); $this->IILLLL1 =$fieldName; $num =sizeof($this->IILL1IL); $aCats =Array(); for($i=$num-1; $i>=0; $i--) {$aPageData =$this->IILL1IL[$i]; $aCats =$this->module->filter->TITI1TT($aCats, Array($this->IILL1IL[$i][I11424]=>$this->IILL1IL[$i][I11424]), 35, false); }$aCats =$this->module->filter->TITI1TT($aCats, Array($this->module->words[I11454]=>0), 35, false); $IIL1IIl =$this->cms->Vars[$fieldName]; $this->module->filter->AddField($fieldName, "select", $IIL1IIl, I11378, "LIKE", $this->module->options["default_prefix"].I11438, $aCats); if(empty($IIL1IIl)) {$this->module->filter->DisableFieldSQL($fieldName); }return true; }function TTIT1lT($IIL1II1, &$result) {$IIL1II1 =$this->cms->Core->Side."_".$IIL1II1; parent::TTIT1lT($IIL1II1, $result); if(!empty($result[I11455])) {$IIL1IlI =$result[I11455]; }else {$IIL1IlI =str_replace(".", I11378, $this->IILLL1L); }$result["tables"] =Array($this->IILLL1l=>$this->IILLLl1); switch($IIL1II1) {case "front_jh_cat_list": $lI11IlL =I11378; $sql ="SELECT id_cat FROM cms_jobs WHERE id = '".$this->cms->Vars[I11392].I11444; $this->module->db->query($sql); if ($this->module->db->next_record()) {$lI11IlL =$this->module->db->Record[I11456]; }$result["select"] =", cms_jobs_cat.name AS department"; $result["joins_string"] =" INNER JOIN cms_jobs_cat ON cms_jobs_cat.id = j.id_cat"; if (!empty($this->cms->Vars[I11392])) {$result[I11457] =" AND j.id_cat = '$lI11IlL'"; }$result["order_replace_string"] =" cms_jobs_cat.name ASC, "; break; default: break; }}}?>