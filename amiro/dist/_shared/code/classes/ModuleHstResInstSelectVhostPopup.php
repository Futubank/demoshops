<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       7591 xkqwwuiusrtnurtyrstrtyqtugmnusrsgiyzgmstimwiwqgklmspymkyiknuqtimyumxpnir
 */ ?><?php foreach(array(10987=>"ZJJHCQS|ZWtMHnD",10988=>"OMSSQn",10989=>"HnJB|nZIQ",10990=>"?=?",10991=>"tQxt",10992=>"fJt|uDQrnZIQ",10993=>"fJt|WJMQntnZIQ",10994=>"fJt|tZrMff",10995=>"SQDt|fMQJS|MS|MS",10996=>'v',10997=>'I`MS=v`MS|WJMQnt',10998=>'LHMnD|tBGQD',10999=>'D_t',11000=>'t',11001=>"DtrMGJMnQ",11002=>"uDQrnZIQ",11003=>"DMAQ",11004=>"fJZPMWHn",11005=>"|JMDt%DQJQWt|MWHn",11006=>'D',11007=>"fHrI|SZtZ",11008=>'',11009=>"tBGQD",11010=>'DuYSHIZMn') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ModuleHstResInstSelectVhostPopup extends ModuleHst {function ModuleHstResInstSelectVhostPopup(&$cms, &$db, &$cModule) {parent::ModuleHst($cms, $db, $cModule); }function _Init($IIll1l1 =Array(), $IIll1LI ="", $IIll1Ll ="", $aOptions =Array()) {$IIIIL11 =array(); $IIIIL11[I10987] =array ("select"); $IIIIL11["lang_data"] =false; $aOptions += $IIIIL11; parent::_Init($IIll1l1, $IIll1LI, $IIll1Ll, $aOptions); }function TTTlIII() {parent::TTTlIII(); $lI1lllI =$this->TIlIIIl($this->cms->Vars["types"]); $this->filter->AddField("types", I10988, $lI1lllI); $this->filter->AddField("dest_field_id_id", I10988, stripslashes(unhtmlentities($this->cms->Vars["dest_field_id_id"]))); $this->filter->AddField("dest_field_id_name", I10988, stripslashes(unhtmlentities($this->cms->Vars["dest_field_id_name"]))); $this->filter->AddField(I10989, I10988, intval(unhtmlentities($this->cms->Vars[I10989]))); $this->cms->Gui->AddGlobalVars(array ("ONLY_NAME" =>$this->filter->GetFieldValue(I10989), ));$this->filter->AddField("id_subscr", I10988, intval(unhtmlentities($this->cms->Vars["id_subscr"])), "", I10990, "v.id_subscription"); if($this->filter->GetFieldValue("id_subscr") == 0) {$this->filter->DisableFieldSql("id_subscr"); }$this->filter->AddField("flt_name", I10991, stripslashes(unhtmlentities($this->cms->Vars["flt_name"])), "", " like ", "v.domain"); $this->filter->AddField(I10992, I10991, stripslashes(unhtmlentities($this->cms->Vars[I10992])), "", " like ", "m.username"); if(!$this->TTTTlTI()) {$this->filter->AddField("flt_clientname", I10991, stripslashes(unhtmlentities($this->cms->Vars[I10993])), "", " like ", "CONCAT_WS(' ', m.lastname, m.firstname)"); }$this->filter->AddField("flt_tariff", I10991, stripslashes(unhtmlentities($this->cms->Vars[I10994])), "", " like ", "t.name"); }function &TTTlI1I(&$aData) {$aData['dest_field_id'] =$this->filter->GetFieldValue(I10995); $aData['dest_field_name'] =$this->filter->GetFieldValue("dest_field_id_name"); parent::TTTlI1I($aData); }function TTTlI11(&$vData, &$aCustom) {$this->browser->InitSQL("v.id, v.id_subscription, v.domain, m.username, CONCAT_WS(' ', m.lastname, m.firstname) as clientname, t.name as tariff ", Array( 'tables'=>Array(I10996=>'cms_hst_res_vhost_inst', 'm'=>'cms_members', 's'=>'cms_hst_subscription', 't'=>'cms_hst_tariff'), 'joins'=>array('v|m'=>I10997, 'm|s'=>'s.id=v.id_subscription', 's|t'=>'t.id=s.id_tariff' ),I10998=>array('v|m'=>'LEFT', 'm|s'=>'LEFT', I10999=>'LEFT'), ),"WHERE 1".$this->_ApplyFilters().$this->TTTlIl1(), 'v.id', 'v.domain' );$this->browser->AddSQLJoinedTables($this->cms->Core, I10996, Array(I10996=>'cms_hst_res_vhost_inst', 'm'=>'cms_members', 's'=>'cms_hst_subscription', I11000=>'cms_hst_tariff')); $aCustom["fields"] += Array( "id"=>Array("action"=>I11001, "size"=>120), "domain"=>Array("action"=>I11001, "size"=>128), I11002=>Array("action"=>I11001, "size"=>64), "clientname"=>Array("action"=>I11001, I11003=>128), "tariff"=>Array("action"=>I11001, I11003=>64), "action_select" => array ("action" => I11004, "value" => 1, "id"=>"sel_id", "on" => $this->moduleName .I11005, "off" => $this->moduleName .I11005 ),);$this->browser->AddSQLJoinedTables($this->cms->Core, I10996, array(I10996=>'cms_hst_res_vhost_inst', 'm'=>'cms_members', I11006=>'cms_hst_subscription', I11000=>'cms_hst_tariff')); $aCustom["legend"] =Array("select"); $aCustom[I11007]["buttons"] =Array(); parent::TTTlI11($vData, $aCustom); }function _ApplyFilters($prefix ='', $bodyType ='', $IIlLLl1 =true) {$res =""; $res .= parent::_ApplyFilters($prefix =I11008, $bodyType =I11008, $IIlLLl1 =true); $res .= " AND m.lang='".$this->langData."' AND s.lang='".$this->langData."' AND t.lang='".$this->langData."' "; $res .= $this->filter->GetFieldValue(I11009); return $res; }function TIlIIIl($types) {$res =""; if($types == "") {return $res; }$lI1llll =array('common','alias',I11010); $aRes =array(); foreach($lI1llll as $type) {if(mb_substr_count($types, $type)) {$aRes[] =$type; }}if(count($aRes)) {$res =" AND v.type in ('".implode("'", $aRes)."')"; }return $res; }}?>