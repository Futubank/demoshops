<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       3769 xkqwmtisrqustprzlgzwqwswnlqypyxlwrspmuzywzglmpyrtmwuqnnmszsmyxgyztnwpnir
 */ ?><?php foreach(array(5214=>"",5215=>"'?zNs?IHSuJQ|nZIQ='",5216=>"MS") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ExternalLinkObject {public $cms; public $db; public $moduleName; public $id; public $II1LI1I; public $targetId; public $name; public $initialized; function ExternalLinkObject(&$cms, &$db) {$this->cms =&$cms; $this->db =&$db; $this->Free(); }function Free() {$this->id =0; $this->II1LI1I =""; $this->targetId =0; $this->name =""; $this->initialized =false; }function Init($cId, $IIIL1LL) {if($cId != I5214) {$sql ="SELECT id, id_target, name FROM cms_external_links ". "WHERE id_external='".addslashes($cId).I5215.$IIIL1LL."' AND lang='".$this->cms->lang_data."'"; $this->db->query($sql); if($this->db->next_record()) {$this->id =$this->db->Record[I5216]; $this->targetId =$this->db->Record["id_target"]; $this->name =$this->db->Record["name"]; $this->initialized =true; $this->moduleName =$IIIL1LL; $this->II1LI1I =$cId; }}return $this->initialized; }function TTTT1Il() {return $this->initialized; }function Save() {}function GetName() {return $this->name; }function TITIlT1() {return $this->targetId; }}?>