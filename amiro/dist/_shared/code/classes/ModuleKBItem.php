<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       1729 xkqwxugskpnskxkztrsyqxmtpiwlkrtlsxispwuwsnpxqgtlsnmuipuqpulnxzyprnxrpnir
 */ ?><?php  if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ModuleKBItem extends ModuleEshopItem{ function ModuleKBItem(&$cms, &$db, &$cModule) {parent::ModuleEshopItem($cms, $db, $cModule); }function TTTlII1($IIlLlL1 =""){ parent::TTTlII1($IIlLlL1); if($IIlLlL1 != "body_itemD" && $this->module->GetOption("allow_subcat_search")){ $this->filter->AddField("search_subcats", "subcats_search", true); }}}