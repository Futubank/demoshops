<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @version    $Id$ 
 * @size       4074 xkqwzyzguzpprnixiyisylukyislgmugylrusttiqgqksluznkgkzxqwknqgrxplsztnpnir
 */ ?><?php foreach(array(9468=>"PQtZJJvZJuQD",9469=>"MIZPQfMJQ",9470=>"nZIQ",9471=>"",9472=>"vZJuQ",9473=>"WZGtMHn") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ModuleExtRSSRules extends CMS_ActModule {function ModuleExtRSSRules(&$cms, &$db, &$cModule) {parent::CMS_ActModule($cms, $db, $cModule); }function getOptionsRssImage($cData, $IIL1lL1, &$res, &$aData, $IIL1l1I ="getallvalues"){ return $this->TIIl11T($cData, $IIL1lL1, $res, $aData, $IIL1l1I, "imagefile"); }function getOptionsRssStyle($cData, $IIL1lL1, &$res, &$aData, $IIL1l1I =I9468){ return $this->TIIl11T($cData, $IIL1lL1, $res, $aData, $IIL1l1I, "stylefile"); }function TIIl11T($cData, $IIL1lL1, &$res, &$aData, $IIL1l1I =I9468, $lIl1IIL ="none"){ $Ill111I =&$this->module->TTlIIIT(); switch($IIL1l1I){ case I9468: $lIl1II1 =$GLOBALS["ROOT_PATH"].$Ill111I->GetProperty("rss_channel_dir"); switch ($lIl1IIL){ case I9469: $lIl1IlI =$Ill111I->GetProperty("rss_image_ext"); $lIl1Ill =$Ill111I->GetProperty("rss_image_maxsize"); break; case "stylefile": $lIl1IlI =$Ill111I->GetProperty("rss_style_ext"); break; default: }$res[] =array(I9470 => "-1", "caption" => $this->words["rss_off"], "selected" => I9471); $lIl1IlL =0; if (is_dir($lIl1II1) ){$lIl1Il1 =dir($lIl1II1); while (false !== ($fileName =$lIl1Il1->read())) {$fileExtension =mb_strtolower(get_file_ext($fileName)); if (in_array($fileExtension, $lIl1IlI)) {if ($lIl1IIL == I9469) {$fileSize =imageGetSize($lIl1II1.$fileName); if ($fileSize[0] >= $lIl1Ill["width"] || $fileSize[1] >= $lIl1Ill["height"]) continue; }$res[] =array(I9470 => $fileName, "caption" => $fileName, "selected" => ($cData[I9472] == $fileName ?($IIL1lL1["SimpleMode"] ?"selected" :"1") :I9471)); $lIl1IlL++; }}$lIl1Il1->close(); }if ($lIl1IlL == 0 && $lIl1IIL != "none" )$res[0][I9473] =$this->words["rss_no_files"]; break; case "getvalue": $res =$cData[I9472]; break; case "correctvalue": $res =-1; break; case "apply": break; }return true; }}?>