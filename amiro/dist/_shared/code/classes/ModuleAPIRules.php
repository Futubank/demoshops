<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    core 
 * @subpackage api 
 * @version    $Id$ 
 * @size       3350 xkqwwypssxrwugirikmlxwktnigtigykxkilqlslyuxyszsnslplnitgppmnnxrkqlxlpnir
 */ ?><?php foreach(array(5957=>'jhwzj|Fmjqd|gzTo',5958=>'~',5959=>'DQJQWtQS',5960=>'nH|QxtQrnZJ|MntQPrZtMHn|IHSuJQD',5961=>'vZJuQ',5962=>'ZJJHC|QIGtB') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class ModuleAPIRules extends CMS_ActModule {function ModuleAPIRules(&$cms, &$db, &$cModule) {parent::CMS_ActModule($cms, $db, $cModule); }function Init($IIll1l1 =array (),$IIll1LI ='', $IIll1Ll ='', $aOptions =array ()){$path =$GLOBALS['LOCAL_FILES_REL_PATH'] .'_admin/templates/lang/ext_app_integration.lng'; parent::Init($IIll1l1, $IIll1LI, $this->cms->Gui->isValidFile($path) ?$path :'', $aOptions); }function getExternalModulesListCB($cData, $IIL1lL1, &$res, &$aData, $IIL1l1I ='getallvalues') {switch ($IIL1l1I) {case 'getallvalues': $res =array ();$IlllIll =$GLOBALS[I5957] .'ext_integration'; $selected =$IIL1lL1['SimpleMode'] ?'selected' :'1'; if (is_dir($IlllIll) && ($handle =opendir($IlllIll))) {while (false !== ($file =readdir($handle))) {if (is_file($IlllIll .I5958. $file) && mb_strpos($file, '.php') == (mb_strlen($file) -4) && mb_strpos($file, 'API_') === 0) {$moduleName =mb_substr($file, 4, -4); $res[] =array ('name' => $moduleName, 'caption' => isset($this->words[$moduleName]) ?$this->words[$moduleName] :$moduleName, I5959 => (in_array($moduleName, $cData['value']) ?$selected :'') );}}closedir($handle); }if (count($res) == 0) {$res[] =array ('name' => -1, 'caption' => $this->cms->Words[I5960], I5959 => ($cData[I5961] == -1 ?$selected :'') );}break; case 'getvalue': $res =$cData[I5961]; break; case 'correctvalue': $res =-1; break; case 'apply': break; }$aData[I5962] =1; return true; }}?>