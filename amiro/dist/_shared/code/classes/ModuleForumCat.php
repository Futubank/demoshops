<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       5194 xkqwspiukxgwpklxwrymlrnnttsymtgnqqywwxtxmwxugwwtuyupzizkzpmnlliqrzpmpnir
 */ ?><?php foreach(array(9712=>'MS|GZPQ|IHSuJQ|nZIQ',9713=>'fHruI',9714=>'IQIYQrD|JMnK',9715=>'JQP|YHJS',9716=>"'{?.IDP|SZtQ.?",9717=>'JMDt|SZtZ',9718=>'',9719=>'HYLQWt',9720=>'MD|DQGZrZtHr',9721=>'YHSB',9722=>'=_NUjj') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ModuleForumCat extends CMS_CategoriesModule {public $lIl1L11; function _Init($IIll1l1 =array (),$IIll1LI ='', $IIll1Ll ='', $aOptions =array ()){$IIIIL11 =array (I9712 => I9713, 'use_id_page' => false, 'use_options_form' => true, 'default_prefix' => 'c', 'description_field_name' => 'body', 'picture_cat' => I9713, 'use_positions' => true );$aOptions += $IIIIL11; parent::_Init($IIll1l1, $IIll1LI, $IIll1Ll, $aOptions); }function _InitAdmin() {parent::_InitAdmin(); $vMod =&$this->cms->Core->GetModule('members'); $this->cms->Gui->AddGlobalVars(array (I9714 => $vMod->GetAdminLink())); $this->lIl1L11 =&$this->cms->Core->GetModule(I9713); $this->cms->Gui->AddGlobalVars(array ('forum_link' => $this->lIl1L11->GetAdminLink(), 'NUM_ITEMS_COL' => false ));$this->lIl1L11->InitEngine($this->cms, $this->db); $this->lIl1L11->Engine->Init(array ('forum_list' =>'templates/forum_list.tpl'), 'templates/lang/_forum_msgs.lng', 'templates/lang/forum.lng'); $this->cms->Gui->removeGlobalVars('USE_DETAILS_NOINDEX'); }function TTT11Tl(&$IILILII) {if ($this->side == 'admin' && ($index =array_search('notpublished', $IILILII))) {array_splice($IILILII, $index +1, 0, array (I9715)); }}function TTTlI11(&$vData, &$aCustom) {$prefix =$this->options['default_prefix']; $aCustom['cat_sql'] =", " .$prefix ."is_separator, " .$prefix ."`num_public_topics` `num_items`, " .$prefix ."`msg_id`, " .$prefix ."`msg_id_thread`, " .$prefix ."`msg_topic`, " .$prefix ."`msg_id_member`, " .$prefix ."`msg_author`, DATE_FORMAT(" .$prefix ."`msg_date`, '" .str_replace(':%s', '', $this->cms->DFMT['db_dtime']) .I9716; $vData['is_separator'] =(sizeof($this->itemData) >0) && $this->itemData['is_separator'] ?' checked' :''; $aCustom[I9717]['custom_cat_form_fields'] =$this->cms->Gui->get($this->moduleName .'_subform:custom_cat_form_fields', $vData); $aCustom[I9717]['list_custom_fields'] =$this->cms->Gui->getAbs($this->moduleName .'_list:list_custom_fields_header', I9718); $aCustom['fields']['id'] =Array('action' => 'callback', I9719 => &$this, 'method' => '_adminListRowCB'); parent::TTTlI11($vData, $aCustom); }function _adminListRowCB(&$aItem, &$aData) {$this->lIl1L11->Engine->TTIl11l($aItem); $aItem['list_custom_fields'] =$this->cms->Gui->get($this->moduleName .'_list:list_custom_fields_row' .($aItem[I9720] ?'_separator' :I9718), $aItem); if ($aItem[I9720]) {$aItem['style'] .= '_b'; }}function TTT1IlI($aSql =array (),$cId =0, $fields =array('announce', I9721)) {$aSql[I9720] =intval(!empty($this->cms->VarsPost[I9720])); if ($aSql[I9720]) {if ($this->options['use_special_list_view']) {$aSql += array ('public_direct_link' => 0, 'urgent' => 0, 'urgent_date' => I9722 );}$aSavedOptions =$this->options; $this->options =array_merge($this->options, array ('use_options_form' => false, 'use_special_list_view' => false ));}$aSql =parent::TTT1IlI($aSql, $cId, $fields); if (isset($aSavedOptions)) {$this->options =$aSavedOptions; }return $aSql; }function TTT1Tl1($cType, $cModule, $condition =I9718){ $this->lIl1L11->Engine->ProcessAction('repair', 0); }}