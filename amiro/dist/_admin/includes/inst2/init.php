<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       64669 xkqwlsnxutztixxkwspiguxwgkwnnqktzyqpipxizlrxwktxrsmlxsutuxstslglxgskpnir
 */ ?><?php  if(!defined('AMI_ENVIRONMENT')){header(I18094);die(I18095.__FILE__.I18096.__LINE__);} mb_internal_encoding(I18097); AMI::getSingleton(I21358)->setBenchType(I21359); function TlTlTll(&$h){ $h =@$h[empty($h[I18098]) ?I18099 :I18098]; }if(!isset($ILlIlIl)) $ILlIlIl =0; if(!isset($l1lIII1)) $l1lIII1 =0; if(!isset($I11I1LI)) $I11I1LI =0; if(!isset($l1I1I1I)) $l1I1I1I =0; if(!isset($l1I1ILL)) $l1I1ILL =0; if(!isset($l1I1IL1)) $l1I1IL1 =0; if(!isset($init_filter)) $init_filter =0; $l1lI1IL =$lLILl1I; $MULTI_SITE_ID =0; require($CONST_PATH .I21363); $GLOBALS[I21364] =I21365; $GLOBALS[I18144] =I21366 .$GLOBALS[I21364] .I21367; $lLILLlI->TTlIlIl($lLILLll[I21368]); $lLlIL11 =TlTIlTI(TlTIlTl(TlTIlT1(TlTIlII(I18100)))); TlTlTll($lLlIL11); $lLlI1II =TlTIlTI($lLILl1I); TlTlTll($lLlI1II); $lLlI1Il =TlTIlTI($lLILlL1[I18100]); TlTlTll($lLlI1Il); $lLlI1IL =Array(); $lLlI1IL[I18101] =I18102; $lLlI1IL[I18103] =I18102; $lLlI1IL[I18104] =I18105; $lLlI1I1 =false; $lLILLlI->IlLIlIl[I18106] =false; $lLILLlI->IlLIlIl[I18107] =$IIlILlI; $lLILLlI->IlLIlIl[I18108] =false; $lLILLlI->IlLIlIl[I18109] =I18110; if(TlTIlIl($lLILLll[I21369], I18112) === 0){ $lLILLll[I21369] =TlTIllT($lLILLll[I21369], 4); }if($lLILLll[I21369] != I21370){ if($GLOBALS[I18113] <2){ $l1lLI1I =($lLILLlI->TTllI11() &DEFINE001) ?I21371 .TlT1III($lLILLll[I21369]) .I21372 :I18126; $lLlI1lL =I21373 .$l1lLI1I .I21374; }else {if($lLILLlI->TTllI11() &DEFINE001){ $lLlI1lL =I21375 .I21376 .I21377 .$lLILLll[I21369] .I18118; }else {$lLlI1lL =I21378; }}$lLILLI1->TT1lT1l($lLlI1lL, DBC_SYS_QUERY); if($lLILLI1->TT1lTII()){ $lLILLlI->IlLIlIl[I18119] =$lLILLI1->ILlI11l[I18120]; if(TlTIlI1($lLILLlI->IlLIlIl[I18119]) >50){ $lLlI1l1 =70; $lLlI1LI =I18121; $lLlI1Ll =I18122; $lLlI1LL =$lLILLlI->IlLIlIl[I18107]; $lLlI1L1 =$lLILLlI->IlLIlIl[I18119]; $lLlI11I =TlTIlIl($lLlI1L1, $lLlI1LI) +TlTIlI1($lLlI1LI) +3; $ePos =TlTIlIl($lLlI1L1, $lLlI1Ll); $lLlI1L1 =TlTIllT($lLlI1L1, $lLlI11I, $ePos -$lLlI11I); $lLlI11l =false; $lLlI1L1 =TlTIllI($lLlI1L1); $lLlI11L =TlTIllT(I18123, 0, 6) .TlTIllT($lLlI1LL, 6); $lLlI111 =TlTIllT($lLlI1LL, 0, 6) .TlTIllT(I18123, 6); $lLllIII =$lLlI111 .$lLlI11L; $lLlI11L =TlTIllT($lLllIII, 0, 6) .TlTIllT(I18124, 6); $lLlI111 =TlTIllT(I18124, 0, 6) .TlTIllT($lLllIII, 6); $lLllIIl =$lLlI11L .$lLlI111; $lLllIIL =TlTIlI1($lLllIIl); $lLllII1 =TlTIlll($lLllIIl); $lLllIlI =$lLllII1[3]; $lLllIll =TlTIlI1($lLlI1L1, I18125); $lLllIlL =I18126; for ($i =0; $i <$lLllIll; $i++){ $lLllIlL .= $lLlI1L1[$i] ^$lLllIIl[$i %$lLllIIL] ^$lLllIlI ^$lLllII1[1]; $lLllIlI =$lLlI1L1[$i]; }$lLllIlL =$lLILLlI->TTlIll1(@TlTIl1T($lLllIlL)); $lLllIl1 =TlTIllT($lLllIlL, 0, $lLlI1l1); $lLllILI =TlTIllT($lLllIlL, $lLlI1l1); $lLllILl =$lLllILI; $lLlI1L1 =$lLllILI; $lLllILL =I18126; $hLen =$lLlI1l1; $lLlI11L =TlTIllT(I18123, 0, 6) .TlTIllT($lLlI1LL, 6); $lLlI111 =TlTIllT($lLlI1LL, 0, 6) .TlTIllT(I18123, 6); $lLllIII =$lLlI111 .$lLlI11L; $lLllILI =$lLllIII .TlTIllT($lLlI1L1, 0, 20) .$lLllIII .TlTIllT($lLlI1L1, 20) .$lLllIII; $lLllIL1 =TlTIIlT($lLlI1L1); $ll1lLIl =TlTIlll($lLlI1L1); $ll1lLIL =TlTIll1($lLlI1L1); $lLllI1L =TlTIlI1($lLlI1L1, I18125); $lLllI11 =TlTIIlT($lLllILI); $lLlllII =TlTIlll($lLllILI); $lLlllIl =TlTIll1($lLllILI); $lLlllIL =TlTIlI1($lLllILI, I18125); $lLlllI1 =TlTIlll($lLllIL1 .$lLlllII .$ll1lLIL .$lLlllIL); $lLllllI =TlTIl1I(TlTIll1($lLllI11 .$ll1lLIl .$lLlllIl .$lLllI1L)); $lLlllll =TlTIllT($lLllllI, 0, 6) .TlTIllT($lLlllI1, 6); $lLllllL =TlTIllT($lLlllI1, 0, 6) .TlTIllT($lLllllI, 6); $lLllll1 =$lLlllll .$lLllllL; if(TlTIlI1($lLllll1) <$hLen){ $lLlllLI =I18126; for ($i =0; $i <($hLen -TlTIlI1($lLllll1)); $i++){ $lLlllLI .= $lLllll1[$i]; }$lLllll1 .= $lLlllLI; }$lLllILL =TlTIllT($lLllll1, 0, $hLen); $lLlllLl =$lLllILL; $lLllILI =$lLllILl; $lLlI11l =true; $IlLILIL =$lLllILI; $lLILLlI->IlLIlIl[I18108] =$lLILLlI->TTlIl1T($IlLILIL); if($lLILLlI->IlLIlIl[I18108][I18127][I18128] <3){ if(isset($lLILLlI->IlLIlIl[I18108][I18127][I18129])){ if(isset($lLILLlI->IlLIlIl[I18108][I18127][I18129][I18130]) && isset($lLILLlI->IlLIlIl[I18108][I18127][I18129][I18130][I18131])){ $lLILLlI->IlLIlIl[I18108][I18127][I18129][I18130][I18131] =TlTI1TI($lLILLlI->IlLIlIl[I18108][I18127][I18129][I18130][I18131], I18097, I18132); }if(isset($lLILLlI->IlLIlIl[I18108][I18127][I18129][I18133]) && isset($lLILLlI->IlLIlIl[I18108][I18127][I18129][I18130][I18131])){ $lLILLlI->IlLIlIl[I18108][I18127][I18129][I18133][I18131] =TlTI1TI($lLILLlI->IlLIlIl[I18108][I18127][I18129][I18133][I18131], I18097, I18132); }}}$lLILLlI->IlLIlIl[I18106] =$lLlI11l && is_array($lLILLlI->IlLIlIl[I18108]); unset($lLlI1l1, $lLlI1LI, $lLlI1Ll, $lLlI1LL, $lLlI1L1, $lLlI11I, $ePos, $lLlI11l, $IlLILIL, $lLlI11L, $lLlI111, $lLllIII, $lLllIIl, $lLllIIL, $lLllII1, $lLllIlI, $lLllIll, $lLllIlL, $lLllIl1, $lLllILI, $lLllILl, $lLllILL, $hLen, $lLllIL1, $ll1lLIl, $ll1lLIL, $lLllI1L, $lLllI11, $lLlllII, $lLlllIl, $lLlllIL, $lLlllI1, $lLllllI, $lLlllll, $lLllllL, $lLllll1, $lLlllLI, $lLlllLl); $lLlllLL =1; $IlLIll1 =1; $ILlLLlL =I18134; $lLlllL1 =array(); $lLlll1l =array(); TlTIl1l(I18136, $lLILLlI->IlLIlIl[I18106] && TlTIllT($lLILLlI->IlLIlIl[I18137][I18138][I18139], 0, 12) == I18140 .TlTIl1I(I18141)); if($lLILLlI->IlLIlIl[I18106]){ if(!isScanty){ $lLILLlI->TTlIllI(I18142, TlTIl1I(I18143), 0); $l1lLI1l =new gui(); $l1lLI1l->setSkinPath($GLOBALS[I18144]); $__url =TlTI1IT(); $aUrl =TlTIlTI($__url); $__url =$aUrl[I18099]; if(isset($aUrl[I21379])){ $__url .= I21380 .$aUrl[I21379]; }echo $l1lLI1l->Parse(I18146, Array(I18147 => $__url)); TlTI1lT(); }$lLlllLL =$lLILLlI->IlLIlIl[I18108][I18148]; $IlLIll1 =$lLILLlI->IlLIlIl[I18108][I18149]; $ILlLLlL =$lLILLlI->IlLIlIl[I18108][I18150][I18151]; $lLLl111 =Array(I18156 .TlTIllT(I21382, 2, 3) .TlTIl1I(I18159), TlTIl1I(I21383) .I21384 .TlTIllT(I21385, 2, 2), I18110 .TlTIl1I(I19357) .I19358 .I19359 .I18110); $lLlll1l =$lLILLlI->IlLIlIl[I18108][I18150][I18171]; $lLILLlI->IlLIlIl[I18106] =false; $lLllLIl =array(I18172, I18173, I18174); $lLllLIL =I18175; $lLllLI1 =TlTI1II(); $lLILLlI->IlLIlIl[I18106] =true; $lLlI1I1 =true; if(!$lLlI1I1){ $lLllLLl =TlTI1IT(); foreach ($lLllLIl as $IILlLl1){ if(TlTIlIl($lLllLLl, $IILlLl1) !== false){ echo $lLllLIL .$lLllLLl; TlTI1lT(); }}if(TlTIlT1($lLlIL11) == I18126){ echo $lLllLIL .$lLllLLl; TlTI1lT(); }}}else {$lLILLlI->IlLIlIl[I18109] =I18110; }}else {$lLILLlI->IlLIlIl[I18109] =I18202; }}else {$lLILLlI->IlLIlIl[I18109] =I18203; }}else {$lLILLlI->IlLIlIl[I18106] =true; trigger_error(I22997, E_USER_ERROR); }$l1lLI11 =I18126; if($lLILLlI->IlLIlIl[I18106]) {if(!($lLILLlI->TT1lTTT($lLILLlI->IlLIlIl[I18108]))){ $lLILLlI->IlLIlIl[I18106] =false; $l1lLI11 =I18204; if(isset($lLILLlI->IlLIlIl[I18108][I18148])){ $GLOBALS[I21387] =intval($lLILLlI->IlLIlIl[I18108][I18148]); }else {$lLILLlI->IlLIlIl[I18106] =false; $l1lLI11 .= I21388; }$GLOBALS[I21389] =intval($lLILLlI->IlLIlIl[I18108][I18149]); }}if($lLILLlI->IlLIlIl[I18106]){ if(IS_FIRST_START === true){ require_once $GLOBALS[I18205] .I18206; TlTl1II(); }$lLILLlI->TTlIl1I($lLlllL1); require_once $GLOBALS[I18205] .I18207; if(!$lLILLlI->TTlIlII($lLILLlI->IlLIlIl[I18108])){ $lLILLlI->IlLIlIl[I18106] =false; $l1lLI11 =I18204; }}$l1lLlIL =empty($lLILLlI->IlLIlIl[I18108][I18150][I21405]); $lLLLIl1 =false; if(TlTIl11(I19376) && isScanty){ $lLILLlI->IlLIlIl[I19377] =array( I19378 => TlTI1I1($GLOBALS[I18210] .I19366), I19379 => I19380, I19381 => I19380, I19382 => true );$lLlI1lL =I22998 .$lLILLlI->IlLIlIl[I19377][I19378] .I19384 .$lLILLlI->IlLIlIl[I19377][I19378] .I22999; $lLILLI1->TT1lT1l($lLlI1lL, DBC_SYS_QUERY); if($lLILLI1->TT1lTII()){ $aHash =TlTI1TT($lLILLI1->ILlI11l[I19386]); if(is_array($aHash)){ $lLILLlI->IlLIlIl[I19377][I19379] =$aHash[I19387]; $lLILLlI->IlLIlIl[I19377][I19381] =$aHash[I19388]; $lLILLlI->IlLIlIl[I19377][I19382] =$lLILLI1->ILlI11l[I19382] == 1; }unset($aHash); $l1lL1lI =$lLILLI1->ILlI11l[I23000]; }if($lLILLlI->IlLIlIl[I19377][I19382]){ $ll1lLIl =TlTIIlT(TlTIlll($lLILLlI->IlLIlIl[I19377][I19378]) .TlTIIlT($lLILLlI->IlLIlIl[I19377][I19378]) .I19389); $lLLLIl1 =$ll1lLIl != $lLILLlI->IlLIlIl[I19377][I19379]; }else {$lLLLIl1 =false; }if(!$lLLLIl1){ $text =I19380; $lLlI1lL =I19390; $lLILLI1->TT1lT1l($lLlI1lL, DBC_SYS_QUERY); while ($lLILLI1->TT1lTII()){ $text .= implode(I19391, $lLILLI1->ILlI11l); }$ll1lLIL =TlTIlll($text .$ll1lLIl); $lLLLIl1 =$ll1lLIL != $lLILLlI->IlLIlIl[I19377][I19381]; unset($text); }unset($ll1lLIl, $ll1lLIL); }if($lLLLIl1){ $lLILLlI->IlLIlIl[I18106] =false; $lLILLlI->IlLIlIl[I18109] =11; }if(!$lLILLlI->IlLIlIl[I18106]){ if(0 && $lLLLIl1){ $l1lLI1l =new gui(); $IILlllL =$lLILLlI->TTlITIT(I21517); $l1lLI1l->langs =array_unique($IILlllL); $l1lLI1l->ll1IlIl =$lLILLlI->TTllTlI(I21516); if(isset($_COOKIE[I21519]) && in_array($_COOKIE[I21519], $lLILLlI->TTlITIT(I21517))){ $l1lL1ll =$_COOKIE[I21519]; }else {$l1lL1ll =$lang; }$l1lLI1l->_setLang(I18255); $l1lLI1l->AddBlock(I18214, $LOCAL_FILES_REL_PATH .I18215); echo $l1lLI1l->get(I23001, $l1lL1lL); TlTI1lT(); }else {$lLllL1I =I21406 .I21407 .$ILlLLlL .I21408 .I21409 .$lLlI1IL[I18104] .I21408 .I21410 .$lLlI1IL[I18101] .I21408 .I21411 .$lLlI1IL[I18103] .I21412 .I21413; $lLllL1l =I18221 .$ILlLLlL .I18222 .$lLlI1IL[I18101] .I18223 .$lLlI1IL[I18103] .I18224 .$lLlI1IL[I18104] .I19374 .$lLILLlI->IlLIlIl[I18109] .I19375; TlTII1T($lLllL1l); $ILlLLl1 =$lLllL1I .I18225 .$l1lLI11 .I18226 .$CMS_VERSION .I18227 .TlTIlII(I18228) .I18229 .$lLILlL1[I18177] .I18230 .TlTIlII(I18178) .I18231 .$lLILLIL[0] .I18232 .$ILlLLlL .I18233 .I18234 .$lLILl1I .I18233 .I18235 .$lLILLII .I18233 .I18236 .$lLILLIl .I18237 .$lLILl11; TlTI1T1(I18238, I21414 .$lLlIL11 .I18240 .$lLILlL1[I18177] .I18230 .TlTIlII(I18178), $ILlLLl1, $lLlIL11); $IIILlL1 =I21415 .$lLILLlI->IlLIlIl[I18109]; unset($lLILLlI->IlLIlIl, $lLLl111, $lLlI1I1, $lLlI1IL); $l1lLI1l =new gui(); $l1lLI1l->setSkinPath($GLOBALS[I18144]); echo $l1lLI1l->Parse(I18146, Array(I18147 => $IIILlL1)); TlTI1lT(); }}$lLILLlI->TTlT11l(I21416, empty($l1IIllL) ?true :false); $adm =new Admin($lLILLlI); $lLILLlI->IlLIIII->TT1TIlI($lLILLlI->TTllTll(I18251)); $adm->IIIlLLl =$lLlll1l[I18252]; $adm->Gui->addMeta(I18253, TlTI1Tl($lLlll1l[I18254][I18255]), $lLlll1l[I18254][I18255][TlTI1Tl($lLlll1l[I18254][I18255])], I18255); $adm->Gui->addMeta(I18253, TlTI1Tl($lLlll1l[I18254][I18256]), $lLlll1l[I18254][I18256][TlTI1Tl($lLlll1l[I18254][I18256])], I18256); $I1ll1lI =$lLlll1l[I18257]; $lLILlLI =I18126; $lLILlLl =I18126; $lLILlLL =I18126; if(!empty($lLlll1l[I19337][I19338])) $lLILlLI =$lLlll1l[I19337][I19338]; if(!empty($lLlll1l[I19337][I18253])) $lLILlLL =$lLlll1l[I19337][I18253]; if(!empty($lLlll1l[I19337][I19340])) $lLILlLl =$lLlll1l[I19337][I19340]; $lllIIIL =TlTIlll($lLILl1I .$lLILLlI->IlLIlIl[I18108][I18150][I18258] .$lLILLlI->IlLIlIl[I18108][I18150][I18259]); $lLLLIlL =$lLILLlI->IlLIlIl[I21386]; if(TlTIl11(I19376) && isScanty){ $lLLLIlL =$l1lL1lI; }$l1lLlI1 =$lLlll1l[I18252]; $lLILLlI->TTlIl1l(); unset($lLLLIl1, $lLLl111, $lLlll11, $lLlI1I1, $lLlI1IL, $lLlll1l); if(!$ENABLE_BUFFERING){ $CONNECT_OPTIONS[I21417] =0; }if(!empty($lLI1lLL)){ unset($lLI1lLL); $Core->TTllT11(); }$conn =new Connector($lLILLlI->IlLIIII, $CONNECT_OPTIONS[I21417], $ENABLE_BUFFERING); $conn->AddHeader(I21418); $vGlobVars[I21419] =$lllIIIL; require_once $GLOBALS[I18241] .I21420; $cms =&$adm; $adm->AdminPathWWW =$ADMIN_PATH_WWW; $adm->PrepareVars(); $oServerCookie =AMI::getSingleton(I21421); if($oServerCookie->get(I21422, FALSE) === FALSE){ $oServerCookie->set(I21422, 6, time() +AMI_ServerCookie::LIFETIME_YEAR, I21367); $oServerCookie->save(); }$GLOBALS[I21364] =$oServerCookie->get(I21423, $GLOBALS[I21364]); if($GLOBALS[I21364] == I21424){ $GLOBALS[I21364] =I21365; SetLocalCookie(I21423, I21365, TlTI1II() +31536000 *10, $ILlII1l); }$GLOBALS[I18144] =I21366 .$GLOBALS[I21364] .I21367; $adm->Gui->setSkinPath($GLOBALS[I18144]); $adm->Gui->addScript(I21425); $adm->Gui->addScript($GLOBALS[I18144] .I21426); AMI_Registry::set( I21427, I21428 .mb_substr(md5($adm->Core->TTlI1TT(I21429 .I21430, I21431 .I21432)), 0, 10) );$adm->constructorPostActions(); $Il11lIL =array(); $Il11lIL[I21433] =$lLILlLI; $Il11lIL[I21434] =$lLILlLl; $Il11lIL[I21435] =$lLILlLL; $Il11lIL[I18113] =isset($GLOBALS[I18113]) ?$GLOBALS[I18113] :1; $adm->Gui->addGlobalVars($Il11lIL); $adm->DirectScripts =array(I21436, I21437, I21438, I21439, I21440, I21441, I21442, I21443, I21444, I21445, I21446, I21447, I21448, I21449, I21450, I21451, I21452, I21453, I21454, I21455, I21456, I21457, I21458, I21459, I21460, I21461, I21462, I21463, I21464, I21465, I21466, I21467, I21468, I21469, I21470, I21468, I21471, I21472, I21473, I21474 );$adm->Gui->DelDebug(I21475); if($sys[I21476][I21477] >0){ $adm->Gui->setDebug(I21478); }if(!$ILlIlIl){ $adm->Core->TTllT1T(); $adm->Core->TTllT1T(I18126, I21479); $adm->Core->IlLIIII->TT1TlIT($adm->TTITlI1()); $l1lLllI =$adm->Core->IsSysUser() ?I19380 :array_sum($adm->Core->TTllI1l(I21480));; $adm->Gui->addHtmlScript(I21481 .$l1lLllI .I21482); unset($l1lLllI); }if( (empty($GLOBALS[I21483][I21484]) || defined(I21485) )&& file_exists($lLILl1L .I21486) ){@include_once($lLILl1L .I21487); }if(function_exists(I21488)){ EventInitBefore($adm); }$ILIl1IL =array(I21489 => $adm); AMI_Event::fire(I21490, $ILIl1IL, AMI_Event::MOD_ANY); unset($ILIl1IL); if(!$adm->Core->IsSysUser() && !$adm->TTITl1l()){ trigger_error(I21491, E_USER_ERROR); TlTI1lI(); }$adm->Pager->lllL11L =$adm->Core->TTllTlI(I21492); $adm->Pager->ShowPageSizeBox =true; unset($lang); $adm->ActivePage =get_script_name(); if($adm->ActivePage == I21493){ $l1lLlll =true; $adm->ActivePage =$adm->Vars[I21494]; if(!$adm->ActivePage){ $oSess =admSession(); $oSess->Location(I21438); }}$adm->ActiveScript =$adm->ActivePage .I21495; if(!empty($lLIlIIl) && $adm->Core->IsOwnerInstalled($lLIlIIl)){ $adm->ActiveOwner =$lLIlIIl; }else {if(empty($l1IllLL)){ $adm->ActiveOwner =$adm->Core->TTllTII(); }else {$optionSource =$adm->ActivePage; if(!empty($l1lLlll)){ $oQuery =DB_Query::getSnippet( I21496 .I21497 )->q($adm->ActivePage); $pluginId =AMI::getSingleton(I21498)->fetchValue($oQuery); if($pluginId){ $optionSource =$pluginId =CMS_InstallablePlugin::GetPluginName($pluginId); }unset($oQuery, $pluginId, $l1lLlll); }if($adm->Core->issetModOption($optionSource, I21499)){ $l1lLllL =$adm->Core->GetModOption($optionSource, I21499); $adm->ActiveOwner =$adm->Core->IsOwnerInstalled($l1lLllL[I21500]) ?$l1lLllL[I21500] :$adm->Core->TTllTII(); }else {$oDeclarator =AMI_ModDeclarator::getInstance(); $adm->ActiveOwner =$oDeclarator->isRegistered($optionSource) ?$oDeclarator->getSection($optionSource) :I21501; unset($oDeclarator); }unset($l1lLllL, $l1IllLL, $optionSource); }}$adm->ActiveModule =$adm->Core->TTlI1lI($adm->ActiveScript); $l1lLll1 =($adm->ActiveModule === false); if($l1lLll1){ $adm->ActiveModule =I18102; }else {$adm->ActiveModule =$adm->ActiveModule->GetName(); }$adm->TTITT1l($adm->ActiveModule); $adm->Module =&$adm->Core->TTlI1lT($adm->ActiveModule); $adm->Owner =$adm->Module->GetOwnerName(); if(!(isset($adm->Vars[I21502]))) $adm->Vars[I21502] =I21503; if($adm->Vars[I21502] == I21504){ unset($adm->Vars[I21505]); }if(empty($adm->Vars[I21506])) $adm->Vars[I21506] =0; if(!(isset($adm->Vars[I21507]))) $adm->Vars[I21507] =-1; if(!(isset($adm->Vars[I21508]))) $adm->Vars[I21508] =0; if(!isset($adm->Vars[I21505])) $adm->Vars[I21505] =0; if(empty($adm->Vars[I21509]) && $oServerCookie->get(I21510)){ $adm->Vars[I21509] =$oServerCookie->get(I21510); }if(empty($adm->Vars[I21509]) && isset($_COOKIE[I21511])){ $adm->Vars[I21509] =$_COOKIE[I21511]; }if(empty($adm->Vars[I21512]) && $oServerCookie->get(I21513)){ $adm->Vars[I21512] =$oServerCookie->get(I21513); }if(empty($adm->Vars[I21509]) || !in_array($adm->Vars[I21509], $adm->Core->TTlITIT(I21514))) $adm->Vars[I21509] =$adm->Core->TTllTlI(I21515); if(empty($adm->Vars[I21512]) || !$adm->Core->TTllTlI(I21516) || !in_array($adm->Vars[I21512], $adm->Core->TTlITIT(I21517))) $adm->Vars[I21512] =$adm->Core->TTllTlI(I21518); $adm->TTITll1($adm->Vars[I21509], $adm->Vars[I21512]); $lang =$adm->Vars[I21509]; $lang_data =$adm->Vars[I21512]; SetLocalCookie(I21509, $lang, time() +3600 *24 *365, I19380); SetLocalCookie(I21519, $lang, time() +3600 *24 *365, I19380, true); SetLocalCookie(I21512, $lang_data, time() +3600 *24 *365, I19380); if(!$l1lLll1){ $adm->Module->InitPager($adm->Pager); if(isset($adm->Vars[I21520]) && $adm->Module->TTlT1IT($adm->Vars[I21520])){ $adm->Pager->SortCol =$adm->Vars[I21520]; }if(isset($adm->Vars[I21521])){ $adm->Pager->SortDim =($adm->Vars[I21521] == I21522) ?I21522 :I21523; }}$adm->setLang($lang); $adm->lang_data =$lang_data; $adm->Gui->lang_data =$lang_data; $adm->Core->IlLIIII->SetLang($lang_data); $adm->Pager->Icons[I21524] =$adm->Gui->getAbs(I21525, I18126); $l1Il1Ll[I21509] =$adm->lang; AMI_Registry::set(I21510, $lang); AMI_Registry::set(I21513, $lang_data); $adm->Gui->addHtmlScript(I21526 .$CMS_VERSION .I21482); $adm->Gui->addHtmlScript(I21527 .$adm->lang .I21482); $adm->Gui->addHtmlScript(I21528 .$GLOBALS[I21364] .I21482); $adm->Gui->addHtmlScript(I21529 .$adm->DFMT[I21530] .I21482); $adm->Gui->addHtmlScript(I21531 .$lLILl1I .I21482); $adm->Gui->addHtmlScript(I21532 .$ADMIN_PATH_WWW .$GLOBALS[I18144] .I21533); $adm->Gui->addHtmlScript(I21534 .$ADMIN_PATH_WWW .$GLOBALS[I18144] .I21535); $adm->Gui->addHtmlScript(I21536 .$lLILl1I .$lLILl1l .I21537); $adm->Gui->addHtmlScript(I21538 .$lLILl1I .$lLILl1l .I21539); $adm->Gui->addHtmlScript(I21540 .$ADMIN_PATH_WWW .I21482); $adm->Gui->addHtmlScript(I21541 .$ADMIN_PATH_WWW .$GLOBALS[I18144] .I21542); $adm->Gui->addHtmlScript(I21543 .$ADMIN_PATH_WWW .$GLOBALS[I18144] .I21544); $adm->Gui->addHtmlScript(I21545 .$ADMIN_PATH_WWW .I21546); $adm->Gui->addHtmlScript(I21547 .$lang_data .I21482); $adm->Gui->addHtmlScript(I21548 .(($cms->Core->TTllTlI(I21516)) ?I21549 :I21550) .I21551); $adm->Gui->addHtmlScript(I21552 .(($cms->Core->TTllTlI(I21553)) ?I21549 :I21550) .I21551); if(!$oServerCookie->get(I21554, false)){ $l1lLlLI =array(); $oQuery =DB_Query::getSnippet(I21555)->q(I21556)->q(I21556); $oDB =AMI::getSingleton(I21498); $rs =$oDB->select($oQuery); foreach($rs as $aRecord){ $lII1I11 =unserialize($aRecord[I21557]); $l1lLlLI[I21558 .$aRecord[I21559]] =array( I21559 => $aRecord[I21559], I21560 => $aRecord[I18139], I18139 => isset($lII1I11[I21561]) ?$lII1I11[I21561] :I19380, I21562 => isset($lII1I11[I21563]) ?$lII1I11[I21563] :I19380, I21564 => isset($lII1I11[I21564]) ?$lII1I11[I21564] :I19380 );}$adm->Gui->addHtmlScript(I21565 .json_encode($l1lLlLI) .I21566); }$l1lLlLl =TlTIlTI($lLILl1I); $l1lLlLl =$l1lLlLl[I18101]; $adm->Gui->addHtmlScript(I21567 .$l1lLlLl .I21482); if(isset($sys[I21568][I21569]) && $sys[I21568][I21569] >1 && !empty($sys[I21568][I21570])){ $adm->Gui->addHtmlScript(I21571); }$adm->Gui->addMeta(I21572, I21573, I21574); $rv =$lLILLlI->TTllI1l(I21575) .I21576 .(int) $oServerCookie->get(I21422, 0); $adm->Gui->addGlobalVars(array(I21577 => $rv)); $adm->Gui->addScript(I21578 .I21579 .$GLOBALS[I21364] .I21580 .$rv .I21581 .$lang_data); $l1lLlLL =isset($GLOBALS[I21582][I21583][I21584]) && $GLOBALS[I21582][I21583][I21584]; $l1lLlL1 =isset($GLOBALS[I21582][I21583][I21584]) && !$GLOBALS[I21582][I21583][I21584]; if((($lLILLll[I21585] == I21586) && !$l1lLlL1) || $l1lLlLL){ $adm->Gui->addScript($GLOBALS[I18144] .I21587); }if($lLILLlI->IssetOption(I21588)) {$list =$lLILLlI->GetOption(I21588); foreach($list as $path) {$adm->Gui->addStyle($path); }unset($list); }$adm->Gui->addStyle(I21589); $adm->Gui->addStyle(I21590); $adm->Gui->setTitle($l1lLlI1 .I21591 .$l1lLlLl); $l1lLl1I =in_array($adm->ActiveScript, $adm->DirectScripts); if(!$l1lLl1I && (!$adm->Module->TTlIIT1() || ($adm->Module->TTlIIT1() && $l1lLll1))){ trigger_error(I21592 .$adm->ActiveModule .I21593 .$adm->ActiveScript, E_USER_WARNING); $lLLllLI =$adm->Gui->ParseLangFile(I21594); TlTI1lI($lLLllLI[I21595]); }unset($l1lLl1I); if($adm->ActiveModule == I21596) $adm->Gui->addHtmlScript(I21597); else $adm->Gui->addHtmlScript(I21598); $adm->InitMessages($adm->Gui->ParseLangFile(I21599), true); $adm->Core->TTllI1I($lang_data, true); $l1lLl1l =$adm->Core->IlLIII1; $adm->Gui->setTitle($l1lLlI1 .I21600 .$l1lLlLl .I21601 .$lLILLll[I21602]); if(!$adm->Core->IsSysUser() && !$l1lLl1l[I21603] && DAEMON_LOGIN_OK !== true){ trigger_error(I21604 .$adm->Core->GetUserId() .I21605, E_USER_WARNING); TlTI1lI(I21606); }$adm->Gui->addHtmlScript(I21607 .$rv .I21482); $adm->Gui->addHtmlScript(I21608 .$adm->ActiveModule .I21482); $adm->Gui->addScript(I21609 .$adm->lang .I21610 .$lLILLlI->TTllTlI(I21516) .I21611 .$GLOBALS[I21364] .I21612 .$adm->lang_data .I21613 .$rv .I21614 .TlTIllT(TlTIlll($lLILLlI->TTlI1TT(I21615, I21616)), 0, 10)); unset($rv); if(!$ILlIlIl || $l1lIII1){ if($adm->Core->TTllI11() &DEFINE001){ $oSess =admSession(); $l1lLl1L =($oSess->loginType() == I21617) && ($oSess->Data[I21618][I21619][I21620] != I21621 || $oSess->Data[I21618][I21619][I19345] != I21621); if($l1lLl1L){ if(in_array($adm->ActiveScript, $adm->DirectScripts)){ }else if($adm->Module->IssetProperty(I21622)){ }else {$oSess->Location(I21438); }}}$tree =&Tree::getInstance($adm); $tree->TI11T1l($adm->Core); $adm->MenuOwnersAll =$adm->GetOwnersCustomLang(I21623); $adm->Core->OwnersAllSetOption(I21624, $adm->MenuOwnersAll); $adm->MenuItemsAll =$adm->GetOwnersCustomLang(I21625); $adm->Core->OwnersAllSetOption(I21626, $adm->MenuItemsAll); $aMenuCaptions =$adm->Gui->ParseLangFile(I21627 .$adm->ActiveOwner .I21628) +$adm->MenuItemsAll; $adm->Core->ModAllSetOption(I21626, $aMenuCaptions); $adm->Core->ModAllSetOption(I21629, $adm->Gui->ParseLangFile(I21627 .$adm->ActiveOwner .I21630) +$aMenuCaptions); unset($aMenuCaptions); $adm->Core->ModAllSetOption(I21631, $adm->GetOwnersCustomLang(I21632)); $adm->Words =$adm->Gui->ParseLangFile(I21633); $adm->Gui->addHtmlScript(I21634 .jparse($adm->Words[I21635]) .I21482); }$oSess =admSession(); if(!$oSess->GetUserInfo(I21636)){ $aUser =$oSess->GetUserInfo(); if(I21637 .I21638 == call_user_func(array(I21639 .I21640, I21641 .I21642))){ unset($aUser[I21643]); }CMS_Member::TTI11Tl($aUser); $oSess->SetVar(I21618, $aUser, TRUE); unset($aUser); }unset($oSess); if($ILlIlIl){ if(!empty($l1lII1I)){ if($adm->Core->TTlIIT1(I21644) && $adm->Core->issetModOption(I18243, I21645) && $adm->Core->TTlI1TT(I18243, I21645)){ $rows =Array(); $id_site =intval($adm->Vars[I21646]); if($id_site){ $lLlI1lL =I21647 .$id_site .I21648; $lLILLI1->TT1lT1l($lLlI1lL); if($lLILLI1->TT1lTII()){ $l1lI1IL =I21649 .TlTIlIT($lLILLI1->ILlI11l[I21650], I21651) .I21651; $MULTI_SITE_ID =$id_site; }$l1Il1Ll[I21652] =$adm->Gui->get(I21653, $rows); if($id_site >= 0){ $adm->Vars[I21646] =0; }}$adm->Vars[I21646] =$MULTI_SITE_ID; SetLocalCookie(I21646, $adm->Vars[I21646], I21654, $ILlII1l, true); }}}else {$adm->helpModule =&$adm->Core->TTlI1lT(I21655); $adm->Gui->addBlock(I21656, I21657); $adm->Gui->addBlock(I21658, I21659); if($adm->helpModule->TTlIIT1() && ($adm->Owner != I22980 && $adm->Module->issetProperty(I21660) && $adm->Module->GetProperty(I21660) )){$adm->Gui->addBlock(I21661, I21662); $footer[I21663] =$adm->Gui->getAbs(I21661); $l1Il1Ll[I21664] =$adm->Gui->getAbs(I21665, I18126); }$l1lLl11 =$adm->Core->TTlI1lT(I21666); if($l1lLl11->TTlIIT1()){ $adm->Gui->addHtmlScript(I21667 .(($l1lLl11->GetOption(I21668) == true) ?I21669 :I21670) .I21551); $adm->Gui->addHtmlScript(I21671 .$l1lLl11->GetOption(I21672) .I21673); }if($I11I1LI){ $adm->Gui->addBlock(I21674, I21675); }else {$adm->Gui->addBlock(I21674, I21676); }if($adm->Core->OwnerGetData($adm->ActiveOwner, I21677) === true){ $html[I21678] =$adm->Gui->getAbs(I21679); }else {$html[I21678] =$adm->Gui->getAbs(I21680); }$lLLllll =I21681 .$lang_data; $lLLlllL[$lLLllll] =I21682; $l1Il1Ll[I21683] =$adm->Module->GetOption(I21631); if(is_array($l1Il1Ll[I21683]) && $l1Il1Ll[I21683][$lang]){ $l1Il1Ll[I21683] =$l1Il1Ll[I21683][$lang]; }$moduleName =$adm->Module->Name; if(AMI_ModDeclarator::getInstance()->isRegistered($moduleName)){ $aModCaptions =AMI_Service_Adm::getModulesCaptions(array($moduleName), TRUE, array(), TRUE); $l1Il1Ll[I21683] =$aModCaptions[$moduleName]; }else{ $l1Il1Ll[I21683] =$adm->TTTTlI1($l1Il1Ll[I21683]); }if(isset($adm->Vars[I21684])){ $l1Il1Ll[I21685] .= I21686; }if($adm->Core->TTllTlI(I21516) && ($adm->ActivePage != I21687)){ $l1IlI1I =$adm->Core->TTlITIT(I21517); $lLLlllL[I21688] =I18126; foreach ($l1IlI1I as $l1lLLII){ $IILIl11 =array(I21689 => ($l1lLLII == $lang_data) ?I21682 :I18126, I21690 => $l1lLLII, I21691 => $adm->TTITl1T($l1lLLII)) +$lLLlllL; $lLLlllL[I21688] .= $adm->Gui->get(I21692, $IILIl11); }if(isset($adm->Vars[I21494])) $lLLlllL[I21693] =$adm->Vars[I21494]; $l1Il1Ll[I21694] =$adm->Gui->get(I21695, $lLLlllL); }if($adm->Core->TTlIIT1(I21644) && $adm->Module->issetOption(I21645) && $adm->Module->GetOption(I21645)){ $rows =Array(); $id_site =$adm->Vars[I21646]; $MULTI_SITE_ID =$id_site; $lLlI1lL =I21696; $lLILLI1->TT1lT1l($lLlI1lL); while ($lLILLI1->TT1lTII()){ $IILIl1L =($lLILLI1->ILlI11l[I21505] == $id_site); if($IILIl1L){ $id_site =-$id_site; $l1lI1IL =I21649 .TlTIlIT($lLILLI1->ILlI11l[I21650], I21651) .I21651; }$IILIl11 =array(I21689 => $IILIl1L ?I21682 :I18126, I21505 => $lLILLI1->ILlI11l[I21505], I18253 => $lLILLI1->ILlI11l[I18253]); $rows[I21688] .= $adm->Gui->get(I21697, $IILIl11); }$l1Il1Ll[I21652] =$adm->Gui->get(I21653, $rows); if($id_site >= 0){ $adm->Vars[I21646] =0; }}else {$adm->Vars[I21646] =0; }SetLocalCookie(I21646, $adm->Vars[I21646], I21654, $ILlII1l, true); if(isset($lLILLll[I21698]) && $lLILLll[I21698]){ $l1Il1Ll[I21699] =$adm->Gui->getAbs(I21700); $l1lLLIl =$lLILLll[I21369]; if($l1lLLIl == I18111){ $l1lLLIl =$l1lLlLl; }$l1llIL1 =I19380; unset($l1lLLIL); $l1llI1I =call_user_func(I21701 .I21702); if( call_user_func( array($l1llI1I, I21703 .I21704), I21643 )){$IlLlLII =call_user_func( array(I21639 .I21640, I21705 .I21706), $adm->Module->Name );if(in_array(I21707, $IlLlLII[I21708])){ $lLLLIII =call_user_func( array($l1llI1I, I21709 .I21710), I21711 );$l1llIL1 =I21712 .I21713 .I21714 .call_user_func( I21715 .I21716, mb_strlen($lLLLIII) .$lLLLIII .$l1llI1I->TlIT11l() ).I21717 .$lang_data; $l1lLLIL =$l1llIL1; if( TRUE !== IS_FIRST_START && I21586 == $lLILLll[I21718] && empty($l1llI1I->Data[I21719]) ){$l1lLLI1 =$l1llI1I->TlIT11l(); $l1lLLlI =new CMS_Session($adm, I19380); $l1lLLlI->Start(); $l1lLLlI->SetVar( I21618, array(I21720 => $l1llI1I->Data[I21618][I21720]) );$l1lLLlI->SetVar(I21711, $lLLLIII); $l1lLLlI->Store(); if($l1lLLI1 != $l1lLLlI->sid){ $_sql =I21721 .I21722 .$l1lLLI1 .I21648; $lLILLI1->TT1lT1l($_sql); $_sql =I21723 .I21724 .$l1lLLI1 .I21725 .I21722 .$l1lLLlI->sid .I21648; $lLILLI1->TT1lT1l($_sql); }$l1llI1I->SetVar(I21719, TRUE, TRUE); unset($l1lLLI1, $l1lLLlI); }unset($IlLlLII, $lLLLIII); }}unset($l1llI1I); if(I19380 != $l1llIL1 && $adm->Core->TTllTlI(I21726)){ $l1llIL1 .= I21727 .rawurlencode($lang_data .I21367); }$l1Il1Ll[I21728] =$lLILl1I .$l1llIL1; $l1Il1Ll[I18252] =$adm->Gui->getAbs(I21729, array(I21730 => $l1lLLIl, I21731 => $lLILLll[I21602], I21728 => $lLILl1I .$l1llIL1)); }if(empty($l1I1I1l)){ $l1Il1Ll[I21732] =$adm->Gui->getAbs(I21733); }$IIlI1LL =array(I21742, I22981, I21743, I22982, I21744, I22983, I22984); if( ($adm->ActiveModule != I21734) ){$aOptions =array(); $_mt =time(); if(CMS_ModulesOptions::TTlTllT($db, $aOptions, $adm->ActiveModule, I21735)){ $_mt =strtotime($aOptions[I21736]); }$l1Il1Ll[I21737] =$adm->Gui->getAbs( I21738, array( I21739 => $adm->ActiveOwner, I21740 => $adm->ActiveModule, I21741 => $_mt ));}if($adm->ActiveModule == I21734){ $_mt =time(); if(CMS_ModulesOptions::TTlTllT($db, $aOptions, $adm->ActiveModule, I21735)){ $_mt =strtotime($aOptions[I21736]); }$l1Il1Ll[I21737] =$adm->Gui->getAbs( I21738, array( I21739 => $adm->ActiveOwner, I21740 => $adm->ActiveModule, I21741 => $_mt ));}$IIlI1LL =array(I21742, I21743, I21744); $l1lLLll =array(I21745, I21746, I21747, I21748, I21749, I21750); if(($adm->ActiveModule != I21751) && ($adm->ActiveOwner != I21752 || in_array($adm->ActiveModule, $IIlI1LL)) && !in_array($adm->ActiveModule, $l1lLLll)){ $l1lLLlL =(int) $oServerCookie->get(I21422, 0) === 6; $l1Il1Ll[I21753] =$adm->Gui->getAbs(I21754, Array(I21755 => $adm->ActiveModule, I21756 => $adm->ActiveOwner, I21757 => $l1lLLlL)); }if($adm->ActiveModule == I21751){ $l1lLLlL =(int) $oServerCookie->get(I21422, 0) === 6; $l1Il1Ll[I21753] =$adm->Gui->getAbs(I21754, Array(I21755 => I19380, I21756 => I19380, I21757 => $l1lLLlL)); }unset($IIlI1LL, $l1lLLl1, $l1lLLll); $l1lLLLI =I21758; $l1lLLLl =I21759; $l1Il1Ll[I21760] =I18126; if($l1lLlIL){ $l1Il1Ll[I21760] =$adm->Gui->getAbs(I21761, I18126); }if($lLLLIlL != I18126 && $lLLLIlL <= TlTI1Il($l1lLLLI)){ if($lLLLIlL <= TlTI1Il($l1lLLLl)){ $l1Il1Ll[I21760] .= $adm->Gui->getAbs(I21762, array(I21763 => TlTIlTT($adm->DFMT[I21764], $lLLLIlL))); }else {$l1Il1Ll[I21760] .= $adm->Gui->getAbs(I21765, array(I21763 => TlTIlTT($adm->DFMT[I21764], $lLLLIlL))); }}$l1lLLLL =I18126; if($l1I1I1I || $I11I1LI){ $html[I21766] =$adm->Gui->getAbs(I21658, I18126); }else {$adm->Gui->addBlock(I21767, I21768); $adm->Gui->addBlock(I21769, I21770); $l1lLLL1 =Array(I21674 => I18126); if($adm->Module->IsFrontAllowed() && !$adm->Module->IssetAndTrueProperty(I21771) || $adm->ActiveModule == I18243){ if($adm->Module->IsPresentInPM() || $adm->ActiveModule == I18243){ $l1llIL1 =$adm->Module->GetFrontLink( isset($adm->Vars[I21772]) ?intval($adm->Vars[I21773]) :0 );if(isset($l1lLLIL)){ $l1llIL1 =$l1lLLIL .I21727 .rawurlencode($l1llIL1); }$l1llIL1 =array( I21774 => $lLILl1I .(I21775 != $adm->ActiveModule ?$l1llIL1 :$adm->Module->GetFrontLink() ));if($adm->ActiveModule != I18243 && $adm->Module->IsPresentInPM() && ($adm->Module->GetOption(I21776) >0)){ $l1lLLLL =$adm->PManager->GetAdminLink(false); $aLink =array(I21505 => $adm->Module->GetOption(I21776)); TlT1IT1($l1lLLLL, $aLink); $l1llIL1[I21777] =$l1lLLLL; $l1Il1Ll[I21778] =$l1lLLLL; $l1lLLL1[I21674] .= $adm->Gui->get(I21779, $l1llIL1); }if($adm->ActiveModule == I18243 || $adm->Module->IsPresentInPMandPublic()){ $l1lLLL1[I21674] .= $adm->Gui->get(I21780, $l1llIL1); }else {$l1lLLL1[I21674] .= $adm->Gui->get(I21781, $l1llIL1); }}else {$aLink =array(I21502 => I21782, I21755 => $adm->ActiveModule); $l1llIL1 =array(I21783 => $adm->PManager->GetAdminLink()); TlT1IT1($l1llIL1[I21783], $aLink); $l1lLLL1[I21674] .= $adm->Gui->get(I21784, $l1llIL1); }$l1Il1Ll[I21774] =$l1llIL1[I21774]; }else {}EventApplyVars($adm, I21785, $l1lLLL1); $l1lLL1I =$adm->Gui->get(I21769, $l1lLLL1); if(TlTIlT1($l1lLL1I) != I18126){ $html[I21766] =$adm->Gui->getAbs(I21767, Array(I21786 => $l1lLL1I)); }}$adm->Gui->addBlock(I21787, I21788); $vOwners =&$adm->Core->GetOwnersList(); if(!$l1I1ILL && !$I11I1LI){ $l1lLL1l =Array(I21789 => I18126); foreach ($vOwners as $vName => $vData){ if($adm->Core->IsOwnerInstalled($vName)){ $lllILLL =array(); $lllILLL[I21790] =$vName; $lllILLL[I21791] =$vData[I21624]; $l1lLL1L =100000; $l1lLL11 =I19380; foreach ($adm->Core->GetModulesByOwner($vName) as $oModule){ if($oModule->Ill1I1I) continue; $l1lL1II =$oModule->GetProperty(I21792, 0); if(isset($l1lL1II) && $l1lL1II <$l1lLL1L){ $l1lLL11 =$oModule->Name; $l1lLL1L =$l1lL1II; }}if($l1lLL11){ $vMod =&$adm->Core->GetModule($l1lLL11); $vData[I21793] =$vMod->GetAdminLink(); }if(isset($vData[I21793])){ $lllILLL[I21794] =$vData[I21793]; }elseif(isset($vData[I21795])){ $vMod =&$adm->Core->GetModule($vData[I21795]); $lllILLL[I21794] =$vMod->GetAdminLink(); }if(empty($lllILLL[I21794])){ continue; }if($vName == $adm->ActiveOwner){ $l1lLL1l[I21789] .= $adm->Gui->get(I21796, $lllILLL); }else {$l1lLL1l[I21789] .= $adm->Gui->get(I21797, $lllILLL); }}}EventApplyVars($adm, I21798, $l1lLL1l); $html[I21787] =$adm->Gui->get(I21787, $l1lLL1l); }$adm->fillModulesSelect(); if($I11I1LI || $l1I1IL1){ $l1Il1Ll[I21799] =$adm->Gui->getAbs(I21658, I18126); }else {$aMenu =$adm->TTTTllT(); $adm->Gui->addBlock(I21799, I21800); $l1lL1Il[I21789] =I18126; $IlLIlL1 =call_user_func(array(I21801 .I21802, I21803 .I21804)); foreach ($aMenu as $aItem){ if($aItem[I18246] == I21805){ $l1lL1Il[I21789] .= $adm->Gui->getAbs(I21806, I18126); continue; }$level =($aItem[I21807] >1) ?I21808 :I21809; $style =I21810; if($aItem[I21689]){ $style =I21689; }if($aItem[I21811] && $aItem[I21807] <= 1){ $style =I21811; }$aItem[I21812] =I19380; $IlLIl1L =$aItem[I21813]; if( call_user_func(array($IlLIlL1, I21814 .I21815), $IlLIl1L) && (I21816 .I21817) === call_user_func(array($IlLIlL1, I21818 .I21819), $IlLIl1L, I21820 .I21821, FALSE) && !$adm->Core->TTlI1TT( call_user_func(array($IlLIlL1, I21822 .I21823), $IlLIl1L), I21824 )){$aItem[I21812] =I21825; }if($aItem[I21812]){ $aItem[I21826] =I21827 .$adm->MenuItemsAll[I21828] .I21829; }if(I21830 === $IlLIl1L || I21831 === mb_substr($IlLIl1L, 0, 7)){ $aItem[I21812] =I21825; }$l1lL1Il[I21789] .= $adm->Gui->get(I21832 .$style .I21833 .$level, $aItem); }unset($IlLIlL1, $IlLIl1L); EventApplyVars($adm, I21834, $l1lL1Il); $html[I21799] =$adm->Gui->get(I21799, $l1lL1Il); }if(isset($CONFIG_INI[I21583]) && !empty($CONFIG_INI[I21583][I21835])){ $l1Il1Ll[I21835] =I21836 .phpversion(); }$l1Il1Ll[I21837] =$CMS_VERSION; $l1Il1Ll[I21838] =$lLI1Ll1; $l1Il1Ll[I21839] =$lLI1LLI; $l1Il1Ll[I21755] =$adm->ActiveModule; $l1Il1Ll[I21840] =$adm->Core->TTlIIT1(I21841); $l1Il1Ll[I21842] =$adm->Core->IsSysUser() ?I21843 :I19380; $ILlI1ll =I21844 .I21845; $adm->Gui->$ILlI1ll =call_user_func(array(I19342 .I21846, I21847 .I21848)); $l1Il1Ll[$ILlI1ll] =$adm->Gui->$ILlI1ll; unset($ILlI1ll); $html[I21656] =$adm->Gui->get(I21656, $l1Il1Ll); $l1lL1IL =I18126; }if(!$ILlIlIl || $init_filter){ $adm->Filter =new Filter($adm); $adm->Filter->TITIl1T($adm->Vars[I21508]); $adm->Filter->SetDateFormat($adm->DFMT); $adm->Filter->SetCaptions($adm->Gui->ParseLangFile(I21849)); $adm->Filter->SetMessages($adm->Gui->ParseLangFile(I21850)); if(!isset($adm->Vars[I21851]) && !isset($adm->Vars[I21852])) $adm->Filter->TITIl1I(); $adm->Vars[I21853] =$adm->Filter->AddField(I21851, I21854, empty($adm->Vars[I21855]) ?null :$adm->Vars[I21855], $GLOBALS[I21856], I21857, I21854, I21858); $adm->Vars[I21851] =TlTIlTT($adm->DFMT[I21764], $adm->Vars[I21853]); $adm->Vars[I21859] =$adm->Filter->AddField(I21852, I21854, empty($adm->Vars[I21860]) ?null :$adm->Vars[I21860], $GLOBALS[I21861], I21862, I21854, I21863); $adm->Vars[I21852] =TlTIlTT($adm->DFMT[I21764], $adm->Vars[I21859]); $adm->Filter->TITIl1l(); $adm->Filter->AddField(I21864, I21864); $adm->Filter->AddField(I21520, I21865, $adm->Pager->SortCol); $adm->Filter->AddField(I21521, I21865, $adm->Pager->SortDim); $adm->Filter->AddField(I21506, I21865, $adm->Vars[I21506]); $adm->Filter->TITI1I1(array(I21851 => I21866, I21852 => I21867)); $adm->Pager->InitPager($adm->Vars[I21506], $adm->Vars[I21507]); $adm->Vars[I21507] =$adm->Pager->InitPageSizeBox($adm->Core->TTllTlI(I21868)); $adm->Filter->AddField(I21507, I21865, $adm->Vars[I21507]); }$vGlobVars =Array(); $vGlobVars[I21869] =$adm->ActiveScript; $vGlobVars[I21870] =$l1lLlLl; $vGlobVars[I21871] =$lang; $vGlobVars[I21872] =$lang_data; $vGlobVars[I21873] =$lLILl1I; $vGlobVars[I21874] =$lLILl1l; $vGlobVars[I21837] =$CMS_VERSION; $vGlobVars[I21875] =$adm->Core->TTllTlI(I21876); $vGlobVars[I21877] =I18110; $vGlobVars[I21878] =$lLILl1L; $vGlobVars[I21879] =$lLILLlI->TTllI1l(I21575); $vGlobVars[I21880] =$_SIDE; $vGlobVars[I21842] =$adm->Core->IsSysUser() ?I21843 :I19380; $adm->Gui->addGlobalVars($vGlobVars); if(!$l1lLll1 && !$I11I1LI){ $l1lIILl =$oServerCookie->get(I21881, false) ?unserialize(unhtmlentities($oServerCookie->get(I21881))) :array(); foreach (array_keys($l1lIILl) as $II1III1){ $vMod =&$adm->Core->getModule($II1III1); if(!is_object($vMod)){ unset($l1lIILl[$II1III1]); }}$vMod =&$adm->Core->getModule($adm->ActivePage); if(is_object($vMod)){ $l1lIILl[$adm->ActivePage] =array( I21882 => time(), I21650 => $vMod->GetAdminLink() );}if(sizeof($l1lIILl) >6){ foreach ($l1lIILl as $key => $value){ unset($l1lIILl[$key]); break; }}$oServerCookie->set(I21881, serialize($l1lIILl), time() +AMI_ServerCookie::LIFETIME_YEAR, I21367); }unset($oServerCookie); if(empty($GLOBALS[I21883][I21884]) && file_exists($lLILl1L .I21363)){ @include_once($lLILl1L .I21363); }$bench_time[I21885] =microtime(); 