<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       23985 xkqwlkmxwwumulszpmtzklxmpqzrkgxxskztrrgpgnzszplxguwlrxtgiqwqssxiitrupnir
 */ ?><?php foreach(array(15057=>"IHSuJQD",15058=>"JZnP",15059=>'zim|zjjhc|jhwzj|ihsUjqd',15060=>"",15061=>'nHt|MnDtZJJQS',15062=>"tMIQJMIMt",15063=>"?200?hk",15064=>'oTTg|UdqR|zpqNT',15065=>"wHntQnt+tBGQ%?",15066=>'nHt|JHPPQS|Mn',15067=>'unKnHCn|fMJQ',15068=>"ftGPQtfMJQ",15069=>"IHSuJQ",15070=>"PZJJQrB",15071=>'QrrHrwHSQ',15072=>'wjzddqd|gzTo',15073=>'frHnt',15074=>"DuYD|DQnS",15075=>"MS",15076=>"QDOHG|fMJQD",15077=>"FRhi?",15078=>"HrMPMnZJ|fnZIQ",15079=>"HrSQr|MS",15080=>"nHt|MnDtZJJQS",15081=>'SHCnJHZS|DtZtuD',15082=>"|HrSQrD.?.H.?",15083=>".H.`.MS|IQIYQr.?=?",15084=>"'{?zNs?",15085=>'Qxt|SZtZ',15086=>"QxGMrQ",15087=>"'?zNs?f`MS='",15088=>"Qxt|SZtZ",15089=>"QDOHG|SMPMtZJD",15090=>"HrSQr|QxGMrQS",15091=>"QDOHG|fMJQD|GZtO",15092=>"ZSIMn",15093=>"'!'",15094=>"SHCnJHZS|ZttQIGtD",15095=>"DIZJJ|GMWturQ",15096=>"GMWturQ",15097=>"?zNs?IHSuJQ='",15098=>"'",15099=>"ihsUjq|gmwTURqd|gzTo",15100=>'LHYD|OMDtHrB|',15101=>"RqeUqdT|iqTohs",15102=>"oTTg|RzNpq",15103=>"dqRVqR|gRhThwhj",15104=>"MnMtMZJ",15105=>"-1?OHurD",15106=>'') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $ActiveModule ="show_pic"; $lLIlIIl =I15057; $ENABLE_BUFFERING =false; if(isset($_GET["lang"])) {$lang =$lang_data =$_GET[I15058]; }$path =$ROOT_PATH .'_local/common_functions.php'; if( (empty($GLOBALS['sys']['disable_user_scripts']) || defined(I15059) )&& file_exists($path) ){require_once $path; }if('front' == $_SIDE) {$skip_detect_page =1; require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .files_subpath .'detector.php'; }require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .'init.php'; $lang =mysql_real_escape_string($lang, $db->_dbLink); if('admin' == $_SIDE){ $cms =&$adm; $lLIlIIL =I15060; }else{ $cms =&$frn; $lLIlIIL =" AND public='1'"; }if(!$cms->Core->IsInstalled('files')){ TlTIT11(I15061); }$IlIlllI =&$cms->Core->GetModule("files"); $buffer =$IlIlllI->GetOption("buffer"); $lLIlII1 =$IlIlllI->GetOption(I15062); $id =$cms->VarsGet["id"]; if(!isset($id)||empty($id)){ TlTIT11('unknown_file'); }$errorCode =I15060; $lLIlIlI =$IlIlllI->GetOption("partial_download_on"); $status =$GLOBALS["SERVER_PROTOCOL"].I15063; function TlTIT1T(){ $lLIlIll =AMI::getSingleton('env/request')->get('logout_after', FALSE); if($lLIlIll){ $oSession =AMI::getSingleton('env/session'); if($oSession->isStarted() && $oSession->isLoggedIn()){ $oSession->logout(); }}die; }function GetContentType($lLIlIlL, $lLIlIl1){ $lLIlILI =mb_strtoupper(get_file_ext($lLIlIlL)); if(isset($lLIlIl1[$lLIlILI])){ $ftype =$lLIlIl1[$lLIlILI]; }else{ $ftype ="application/octet-stream"; }return $ftype; }function TlTIT1I($oname, $fsize, $status, $lLIlIl1=false, $lLIlILl =I15060) {global $lLIlIlI; $I1lIl1I =$oname; if(!empty($_SERVER[I15064]) && (mb_strpos($_SERVER[I15064], 'MSIE ') !== false)){ $I1lIl1I =rawurlencode($I1lIl1I); }Header($status); if(strpos($I1lIl1I, ",") !== false){ $I1lIl1I =str_replace(",", "_", $I1lIl1I); }if(is_array($lLIlIl1)) {$lLIlILI =mb_strtoupper(get_file_ext($oname)); if(isset($lLIlIl1[$lLIlILI])){ $ctype =$lLIlIl1[$lLIlILI]; }else{ $ctype ="application/octet-stream"; }Header("Content-disposition: filename=\"$I1lIl1I\""); }else {$ctype ="application/force-download; name=\"".$I1lIl1I."\""; Header("Content-Disposition: attachment; filename=\"$I1lIl1I\""); }if($lLIlIlI) {Header("Accept-Ranges: bytes"); }else {Header("Accept-Ranges: none"); }if(is_array($lLIlILl) && sizeof($lLIlILl) >0) {foreach($lLIlILl as $key=>$val) {Header($val); }}Header(I15065.$ctype); Header("Content-Length: ".$fsize); }function TlTIT1l(&$content, $lLIlII1) {set_time_limit($lLIlII1); echo $content; flush(); if(connection_aborted()) {TlTIT1T(); }}function TlTIT11($errorCode){ global $cms; header('Content-Type: text/html; charset=UTF-8', TRUE); $aHeaders =array( 'wrong_request' => array(400, 'Status: %s Bad Request'), I15066 => array(401, 'Status: %s Unauthorized'), 'access_denied' => array(403, 'Status: %s Forbidden'), 'no_attempts' => array(403, 'Status: %s Forbidden'), 'order_expired' => array(403, 'Status: %s Forbidden'), 'not_found' => array(404, 'Status: %s Not Found'), I15067 => array(404, 'Status: %s Not Found'), I15061 => array(404, 'Status: %s Forbidden') );if(isset($aHeaders[$errorCode])){ $aHeader =$aHeaders[$errorCode]; header(sprintf($aHeader[1], $aHeader[0]), TRUE, $aHeader[0]); }$lLIlILL =$cms->Gui->ParseLangFile($GLOBALS["LOCAL_FILES_REL_PATH"]."_admin/templates/lang/ftpgetfile.lng"); $cms->Gui->addBlock(I15068, $GLOBALS["LOCAL_FILES_REL_PATH"]."_admin/templates/ftpgetfile.tpl"); $IlL1IIl =Array(); $IlL1IIl["err_message"] =$lLIlILL[$errorCode]; echo $cms->Gui->get(I15068, $IlL1IIl); TlTIT1T(); }if(!isset($cms->VarsGet[I15069]) || empty($cms->VarsGet[I15069])) {$moduleName ="files"; }else {$lLIlIL1 =$moduleName =$cms->VarsGet[I15069]; if($moduleName == I15070 || $moduleName == "eshop") $lLIlIL1 .= "_item"; if(!$cms->Core->IsInstalled($lLIlIL1)) {TlTIT11(I15061); }}$aEvent =array( 'modId' => isset($lLIlIL1) ?$lLIlIL1 :$moduleName, 'itemId' => $id, I15071 => '' );AMI_Event::fire('on_file_download', $aEvent, AMI_Event::MOD_ANY); if('' !== $aEvent[errorCode]){ TlTIT11($aEvent[errorCode]); TlTIT1T(); }$filename =I15060; switch($moduleName) {case 'srv_backups': require_once $GLOBALS[I15072].'CMSBackup.php'; $type ='file'; $filename =$oname =''; $file_id =intval($cms->VarsGet["id"]); if($_SIDE==I15073) {$errorCode ='access_denied'; }else {$lI1IIll =new CMSBackup($db,$file_id); $meta =$lI1IIll->meta(); if(($meta)!==false && $meta['sys_type']==ARCH_SYSTYPE_USER) {$filename =$oname =$lI1IIll->TI1lI1I(); $lLIlI1I =$lI1IIll->TI1lI1l(); $sql =''; }else {$errorCode ='wrong_request'; }}break; case I15074: $sql ="select attach as name, attach_data as body from cms_subs_sent where id='$id'"; $type ="base"; break; case "eshop": if(!$cms->Core->IsInstalled('eshop_digitals')){ TlTIT11(I15061); }$lIIII1L =&$cms->Core->GetModule("eshop_digitals"); $file_id =intval($cms->VarsGet[I15075]); $ILLl1I1 =&$cms->Core->GetModule("eshop_item"); $tableName =$ILLl1I1->GetTableName(); $pos =mb_strrpos($tableName, "_items"); $dbTablePrefix =mb_substr($tableName, 0, mb_strlen($tableName) -$pos); $lLIlI1l =false; $lLIlI1L =false; $lLIlI11 =I15060; if($_SIDE!="admin") {$lLIlI11 =" AND f.active=1"; $lLIllII =$cms->Core->GetModOption(I15076, "allow_external_files"); if(!$lLIllII) {$lLIlI11 .= " AND f.is_external_file=0"; }}$type ="file"; $sql ="SELECT f.original_fname, f.filename, f.free_download, f.is_external_file, `f`.`id_product` " .I15077.$dbTablePrefix."_files AS f WHERE f.id='".$file_id."'".$lLIlI11; $db->query($sql); if($db->next_record()) {$aFileData =$db->Record; $lLIlI1l =$db->Record["free_download"]; $filename =$db->Record["filename"]; if($lLIlI1l) {$oname =$db->Record[I15078]; $lLIlI1L =true; }if($db->Record["is_external_file"] == 1) {$type ="external_file"; }}else {$errorCode ="wrong_request"; }if($_SIDE!="admin" && !$lLIlI1l) {$order_id =intval($cms->VarsGet[I15079]); $item_id =intval($cms->VarsGet["item_id"]); $file_id =intval($cms->VarsGet[I15075]); $errorCode =$lIIII1L->IsInstalled()?I15060:I15080; $errorCode =$cms->Member->isLoggedIn()?I15060:"not_logged_in"; if($errorCode == I15060) {$errorCode ="wrong_request"; $userId =(int)$cms->Member->getUserInfo('id'); $lLIllIl =$lIIII1L->GetOption(I15081); if(!is_array($lLIllIl)) {$lLIllIl =Array($lLIllIl); }$aExtData =array(); if( ($order_id <= 0 || $item_id <= 0) && !empty($cms->VarsGet['get_by_file_id']) ){$item_id =(int)$aFileData['id_product']; $sql ="SELECT `o`.`id`, `o`.`ext_data` " ."FROM `" .$dbTablePrefix .I15082 ."LEFT JOIN `" .$dbTablePrefix ."_order_items` `oi` " ."ON `oi`.`id_order` = `o`.`id` " ."WHERE " .I15083 .$userId ." AND `oi`.`id_product` = " .$item_id ." AND " ."`o`.`status` IN ('".implode("', '", $lLIllIl) .I15084 ."`o`.`lang` = '" .$lang ."' " ."LIMIT 1"; $db->query($sql); if($db->next_record()){ $order_id =(int)$db->Record['id']; $aExtData =unserialize($db->Record[I15085]); }}if($order_id >0 && $item_id >0) {if(empty($aExtData)){ $sql ="SELECT ext_data FROM ".$dbTablePrefix."_orders AS o WHERE o.id='".$order_id. "' AND id_member='".$userId."' AND o.lang='".$lang."' AND o.status IN('".implode("','", $lLIllIl)."')"; $db->query($sql); if($db->next_record()) {$aExtData =unserialize($db->Record["ext_data"]); }}if(!empty($aExtData)){ $expireTime =intval($aExtData["eshop_digitals"][I15086]); if($expireTime >time()) {$sql ="SELECT f.original_fname, f.filename, oi.ext_data FROM ".$dbTablePrefix."_order_items AS oi, ".$dbTablePrefix."_files AS f WHERE oi.id_order='".$order_id."' AND oi.id_product='".$item_id.I15087.$file_id."' AND f.id_product='".$item_id."'".$lLIlI11." AND f.lang='".$lang."'"; $db->query($sql); $sql =I15060; if($db->next_record()){ $aExtData =unserialize($db->Record[I15088]); $ILLlI11 =intval($lIIII1L->GetOption("max_download_attempts")); if(isset($aExtData["eshop_digitals"]["download_attempts"][$id]["rest"])) {$ILLlI11 =intval($aExtData[I15089]["download_attempts"][$id]["rest"]); }if($ILLlI11 >0) {$filename =$db->Record["filename"]; $oname =$db->Record[I15078]; $errorCode =I15060; }else {$errorCode ="no_attempts"; }}}else {$errorCode =I15090; }}}}}else {if(!$lLIlI1L) {$sql ="SELECT f.original_fname, f.filename FROM ".$dbTablePrefix."_files AS f WHERE f.id='".$file_id."'".$lLIlI11; }}$lLIlI1I =$GLOBALS["PRIVATE_PATH"].$lIIII1L->GetOption(I15091); break; case I15070: if(!$cms->Core->IsInstalled('gallery_digitals')){ TlTIT11(I15061); }$lLIllIL =&$cms->Core->GetModule("gallery_item"); $lLIllI1 =&$cms->Core->GetModule("gallery_digitals"); $file_id =intval($cms->VarsGet[I15075]); $tableName =$lLIllIL->GetTableName(); $pos =mb_strrpos($tableName, "_items"); $dbTablePrefix =mb_substr($tableName, 0, mb_strlen($tableName) -$pos); $lLIlI1I =I15060; if($_SIDE!=I15092) {$order_id =intval($cms->VarsGet[I15079]); $item_id =intval($cms->VarsGet["item_id"]); $errorCode =$lLIllIL->IsInstalled() ?I15060 :I15080; $errorCode =is_object($cms->Member) && $cms->Member->isLoggedIn()? I15060 :"not_logged_in"; if($errorCode == I15060) {$errorCode ="wrong_request"; if($order_id >0 && $item_id >0) {$userId =$cms->Member->getUserInfo(I15075); $lLIllIl =$lLIllI1->GetOption("download_status"); if(!is_array($lLIllIl)) {$lLIllIl =Array($lLIllIl); }$sql ="SELECT ext_data FROM ".$dbTablePrefix."_orders AS o WHERE o.id='".$order_id."' AND id_member='".$userId."' AND o.lang='".$lang."' AND o.status IN('".implode(I15093, $lLIllIl)."')"; $db->query($sql); $sql =I15060; if($db->next_record()) {$aExtData =unserialize($db->Record[I15088]); $expireTime =intval($aExtData[I15089][I15086]); if($expireTime >time()) {$sql ="SELECT f.ext_popup_picture as popup_picture, f.ext_small_picture as small_picture, f.ext_picture as picture, oi.ext_data FROM ".$dbTablePrefix."_order_items AS oi, ".$dbTablePrefix."_items AS f WHERE oi.id_order='".$order_id."' AND oi.id_product='".$item_id.I15087.$file_id."'".$lLIlI11." AND f.lang='".$lang."'"; $db->query($sql); $sql =I15060; if($db->next_record()){ $aExtData =unserialize($db->Record[I15088]); $ILLlI11 =intval($lLIllI1->GetOption("max_download_attempts")); if(isset($aExtData[I15089][I15094][$id]["rest"])) {$ILLlI11 =intval($aExtData[I15089][I15094][$id]["rest"]); }if($ILLlI11 >0) {$lLIlllI =$db->Record["popup_picture"]; if(empty($lLIlllI)) $lLIlllI =$db->Record["picture"]; if(empty($lLIlllI)) $lLIlllI =$db->Record[I15095]; $filename =I15060; $lLIlI1I =I15060; if(is_file($GLOBALS["ROOT_PATH"].$lLIlllI)){ $filename =basename($lLIlllI); $lLIlI1I =dirname($GLOBALS["ROOT_PATH"].$lLIlllI)."/"; }$oname =$filename; $errorCode =I15060; }else {$errorCode ="no_attempts"; }}}else {$errorCode =I15090; }}}}}else{ $sql ="SELECT popup_picture, small_picture, picture FROM ".$dbTablePrefix."_items WHERE id='".$file_id."' AND lang='".$lang."'"; $db->query($sql); $sql =I15060; if($db->next_record()){ $lLIlllI =$db->Record["popup_picture"]; if(empty($lLIlllI)) $lLIlllI =$db->Record[I15096]; if(empty($lLIlllI)) $lLIlllI =$db->Record[I15095]; if(is_file($GLOBALS["ROOT_PATH"].$lLIlllI)){ $filename =basename($lLIlllI); $lLIlI1I =dirname($GLOBALS["ROOT_PATH"].$lLIlllI)."/"; }$oname =$filename; $errorCode =I15060; }}$type ="file"; break; default: $sql ="select original_fname, filename from cms_files where id='$id' ".$lLIlIIL.I15097.$moduleName.I15098; $lLIlI1I =$GLOBALS[I15099].$IlIlllI->GetOption("files_path"); $type ="file"; break; }if($errorCode == I15060) {switch($type) {case "external_file": Header($GLOBALS["SERVER_PROTOCOL"].' 301 Moved Permanently'); Header("Location: ".$filename, true, 301); TlTIT1T(); break; case "file": if($sql != I15060) {$db->query($sql); if($db->next_record()){ $filename =$db->Record["filename"]; $oname =$db->Record[I15078]; }}if(!empty($filename)){ if((mb_stripos($filename, 'jobs_resume_') === 0) || (mb_stripos($filename, I15100) === 0)){ if($_SIDE == I15073){ TlTIT11('not_found'); }}if(empty($oname)) $oname =$filename; $filename =$lLIlI1I.$filename; if(file_exists($filename)){ $fsize =filesize($filename); if($fsize){ $fp =fopen($filename, "r"); if($fp){ if($moduleName!="eshop") {$imgTypes =$cms->Core->GetProperty("images_mimes"); }if($_SERVER[I15101] == "HEAD") {TlTIT1I($oname, $fsize, $status, $imgTypes); TlTIT1T(); }else {$lLIlILl =Array(); $lLIllll =0; if($lLIlIlI) {if(isset($_SERVER["HTTP_RANGE"])) {$pos =mb_strpos($_SERVER["HTTP_RANGE"], "="); if($pos !==false && $pos >0) {$range =mb_substr($_SERVER[I15102], $pos +1); $pos =mb_strpos($range, "-"); if($pos !== false) {$lLIllll =intval(mb_substr($range, 0, $pos)); $size =intval(mb_substr($range, $pos +1)); if($size <= 0) {$size =$fsize -1; }if($lLIllll >$size) {$lLIllll =0; $size =$fsize -1; }$lLIlILl[] ="Content-Range: bytes ".$lLIllll."-".$size."/".$fsize; $status =$GLOBALS[I15103]." 206 Partial Content"; $fsize =$size -$lLIllll +1; fseek($fp, $lLIllll); }}}else {$lLIlIlI =false; }}if($moduleName=="eshop" && $_SIDE!=I15092 && !$lLIlI1l) {$lLIlllL =true; if(is_object($oSession)) {if(!$oSession->IssetVar("eshop_digitals_download_".$id)) {$oSession->SetVar("eshop_digitals_download_".$id, strtotime($lIIII1L->GetOption("max_time_for_attempt"))); }else {$lLIlll1 =$oSession->GetVar("eshop_digitals_download_".$id); if($lLIlll1 >time()) {$lLIlllL =false; }else {$oSession->SetVar("eshop_digitals_download_".$id, strtotime($lIIII1L->GetOption("max_time_for_attempt"))); }}}if($lLIlllL && $lLIllll <100) {$aExtData[I15089][I15094][$id]["rest"] =$ILLlI11 -1; if(!isset($aExtData[I15089][I15094][$id][I15104])) {$aExtData[I15089][I15094][$id][I15104] =$lIIII1L->GetOption("max_download_attempts"); }$asql =Array(I15088=>addslashes(serialize($aExtData))); $sql =$db->GenUpdateSQL($dbTablePrefix."_order_items", $asql, "WHERE id_order='".$order_id."' AND id_product='".$item_id.I15098); $db->query($sql); }}TlTIT1I($oname, $fsize, $status, $imgTypes, $lLIlILl); $lLIllLI =true; while($content =fread($fp, $buffer)) {if($lLIllll == 0 && $lLIllLI) {$lLIllLI =false; if($_SIDE!=I15092 && $IlIlllI->GetOption("show_download_counter") && $moduleName=="files" && $lLIllll == 0) {$sql ="UPDATE cms_files SET num_downloaded=num_downloaded+1 WHERE id='".$id.I15098; $lLIllLl =new DB_si; $lLIllLl->query($sql); $curTime =time(); $lLIllLL =date("i", $curTime); if($lLIllLL <59) {$lLIllL1 =59; $hour =date("H", $curTime); $expTime =mktime($hour, $lLIllL1, 59); }else {$expTime =strtotime (I15105); }$cms->Core->Cache->ClearAdd("files", 0, I15060, $expTime); }}TlTIT1l($content, $lLIlII1); }TlTIT1T(); }}}}}break; case "base": $db->query($sql); if($db->next_record()) {$oname =$db->Record["name"]; $fbody =$db->Record["body"]; $fsize =mb_strlen($fbody); $pos =0; TlTIT1I($oname, $fsize); while($pos <$fsize) {TlTIT1l(mb_substr($fbody, $pos, $buffer), $lLIlII1); $pos += $buffer; }TlTIT1T(); }break; }}if($errorCode != I15106){ TlTIT11($errorCode); }TlTIT11('not_found'); 