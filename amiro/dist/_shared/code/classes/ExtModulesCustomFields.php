<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    modules 
 * @subpackage extensions 
 * @version    $Id$ 
 * @size       12424 xkqwlzykxpqiwztkxyrkzrqqmtslmslyppyrstnpuuwmnpxunltkulkwmrntliniksitpnir
 */ ?><?php foreach(array(5002=>'Qxt|IHSuJQD|WuDtHI|fMQJSD',5003=>'Qxt|IHS|Wf|IHSuJQ',5004=>'SZtZDQt|MS',5005=>'IHSuJQ',5006=>'qxtiHSuJQDwuDtHIFMQJSD|onS|Frn`GOG',5007=>'frHnt|JMDt|DEJ',5008=>'MnMt|YB|IHSuJQ|nZIQ',5009=>'MD|WZt|IHSuJQ',5010=>'qxtiHSuJQDwuDtHIFMQJSD|onS|zSI`GOG',5011=>'MnMt|fMJtQr',5012=>'WZtQPHrMQD',5013=>"?",5014=>'DMIGJQ',5015=>"dqjqwT?.MS.?FRhi?.WID|IHSuJQD|SZtZDQtD.?",5016=>"coqRq?.IHSuJQ|nZIQ.?=?'",5017=>'MS|WZt',5018=>".?coqRq?.MS.?=?",5019=>'MS|GZPQ',5020=>"'",5021=>"dqjqwT?.nZIQ.!?.fMQJSD|IZG.!?.fMQJSD|DOZrQS.!?.fMQJSD|WZGtMHnD.!?.GHDtfMx.?FRhi?.WID|IHSuJQD|SZtZDQtD.?coqRq?.MS.?=?",5022=>'fMQJSD|WZGtMHnD') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ExtModulesCustomFields extends CMS_ExtModule{ public $IL1Llll; public $aDataset =array(); public $aCrossHandlerData; public $IL1LllL =0; public $moduleName =''; public $isCatModule =false; public $IL1Lll1 =array(); private $_useSharedOnly =false; private $IL1LlLI =-1; private $IL1LlLl =true; public function __construct(){ parent::CMS_ExtModule(); }public function getModuleName(){ return I5002; }public function init(&$cms, &$IlIlIl1, &$IlIlILI){ parent::init($cms, $IlIlIl1, $IlIlILI); $this->moduleName =$this->activeModule->Name; if($IlIlIl1->issetProperty(I5003)){ $this->moduleName =$IlIlIl1->GetProperty(I5003); }$this->IL1LlLl =$this->cms->Side != 'admin'; $this->IL1Llll =CMS_API_ModulesCustomFields::getInstance(); $this->IL1Llll->init($this->cms, $this->db); if($this->IL1LlLl){ $this->IL1Lll1 =array( I5004 => 0, 'category_id' => 0, 'page_id' => 0, 'db_fields' => array(), 'common_db_fields' => array() );$this->aCrossHandlerData[$this->moduleName] =$this->IL1Lll1 +array(I5005 => $this->moduleName); require_once I5006; $this->addHandler(I5007, new ExtModulesCustomFields_Hnd_Frn_ModifySQL); $IL1LlLL =new ExtModulesCustomFields_Hnd_Frn_FillData; $this->addHandler('item_details_record', $IL1LlLL); $this->addHandler('fill_front_data', $IL1LlLL); $this->addHandler(I5008, new ExtModulesCustomFields_Hnd_Frn_InitByMod); $this->addHandler('createfilterfields', new ExtModulesCustomFields_Hnd_Frn_CreateFilterFields); $this->addHandler('process_front', new ExtModulesCustomFields_Hnd_Frn_ProcessAction); }else{ $this->aCrossHandlerData[I5009] =$this->IL1Llll->getParentForCatModule($this->moduleName) != $this->moduleName; require_once I5010; $this->addHandler(I5011, new ExtModulesCustomFields_Hnd_Adm_InitFilter); $this->addHandler('admin_list_sql', new ExtModulesCustomFields_Hnd_Adm_ModifySQL); $this->addHandler('fill_admin_data', new ExtModulesCustomFields_Hnd_Adm_FillData); $this->addHandler('fill_cat_admin_data', new ExtModulesCustomFields_Hnd_Adm_FillData); $this->addHandler('prepare_item_data', new ExtModulesCustomFields_Hnd_Adm_PrepareItemData); }}public function detectDatasetId($IL1LlL1 =false){ $mode =$this->IL1Llll->getModuleUsageMode($this->moduleName); if($this->IL1LlLl){ $datasetId =0; switch($mode){ case I5012: $catId =(int)$this->mod->catId; if($catId){ $this->aCrossHandlerData[$this->moduleName]['category_id'] =$catId; $oModule =$this->cms->Core->GetModule($this->moduleName .'_cat'); $sql ="SELECT `id_dataset` " ."FROM " .$oModule->GetTableName() .I5013 ."WHERE `id` = " .$catId; $datasetId =(int)$this->db->getValue($sql); }if(!$datasetId){ $this->_useSharedOnly =true; }break; case 'pages': $pageId =(int)$this->cms->GetPageId(); if($pageId >0){ $sql ="SELECT `id_dataset` FROM `cms_pages` WHERE `id` = " .$pageId; $datasetId =(int)$this->db->getValue($sql); if($datasetId){ $this->aCrossHandlerData[$this->moduleName]['page_id'] =$pageId; }}break; case I5014: $sql =I5015 .I5016. $this->moduleName ."' AND `used_simple` = 1 AND `lang` = '" .$this->mod->langData ."'"; $datasetId =(int)$this->db->getValue($sql); break; }}else{ static $datasetId =null; if(is_null($datasetId) || $IL1LlL1){ $datasetId =0; switch($mode){ case I5012: $catId =0; if(isset($this->cms->Vars['fcid'])){ $catId =$this->cms->Vars['fcid']; }elseif(isset($this->mod->IlIllI1) && isset($this->cms->VarsPost[$this->mod->IlIllI1->varName])){ $catId =$this->cms->VarsPost[$this->mod->IlIllI1->varName]; }else{ if(is_array($this->mod->itemData) && isset($this->mod->itemData[I5017])){ $catId =$this->mod->itemData[I5017]; }else if($this->mod->filter->issetField('flt_cat_id')){ $catId =$this->mod->filter->GetFieldValue('flt_cat_id'); }}$catId =(int)$catId; if($catId){ if(isset($this->mod->IL1Ll1I) && !empty($this->mod->IL1Ll1I)){ $IL1Ll1I =$this->mod->IL1Ll1I; }else{ $IL1Ll1I =$this->activeModule->GetTableName(). "_cat"; }$sql ="SELECT `id_dataset` FROM `" .$IL1Ll1I .I5018 .$catId; $datasetId =(int)$this->db->getValue($sql); }break; case 'pages': $pageId =0; if(isset($this->cms->Vars['pid'])){ $pageId =$this->cms->Vars['pid']; }else{ if(is_array($this->mod->itemData) && isset($this->mod->itemData['id_page'])){ $pageId =$this->mod->itemData[I5019]; }else if(isset($this->cms->VarsPost[I5019])){ $pageId =$this->cms->VarsPost[I5019]; }else if($this->mod->filter->issetField('flt_id_page')){ $pageId =$this->mod->filter->GetFieldValue('flt_id_page'); }}$pageId =(int)$pageId; $this->IL1LllL =$pageId; if($pageId >0){ $sql ="SELECT `id_dataset` FROM `cms_pages` WHERE `id` = " .$pageId; $datasetId =(int)$this->db->getValue($sql); }break; case I5014: $sql =I5015 .I5016. $this->moduleName ."' AND `used_simple` = 1 AND `lang` = '" .$this->mod->langData .I5020; $datasetId =(int)$this->db->getValue($sql); break; }}}if(!$datasetId) {$datasetId =$this->IL1Llll->getSysDatasetId($this->moduleName); }if($this->IL1LlLl){ $this->aCrossHandlerData[$this->moduleName][I5004] =$datasetId; }return $datasetId; }public function setDataset($datasetId =0){ $datasetId =(int)$datasetId; if(!$datasetId){ $datasetId =$this->detectDatasetId(); }if($this->IL1LlLI == $datasetId){ return true; }$sql =I5021 .$datasetId; $aDataset =$this->db->getRecord($sql); if(!$aDataset){ return false; }$this->IL1Llll->string2Array($aDataset['fields_map']); $this->IL1Llll->string2Array($aDataset['fields_shared']); $aDataset['fields_captions'] =unserialize($aDataset['fields_captions']); if(!$aDataset[I5022]){ $aDataset[I5022] =array(); }if($aDataset['fields_map']){ $this->IL1Llll->loadFieldsByIds($aDataset['fields_map'], $aDataset[I5022]); }$this->aDataset =$aDataset; $this->aCrossHandlerData[$this->moduleName]['dataset_postfix'] =$aDataset['postfix']; return true; }public function TITIIIT(){ return $this->_useSharedOnly; }}