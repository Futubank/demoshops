<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       9497 xkqwqtzkwiszxkxguskxgruiurlulilwxyuzyipzzmtupymrrzgilusgxpmmsymwiignpnir
 */ ?><?php foreach(array(17118=>"IHSuJQD",17119=>"WuDtHI|IHSuJQ",17120=>"nHnQ",17121=>"ZSv|PrHuGD",17122=>"ZSv|GJZWQD",17123=>"ZSv|WZIGZMPnD",17124=>"ZSv|DtZtD",17125=>"ZSv|IHSuJQD|DtZtD",17126=>"ZSv|IHSuJQD|DtZtD`GOG",17127=>"Qxt|ZSv|ZuSMt",17128=>"tZYHrSQr") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} $Core->SetOwner(I17118); $vMod =&$Core->AddModule("show_pic", 0, "none"); $vMod->SetAdminAllowed(0); $vMod =&$Core->AddModule(I17119, 0, I17120); $vMod->TTlIT1T(0); $vMod->SetAdminAllowed(0); $vMod =&$Core->AddModule("adv_places", 1, "adv_places"); $vMod->SetAdminLink("adv_places.php"); $vMod =&$Core->TTllTI1("adv_places", I17121, 0, I17121); $vMod->SetAdminLink("adv_groups.php"); $vMod =&$Core->TTllTI1("adv_places", "adv_advertisers", 1, "adv_advertisers"); $vMod->SetAdminLink("adv_advertisers.php"); $vMod =&$Core->TTllTI1("adv_places", "adv_campaign_types", 1, "adv_campaign_types"); $vMod->SetAdminLink("adv_campaign_types.php"); $vMod =&$Core->TTllTI1(I17122, "adv_campaign_types_groups", 0, "adv_campaign_types_groups"); $vMod->SetAdminLink("adv_campaign_types_groups.php"); $vMod =&$Core->TTllTI1(I17122, "adv_campaigns", 0, I17123); $vMod->SetAdminLink("adv_campaigns.php"); $vMod =&$Core->TTllTI1(I17122, "adv_banners", 0, "adv_banners"); $vMod->SetAdminLink("adv_banners.php"); $vMod =&$Core->TTllTI1(I17122, I17124, 1, I17124); $vMod->SetAdminLink("adv_stats.php"); $vMod =&$Core->TTllTI1(I17122, I17125, 1, I17125); $vMod->SetAdminLink(I17126); $vMod =&$Core->TTllTI1(I17122, "adv_links_stats", 1, "adv_links_stats"); $vMod->SetAdminLink("adv_links_stats.php"); $vMod->SetInstalled(false); $vMod =&$Core->TTllTI1(I17122, I17127, 0); $vMod->SetAdminAllowed(0); $vMod =&$Core->AddModule("rating", 0); $vMod->SetAdminAllowed(0); $vMod->SetProperty("help_on", true); $vMod =&$Core->AddModule("calendar_grid", 0); $vMod->SetAdminAllowed(0); $vMod =&$Core->AddModule("ext_images", 1); $vMod->SetAdminAllowed(1); $vMod->TTlIT1T(1); $Core->OwnerSetData(I17118,I17128, 2000); $Core->OwnerSetData(I17118,"allow_hide_menu", true); 