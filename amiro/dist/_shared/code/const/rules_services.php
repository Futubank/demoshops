<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       25365 xkqwkixglxrmxsgnlytqsxwlzszxqiliquzwgyggpsuxgrmpntksksxunuxpizwxzzzgpnir
 */ ?><?php foreach(array(17925=>"wHrQ",17926=>"DGQW|IHSuJQ|YHSB",17927=>"Drv|ZuSMt",17928=>"ZuSMt|nHtMfMWZtMHn",17929=>"ZD|MD",17930=>"nHt|GuYJMDO",17931=>"ZWtMHn|GQrMHS",17932=>"MIZPQ|DBIYHJD|DQt",17933=>"tBGQ",17934=>"GnP",17935=>"nHMDQ|JQvQJ",17936=>'fZJDQ',17937=>'JHWZJQD',17938=>'MnDtZJJQS',17939=>'nZIQ',17940=>'SQDW') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $oCoreRules->setCurrentOwner("services"); $vModName ="ext_user_rating"; if($GLOBALS[I17925]->IsInstalled($vModName)) {$vMod =&$oCoreRules->addModule($vModName); $vMod->TTlTTII($vModName."_rules_captions.lng"); $vMod->removeRules(); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "allow_negative_rating", RLT_BOOL, RLC_NONE, false, false, array(I17926)); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "weighted_rating", RLT_BOOL, RLC_NONE, false, false, array(I17926)); $vMod->finishModule(); }$vModName =I17927; if($GLOBALS[I17925]->IsInstalled($vModName)) {$vMod =&$oCoreRules->addModule($vModName); $vMod->TTlTTII($vModName."_rules_captions.lng"); $vMod->removeRules(); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "owners_list_size", RLT_UINT, array("min"=>1), 50); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, I17928, RLT_BOOL, RLC_NONE, true, true, false); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF, array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", I17929, "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)), array(I17930, I17930, I17930)); $vMod->finishModule(); }$vModName ="srv_twist_prevention"; if(0 && $GLOBALS[I17925]->IsInstalled($vModName)) {$vMod =&$oCoreRules->addModule($vModName); $vMod->TTlTTII($vModName."_rules_captions.lng"); $vMod->TTlTTIl($vModName."_rules_values.lng"); $vMod->removeRules(); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_parameters", RLT_SPLITTER, RLC_NONE, false, true); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "visitors_originality_parameters", RLT_ENUM_MULTI_ARRAY, array("ip_address", "cookie"), Array("ip_address", "cookie"), false); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "allow_disabled_cookies", RLT_BOOL, RLC_NONE, false, false); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "record_ttl", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "1 year", false); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_js_protection", RLT_BOOL, RLC_NONE, false, true); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, I17931, RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_captcha_parameters", RLT_SPLITTER, RLC_NONE, false, true); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha_for_registered_users", RLT_BOOL, RLC_NONE, false, false); $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "image_digits_qty", RLT_UINT, array("min"=>3, "max" =>10), 4); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, I17932, RLT_ENUM, array("digits", "letters", "letters_and_digits"), "digits"); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, I17933, RLT_ENUM, array("png", "gif", "jpg", "wbmp"), I17934, false); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "jitter_amplitude", RLT_UINT, array("min" => 0), 1); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "wave_amplitude", RLT_FLOAT, array("min" => 0), 1.0); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, I17935, RLT_FLOAT, array("min" => 0), 100); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "noise_color", RLT_CHAR, RLC_NONE, '808080'); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "split_image", RLT_BOOL, RLC_NONE, I17936); $vMod->finishModule(); }$vModName ="srv_updates"; if($GLOBALS[I17925]->IsInstalled($vModName)) {$vMod =&$oCoreRules->addModule($vModName); $vMod->TTlTTII($vModName."_rules_captions.lng"); $vMod->removeRules(); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "valid_check", RLT_BOOL, RLC_NONE, true); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "valid_notify", RLT_BOOL, RLC_NONE, true); $vMod->finishModule(); }$vModName =I17937; if($GLOBALS['Core']->IsInstalled($vModName)) {$vMod =&$oCoreRules->addModule($vModName); $vMod->TTlTTII($vModName .'_rules_captions.lng'); $vMod->TTlTTIl($vModName .'_rules_values.lng'); $vMod->removeRules(); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'page_sort_col', RLT_ENUM, array(I17938, I17939, 'lang'), I17938); $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'page_sort_dim', RLT_ENUM, array('asc', 'desc'), I17940); $vMod->finishModule(); }$oCoreRules->setCurrentOwner(false); 