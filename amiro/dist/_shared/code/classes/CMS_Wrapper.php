<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       4494 xkqwtumzpyskipkklkurkymiktwwrlztuigutrppmmylnuqnquyurwzkxyrplsptpnqypnir
 */ ?><?php foreach(array(2550=>"M`nZIQ",2551=>'ZWtMHn',2552=>"DtZtD",2553=>"HM",2554=>"HM_M",2555=>"jqFT?hUTqR",2556=>'DtrMGJMnQ',2557=>"rQGHrt|YuB|",2558=>"WHSQ",2559=>"MtQI|GrMWQ",2560=>"MS|IQIYQr") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class CMS_Wrapper extends ModuleEshopOrder {public $aUsers; function CMS_Wrapper(&$cms, &$db, &$cModule) {$this->aUsers =Array(); parent::ModuleEshopOrder($cms, $db, $cModule); }function _InitAdmin() {$vMod =&$this->cms->Core->GetModule("eshop_item"); $vMod->PushPager($this->browser); $vMod->InitPager($this->browser); $this->fieldsMap =array_merge($this->fieldsMap, Array("item_name" => I2550)); $vMod->PopPager($this->browser); parent::_InitAdmin(); }function TTTlI11(&$vData, &$aCustom) {switch ($this->IlL1LLl["type"]) {case "details": $aCustom["fields"] += Array( 'item_amount'=>Array(I2551=>'callback', 'object'=>&$this, 'method'=>'_OrderItemRow'), );case I2552: $aCustom += Array( "sql_fileds" => ", oi.*, oi.price as purchase_price, oi.ext_data as item_ext_data, ". "m.id as id_member, i.name as item_name, i.sku ", "tables" => Array(I2553 => "cms_es_order_items", "i" => "cms_es_items"), "joins" => Array(I2554 => "i.id=oi.id_product", "i|o" => "oi.id_order=o.id"), "joins_types" => Array(I2554 => I2555, "i|o" => I2555), );if($this->action != "print") {$aCustom["fields"] += Array( 'item_name' => Array(I2551=>I2556, 'size'=>100), );}break; }$Il11lIl =$this->cms->Core->TTlI1TI($this->oEshop->ownerName."_item", "price_buy"); $Il11lIL =Array("report_buy_prices" => count($Il11lIl)); foreach($Il11lIl as $key => $Il11lI1) {$Il11lIL[I2557.$Il11lI1] =1; }$this->cms->Gui->addGlobalVars($Il11lIL); $this->browser->TI1TITl($cSQLFields); parent::TTTlI11($vData, $aCustom); }function _OrderItemRow(&$aItem, &$aData) {$Il11llI =unserialize($aItem["ext_data"]); $Il11lll =unserialize($aItem["item_ext_data"]); $this->oEshop->setCurrencyData($Il11llI["currency"], $Il11llI["base_currency"][I2558]); $priceTotal =$this->oEshop->convertCurrency($aItem["purchase_price"], $Il11llI["buy_currency"][I2558], $this->defaultCurrency); $aItem["item_price"] =$this->oEshop->formatNumber($priceTotal, true, true); $aItem["item_price_money"] =$this->oEshop->formatMoney($aItem[I2559], $this->defaultCurrency); $aItem["item_amount"] =$this->oEshop->formatNumber($aItem[I2559] *$aItem["qty"], true, true); $aItem["item_amount_money"] =$this->oEshop->formatMoney($aItem["item_amount"], $this->defaultCurrency); if(!array_key_exists($aItem[I2560], $this->aUsers)) {$sql ="SELECT *, id_external as member_id_external FROM cms_members m LEFT JOIN cms_es_users eu ON eu.id_member=m.id WHERE id_member='".$aItem[I2560]."'"; $this->db->query($sql); $this->db->next_record(); $this->aUsers[$aItem[I2560]] =$this->db->Record; $aCustomData =unserialize($this->db->Record["custom_data"]); if (is_array($aCustomData)) {$this->aUsers[$aItem[I2560]] += $aCustomData; }}if(is_array($this->aUsers[$aItem[I2560]])) {$aItem += $this->aUsers[$aItem[I2560]]; }}}?>