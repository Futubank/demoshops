<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       10518 xkqwiulqsllpxsyswgkqsgmslrkzpkzqtxztlwkugqisglyizwzyinmypiskwmlllyuwpnir
 */ ?><?php foreach(array(22454=>'MnMt`GOG',22455=>"DMtQD|WHunt|CZrn",22456=>"ZWtMHn",22457=>"",22458=>'MnDtZJJQS|JZnPD',22459=>"rHHt|nZIQ",22460=>"JZB|f",22461=>"YHSB=''!?",22462=>'MD|DQWtMHn',22463=>"'",22464=>'trMZJ|OZDO',22465=>"ZGGJB",22466=>"WID|DMtQD",22467=>"DtZtuD|ZGGJB|fZMJ",22468=>"MS",22469=>"QSMt",22470=>"urJ",22471=>"DMtQD|JMDt",22472=>"nZIQ",22473=>"SZtQtH",22474=>"rHC1",22475=>"DtBJQ",22476=>"GZPQr",22477=>"DGZWQr",22478=>"DMtQD|DuYfHrI",22479=>"DMtQD|fHrI",22480=>"ZJMPn=WQntQr") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $lLIlIIl ="services"; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath. I22454; $l1LILI1 =&$adm->Core->GetModule("srv_multi_sites"); $adm->InitMessages($adm->Gui->ParseLangFile("templates/lang/_srv_multi_sites_msgs.lng")); function TlIIIIl(){ global $IlLIll1, $db, $adm; $res =true; $sql ="SELECT count(id) as c FROM cms_sites"; $db->query($sql); if($db->next_record() && ($db->Record["c"] >= $IlLIll1)){ $res =false; $adm->AddStatusMsg(I22455, "red", "", "", array("num"=>"$IlLIll1")); }return $res; }if($adm->Vars[I22456] == "add") {$name =$adm->VarsPost["name"]; $url =rtrim(mb_strtolower($adm->VarsPost["url"]), "/"); if($name != I22457 && $url != I22457 && TlIIIIl()) {$asql =Array( "name"=>$name, "url"=>$url, );$sql =$db->GenInsertSQL("cms_sites", $asql); $db->query($sql); $lid =$db->lastInsertId(); $applied_id =$lid; $l1LILlI =$adm->Core->GetOption('default_ids'); $l1lIlL1 =$l1LILlI; $template_blocks_number =$adm->PManager->GetProperty("template_blocks_number"); if(!$adm->Core->GetOption("allow_multi_lang")) $I1lllIl =Array($adm->Core->GetOption("default_data_lang")); else $I1lllIl =$adm->Core->GetAOption(I22458); $ILl1I1I =$adm->Gui->lang; foreach($I1lllIl as $l1LILll) {$l1lILL1 =I22457; $I1lI1LL =Array(); $adm->setLang($adm->lang_data); $l1lIlLl =$adm->Gui->ParseLangFile("templates/lang/_srv_multi_sites_msgs.lng"); $pageName =str_replace('_site_', $name, $l1lIlLl[I22459]); $pid =intval($l1LILlI[$l1LILll]); $module_name ="pages"; $sql ="SELECT * FROM cms_layouts WHERE is_default='1' AND lang='".$l1LILll."' AND hidden=0"; $db->query($sql); if ($db->next_record()){ $llIIlII =$db->Record["id"]; for ($i=1;$i<=$template_blocks_number;$i++) $I1lI1LL[I22460.$i."_body"] =addslashes($db->Record[I22460.$i."_body"]); }if(!empty($pageName) && $llIIlII>0 && $pid>0) {$sql ="INSERT INTO cms_pages SET ". "parent_id='$pid', ". "all_parents='0,$pid', ". "name='$pageName', ". "module_name = '$module_name',". "lay_id='$llIIlII', ". "script_link='', ". I22461; for ($i=1;$i<=$template_blocks_number;$i++) $sql .= I22460.$i."_body='".$I1lI1LL[I22460.$i."_body"]."', "; $aData =Array( 'show_in_sitemap'=>1, I22462=>1, );$sql .= "removable = '0', ". "hidden = '0', ". "fixed_name = '0', ". "public='1', ". "last_changed=NOW(), ". "id_site='$lid', ". Tree::TI11T11($aData). "lang='$l1LILll'"; $db->query($sql); $pageId =$db->lastInsertId(); $sql ="UPDATE cms_pages SET ". "position = '".$pageId."' ". "WHERE id='".$pageId.I22463; $db->query($sql); Tree::TI11ITI(I22464, $GLOBALS['db']); $l1lIlL1[$l1LILll] =$pageId; }else{ $adm->AddStatusMsg("status_add_site_fail", "red", I22457, I22457, Array('lang'=>$adm->TTITl1T($l1LILll))); }}$sql ="UPDATE cms_sites SET default_pages='".addslashes(serialize($l1lIlL1))."' WHERE id='$lid'"; $db->query($sql); $adm->setLang($ILl1I1I); $adm->AddStatusMsg("status_add"); }else{ $adm->AddStatusMsg("status_add_fail", "red"); }}if($adm->Vars["id"]>0 && $adm->Vars[I22456] == I22465 ){$name =$adm->VarsPost["name"]; $url =$adm->VarsPost["url"]; if($name != I22457 && $url != I22457) {$asql =Array( "name"=>$name, "url"=>$url );$sql =$db->GenUpdateSQL(I22466, $asql, "WHERE id='".$adm->Vars["id"].I22463); $db->query($sql); $applied_id =$adm->Vars["id"]; $adm->AddStatusMsg("status_apply"); }else{ $adm->AddStatusMsg(I22467, "red"); }unset($adm->Vars["id"]); }if($adm->Vars["id"]>0 && $adm->Vars[I22456] == "del") {$sql ="DELETE FROM cms_sites WHERE id='".$adm->Vars["id"].I22463; $db->query($sql); $sql ="UPDATE cms_pages SET removable=1, id_site=0 WHERE id_site='".$adm->Vars["id"].I22463; $db->query($sql); $adm->AddStatusMsg("status_del"); unset($adm->Vars[I22468]); }$form[I22465] ="disabled"; $form[I22456] ="add"; $form["public"] ="checked"; if( $adm->Vars[I22456] == I22469 && $adm->Vars[I22468]>0) {$sql ="SELECT id, name, url FROM cms_sites ". "WHERE id='".$adm->Vars[I22468].I22463; $db->query($sql); if($db->next_record()) {$form[I22468] =$db->Record[I22468]; $form["name"] =$db->Record["name"]; $form[I22470] =$db->Record[I22470]; $form["add"] ="disabled"; $form[I22456] =I22465; $form[I22465] =I22457; }}$adm->Gui->addBlock("sites_list","templates/srv_multi_sites_list.tpl"); $l1LILlL =$adm->TTITI1T(I22471); $adm->Filter->AddField("flt_name", "text", stripslashes(unhtmlentities($adm->Vars["flt_name"])), I22457, " like ", I22472); $adm->Filter->MoveField("flt_name", _MOVE_PREV); if($adm->Filter->issetField("datefrom")) $adm->Filter->TITI1l1("datefrom"); if($adm->Filter->issetField("dateto")) $adm->Filter->TITI1l1(I22473); $filter ="WHERE 1 "; $filter .= $adm->Filter->GetFilterSql(); $filter .= "ORDER BY ".$adm->Pager->TI1TTlT(I22472).", id asc "; $sql ="SELECT id from cms_sites $filter "; $db->query($sql); $adm->Pager->MaxCount =$db->num_rows(); if(isset($applied_id) && $applied_id>0){ $adm->Pager->Position =$adm->Pager->TI1TT1l($db, I22468, $applied_id); }$adm->Pager->TI1TT1I(); $adm->Filter->UpdateField("offset", $adm->Pager->Position); $lll1lII =$adm->Pager->GetPager(); $pager =$adm->Pager->GetPagerHtml( $lll1lII, "javascript:go_page('[START]');"); if($adm->Pager->MaxCount>0){ $sql ="SELECT id, name, url ". "from cms_sites $filter ".$adm->Pager->TI1TTlI(); $db->query($sql); $i=1; while($db->next_record()) {$lid =$db->Record[I22468]; $l1LILl1[I22472] =$db->Record[I22472]; $l1LILl1[I22470] =$adm->stripLine($db->Record[I22470], 120); $links["del_id"] =$links["edit_id"] =$lid; $style ="row2"; if($i%2) $style=I22474; if($adm->Vars[I22468]>0 && $adm->Vars[I22468] == $lid) $style ="row3"; if($lid == $applied_id) $style ="row4"; $actions =$adm->Gui->get("sites_list:icons_edit_del",$links); $l1LILl1["actions"] =$actions; $l1LILl1[I22468] =$lid; $l1LILl1[I22475] =$style; $l1LILlL[I22471] .= $adm->Gui->get("sites_list:row",$l1LILl1); $i++; }$l1LILlL["legend"] .= $adm->Gui->getAbs("sites_list:leg_yellow",I22457); $l1LILlL["legend"] .= $adm->Gui->getAbs("sites_list:leg_blue",I22457); $l1LILlL["legend"] .= $adm->Gui->getAbs("sites_list:leg_edit",I22457); $l1LILlL["legend"] .= $adm->Gui->getAbs("sites_list:leg_del",I22457); $l1LILlL[I22476] =$pager; $html["list_table"] =$adm->Gui->get(I22471,$l1LILlL); }else {$html["list_table"] =$adm->Gui->getAbs("sites_list:empty",I22457); $html["list_table"] .= $adm->Gui->getAbs(I22477,I22457); }$html["list_table"] .=$adm->Gui->getAbs(I22477,I22457); $form["filter_hidden_fields"] =$adm->Filter->GetFieldsAsHidden(); $adm->Gui->addBlock("sites_form","templates/form.tpl"); $adm->Gui->addBlock(I22478, "templates/srv_multi_sites_form.tpl"); if($form["add"] != "disabled") {$l1LILlL =$adm->Gui->get(I22478, $form); $html["form"] =$adm->Gui->getAbs(I22479,Array("header"=>$adm->Words["srv_multi_sites_add"],"content"=>$l1LILlL,"form_align"=>I22480)); }else {if($form[I22456] == I22465) {$form["cancel"] =$adm->Gui->getAbs("sites_subform:cancel", I22457); }$l1LILlL =$adm->Gui->get(I22478, $form); $html["form"] =$adm->Gui->getAbs(I22479,Array("header"=>$adm->Words["srv_multi_sites_apply"],"content"=>$l1LILlL,"form_align"=>I22480)); }require $GLOBALS['DEFAULT_INCLUDES_PATH'] .'done.php'; ?>