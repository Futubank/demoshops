<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       16560 xkqwkymspxyipyuqtnqstxtkmzwmzkpzizpmnkxikslxlryzzsllkpwxlnrgiignkwskpnir
 */ ?><?php foreach(array(413=>"QvQn",414=>"rHC4",415=>"|nuI|rHCD",416=>"PrHuGMnP",417=>"DMIGJQ",418=>"dqjqwTqs|mTqi",419=>'YrHCDQr|rHC|1',420=>'YrHCDQr|rHC',421=>'GZPQ~WZtmS',422=>'MS|HCnQr',423=>'truQ',424=>'OQZSQr',425=>'JMDt',426=>'YHSB|DIZJJ',427=>'JQPQnS',428=>"GZPQ",429=>"WZJW",430=>"WZJW|HGtMHnD",431=>"|",432=>"%rHC|",433=>"JMDt",434=>"DuI",435=>'DtrMGJMnQ',436=>'Hff',437=>"tGJ|GHDtfMx",438=>'ZWtMHnD',439=>'PQt|CHrS',440=>'WZJJYZWK',441=>'HYLQWt',442=>'GZrZID') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class Browser extends Pager{ public $style; public $III1I1L; function Browser(&$oCms){ $this->style =Array( "simple"=>"row1", I413=>"row2", "edited"=>"row3", "last_edited"=>I414, );return parent::Pager($oCms); }function GetList(&$db, $cFields, $cMainSet, $cTableSet, $cRowSet, $cEmptySet, $cLid, $cAppliedId, $cLegend, $cData =Array(), $numCols =1, &$III1I11 =null){ if(is_array($cData)){ $aData =$cData; }else{ $aData =Array(); }$aData += Array('offset_link' => "javascript:go_page('[START]', 'offset');", 'list'=>''); if(empty($numCols)){ $numCols =1; }$numCols *= 2; $aData[I415] =$db->num_rows(); $aData["_total_rows"] =$this->MaxCount; $numRows =$aData[I415]; if($numRows >0){ $i =0; if(!is_array($cFields)) {$cFields =Array(); }$III1lII =array(); while($db->next_record()){ $III1lII[] =$db->Record; }$aData["_page_is_last"] =($this->getPagesCount() == ($this->getActivePage() +1)); $aSkipRowNums =Array(); $numSkippedRows =0; if($this->mode == "tape"){ if($this->TapePosition >0){ $numLeftTapeItems =$this->TapePosition -1; $numRightTapeItems =$this->PageSize -$this->TapePosition; $numSkippedRows =min($numRightTapeItems, $this->MaxCount -$this->Position -1, $this->Position -$numLeftTapeItems, $this->MaxCount -$this->PageSize); $numSkippedRows =max(0, $numSkippedRows); $numRows =$this->PageSize +$numSkippedRows; }else{ $III1lIl =0; if($this->Position >($this->PageSize -1) && $this->Position != ($this->MaxCount )){$aSkipRowNums[] =0; }if($numRows >$this->PageSize) {$aSkipRowNums[] =$this->PageSize; }}}if(sizeof($aSkipRowNums) >0){ reset($aSkipRowNums); $skipRowNum =current($aSkipRowNums); }else {$skipRowNum =-1; }if(!empty($this->SQLData["grouping"])){ $aGrouping =array_keys(array_reverse($this->SQLData[I416])); $III1lIL =$this->SQLData["calculating"]; }$III1lI1 =$this->cms->Gui->issetSet($cMainSet.$cRowSet."_1"); for($rowIndex =$numSkippedRows; $rowIndex <$numRows; $rowIndex++){ $aItem =$III1lII[$rowIndex]; $aItem['row_index'] =$i; $aItem['abs_row_index'] =$i +$this->Position; $style =$this->style[I417]; if($i %$numCols){ $style =$this->style[I413]; }if($aItem['id'] == $cAppliedId){ $style =$this->style["last_edited"]; }if($aItem['id'] == $cLid) {$style =$this->style["edited"]; $aItem[I418] ="1"; $this->currentItemOffset =$i; }else {$aItem[I418] ="0"; }$aItem["style"] =$style; $this->ProcessFields($cFields, $aItem, $aData); if($i == $skipRowNum){ if(next($aSkipRowNums)){ $skipRowNum =current($aSkipRowNums); }else{ $skipRowNum =-1; }}else{ $i++; $aData['browser_row'] =$this->cms->Gui->get($cMainSet.$cRowSet, $aItem); if($III1lI1){ $aData[I419] =$this->cms->Gui->get($cMainSet.$cRowSet."_1", $aItem); }if(isset($aGrouping)) {$III1llI =Array(); $III1lll =false; foreach(array_reverse($aGrouping) as $III1llL) {$III1lll =$III1lll || ($III1lIL[$III1llL]["current_value"] !== $aItem[$III1llL] && $III1llL !== ""); $III1llI[$III1llL] =$III1lll; if($III1lll) {$III1lIL[$III1llL]["current_value"] =$aItem[$III1llL]; }}$III1ll1 =false; foreach($aGrouping as $III1llL) {$this->TTTIIT1($III1lIL[$III1llL], $III1llL, $aData[I420], $aItem, ($rowIndex >$numSkippedRows) && $III1llI[$III1llL], $III1ll1, $cMainSet); $III1ll1 =true; }}if(is_array($III1I11)){ $III1I11[] =$aItem; }$icons =''; if(AMI::editModeEnabled() && !AMI_Registry::get('ami_specblock_mode', false)){ $modId =AMI_Registry::get('page/modId', ''); $categoryId =AMI_Registry::get(I421, 0); $itemId =AMI_Registry::get('page/itemId', 0); if($modId == 'eshop_item'){ $isCat =!isset($aItem['sku']); }else{ $isCat =FALSE; }if(($modId == 'eshop_item') && AMI::checkAccessRights($modId, $aItem[I422], array('edit'))){ $aIconsData =array( 'id' => $aItem['id'], 'isCat' => $isCat ?I423 :'false', 'modId' => $modId, 'header' => AMI_Lib_String::htmlChars(isset($aItem['header']) ?$aItem[I424] :$aItem['name']) );$this->cms->Gui->addBlock('list_icons', AMI_Skin::getPath('templates/list_icons.tpl')); $icons =$this->cms->Gui->get('list_icons:icons', $aIconsData); }}$aData[I425] .= ($icons .$aData[I420]); if($III1lI1) {$aData['list_1'] .= $aData[I419]; }}}if(isset($aGrouping)) {foreach($aGrouping as $III1llL){ $this->TTTIIT1($III1lIL[$III1llL], $III1llL, $aData[I420], $aItem, 1, true, $cMainSet); }$aData[I425] =$aData[I420]; }$aData['pager'] =empty($aData['page_item_type']) || $aData['page_item_type'] != I426 ?$this->GetPagerHtml($this->GetPager(), $aData['offset_link']) :''; $aData['legend'] =''; if(is_array($cLegend)){ foreach($cLegend as $setName){ $aData[I427] .= $this->cms->Gui->getAbs($cMainSet.':'.$setName, ''); }}$aData['list_table'] =$this->cms->Gui->get($cMainSet.$cTableSet, $aData); unset($aData[I425]); }else{ if(!empty($this->III1I1L)){ unset($this->III1I1L); $aData['list_table'] =$this->cms->Gui->get($cMainSet.$cTableSet, $aData); $this->mode =I428; unset($aData[I425]); return $aData; }$listData =$this->cms->Gui->getAbs($cMainSet.$cEmptySet, $aData); $aData += Array("list"=>$listData); if(isset($aData["_force_show_main"]) && $aData["_force_show_main"]) {$listData =$this->cms->Gui->get($cMainSet.$cTableSet, $aData); }$aData['list_table'] =$listData; }$this->mode =I428; return $aData; }function TTTIIT1(&$III1lLI, $III1lLl, &$III1lLL, &$aItem, $III1lL1, $III1l1I, $cMainSet) {if($III1lL1) {$III1l1l =Array(); if(is_array($III1lLI[I429])) {foreach($III1lLI[I429] as $field => $aMethod) {foreach($aMethod as $method => $val) {if($method == "avg") {$val /= $aMethod["__count"]; }$III1l1l[$III1lLl."_".$field."_".$method] =number_format($val, $this->SQLData[I430]["decimal_digits"], $this->SQLData[I430]["decimal"], $this->SQLData[I430]["thousand"]); $III1l1l[$III1lLl."_".$field.I431.$method."_plain"] =$val; $III1lLI[I429][$field][$method] =$aItem[$field]; }$III1lLI[I429][$field]["__count"] =1; }}if($III1l1I) {$tmp =""; $III1lLI["list"] .= $III1lLL; }else {$tmp =$III1lLL; }$setName =$cMainSet.I432.$III1lLl; if($this->cms->Gui->issetSet($setName)) {$III1lLL =$this->cms->Gui->getAbs($setName, Array("list" => $III1lLI["list"]) +$III1l1l +$III1lLI["item"]); }else {$III1lLL =$III1lLI["list"]; }$III1lLI[I433] =$tmp; }else {$III1lLI[I433] .= $III1lLL; $III1lLL =""; if(is_array($III1lLI[I429])) {foreach($III1lLI[I429] as $field => $aMethod) {$III1lLI[I429][$field]["__count"]++; foreach($aMethod as $method => $val) {if($III1lLI[I429][$field]["__count"] == 1) {$III1lLI[I429][$field][$method] =$aItem[$field]; }else {switch($method) {case "avg": case I434: $III1lLI[I429][$field][$method] += $aItem[$field]; break; case "max": $III1lLI[I429][$field][$method] =max($III1lLI[I429][$field][$method], $aItem[$field]); break; case "min": $III1lLI[I429][$field][$method] =min($III1lLI[I429][$field][$method], $aItem[$field]); break; }}}}}}$III1lLI["item"] =$aItem; }function ProcessFields(&$cFields, &$aItem, &$aData) {foreach($cFields as $name => $aRule) {if(!is_array($aRule)){ continue; }if(!isset($aItem[$name])){ $aItem[$name] =null; }switch($aRule['action']) {case I435: $aItem[$name] =$this->cms->stripLine($aItem[$name], $aRule['size']); break; case 'flagicon': $tplName =!isset($aItem[$name]) || $aItem[$name] == $aRule['value'] ?$aRule['on']: $aRule[I436]; if(isset($aRule["rights"]) && is_array($aRule["rights"])) {foreach($aRule["rights"] as $right => $III1l1L) {$aItem["_sys_right_".$right] =1; if((1 +intval($III1l1L["modify_on_permission"]) -intval($aItem["_sys_right_".$right])) != 0) {$tplName =str_replace(":", ":".$III1l1L["tpl_prefix"], $tplName).$III1l1L[I437]; }}}if(isset($aRule['id'])){ $aItem[$aRule['id']] =$aItem['id']; }$aItem[$name] =$this->cms->Gui->get($tplName, $aItem); break; case 'strip_tags': $aItem[$name] =strip_tags($aItem[$name]); break; case I438: foreach($aRule['id'] as $idName) {$aItem[$idName] =$aItem['id']; }case 'get_set': $aItem[$name] =$this->cms->Gui->get($aRule['set'], $aItem); break; case I439: $aItem[$name] =isset($aRule["words"][$aItem[$name]]) ?$aRule["words"][$aItem[$name]] :$aRule["words"][$aRule["default_word"]]; break; case I440: $method =$aRule['method']; if (is_object($aRule['object'])) {if (method_exists($aRule['object'], $method)) {$aRule['object']->{$method}($aItem, $aData); }else {trigger_error(get_class($aRule[I441])."::{$method} doesn't exist",E_USER_ERROR); }}else {if (function_exists($method)) {$method($aItem, $aData); }else {trigger_error("Function {$method} doesn't exist",E_USER_ERROR); }}break; case 'acallback': foreach($aRule['callbacks'] as $cb) {if(isset($cb['params'])) {$cb[I441]->{$cb['method']}($aItem, $aData, $cb[I442]); }else {$cb[I441]->{$cb['method']}($aItem, $aData); }}break; }}}function GetPagerHtml($III1l11, $cLinkHtml =''){ return empty($this->cms->Gui->PrintVersion) ?parent::GetPagerHtml($III1l11, $cLinkHtml) :''; }}