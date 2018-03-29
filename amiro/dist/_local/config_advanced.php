<?php
/* ====================================================================================================================
  Application:    Amiro.CMS
  File:           Advanced config file for the system
  Version:        5

  Copyright:      XXI, Amiro.CMS, All rights reserved.
=====================================================================================================================*/

// =======================================================================
// == Other System Settings ==============================================
// =======================================================================

// =======================================================================
// == Global System Settings =============================================

/*
$SITE_TITLE = "";
$SITE_NAME = "";
$COMPANY_URL = "";
$ROBOT_EMAIL = "";
*/


if(!empty($SITE_TITLE["en"]))   $Core->SetOption( "default_title",       $SITE_TITLE);
if(!empty($SITE_NAME["en"]))    $Core->SetOption( "site_name",           $SITE_NAME);
if(!empty($COMPANY_NAME))       $Core->SetOption( "company_name",        $COMPANY_NAME);
if(!empty($COMPANY_URL))        $Core->SetOption( "company_url",         $COMPANY_URL);
if(!empty($COMPANY_EMAIL))      $Core->SetOption( "company_email",       $COMPANY_EMAIL);
if(!empty($ROBOT_EMAIL))        $Core->SetOption( "company_robot_email", $ROBOT_EMAIL);

                // path to lock file while database is updating (for demosites only)
                // use prefix $LOG_PATH
$Core->SetOption( "lock_file",                  "system_is_updating.lock");

                // allow supporting of multilanguages content
$Core->SetOption( "allow_multi_lang",           false);
                // allowed data languages
$Core->SetOption( "installed_langs", "en", "ru", "cn");
                // default language for website interface
$Core->SetOption( "default_gui_lang",           "ru");
                // default language for website data
$Core->SetOption( "default_data_lang",          "ru");

                // demo mode
$Core->SetOption( "demo_mode",                  false);

$Core->SetOption( "host_mode",                  "user");

                // try to detect language of visitor and redirect to related home page
$Core->SetOption( "auto_redirect_by_lang",      true);


                // Customizable owners
$Core->SetOption( "custom_owners",              "plugins");

                // date format display settings

                // date format symbols: DD = day;                 i.e. "01" to "31"
                //                      MM = month;               i.e. "01" to "12"
                //                    YYYY = year, 4 digits;      e.g. "1999"
                //                      YY = year, 2 digits;      e.g "99"
                //                      hh = hour;                i.e. "00" to "23"
                //                      mm = minutes;             i.e. "00" to "59"
                //                      ss = seconds;             i.e. "00" to "59"
                //example: "MM/DD/YYYY hh:mm:ss"
$Core->SetOption( "dateformat_front",    array("en"=>"MM/DD/YY hh:mm:ss", "ru"=>"DD.MM.YY hh:mm:ss", "gr"=>"MM/DD/YY hh:mm:ss"));
$Core->SetOption( "dateformat_admin",    array("en"=>"DD.MM.YYYY hh:mm:ss", "ru"=>"DD.MM.YYYY hh:mm:ss", "gr"=>"MM/DD/YY hh:mm:ss"));

                // Html transferring compression settings
                // It's recommended to set level to 4 and method to "manual"
                // If you have any troubles with correct displaying of web pages
                // try to change method or compression level

$Core->SetOption( "admin_compression_level",    $CONNECT_OPTIONS["admin_compression_level"]);
$Core->SetOption( "front_compression_level",    $CONNECT_OPTIONS["front_compression_level"]);
$Core->SetOption( "compression_method",         $CONNECT_OPTIONS["compression_method"]);

                // html code protecting mode (seperating with '|': none, email, tags, text
$Core->SetOption("html_protecting", "email");


                // true | false
$Core->SetOption( "allow_ip_limits",            $Core->IsInstalled('iplist'));

