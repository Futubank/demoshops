<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       15313 xkqwgtylgysxtunpwurkgnntpmxymqinplxpwyykmlkqtprkwiqzziktiwylygltqpsypnir
 */ ?><?php foreach(array(20185=>'UTF+8',20186=>'|whhkmq',20187=>"",20188=>'fMJQ',20189=>'DMnPJQ',20190=>'Dsy|sZtZYZDQ',20191=>'fJZPD',20192=>'SQfZuJt',20193=>'SYZDQ',20194=>"sZtQ%??????",20195=>"dMtQ%??????",20196=>"\n",20197=>"'",20198=>'SZQIHn|ZSSr',20199=>"dqT?Nziqd?'utf8'",20200=>"ZSIMn",20201=>"``~",20202=>'cmN',20203=>'|OHDt~OHDt`MnW`',20204=>'zsimN|RqeUmRq|ddj',20205=>'dwRmgT|Nziq',20206=>'',20207=>'WHSQ|GHDtfMx',20208=>'oTTg|ohdT',20209=>'JJZnP',20210=>'DQDDMHn',20211=>'zWWQDD?SQnMQS',20212=>"~\\\\~",20213=>'Dsy|gZDDCHrS',20214=>'60~',20215=>'DuYfHJSQr',20216=>"QnZYJQ|WZWOQ",20217=>'|DOZrQS~WHSQ~OBGQr|IHSuJQD~',20218=>'|JHWZJ~IHSuJQD~',20219=>'OBGQr|DOZrQS',20220=>'GZtO~rHHt',20221=>'fJt|IHSuJQ|YHSB|HnJB') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){ define('AMI_ENVIRONMENT', TRUE); }mb_internal_encoding(I20185); @set_magic_quotes_runtime(false); if(empty($AMI_MICROTIME_STARTED)){ $AMI_MICROTIME_STARTED =microtime(true); }$AMI_ESCAPE_REQUEST =!@get_magic_quotes_gpc(); function amiNotArray($value){ return !is_array($value); }$_COOKIE =array_filter($_COOKIE, 'amiNotArray'); if($AMI_ESCAPE_REQUEST){ foreach(array_keys($_COOKIE) as $k){ $_COOKIE[$k] =addslashes($_COOKIE[$k]); }unset($k); }if(ini_get('register_globals') == 1){ foreach(array('_POST', '_GET', I20186, '_REQUEST', '_FILES') as $n){ foreach($GLOBALS[$n] as $k => $v){ if(isset($GLOBALS[$k])){ unset($GLOBALS[$k]); }}}}unset($n, $k, $v); include "_host/copyright.php"; error_reporting (E_ALL &~E_NOTICE); @ini_set("zend.ze1_compatibility_mode", I20187); define('HOSTMODE_SHARED', 0x2); define('HOSTMODE_ADMIN', 0x4); define('SF_DEMO', 0x04); function TlITllI($op='get',$arg=false,$l1II1L1=true){ global $_h; static $dbh =array(); static $l1II11I =false; static $path =false; if($path!==false){ $st =debug_backtrace(); foreach($st as $i => $se){ if(mb_strpos($se[I20188], $path) !== false) {trigger_error("DBC: access denied", E_USER_ERROR); }}}if($op==='check_path') return false; if(is_array($_h) && isset($_h['mode'])) {$l1II11l =$_h['mode']==I20189; }else {trigger_error('DBC: cannot detect mode',E_USER_ERROR); }if($l1II11I===false) {$l1II11I =array(); $l1II11I['host'] =$GLOBALS['sDB_Host']; $l1II11I['dbase'] =$GLOBALS[I20190]; $l1II11I['user'] =$GLOBALS['sDB_User']; $l1II11I['pass'] =$GLOBALS['sDB_Password']; $l1II11I[I20191] =isset($GLOBALS['l1IIlLI']) ?(int)$GLOBALS['l1IIlLI'] :0; }switch($op) {case 'baddir': if($path===false) {$path =$arg; return false; }case 'close': $l1II11L =$l1II11l ?I20192 :BUILDER_DOMAIN; if($arg===false || $l1II11l) $arg =$l1II11L; if(isset($dbh[$arg])) {@mysql_close($dbh[$arg]); unset($dbh[$arg]); }return false; case 'get': $l1II11L =$l1II11l ?I20192 :BUILDER_DOMAIN; if($arg===false || $l1II11l) $arg =$l1II11L; if(!isset($dbh[$arg])) {if(!isset($dbh[$l1II11L])) {if(!($l1II111 =@mysql_connect( $l1II11I['host'], $l1II11I['user'], $l1II11I['pass'], true, $l1II11I[I20191] ))|| !@mysql_select_db($l1II11I[I20193],$l1II111)) {if($l1II1L1) {if(!$l1II11l && preg_match('/\.cmspanel\.|\.websitemaster\./', BUILDER_DOMAIN)){ @mail( 'reports.dev@locmail.amiro.ru', 'BUILDER DB FAILED: ' .BUILDER_DOMAIN, "Cannot connect to the builder DB!\n\n" .I20194 .date('Y-m-d H:i:s') ."\n" ."Builder:   " .BUILDER_DOMAIN ."\n" .I20195 .$GLOBALS['ROOT_PATH_WWW'] ."\n" ."Host IP:   " .$_SERVER['SERVER_ADDR'] .I20196 ."Client IP: " .getenv('REMOTE_ADDR') .I20196 );}require_once $GLOBALS['CLASSES_PATH'] .'60/AMI_Service.php'; AMI_Service::log('Clan DB is temporarily unavailable', $GLOBALS['ROOT_PATH'] .'_admin/_logs/err.log'); display503Header(3600); define('AMI_DB_ERROR', TRUE); $text =require($GLOBALS['CLASSES_PATH'] .'60/AMI_ErrorHandler_Message.php'); die($text); }else{ return false; }}@mysql_query("SET NAMES 'utf8'", $l1II111); $dbh[$l1II11L] =$l1II111; }do {if($arg==$l1II11L) {$ret =$dbh[$arg]; break; }$sql ="SELECT u.dbase,u.id_node,n.daemon_addr,n.mysql_addr FROM cms_host_users u ". "LEFT JOIN cms_clan_nodes n ON n.id=u.id_node ". "WHERE u.domain_orig='".addslashes($arg).I20197; $res =@mysql_query($sql,$dbh[$l1II11L]); $data =@mysql_fetch_array($res); if($data===false) {if($l1II1L1) trigger_error('DBC: invalid domain '.$arg,E_USER_ERROR); else {$ret =false; break; }}if(!$data['id_node']) $host =$l1II11I['host']; else $host =empty($data['mysql_addr']) ?$data[I20198] :$data['mysql_addr']; if($host===$l1II11I['host'] && $data[I20193]===$l1II11I[I20193]) {$ret =$dbh[$l1II11L]; break; }if(!($l1IlIII =@mysql_connect( $host, $l1II11I['user'], $l1II11I['pass'], true, $l1II11I[I20191] )))trigger_error("DBC: Cannot connect to db host '$host': ".mysql_error(),E_USER_ERROR); if(!@mysql_select_db($data[I20193],$l1IlIII)) trigger_error("DBC: Cannot use database $data[dbase]@$host: ".mysql_error($l1IlIII),E_USER_ERROR); @mysql_query(I20199, $l1IlIII); $ret =$dbh[$arg] =$l1IlIII; }while(false); }else $ret =$dbh[$arg]; return $ret; default: trigger_error("DBC: unknown op '$op'",E_USER_ERROR); }}function admSession($obj=false) {static $sess =false; if(is_object($sess)) return $sess; if(is_object($obj)) {$sess =$obj; return $sess; }return false; }function TlITlll(){ $str =$_SERVER['PHP_SELF']; if (empty($str)){ $str =@getenv('SCRIPT_NAME'); }return $str; }function hostMode(){ static $mode =false; if($mode!==false){ return $mode; }if($GLOBALS['_h']['mode']==I20189) {$mode =0; }else{ $mode =HOSTMODE_SHARED; $sess =admSession(); if($sess->TlIT11I()==BUILDER_DOMAIN or $sess->TlIT11I()==REMOTE_BUILDER_DOMAIN) {$mode |= HOSTMODE_ADMIN; }}return $mode; }$_SIDE =I20200; $_current_timestamp =time(); $bench_time =array("_bstart" => microtime()); $_h =array(); $l1IlIIl ='../readconf.php'; if(file_exists($l1IlIIl)){ $l1IlIIL ='../_local/'; include $l1IlIIl; $_h['mode'] =I20189; $sDB_Host =DB_Host; $sDB_Database =DB_Database; $sDB_User =DB_User; $sDB_Password =DB_Password; $l1IlII1 ="../_shared/code/lib/"; $l1IlIlI ="../_shared/code/classes/"; $CLASSES_PATH =$l1IlIlI; require_once $l1IlII1.'func_simple.php'; $ROOT_PATH_WWW =TlT1TlT(false); $ADMIN_PATH_WWW =$ILlII1l =$ROOT_PATH_WWW.'_admin/'; $_h["root_dir"] =I20201; $_h["postfix"] ="/"; if(!isset($ROOT_PATH)) {$ROOT_PATH =realpath(getcwd().'/../').'/'; if(mb_substr(PHP_OS,0,3)==I20202) $ROOT_PATH =preg_replace("/\\\\/",'/',$ROOT_PATH); }}else {$_h['mode'] ='shared'; $l1IlIll =I20203.mb_strtolower($_SERVER['HTTP_HOST']).'.php'; if(file_exists($l1IlIll)) require_once $l1IlIll; else require_once "_host/host.inc.php"; unset($l1IlIll); if(!defined('ADMIN_REQUIRE_SSL')){ define(I20204, 'no'); }if($l1IIlLl) {if(!function_exists('session_start')) $l1IIlLl =false; else session_start(); }$pi =empty($_SERVER['PATH_INFO']) ?explode('/',$_SERVER[I20205]) :explode('/',$_SERVER['PATH_INFO']); array_shift($pi); $postfix =array_pop($pi); if(empty($postfix)) $postfix =array_pop($pi); if(mb_strpos($postfix,'.php')!==false) $postfix =array_pop($pi); if($postfix=='_admin') $postfix =I20206; elseif(array_pop($pi)!='_admin') die("Invalid adm URL"); $path =sizeof($pi) ?implode('/',$pi).'/' :I20206; if($postfix!=I20206) {$_h[I20207] =$postfix; $l1IlIlL ='-'.$postfix; $postfix .= '/'; }else {$l1IlIlL =I20206; }$l1IlII1 ="../_shared/code$l1IlIlL/lib/"; $l1IlIlI ="../_shared/code$l1IlIlL/classes/"; $CLASSES_PATH =$l1IlIlI; require_once $l1IlII1.'func_simple.php'; unset($l1IlIlL); $ILlII1l ='http://'.mb_strtolower($_SERVER[I20208]).'/'.$path.'_admin/'; $ADMIN_PATH_WWW =$ILlII1l.$postfix; unset($pi); unset($path); unset($postfix); }require("includes/host_session.php"); require_once $l1IlII1 .'function.php'; $l1IlIl1 =isset($_GET[I20209]) ?$_GET[I20209] :ADMIN_LOGIN_LANG; $oSess =new LoginSession($l1IlIl1); $oSess->l1llLLI =true; $oSess->hostMode =$_h["mode"]; if( FALSE !== mb_strpos(getenv('HTTP_VIA'), 'Chrome-Compression-Proxy') || getenv('HTTP_CHROME_PROXY') ){$_h['session_adm_no_ip_bind'] =TRUE; }if((isset($GLOBALS['CONFIG_INI']['session']['session_adm_no_ip_bind']) && $GLOBALS['CONFIG_INI'][I20210]['session_adm_no_ip_bind']) || (isset($GLOBALS['_h']['session_adm_no_ip_bind']) && $GLOBALS['_h']['session_adm_no_ip_bind'])){ $oSess->l1llL1I =true; }require defined('DAEMON_LOGIN_OK') && DAEMON_LOGIN_OK === true ?'includes/daemon_auth.php' :'includes/host_auth.php'; unset($l1IIlLl); if($_h['auth'] !== true){ die(I20211); }admSession($oSess); unset($oSess); hostMode(); if($_h['mode']!=I20189){ $l1IlILI =realpath($_h["root_dir"] .$_h["user_dir"]) .'/'; if(mb_substr(PHP_OS,0,3) == I20202) {$l1IlILI =preg_replace(I20212,'/',$l1IlILI); }TlITllI('baddir', $l1IlILI); unset($GLOBALS['sDB_Host']); unset($GLOBALS[I20190]); unset($GLOBALS['sDB_User']); unset($GLOBALS[I20213]); $l1IlIIL =$l1IlILI.'_local/'; include ('includes/readconf.php'); $ROOT_PATH =$l1IlILI; unset($l1IlILI); if(!isset($HOST_PATH)){ $HOST_PATH =$ROOT_PATH; }}else{ $HOST_PATH =$ROOT_PATH; }require_once $CLASSES_PATH .'60/AMI_Service.php'; $CLASSES_PATH =$HOST_PATH .'_shared/code/classes/'; AMI_Service::addAutoloadPath($CLASSES_PATH); AMI_Service::addAutoloadPath($CLASSES_PATH .I20214); set_error_handler(array('AMI_Service', 'handleError'), CMS_ERROR_REPORTING); AMI_Registry::set('side', 'adm'); AMI_Registry::set(I20215, substr($_SERVER['REQUEST_URI'], 0, strpos($_SERVER['REQUEST_URI'], '/_admin'))); $AMI_REGISTRY =array('cacheMode' => I20206); $GLOBALS[I20216] =1; $aPath =array( 'hyper_shared' => $HOST_PATH .I20217, 'hyper_local' => $ROOT_PATH .I20218, 'images' => $ROOT_PATH .'_mod_files/ce_images/' );AMI_Service::addAutoloadPath($aPath[I20219] .'code/'); AMI_Registry::set('path', $aPath); unset($aPath); if(empty($l1IIlI1)){ require_once($HOST_PATH .'_shared/code/const/const.php'); }AMI_Registry::set('path/host', $HOST_PATH); AMI_Registry::set(I20220, $ROOT_PATH); AMI_Registry::set('path/www_root', $ROOT_PATH_WWW); AMI_Registry::set('path/www_images', $ROOT_PATH_WWW .'_mod_files/ce_images/'); if(isset($_GET['unbuffered_output'])){ $ENABLE_BUFFERING =false; }if(!empty($_GET[I20221]) || !empty($_POST[I20221])){ $I11I1LI =1; }