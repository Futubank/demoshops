<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1625 xkqwnysgyxgwituyrizkqyitswxsyglrtsnynitmtpyrtmisprsrtsmmxiuwmmpmrwngpnir
 */ ?><?php foreach(array(18023=>"dtZtuD%?200?hk") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $member =1; $lLI111I =0; if(isset($mode)&&$mode=="small"){ $lLI111I =1; }$ActiveModule ="adv_places"; if(!$lLI111I){ require_once $GLOBALS['DEFAULT_INCLUDES_PATH'] .'init.php'; }$lLlIIII =&$frn->Core->GetModule("adv_places"); $lLlIIII->InitEngine($frn, $db); $lLlIIIl =Array( "adv_places"=>"templates/adv_places.tpl" );if($lLI111I){ if(empty($reindex)){ $NONE =Array(); $lLlIIII->Engine->Init($lLlIIIl); $lLlIIII->Engine->TTTlITl($NONE); $lLI111I =0; }else{ }}else if(isset($lLlIIIL) && $lLlIIIL){ if(empty($reindex)){ header(I18023); header("HTTP/1.0 200 OK"); $lLlIIII->Engine->Init($lLlIIIl); print $lLlIIII->Engine->procBannerAction(); exit; }}?>