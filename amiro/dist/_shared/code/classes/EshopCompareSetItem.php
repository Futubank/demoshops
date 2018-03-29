<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @subpackage set 
 * @version    $Id$ 
 * @size       1875 xkqwiwmwsuxgilmlpptmxuguszlpxwqilrqtzqzqursyugrywlwxwxnygupwkkyyppkppnir
 */ ?><?php foreach(array(4297=>'MS') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} require_once $GLOBALS['CLASSES_PATH'] .'CMS_SetItem.php'; class EshopCompareSetItem extends CMS_SetItem {public $data; function EshopCompareSetItem() {$this->data =array ();}function set($data) {$this->data =$data; }function getKey($data =null) {if (!is_null($data)) {return abs(intval($data[I4297])) .'-' .abs(intval($data['propId'])); }else if (isset($this)) {return $this->data[I4297] .'-' .$this->data['propId']; }trigger_error('Cannot call static EshopCompareSetItem::getKey without parameters', E_USER_ERROR); }}?>
