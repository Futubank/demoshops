<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       8836 xkqwrimzmxypqwsqitqusytpwxixrsnsisqmywwgumsylurrukngkigmxittkxrwxkqkpnir
 */ ?><?php foreach(array(19456=>'wjzddqd|gzTo',19457=>'iHSuJQoHDtTrZffMW`GOG',19458=>'iHSuJQoHDtUDQrD`GOG',19459=>'iHSuJQoHDtgZBIQntD`GOG',19460=>'iHSuJQoHDtgZBIQntDoMDtHrB`GOG',19461=>'czRN',19462=>'DtZtuD',19463=>'SHIZMn',19464=>'ZIHunt|IMn',19465=>'ZIHunt',19466=>'GZBIQnt|nuI',19467=>'Qn',19468=>'OQZSQr',19469=>'WHIGZnB|QIZMJ',19470=>'BQD',19471=>'rQWMGMQnt|ZSSr',19472=>"dTzRT",19473=>'IZDD|GZBIQntD`JHWK',19474=>'C',19475=>'MnDtZJJQS|JZnPD',19476=>"IZMJ|",19477=>"nHC=",19478=>'MS|nHSQ',19479=>'MS|uDQr',19480=>'GZBIQnt|tBGQ',19481=>'GZBIQnt|tBGQ|CHrS',19482=>"NHtMfMWZtMHn?DQnt") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} require_once $GLOBALS['CLASSES_PATH'] .'CMS_Member.php'; require_once $GLOBALS[I19456] .'SiteManager.php'; require_once $GLOBALS[I19456] .I19457; require_once $GLOBALS[I19456] .I19458; require_once $GLOBALS[I19456] .I19459; require_once $GLOBALS[I19456] .I19460; require_once $GLOBALS[I19456] .'Mailer.php'; require_once $GLOBALS[I19456] .'WZDaemon.php'; define("LOG_TO_FILE",true); function _error($msg,$type=I19461) {global $LOG_PATH,$adm; $str =DateTools::toMysqlDate(time()); $str .= " $type: $msg\n"; if(LOG_TO_FILE && ($f=@fopen($LOG_PATH."mass_payments.log","a"))) {fputs($f,$str); fclose($f); }echo $str; flush(); if($type=='FATAL') {exit; }}function _log($msg,$obj=false) {_error($msg,'LOG'); if($obj!==false) _d($obj); }function TITTll1(&$account,$type,$t,$date) {global $adm,$DFMT,$db,$ILLLlIl,$lL1IlIL; if ($account[I19462] != 'active' && $type != 'delete'){ return; }require_once($GLOBALS["FUNC_INCLUDES_PATH"]."func_format.php"); $member =CMS_Member::TTTll11($account[I19463],$account['username']); TlIT111('close',$account[I19463]); $III1LlI =array (I19463=>$account[I19463], 'curdate'=>date($DFMT,$t), 'amount_min'=>FormatMoney($adm,$account[I19464],$lL1IlIL,2,2,true,false), 'date'=>date($DFMT,$date), 'balance'=> $account['balance'], 'amount' => $account[I19465] .' руб.', 'payment_type_word' => $account['payment_type_word'], 'payment_num' => $account[I19466], 'note' => $account['note'] );$lILl11I =isset($member['lang']) ?$member['lang'] :I19467; $gui =&$adm->Gui; $tpl ='mail_' .$lILl11I .':'; $III1LlL =$gui->get($tpl .$type .'_subject', $III1LlI); $III1LlI['subject'] =$III1LlL; $mbody =$gui->get($tpl .I19468, $III1LlI); $III1LlI[I19465] =FormatMoney($adm,$account[I19465],$lL1IlIL,2,2,true,false); $mbody .= $gui->get($tpl .$type .'_body', $III1LlI); $mbody .= $gui->get($tpl .'footer', $III1LlI); require_once($GLOBALS["CLASSES_PATH"]."Mailer.php"); $oMail =new Mailer(); $oMail->SenderAddress =$adm->Core->GetOption(I19469); $oMail->SenderName =$adm->Core->GetOption("company_name"); $oMail->Subject =$III1LlL; $oMail->Body =$mbody; $oMail->BodyFormat ="html"; $oMail->Encoding ="UTF-8"; $oMail->Prepare(); if($GLOBALS['lL1IlI1']==I19470) {if(empty($member['email'])) {_error("Cannot get member email address for username=$account[username], userDB=$account[dbase]",'ERROR'); }else {$oMail->RecipientAddress =$member['email']; if(!$oMail->Send()) _error("sending email failed to '$oMail->RecipientAddress'"); }}if(!ModuleHostUsers::TT111Il($adm,$ILLLlIl,$account['id_user'], array(I19471=>$member['email'],'subject'=>"[BILLING: $account[domain]] $III1LlL",'body'=>$mbody,'lang'=>HOST_DOCS_LANG))) _error("sending email failed to $ILLLlIl"); }while(@ob_end_flush()); _log(I19472); $ILLLlII =&$adm->Core->GetModule('wz_host_users'); $lL1IllI =&$adm->Core->GetModule('srv_host_payments_history'); $ILLLlIl =$ILLLlII->GetOption('bill_admin_email'); $ILLLl1L =$GLOBALS["LOG_PATH"].I19473; $lL1IlI1 =$adm->VarsGet['notify_users']; $lL1IlI1 =isset($lL1IlI1) && $lL1IlI1=='no' ?'no' :I19470; if(empty($sid)) $sid =$adm->VarsGet['billing_sid']; $lL1IlL1 =$adm->VarsGet[I19463]; $lock =fopen($ILLLl1L,I19474); if(!$lock) _error("Cannot open lock file '$ILLLl1L' for writing",'FATAL'); if(!flock($lock,LOCK_EX|LOCK_NB)) _error("Billing daemon is already working",'FATAL'); $DFMT =$adm->DFMT['php']; $ILLLllL =new WZDaemonPool(); foreach($adm->Core->GetOption(I19475) as $ILLLLII){ $adm->Gui->addBlock(I19476 .$ILLLLII, $GLOBALS['LOCAL_FILES_REL_PATH'] ."_admin/templates/letters/_billing_daemon_" .$ILLLLII .".tpl"); }$words =$adm->Gui->ParseLangFile("templates/lang/billing_daemon.lng"); $now =time(); $lL1Il1I =ModuleHostPayments::TTll1TT(0, true); _log(I19477.DateTools::toMysqlDate($now)." accounts=".sizeof($lL1Il1I)); _log("User notification: $lL1IlI1"); if(!empty($lL1IlL1)) {_log("SPECIFIED domain='$lL1IlL1'"); }_log("\n\n"); $lL1IL1L =0; $lILILLI =0; while(list($lILI11l,)=each($lL1Il1I)) {$account =&$lL1Il1I[$lILI11l]; if(($account['id_node'] != 0) && ($account['id_node'] != 5) && ($account[I19478] != 6 )){continue; }if(!empty($lL1IlL1) && $account[I19463]!=$lL1IlL1) {continue; }if ($account[I19462]!='active' || $account['billing_off']){ continue; }set_time_limit(50); $lL1IL11 += 1; if($lL1IL11 <844){ continue; }$lILI1lI =$account['amount_month']; $amount =round($lILI1lI /31 *2, 2); $lL1Il1l =$account['billing_off']; $lILILLI += $amount; _log("BEGIN domain=$account[domain] billStart=".DateTools::toMysqlDate($lILlILI)); $lL1ILII =array( I19479=>$lILI11l, 'date'=>DateTools::toMysqlDate($now), 'id_contractor'=>2, I19465=>$amount, 'rest' => $amount, I19466 => 'Б13072012', I19480=>99, 'note'=>'Бонус - хостинг(аренда) 2 дня. Компенсация простоя в течение 6 часов из-за аварии в датацентре masterhost.ru' );$daz =ModuleHostPaymentsHistory::TIlITTI($lL1ILII); _log("t=".DateTools::toMysqlDate($t)." addPaymentItem($amount,$account[domain])=".DateTools::toMysqlDate($daz)); $account['balance'] =$account[I19465] += $amount; $account[I19465] =$amount; $account[I19481] ='Бонус'; $account[I19466] =$lL1ILII[I19466]; $account['note'] =$lL1ILII['note']; TITTll1($account,'payment',$now); _log(I19482); _log("END domain=$account[domain]"); }_log("TOTALS: accounts = $lL1IL11, amount = $lILILLI"); fclose($lock); _log("DONE"); ?>