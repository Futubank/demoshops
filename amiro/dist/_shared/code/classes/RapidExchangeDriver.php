<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       42442 xkqwinlxtswkpgwszxixyszwrwltrtryukrnyxrxixrkqxzrwrzyzkzkrlniwgtntqzmpnir
 */ ?><?php foreach(array(13754=>'vZrD',13755=>'ZSIdQDDMHn',13756=>'IQtZ|uGSZtQ',13757=>'DrW|MtQID',13758=>'|fMJQD',13759=>'WZtQPHrMQD',13760=>'SQJ|Mn|WZt',13761=>'MS',13762=>'MtQID',13763=>'fMJQD',13764=>'WZtD|MSD',13765=>'DrW|fMJQD',13766=>'MtQID|MSD',13767=>'WuDtHI|tBGQD',13768=>'DOMGGMnP|tBGQD',13769=>"?jmkq?",13770=>"wRqzTq?Tzyjq?",13771=>"zjTqR?Tzyjq?",13772=>"?dqjqwT?[?FRhi?",13773=>"?zUTh|mNwRqiqNT?=?",13774=>"?smdzyjq?kqbd",13775=>'WZtD',13776=>"{",13777=>"mNdqRT?mNTh?",13778=>'DrW|WZtD',13779=>'MIGHrt|',13780=>"sqdwRmyq?",13781=>"rQP",13782=>"MS",13783=>'GMS',13784=>'rQP',13785=>'nZIQ',13786=>'',13787=>'GZrQnt',13788=>'SZtZDQt|MS',13789=>'MS|DMtQ',13790=>'MSD|',13791=>'IHSuJQ',13792=>'DI|SZtZ',13793=>'<',13794=>'DuYJMnK',13795=>'ms|qXTqRNzj',13796=>'ZmtQI',13797=>'|SMDWZrS',13798=>'GrHWQDD|MtQID',13799=>'WZt',13800=>'MS|HCnQr',13801=>'=_NUjj',13802=>'GrMWQ',13803=>'YQfHrQ|ZGGJB',13804=>'MtQI|JMnKD',13805=>'GrMWQ|WOQWKYHx',13806=>'!',13807=>'Hn|DGQWMZJ',13808=>'SQDt|WZt|MS',13809=>'MS|WZtQPHrB',13810=>"mNdqRT?",13811=>'ZGGJB',13812=>'KQBCHrSD',13813=>'ZSS',13814=>'WHuntQrD',13815=>'coqRq?.MS.?=?',13816=>'fMJQD|MSD',13817=>'DrW|GrQfMx',13818=>'?cRmTq',13819=>"sqjqTq?FRhi?",13820=>"UNjhwk?Tzyjqd",13821=>'DOMGGMnP|IQtOHSD',13822=>'|MtQI') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class RapidExchangeDriver extends ExchangeDriver{ public $llLIII1; public $lIl11L1; public $llLIIlI; public $llLIIll; public $llLIIlL; public $llLIIl1; private $llLIILI =null; function RapidExchangeDriver(&$gui, &$module) {parent::__construct($gui, $module); $this->llLIIll =null; }function Start($actionType, &$aParams) {$II1LIlI =parent::Start($actionType, $aParams); $this->module->II1lIlL =mb_substr($this->module->II1lIlL, 5); return $II1LIlI; }function TI1T1lI(&$aParams, $llLIILl =array ()){$llLIILL =sizeof($llLIILl) >0; $I11lLIl =$aParams['eshop_params']['destination_cat_id']; $llLIIL1 =$aParams[I13754]['delete_mode']; $llLII1I =$this->module->cms->Core->GetOption('default_ids'); $llLII1I =$llLII1I[$this->module->langData]; global $oSession; if (is_object($oSession)) {$ownerId =$oSession->GetVar('user'); $ownerId =$ownerId['id']; }else if (function_exists(I13755)) {$session =admSession(); $ownerId =$session->GetVar('user'); $ownerId =$ownerId['id']; }else {$ownerId =0; }$this->lIl11L1 =" WHERE `lang` = '" .$this->module->langData ."'"; $this->llLIII1 =array (I13756 => empty($aParams[I13754][I13756]), 'src_prefix' => $this->module->oEshop->dbTablePrefix, 'id_site' => $this->module->siteId, 'id_owner' => $ownerId, 'dest_cat_id' => $I11lLIl, I13757 => $this->module->oEshop->dbTablePrefix .'_items', 'src_cats' => $this->module->oEshop->dbTablePrefix .'_cats', 'src_files' => $this->module->oEshop->dbTablePrefix .I13758 );$sql ="SELECT position FROM ". $this->llLIII1[I13757] ." ORDER BY position DESC LIMIT 1"; $this->llLIII1['item_position'] =intval($this->module->db->getValue($sql)); $this->llLIII1['datasets'] =array ();$this->llLIII1[I13759] =array ();$this->llLIII1['dest_cat'] =array ();$sql ="SELECT id, dataset_id, dataset_data, id_discount, id_shipping_type, id_external " ."FROM " .$this->llLIII1['src_cats'] .$this->lIl11L1; $rs =&$this->module->db->select($sql); $llLII1l =$llLIIL1 == I13760; $this->llLIIl1 =$llLIIL1 == 'notmodif_items'; while ($record =$rs->nextRecord()) {$this->llLIII1['datasets'][$record['dataset_id']] =$record['dataset_data']; $id =$record[I13761]; unset($record[I13761]); if ($id == $I11lLIl) {$this->llLIII1['dest_cat'] =$record; }if ($llLII1l && $id != $I11lLIl) {continue; }$II1LI1I =$record['id_external']; unset($record['dataset_data'], $record['id_external']); $this->llLIII1[I13759][$II1LI1I] =$record; }$this->llLIII1 += array (I13762 => 'import_' .$this->llLIII1[I13757], 'cats' => 'import_' .$this->llLIII1['src_cats'], I13763 => 'import_' .$this->llLIII1['src_files'], 'items_ids' => 'ids_import_' .$this->llLIII1[I13757], I13764 => 'ids_import_' .$this->llLIII1['src_cats'], 'files_ids' => 'ids_import_' .$this->llLIII1[I13765] );$aSQL =array ("DROP TABLE IF EXISTS " .$this->llLIII1[I13762], "DROP TABLE IF EXISTS " .$this->llLIII1['cats'], "DROP TEMPORARY TABLE IF EXISTS " .$this->llLIII1[I13766], "DROP TEMPORARY TABLE IF EXISTS " .$this->llLIII1[I13764] );if ($llLIILL) {$aSQL[] ="DROP TEMPORARY TABLE IF EXISTS " .$this->llLIII1['files_ids']; }$tables =array ('currency' => true, I13767 => false, 'datasets' => true, 'letters' => true, 'ref_types' => false, 'shipping_methods' => true, I13768 => true )+$llLIILl; foreach ($tables as $table => $llLII1L) {$llLII11 =$this->module->oEshop->dbTablePrefix .'_' .$table; $llLIlII ='import_' .$llLII11; $aSQL[] ="DROP TABLE IF EXISTS " .$llLIlII; $aSQL[] ="CREATE TABLE " .$llLIlII .I13769 .$llLII11; $aSQL[] ="INSERT INTO " .$llLIlII ." SELECT * FROM  " .$llLII11 .($llLII1L ?$this->lIl11L1 :''); }$llLIlIl =true; $llLIlIL =TRUE; if ($llLIIL1 == I13762) {$aSQL[] ="CREATE TABLE " .$this->llLIII1[I13762] .I13769 .$this->llLIII1[I13757]; $aSQL[] =I13770 .$this->llLIII1['cats'] .I13769 .$this->llLIII1['src_cats']; $aSQL[] ="ALTER TABLE " .$this->llLIII1[I13762] ." DISABLE KEYS"; $aSQL[] =I13771 .$this->llLIII1['cats'] ." DISABLE KEYS"; $llLIlIL =FALSE; $aSQL[] ="INSERT INTO " .$this->llLIII1['cats'] .I13772 .$this->llLIII1['src_cats'] .$this->lIl11L1; $sql ="SELECT MAX(id) FROM " .$this->llLIII1[I13757] ." WHERE `lang` != '" .$this->module->langData ."'"; $aSQL[] =I13771 .$this->llLIII1[I13762] .I13773 .(intval($this->module->db->getValue($sql)) +1); $llLIlIl =false; $this->module->skipDellAll =true; }else if ($llLIIL1 == I13760) {$aSQL[] =I13770 .$this->llLIII1[I13762] .I13769 .$this->llLIII1[I13757]; $aSQL[] =I13770 .$this->llLIII1['cats'] .I13769 .$this->llLIII1['src_cats']; if ($llLII1I == $I11lLIl) {$aSQL[] =I13771 .$this->llLIII1[I13762] ." DISABLE KEYS"; $aSQL[] =I13771 .$this->llLIII1['cats'] .I13774; $llLIlIL =FALSE; $aSQL[] ="INSERT INTO " .$this->llLIII1['cats'] .I13772 .$this->llLIII1['src_cats'] ." WHERE id = " .$llLII1I; $sql ="SELECT MAX(id) FROM " .$this->llLIII1[I13757] ." WHERE `lang` != '" .$this->module->langData ."'"; $aSQL[] =I13771 .$this->llLIII1[I13762] .I13773 .(intval($this->module->db->getValue($sql)) +1); }else {$aSQL[] =I13771 .$this->llLIII1[I13762] .I13774; $aSQL[] =I13771 .$this->llLIII1['cats'] .I13774; $llLIlIL =FALSE; $aSQL[] ="INSERT INTO " .$this->llLIII1[I13775] .I13772 .$this->llLIII1['src_cats'] .$this->lIl11L1; $aSQL[] ="INSERT INTO " .$this->llLIII1[I13762] .I13772 .$this->llLIII1[I13757] .$this->lIl11L1; $sql ="SELECT `id` FROM " .$this->llLIII1['src_cats'] ." WHERE `all_parents` LIKE '%," .$I11lLIl .",%'"; $rs =&$this->module->db->select($sql); $ids =array ();while (list ($id) =$rs->nextRecord(MYSQL_NUM)) {$ids[] =$id; }if (sizeof($ids)) {$aSQL[] ="DELETE FROM " .$this->llLIII1[I13775] ." WHERE `id` IN (" .implode(',', $ids) .I13776; }$ids[] =$I11lLIl; $aSQL[] ="DELETE FROM " .$this->llLIII1[I13762] ." WHERE `id_category` IN (" .implode(',', $ids) .I13776; $aSQL[] ="OPTIMIZE TABLE " .$this->llLIII1[I13762]; unset($ids, $id); }$llLIlIl =false; }if ($llLIlIl) {$aSQL[] =I13770 .$this->llLIII1[I13762] .I13769 .$this->llLIII1[I13757]; $aSQL[] =I13771 .$this->llLIII1[I13762] .I13774; $aSQL[] =I13777 .$this->llLIII1[I13762] .I13772 .$this->llLIII1[I13757] .$this->lIl11L1; $sql ="SELECT MAX(id) FROM " .$this->llLIII1[I13757] ." WHERE `lang` != '" .$this->module->langData ."'"; $aSQL[] =I13771 .$this->llLIII1[I13762] .I13773 .(intval($this->module->db->getValue($sql)) +1); $aSQL[] =I13770 .$this->llLIII1[I13775] .I13769 .$this->llLIII1['src_cats']; $aSQL[] =I13771 .$this->llLIII1[I13775] .I13774; $aSQL[] =I13777 .$this->llLIII1[I13775] .I13772 .$this->llLIII1[I13778] .$this->lIl11L1; $llLIlIL =FALSE; }$aSQL[] ="CREATE TEMPORARY TABLE " .$this->llLIII1[I13766] ." AS SELECT id, id_external FROM " .$this->llLIII1[I13762]; $aSQL[] ="CREATE TEMPORARY TABLE " .$this->llLIII1[I13764] ." AS SELECT id, id_parent, id_external, sublink FROM " .$this->llLIII1[I13775]; if($llLIlIL){ $aSQL[] =I13771 .$this->llLIII1[I13762] .I13774; $aSQL[] =I13771 .$this->llLIII1[I13775] .I13774; }$aSQL[] =I13771 .$this->llLIII1[I13766] ." ADD INDEX `i_id_external` (`id_external`)"; $aSQL[] =I13771 .$this->llLIII1[I13764] ." ADD PRIMARY KEY (`id`)"; $aSQL[] =I13771 .$this->llLIII1[I13764] ." ADD INDEX `i_id_external` (`id_external`)"; if ($llLIILL) {$aSQL[] ="CREATE TEMPORARY TABLE " .$this->llLIII1['files_ids'] ." AS SELECT id, id_external FROM " .$this->llLIII1[I13763]; $aSQL[] =I13771 .$this->llLIII1['files_ids'] ." ADD PRIMARY KEY (`id`)"; $aSQL[] =I13771 .$this->llLIII1['files_ids'] ." ADD INDEX `i_id_external` (`id_external`)"; }foreach ($aSQL as $sql) {@set_time_limit($this->module->I11l1l1); $this->module->db->execute($sql, DBC_RAW_QUERY); }$this->module->I11lLIL =false; $this->llLIIlI =$this->module->oEshop->dbTablePrefix; $this->module->oEshop->dbTablePrefix =I13779 .$this->llLIIlI; $ownerName =$this->module->module->GetOwnerName(); foreach (array ('_item', '_cat', '_digitals') as $postfix) {$moduleName =$ownerName .$postfix; if ($this->module->cms->Core->IsInstalled($moduleName)) {$module =&$this->module->cms->Core->GetModule($moduleName); $module->TablePrefix =I13779 .$module->TablePrefix; }}$this->module->II1lLLI =true; $this->module->I11lLI1 ='ids_'; $this->llLIIlL =array ();$sql =I13780 .$this->llLIII1[I13762]; $rs =&$this->module->db->select($sql); while ($record =$rs->nextRecord()) {$this->llLIIlL[] =$record['Field']; }}function TI1T1ll() {$aSQL =array ();$sql ="SHOW TABLES LIKE '" .$this->llLIII1['src_prefix'] ."_reference_%'"; $rs =&$this->module->db->select($sql); while (list ($table) =$rs->nextRecord(MYSQL_NUM)) {$aSQL[] ="DROP TABLE IF EXISTS import_" .$table; $aSQL[] ="CREATE TABLE import_" .$table .I13769 .$table; $aSQL[] ="ALTER TABLE import_" .$table ." CHANGE `lang` `lang` char(3) default '" .$this->module->langData ."' NOT NULL"; $aSQL[] ="INSERT INTO import_" .$table .I13772 .$table .$this->lIl11L1; }foreach ($aSQL as $sql) {@set_time_limit($this->module->I11l1l1); $this->module->db->execute($sql, DBC_RAW_QUERY); }}function TT1TIIT($Il111ll =true) {if(is_array($this->Il11lL1["pid"]) && sizeof($this->Il11lL1["pid"]) >0) {foreach($this->Il11lL1["pid"] as $pid=>$children) {if(!isset($this->Il11lL1["id"][$pid])) {if(is_array($children)) {foreach($children as $child) {$this->Il11lL1[I13781][] =$child +Array("pid"=>$pid); $this->Il11lL1["reg_id"][$child["id"]] =1; unset($this->Il11lL1["id"][$child[I13782]]); }}unset($this->Il11lL1["pid"][$pid]); }}$this->TT1TIIT(false); }if ($Il111ll) {if (is_array($this->Il11lL1['reg'])) {$Il111lL =array ();$Il111l1 =array ();foreach (array_keys($this->Il11lL1['reg']) as $i) {$el =$this->Il11lL1['reg'][$i]; $set =true; if ($el[I13783] != '' && isset($Il111l1[$el[I13761]]) && $Il111l1[$el[I13761]][I13783] == '') {$Il111lL[] =$Il111l1[$el[I13761]]['idx']; }else if (isset($Il111l1[$el[I13761]])) {$Il111lL[] =$i; $set =false; }if ($set) {$Il111l1[$el[I13761]] =array (I13783 => $el[I13783], I13783 => $el[I13783], 'idx' => $i); }}foreach ($Il111lL as $i) {unset($this->Il11lL1[I13784][$i]); }}}}function _rapidImportCategoriesCB(&$aCatData, $II1L1lI) {$aItem =$this->module->TTII11T($this->module->II1llIl, $aCatData, true, array ('id_external' => $II1L1lI)); $id =$aItem[I13761]; unset($aItem[I13761]); if(isset($aItem['name'])){ $aItem['name'] =trim($aItem['name']); }if(isset($this->module->I11lLll[$id]) && (isset($aItem[I13785]) ?$aItem[I13785] === '' :TRUE)){ $this->module->TTIlTT1(3, array('message' => 'internal_warning_missing_new_category_obligatory_field')); $this->module->TTII1lT($this->module->II1llIL, 'add', I13786, $II1L1lI, TRUE); return; }unset($aItem['on_special']); if (isset($aItem['parent'])) {$aItem['id_parent'] =$aItem['parent']; unset($aItem[I13787]); }if($id && isset($aItem['id_parent']) && $id == $aItem['id_parent']){ $aItem['id_parent'] =0; }if (isset($this->llLIII1[I13759][$II1L1lI])) {$aItem += $this->llLIII1[I13759][$II1L1lI]; if (isset($this->llLIII1['datasets'][$this->llLIII1[I13759][$II1L1lI][I13788]])) {$aItem += array ('dataset_data' => $this->llLIII1['datasets'][$this->llLIII1[I13759][$II1L1lI][I13788]]); }}$aItem += $this->llLIII1['dest_cat']; $aItem += array ('lang' => $this->module->langData, I13789 => $this->llLIII1[I13789], 'id_owner' => $this->llLIII1['id_owner'], 'modified_date' => '=|NOW()' );if (!empty($this->module->I11lLll[$id]) || $this->llLIII1[I13756]) {$engine =&$this->module->II1llIL->Engine; $llLIlI1 =$engine->oEshop->tree->ll1lLI1; $engine->oEshop->tree->ll1lLI1 =I13790 .$llLIlI1; if(isset($aItem[$engine->options['name_field_name']])){ $engine->cms->IIIlL1l =array( I13791 => $engine->module->Name, I13761 => $id );list ($IIl1I1L, $IIILlLl) =$engine->TTT1Il1($aItem); $aItem['sublink'] =$engine->GenAutoLink($aItem[$engine->options['name_field_name']], $IIl1I1L, $IIILlLl); $engine->cms->IIIlL1l =array(); }$aItem['link_alias'] =I13786; $aItem[I13792] =I13786; $engine->oEshop->tree->ll1lLI1 =$llLIlI1; }$aCurrency =array(); foreach (array_keys($aItem) as $key) {if (preg_match('/^(?:currency|price_checkbox|db_currency)(\d+)$/', $key, $m)) {if ($key[0] == 'c') {if(!isset($aCurrency[$m[1]])){ $aCurrency[$m[1]] =array(); }$aCurrency[$m[1]][1] =$aItem[$key]; }elseif($key[0] == 'd') {if(!isset($aCurrency[$m[1]])){ $aCurrency[$m[1]] =array(); }$aCurrency[$m[1]][0] =$aItem[$key]; }unset($aItem[$key]); }}foreach($aCurrency as $priceNum => $llLIllI){ $aItem['price' .$priceNum] .= I13793 .implode(':', $llLIllI); }unset($llLIllI, $aCurrency, $aCurrency); $sql =$this->module->db->genUpdateSQL($this->llLIII1[I13775], $aItem, "WHERE id = " .$id); $this->module->db->execute($sql, DBC_IGNORE_CACHE); if(!empty($aItem['sublink'])){ $sql =$this->module->db->genUpdateSQL($this->llLIII1[I13764], array( 'sublink' => $aItem[I13794] ),"WHERE id = " .$id); $this->module->db->execute($sql, DBC_IGNORE_CACHE); }$this->module->TTII1Il(I13786, 0, I13786, false); $this->module->TTII1lT($this->module->II1llIL, isset($this->module->I11lLll[$id]) ?'add' :'apply', I13786, $II1L1lI); }function _rapidImportItemsCB(&$aItemData) {$llLIlll =$this->module->oEshop->dbTablePrefix; $this->module->oEshop->dbTablePrefix =I13790 .$this->module->oEshop->dbTablePrefix; $aItem =$this->module->TTII11T($this->module->II1llIl, $aItemData, true, array ('id_external' => $aItemData[I13795])); $aEvent =array( 'type' => 'import', 'driver' => $this->name, 'modId' => $this->module->II1llIL->Name, I13796 => &$aItem, '_discard' => FALSE );AMI_Event::fire('deprecated_v5_on_dataexchange_rapid_item_import', $aEvent, AMI_Event::MOD_ANY); AMI_Event::fire('v5_on_dataexchange_item', $aEvent, AMI_Event::MOD_ANY); if(!empty($aEvent['bForbid']) || !empty($aEvent[I13797])){ $this->module->oEshop->dbTablePrefix =$llLIlll; return; }$id =$aItem[I13761]; unset($aItem[I13761]); $lIILll1 =empty($id); if(isset($aItem[I13785])){ $aItem[I13785] =trim($aItem[I13785]); }if($lIILll1 && (isset($aItem[I13785]) ?$aItem[I13785] === I13786 :TRUE)){ $this->module->oEshop->dbTablePrefix =$llLIlll; $this->module->TTIlTT1(2, array('message' => 'internal_warning_missing_new_product_obligatory_field')); $this->module->TTII1lT($this->module->II1llIL, 'add', I13786, $aItemData[I13795], TRUE); return; }$IIlLIIL =array ('action' => I13798, I13761 => I13786, 'data' => &$this->module->cms->VarsPost); $this->module->TTT1lI1($IIlLIIL); $this->module->oEshop->dbTablePrefix =$llLIlll; if (isset($aItem['cat'])) {$aItem['id_category'] =$aItem['cat']; unset($aItem[I13799]); }$aItem += array ('lang' => $this->module->langData, 'modified_date' => '=|NOW()', I13789 => $this->llLIII1[I13789], 'id_owner' => $this->llLIII1[I13800] );if ($lIILll1 || $this->llLIII1[I13756]) {$engine =&$this->module->II1llIL->Engine; $llLIlI1 =$engine->oEshop->tree->ll1lLI1; $engine->oEshop->tree->ll1lLI1 =I13790 .$llLIlI1; list($IIl1I1L, $IIILlLl) =$engine->TTT1Il1($aItem); $engine->cms->IIIlL1l =array( I13791 => $engine->module->Name, I13761 => empty($id) ?0 :$id );$aItem[I13794] =$engine->GenAutoLink($aItem[$engine->options['name_field_name']], $IIl1I1L, $IIILlLl); $engine->cms->IIIlL1l =array(); $aItem['link_alias'] =I13786; if(empty($aItem[I13792])){ $aItem[I13792] =I13786; }$engine->oEshop->tree->ll1lLI1 =$llLIlI1; }$llLIllL =array ();foreach (array_keys($aItem) as $key) {if (preg_match('/^price_checkbox(\d+)$/', $key, $matches)) {$llLIllL[] =$matches[1]; unset($aItem[$key]); }}foreach ($this->module->oEshop->priceFields as $priceNum){ $llLIll1 ='price' .$priceNum; if (in_array($priceNum, $llLIllL)){ if($aItem[$llLIll1] === I13786){ $aItem[$llLIll1] =I13801; }}else{ unset($aItem[$llLIll1]); }}foreach (array_merge(array(I13786, $this->module->oEshop->priceFields)) as $priceNum) {if(isset($aItem['price' .$priceNum])){ $aItem['price' .$priceNum] =str_replace(',', '.', $aItem[I13802 .$priceNum]); }}unset($aItem['tax_old']); if (isset($aItem['file_ids'])) {$this->cms->Vars['file_ids'] =$aItem['file_ids']; $none =array ();if ($id) {$this->module->II1llIL->Engine->oEshop->TTT1lI1(I13803, $id, $aItem, $none); }unset($aItem['file_ids']); }if (empty($aItem['item_type'])) {unset($aItem['item_type']); }$llLIlLI =I13786; if(isset($aItem['item_links'])){ if($this->module->I11LIlL){ $llLIlLI =$aItem[I13804]; }unset($aItem[I13804]); }if(!empty($aItem[I13792])){ $this->processHTMLMeta($aItem); }foreach (array ('picture','popup_picture','small_picture') as $field) {if (isset($aItem[$field])) {$aItem['ext_' .$field] =$aItem[$field]; unset($aItem[$field]); }}unset($aItem[I13805], $aItem['quantity'], $aItem['fdate'], $aItem['item_links_list'], $aItem['item_links_num'], $aItem['eshop_digitals_quantity']); $diff =array_diff(array_keys($aItem), $this->llLIIlL); if (sizeof($diff)) {$this->module->TTIlTT1(5, array ('message' => 'status_internal_warning_excess_db_fields', 'params' => array ('fields' => implode(I13806, $diff)))); $this->module->TTII1lT($this->module->II1llIL, $lIILll1 ?'add' :'apply', I13786, $aItemData[I13795], true); return; }if(isset($aItem['on_special']) && is_array($aItem['on_special'])){ $aItem[I13807] =array_sum($aItem[I13807]); }if ($lIILll1) {$aItem['date'] ='=|NOW()'; if (empty($aItem['id_category'])) {$aItem['id_category'] =$this->llLIII1[I13808]; }if(empty($aItem['position'])){ $aItem['position'] =++$this->llLIII1['item_position']; }$sql =$this->module->db->genInsertSQL($this->llLIII1[I13762], $aItem); $res =$this->module->db->execute($sql, DBC_IGNORE_CACHE); $id =$this->module->db->lastInsertId(); }else {$sql =$this->module->db->genUpdateSQL($this->llLIII1[I13762], $aItem, "WHERE id = " .$id); $res =$this->module->db->execute($sql, DBC_IGNORE_CACHE); $this->module->II1llIL->Engine->TIIlIl1($id, array_keys($aItem)); }if(mb_strlen($llLIlLI)){ $this->module->II1llIL->Engine->lIIlI11 =false; $this->module->II1llIL->Engine->TIIlIll($id, $aItem[I13809], $llLIlLI); $this->module->II1llIL->Engine->lIIlI11 =false; }if ($lIILll1 && $res) {$llLIlLl =!empty($this->cms->Vars['file_ids']); $llLIlLL =$engine->cms->IIIlL1L && $aItem[I13794] === I13786; if($llLIlLl || $llLIlLL){ $aSQL =array(); if($llLIlLl){ $this->module->II1llIL->Engine->oEshop->TTT1lI1(I13803, $id, $aSQL, $none); }if($llLIlLL){ list($IIl1I1L, $IIILlLl) =$engine->TTT1Il1($aItem); $engine->cms->IIIlL1l =array( I13791 => $engine->module->Name, I13761 => $id );$aSQL[I13794] =$engine->GenAutoLink($aItem[$engine->options['name_field_name']], $IIl1I1L, $IIILlLl); $engine->cms->IIIlL1l =array(); }$sql =$this->module->db->genUpdateSQL($this->llLIII1[I13762], $aSQL, "WHERE id = " .$id); $this->module->db->execute($sql, DBC_IGNORE_CACHE); }$aSQL =array (I13761 => $id, 'id_external' => addslashes($aItemData[I13795]) );$sql =$this->module->db->genInsertSQL($this->llLIII1[I13766], $aSQL); $this->module->db->execute($sql, DBC_IGNORE_CACHE); }if ($this->module->I11LIII && !empty($this->module->I11LIIl)) {$this->module->TIIIlIT(); $sql =I13810.$this->module->oEshop->dbTablePrefix."_de_tmp VALUES('".$id."', '".addslashes(serialize($this->module->I11LIIl))."')"; $this->module->db->execute($sql); $this->module->I11LIIl =array ();}$this->module->TTII1Il(I13786, 0, I13786, false); $this->module->TTII1lT($this->module->II1llIL, $lIILll1 ?'add' :I13811, I13786, $aItemData[I13795]); }private function processHTMLMeta(array &$aItem){ $aMeta =$aItem[I13792]; array_walk($aMeta, 'trim'); if(isset($aMeta['keywords'])){ $aMeta['keywords'] =str_replace('"', I13786, $aMeta[I13812]); }foreach(array(I13812, 'description') as $key){ if(isset($aMeta[$key])){ $aMeta[$key] =str_replace('"', I13786, AMI_Lib_String::unhtmlEntities($aMeta[$key])); }}$aItem[I13792] =addslashes(serialize($aMeta)); }function TI1T1l1() {$llLIlL1 =preg_match('/_item$/', $this->module->II1llIL->Name); if(!$llLIlL1){ $this->llLIIll =&$this->module->II1llIL->Engine; }$this->module->II1llIL->Engine->cms->Vars['gen_keywords_force'] =true; $table =$this->module->II1llIL->TablePrefix .$this->module->II1llIL->TableName; @set_time_limit($this->module->I11l1l1); $LIMIT =100; $START =0; $sqlPart =$this->llLIIl1 ?" AND `modified_date` >= '" .$this->module->I11l111 ."'" :I13786; $sql ="SELECT `id`, IF(`sm_data` = '', 1, 0) `smde`, IF(`hs_cat` = '', 1, 0) `she`  " ."FROM " .$table ." " ."WHERE `sm_data` = '' OR `hs_cat` = ''" .$sqlPart ." LIMIT " .$LIMIT; $rs =&$this->module->db->select($sql); $llLIl1I =$this->module->II1llIL->GetOption('keywords_generate') == 'none'; while ($rs->numRows() >0) {echo ' '; if (ob_get_level()) {ob_flush(); }@set_time_limit($this->module->I11l1l1); $ids =array ();$llLIl1l =array(); while (list ($id, $llLIl1L, $llLIl11) =$rs->nextRecord(MYSQL_NUM)) {if($llLIl1L){ $llLIl1l[] =$id; }if($llLIl11){ $ids[] =$id; }}$llLILII =I13786; if (sizeof($ids)) {@set_time_limit($this->module->I11l1l1); if($llLIlL1){ $this->module->II1llIL->Engine->importForceAction =I13813; }$llLILII =implode(I13806, $ids); $this->module->II1llIL->Engine->TTT1Tl1('search_hash', I13786, " WHERE `id` IN (" .$llLILII .I13776); $this->module->TTII1Il(I13786, 0, I13786, false); @set_time_limit($this->module->I11l1l1); $this->module->II1llIL->Engine->TTT1TTT($ids, I13786); $this->module->TTII1Il(I13786, 0, I13786, false); }@set_time_limit($this->module->I11l1l1); if(!$llLIl1I && sizeof($llLIl1l)){ $IIl1llL ="UPDATE " .$table ." " ."SET `sm_data` = 'a:0:{}' " ."WHERE `sm_data` = '' AND `id` IN (" .implode(I13806, $llLIl1l) .I13776; $this->module->db->execute($IIl1llL); unset($IIl1llL); }$START += $LIMIT; $sql ="SELECT `id`, IF(`sm_data` = '', 1, 0) `smde`, IF(`hs_cat` = '', 1, 0) `she`  " ."FROM " .$table ." " ."WHERE `sm_data` = '' OR `hs_cat` = ''" .$sqlPart ." LIMIT " .$START .", " .$LIMIT; $rs =&$this->module->db->select($sql); }}function TI1T11T() {if (sizeof($this->module->I11lLll)) {@set_time_limit($this->module->I11l1l1); $sql ="UPDATE " .$this->llLIII1[I13775] ." SET `position` = `id` WHERE `id` IN (" .implode(I13806, array_keys($this->module->I11lLll)) .I13776; $this->module->db->execute($sql); }}function TI1T11I($llLILIl, $llLILIL =false) {if (is_object($this->llLIIll)) {$this->llLIIll->TTT1Tl1(I13814, I13786); }$aMap =$this->module->TTII111('fields_map'); $tables =isset($aMap['CATALOG']['SUBLINK']) ?array() :array($this->llLIII1[I13762]); unset($aMap); $count =0; foreach ($tables as $table) {do {@set_time_limit($this->module->I11l1l1); $sql ="SELECT `sublink` FROM " .$table ." GROUP BY `sublink` HAVING COUNT(1) > 1"; $rs =&$this->module->db->select($sql); if ($rs->numRows() <1) {break; }while (list ($sublink) =$rs->nextRecord(MYSQL_NUM)) {@set_time_limit($this->module->I11l1l1); $sql ="SELECT `id` FROM " .$table ." WHERE `sublink` = '" .addslashes($sublink) ."'"; $rs1 =&$this->module->db->select($sql); $first =true; while (list ($id) =$rs1->nextRecord(MYSQL_NUM)) {if ($first) {$first =false; continue; }$sql =$this->module->db->genUpdateSQL($table, array (I13794 => addslashes($sublink .'-' .$id)), I13815 .$id); $this->module->db->execute($sql); $count++; if(!($count %100))echo ' '; }}}while (true); }$aSQL =array ("DROP TEMPORARY TABLE " .$this->llLIII1[I13766], "DROP TEMPORARY TABLE " .$this->llLIII1[I13764], "DROP TEMPORARY TABLE IF EXISTS " .$this->llLIII1[I13816] );$llLILI1 =array ();$tables =array (I13762, I13775, 'letters'); if ($llLILIL) {$tables[] =I13763; }if ($llLILIl) {$sql ="SHOW TABLES LIKE '" .$this->llLIII1['src_prefix'] ."_reference_%'"; $rs =&$this->module->db->select($sql); $l =mb_strlen($this->llLIII1[I13817]) +1; while (list ($table) =$rs->nextRecord(MYSQL_NUM)) {$tables[] =$llLILI1[] =mb_substr($table, $l); }}$llLILlI =array ();foreach ($tables as $table) {$llLILlI[] =$this->llLIII1[I13817] .'_' .$table; $llLILlI[] =I13779 .$this->llLIII1[I13817] .'_' .$table; }$aSQL[] ="LOCK TABLES " .implode(' WRITE, ', $llLILlI) .I13818; foreach ($tables as $table) {$llLII11 =$this->llLIII1[I13817] .'_' .$table; $llLIlII =I13779 .$llLII11; $aSQL[] =I13771 .$llLII11 .I13774; $sql ="SELECT 1 FROM " .$llLII11 ." WHERE `lang` != '" .$this->module->langData ."' LIMIT 1"; if ($this->module->db->getValue($sql)) {$aSQL[] =I13819 .$llLII11 .$this->lIl11L1; $aSQL[] ="OPTIMIZE TABLE " .$llLII11; }else {@set_time_limit($this->module->I11l1l1); $sql ="TRUNCATE TABLE " .$llLII11; $this->module->db->execute($sql, DBC_RAW_QUERY); }$aSQL[] =I13777 .$llLII11 ." SELECT * FROM  " .$llLIlII; $aSQL[] =I13771 .$llLII11 ." ENABLE KEYS"; }$aSQL[] =I13820; $tables =array_merge($llLILI1, array (I13775, 'currency', I13767, 'datasets', I13762, 'letters', 'ref_types', I13821, I13768, I13763, 'props')); foreach ($tables as $table) {$aSQL[] ="DROP TABLE IF EXISTS import_" .$this->llLIII1[I13817] .'_' .$table; }foreach ($aSQL as $sql) {@set_time_limit($this->module->I11l1l1); echo ' '; if (ob_get_level()) {ob_flush(); }$this->module->db->execute($sql, DBC_RAW_QUERY); }$ownerName =$this->module->module->GetOwnerName(); $oModule =&$this->module->cms->Core->GetModule($ownerName .I13822); $this->module->cms->Core->Cache->clearModCache($oModule); }}