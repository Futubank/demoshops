<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       20484 xkqwkxiikqiwunwglzsmswmglxsyppgqrupmnmlxkpqyltzkuuxxrmiysstutmiigquipnir
 */ ?><?php foreach(array(4382=>'zim~iHSuJQ~QDOHG|MtQI~YuMJSwHIGZrQjMnK',4383=>'QDOHG|WHIGZrQ',4384=>"MS",4385=>"",4386=>"DOHCsMDWHuntDVZJuQ",4387=>'|uDQwHIGZrMDHn',4388=>"DOHC|YZDQ|GrMWQ",4389=>"nuJJ",4390=>"QSMt",4391=>"W`GrMWQ:S",4392=>"GuYJMW",4393=>"|tIG|rQD",4394=>"YuB|JMnK",4395=>"GrMWQ|HrMPMnZJ",4396=>"tZx|tBGQ",4397=>"WurrQnWB",4398=>"MS|SMDWHunt",4399=>"MS|tZx|WJZDD",4400=>'qdohg|yUb|aqRh',4401=>"GrMWQ|nuJJ",4402=>"HrMPMnZJ",4403=>"GrMWQ",4404=>"?coqRq?M`MS?mN?}",4405=>"SY|WurrQnWB",4406=>'ZmtQI',4407=>"MtQIMS",4408=>"nZIQ",4409=>"DKu",4410=>"ZnnHunWQ",4411=>'MtQI|WZtnZIQ',4412=>"HtOQr|GrMWQD",4413=>"DuYJMnK",4414=>"vMQC|DuYJMnK",4415=>"SQDWr|QIGtB",4416=>'ZsZtZ',4417=>"'!'",4418=>'wjzddqd|gzTo',4419=>'|WHIGZrQ',4420=>'WHHKMQ|nZIQ',4421=>'|JMnK',4422=>'YHSB|MtQIs',4423=>'GrHGmS',4424=>'%ZSS|tH|WHIGZrMDHn') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} require_once $GLOBALS['CLASSES_PATH'] .'Eshop.php'; class EshopFront extends Eshop {public $buySpecPrices; public $showEmptyCaptions; public $zeroPriceIsBuy; public $nullPriceIsBuy; public $showBasePrice; public $showDiscountsValue; public $ILLllI1; public $_priceFieldsBuy; public $showDetailLink; public $ILLlllI; public $_useComparison; public $_comparisonBodyTypes; public $ILLllll; public $ILLlllL; public $ILLlll1; public $ILLllLI; public $ILLllLl; function EshopFront(&$cms, &$words) {parent::Eshop($cms, $words); if(AMI_Registry::get(I4382, TRUE)){ AMI_Registry::set(I4382, FALSE); if( $cms->Core->IsInstalled(I4383) && $cms->Core->GetModule(I4383)->IsPresentInPMandPublic() ){$cms->Gui->addGlobalVars(array( 'ESHOP_COMPARE_LINK' => $cms->Core->GetModule(I4383)->GetFrontLink() ));}}}function TT1l1ll($ILl1IlI) {parent::TT1l1ll($ILl1IlI); if($this->cms->Core->issetModOption("srv_multi_sites", "id")) {$this->idSite =intval($this->cms->Core->GetModOption("srv_multi_sites", I4384)); }$this->ILLllll ="price_original"; $this->ILLlllL ="price_difference"; $this->ILLlll1 ="_null"; $this->ILLllLI =false; $this->ILLllI1 =true; $this->ILLllLl =($this->getCommonModuleName("_cart") != I4385 && $this->getCommonModuleName("_order") != I4385); $this->TITTITT(); }function TT1l11I($ownerName) {parent::TT1l11I($ownerName); $II1LIll =Array("buySpecPrices", "showEmptyCaptions", "showBasePrice", I4386, "showDetailLink", "zeroPriceIsBuy", "nullPriceIsBuy", "_priceFieldsBuy", I4387, '_comparisonBodyTypes'); if(!$this->TT1l11T("front_options", $II1LIll)) {$this->buySpecPrices =$this->mEshop->GetOption("buy_spec_prices"); $this->showEmptyCaptions =$this->mEshop->GetOption("show_empty_captions"); $this->showBasePrice =$this->mEshop->GetOption(I4388); $this->showDiscountsValue =$this->mEshop->GetOption("show_discounts_value"); $this->showDetailLink =$this->mEshop->GetOption("show_detail_link"); $this->zeroPriceIsBuy =false; $this->nullPriceIsBuy =false; if($this->buySpecPrices == "both") {$this->zeroPriceIsBuy =true; $this->nullPriceIsBuy =true; }elseif($this->buySpecPrices == "zero") {$this->zeroPriceIsBuy =true; }elseif($this->buySpecPrices == I4389) {$this->nullPriceIsBuy =true; }$this->_priceFieldsBuy =$this->TT11TI1("price_buy"); $moduleName =$ownerName .'_compare'; $this->_useComparison =$this->cms->Core->IsInstalled($moduleName) && $this->cms->Core->IsPresentInPMandPublic($moduleName); $this->_comparisonBodyTypes =$this->_useComparison ?$this->cms->Core->TTlI1TI($moduleName, 'body_types') :array ();$this->TT1l1l1("front_options", $II1LIll); }}function TT11TTT() {parent::TT11TTT(); $this->tree->TI11IIT(I4390, "c.name, c.announce, c.description, c.sm_data, c.details_noindex, c.sublink, c.instruction, ". "IF(c.instruct > 0,'checked','') AS instruct, IF(c.public > 0,'checked','') as public, ". "c.price".$this->getPriceFields("c.price_caption%d").$this->getPriceFields(I4391). ", c.price, price_mask, IF(c.is_price_list > 0,'checked','') AS price_list_checked, c.*" );$this->tree->TI11IIT("counters_info", "c.public AS cat_public, c2.public AS cat_parent_public, c.count_childs, c.count_public_childs"); $this->tree->TI11IIT("public", I4392); $this->tree->TI11IIT("path", "name, sublink"); $this->tree->addFilter(I4392, "c.public='1'"); }function TITTT11() {$this->ILLllLI =true; }function TITTITT() {$this->ILLllLI =(false || !$this->ILLllLl); }function isBuyPrice($priceNum) {return isset($this->_priceFieldsBuy[$priceNum]); }function TITTITI(&$vData, &$Il111lI, $ILLllLL, $ILLllL1, $ILLllII ="base_price") {$vData[I4393] =I4385; if($this->showBasePrice) {$vData["buy_link"] =$this->cms->Member->Cart->GetBuyNowLink(); $this->TITTIT1(0, $vData, $Il111lI, $ILLllLL, $ILLllL1, $ILLllII); }$res =$vData[I4393]; unset($vData[I4393]); return $res; }function TITTITl(&$vData, &$Il111lI, $ILLllLL, $ILLllL1, $ILLllII ="other_prices") {$vData[I4393] =I4385; $res =I4385; for($i=0; $i<$this->numPrices; $i++) {$numPrice =$this->priceFields[$i]; if($this->showEmptyCaptions || $Il111lI["price_caption".$numPrice] != I4385) {$vData["url_buy"] =$vData[I4394] =$this->cms->Member->Cart->GetBuyNowLink(); $vData["price_caption"] =$Il111lI["price_caption".$numPrice]; $this->TITTIT1($numPrice, $vData, $Il111lI, $ILLllLL, $ILLllL1, $ILLllII); }}$res =$vData[I4393]; if($vData[I4393] != I4385) {$vData["other_price_list"] =$vData[I4393]; $res =$this->cms->TTITI1l($ILLllL1, $ILLllII."_list", $vData); }unset($vData[I4393]); return $res; }function TITTIT1($numPrice, &$vData, &$Il111lI, $ILLllLL, $ILLllL1, $ILLllII) {unset($vData[I4395]); unset($vData["price_difference"]); $vData["num_prices"] =$numPrice; $aPrice =$this->calcPrice( $Il111lI["price".$numPrice], $numPrice, $Il111lI["tax"], $Il111lI[I4396], $Il111lI["charge_tax_type"], $Il111lI["discount"], $Il111lI["discount_type"], $numPrice == 0 ?'' :$Il111lI[I4397.$numPrice], $numPrice == 0 ?'' :$Il111lI["db_currency".$numPrice], $this->ILLllI1, array ("id_discount" => isset($Il111lI["id_discount"]) ?$Il111lI[I4398] :0 ),array( "tax_class_type" => isset($vData['tax_class_type']) ?$vData['tax_class_type'] :'', I4399 => isset($vData['id_tax_class']) ?$vData['id_tax_class'] :0, ));$ILLll1I =true; if((($this->zeroPriceIsBuy && $aPrice["price_zero"]) || ($this->isBuyPrice($numPrice) && !$aPrice["price_zero"])) && !$this->ILLllLI) {$this->cms->Gui->AddGlobalVars(Array(I4400 => '1')); }else {$this->cms->Gui->AddGlobalVars(Array(I4400 => '')); $ILLll1I =false; }$this->cms->Gui->AddGlobalVars(Array('ESHOP_BUY_NULL' => '')); if((($this->nullPriceIsBuy && $aPrice[I4401]) || ($this->isBuyPrice($numPrice) && !$aPrice[I4401])) && !$this->ILLllLI) {if($ILLll1I) {$this->cms->Gui->AddGlobalVars(Array('ESHOP_BUY_NULL' => '1')); }}else {$this->cms->Gui->AddGlobalVars(Array(I4400 => '')); }if(isset($aPrice["original"])) {$vData[I4395] =$this->cms->TTITI1l($ILLllLL, $this->ILLllll, $aPrice[I4402]); if($this->showDiscountsValue) {$vData["price_difference"] =$this->cms->TTITI1l($ILLllLL, $this->ILLlllL, $aPrice); }}$ILLll1l =$aPrice[I4401] ?$this->ILLlll1 :I4385; if(isset($vData["item_type"]) && $vData["item_type"] == "eshop_account" && $numPrice == 0 && $aPrice[I4403] === I4385){ $ILLll1l ="_variable"; }if(!empty($vData['id_source'])){ $vData['itemid'] =$vData['id_source']; }$vData[I4403] =$this->cms->TTITI1l($ILLllLL, I4403.$ILLll1l, $aPrice[I4403]); $this->TITTII1($vData, $this->cms->SetsTemplate); $vData[I4393] .= $this->cms->TTITI1l($ILLllL1, $ILLllII.$ILLll1l, $vData); }function TITTIIT(&$itemsArray) {$priceInfo =Array(); $countItems =sizeof($itemsArray) -1; $itemIds =Array(); for($index=0; $index <$countItems; $index++) {$itemIds[] =$itemsArray[$index][I4384]; }$sql ="SELECT i.id AS id_product, c.id AS id_category". $this->getPriceFields("c.price_caption%d, SUBSTRING(c.price%d, INSTR(c.price%d, '#')+1, 3) AS currency%d, SUBSTRING(c.price%d, INSTR(c.price%d, ':')+1, 3) AS db_currency%d"). " FROM ".$this->dbTablePrefix."_items i INNER JOIN ".$this->dbTablePrefix."_cats c ON i.id_category=c.id". I4404.implode(",", $itemIds).")"; $this->db->query($sql); while($this->db->next_record()) {$aCaptions =Array(); $aCurrency =Array(); $ILLll1L =Array(); for($i=0;$i<$this->numPrices;$i++) {$numPrice =$this->priceFields[$i]; $aCaptions[$numPrice] =$this->db->Record["price_caption".$numPrice]; $aCurrency[$numPrice] =$this->db->Record[I4397.$numPrice]; $ILLll1L[$numPrice] =isset($this->db->Record["db_currency".$numPrice]) ?$this->db->Record[I4405.$numPrice] :$this->baseCurrency; }$priceInfo["captions"][$this->db->Record["id_product"]] =$aCaptions; $priceInfo[I4397][$this->db->Record["id_product"]] =$aCurrency; $priceInfo[I4405][$this->db->Record["id_product"]] =$ILLll1L; }return $priceInfo; }function getItemCB(&$aItem, &$aData) {$aEvent =array( I4406 => &$aItem, 'aData' => &$aData );AMI_Event::fire('v5_on_before_get_eshop_front_item', $aEvent, AMI_Event::MOD_ANY); unset($aEvent); if(is_array($this->ILlL1l1["item_list"])){ extract($this->ILlL1l1["item_list"]); }$ILLll11 =$vNavData =Array(); $aItem[I4407] =$aItem[I4384]; $aItem =array_merge($aItem, $vNavData); $aItem["add_params"] =$addParams; $aItem["name"] =$this->cms->TTITI1l("item", "name", $aItem[I4408]); $aItem["fdate"] =$this->cms->TTITI1l("item", "fdate", $aItem["fdate"]); $aItem[I4409] =$this->cms->TTITI1l("item", I4409, $aItem[I4409]); $aItem["announce"] =$this->cms->TTITI1l("item", "announce", $aItem[I4410]); $aItem["description"] =$this->cms->TTITI1l("item", "description", $aItem["description"]); $aItem[I4411] =isset($aData[I4411]) ?$aData[I4411] :''; $aItem["base_price"] =$this->TITTITI($aItem, $aItem, "item", "item"); $aItem[I4412] =$this->TITTITl($aItem, $aItem, "item", "item", "other_price"); $vNavData[I4384] =$aItem[I4384]; $vNavData["id_sublink"] =$aItem[I4413]; if(isset($aItem["viewid"])) {$vNavData["viewid"] =$aItem["viewid"]; $vNavData["viewid_sublink"] =$aItem[I4414]; }else {$vNavData["catid"] =$aItem["catid"]; $vNavData["catid_sublink"] =$aItem["catid_sublink"]; }$vNavData =$this->cms->ApplyNav($vNavData); $aItem =array_merge($aItem, $vNavData); if($this->showDetailLink || !$aItem[I4415]) {$aItem[I4408] =$this->cms->TTITI1l("item", "name_link", $aItem); }$this->TT1111T($this->ILlL1l1["item_list"]["CurPageType"], $aItem, $aItem); $aEvent =array( I4406 => &$aItem, I4416 => &$aData );AMI_Event::fire('v5_on_after_get_eshop_front_item', $aEvent, AMI_Event::MOD_ANY); unset($aEvent); }function TITTIII($tableAlias) {$res =I4385; if(!empty($tableAlias)) {$tableAlias .= "."; }if(sizeof($this->aAllowExtMods) >0) {$res =" AND ".$tableAlias."item_type IN('".implode(I4417, $this->aAllowExtMods)."')"; }return $res; }function TT1111T($pageType, &$aItem, &$aData) {for($i=0; $i <$this->numItemTypes; $i++) {$this->_oExtensions[$i]->TT11lll($pageType, $aItem, $aData); }}function TITTIIl(&$aData, $templateName) {global $oSession; $aData['compare_script'] =$aData['compare_script_bottom'] =''; if (!$this->_useComparison) {return; }require_once $GLOBALS[I4418] .'EshopCompareSet.php'; require_once $GLOBALS[I4418] .'EshopCompareSetItem.php'; if ($oSession->IssetVar('compare')) {$ILLlLII =$oSession->GetVar('compare'); }else {$ILLlLII =new EshopCompareSet(); }$ILLlLII->owner =$this->ownerName; $ILLlLII->cms =&$this->cms; $ILLlLII->init(); $products =$ILLlLII->getItems(); $moduleName =$this->ownerName .I4419; $keys =array ();foreach ($products as $product) {$keys[] =$product->getKey() .'-' .$product->data['dataset_id']; }$aData['compare_script'] =$this->cms->Gui->getAbs($templateName .':compare_script', array (I4420 => 'cms_compare', 'max_qty' => $this->cms->Core->GetModOption($moduleName, 'items_to_compare'), 'dis_diff_datasets' => $this->cms->Core->GetModOption($moduleName, 'allow_different_datasets') ?'false' :'true' ));$module =&$this->cms->Core->GetModule($moduleName); $aData['compare_script_bottom'] =$this->cms->Gui->getAbs($templateName .':compare_script_bottom', array (I4421 => $module->GetFrontLink() ));}function TITTII1(&$aItem, $templateName, $propId =0) {$aItem['add_to_comparison'] =''; if ($this->_useComparison && !isset($aItem[I4400]) && in_array($this->ILLlllI, $this->_comparisonBodyTypes) && !isset($aItem['property_data']) ){$aItem['_ch'] =$this->ILLlllI != I4422 || !empty($aItem['propId']); $aItem['_key'] =$aItem['id'] .'-' .(isset($aItem[I4423]) ?$aItem[I4423] :$propId) .'-' .$aItem['dataset_id']; $aItem['_body_type'] =$this->ILLlllI; $aItem['add_to_comparison'] =$this->cms->Gui->get($templateName .I4424, $aItem); unset($aItem['_ch'], $aItem['_key'], $aItem['_body_type']); }}}