<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       9654 xkqwylsgnyrlpnzlmkipgpsxztuyuyqirnzlngysqnzzpwpuytmpnglwpmqzikklkkqipnir
 */ ?><?php foreach(array(10822=>'wjzddqd|gzTo',10823=>'nZIQ',10824=>"WJZDD",10825=>'SHIZMn',10826=>'v',10827=>'DtHrQ|tH|SY',10828=>'tBGQ',10829=>'Mn|JMDt',10830=>'fHrCZrS',10831=>'rMPOt',10832=>'WZGt|tS|DtZrt',10833=>'SMDK|EuHtZ',10834=>'ZJMPn',10835=>'MnGut|ZD|tQxt',10836=>"?JMKQ?",10837=>"",10838=>"SQfZuJt|SMDK|EuHtZ",10839=>'zwTmhNd|cmsTo',10840=>"IQtOHS",10841=>"vZJuQ",10842=>"Hff",10843=>'SMDK|DGZWQ',10844=>'rQS',10845=>'I',10846=>'I`MS|rQD|MnDt=r`MS',10847=>'mNNqR',10848=>">",10849=>'vZJuQD') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} require_once $GLOBALS['CLASSES_PATH'] .'MboxClient.php'; require_once $GLOBALS[I10822] .'CMS_IteratorArray.php'; class ModuleHstResEmailInst extends ModuleHstResInst {function ModuleHstResEmailInst(&$cms, &$db, &$cModule) {parent::ModuleHstResInst($cms, $db, $cModule); }function _Init($IIll1l1 =Array(), $IIll1LI ="", $IIll1Ll ="", $aOptions =Array()) {$IIIIL11 =array(); $IIIIL11["belongs_to_vhost"] =true; $IIIIL11["cannot_change_vhost"] =true; $aOptions += $IIIIL11; parent::_Init($IIll1l1, $IIll1LI, $IIll1Ll, $aOptions); }function _InitAdmin() {parent::_InitAdmin(); if($this->cms->Vars['action'] == "edit" || $this->cms->Vars['action'] == "save"){ $this->TIlITIT(array(I10823 => 'local_part', 'in_list' => false, 'is_required' => true, 'readonly' => true, I10824 => "rdo_btn1")); }else {$this->TIlITIT(array(I10823 => 'local_part', 'in_list' => false, 'is_required' => true)); }$this->TIlITIT(array(I10823 => I10825, 'in_list' => false, 'store_to_db' => false, 'on_form' => false, 'table' => I10826)); $this->TIlITIT(array(I10823 => 'email', 'calculate_expr' => "CONCAT_WS('@', m.local_part, v.domain) ", 'in_list' => true, I10827 => false, 'on_form' => false, 'table' => '')); $this->TIlITIT(array(I10823 => 'password', I10828 => 'password', I10827 => false)); $this->TIlITIT(array(I10823 => 'confirm_password', I10828 => 'password', I10827 => false)); $this->TIlITIT(array(I10823 => 'alias_type', I10829 => true, I10828 => 'select', 'values' => Array('none' => '%%disabled%%', I10830 => '%%forward%%', 'copy' => '%%copy%%'), 'actions' => 'onChange="javascript:onForwardingChange(this.value);"', 'row_template' => 'row_alias_type', ));$this->TIlITIT(array(I10823 => 'alias', I10829 => true, 'caption_align' => I10831, 'caption_style' => 'font-size: 10px; margin-left: 40px; margin-right: 5px; display: inline;', 'row_template' => 'row_alias', I10832 => false, 'capt_td_end' => false, 'input_td_start' => false, 'hint_word' => 'hint_alias_type', ));$this->TIlITIT(array(I10823 => I10833, I10829 => true, 'align' => I10831, 'col_width' => "200")); $this->TIlITIT(array(I10823 => 'disk_space', I10829 => true, I10834 => I10831, 'col_width' => "150", 'readonly' => true, 'input_template' => I10835, ));}function TTTlIII() {parent::TTTlIII(); $this->filter->AddField("flt_mailbox", "text", stripslashes(unhtmlentities($this->cms->Vars["flt_mailbox"])), "", I10836, $this->lI1IL1L.".local_part"); $this->filter->AddField("flt_adress", "text", stripslashes(unhtmlentities($this->cms->Vars["flt_adress"])), I10837, I10836, $this->lI1IL1L.".alias"); }function &TTTlI1I(&$aData) {$aTmp =Array(); if($this->itemData['disk_space']) {$this->itemData['disk_space'] =strip_tags(getBytesAsText($this->itemData['disk_space'], $aTmp, 2, 2)); }if(!$this->itemData[I10833]) {$this->itemData[I10833] =$this->module->GetOption(I10838); }parent::TTTlI1I($aData); }function TTTlI11(&$vData, &$aCustom) {$aCustom['list_data']['sort_email'] =$aCustom['list_data']['sort_m.local_part,v.domain']; $this->cms->Gui->addGlobalVars(Array(I10839 => 70)); parent::TTTlI11($vData, $aCustom); }function TIlTI1I($aFields) {$aFields += parent::TIlTI1I($aFields); $aFields += Array("alias_type"=>Array("action"=>"callback", "object"=>&$this, I10840=>'_SubstituteAliasType') );$aFields += Array("action_purge"=>Array("action"=>"flagicon", I10841=>I10837, "id"=>"purge_id", "on"=>$this->moduleName."_list:icon_mailmanage_purge",I10842=>I10837)); return $aFields; }function TIlTI11() {$aSql =parent::TIlTI11(); if ($aSql['alias_type'] == 'none') {$aSql['alias'] =''; }return $aSql; }function TTT1IlI($aSql =Array(), $cId =0) {$aSql =parent::TTT1IlI($aSql, $cId); unset($aSql[I10843]); return $aSql; }function TTTlITT($IIIL11l, $cId, $cModule =I10837) {parent::TTTlITT($IIIL11l, $cId, $cModule); if($IIIL11l=='purge') {$this->TIlTl1T($cId); }}function TIlTl1T($cId) {if(!$this->TIlTll1($cId)) {$this->cms->AddStatusMsg("access_violation", "red"); return false; }$this->cms->ClearMessages(); if($this->TIlTl1I()) {$this->cms->AddStatusMsg('mbox_purge_failed',I10844); }else {$this->cms->AddStatusMsg('mbox_purge_ok','blue'); }}function TIlTl1I($args =null) {return $this->TIlT1lT('purge', $args, false); }function TIlTlTT() {$lI1IIlL=array( 'tables'=>Array(I10845 => 'cms_hst_res_email_inst', I10826 => 'cms_hst_res_vhost_inst'), 'joins'=>Array('r|m'=>I10846, 'm|v'=>'m.id_vhost=v.id'), 'joins_types'=>Array('r|m'=>I10847, 'm|v'=>I10847) );return $lI1IIlL; }function TIlTl1l($email) {$res =true; return $res; }function _ApplyResFieldsCB(&$vItem, &$vData) {$aTmp =Array(); $vItem[I10833] =FormatNumber($vItem["disk_quota"], 0, 0); $vItem[I10843] =getBytesAsText($vItem["disk_space"], $aTmp, 2, 2); $vItem['email'] =str_replace (I10848, "@<br>", $vItem["email"]); parent::_ApplyResFieldsCB($vItem, $vData); }function _SubstituteAliasType(&$vItem, &$vData) {$vItem['alias_type'] =$this->fields['alias_type'][I10849][$vItem['alias_type']]; }}?>