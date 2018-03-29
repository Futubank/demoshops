<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       357727 xkqwgtilxrswtrkxtzpnnknknmyzgtsyiyzitkrzwpgtkkqnuttsugnumiwrquzzrxiupnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


// [ami_users|users] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // MEMBERS module constants
    $vMod = &$Core->GetModule($modName);
            // Count of files per page
    $vMod->SetOption( "page_size",              10);
            // Sort field of files "date", "active", "firstname", "lastname", "company", "email", "username"
    $vMod->SetOption( "page_sort_col",          "date");
            // Sort dimension of files "asc", "desc"
    $vMod->SetOption( "page_sort_dim",          "desc");
    $vMod->SetOption('extensions', array());
            // form template
            // used prefix - $LOCAL_FILES_PATH
    $vMod->SetOption("form_template", "_admin/templates/member.tpl");
            // minimal length of a username
    $vMod->SetOption("username_minlen", 3);
            // minimal length of a password
    $vMod->SetOption("password_minlen", 5);
            // time given to user to activate his account (in hours)
    $vMod->SetOption("activate_time", 1);

            // email that will be shown in the confirm email
    $Core->TTlI1ll($vMod, 'confirm_from_email', 'core_module', 'company_email');
            // admin email that will be shown if user obtain error in his actions
    $Core->TTlI1ll($vMod, 'admin_email', 'core_module', 'company_email');
            // forgot password custom field "email", "firstname", "lastname", "city", "phone"
    $vMod->SetOption("forgot_custom", "");
            // length of password to be generated when password reset
    $vMod->SetOption("generate_pass_len", 10);
            // show share warning
    $vMod->SetOption("show_share_warn", true);
            // Confirmation type "none", "admin", "email", "admin|email"
    $vMod->SetOption("confirmation_type", "none");
            // Confirmation attempts
    $vMod->SetOption("confirm_attempt_number", 10);
            // time given to user to activate his account (in hours)
    $vMod->SetOption("expire_period", "+1 month");

            // Send email notification on user registration
    $vMod->SetOption("notify_admin_on_registration", true);
            // Send email notification on user status changing.
            // Allowed values separated with "|": "active", "not_active"
    $vMod->SetOption("notify_on_status_changing",    "");
            // array of used fields separated with
            // allowed values are ("username", "email", "firstname", "lastname", "address1", "city",
            //      "state", "zip", "address2", "country", "phone", "company", "companyweb", "password", "ip", "icq", "photo")
            // ip will be filled automatically if it is specified
    $vMod->SetOption("used_fields", array ("firstname", "username", "email", 'nickname', "password", "photo" /*, "custom_field2", "custom_field1"*/));

            // array of used fields separated with
            // allowed values are ("username", "email", "firstname", "lastname", "address1", "city",
            //      "state", "zip", "address2", "country", "phone", "company", "companyweb", "password", "ip", "icq", "photo")
            // ip will be filled automatically if it is specified
    $vMod->SetOption("view_fields", array ('nickname', "photo", "forum_sign"));

    $vMod->SetOption('login_field', 'username'); /// 'email'

            // array of required fields separated with |
            // allowed values are ("username", "email", "firstname", "lastname", "address1", "city",
            //      "state", "zip", "address2", "country", "phone", "company", "companyweb", "password", "ip", "icq", "photo")
            // ip will be filled automatically if it is specified
    $vMod->SetOption("required_fields", array ("firstname", "lastname", "username", "email", 'nickname', "password"));
    $vMod->SetOption("admin_required_fields",       Array("username", "email"));

    $vMod->SetOption( "cache_expire",               "+1 day");
    $vMod->SetOption( "username_symbols",           "a-zA-Z0-9_.@\\-");


            // prefix to define a custom fields in a "used_fields" array
    $vMod->SetOption( "custom_fields_prefix", "custom_");

    $vMod->SetOption( "custom_fields", array(
                            "custom_field1" => array("type" => "text", "value" => "", "size" => "50"),
                            "custom_field2" => array("type" => "text", "value" => "", "size" => "50"),
                    ));
            // list of fields, which will be shown into form (in that order, in which they are listed)
            // possible fields: "firstname", "lastname", "birthdate", "email", "phone", "fax", "web", "company", "title", "address1", "address2", "city", "state", "zip", "country", "info", "custom_1", ..., custom_N (N =1, 2, 3, ...)


            // External modules integration
    $vMod->SetOption("external_integration_modules_list", array ());

    // {{{ twist prevention extension options

            // for old engine modules
    $vMod->SetOption("use_twist_prevention", true);
            // period of next active action preventing, e. g. adding message to forum (into current module)
    $vMod->SetOption("action_period", "5 second");
            // show captcha (image to prevent from robots actions)
    $vMod->SetOption("show_captcha", true);
            // check captcha without page reloading
    $vMod->SetOption("js_checking", true);
            // add "_twist" postfix to module action in case of twist detection
    $vMod->SetOption("generate_twist_action", false);
            // add status message in case of twist detection
    $vMod->SetOption("show_alert", true);

    // }}}

            // show user menu links ("aff_users", "eshop_user", "eshop_user_items", "eshop_order_history", "eshop_item", "eshop_order", "eshop_cart", "subscribe", "adv_campaign_types", "adv_advertisers", "adv_stats", "srv_audit_news", "srv_audit_eshop_item", "srv_audit_adv_banners", "srv_audit_adv_campaigns")
    $vMod->SetOption("show_user_menu_links", Array("aff_users", /*"eshop_user", "eshop_user_items",*/ "eshop_order_history", 'private_messages', /*"eshop_item", "eshop_order", "eshop_cart",*/ "subscribe", "adv_campaign_types", "adv_advertisers", "srv_audit_adv_banners", "srv_audit_adv_campaigns", "adv_stats", "adv_modules_stats", "srv_audit_news", "srv_audit_blog", "srv_audit_articles", "srv_audit_articles_cat", "srv_audit_files", "srv_audit_files_cat", "srv_audit_jobs", "srv_audit_jobs_cat", "srv_audit_photoalbum", "srv_audit_photoalbum_cat", "srv_audit_eshop_item"));
            // Force expire time (strtotime format), "" - auto
    $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');

    $vMod->SetOption('autoredirect_forms', array ());
    $vMod->SetOption('autoredirect_to_modules', array ());
            // Set specblock mode (dynamic/static)
    $vMod->SetOption('disable_dynamic_specblock', true);
            // Custom filter fields for admin interface. Format of array: field_name [from DB] => field caption.
    $vMod->SetOption('admin_filter_custom_fields', array());

            // Allow members to login via external services
    $vMod->SetOption('user_source_app', false);
    
    // #CMS-11748: List of modules allowing "edit in place" at front side
    $vMod->SetOption('edit_front_allowed_modules', array());
}

// } [ami_users|users]
// [ami_fake|users] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption('admin_menu_allowed', FALSE);
}

// } [ami_fake|users]
// [ami_access_rights|groups] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // GROUPS module constants
    $vMod = &$Core->GetModule($modName);
    // Sort field
    $vMod->SetOption("page_sort_col", "name");
    // Sort dimension "asc", "desc"
    $vMod->SetOption("page_sort_dim", "asc");
    // Default rights
    // User groups rights
    $vMod->SetOption("sys_default_group",       7);
    // Other groups rights
    $vMod->SetOption("sys_default_other_group", 4);
    // Guest groups rights
    $vMod->SetOption("sys_default_guest",       4);
}

// } [ami_access_rights|groups]
// [ami_users|access_rights] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // USERS module constants
    $vMod = &$Core->GetModule($modName);
    // Engine version. Set version greater than 0302 to turn on class engine support
    $vMod->SetOption("engine_version", '0303');
    // Sort field of items "username", "active", "firstname", "lastname", "email"
    $vMod->SetOption( "page_sort_col", "username");
    // Sort dimension of items "asc", "desc"
    $vMod->SetOption( "page_sort_dim", "asc");
    // Custom filter fields for admin interface. Format of array: field_name [from DB] => field caption.
    $vMod->SetOption('admin_filter_custom_fields', array());
}

// } [ami_users|access_rights]
// [ami_access_rights|users_popup] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // USERS popup module constants
    $vMod = &$Core->GetModule($modName);
    // Engine version. Set version greater than 0302 to turn on class engine support
    $vMod->SetOption("engine_version", '0303');
    $vMod->SetOption("admin_menu_allowed", false);
    // Sort field of items "username", "active", "firstname", "lastname", "email"
    $vMod->SetOption( "page_sort_col", "username");
    // Sort dimension of items "asc", "desc"
    $vMod->SetOption( "page_sort_dim", "asc");
    // Engine version. Set version greater than 0302 to turn on class engine support
    $vMod->SetOption( "admin_menu_allowed", false);
    // Sort field of items "username", "active", "firstname", "lastname", "email"
    $vMod->SetOption( "page_sort_col", "username");
    // Sort dimension of items "asc", "desc"
    $vMod->SetOption( "page_sort_dim", "asc");
    // Custom filter fields for admin interface. Format of array: field_name [from DB] => field caption.
    $vMod->SetOption('admin_filter_custom_fields', array());
}

// } [ami_access_rights|users_popup]
// [ami_access_rights|groups_popup] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // GROUPS popup module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption("engine_version", '0303');
    $vMod->SetOption("admin_menu_allowed", false);
    // Sort field
    $vMod->SetOption("page_sort_col", "name");
    // Sort dimension "asc", "desc"
    $vMod->SetOption("page_sort_dim", "asc");
}

// } [ami_access_rights|groups_popup]
// [ami_access_rights|modules_popup] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // MODULES popup module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption('engine_version', '0303');
    $vMod->SetOption('admin_menu_allowed', false);
    $vMod->SetOption('cols', 3);
}

// } [ami_access_rights|modules_popup]
// [ami_access_rights|departments] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // DEPARTMENTS module constants
    $vMod = &$Core->GetModule($modName);
    // Engine version. Set version greater than 0302 to turn on class engine support
    $vMod->SetOption("engine_version", '0303');
    // Sort field of items "username", "active", "firstname", "lastname", "email"
    $vMod->SetOption( "page_sort_col", "name");
    // Sort dimension of items "asc", "desc"
    $vMod->SetOption( "page_sort_dim", "asc");
}

// } [ami_access_rights|groups]
// [ami_multifeeds|articles] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // ARTICLES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    // $vMod->SetOption('rule_test', Array('r1'));
    $vMod->SetOption('cols', 1);

            // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
    $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
            // Array with available pictures

    // 'ext_image' extension options {

    ###        $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
    $vMod->SetOption('ext_img_fields', array('ext_img', 'ext_img_popup', 'ext_img_small'));
            // Type of picture, which will be shown in admin item's list:
            // "none", "picture", "popup_picture", "small_picture"
    $Core->TTlI1ll(
        $vMod,
        'ext_img_list_col',
        'ext_images',
        'col_picture_type',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
            // Picture generator options
    ###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
    $vMod->SetOption('ext_img_creatable', array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $Core->TTlI1ll(
        $vMod,
        'ext_img_source',
        'ext_images',
        'prior_source_picture',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
    $Core->TTlI1ll($vMod, 'ext_img_maxwidth', 'ext_images', 'picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_maxheight', 'ext_images', 'picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxwidth', 'ext_images', 'popup_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxheight', 'ext_images', 'popup_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxwidth', 'ext_images', 'small_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxheight', 'ext_images', 'small_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_create_bigger', 'ext_images', 'generate_bigger_image');

    // } 'ext_image' extension options

    $vMod->SetOption("use_categories", TRUE);
    if($vMod->GetOption( "use_categories")){
        $vMod->SetOption("stop_arg_names", $Core->GetModProperty("##modId##_cat", "stop_arg_names"));
    } else {
        $vMod->SetOption("stop_arg_names", $Core->GetModProperty("##modId##", "stop_arg_names"));
    }

    $vMod->SetOption("subitems_total_items_limit", 30);
    $vMod->SetOption("spec_total_items_limit", 30);

            // Count of articles per page
    $vMod->SetOption("page_size",                  10);
            // Sort field of articles "date", "header"
    $vMod->SetOption("page_sort_col",              'date_created');
            // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("page_sort_dim",              "desc");
    // Sort field of articles "date", "header"
    $vMod->SetOption("front_subitem_sort_col",     'date_created');
            // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("front_subitem_sort_dim",     "desc");
            // Sort field of articles "date", "header"
    $vMod->SetOption("front_page_sort_col",        "date_created");
            // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("front_page_sort_dim",        "desc");
            // Suport multi pages
    $vMod->SetOption("multi_page",                 true);
            // type of archiving method: "manual", "date"
    $vMod->SetOption("archive_type",               "manual");
            // strings containing an english date format
            // Valid only when archive type is date
            // Examples:
            // "10 September 2000"
            // "-1 day"
            // "-1 week"
            // "-12 month"
    $vMod->SetOption("archive_period",             "-1 year");
            // type of articles to show: "all", "active", "archive"
    $vMod->SetOption("show_type",                  "all");
            // Show list of categories inside category
    $vMod->SetOption("multicat",                   false);
            // Show list of categories inside item details
    $vMod->SetOption("multicat_in_body_details",   false);
            // Show N last items, when url parametr "show_last=1" is present
            // If N=0, then working in normal mode
    $vMod->SetOption("show_last_items",            10);
            // Show forum_count_replies, true, false
    $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
            // Show forum_count_topics, true, false
    //        $Core->SetOptionInherited($vMod, 'show_forum_count_topics', 'ext_discussion', 'show_forum_count_topics');
            // Show forum links in news list, true, false
    $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
            // Show forum links in small news block, true, false
    $Core->TTlI1ll($vMod, 'show_forum_link_in_small', 'ext_discussion', 'show_forum_link_in_small');
            // Show forum at element details page right away
    $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details');
            // Display element numbers in messages list
    $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
            // Discussion admin notification
    $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
            // Webmaster email
    $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
            // Use tree view
    $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');
            // Anonymous user email
    //        $vMod->SetOption("forum_anonymous_user_email",       "anonymous@localhost.ru");
            // Are attaches allowed
    //        $Core->SetOptionInherited($vMod, 'forum_attaches_allowed', 'ext_discussion', 'forum_attaches_allowed');
            // False - one level tree messages, true - normal tree
    //        $Core->SetOptionInherited($vMod, 'forum_only_one_level', 'ext_discussion', 'forum_only_one_level');
            // Set type of pager, "items", "topics"
    //        $Core->SetOptionInherited($vMod, 'forum_pager_type', 'ext_discussion', 'forum_pager_type');
            // Count of forum items per page
    //        $Core->SetOptionInherited($vMod, 'forum_page_size', 'ext_discussion', 'forum_page_size');
            // Only one topic per item
    //        $Core->SetOptionInherited($vMod, 'forum_multi_topics', 'ext_discussion', 'forum_multi_topics');

    // #CMS-11482, ext_rating {

    if($GLOBALS['Core']->IsInstalled('ext_rating')){
        $Core->TTlI1ll($vMod, 'form_template', 'ext_rating', 'form_template', TRUE, 'rating_like.tpl');
    }

    // } ext_rating

            // Count of categories' columns per page
    $vMod->SetOption("body_cats_cols",             1);
            // Count of articles columns on spec block
    $vMod->SetOption("body_small_cols",            1);
            // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
    $vMod->SetOption("show_subitems",              -1);
            // The number of sub items, after which is inserted splitter, 0 - no splitter
    $vMod->SetOption("subitems_splitter_period",    0);
            // Count of subitems' columns per page
    $vMod->SetOption("subitems_cols",               1);
    // #CMS-11147
    $vMod->SetOption('subitems_grp_by_cat', TRUE);
            // Count of items, which will be shown. If category(is) is specified, then count of items from each category.
    $vMod->SetOption("small_number_items",          5);
            // List of categories id, from which the items will be shown
            //(0 - first N categories, which is specified in an option "small_number_categories").
    $vMod->SetOption("small_category_ids",          0);
    $vMod->SetOption('small_grp_by_cat', FALSE);
            // Sort field of categories "name", "position"
    $vMod->SetOption("small_categories_sort_col",   "header");
            // Sort dimension of categories "asc", "desc"
    $vMod->SetOption("small_categories_sort_dim",   "asc");
            // Sort field of articles "date", "header"
    $vMod->SetOption("small_items_sort_col",        "date_created");
            // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("small_items_sort_dim",        "desc");
            // Fill empty description/body with announce on details page
    $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description');
            // Currently available "ext_discussion", "ext_tags"
    $vMod->SetOption("extensions", array('ext_twist_prevention', 'ext_reindex', 'ext_discussion', 'ext_rating', 'ext_rss'));
            // Show urgent elements at pages
    //        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
    $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

    // {{{ twist prevention extension options

            // period of next active action preventing, e. g. adding message to forum (into current module)
    ###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
    $vMod->SetOption('action_period', '5 second');
            // show captcha (image to prevent from robots actions)
    $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
            // check captcha without page reloading
    $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
            // add "_twist" postfix to module action in case of twist detection
    $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
            // add status message in case of twist detection
    $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');

    // }}}

    //-- RSS extension ARTICLES module constants
           // number of RSS channel elements
    $Core->TTlI1ll($vMod, 'rss_num_elements', 'ext_rss', 'rss_num_elements');
           // display on page
    $Core->TTlI1ll($vMod, 'rss_display_page', 'ext_rss', 'rss_display_page');
           // type of display image on page
    $Core->TTlI1ll($vMod, 'rss_display_image', 'ext_rss', 'rss_display_image');
           // rss channel title (only to module) = field from news
    $Core->TTlI1ll($vMod, 'rss_channel_title', 'core_module', 'company_name');
           // rss channel description (only to module)
    $vMod->SetOption("rss_channel_description",       "");
           // rss channel webmaster (only to module)
    $Core->TTlI1ll($vMod, 'rss_channel_webmaster', 'ext_rss', 'rss_channel_webmaster');
           // rss channel generator (only to module, god_mode)
    $Core->TTlI1ll($vMod, 'rss_channel_generator', 'ext_rss', 'rss_channel_generator');
           // rss item title (only to module)
    $vMod->SetOption("rss_item_title",                "rss_header");
           // rss item description (only to module) = field from news
    $vMod->SetOption("rss_item_description",          "rss_announce");
           // rss item enclosure (only to module) = field from news
    $vMod->SetOption("rss_item_enclosure",            "rss_small_image");
           // rss item guid (only to module) = field from news
    $vMod->SetOption("rss_item_guid",                 "none");
           // rss item guid (only to module) = field from news
    $vMod->SetOption("rss_item_pubdate",              "rss_c_date");
            // rss channel (only to module, list of files in "_img/")
    $Core->TTlI1ll($vMod, 'rss_channel_image', 'ext_rss', 'rss_channel_image');
            // rss channel (only to module, list of files in "_img/")
    $Core->TTlI1ll($vMod, 'rss_channel_style', 'ext_rss', 'rss_channel_style');
    //-- end RSS

            // Sort fields for some body types:
            // Array(
            //        "{body_type1};..;{body_typeN}"=>Array({field1}, ...{fieldN}),
            //        ...
            //        "{body_type(N+1)};..;{body_type(N+M)}"=>Array({field1}, ...{fieldN})
            //      )
            // Currently available body types: body_items, body_cats.
            // Currently available fileds for body_items: "header", "date"
            // Currently available fileds for body_cats: "name", "position"
    $vMod->SetOption("sort_pages_setup",  Array(
            "body_items;body_urgent_items"=>Array("header", "date"),
            "body_cats;body_urgent_cats"=>Array("name", "position")
    ));
            // Adv place
            // Adv place
    $vMod->SetOption("adv_place_list",  -1);
    $vMod->SetOption("adv_place_details",  -1);
    $vMod->SetOption("adv_place_sb",  -1);
            // Show advertisement statistics counter in admin's list table
    $vMod->SetOption("show_adv_stat_columns",    false);
            // Show advertisement place name in admin's list table
    $vMod->SetOption("show_adv_place_columns",    false);

    $vMod->SetOption("stop_arg_names", array("catid"=>"##modId##_cat", "id"=>"##modId##"));
    $vMod->SetOption("html_title_template",    "##object_name## - ##cat_name## - ##current_page_name## | ##site_title##");
    $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
            // Displayed fields' properties (used for audit module ONLY)
    $vMod->SetOption("audit_displayed_fields", Array("field_date"=>"visible", "field_author"=>"visible", "field_source"=>"visible", "field_picture"=>"visible", "field_popup_picture"=>"visible", "field_small_picture"=>"visible", "field_body"=>"visible", "field_html_title"=>"hidden"));
            // Array of required fields (used for audit module ONLY)
    $vMod->SetOption("audit_required_fields",  Array());
            // Audit changes made in admin interface
    $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
            // Send notification on user's item changing
    $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
            // Audit action handling rules
    ###        $Core->SetOptionInherited($vMod, 'audit_actions_handling', 'srv_audit', 'audit_actions_handling');
    $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
            // Additional template file for spec block
    $vMod->SetOption("spec_block_template",    "");
            // Additional template file for spec block
    $vMod->SetOption("spec_id_pages",          Array(-1));
    $vMod->SetOption("spec_id_pages",          Array(-1));
    $vMod->SetOption('spec_cat_id_pages', array(-1));
    $vMod->SetOption('mod_id_pages', array(-2, 0));
    $vMod->SetOption('mod_cat_id_pages', array(-2, 0));
            // Set pages view in pager (numbers or bounds)
    $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');
            // Diplay or not on front module items having date in the future
    $Core->TTlI1ll($vMod, 'hide_future_items', 'common_settings', 'hide_future_items');
            // Force expire time (strtotime format), "" - auto
    $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');
            // Small block view mode "usual" or "calendar"
    $vMod->SetOption("small_view_mode", "usual");
            // number cols in body_filtered mode
    $vMod->SetOption("body_filtered_cols", 1);
            // number of page items in body_filtered mode
    $vMod->SetOption("body_filtered_page_size", 10);
    $vMod->SetOption("filter_pages_setup",  Array(
        "body_filtered"=>Array("date_from", "date_to"))
    );
            // 404 header for not found pages
    $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
    // Disable search engine indexing for following cases
    $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
    // Add date-prefix to URL
    $vMod->SetOption("add_date_prefix", false);
}

// } [ami_multifeeds|articles]
// [ami_multifeeds|articles|cat] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // ARTICLES CATEGORIES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
            // Suport multi pages

    // 'ext_image' extension options {

###                $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
    $vMod->SetOption('ext_img_fields', array('ext_img', 'ext_img_popup', 'ext_img_small'));
            // Type of picture, which will be shown in admin item's list:
            // "none", "picture", "popup_picture", "small_picture"
    $Core->TTlI1ll(
        $vMod,
        'ext_img_list_col',
        'ext_images',
        'col_picture_type',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
            // Picture generator options
###                $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
    $vMod->SetOption('ext_img_creatable', array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $Core->TTlI1ll(
        $vMod,
        'ext_img_source',
        'ext_images',
        'prior_source_picture',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
    $Core->TTlI1ll($vMod, 'ext_img_maxwidth', 'ext_images', 'picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_maxheight', 'ext_images', 'picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxwidth', 'ext_images', 'popup_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxheight', 'ext_images', 'popup_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxwidth', 'ext_images', 'small_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxheight', 'ext_images', 'small_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_create_bigger', 'ext_images', 'generate_bigger_image');

    // } 'ext_image' extension options

            // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
    $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
            // Default category: "all", "none", "NN" - id of category
    //$vMod->SetOption("default_category",        "all");
            // Module extensions 'ext_reindex', 'ext_rating'
    $vMod->SetOption("extensions", array('ext_reindex'));
            // Count of categories per page
    $vMod->SetOption("page_size",               10);
            // Sort field of categories "name"
    $vMod->SetOption("page_sort_col",           "header");
            // Sort dimension of categories "asc", "desc"
    $vMod->SetOption("page_sort_dim",           "asc");
            // Sort field of categories "name"
    $vMod->SetOption("front_page_sort_col",     "header");
            // Sort dimension of categories "asc", "desc"
    $vMod->SetOption("front_page_sort_dim",     "asc");
            // Count of categories' columns per page
    $vMod->SetOption("cols",                    2);
            // Show empty categories
    $vMod->SetOption("show_empty_cats",         false);
            // Fill empty description/body with announce on details page
    $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description', true, false);
            // Show urgent elements at pages
//                $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
    $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

            // Show advertisement statistics counter in admin's list table
    $vMod->SetOption("show_adv_stat_columns",    false);
            // Show advertisement place name in admin's list table
    $vMod->SetOption("show_adv_place_columns",    false);

    $vMod->SetOption("average_cat_rating", true);
    $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
    $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');

    /*        // Displayed fields' properties (used for audit module ONLY)
    $vMod->SetOption("audit_displayed_fields", Array("field_cdate"=>"visible", "field_mdate"=>"visible", "field_name"=>"visible", "field_announce"=>"visible", "field_body"=>"visible", "field_filename"=>"visible"));
            // Array of required fields (used for audit module ONLY)
    $vMod->SetOption("audit_required_fields",  Array());*/
            // Audit changes made in admin interface
    $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
            // Send notification on user's item changing
    $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
            // Audit action handling rules
    $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
            // 404 header for not found pages
    $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
}

// } [ami_multifeeds|articles|cat]
// [ami_multifeeds|stickers] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // STICKERS module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);

    // 'ext_image' extension options {

    ###        $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
    $vMod->SetOption('ext_img_fields', array('ext_img', 'ext_img_popup', 'ext_img_small'));
            // Type of picture, which will be shown in admin item's list:
            // "none", "picture", "popup_picture", "small_picture"
    $Core->TTlI1ll(
        $vMod,
        'ext_img_list_col',
        'ext_images',
        'col_picture_type',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
            // Picture generator options
    ###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
    $vMod->SetOption('ext_img_creatable', array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $Core->TTlI1ll(
        $vMod,
        'ext_img_source',
        'ext_images',
        'prior_source_picture',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
    $Core->TTlI1ll($vMod, 'ext_img_maxwidth', 'ext_images', 'picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_maxheight', 'ext_images', 'picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxwidth', 'ext_images', 'popup_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxheight', 'ext_images', 'popup_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxwidth', 'ext_images', 'small_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxheight', 'ext_images', 'small_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_create_bigger', 'ext_images', 'generate_bigger_image');

    // } 'ext_image' extension options

    //Use categories
    $vMod->SetOption("use_categories", true);
    // Count of articles per page
    $vMod->SetOption("page_size", 10);
    // Sort field of articles "date", "header"
    $vMod->SetOption("page_sort_col", "id");
    // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("page_sort_dim", "desc");
    // Sort field of articles "date", "header"

    $vMod->SetOption("search_field_cat", array(-1));
    $vMod->SetOption("search_field_item", array(-1));

    // Sort field of articles "date", "header"
    $vMod->SetOption("small_items_sort_col", "date_created");
    // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("small_items_sort_dim", "desc");
    // Currently available "ext_discussion", "ext_tags"
    $vMod->SetOption("extensions", array());

    $vMod->SetOption("small_number_items", 4);
    $vMod->SetOption("body_small_cols", 1);

    // Additional template file for spec block
    $vMod->SetOption("spec_block_template", "");
    // Force expire time (strtotime format), "" - auto
    $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force', true, '1 hour');
    // Outputs full announce in small mode
    $vMod->SetOption("announce_mode_full", true);
    $vMod->SetOption("announce_small_length", 120);
    $vMod->SetOption("header_small_length", 120);
}

// } [ami_multifeeds|stickers]
// [ami_multifeeds|stickers|cat] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // STICKERS CATEGORIES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    // Sort field of categories "name"
    $vMod->SetOption("page_sort_col", "id");
    // Sort dimension of categories "asc", "desc"
    $vMod->SetOption("page_sort_dim", "desc");
    // Sort field of categories "name"
    $vMod->SetOption("show_empty_cats", false);
}

// } [ami_multifeeds|stickers|cat]
// [ami_fake|news|archive] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('front_page_sort_col', 'id');
    $vMod->SetOption('front_page_sort_dim', 'desc');
    $vMod->SetOption('page_sort_col', 'id');
    // Archive size, string ( strtotime() format)
    $vMod->SetOption("stop_arg_names", array("id"=>"##parentModId##"));
    $vMod->SetOption("archive_size",               "-30 year");
    // Archive period, string
    // N days, N months, N years, week
    // N - integer, greater than zero
    $vMod->SetOption("archive_period",             "1 year");
    // Show news counters, true, false
    $vMod->SetOption("show_count_news",            true);
    // Archive page size, integer
    $vMod->SetOption("archive_page_size",          10);
    // News page size, integer
    $vMod->SetOption("page_size",                  10);
    // Show only archived news (otherwise - all news), true, false
    $vMod->SetOption("show_only_archived",         false);
    // Show news body, when forum
    $Core->TTlI1ll($vMod, 'show_body_when_forum', 'ext_discussion', 'show_body_when_forum');
    // Show forum_count_replies, true, false
    $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
    // Show forum_count_topics, true, false
    // $Core->SetOptionInherited($vMod, 'show_forum_count_topics', 'ext_discussion', 'show_forum_count_topics');
    // Show forum links in news list, true, false
    $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
    // Show forum at element details page right away
    $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details');
    // Display element numbers in messages list
    $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
    // Discussion admin notification
    $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
    // Webmaster email
    $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
    // Use tree view
    $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');
    // Anonymous user email
    // $Core->SetOptionInherited($vMod, 'forum_anonymous_user_email', 'ext_discussion', 'forum_anonymous_user_email');
    // Are attaches allowed
    // $Core->SetOptionInherited($vMod, 'forum_attaches_allowed', 'ext_discussion', 'forum_attaches_allowed');
    // False - one level tree messages, true - normal tree
    // $Core->SetOptionInherited($vMod, 'forum_only_one_level', 'ext_discussion', 'forum_only_one_level');
    // Set type of pager, "items", "topics"
    // $Core->SetOptionInherited($vMod, 'forum_pager_type', 'ext_discussion', 'forum_pager_type');
    // Count of forum items per page
    // $Core->SetOptionInherited($vMod, 'forum_page_size', 'ext_discussion', 'forum_page_size');
    // Currently available "ext_discussion"
    $vMod->SetOption("extensions", array() );
    // Force expire time (strtotime format), "" - auto
    $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');
    // Disable search engine indexing for following cases
    $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
}

// } [ami_fake|news|archive]
// [ami_multifeeds|news] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // NEWS module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    $isCoreV5 = $oDeclarator->getAttr($modName, 'core_v5', FALSE);
    $vMod->SetOption('page_size', $Core->GetOption('default_page_size'));
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption('front_page_sort_dim', 'desc');
    $vMod->SetOption('page_sort_dim_small', 'desc');
    $vMod->SetOption('cols', 1);

    $vMod->SetOption('use_categories', FALSE);
    if($vMod->GetOption('use_categories')){
        $vMod->SetOption('stop_arg_names', $Core->GetModProperty('##modId##_cat', 'stop_arg_names'));
    }else{
        $vMod->SetOption("stop_arg_names", $Core->GetModProperty('##modId##', 'stop_arg_names'));
    }

    $vMod->SetOption("subitems_total_items_limit", 30);
    $vMod->SetOption("spec_total_items_limit", 30);

    $vMod->SetOption('body_cats_cols', 1);
    $vMod->SetOption('multicat', FALSE);
    $vMod->SetOption('multicat_in_body_details', FALSE);
    $vMod->SetOption('show_last_items', 10);

                // Suport multi pages
        $vMod->SetOption("multi_page",              true);
                // Sort field of news "date_created", "header", "position", "votes_rate"
        $vMod->SetOption("front_page_sort_col",        "date_created");
                // Sort field of news in specblock "date_created", "header", "position", "votes_rate"
        $vMod->SetOption("page_sort_col_small", "date_created");
                // Count of news columns on spec block
        $vMod->SetOption("body_small_cols", 1);
                // Array with available pictures

    // 'ext_image' extension options {

    $vMod->SetOption('ext_img_fields', array('ext_img', 'ext_img_popup', 'ext_img_small'));
            // Type of picture, which will be shown in admin item's list:
            // "none", "picture", "popup_picture", "small_picture"
    $Core->TTlI1ll(
        $vMod,
        'ext_img_list_col',
        'ext_images',
        'col_picture_type',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
            // Picture generator options
    ###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
    $vMod->SetOption('ext_img_creatable', array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $Core->TTlI1ll(
        $vMod,
        'ext_img_source',
        'ext_images',
        'prior_source_picture',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
    $Core->TTlI1ll($vMod, 'ext_img_maxwidth', 'ext_images', 'picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_maxheight', 'ext_images', 'picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxwidth', 'ext_images', 'popup_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxheight', 'ext_images', 'popup_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxwidth', 'ext_images', 'small_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxheight', 'ext_images', 'small_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_create_bigger', 'ext_images', 'generate_bigger_image');

    // } 'ext_image' extension options

                // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                // Outputs full announce in small mode
        $vMod->SetOption("announce_mode_full",      false);
                // max length of announce string on small block. [1..250]
        $vMod->SetOption("announce_small_length",      250);
                // max length of header string on small block. [1..100]
        $vMod->SetOption("header_small_length",        200);
                // type of archiving method: "manual", "date"
        $vMod->SetOption("archive_type",               "manual");
                // all $..._ARCHIVE_PERIOD are strings containing an english date format
                // Valid only when archive type is date
                // Examples:
                // "10 September 2000"
                // "-1 day"
                // "-1 week"
                // "-12 month"
        $vMod->SetOption("archive_period",             "-12 month");
                // type of items to show: "all", "active", "archive"
        $vMod->SetOption("show_type",                  "all");
                // Currently available "ext_twist_prevention", "ext_discussion", "ext_rss", "ext_tags")
        $vMod->SetOption('extensions', array('ext_twist_prevention', 'ext_rss', 'ext_reindex'));
                // Fill empty description/body with announce on details page
        $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description');
                // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));
                // Set pages view in pager (numbers or bounds)
        $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');
                // Diplay or not on front module items having date in the future
        $Core->TTlI1ll($vMod, 'hide_future_items', 'common_settings', 'hide_future_items');

        // RSS extension NEWS module constants
               // number of RSS channel elements
        $Core->TTlI1ll($vMod, 'rss_num_elements', 'ext_rss', 'rss_num_elements');
               // display on page
        $Core->TTlI1ll($vMod, 'rss_display_page', 'ext_rss', 'rss_display_page');
               // type of display image on page
        $Core->TTlI1ll($vMod, 'rss_display_image', 'ext_rss', 'rss_display_image');
               // rss channel title (only to module) = field from news
        $Core->TTlI1ll($vMod, 'rss_channel_title', 'core_module', 'company_name');
               // rss channel description (only to module)
        $vMod->SetOption("rss_channel_description",       "");
               // rss channel webmaster (only to module)
        $Core->TTlI1ll($vMod, 'rss_channel_webmaster', 'ext_rss', 'rss_channel_webmaster');
               // rss channel generator (only to module, god_mode)
        $Core->TTlI1ll($vMod, 'rss_channel_generator', 'ext_rss', 'rss_channel_generator');
               // rss item title (only to module)
        $vMod->SetOption("rss_item_title",                "rss_header");
               // rss item description (only to module) = field
        $vMod->SetOption("rss_item_description",          "rss_announce");
               // rss item yandex fulltext (only to module) = field
        $vMod->SetOption("rss_item_fulltext",             "none");
               // rss item enclosure (only to module) = field from news
        $vMod->SetOption("rss_item_enclosure",            "rss_small_image");
               // rss item guid (only to module) = field
        $vMod->SetOption("rss_item_guid",                 "none");
               // rss item guid (only to module) = field
        $vMod->SetOption("rss_item_pubdate",              "rss_c_date");

                // rss channel (only to module, list of files in "_img/")
        $Core->TTlI1ll($vMod, 'rss_channel_image', 'ext_rss', 'rss_channel_image');
                // rss channel (only to module, list of files in "_img/")
        $Core->TTlI1ll($vMod, 'rss_channel_style', 'ext_rss', 'rss_channel_style');
        //-- end RSS
                // Force expire time (strtotime format), "" - auto
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');

        $vMod->SetOption("filter_pages_setup",  Array(
            "body_filtered"=>Array("date_from", "date_to"))
        );


//// Obsolete 0302 version options

        // {{{ twist prevention extension options

                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');

        // }}}
        // {{{ discussion extension

        if($isCoreV5){
            // Show news body, when forum
            $Core->TTlI1ll($vMod, 'show_body_when_forum', 'ext_discussion', 'show_body_when_forum');
        }
                // Show forum_count_replies, true, false
        $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
                // Show forum_count_topics, true, false
//        $Core->SetOptionInherited($vMod, 'show_forum_count_topics', 'ext_discussion', 'show_forum_count_topics');
                // Show forum links in news list, true, false
        $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
                // Show forum links in small news block, true, false
        $Core->TTlI1ll($vMod, 'show_forum_link_in_small', 'ext_discussion', 'show_forum_link_in_small');
                // Show forum at element details page right away
        $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details');
                // Display element numbers in messages list
        $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
                // Discussion admin notification
        $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
                // Webmaster email
        $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
                // Use tree view
        $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');
                // Anonymous user email
//        $Core->SetOptionInherited($vMod, 'forum_anonymous_user_email', 'ext_discussion', 'forum_anonymous_user_email');
                // Are attaches allowed
//        $Core->SetOptionInherited($vMod, 'forum_attaches_allowed', 'ext_discussion', 'forum_attaches_allowed');
                // False - one level tree messages, true - normal tree
//        $Core->SetOptionInherited($vMod, 'forum_only_one_level', 'ext_discussion', 'forum_only_one_level');
                // Set type of pager, "items", "topics"
//        $Core->SetOptionInherited($vMod, 'forum_pager_type', ext_discussion', 'forum_pager_type');
                // Count of forum items per page
//        $Core->SetOptionInherited($vMod, 'forum_page_size', 'ext_discussion', 'forum_page_size');
                // Only one topic per item
//        $Core->SetOptionInherited($vMod, 'forum_multi_topics', 'ext_discussion', 'forum_multi_topics');

        // }}}

//// End of obsolete 0302 ver options

        // #CMS-11482, ext_rating {

        if($GLOBALS['Core']->IsInstalled('ext_rating')){
            $Core->TTlI1ll($vMod, 'form_template', 'ext_rating', 'form_template', TRUE, 'rating_like.tpl');
        }

        // } ext_rating

                // Show body browse
        $vMod->SetOption("show_body_browse", false);
                // Count of pictures per page for browse list
        $vMod->SetOption("body_browse_page_size",      5);
                // Browse active item position
        $vMod->SetOption("browse_active_item_position",3);
                // Count of pictures columns on browse mode
        $vMod->SetOption("body_browse_cols",           5);
                // Adv place initial parameters. Should not be any but -1 because this is callback parameters
        $vMod->SetOption("adv_place_list",  -1);
        $vMod->SetOption("adv_place_details",  -1);
        $vMod->SetOption("adv_place_sb",  -1);
                // Show advertisement statistics counter in admin's list table
        $vMod->SetOption("show_adv_stat_columns",    false);
                // Show advertisement place name in admin's list table
        $vMod->SetOption("show_adv_place_columns",    false);

        $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
                // Displayed fields' properties (used for audit module ONLY)
        $vMod->SetOption("audit_displayed_fields", Array("field_date"=>"visible", "field_body"=>"visible", "field_picture"=>"visible", "field_popup_picture"=>"visible", "field_small_picture"=>"visible", "field_html_title"=>"hidden"));
                // Array of required fields (used for audit module ONLY)
        $vMod->SetOption("audit_required_fields",  Array());
                // Audit changes made in admin interface
        $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
                // Send notification on user's item changing
        $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
                // Audit action handling rules
###        $Core->SetOptionInherited($vMod, 'audit_actions_handling', 'srv_audit', 'audit_actions_handling');
        $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
                // Additional template file for spec block
        $vMod->SetOption("spec_block_template",    "");
        $vMod->SetOption("spec_id_pages",          Array(-1));
        $vMod->SetOption('spec_cat_id_pages', array(-1));
        $vMod->SetOption('mod_id_pages', array(-2, 0));
        $vMod->SetOption('mod_cat_id_pages', array(-2, 0));
        if($isCoreV5){
            // Small block view mode "usual" or "calendar"
            $vMod->SetOption("small_view_mode", "usual");
        }else{
            $vMod->SetOption('small_number_items', 4);
            $vMod->SetOption('small_grp_by_cat', FALSE);
                    // Sort field of categories "name", "position"
            $vMod->SetOption("small_categories_sort_col",   "header");
                    // Sort dimension of categories "asc", "desc"
            $vMod->SetOption("small_categories_sort_dim",   "asc");
                    // Sort field of articles "date", "header"
            $vMod->SetOption("small_items_sort_col",        "date_created");
                    // Sort dimension of articles "asc", "desc"
            $vMod->SetOption("small_items_sort_dim",        "desc");
        }

        $vMod->SetOption('page_size_small', 3);
                // number cols in body_filtered mode
        $vMod->SetOption("body_filtered_cols", 1);
                // number of page items in body_filtered mode
        $vMod->SetOption("body_filtered_page_size", 10);
                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
        // Disable search engine indexing for following cases
        $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
        // Add date-prefix to URL
        $vMod->SetOption("add_date_prefix", false);

    // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
    $vMod->SetOption("show_subitems",              -1);
    // The number of sub items, after which is inserted splitter, 0 - no splitter
    $vMod->SetOption("subitems_splitter_period",    0);
    // Count of subitems' columns per page
    $vMod->SetOption("subitems_cols",               1);
    // #CMS-11147
    $vMod->SetOption('subitems_grp_by_cat', TRUE);
    // Sort field of articles "date", "header"
    $vMod->SetOption("front_subitem_sort_col",     "date_created");
    // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("front_subitem_sort_dim",     "desc");
}
// } [ami_multifeeds|news]
// [ami_multifeeds|news|cat] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // ARTICLES CATEGORIES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
            // Suport multi pages

    // 'ext_image' extension options {

            // Array with available pictures
###                $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
    $vMod->SetOption('ext_img_fields', array('ext_img', 'ext_img_popup', 'ext_img_small'));
            // Type of picture, which will be shown in admin item's list:
            // "none", "picture", "popup_picture", "small_picture"
    $Core->TTlI1ll(
        $vMod,
        'ext_img_list_col',
        'ext_images',
        'col_picture_type',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
            // Picture generator options
    ###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
    $vMod->SetOption('ext_img_creatable', array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $Core->TTlI1ll(
        $vMod,
        'ext_img_source',
        'ext_images',
        'prior_source_picture',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
    $Core->TTlI1ll($vMod, 'ext_img_maxwidth', 'ext_images', 'picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_maxheight', 'ext_images', 'picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxwidth', 'ext_images', 'popup_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxheight', 'ext_images', 'popup_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxwidth', 'ext_images', 'small_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxheight', 'ext_images', 'small_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_create_bigger', 'ext_images', 'generate_bigger_image');

    // } 'ext_image' extension options

            // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
    $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
            // Default category: "all", "none", "NN" - id of category
    //$vMod->SetOption("default_category",        "all");
            // Module extensions 'ext_reindex', 'ext_rating'
    $vMod->SetOption("extensions", array('ext_reindex'));
            // Count of categories per page
    $vMod->SetOption("page_size",               10);
            // Sort field of categories "name"
    $vMod->SetOption("page_sort_col",           "header");
            // Sort dimension of categories "asc", "desc"
    $vMod->SetOption("page_sort_dim",           "asc");
            // Sort field of categories "name"
    $vMod->SetOption("front_page_sort_col",     "header");
            // Sort dimension of categories "asc", "desc"
    $vMod->SetOption("front_page_sort_dim",     "asc");
            // Count of categories' columns per page
    $vMod->SetOption("cols",                    2);
            // Show empty categories
    $vMod->SetOption("show_empty_cats",         false);
            // Fill empty description/body with announce on details page
    $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description', true, false);
            // Show urgent elements at pages
//                $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
    $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

            // Show advertisement statistics counter in admin's list table
    $vMod->SetOption("show_adv_stat_columns",    false);
            // Show advertisement place name in admin's list table
    $vMod->SetOption("show_adv_place_columns",    false);

    $vMod->SetOption("average_cat_rating", true);
    $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
    $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');

    /*        // Displayed fields' properties (used for audit module ONLY)
    $vMod->SetOption("audit_displayed_fields", Array("field_cdate"=>"visible", "field_mdate"=>"visible", "field_name"=>"visible", "field_announce"=>"visible", "field_body"=>"visible", "field_filename"=>"visible"));
            // Array of required fields (used for audit module ONLY)
    $vMod->SetOption("audit_required_fields",  Array());*/
            // Audit changes made in admin interface
    $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
            // Send notification on user's item changing
    $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
            // Audit action handling rules
    $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
            // 404 header for not found pages
    $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
}

// } [ami_multifeeds|news|cat]
// [ami_multifeeds|blog] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // blog module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    $isCoreV5 = $oDeclarator->getAttr($modName, 'core_v5', FALSE);
    $vMod->SetOption('page_size', $Core->GetOption('default_page_size'));
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption('front_page_sort_dim', 'desc');
    $vMod->SetOption('page_sort_dim_small', 'desc');
    $vMod->SetOption('cols', 1);

    $vMod->SetOption('use_categories', FALSE);
    if($vMod->GetOption('use_categories')){
        $vMod->SetOption('stop_arg_names', $Core->GetModProperty('##modId##_cat', 'stop_arg_names'));
    }else{
        $vMod->SetOption("stop_arg_names", $Core->GetModProperty('##modId##', 'stop_arg_names'));
    }

    $vMod->SetOption("subitems_total_items_limit", 30);
    $vMod->SetOption("spec_total_items_limit", 30);

    $vMod->SetOption('body_cats_cols', 1);
    $vMod->SetOption('multicat', FALSE);
    $vMod->SetOption('multicat_in_body_details', FALSE);
    $vMod->SetOption('show_last_items', 10);

    // Suport multi pages
    $vMod->SetOption("multi_page",              true);
    // Sort field of blog "date", "header", "position", "votes_rate"
    $vMod->SetOption("front_page_sort_col", "date_created");
    // Sort field of blog in specblock "date", "header", "position", "votes_rate"
    $vMod->SetOption("page_sort_col_small", "date_created");
    // Count of blog columns on spec block
    $vMod->SetOption("body_small_cols", 1);

    // 'ext_image' extension options {

    ###        $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
    $vMod->SetOption('ext_img_fields', array('ext_img', 'ext_img_popup', 'ext_img_small'));
            // Type of picture, which will be shown in admin item's list:
            // "none", "picture", "popup_picture", "small_picture"
    $Core->TTlI1ll(
        $vMod,
        'ext_img_list_col',
        'ext_images',
        'col_picture_type',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
            // Picture generator options
    ###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
    $vMod->SetOption('ext_img_creatable', array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $Core->TTlI1ll(
        $vMod,
        'ext_img_source',
        'ext_images',
        'prior_source_picture',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
    $Core->TTlI1ll($vMod, 'ext_img_maxwidth', 'ext_images', 'picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_maxheight', 'ext_images', 'picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxwidth', 'ext_images', 'popup_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxheight', 'ext_images', 'popup_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxwidth', 'ext_images', 'small_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxheight', 'ext_images', 'small_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_create_bigger', 'ext_images', 'generate_bigger_image');

    // } 'ext_image' extension options

    // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
    $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
    // Outputs full announce in small mode
    $vMod->SetOption("announce_mode_full",      false);
    // max length of announce string on small block. [1..250]
    $vMod->SetOption("announce_small_length",      120);
    // max length of header string on small block. [1..100]
    $vMod->SetOption("header_small_length",        100);
    // type of archiving method: "manual", "date"
    $vMod->SetOption("archive_type",               "manual");
    // all $..._ARCHIVE_PERIOD are strings containing an english date format
    // Valid only when archive type is date
    // Examples:
    // "10 September 2000"
    // "-1 day"
    // "-1 week"
    // "-12 month"
    $vMod->SetOption("archive_period",             "-12 month");
    // type of items to show: "all", "active", "archive"
    $vMod->SetOption("show_type",                  "all");
    // Currently available "ext_twist_prevention", "ext_discussion", "ext_rss", "ext_tags")
    $vMod->SetOption('extensions', array('ext_twist_prevention', 'ext_reindex', 'ext_discussion', 'ext_rating', 'ext_rss'));
    // Fill empty description/body with announce on details page
    $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description', false, true);
    // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
    $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));
    // Set pages view in pager (numbers or bounds)
    $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');
    // Diplay or not on front module items having date in the future
    $Core->TTlI1ll($vMod, 'hide_future_items', 'common_settings', 'hide_future_items');

    // RSS extension blog module constants
    // number of RSS channel elements
    $Core->TTlI1ll($vMod, 'rss_num_elements', 'ext_rss', 'rss_num_elements');
    // display on page
    $Core->TTlI1ll($vMod, 'rss_display_page', 'ext_rss', 'rss_display_page');
    // type of display image on page
    $Core->TTlI1ll($vMod, 'rss_display_image', 'ext_rss', 'rss_display_image');
    // rss channel title (only to module) = field from blog
    $Core->TTlI1ll($vMod, 'rss_channel_title', 'core_module', 'company_name');
    // rss channel description (only to module)
    $vMod->SetOption("rss_channel_description",       "");
    // rss channel webmaster (only to module)
    $Core->TTlI1ll($vMod, 'rss_channel_webmaster', 'ext_rss', 'rss_channel_webmaster');
    // rss channel generator (only to module, god_mode)
    $Core->TTlI1ll($vMod, 'rss_channel_generator', 'ext_rss', 'rss_channel_generator');
    // rss item title (only to module)
    $vMod->SetOption("rss_item_title",                "rss_header");
    // rss item description (only to module) = field
    $vMod->SetOption("rss_item_description",          "rss_announce");
    // rss item yandex fulltext (only to module) = field
    $vMod->SetOption("rss_item_fulltext",             "none");
    // rss item enclosure (only to module) = field from blog
    $vMod->SetOption("rss_item_enclosure",            "rss_small_image");
    // rss item guid (only to module) = field
    $vMod->SetOption("rss_item_guid",                 "none");
    // rss item guid (only to module) = field
    $vMod->SetOption("rss_item_pubdate",              "rss_c_date");

    // rss channel (only to module, list of files in "_img/")
    $Core->TTlI1ll($vMod, 'rss_channel_image', 'ext_rss', 'rss_channel_image');
    // rss channel (only to module, list of files in "_img/")
    $Core->TTlI1ll($vMod, 'rss_channel_style', 'ext_rss', 'rss_channel_style');
    //-- end RSS
    // Force expire time (strtotime format), "" - auto
    $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');

    $vMod->SetOption("filter_pages_setup",  Array(
            "body_filtered"=>Array("date_from", "date_to"))
    );


//// Obsolete 0302 version options

    // {{{ twist prevention extension options

    // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
    $vMod->SetOption('action_period', '5 second');
    // show captcha (image to prevent from robots actions)
    $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
    // check captcha without page reloading
    $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
    // add "_twist" postfix to module action in case of twist detection
    $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
    // add status message in case of twist detection
    $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');

    // }}}
    // {{{ discussion extension

    if($isCoreV5){
        // Show blog body, when forum
        $Core->TTlI1ll($vMod, 'show_body_when_forum', 'ext_discussion', 'show_body_when_forum');
    }
    // Show forum_count_replies, true, false
    $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
    // Show forum_count_topics, true, false
//        $Core->SetOptionInherited($vMod, 'show_forum_count_topics', 'ext_discussion', 'show_forum_count_topics');
    // Show forum links in blog list, true, false
    $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
    // Show forum links in small blog block, true, false
    $Core->TTlI1ll($vMod, 'show_forum_link_in_small', 'ext_discussion', 'show_forum_link_in_small');
    // Show forum at element details page right away
    $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details');
    // Display element numbers in messages list
    $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
    // Discussion admin notification
    $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
    // Webmaster email
    $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
    // Use tree view
    $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');
    // Anonymous user email
//        $Core->SetOptionInherited($vMod, 'forum_anonymous_user_email', 'ext_discussion', 'forum_anonymous_user_email');
    // Are attaches allowed
//        $Core->SetOptionInherited($vMod, 'forum_attaches_allowed', 'ext_discussion', 'forum_attaches_allowed');
    // False - one level tree messages, true - normal tree
//        $Core->SetOptionInherited($vMod, 'forum_only_one_level', 'ext_discussion', 'forum_only_one_level');
    // Set type of pager, "items", "topics"
//        $Core->SetOptionInherited($vMod, 'forum_pager_type', ext_discussion', 'forum_pager_type');
    // Count of forum items per page
//        $Core->SetOptionInherited($vMod, 'forum_page_size', 'ext_discussion', 'forum_page_size');
    // Only one topic per item
//        $Core->SetOptionInherited($vMod, 'forum_multi_topics', 'ext_discussion', 'forum_multi_topics');

    // }}}

//// End of obsolete 0302 ver options

    // #CMS-11482, ext_rating {

    if($GLOBALS['Core']->IsInstalled('ext_rating')){
        $Core->TTlI1ll($vMod, 'form_template', 'ext_rating', 'form_template', TRUE, 'rating_like.tpl');
    }

    // } ext_rating

    // Show body browse
    $vMod->SetOption("show_body_browse", TRUE);
    // Count of pictures per page for browse list
    $vMod->SetOption("body_browse_page_size", 3);
    // Browse active item position
    $vMod->SetOption("browse_active_item_position",2);
    // Count of pictures columns on browse mode
    $vMod->SetOption("body_browse_cols", 1);
    // Adv place initial parameters. Should not be any but -1 because this is callback parameters
    $vMod->SetOption("adv_place_list",  -1);
    $vMod->SetOption("adv_place_details",  -1);
    $vMod->SetOption("adv_place_sb",  -1);
    // Show advertisement statistics counter in admin's list table
    $vMod->SetOption("show_adv_stat_columns",    false);
    // Show advertisement place name in admin's list table
    $vMod->SetOption("show_adv_place_columns",    false);

    $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
    $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
    // Displayed fields' properties (used for audit module ONLY)
    $vMod->SetOption("audit_displayed_fields", Array("field_date"=>"visible", "field_body"=>"visible", "field_picture"=>"visible", "field_popup_picture"=>"visible", "field_small_picture"=>"visible", "field_html_title"=>"hidden"));
    // Array of required fields (used for audit module ONLY)
    $vMod->SetOption("audit_required_fields",  Array());
    // Audit changes made in admin interface
    $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
    // Send notification on user's item changing
    $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
    // Audit action handling rules
###        $Core->SetOptionInherited($vMod, 'audit_actions_handling', 'srv_audit', 'audit_actions_handling');
    $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
    // Additional template file for spec block
    $vMod->SetOption("spec_block_template",    "");
    $vMod->SetOption("spec_id_pages",          Array(-1));
    $vMod->SetOption('spec_cat_id_pages', array(-1));
    $vMod->SetOption('mod_id_pages', array(-2, 0));
    $vMod->SetOption('mod_cat_id_pages', array(-2, 0));
    if($isCoreV5){
        // Small block view mode "usual" or "calendar"
        $vMod->SetOption("small_view_mode", "usual");
    }else{
        $vMod->SetOption('small_number_items', 4);
        $vMod->SetOption('small_grp_by_cat', FALSE);
                // Sort field of categories "name", "position"
        $vMod->SetOption("small_categories_sort_col",   "header");
                // Sort dimension of categories "asc", "desc"
        $vMod->SetOption("small_categories_sort_dim",   "asc");
                // Sort field of articles "date", "header"
        $vMod->SetOption("small_items_sort_col",        "date_created");
                // Sort dimension of articles "asc", "desc"
        $vMod->SetOption("small_items_sort_dim",        "desc");
    }

    $vMod->SetOption('page_size_small', 3);
    // number cols in body_filtered mode
    $vMod->SetOption("body_filtered_cols", 1);
    // number of page items in body_filtered mode
    $vMod->SetOption("body_filtered_page_size", 10);
    // 404 header for not found pages
    $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
    // Disable search engine indexing for following cases
    $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
    // Add date-prefix to URL
    $vMod->SetOption("add_date_prefix", false);

    // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
    $vMod->SetOption("show_subitems",              -1);
    // The number of sub items, after which is inserted splitter, 0 - no splitter
    $vMod->SetOption("subitems_splitter_period",    0);
    // Count of subitems' columns per page
    $vMod->SetOption("subitems_cols",               1);
    // #CMS-11147
    $vMod->SetOption('subitems_grp_by_cat', TRUE);
    // Sort field of articles "date", "header"
    $vMod->SetOption("front_subitem_sort_col",     "date_created");
    // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("front_subitem_sort_dim",     "desc");
}

// } [ami_multifeeds|blog]
// [ami_multifeeds|blog|cat] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // ARTICLES CATEGORIES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);

    // 'ext_image' extension options {

    ###        $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
    $vMod->SetOption('ext_img_fields', array('ext_img', 'ext_img_popup', 'ext_img_small'));
            // Type of picture, which will be shown in admin item's list:
            // "none", "picture", "popup_picture", "small_picture"
    $Core->TTlI1ll(
        $vMod,
        'ext_img_list_col',
        'ext_images',
        'col_picture_type',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
            // Picture generator options
    ###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
    $vMod->SetOption('ext_img_creatable', array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $Core->TTlI1ll(
        $vMod,
        'ext_img_source',
        'ext_images',
        'prior_source_picture',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
    $Core->TTlI1ll($vMod, 'ext_img_maxwidth', 'ext_images', 'picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_maxheight', 'ext_images', 'picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxwidth', 'ext_images', 'popup_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxheight', 'ext_images', 'popup_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxwidth', 'ext_images', 'small_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxheight', 'ext_images', 'small_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_create_bigger', 'ext_images', 'generate_bigger_image');

    // } 'ext_image' extension options

    // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
    $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
    // Default category: "all", "none", "NN" - id of category
    //$vMod->SetOption("default_category",        "all");
    // Module extensions 'ext_reindex', 'ext_rating'
    $vMod->SetOption("extensions", array('ext_reindex'));
    // Count of categories per page
    $vMod->SetOption("page_size",               10);
    // Sort field of categories "name"
    $vMod->SetOption("page_sort_col",           "header");
    // Sort dimension of categories "asc", "desc"
    $vMod->SetOption("page_sort_dim",           "asc");
    // Sort field of categories "name"
    $vMod->SetOption("front_page_sort_col",     "header");
    // Sort dimension of categories "asc", "desc"
    $vMod->SetOption("front_page_sort_dim",     "asc");
    // Count of categories' columns per page
    $vMod->SetOption("cols",                    2);
    // Show empty categories
    $vMod->SetOption("show_empty_cats",         false);
    // Fill empty description/body with announce on details page
    $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description', true, false);
    // Show urgent elements at pages
//                $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
    $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

    // Show advertisement statistics counter in admin's list table
    $vMod->SetOption("show_adv_stat_columns",    false);
    // Show advertisement place name in admin's list table
    $vMod->SetOption("show_adv_place_columns",    false);

    $vMod->SetOption("average_cat_rating", true);
    $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
    $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');

    /*        // Displayed fields' properties (used for audit module ONLY)
    $vMod->SetOption("audit_displayed_fields", Array("field_cdate"=>"visible", "field_mdate"=>"visible", "field_name"=>"visible", "field_announce"=>"visible", "field_body"=>"visible", "field_filename"=>"visible"));
            // Array of required fields (used for audit module ONLY)
    $vMod->SetOption("audit_required_fields",  Array());*/
    // Audit changes made in admin interface
    $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
    // Send notification on user's item changing
    $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
    // Audit action handling rules
    $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
    // 404 header for not found pages
    $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
}

// } [ami_multifeeds|blog|cat]
// [ami_fake|blog|archive] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('front_page_sort_col', 'id');
    $vMod->SetOption('front_page_sort_dim', 'desc');
    $vMod->SetOption('page_sort_col', 'id');
    // Archive size, string ( strtotime() format)
    $vMod->SetOption("stop_arg_names", array("id"=>"##parentModId##"));
    $vMod->SetOption("archive_size",               "-30 year");
    // Archive period, string
    // N days, N months, N years, week
    // N - integer, greater than zero
    $vMod->SetOption("archive_period",             "1 year");
    // Show news counters, true, false
    $vMod->SetOption("show_count_news",            true);
    // Archive page size, integer
    $vMod->SetOption("archive_page_size",          10);
    // News page size, integer
    $vMod->SetOption("page_size",                  10);
    // Show only archived news (otherwise - all news), true, false
    $vMod->SetOption("show_only_archived",         false);
    // Show news body, when forum
    $Core->TTlI1ll($vMod, 'show_body_when_forum', 'ext_discussion', 'show_body_when_forum');
    // Show forum_count_replies, true, false
    $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
    // Show forum_count_topics, true, false
    // $Core->SetOptionInherited($vMod, 'show_forum_count_topics', 'ext_discussion', 'show_forum_count_topics');
    // Show forum links in news list, true, false
    $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
    // Show forum at element details page right away
    $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details');
    // Display element numbers in messages list
    $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
    // Discussion admin notification
    $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
    // Webmaster email
    $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
    // Use tree view
    $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');
    // Anonymous user email
    // $Core->SetOptionInherited($vMod, 'forum_anonymous_user_email', 'ext_discussion', 'forum_anonymous_user_email');
    // Are attaches allowed
    // $Core->SetOptionInherited($vMod, 'forum_attaches_allowed', 'ext_discussion', 'forum_attaches_allowed');
    // False - one level tree messages, true - normal tree
    // $Core->SetOptionInherited($vMod, 'forum_only_one_level', 'ext_discussion', 'forum_only_one_level');
    // Set type of pager, "items", "topics"
    // $Core->SetOptionInherited($vMod, 'forum_pager_type', 'ext_discussion', 'forum_pager_type');
    // Count of forum items per page
    // $Core->SetOptionInherited($vMod, 'forum_page_size', 'ext_discussion', 'forum_page_size');
    // Currently available "ext_discussion"
    $vMod->SetOption("extensions", array() );
    // Force expire time (strtotime format), "" - auto
    $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');
    // Disable search engine indexing for following cases
    $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
}

// } [ami_fake|blog|archive]
// [ami_multifeeds|faq] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // FAQ module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                // Suport multi pages
        $vMod->SetOption("multi_page",              true);

                //Use categories
        $vMod->SetOption('use_categories', true);
        if($vMod->GetOption('use_categories')){
            $vMod->SetOption('stop_arg_names', $Core->GetModProperty('##modId##_cat', 'stop_arg_names'));
        }else{
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty('##modId##', 'stop_arg_names'));
        }
        $vMod->SetOption("page_sort_col", "answered");
        $vMod->SetOption("page_sort_dim", "asc");
        $vMod->SetOption("front_page_sort_col", "date_created");
        $vMod->SetOption("front_page_sort_dim", "desc");

        $vMod->SetOption("multicat",                   false);
                // Show list of categories inside item details
        $vMod->SetOption("multicat_in_body_details",   false);
        $vMod->SetOption("show_last_items",            10);

                // confirm email
        $Core->TTlI1ll($vMod, 'confirm_from_email', 'core_module', 'company_email');
                // email address that will receive questions from the site
        $Core->TTlI1ll($vMod, 'faq_email', 'core_module', 'company_email');
        $Core->TTlI1ll($vMod, 'company_robot_email', 'core_module', 'company_robot_email');
        $Core->TTlI1ll($vMod, 'company_name', 'core_module', 'company_name');

        $vMod->SetOption("page_size",                  10);

                // Count of categories' columns per page
        $vMod->SetOption("body_cats_cols",             1);
                // Count of questions columns on spec block
        $vMod->SetOption("body_small_cols",            1);
                // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
        $vMod->SetOption("show_subitems",              -1);
                // The number of sub items, after which is inserted splitter, 0 - no splitter
        $vMod->SetOption("subitems_splitter_period",    0);
                // Count of subitems' columns per page
        $vMod->SetOption("subitems_cols",               1);
                // Count of items, which will be shown. If category(is) is specified, then count of items from each category.
        $vMod->SetOption("small_number_items",          5);
                // List of categories id, from which the items will be shown
                //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->SetOption("small_category_ids",          0);
                // Number categories, from which the items will be shown.
                // Only when option "small_category_ids" eq. 0.
                // (if 0  and option "small_category_ids" eq. 0, then categories will be not specified)
        $vMod->SetOption("small_number_categories",     0);
                // Sort field of categories "name", "position"
        $vMod->SetOption("small_categories_sort_col",   "header");
                // Sort dimension of categories "asc", "desc"
        $vMod->SetOption("small_categories_sort_dim",   "asc");
                // Sort field of articles "date", "header"
        $vMod->SetOption("small_items_sort_col",        "date_created");
                // Sort dimension of articles "asc", "desc"
        $vMod->SetOption("small_items_sort_dim",        "desc");
                // Sort field of FAQ "date", "subject"
        $vMod->SetOption("front_subitem_sort_col",     "date_created");
                // Sort dimension of FAQ "asc", "desc"
        $vMod->SetOption("front_subitem_sort_dim",     "desc");
                // Sort field of FAQ "date", "subject"
        $vMod->SetOption("front_page_sort_col",        "date_created");
                // Sort dimension of FAQ "asc", "desc"
        $vMod->SetOption("front_page_sort_dim",        "desc");

        $vMod->SetOption("sort_pages_setup",  Array(
                "body_items;body_urgent_items"=>Array("date_created", "subject"),
                "body_cats;body_urgent_cats"=>Array("header", "position")
        ));
        $vMod->SetOption("required_fields", array ("author", "email", "question"));

        // question list layout:
        // "link_to_same_page", "link_to_separate_page", "no_links"
        $vMod->SetOption("question_list_layout",     "link_to_separate_page");

         // Question number type: "arabic", "roman" or "no_numbering"
        $vMod->SetOption("question_number_type", "bullet");

        // FAQ addition by registered users only:
        $vMod->SetOption("faq_add_by_registered_only",     false);

        // default value for the "Send the answer to author"
        $vMod->SetOption("send_answer_to_author",     true);
                // Currently available "ext_twist_prevention")
        $vMod->SetOption("extensions", array("ext_twist_prevention", 'ext_reindex'));
                // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));
        $vMod->SetOption("html_title_template",    "##object_name## - ##cat_name## - ##current_page_name## | ##site_title##");
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
                // Additional template file for spec block
        $vMod->SetOption("spec_block_template",    "");
                // Additional template file for spec block
        $vMod->SetOption("spec_id_pages",          Array(-1));
        $vMod->SetOption('spec_cat_id_pages', array(-1));
        $vMod->SetOption('mod_id_pages', array(-2, 0));
        $vMod->SetOption('mod_cat_id_pages', array(-2, 0));

        // {{{ twist prevention extension options

                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');
                // Force expire time (strtotime format), "" - auto
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');

        // }}}
                // Set pages view in pager (numbers or bounds)
        $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');
               // Diplay or not on front module items having date in the future
        $Core->TTlI1ll($vMod, 'hide_future_items', 'common_settings', 'hide_future_items');
                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
        // Disable search engine indexing for following cases
        $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
}

// } [ami_multifeeds|faq]
// [ami_multifeeds|faq|cat] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // FAQ CATEGORIES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);

        $vMod->SetOption("admin_as_submenu_caption", true);
        // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');

        // Default category: "all", "none", "NN" - id of category
        //$vMod->SetOption("default_category",        "all");
                        // Count of categories per page
        $vMod->SetOption("page_size",               10);
                        // Sort field of categories "name", "position"
        $vMod->SetOption("page_sort_col",           "position");
                        // Sort dimension of categories "asc", "desc"
        $vMod->SetOption("page_sort_dim",           "asc");
                        // Sort field of categories "name", "position"
        $vMod->SetOption("front_page_sort_col",     "position");
                        // Sort dimension of categories "asc", "desc"
        $vMod->SetOption("front_page_sort_dim",     "asc");
                        // Count of categories' columns per page
        $vMod->SetOption("cols",                    2);
                        // Show empty categories
        $vMod->SetOption("show_empty_cats",         false);
                // Fill empty description/body with announce on details page
        $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description', true, false);
                // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

         // Category number type: "arabic", "roman", "bullet" or "no_numbering"
        $vMod->SetOption("category_number_type",         "bullet");
        // category (subject) list layout:
        // "link_to_same_page" or "no_links"
        $vMod->SetOption("cat_list_layout",     "link_to_same_page");

        // Show counters of questions in subjects:
        $vMod->SetOption("show_counters",     true);
        $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');

                // Extensions
        $vMod->SetOption("extensions", array('ext_reindex'));
                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
}

// } [ami_multifeeds|faq|cat]
// [ami_multifeeds|photoalbum] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // PHOTOALBUM module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);

                // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                //Use categories
        $vMod->SetOption("use_categories",             true);
        if($vMod->GetOption( "use_categories")){
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty("##modId##_cat", "stop_arg_names"));
        } else {
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty("##modId##", "stop_arg_names"));
        }
        $vMod->SetOption("subitems_total_items_limit", 30);
        $vMod->SetOption("spec_total_items_limit", 30);

                // Count of pictures per page
        $vMod->SetOption("page_size",                  12);
                // Sort field of pictures "date", "header"
        $vMod->SetOption("page_sort_col",              "date_created");
                // Sort dimension of pictures "asc", "desc"
        $vMod->SetOption("page_sort_dim",              "desc");
                // Sort field of pictures "date", "header"
        $vMod->SetOption("front_subitem_sort_col",     "date_created");
                // Sort dimension of pictures "asc", "desc"
        $vMod->SetOption("front_subitem_sort_dim",     "desc");
                // Sort field of pictures "date", "header"
        $vMod->SetOption("front_page_sort_col",        "date_created");
                // Sort dimension of pictures "asc", "desc"
        $vMod->SetOption("front_page_sort_dim",        "desc");
                // Suport multi pages
        $vMod->SetOption("multi_page",                 true);
                // Show list of categories inside category
        $vMod->SetOption("multicat",                   false);
                // Show list of categories inside item details
        $vMod->SetOption("multicat_in_body_details",   false);
                // Show N last items, when url parametr "show_last=1" is present
                // If N=0, then working in normal mode
        $vMod->SetOption("show_last_items",            10);

                // Show forum_count_replies, true, false
        $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
                // Show forum_count_topics, true, false
//        $Core->SetOptionInherited($vMod, 'show_forum_count_topics', 'ext_discussion', 'show_forum_count_topics');
                // Show forum links in news list, true, false
        $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
                // Show forum links in small news block, true, false
        $Core->TTlI1ll($vMod, 'show_forum_link_in_small', 'ext_discussion', 'show_forum_link_in_small');
                // Show forum at element details page right away
        $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details', TRUE, TRUE);
                // Display element numbers in messages list
        $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
                // Discussion admin notification
        $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
                // Webmaster email
        $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
                // Use tree view
        $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');
                // Anonymous user email
//        $vMod->SetOption("forum_anonymous_user_email",       "anonymous@localhost.ru");
                // Are attaches allowed
//        $Core->SetOptionInherited($vMod, 'forum_attaches_allowed', 'ext_discussion', 'forum_attaches_allowed');
                // False - one level tree messages, true - normal tree
//        $Core->SetOptionInherited($vMod, 'forum_only_one_level', 'ext_discussion', 'forum_only_one_level');
                // Set type of pager, "items", "topics"
//        $Core->SetOptionInherited($vMod, 'forum_pager_type', 'ext_discussion', 'forum_pager_type');
                // Count of forum items per page
//        $Core->SetOptionInherited($vMod, 'forum_page_size', 'ext_discussion', 'forum_page_size');
                // Only one topic per item
//        $Core->SetOptionInherited($vMod, 'forum_multi_topics', 'ext_discussion', 'forum_multi_topics');

        // #CMS-11482, ext_rating {

        if($GLOBALS['Core']->IsInstalled('ext_rating')){
            $Core->TTlI1ll($vMod, 'form_template', 'ext_rating', 'form_template', TRUE, 'rating_like.tpl');
        }

        // } ext_rating

                // Count of categories' columns per page
        $vMod->SetOption("body_cats_cols", 3);
                // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
        $vMod->SetOption("cols", 3);
                // Count of pictures columns on spec block
        $vMod->SetOption("body_small_cols",            1);
                // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
        $vMod->SetOption("show_subitems",              -1);
                // The number of sub items, after which is inserted splitter, 0 - no splitter
        $vMod->SetOption("subitems_splitter_period",    0);
                // Count of subitems' columns per page
        $vMod->SetOption("subitems_cols",               1);
        $vMod->SetOption('subitems_grp_by_cat', TRUE);
                // Count of items, which will be shown. If category(is) is specified, then count of items from each category.
        $vMod->SetOption("small_number_items",          3);
                // List of categories id, from which the items will be shown
                //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->SetOption("small_category_ids",          0);
        if($oDeclarator->getAttr($modName, 'core_v5')){
            // Number categories, from which the items will be shown.
            // Only when option "small_category_ids" eq. 0.
            // (if 0  and option "small_category_ids" eq. 0, then categories will be not specified)
            $vMod->SetOption('small_number_categories', 0);
        }else{
            $vMod->SetOption('small_grp_by_cat', FALSE);
        }
                // Sort field of categories "name", "position"
        $vMod->SetOption("small_categories_sort_col",   "header");
                // Sort dimension of categories "asc", "desc"
        $vMod->SetOption("small_categories_sort_dim",   "asc");
                // Sort field of pictures "date", "header"
        $vMod->SetOption("small_items_sort_col",        "date_created");
                // Sort dimension of pictures "asc", "desc"
        $vMod->SetOption("small_items_sort_dim",        "desc");
                // Currently available "ext_discussion"
        $vMod->SetOption('extensions',
            array(
                'ext_images',
                'ext_twist_prevention',
                'ext_reindex',
                'ext_discussion',
                'ext_rating'
            )
        );
                // Fill empty description/body with announce on details page
        $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description');
                // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));
                // Diplay or not on front module items having date in the future
        $Core->TTlI1ll($vMod, 'hide_future_items', 'common_settings', 'hide_future_items');

                // Sort fields for some body types:
                // Array(
                //        "{body_type1};..;{body_typeN}"=>Array({field1}, ...{fieldN}),
                //        ...
                //        "{body_type(N+1)};..;{body_type(N+M)}"=>Array({field1}, ...{fieldN})
                //      )
                // Currently available body types: body_items, body_cats.
                // Currently available fileds for body_items: "header", "date"
                // Currently available fileds for body_cats: "name", "position"
        $vMod->SetOption("sort_pages_setup",  Array(
                "body_items;body_urgent_items"=>Array(),
                "body_cats;body_urgent_cats"=>Array()
        ));

    // 'ext_image' extension options {

    ###        $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
    $vMod->SetOption('ext_img_fields', array('ext_img', 'ext_img_popup', 'ext_img_small'));
            // Type of picture, which will be shown in admin item's list:
            // "none", "picture", "popup_picture", "small_picture"
    $Core->TTlI1ll(
        $vMod,
        'ext_img_list_col',
        'ext_images',
        'col_picture_type',
        TRUE,
        'ext_img_small',
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
            // Picture generator options
    ###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
    $vMod->SetOption('ext_img_creatable', array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $Core->TTlI1ll(
        $vMod,
        'ext_img_source',
        'ext_images',
        'prior_source_picture',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
    $vMod->SetOption('ext_img_maxwidth', 600);
    $vMod->SetOption('ext_img_maxheight', 600);
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxwidth', 'ext_images', 'popup_picture_maxwidth', TRUE, 800);
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxheight', 'ext_images', 'popup_picture_maxheight', TRUE, 800);
    $Core->TTlI1ll($vMod, 'ext_img_small_maxwidth', 'ext_images', 'small_picture_maxwidth', TRUE, 275);
    $Core->TTlI1ll($vMod, 'ext_img_small_maxheight', 'ext_images', 'small_picture_maxheight', TRUE, 275);
    $Core->TTlI1ll($vMod, 'ext_img_create_bigger', 'ext_images', 'generate_bigger_image');

    // } 'ext_image' extension options

                // Set static watermark
        $vMod->SetOption("static_watermark", "_mod_files/ce_images/icons/static_watermark.gif");
                // Position, where watermark should be created. Allowed values: "upleft", "upright", "center", "downleft", "downright", "tile", "none"
        $vMod->SetOption("static_watermark_method", "downright");
                // Alpha level of layer image transparency [0-127]
        $vMod->SetOption("static_watermark_alpha", "85");
                // Show body browse
        $vMod->SetOption("show_body_browse", true);
                // Count of pictures per page for browse list
        $vMod->SetOption("body_browse_page_size",      9);
                // Browse active item position
        $vMod->SetOption("browse_active_item_position",5);
                // Count of pictures columns on browse mode
        $vMod->SetOption("body_browse_cols",           3);
        $vMod->SetOption("html_title_template",    "##object_name## - ##cat_name## - ##current_page_name## | ##site_title##");
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
                // Additional template file for spec block
        $vMod->SetOption("spec_block_template",    "");
                // Additional template file for spec block
        $vMod->SetOption("spec_id_pages",          Array(-1));
        $vMod->SetOption('spec_cat_id_pages', array(-1));
        $vMod->SetOption('mod_id_pages', array(-2, 0));
        $vMod->SetOption('mod_cat_id_pages', array(-2, 0));
        // {{{ twist prevention extension options

                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');
                // Force expire time (strtotime format), "" - auto
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');

        /*        // Displayed fields' properties (used for audit module ONLY)
        $vMod->SetOption("audit_displayed_fields", Array("field_cdate"=>"visible", "field_mdate"=>"visible", "field_name"=>"visible", "field_announce"=>"visible", "field_body"=>"visible", "field_filename"=>"visible"));
                // Array of required fields (used for audit module ONLY)
        $vMod->SetOption("audit_required_fields",  Array());*/
                // Audit changes made in admin interface
        $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
                // Send notification on user's item changing
        $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
                // Audit action handling rules
        $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));

        // }}}
                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
        // Disable search engine indexing for following cases
        $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');

        // Set pages view in pager (numbers or bounds)
        $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound', TRUE, TRUE);
}

// } [ami_multifeeds|photoalbum]
// [ami_multifeeds|photoalbum|cat] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // PHOTOALBUM CATEGORIES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
                        // Suport multi pages
                        // Type of picture, which will be shown in admin item's list:
                        // "none", "picture", "popup_picture", "small_picture"
                $vMod->SetOption("col_picture_type",    "small_picture");
                        // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
                $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                        // Default category: "all", "none", "NN" - id of category
                //$vMod->SetOption("default_category",        "all");
                        // Count of categories per page
                $vMod->SetOption("page_size",               16);
                        // Sort field of categories "name"
                $vMod->SetOption("page_sort_col",           "header");
                        // Sort dimension of categories "asc", "desc"
                $vMod->SetOption("page_sort_dim",           "asc");
                        // Sort field of categories "name"
                $vMod->SetOption("front_page_sort_col",     "header");
                        // Sort dimension of categories "asc", "desc"
                $vMod->SetOption("front_page_sort_dim",     "desc");
                        // Count of categories' columns per page
                $vMod->SetOption("cols",                    2);
                        // Show empty categories
                $vMod->SetOption("show_empty_cats",         false);
                       // Extensions: "ext_rating"
                $vMod->SetOption("extensions", array("ext_rating", 'ext_reindex','ext_images') );
                        // Show urgent elements at pages
//                $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
                $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

                      // Set album rating as average of its elements ratings
                $vMod->SetOption("average_cat_rating", true);
                $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
                $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');

                /*        // Displayed fields' properties (used for audit module ONLY)
                $vMod->SetOption("audit_displayed_fields", Array("field_cdate"=>"visible", "field_mdate"=>"visible", "field_name"=>"visible", "field_announce"=>"visible", "field_body"=>"visible", "field_filename"=>"visible"));
                        // Array of required fields (used for audit module ONLY)
                $vMod->SetOption("audit_required_fields",  Array());*/
                        // Audit changes made in admin interface
                $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
                        // Send notification on user's item changing
                $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
                        // Audit action handling rules
                $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));

    // 'ext_image' extension options {

    ###        $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
    $vMod->SetOption('ext_img_fields', array('ext_img', 'ext_img_popup', 'ext_img_small'));
            // Type of picture, which will be shown in admin item's list:
            // "none", "picture", "popup_picture", "small_picture"
    $Core->TTlI1ll(
        $vMod,
        'ext_img_list_col',
        'ext_images',
        'col_picture_type',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
            // Picture generator options
    ###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
    $vMod->SetOption('ext_img_creatable', array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $Core->TTlI1ll(
        $vMod,
        'ext_img_source',
        'ext_images',
        'prior_source_picture',
        FALSE,
        NULL,
        array('AmiExt_Image_Adm', 'convertOptionValue')
    );
    $vMod->SetOption('ext_img_maxwidth', 300);
    $vMod->SetOption('ext_img_maxheight',300);
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxwidth', 'ext_images', 'popup_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'ext_img_popup_maxheight', 'ext_images', 'popup_picture_maxheight');
    $Core->TTlI1ll($vMod, 'ext_img_small_maxwidth', 'ext_images', 'small_picture_maxwidth', TRUE, 275);
    $Core->TTlI1ll($vMod, 'ext_img_small_maxheight', 'ext_images', 'small_picture_maxheight', TRUE, 275);
    $Core->TTlI1ll($vMod, 'ext_img_create_bigger', 'ext_images', 'generate_bigger_image');

    // } 'ext_image' extension options

                // Set static watermark
        $vMod->SetOption("static_watermark", "_mod_files/ce_images/icons/static_watermark.gif");
                // Position, where watermark should be created. Allowed values: "upleft", "upright", "center", "downleft", "downright", "tile", "none"
        $vMod->SetOption("static_watermark_method", "downright");
                // Alpha level of layer image transparency [0-127]
        $vMod->SetOption("static_watermark_alpha", "85");
                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");

        // {{{ twist prevention extension options

                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');

        // }}}
        // {{{ discussion extension

                // Show forum_count_replies, true, false
        $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
                // Show forum_count_topics, true, false
        $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
                // Show forum at element details page right away
        $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details');
                // Display element numbers in messages list
        $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
                // Discussion admin notification
        $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
                // Webmaster email
        $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
                // Use tree view
        $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');
                // Are attaches allowed
//        $Core->SetOptionInherited($vMod, 'forum_attaches_allowed', 'ext_discussion', 'forum_attaches_allowed');
                // False - one level tree messages, true - normal tree

        // }}}
}

// } [ami_multifeeds|photoalbum|cat]
// [ami_data_exchange|photoalbum|data_exchange] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // PHOTOALBUM DATA EXCHANGE module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
                        // Import path
                        // used prefix - $MODULE_PICTURES_PATH
                $vMod->SetOption("import_path",            "_upload/");
                        // Import tmp path (for tmp files)
                        // used prefix - $MODULE_PICTURES_PATH
                $vMod->SetOption("import_tmp_path",        "_upload/tmp/");
                        // Export path
                        // used prefix - $MODULE_PICTURES_PATH
                $vMod->SetOption("export_path",            "_upload/tmp/");
                        // Files that users cannot upload
                $vMod->SetOption("forbidden_files", array ("exe", "pif", "bat", "scr", "reg", "cmd", "dll", "com", "lnk", "vbs", "php"));
                        // Save methods, currently available: "file", "email".
                $vMod->SetOption("export_save method",     "file");
                        // Import log file name
                        // used prefix - $LOG_PATH
                $vMod->SetOption("import_log_file_name",   "photoalbum_import.log");
                        // Image import module params
                $vMod->SetOption("PhotoExchangeDriver_allowed_actions",   Array("add", "apply"));
                $vMod->SetOption("PhotoExchangeDriver_overwrite_images",  true);
                $vMod->SetOption("PhotoExchangeDriver_use_transliterate", true);
                $vMod->SetOption("PhotoExchangeDriver_fields_map",   Array(
                        "IMAGE"=>Array(
                                  //"IMAGE_MAIN"=>Array("type"=>"proc_data", "value"=>"store_name"),
                                  //"IMAGE_SMALL"=>Array("type"=>"value", "value"=>""),
                                  "IMAGE_POPUP"=>Array("type"=>"proc_data", "value"=>"store_name"),
                                   ),
                        "CATEGORY"=>Array(
                                  "DESCRIPTION"=>Array("type"=>"proc_data", "value"=>"dir"),
                                  "IS_DELETED"=>Array("type"=>"value", "value"=>"false"),
                                  "ID_EXTERNAL"=>Array("type"=>"proc_data", "value"=>"id"),
                                   ),
                        "CATALOG"=>Array(
                                  "IS_DELETED"=>Array("type"=>"value", "value"=>"false"),
                                  "DESCRIPTION"=>Array("type"=>"proc_data", "value"=>"name"),
                                  "ID_EXTERNAL"=>Array("type"=>"proc_data", "value"=>"id"),
                                  "ID_PARENT_EXTERNAL"=>Array("type"=>"proc_data", "value"=>"cid"),
                                  "IMAGE",
                                ),
                      ));
                        // Destination eshop category id.
                $vMod->SetOption("cat_fields_map", Array(
                      "DESCRIPTION"=>Array(
                              "operation"=>"copy",
                              "fields"=>Array("header", "name", "announce", "body")
                              ),
                      "IS_DELETED"=>Array(
                              "operation"=>"replace",
                              "values"=>Array("true"=>"0", "false"=>"1"),
                              "fields"=>"public"
                              ),
                      "ID_EXTERNAL"=>Array(
                              "operation"=>"get_cat_id",
                              "fields"=>"id"
                              ),
                ));
                $vMod->SetOption("item_fields_map", Array(
                      "NAME_FULL"=>Array(
                              "operation"=>"copy",
                              "fields"=>Array("body")
                              ),
                      "DESCRIPTION"=>Array(
                              "operation"=>"copy",
                              "fields"=>Array("header", "name", "announce")
                              ),
                      "ID_CATEGORY"=>Array(
                              "operation"=>"copy",
                              "fields"=>Array("id_cat")
                              ),
                      "IS_DELETED"=>Array(
                              "operation"=>"replace",
                              "values"=>Array("true"=>"0", "false"=>"1"),
                              "fields"=>"public"
                              ),
                      "ID_EXTERNAL"=>Array(
                              "operation"=>"get_item_id",
                              "fields"=>"id"
                              ),
                      "ID_PARENT_EXTERNAL"=>Array(
                              "operation"=>"get_parent_cat_id",
                              "fields"=>"cat_id"
                              ),
                      "IMAGE_MAIN"=>Array(
                              "operation"=>"image",
                              "fields"=>"picture"
                              ),
                      "IMAGE_POPUP"=>Array(
                              "operation"=>"image",
                              "fields"=>"popup_picture"
                              ),
                      "IMAGE_SMALL"=>Array(
                              "operation"=>"image",
                              "fields"=>"small_picture"
                              ),
                ));
}

// } [ami_data_exchange|photoalbum|data_exchange]
// [ami_files|files] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // FILES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    $vMod->SetOption('page_size', $Core->GetOption('default_page_size'));
    $vMod->SetOption('page_sort_dim', 'desc');
                // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                // Array with available pictures
###        $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
        $vMod->SetOption("item_pictures",           Array("picture", "popup_picture", "small_picture"));
                // Type of picture, which will be shown in admin item's list:
                // "none", "picture", "popup_picture", "small_picture"
        $Core->TTlI1ll($vMod, 'col_picture_type', 'ext_images', 'col_picture_type');
                // Picture generator options
###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'ext_images', 'generate_pictures');
        $vMod->SetOption("generate_pictures",   Array("picture", "popup_picture", "small_picture"));
        $Core->TTlI1ll($vMod, 'prior_source_picture', 'ext_images', 'prior_source_picture');
        $Core->TTlI1ll($vMod, 'picture_maxwidth', 'ext_images', 'picture_maxwidth');
        $Core->TTlI1ll($vMod, 'picture_maxheight', 'ext_images', 'picture_maxheight');
        $Core->TTlI1ll($vMod, 'popup_picture_maxwidth', 'ext_images', 'popup_picture_maxwidth');
        $Core->TTlI1ll($vMod, 'popup_picture_maxheight', 'ext_images', 'popup_picture_maxheight');
        $Core->TTlI1ll($vMod, 'small_picture_maxwidth', 'ext_images', 'small_picture_maxwidth');
        $Core->TTlI1ll($vMod, 'small_picture_maxheight', 'ext_images', 'small_picture_maxheight');
        $Core->TTlI1ll($vMod, 'generate_bigger_image', 'ext_images', 'generate_bigger_image');
        // Type of picture, which will be shown in admin item's list:
                // "none", "picture", "popup_picture", "small_picture"
        $Core->TTlI1ll($vMod, 'col_picture_type', 'ext_images', 'col_picture_type');

                //Use categories
        $vMod->SetOption("use_categories",             true);
        if($vMod->GetOption( "use_categories")){
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty("##modId##_cat", "stop_arg_names"));
        } else {
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty("##modId##", "stop_arg_names"));
        }
        $vMod->SetOption("page_sort_col", "cdate");
        $vMod->SetOption("multi_page",              true);
                // Sort field of files "name", "num_downloaded", "cdate", "mdate"
        $vMod->SetOption("front_page_sort_col",     "name");
                // Sort dimension of files "asc", "desc"
        $vMod->SetOption("front_page_sort_dim",     "asc");
                // Sort field of sub files (sub items) "name", "num_downloaded", "cdate", "mdate"
        $vMod->SetOption("front_subitem_sort_col",     "name");
                // Sort dimension of sub files (sub items) "asc", "desc"
        $vMod->SetOption("front_subitem_sort_dim",     "asc");
                // Number columns in items list
        $vMod->SetOption("cols",                     1);
        // used prefix - $MODULE_PICTURES_PATH
        $vMod->SetOption("files_path", "ftpfiles/");
        // used prefix - $MODULE_PICTURES_PATH
        $vMod->SetOption("icons_path", "ftpicons/");
        $vMod->SetOption("extension", ".dat");
        // Currently available extensions: "ext_tags"
        $vMod->SetOption("extensions", array('ext_reindex'));
                // Fill empty description/body with announce on details page
        $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description');
                // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

        //-- RSS extansion FILES module constants
               // number of RSS channel elements
        $Core->TTlI1ll($vMod, 'rss_num_elements', 'ext_rss', 'rss_num_elements');
               // display on page
        $Core->TTlI1ll($vMod, 'rss_display_page', 'ext_rss', 'rss_display_page');
               // type of display image on page
        $Core->TTlI1ll($vMod, 'rss_display_image', 'ext_rss', 'rss_display_image');
               // rss channel title (only to module) = field from news
        $Core->TTlI1ll($vMod, 'rss_channel_title', 'core_module', 'company_name');
               // rss channel description (only to module)
        $vMod->SetOption("rss_channel_description",       "");
               // rss channel webmaster (only to module)
        $Core->TTlI1ll($vMod, 'rss_channel_webmaster', 'ext_rss', 'rss_channel_webmaster');
               // rss channel generator (only to module, god_mode)
        $Core->TTlI1ll($vMod, 'rss_channel_generator', 'ext_rss', 'rss_channel_generator');
               // rss item title (only to module)
        $vMod->SetOption("rss_item_title",                "rss_f_name");
               // rss item description (only to module) = field from news
        $vMod->SetOption("rss_item_description",          "rss_announce");
               // rss item enclosure (only to module) = field from news
        $vMod->SetOption("rss_item_enclosure",            "rss_small_image");
               // rss item guid (only to module) = field from news
        $vMod->SetOption("rss_item_guid",                 "none");
               // rss item guid (only to module) = field from news
        $vMod->SetOption("rss_item_pubdate",              "rss_c_date");
                // rss channel (only to module, list of files in "_img/")
        $Core->TTlI1ll($vMod, 'rss_channel_image', 'ext_rss', 'rss_channel_image');
                // rss channel (only to module, list of files in "_img/")
        $Core->TTlI1ll($vMod, 'rss_channel_style', 'ext_rss', 'rss_channel_style');
        //-- end RSS

        $vMod->SetOption("timelimit", 350);
        $vMod->SetOption("buffer", 512000);
                // On/Off byte ranges downloads
        $vMod->SetOption("partial_download_on",        true);
                // Enable/disable download counter, true, false
        $vMod->SetOption("show_download_counter", true);
                // Count of categories' columns per page
        $vMod->SetOption("body_cats_cols",             1);
                // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
        $vMod->SetOption("show_subitems",   -1);
                // The number of sub items, after which is inserted splitter, 0 - no splitter
        $vMod->SetOption("subitems_splitter_period",    0);
                // Count of subitems' columns per page
        $vMod->SetOption("subitems_cols",               1);
                // Sort fields for some body types:
                // Array(
                //        "{body_type1};..;{body_typeN}"=>Array({field1}, ...{fieldN}),
                //        ...
                //        "{body_type(N+1)};..;{body_type(N+M)}"=>Array({field1}, ...{fieldN})
                //      )
                // Currently available body types: body_items, body_cats.
                // Currently available fileds for body_items: "header", "date"
                // Currently available fileds for body_cats: "name", "position"
        $vMod->SetOption("sort_pages_setup",  Array(
                "body_items;body_urgent_items"=>Array("header", "date"),
                "body_cats;body_urgent_cats"=>Array("name", "position")
        ));
        $vMod->SetOption("html_title_template",    "##object_name## - ##cat_name## - ##current_page_name## | ##site_title##");
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
                // Force expire time (strtotime format), "" - auto
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');
                // Set pages view in pager (numbers or bounds)
        $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');

               // Diplay or not on front module items having date in the future
        $Core->TTlI1ll($vMod, 'hide_future_items', 'common_settings', 'hide_future_items');
                // Displayed fields' properties (used for audit module ONLY)
        $vMod->SetOption("audit_displayed_fields", Array("field_cdate"=>"visible", "field_mdate"=>"visible", "field_name"=>"visible", "field_announce"=>"visible", "field_body"=>"visible", "field_filename"=>"visible"));
                // Array of required fields (used for audit module ONLY)
        $vMod->SetOption("audit_required_fields",  Array());
                // Audit changes made in admin interface
        $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
                // Send notification on user's item changing
        $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
                // Audit action handling rules
        $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
        // Disable search engine indexing for following cases
        $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
}

// } [ami_files|files]
// [ami_files|files|cat] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // FILES CATEGORIES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    $vMod->SetOption('page_size', $Core->GetOption('default_page_size'));
    $vMod->SetOption('cols', 1);
                        // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
                $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                        // Array with available pictures
###                $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
                $vMod->SetOption("item_pictures",           Array("picture", "popup_picture", "small_picture"));
                $vMod->SetOption("generate_pictures",   Array("picture", "popup_picture", "small_picture"));
                $Core->TTlI1ll($vMod, 'prior_source_picture', 'ext_images', 'prior_source_picture');
                $vMod->SetOption("picture_maxwidth", 400);
                $vMod->SetOption("picture_maxheight", 400);
                $Core->TTlI1ll($vMod, 'popup_picture_maxwidth', 'ext_images', 'popup_picture_maxwidth');
                $Core->TTlI1ll($vMod, 'popup_picture_maxheight', 'ext_images', 'popup_picture_maxheight');
                $Core->TTlI1ll($vMod, 'small_picture_maxwidth', 'ext_images', 'small_picture_maxwidth');
                $Core->TTlI1ll($vMod, 'small_picture_maxheight', 'ext_images', 'small_picture_maxheight');
                $Core->TTlI1ll($vMod, 'generate_bigger_image', 'ext_images', 'generate_bigger_image');

                // Type of picture, which will be shown in admin item's list:
                        // "none", "picture", "popup_picture", "small_picture"
                $Core->TTlI1ll($vMod, 'col_picture_type', 'ext_images', 'col_picture_type');
                        // Show empty categories
                $vMod->SetOption("show_empty_cats",         false);
                        // Fill empty description/body with announce on details page
                $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description', true, false);
                        // Show urgent elements at pages
                        // Currently available "ext_twist_prevention", "ext_discussion", "ext_rss")
                $vMod->SetOption("extensions", array('ext_reindex'));
//                $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
                $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));
                        // Sort field of categories "name"
                $vMod->SetOption("page_sort_col",           "name");
                        // Sort dimension of categories "asc", "desc"
                $vMod->SetOption("page_sort_dim",           "asc");
                        // Sort field of categories "name"
                $vMod->SetOption("front_page_sort_col",           "name");
                        // Sort dimension of categories "asc", "desc"
                $vMod->SetOption("front_page_sort_dim",           "asc");
                $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
                $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
                        // Audit changes made in admin interface
                $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
                        // Send notification on user's item changing
                $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
                        // Audit action handling rules
                $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
                        // 404 header for not found pages
                $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
}

// } [ami_files|files|cat]
// [ami_data_exchange|files] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // FILES IMPORT module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
                        // Count of files per page
                $vMod->SetOption("page_size",                  10);
                        // Sort field of files "date", "subject", "topic", "send_to", "attach"
                $vMod->SetOption("page_sort_col",              "date");
                        // Sort dimension of files "asc", "desc"
                $vMod->SetOption("page_sort_dim",              "desc");
                        // Import path
                        // used prefix - $MODULE_PICTURES_PATH
                $vMod->SetOption("import_path",                "_upload/");
                        // Max import size
                $vMod->SetOption("max_import_size",            50000000);
                        // Eshop files (digitals products) extention
                $vMod->SetOption("files_extension",   ".dat");
                        // Prefix for the file that will be stored
                $vMod->SetOption("files_prefix",   "files_");
}

// } [ami_data_exchange|files]
// [ami_relations|relations] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    // RELATED ENTITIES module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
        $vMod->SetOption('engine_version', '0303');
        $vMod->SetOption('start_disable', true);
        $vMod->SetOption('admin_menu_allowed', false);
                // admin default module filter
        $vMod->SetOption('default_module_filter', 'articles');
                // list of modules to display in specblock
        $vMod->SetOption('small_display_modules', array ('all'));
                // additional template file for spec block
        $vMod->SetOption('spec_block_template', '');
                // additional template file for spec block
        $vMod->SetOption('source', 'item');
}

// } [ami_relations|relations]
// [ami_ext|category] {

// } [ami_ext|category]
// [ami_ext|adv] {

// } [ami_ext|adv]
// [ami_ext|reindex] {

// } [ami_ext|reindex]
// [ami_ext|discussion] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // DISCUSSION EXTENSION module constants
    $vMod = &$Core->GetModule($modName);

        $vMod->SetOption('front_page_sort_col', 'date');
        $vMod->SetOption('front_page_sort_dim', 'desc');

        $vMod->SetOption('page_size', 10);
                // Front: number of pages in messages pager
        $vMod->SetOption('messages_pages', 5);
                // messages addition by registered users only
        $vMod->SetOption('add_messages_by_registered_only', false);
                // message can be updated for this period by its authorized author
        $vMod->SetOption('updatable_period', '6 hour');
                // Frame extarnal links in messages by <noindex> tags
        $vMod->SetOption('noindex_external_links', true);
                // Use tree view
        $vMod->SetOption('use_tree_view', true);
                // Display sys user username as "Administration"
        $vMod->SetOption('sys_user_as_administration', true);
                // allowed front images
        $vMod->SetOption('front_images', array ('registered_users_only', 'internal_links', 'external_links'));
                // Allow visitors to watch comments
        $vMod->SetOption('watch_comments', false);
                // Show forum_count_replies, true, false
        $vMod->SetOption('show_forum_count_replies',   true);
                // Show module body, when forum
        $vMod->SetOption('show_body_when_forum',       true);
                // Show forum links in news list, true, false
        $vMod->SetOption('show_forum_link_in_list',    true);
                // Show forum links in small news block, true, false
        $vMod->SetOption('show_forum_link_in_small',   false);
                // Count of forum items per page
        $vMod->SetOption('forum_page_size',            10);
                // Show forum at element details page right away
        $vMod->SetOption('show_forum_at_details',      false);
                // Display element numbers in messages list
        $vMod->SetOption('forum_pager_page_number_as_bound', true);

        $vMod->SetOption('notify_admin_about_new_message', true);
                // email address that will receive questions from the site
        $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'core_module', 'company_email');
                // Shared mode from mailbox option. Without domain! Domain will be appended by script
        $Core->TTlI1ll($vMod, 'from_mbox', 'core_module', 'from_mbox');

        //publishing options
        $vMod->setOption('publish_from_not_authorized', false);
        $vMod->setOption('publish_from_authorized', true);
}

// } [ami_ext|discussion]
// [ami_ext|rating] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption("allow_ratings", true);
    $vMod->SetOption("display_ratings", true);
    $vMod->SetOption("sort_by_ratings", true);
    $vMod->SetOption("display_votes", true);

    $vMod->SetOption("rating_decimal_places", 2);
    $vMod->SetOption("rating_by_registered_only", false);
    $vMod->SetOption("weighted_rating", false);

    $vMod->SetOption("weight_formula", "((\$regdays+1)/365) + 10");
    $vMod->SetOption('form_template', 'rating_stars_oneblock.tpl');

    $vMod->SetOption("history_allow_same_ip", "14 day");
    $vMod->SetOption("history_allow_same_user", "3 year");
    $vMod->SetOption("history_allow_same_vid", "3 year");

    $vMod->SetOption("history_clear_interval", "1 day");
    // where to display the form.
    // can contain "body_items", "body_itemD", "body_filtered" or all.
    $vMod->SetOption("show_form_in", array( /* "body_items", 'body_urgent_items', */ "body_itemD"));

    // form type - "radio" or "select"
    $vMod->SetOption("form_type", "select");

    // default rating - new
    $vMod->SetOption("default_rating", 3);

    // how many radio buttons/select options will be displayed in the form
    $vMod->SetOption("grade_size", 5);

    // minimum number of votes to display ratings
    $vMod->SetOption("minimum_votes_to_display", 1);

    // last time we cleared the rating history
    $vMod->SetOption("last_clearing_time", 110000);
}

// } [ami_ext|rating]
// [ami_ext|image] {

// } [ami_ext|image]
// [ami_ext|tags] {

// } [ami_ext|tags]
// [ami_ext|relations] {

// } [ami_ext|relations]
// [ami_antispam|antispam] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    //  TWIST PREVENTION module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
        $vMod->SetOption("visitors_originality_parameters", Array("ip_address", "cookie"));
        $vMod->SetOption("allow_disabled_cookies", false);
        $vMod->SetOption("record_ttl", "1 year");
        // use javascript protection instead of captcha
        $vMod->SetOption("use_js_protection", true);
        // number of digits in captcha
        $vMod->SetOption("image_digits_qty", 4);
        // set of symbopls in captcha ('digits', 'letters' or 'letters_and_digits')
        $vMod->SetOption("image_symbols_set", 'digits');
        $vMod->SetOption("show_captcha_for_registered_users", false);

                // period of next active action preventing, e. g. adding message to forum (into current module)
        $vMod->SetOption("action_period", "5 second");
                // show captcha (image to prevent from robots actions)
        $vMod->SetOption("show_captcha", false);
                // check captcha without page reloading
        $vMod->SetOption("js_checking", true);
                // add "_twist" postfix to module action in case of twist detection
        $vMod->SetOption("generate_twist_action", false);
                // add status message in case of twist detection
        $vMod->SetOption("show_alert", true);

        // {{{ options from const_system / Show num image module constants

        // Image type "png", "gif", "jpg", "wbmp"
        $vMod->SetOption("type",	'png');
        //set jitter of amplitude for each digit (pixels)
        $vMod->SetOption("jitter_amplitude",  1);
        $vMod->SetOption("wave_amplitude",    1.0);
        $vMod->SetOption("noise_level",       100);
        $vMod->SetOption("noise_color",       '808080');
        $vMod->SetOption("split_image",       false);

        // }}}
}

// } [ami_antispam|antispam]
// [ami_ext|antispam] {

// } [ami_ext|antispam]
// [ami_multifeeds5|jobs] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // JOBS module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('cols', 1);
             // Engine version. Set version greater than 0302 to turn on class engine support
        $vMod->SetOption("engine_version", '0303');
             // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
             // Array with available pictures
        //$Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
                // Type of picture, which will be shown in admin item's list:
                // "none", "picture", "popup_picture", "small_picture"

                //Use categories
        $vMod->SetOption("use_categories",             true);
        if($vMod->GetOption( "use_categories")){
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty("##modId##_cat", "stop_arg_names"));
        } else {
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty("##modId##", "stop_arg_names"));
        }
                // Count of articles per page
        $vMod->SetOption("page_size",                  10);
                // Sort field of articles "date", "header"
        $vMod->SetOption("page_sort_col",              "date");
                // Sort dimension of articles "asc", "desc"
        $vMod->SetOption("page_sort_dim",              "desc");
        // Sort field of articles "date", "header"
        $vMod->SetOption("front_subitem_sort_col",     "name");
                // Sort dimension of articles "asc", "desc"
        $vMod->SetOption("front_subitem_sort_dim",     "desc");
                // Sort field of articles "date", "header"
        $vMod->SetOption("front_page_sort_col",        "name");
                // Sort dimension of articles "asc", "desc"
        $vMod->SetOption("front_page_sort_dim",        "desc");
                // Suport multi pages
        $vMod->SetOption("multi_page",                 false);
                // Archive field name
        $vMod->SetOption("show_type",                  "active");
                // Show list of categories inside category
        $vMod->SetOption("multicat",                   false);
                // Show list of categories inside item details
        $vMod->SetOption("multicat_in_body_details",   false);
                // Show N last items, when url parametr "show_last=1" is present
                // If N=0, then working in normal mode
        $vMod->SetOption("show_last_items",            10);
        $vMod->SetOption("body_cats_cols",             1);
                // Count of articles columns on spec block
        $vMod->SetOption("body_small_cols",            1);
                // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
        $vMod->SetOption("show_subitems",              2);
                // The number of sub items, after which is inserted splitter, 0 - no splitter
        $vMod->SetOption("subitems_splitter_period",    0);
                // Count of subitems' columns per page
        $vMod->SetOption("subitems_cols",               1);
                // Count of items, which will be shown. If category(is) is specified, then count of items from each category.
        $vMod->SetOption("small_number_items",          4);
                // List of categories id, from which the items will be shown
                //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->SetOption("small_category_ids",          0);
                // Number categories, from which the items will be shown.
                // Only when option "small_category_ids" eq. 0.
                // (if 0  and option "small_category_ids" eq. 0, then categories will be not specified)
        $vMod->SetOption("small_number_categories",     0);
                // Sort field of categories "name", "position"
        $vMod->SetOption("small_categories_sort_col",   "name");
                // Sort dimension of categories "asc", "desc"
        $vMod->SetOption("small_categories_sort_dim",   "asc");
                // Sort field of articles "date", "header"
        $vMod->SetOption("small_items_sort_col",        "name");
                // Sort dimension of articles "asc", "desc"
        $vMod->SetOption("small_items_sort_dim",        "asc");
                // Set pages view in pager (numbers or bounds)
        $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');
               // Diplay or not on front module items having date in the future
        $Core->TTlI1ll($vMod, 'hide_future_items', 'common_settings', 'hide_future_items');
                // Currently available "ext_rss"

        $vMod->SetOption("extensions", array("ext_rss", 'ext_reindex') );
                // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

        // RSS extension JOBS module constants
               // number of RSS channel elements
        $Core->TTlI1ll($vMod, 'rss_num_elements', 'ext_rss', 'rss_num_elements');
               // display on page
        $Core->TTlI1ll($vMod, 'rss_display_page', 'ext_rss', 'rss_display_page');
               // type of display image on page
        $Core->TTlI1ll($vMod, 'rss_display_image', 'ext_rss', 'rss_display_image');
               // rss channel title (only to module) = field from news
        $Core->TTlI1ll($vMod, 'rss_channel_title', 'core_module', 'company_name');
               // rss channel description (only to module)
        $vMod->SetOption("rss_channel_description",       "");
               // rss channel webmaster (only to module)
        $Core->TTlI1ll($vMod, 'rss_channel_webmaster', 'ext_rss', 'rss_channel_webmaster');
               // rss channel generator (only to module, god_mode)
        $Core->TTlI1ll($vMod, 'rss_channel_generator', 'ext_rss', 'rss_channel_generator');
               // rss item title (only to module)
        $vMod->SetOption("rss_item_title",                "rss_jobs_name");
               // rss item description (only to module) = field from news
        $vMod->SetOption("rss_item_description",          "rss_duty");
               // rss item guid (only to module) = field from news
        $vMod->SetOption("rss_item_guid",                 "none");
               // rss item guid (only to module) = field from news
        $vMod->SetOption("rss_item_pubdate",              "rss_c_date");
                // rss channel (only to module, list of files in "_img/")
        $Core->TTlI1ll($vMod, 'rss_channel_image', 'ext_rss', 'rss_channel_image');
                // rss channel (only to module, list of files in "_img/")
        $Core->TTlI1ll($vMod, 'rss_channel_style', 'ext_rss', 'rss_channel_style');
//-- end RSS
                // Sort fields for some body types:
                // Array(
                //        "{body_type1};..;{body_typeN}"=>Array({field1}, ...{fieldN}),
                //        ...
                //        "{body_type(N+1)};..;{body_type(N+M)}"=>Array({field1}, ...{fieldN})
                //      )
                // Currently available body types: body_items, body_cats.
                // Currently available fileds for body_items: "header", "date"
                // Currently available fileds for body_cats: "name", "position"
        $vMod->SetOption("sort_pages_setup",  Array(
                "body_items;body_urgent_items"=>Array("name", "date"),
                "body_cats;body_urgent_cats"=>Array("name", "position")
        ));
        $vMod->SetOption("expire_period", "+2 month");
        $vMod->SetOption("html_title_template",    "##object_name## - ##cat_name## - ##current_page_name## | ##site_title##");
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
        // Email for new resume postings notifications - used in JobsHistory
        $Core->TTlI1ll($vMod, 'jobs_email', 'core_module', 'company_email');
                // Additional template file for spec block
        $vMod->SetOption("spec_block_template",    "");
                // Additional template file for spec block
        $vMod->SetOption("spec_id_pages",          Array(-1));
        $vMod->SetOption('spec_cat_id_pages', array(-1));

        /*        // Displayed fields' properties (used for audit module ONLY)
        $vMod->SetOption("audit_displayed_fields", Array("field_cdate"=>"visible", "field_mdate"=>"visible", "field_name"=>"visible", "field_announce"=>"visible", "field_body"=>"visible", "field_filename"=>"visible"));
                // Array of required fields (used for audit module ONLY)
        $vMod->SetOption("audit_required_fields",  Array());*/
                // Audit changes made in admin interface
        $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
                // Send notification on user's item changing
        $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
                // Audit action handling rules
        $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));

                // Force expire time (strtotime format), "" - auto
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');

                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
        // Disable search engine indexing for following cases
        $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
}

// } [ami_multifeeds5|jobs]
// [ami_multifeeds5|jobs|cat] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
        // JOBS CATEGORIES module constants
        $vMod = &$Core->GetModule($modName);
        $vMod->SetOption('cols', 1);
                        // Engine version. Set version greater than 0302 to turn on class engine support
                $vMod->SetOption("engine_version", "0303");
                        // Suport multi pages
                        // Array with available pictures
                //$Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
                        // Type of picture, which will be shown in admin item's list:
                        // "none", "picture", "popup_picture", "small_picture"
                //$Core->SetOptionInherited($vMod, 'col_picture_type', 'ext_images', 'col_picture_type');
                        // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
                $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                        // Default category: "all", "none", "NN" - id of category
                //$vMod->SetOption("default_category",        "all");
                        // Currently available "ext_twist_prevention", "ext_discussion", "ext_rss")
                $vMod->SetOption("extensions", array('ext_reindex'));
                        // Count of categories per page
                $vMod->SetOption("page_size",               10);
                        // Sort field of categories "name"
                $vMod->SetOption("page_sort_col",           "name");
                        // Sort dimension of categories "asc", "desc"
                $vMod->SetOption("page_sort_dim",           "asc");
                        // Sort field of categories "name"
                $vMod->SetOption("front_page_sort_col",     "name");
                        // Sort dimension of categories "asc", "desc"
                $vMod->SetOption("front_page_sort_dim",     "asc");
                        // Count of categories' columns per page
                //$vMod->SetOption("cols",                    2);
                        // Show empty categories
                $vMod->SetOption("show_empty_cats",         false);
                        // Fill empty description/body with announce on details page
                $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description', true, false);
                        // Show urgent elements at pages
//                $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
                $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));
                $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
                $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');

                /*        // Displayed fields' properties (used for audit module ONLY)
                $vMod->SetOption("audit_displayed_fields", Array("field_cdate"=>"visible", "field_mdate"=>"visible", "field_name"=>"visible", "field_announce"=>"visible", "field_body"=>"visible", "field_filename"=>"visible"));
                        // Array of required fields (used for audit module ONLY)
                $vMod->SetOption("audit_required_fields",  Array());*/
                        // Audit changes made in admin interface
                $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
                        // Send notification on user's item changing
                $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
                        // Audit action handling rules
                $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
                        // 404 header for not found pages
                $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
}

// } [ami_multifeeds5|jobs|cat]
// [ami_jobs|history|history] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // JOBS HISTORY module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_size', $Core->GetOption('default_page_size'));
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
                        // Engine version. Set version greater than 0302 to turn on class engine support
                $vMod->SetOption("engine_version", "0303");
                $vMod->SetOption("resume_other", true);
                $vMod->SetOption("message_sign", array("ru"=>"С уважением,\nВебмастер", "en"=>"Sincerely yours,\nWebmaster"));
                //$vMod->SetOption("custom_fields", array());
                        // list of fields, which will be shown into form (in that order, in which they are listed)
                        // possible fields: "firstname", "lastname", "birthdate", "email", "phone", "fax", "web", "company", "title", "address1", "address2", "city", "state", "zip", "country", "info", "custom_1", ..., custom_N (N =1, 2, 3, ...)

/*
        $vMod->SetOption("custom_fields", array( "custom_1" => array("type" => "text",     "value" => "0", "size" => "50" ),
                                                 "custom_2" => array("type" => "textarea", "value" => "",  "rows" =>"3", "cols" => "20"),
                                                 "custom_3" => array("type" => "checkbox", "value" => "1")
                                                ));*/
                $vMod->SetOption("custom_fields", array(
/*                        "custom_field1" => array("type" => "text", "value" => "", "size" => "50"),
                        "custom_field2" => array("type" => "text", "value" => "", "size" => "50"),
*/
                ));
                // list of fields, which will be shown into form (in that order, in which they are listed)
                // possible fields: "firstname", "lastname", "birthdate", "email", "phone", "fax", "web", "company", "title", "address1", "address2", "city", "state", "zip", "country", "info", "custom_1", ..., custom_N (N =1, 2, 3, ...)

                $vMod->SetOption("enabled_fields", array ("firstname", "lastname", "email", "phone", "resume", "resume_attach", "resume_addon"));
                $vMod->SetOption("message_topic", array("ru"=>"Ответ на ваше резюме", "en"=>"An answer to your resume"));
                $vMod->SetOption("def_request_text", array("ru"=>"Интересует данная вакансия.", "en"=>"I am interested in the position."));

                        // list of required fields
                $vMod->SetOption("required_fields", array ("firstname", "lastname", "email"));
                $vMod->SetOption("attach_allowed",             true);
                $vMod->SetOption("max_upload_size", min(1048576, $Core->GetOption("max_upload_size")));
                $vMod->SetOption("forbidden_attach", array ("exe", "pif", "bat", "scr", "reg", "cmd", "dll", "com", "lnk", "vbs", "php"));
}

// } [ami_jobs|history|history]
// [ami_jobs|resume|resume] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
        // JOBS RESUME module constants
        $vMod = &$Core->GetModule($modName);
        $vMod->SetOption('cols', 1);
        $vMod->SetOption("engine_version", '0303');
        $vMod->SetOption('extensions', array());
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
        $vMod->SetOption("use_categories", true);
        if($vMod->GetOption("use_categories")){
            $vMod->SetOption("stop_arg_names", array("catid"=>"jobs_cat", "id"=>"jobs_resume"));
        } else {
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty("##modId##", "stop_arg_names"));
        }
        $vMod->SetOption("page_size", 10);
        $vMod->SetOption("page_sort_col", "date");
        $vMod->SetOption("page_sort_dim", "desc");
        $vMod->SetOption("front_subitem_sort_col", "date");
        $vMod->SetOption("front_subitem_sort_dim", "desc");
        $vMod->SetOption("front_page_sort_col", "date");
        $vMod->SetOption("front_page_sort_dim", "desc");
        $vMod->SetOption("multicat", false);
        $vMod->SetOption("multicat_in_body_details", false);
        $vMod->SetOption("show_last_items", 10);
        $vMod->SetOption("body_cats_cols", 1);
        $vMod->SetOption("body_small_cols", 1);
        // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
        $vMod->SetOption("show_subitems", 2);
        // The number of sub items, after which is inserted splitter, 0 - no splitter
        $vMod->SetOption("subitems_splitter_period", 0);
        // Count of subitems' columns per page
        $vMod->SetOption("subitems_cols", 1);
        // Count of items, which will be shown. If category(is) is specified, then count of items from each category.
        $vMod->SetOption("small_number_items", 4);
        // List of categories id, from which the items will be shown
        //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->SetOption("small_category_ids", 0);
        // Number categories, from which the items will be shown.
        // Only when option "small_category_ids" eq. 0.
        // (if 0  and option "small_category_ids" eq. 0, then categories will be not specified)
        $vMod->SetOption("small_number_categories", 0);
        // Sort field of categories "name", "position"
        $vMod->SetOption("small_categories_sort_col", "name");
        // Sort dimension of categories "asc", "desc"
        $vMod->SetOption("small_categories_sort_dim", "asc");
        // Sort field of articles "date", "header"
        $vMod->SetOption("small_items_sort_col", "date");
        // Sort dimension of articles "asc", "desc"
        $vMod->SetOption("small_items_sort_dim", "desc");
        $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

        $vMod->SetOption("expire_period", "+2 month");
        $vMod->SetOption("html_title_template", "##object_name## - ##cat_name## - ##current_page_name## | ##site_title##");
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
        $vMod->SetOption("spec_block_template", "");
        $vMod->SetOption("spec_id_pages", Array(-1));
        $vMod->SetOption('spec_cat_id_pages', array(-1));
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');

        $vMod->SetOption("message_sign", array("ru"=>"С уважением,\nВебмастер", "en"=>"Sincerely yours,\nWebmaster"));
        $vMod->SetOption("message_topic", array("ru"=>"Ответ на ваш запрос", "en"=>"An answer to your request"));
        $vMod->SetOption("enabled_fields", array ("fname", "lname", "resume", "addon"));
        $vMod->SetOption("required_fields", array ("fname", "lname", "email"));
        $vMod->SetOption("attach_allowed", true);
        $vMod->SetOption("max_upload_size", min(2097152, $Core->GetOption("max_upload_size")));
        $vMod->SetOption("forbidden_attach", array ("exe", "pif", "bat", "scr", "reg", "cmd", "dll", "com", "lnk", "vbs", "php"));
}

// } [ami_jobs|resume|resume]
// [ami_jobs|employer|employer] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
        // JOBS EMPLOYER module constants
        $vMod = &$Core->GetModule($modName);
        $vMod->SetOption('page_size', $Core->GetOption('default_page_size'));
        // Engine version. Set version greater than 0302 to turn on class engine support
        $vMod->SetOption("engine_version", "0303");
        $vMod->SetOption("page_sort_col", "date");
        $vMod->SetOption("page_sort_dim", "desc");
        $vMod->SetOption("enabled_fields", array ("name", "department", "fname", "lname", "email", "website", "phone", "addon"));
        $vMod->SetOption("custom_fields", array());
        $vMod->SetOption("message_sign", array("ru"=>"С уважением,\nВебмастер", "en"=>"Sincerely yours,\nWebmaster"));
        $vMod->SetOption("message_topic", array("ru"=>"Ответ на ваш запрос", "en"=>"An answer to your request"));
        $vMod->SetOption("def_request_text", array("ru"=>"Интересует данный соискатель.", "en"=>"I am interested in the competitor."));
        // list of required fields
        $vMod->SetOption("required_fields", array ("name", "department", "fname", "lname", "email"));
        $vMod->SetOption("use_twist_prevention", true);
        $vMod->SetOption("extensions", array("ext_twist_prevention"));
        $vMod->SetOption('action_period', '5 second');
        // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
        // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
        // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
        // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');
}

// } [ami_jobs|employer|employer]
// [ami_votes|votes] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // VOTES module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_size', $Core->GetOption('default_page_size'));
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
            // Engine version. Set version greater than 0302 to turn on class engine support
        $vMod->SetOption("engine_version",  '0303');
        $vMod->SetOption("stop_arg_names", array("id"=>"votes"));
                // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
        $vMod->SetOption("keywords_generate",   "auto");
        $vMod->SetOption("front_page_sort_col", 'date_start');
        $vMod->SetOption("front_page_sort_dim", 'asc');
        $vMod->SetOption("page_sort_col_small", 'date_start');
        $vMod->SetOption("page_sort_dim_small", 'asc');
                // number of poll default answers in admin
        $vMod->SetOption("default_answers_count",        5);
                // width of the bar in visual vote representation
        $vMod->SetOption("bar_width",          300);
                // width of the small bar in visual vote representation on the frontend
        $vMod->SetOption("small_bar_width",    70);
                // max length of the question in the list [1-250]
        $vMod->SetOption("question_length",    45);
        $vMod->SetOption("cache_expire",       "+1 year");
        $vMod->SetOption("small_cache_expire", "+1 minute");
        // Disable search engine indexing for following cases
        $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
        $vMod->SetOption("view_results_before_voting", false);
        $vMod->SetOption("show_after_voices_count", 0);
        $vMod->SetOption("show_numeric", array ("show_numeric_total", "show_numeric_percentage"));
        $vMod->SetOption("registered_users_only", false);
                // sort answers in result by col / dim
        $vMod->SetOption('result_answers_sort_col', 'voices');
        $vMod->SetOption('result_answers_sort_dim', 'desc');

                // Currently available "ext_twist_prevention"
        $vMod->SetOption("extensions", array('ext_reindex'));

                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");

        // {{{ twist prevention extension options

                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');

        // }}}
}

// } [ami_votes|votes]
// [ami_ext|ce_page_break] {

// } [ami_ext|ce_page_break]
// [ami_subscribe|subscribe] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // SUBSCRIBE module constants
    $vMod = &$Core->GetModule($modName);
                // Count of files per page
        $vMod->SetOption("page_size",                  2);
                // Sort field of files "date", "active", "firstname", "lastname", "email", "username"
        $vMod->SetOption("page_sort_col",              "date");
                // Sort dimension of files "asc", "desc"
        $vMod->SetOption("page_sort_dim",              "desc");
                // Allow topics support true, false
        $vMod->SetOption("topics",                     true);
                // Allow to subscribe unregistered users
        $vMod->SetOption("allow_unregistered",         true);
                // Number of topics that will be shown in subscriber list
        $vMod->SetOption("topics_in_list",             2);
                // delimiter in export file
        $vMod->SetOption("export_delimiter",           ';');
                // export filename
        $vMod->SetOption("export_filename",            "export.csv");
                // log only addresses that have specified send status "fail", "ok", "all"
        $vMod->SetOption("log_details",                "fail");
                // perl send script name
                // remind time in percents of a period before expiration date
        $vMod->SetOption("remind_period",              10);
                // subscribe_with_billing
        $vMod->SetOption("with_billing",               false);
                // subscription confirmation type "auto", "manual"
        $vMod->SetOption("subscription_confirm",       "auto");
                // fast signup
        $vMod->SetOption("fast_signup",                true);
                // send registration email
        $vMod->SetOption("send_registration_email",    true);
        $vMod->SetOption("cache_expire",               "+1 day");
                // array of used fields separated with
                // allowed values are ("username", "email", "firstname", "lastname", "address1", "city",
                //      "state", "zip", "address2", "country", "phone", "company", "companyweb", "password", "ip")
                // ip will be filled automatically if it is specified
        $vMod->SetOption("used_fields",                 Array(
                                                            "username", "email", "firstname",
                                                            "lastname", "address1",
                                                            "state", "address2",
                                                            "country", "phone", "phone_work", "phone_cell", "company", "companyweb",
                                                            "password", "ip", "city")
                                                        );
                // array of required fields separated with |
                // allowed values are ("username", "email", "firstname", "lastname", "address1", "city",
                //      "state", "zip", "address2", "country", "phone", "company", "companyweb", "password", "ip")
                // ip will be filled automatically if it is specified
        //$vMod->SetOption("required_fields",             Array("username", "email", "firstname", "lastname", "address1", "city", "phone", "phone_work", "phone_cell"));
        $vMod->SetOption("required_fields",             Array("username","password","email"));
        $vMod->SetOption("admin_required_fields",       Array("username","email"));

        // {{{ twist prevention extension options

                // for old engine modules
        $vMod->SetOption("use_twist_prevention", true);
                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');
                // Force expire time (strtotime format), "" - auto
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');

        // }}}
}

// } [ami_subscribe|subscribe]
// [ami_subscribe|topic|topic] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
        // SUBSCRIBE CATEGORIES module constants
        $vMod = &$Core->GetModule($modName);
                        // Count of files per page
                $vMod->SetOption("page_size",                  10);
                        // Sort field of files "active", "name", "public", "free"
                $vMod->SetOption("page_sort_col",              "name");
                        // Sort dimension of files "asc", "desc"
                $vMod->SetOption("page_sort_dim",              "asc");
                        // Sort field of files "active", "name", "public", "free"
                $vMod->SetOption("front_page_sort_col",        "name");
                        // Sort dimension of files "asc", "desc"
                $vMod->SetOption("front_page_sort_dim",        "asc");
                        // topic name length
                $vMod->SetOption("name_length",                50);
                        // manual price
                $vMod->SetOption("manual_price",               true);
}

// } [ami_subscribe|topic|topic]
// [ami_subscribe|send|send] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
        // SUBSCRIBE SEND module constants
        $vMod = &$Core->GetModule($modName);
                        // Count of files per page
                $vMod->SetOption("page_size",                  10);
                        // Sort field of files "date", "subject", "topic", "send_to", "attach"
                $vMod->SetOption("page_sort_col",              "date");
                        // Sort dimension of files "asc", "desc"
                $vMod->SetOption("page_sort_dim",              "desc");
                        // allow to add coosing active/inactive users sending false, true
                $vMod->SetOption("send_only_active",           false);
                        // attempts to send a letter
                $vMod->SetOption("attempts",                   2);
                        // max number of subscribers that script will try to send directly
                $vMod->SetOption("max_subs_direct",            50);
                        // Shared mode from mailbox option. Without domain! Domain will be appended by script
                $Core->TTlI1ll($vMod, 'from_mbox', 'core_module', 'from_mbox');
                        // files that admin cannot attach to a mail
                $vMod->SetOption("forbidden_attach", array ("exe", "pif", "bat", "scr", "reg", "cmd", "dll", "com", "lnk", "vbs", "php"));
                $vMod->SetOption("mailer_mode",           'default');     // 'smtp', 'default'
                $vMod->SetOption("smtp_server",           'localhost');
                        // 'PLAIN', 'LOGIN' or '' for no auth
                $vMod->SetOption("smtp_auth",           'PLAIN');
}

// } [ami_subscribe|send|send]
// [ami_subscribe|export|export] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
        // SUBSCRIBE SEND module constants
        $vMod = &$Core->GetModule($modName);
        $vMod->SetOption('engine_version', '0600');
        $vMod->SetOption('api_key', '');
        $vMod->SetOption('autoexport_enabled', true);
        $vMod->SetOption('autoexport_topics', array());
}

// } [ami_subscribe|export|export]
// [ami_search|search] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // SEARCH  module constants
    $vMod = &$Core->GetModule($modName);
    // Sort field of queries "create_date", "update_date", "query", "quantity", "count_pages"
    $vMod->SetOption("page_sort_col",              "update_date");
    // Sort dimension of queries "asc", "desc"
    $vMod->SetOption("page_sort_dim",              "desc");
    // Sort field of queries "id" (relevance), "name"
    $vMod->SetOption("front_page_sort_col",        "id");
    // Sort dimension of queries "asc", "desc"
    $vMod->SetOption("front_page_sort_dim",        "desc");
    $vMod->SetOption("relevance",                  array (10, 5, 1));
    $vMod->SetOption("relevance_by_entries",       false);
    $vMod->SetOption("page_size",                  10);
    $vMod->SetOption("min_len",                    3);
    $vMod->SetOption("is_advanced_search",         false);
    $vMod->SetOption("advanced_search_pages",      array('all'));
    // Set pages view in pager (numbers or bounds)
    $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');
}

// } [ami_search|search]
// [ami_search|search|reindex] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    //  REINDEX module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption("allow_runtime_indexing", TRUE);
    // '', 'fulltext'
    $vMod->SetOption('mode', 'fulltext');
    $vMod->SetOption('fill_full_announce', FALSE);
}

// } [ami_search|search|reindex]
// [ami_feedback|feedback] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    // FEEDBACK module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_size', $Core->GetOption('default_page_size'));
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
                // Suport multi pages
        $vMod->SetOption("multi_page",              true);
                // email address that will receive mails from the website
        $Core->TTlI1ll($vMod, 'email_to', 'core_module', 'company_email');
                // array with custom fields descriptions
                // format: array("custom_1" => <field_description>, "custom_2" => <field_description>, ... "custom_N" => <field_description>)
                // <field_description>: array(<property_name> => <property_value>, ...<property_name> => <property_value>)
                // <property_name>: "type" - field's type,  <property_value>: "text" | "textarea" | "checkbox"
                // <property_name>: "value" - default value for field,  <property_value>: any text
                // additional properties for field "text"
                // <property_name>: "size" - field's size,  <property_value>: integer value
                // additional properties for field "textarea"
                // <property_name>: "rows" - count rows for textarea,  <property_value>: integer value
                // <property_name>: "cols" - count cols for textarea,  <property_value>: integer value
/*
        $vMod->SetOption("custom_fields", array( "custom_1" => array("type" => "text",     "value" => "0", "size" => "50" ),
                                                 "custom_2" => array("type" => "textarea", "value" => "",  "rows" =>"3", "cols" => "20"),
                                                 "custom_3" => array("type" => "checkbox", "value" => "1")
                                                ));*/
        $vMod->SetOption("custom_fields", array());

                // list of fields, which will be shown into form (in that order, in which they are listed)
                // possible fields: "firstname", "lastname", "birthdate", "email", "phone", "fax", "web", "company", "title", "address1", "address2", "city", "state", "zip", "country", "info", "custom_1", ..., custom_N (N =1, 2, 3, ...)
        $vMod->SetOption("enabled_fields", array ("firstname", "lastname", "email", "phone", "address1", "address2", "city", "country", "info"));
                // list of required fields
        $vMod->SetOption("required_fields", array ("firstname", "lastname", "email", "info"));

        $vMod->SetOption("email_subject", "");
        $vMod->SetOption("form_template", "feedback_mail.tpl");
        $vMod->SetOption("feedback_copy_send", false);
        $vMod->SetOption("feedback_text_mode_html", false);
        $vMod->SetOption("extensions", array("ext_twist_prevention"));
                // Force expire time (strtotime format), "" - auto
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');
/*
        // Disable search engine indexing for following cases
        $Core->SetOptionInherited($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
*/

        // twist prevention extension options {

                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');

        // }
}

// } [ami_feedback|feedback]
// [ami_datasets|datasets] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
        // Engine version. Set version greater than 0302 to turn on class engine support
    $vMod->SetOption("engine_version", '0303');
        // Sort field of items "name", "date"
    $vMod->SetOption("page_sort_col",           "name");
        // Sort dimension of items "asc", "desc"
    $vMod->SetOption("page_sort_dim",           "asc");
        // Count of Eshop items per page
    $vMod->SetOption("page_size",               10);
}

// } [ami_datasets|datasets]
// [ami_fake|datasets] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption('admin_menu_allowed', false);
}

// } [ami_fake|datasets]
// [ami_datasets|custom_fields] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    // Engine version. Set version greater than 0302 to turn on class engine support
    $vMod->SetOption('engine_version', '0303');
    // Sort field of items 'name', 'date'
    $vMod->SetOption('page_sort_col', 'id');
    // Sort dimension of items 'asc', 'desc'
    $vMod->SetOption('page_sort_dim', 'asc');
    // Count of Eshop items per page
    $vMod->SetOption('page_size', 10);
    // Default value for admin form displaying
    $vMod->SetOption('admin_form', 'top');
}

// } [ami_datasets|custom_fields]
// [ami_ext|custom_fields] {

// } [ami_ext|custom_fields]
// [ami_multifeeds5|classifieds] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    // CLASSIFIEDS module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('cols', 1);
                // List of custom fields
        $vMod->SetOption('custom_fields', array (1, 2));
                // Allow front visitors to add announcements
        $vMod->SetOption('front_allow_to_add', true);
                // Allow to add announcements authorized members only
        $vMod->SetOption('front_allow_to_add_registered_only', false);
                // Publish status for front added announcements
        $vMod->SetOption('front_add_as_published', false);
        $vMod->SetOption('display_inactive_by_direct_link', false);
                // Allow front-side attachments
        $vMod->SetOption('front_allow_attach', true);
                // Forbidden attachment file extensions
        $vMod->SetOption('forbidden_attachment_extensions', array ('exe', 'pif', 'bat', 'scr', 'reg', 'cmd', 'dll', 'com', 'lnk', 'vbs', 'php'));
                // Maximum front-side attachment size
        $vMod->SetOption('max_upload_size', min(1048576, $GLOBALS['Core']->GetOption('max_upload_size')));
                // Allow front-side images
        $vMod->SetOption('front_allow_attach_images', false);
                // Announcement default life time
        $vMod->SetOption('default_life_time', '1 month');
                // Autodeletion period
        $vMod->SetOption('autodeletion_period', '0 second');
                // Noticiation email
        $Core->TTlI1ll($vMod, 'noticiation_email', 'core_module', 'company_email');
                // Shared mode from mailbox option. Without domain! Domain will be appended by script
        $Core->TTlI1ll($vMod, 'from_mbox', 'core_module', 'from_mbox');
                // Notify admin on front data submission
        $vMod->SetOption('notify_admin_on_submission', true);
                // Notify author when published
        $vMod->SetOption('notify_author_when_published', true);

                        // Engine version. Set version greater than 0302 to turn on class engine support
        $vMod->SetOption("engine_version", '0303');
                // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                // Array with available pictures
###        $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
        $vMod->SetOption( "item_pictures",           Array("picture"));
                // Type of picture, which will be shown in admin item's list:
                // "none", "picture", "popup_picture", "small_picture"
        $Core->TTlI1ll($vMod, 'col_picture_type', 'ext_images', 'col_picture_type');
                // Picture generator options
###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
        $vMod->SetOption( "generate_pictures",   Array("picture", "popup_picture", "small_picture"));
        $Core->TTlI1ll($vMod, 'prior_source_picture', 'ext_images', 'prior_source_picture');
        $Core->TTlI1ll($vMod, 'picture_maxwidth', 'ext_images', 'picture_maxwidth');
        $Core->TTlI1ll($vMod, 'picture_maxheight', 'ext_images', 'picture_maxheight');
        $Core->TTlI1ll($vMod, 'popup_picture_maxwidth', 'ext_images', 'popup_picture_maxwidth');
        $Core->TTlI1ll($vMod, 'popup_picture_maxheight', 'ext_images', 'popup_picture_maxheight');
        $Core->TTlI1ll($vMod, 'small_picture_maxwidth', 'ext_images', 'small_picture_maxwidth');
        $Core->TTlI1ll($vMod, 'small_picture_maxheight', 'ext_images', 'small_picture_maxheight');
        $Core->TTlI1ll($vMod, 'generate_bigger_image', 'ext_images', 'generate_bigger_image');

                //Use categories
        $vMod->SetOption( "use_categories",             true);
        if($vMod->GetOption( "use_categories")) {
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty("classifieds_cat", "stop_arg_names"));
        } else {
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty("classifieds", "stop_arg_names"));
        }
                // Count of classifieds per page
        $vMod->SetOption( "page_size",                  10);
                // Sort field of classifieds "date", "header"
        $vMod->SetOption( "page_sort_col",              "header");
                // Sort dimension of classifieds "asc", "desc"
        $vMod->SetOption( "page_sort_dim",              "asc");
        // Sort field of classifieds "date", "header"
        $vMod->SetOption( "front_subitem_sort_col",     "date_start");
                // Sort dimension of classifieds "asc", "desc"
        $vMod->SetOption( "front_subitem_sort_dim",     "desc");
                // Sort field of classifieds "date", "header"
        $vMod->SetOption( "front_page_sort_col",        "date_start");
                // Sort dimension of classifieds "asc", "desc"
        $vMod->SetOption( "front_page_sort_dim",        "desc");
                // Suport multi pages
        $vMod->SetOption( "multi_page",                 true);
                // type of archiving method: "manual", "date"
        $vMod->SetOption( "archive_type",               "manual");
                // strings containing an english date format
                // Valid only when archive type is date
                // Examples:
                // "10 September 2000"
                // "-1 day"
                // "-1 week"
                // "-12 month"
        $vMod->SetOption( "archive_period",             "-1 year");
                // type of classifieds to show: "all", "active", "archive"
        $vMod->SetOption( "show_type",                  "all");
                // Show list of categories inside category
        $vMod->SetOption( "multicat",                   false);
                // Show list of categories inside item details
        $vMod->SetOption( "multicat_in_body_details",   false);
                // Show N last items, when url parametr "show_last=1" is present
                // If N=0, then working in normal mode
        $vMod->SetOption( "show_last_items",            10);
                // Show forum_count_replies, true, false
        $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
                // Show forum_count_topics, true, false
//        $Core->SetOptionInherited($vMod, 'show_forum_count_topics', 'ext_discussion', 'show_forum_count_topics');
                // Show forum links in news list, true, false
        $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
                // Show forum links in small news block, true, false
        $Core->TTlI1ll($vMod, 'show_forum_link_in_small', 'ext_discussion', 'show_forum_link_in_small');
                // Show forum at element details page right away
        $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details');
                // Display element numbers in messages list
        $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
                // Discussion admin notification
        $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
                // Webmaster email
        $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
                // Use tree view
        $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');
                // Anonymous user email
//        $vMod->SetOption("forum_anonymous_user_email",       "anonymous@localhost.ru");
                // Are attaches allowed
//        $Core->SetOptionInherited($vMod, 'forum_attaches_allowed', 'ext_discussion', 'forum_attaches_allowed');
                // False - one level tree messages, true - normal tree
//        $Core->SetOptionInherited($vMod, 'forum_only_one_level', 'ext_discussion', 'forum_only_one_level');
                // Set type of pager, "items", "topics"
//        $Core->SetOptionInherited($vMod, 'forum_pager_type', 'ext_discussion', 'forum_pager_type');
                // Count of forum items per page
//        $Core->SetOptionInherited($vMod, 'forum_page_size', 'ext_discussion', 'forum_page_size');
                // Only one topic per item
//        $Core->SetOptionInherited($vMod, 'forum_multi_topics', 'ext_discussion', 'forum_multi_topics');

                // Count of categories' columns per page
        $vMod->SetOption( "body_cats_cols",             1);
                // Count of classifieds columns on spec block
        $vMod->SetOption( "body_small_cols",            1);
                // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
        $vMod->SetOption( "show_subitems",              -1);
                // The number of sub items, after which is inserted splitter, 0 - no splitter
        $vMod->SetOption("subitems_splitter_period",    0);
                // Count of subitems' columns per page
        $vMod->SetOption("subitems_cols",               1);
                // Count of items, which will be shown. If category(is) is specified, then count of items from each category.
        $vMod->SetOption("small_number_items",          5);
                // List of categories id, from which the items will be shown
                //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->SetOption("small_category_ids",          0);
                // Number categories, from which the items will be shown.
                // Only when option "small_category_ids" eq. 0.
                // (if 0  and option "small_category_ids" eq. 0, then categories will be not specified)
        $vMod->SetOption("small_number_categories",     0);
                // Sort field of categories "name", "position"
        $vMod->SetOption("small_categories_sort_col",   "name");
                // Sort dimension of categories "asc", "desc"
        $vMod->SetOption("small_categories_sort_dim",   "asc");
                // Sort field of classifieds "date", "header"
        $vMod->SetOption("small_items_sort_col",        "date_start");
                // Sort dimension of classifieds "asc", "desc"
        $vMod->SetOption("small_items_sort_dim",        "desc");
                // Fill empty description/body with announce on details page
        $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description');
                // Currently available "ext_discussion"
        $vMod->SetOption( "extensions", array("ext_twist_prevention", 'ext_reindex'));
                // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

        // {{{ twist prevention extension options

                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');

        // }}}

        //-- RSS extension CLASSIFIEDS module constants
               // number of RSS channel elements
        $Core->TTlI1ll($vMod, 'rss_num_elements', 'ext_rss', 'rss_num_elements');
               // display on page
        $Core->TTlI1ll($vMod, 'rss_display_page', 'ext_rss', 'rss_display_page');
               // type of display image on page
        $Core->TTlI1ll($vMod, 'rss_display_image', 'ext_rss', 'rss_display_image');
               // rss channel title (only to module) = field from news
        $Core->TTlI1ll($vMod, 'rss_channel_title', 'core_module', 'company_name');
               // rss channel description (only to module)
        $vMod->SetOption( "rss_channel_description",       "");
               // rss channel webmaster (only to module)
        $Core->TTlI1ll($vMod, 'rss_channel_webmaster', 'ext_rss', 'rss_channel_webmaster');
               // rss channel generator (only to module, god_mode)
        $Core->TTlI1ll($vMod, 'rss_channel_generator', 'ext_rss', 'rss_channel_generator');
               // rss item title (only to module)
        $vMod->SetOption( "rss_item_title",                "rss_header");
               // rss item description (only to module) = field from news
        $vMod->SetOption( "rss_item_description",          "rss_announce");
               // rss item enclosure (only to module) = field from news
        $vMod->SetOption( "rss_item_enclosure",            "rss_small_image");
               // rss item guid (only to module) = field from news
        $vMod->SetOption( "rss_item_guid",                 "none");
               // rss item guid (only to module) = field from news
        $vMod->SetOption( "rss_item_pubdate",              "rss_c_date");
                // rss channel (only to module, list of files in "_img/")
        $Core->TTlI1ll($vMod, 'rss_channel_image', 'ext_rss', 'rss_channel_image');
                // rss channel (only to module, list of files in "_img/")
        $Core->TTlI1ll($vMod, 'rss_channel_style', 'ext_rss', 'rss_channel_style');
        //-- end RSS

                // Sort fields for some body types:
                // Array(
                //        "{body_type1};..;{body_typeN}"=>Array({field1}, ...{fieldN}),
                //        ...
                //        "{body_type(N+1)};..;{body_type(N+M)}"=>Array({field1}, ...{fieldN})
                //      )
                // Currently available body types: body_items, body_cats.
                // Currently available fileds for body_items: "header", "date"
                // Currently available fileds for body_cats: "name", "position"
        $vMod->SetOption("sort_pages_setup",  Array(
                "body_items;body_urgent_items"=>Array("header", "date"),
                "body_cats;body_urgent_cats"=>Array("name", "position")
        ));
                // Adv place
                // Adv place
        $vMod->SetOption( "adv_place_list",  -1);
        $vMod->SetOption( "adv_place_details",  -1);
        $vMod->SetOption( "adv_place_sb",  -1);
                // Show advertisement statistics counter in admin's list table
        $vMod->SetOption( "show_adv_stat_columns",    false);
                // Show advertisement place name in admin's list table
        $vMod->SetOption( "show_adv_place_columns",    false);

        $vMod->SetOption( "stop_arg_names", array("catid"=>"classifieds_cat", "id"=>"classifieds"));
        $vMod->SetOption( "html_title_template",    "##object_name## - ##cat_name## - ##current_page_name## | ##site_title##");
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
                // Additional template file for spec block
        $vMod->SetOption( "spec_block_template",    "");
        $vMod->SetOption( "spec_id_pages",          Array(-1));
        $vMod->SetOption('spec_cat_id_pages', array(-1));
                // Force expire time (strtotime format), "" - auto
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');
                // Set pages view in pager (numbers or bounds)
        $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');
                // Small block view mode "usual" or "calendar"
        $vMod->SetOption("small_view_mode", "usual");
                // number cols in body_filtered mode
        $vMod->SetOption("body_filtered_cols", 1);
                // number of page items in body_filtered mode
        $vMod->SetOption("body_filtered_page_size", 10);
        $vMod->SetOption( "filter_pages_setup",  Array(
            "body_filtered"=>Array("date_from", "date_to"))
        );
                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
        // Disable search engine indexing for following cases
        $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
}

// } [ami_multifeeds5|classifieds]
// [ami_multifeeds5|classifieds|cat] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
        // CLASSIFIEDS CATEGORIES module constants
        $vMod = &$Core->GetModule($modName);
                // Show counters of classifieds in sections
                $vMod->SetOption("show_counters", true);
                        // Engine version. Set version greater than 0302 to turn on class engine support
                $vMod->SetOption("engine_version", "0303");
                        // Suport multi pages
                        // Array with available pictures
###                $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
                $vMod->SetOption( "item_pictures",           Array("picture", "popup_picture", "small_picture"));
                        // Type of picture, which will be shown in admin item's list:
                        // "none", "picture", "popup_picture", "small_picture"
                $Core->TTlI1ll($vMod, 'col_picture_type', 'ext_images', 'col_picture_type');
                        // Picture generator options
###                $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
                $vMod->SetOption( "generate_pictures",   Array("picture", "popup_picture", "small_picture"));
                $Core->TTlI1ll($vMod, 'prior_source_picture', 'ext_images', 'prior_source_picture');
                $Core->TTlI1ll($vMod, 'picture_maxwidth', 'ext_images', 'picture_maxwidth');
                $Core->TTlI1ll($vMod, 'picture_maxheight', 'ext_images', 'picture_maxheight');
                $Core->TTlI1ll($vMod, 'popup_picture_maxwidth', 'ext_images', 'popup_picture_maxwidth');
                $Core->TTlI1ll($vMod, 'popup_picture_maxheight', 'ext_images', 'popup_picture_maxheight');
                $Core->TTlI1ll($vMod, 'small_picture_maxwidth', 'ext_images', 'small_picture_maxwidth');
                $Core->TTlI1ll($vMod, 'small_picture_maxheight', 'ext_images', 'small_picture_maxheight');
                $Core->TTlI1ll($vMod, 'generate_bigger_image', 'ext_images', 'generate_bigger_image');
                        // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
                $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                        // Default category: "all", "none", "NN" - id of category
                //$vMod->SetOption( "default_category",        "all");
                        // Count of categories per page
                $vMod->SetOption( "page_size",               10);
                        // Sort field of categories "name"
                $vMod->SetOption( "page_sort_col",           "name");
                        // Sort dimension of categories "asc", "desc"
                $vMod->SetOption( "page_sort_dim",           "asc");
                        // Sort field of categories "name"
                $vMod->SetOption( "front_page_sort_col",     "name");
                        // Sort dimension of categories "asc", "desc"
                $vMod->SetOption( "front_page_sort_dim",     "asc");
                        // Count of categories' columns per page
                $vMod->SetOption( "cols",                    2);
                        // Show empty categories
                $vMod->SetOption( "show_empty_cats", true);
                        // Fill empty description/body with announce on details page
                $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description', true, false);
                        // Show urgent elements at pages
//                $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
                $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

                        // Show advertisement statistics counter in admin's list table
                $vMod->SetOption( "show_adv_stat_columns",    false);
                        // Show advertisement place name in admin's list table
                $vMod->SetOption( "show_adv_place_columns",    false);

                $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
                $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');

                        // Displayed fields' properties (used for audit module ONLY)
                // $vMod->SetOption( "audit_displayed_fields", Array("field_cdate"=>"visible", "field_mdate"=>"visible", "field_name"=>"visible", "field_announce"=>"visible", "field_body"=>"visible", "field_filename"=>"visible"));
                        // Array of required fields (used for audit module ONLY)
                // $vMod->SetOption( "audit_required_fields",  Array());
                        // Audit changes made in admin interface
                $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
                        // Send notification on user's item changing
                $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
                        // Audit action handling rules
                $vMod->SetOption( "audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
                        // Extensions
                $vMod->SetOption("extensions", array('ext_reindex'));
                        // 404 header for not found pages
                $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
}

// } [ami_multifeeds5|classifieds|cat]
// [ami_login_history|login_history] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
}

// } [ami_login_history|login_history]
// [ami_tags|tags] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    //  TAGS module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption("engine_version", '0303');

    $vMod->SetOption("page_size", 200);

    $vMod->SetOption("body_browse_cols",     1);
    $vMod->SetOption("page_sort_col",           "tag");
    // Sort dimension of items "asc", "desc"
    $vMod->SetOption("page_sort_dim",           "asc");

    $vMod->SetOption("front_page_sort_col",           "tag");
    // Sort dimension of items "asc", "desc"
    $vMod->SetOption("front_page_sort_dim",           "asc");

    $vMod->SetOption("front_page_sort_col_result",           "name");
    // Sort dimension of items "asc", "desc"
    $vMod->SetOption("front_page_sort_dim_result",           "asc");

    $vMod->SetOption("page_size_result", 10);


    $vMod->SetOption("tags_presense_number", "lev5");    // 3 - 10

    $vMod->SetOption("page_size_small", 30);

    $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
    $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
    $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
    // 404 header for not found pages
    $Core->TTlI1ll($vMod, 'set_404_header', 'page_404', 'set_404_header');

    // number of tags per small block :)
    $vMod->SetOption("page_sort_col_small",     "tag");
    // Sort dimension of items "asc", "desc"
    $vMod->SetOption("page_sort_dim_small",     "asc");
    // number of tags per small block :)
    $vMod->SetOption("page_size_small", 30);
    // view type of small block
    $vMod->SetOption( "body_small_view_type", "cloud");
    //
    $vMod->SetOption("body_small_cols",     1);

    $vMod->SetOption( "spec_block_template",    "");

    $vMod->SetOption("stop_arg_names", array("id"=>"srv_tags"));
}

// } [ami_tags|tags]
// [ami_tags|tags|reindex] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption('allow_runtime_indexing', false);
}

// } [ami_tags|tags|reindex]
// [ami_page_manager|layouts] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    //  Layouts module constants
    $vMod = &$Core->GetModule($modName);
    // Sort field "name", "start", "end"
    $vMod->SetOption( "page_sort_col",              "name");
    // Sort dimension "asc", "desc"
    $vMod->SetOption( "page_sort_dim",              "asc");
    // Layout id for mobile devices
    $vMod->SetOption('mobile_layout_id', 101);
}

// } [ami_page_manager|layouts]
// [ami_clean|templates] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    //  TEMPLATES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);

    $vMod->SetOption("page_sort_col", "name");
}

// } [ami_clean|templates]
// [ami_modules_templates|templates] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    //  MODULES TEMPLATES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    $vMod->SetOption("page_sort_col", "modified");
    $vMod->SetOption("page_sort_dim", "desc");
    $vMod->SetOption("multi_site", true);
}

// } [ami_modules_templates|templates]
// [ami_modules_templates|langs] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    //  MODULES TEMPLATES LANGS module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    $vMod->SetOption("page_sort_col", "modified");
    $vMod->SetOption("page_sort_dim", "desc");
    $vMod->SetOption("admin_as_submenu_caption", true);
    $vMod->SetOption("multi_site", true);
}

// } [ami_modules_templates|langs]
// [ami_fake|google_sitemap] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    //  GOOGLE SITEMAP module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption("engine_version", "0303");
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption("sitemaps_disabled", false);
    $vMod->SetOption("sitemap_ping_google", "weekly");
    require_once $GLOBALS['CLASSES_PATH'] . 'CMS_ActModule.php';
    require_once $GLOBALS['CLASSES_PATH'] . 'ModuleGoogleSitemap.php';
    $vMod->SetOption("sitemap_modules", ModuleGoogleSitemap::TII1I1T($Core));
    $vMod->SetOption("sitemap_changefreq", ModuleGoogleSitemap::TII1I1I($Core));
    $vMod->SetOption("sitemap_auto_update", false);
    $vMod->SetOption("sitemap_auto_update_pages", 10);
    $vMod->SetOption("sitemap_compress", false);
    $vMod->SetOption('autodeletion_period', '1 month');
}

// } [ami_fake|google_sitemap]
// [ami_sitemap_history|sitemap_history] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
        // SITEMAP HISTORY module constants
        $vMod = &$Core->GetModule($modName);
	$oDeclarator->setupAsyncInterface($vMod, FALSE);
        $vMod->SetOption("page_sort_col", "date");
        $vMod->SetOption("page_sort_dim", "desc");
}

// } [ami_sitemap_history|sitemap_history]
// [ami_discussion|guestbook] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
        $vMod->SetOption("front_page_sort_col", "date");
        $vMod->SetOption("front_page_sort_dim", "desc");
        $vMod->SetOption('engine_version', '0303');
        $vMod->SetOption('page_size', 10);
                // Front: number of pages in messages pager
        $vMod->SetOption('messages_pages', 5);
                // messages addition by registered users only
        $vMod->SetOption('add_messages_by_registered_only', false);
                // message can be updated for this period by its authorized author
        $vMod->SetOption('updatable_period', '6 hour');
                // Frame extarnal links in messages by <noindex> tags
        $vMod->SetOption('noindex_external_links', true);
                // Display sys user username as "Administration"
        $vMod->SetOption('sys_user_as_administration', true);
                // allowed front images
        $vMod->SetOption('front_images', array ('registered_users_only', 'internal_links', 'external_links'));
                // Publish post by default
        $vMod->SetOption('force_publish', true);
                // Force expire time (strtotime format), "" - auto
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');
                // Currently available "ext_twist_prevention"
        $vMod->SetOption('extensions', array ('ext_twist_prevention', 'ext_reindex'));

        $vMod->SetOption('notify_admin_about_new_message', true);
                // email address that will receive questions from the site
        $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'core_module', 'company_email');
                // Use tree view
        $vMod->SetOption('use_tree_view', true);
                // Shared mode from mailbox option. Without domain! Domain will be appended by script
        $Core->TTlI1ll($vMod, 'from_mbox', 'core_module', 'from_mbox');

        // {{{ twist prevention extension options

                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');

        // }}}

                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
}

// } [ami_discussion|guestbook]
// [ami_discussion|discussion] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    // DISCUSSION module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('engine_version', '0303');
    $vMod->SetOption('noindex_external_links', TRUE);
    // Sort field of messages
    $vMod->SetOption('page_sort_col', 'msg_date');
    // Sort dimension of articles "asc", "desc"
    $vMod->SetOption('page_sort_dim', 'desc');
    // Extensions
    $vMod->SetOption('extensions', array('ext_reindex'));
}

// } [ami_discussion|discussion]
// [ami_forum|forum] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    // FORUM module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_dim_small', 'desc');
        $vMod->SetOption('engine_version', '0303');
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
            // Suport multi pages
        $vMod->SetOption('multi_page', false);

            //Use categories
        $vMod->SetOption('use_categories', true);
        $vMod->SetOption('stop_arg_names', $vMod->GetOption('use_categories') ? $Core->GetModProperty('forum_cat', 'stop_arg_names') : $Core->GetModProperty('forum', 'stop_arg_names'));

        $vMod->SetOption('page_size', 10);
        $vMod->SetOption('page_sort_col', 'date');
        $vMod->SetOption('page_sort_dim', 'desc');
        $vMod->SetOption('front_page_sort_col', 'msg_date');
        $vMod->SetOption('front_page_sort_dim', 'desc');

                // topics addition by registered users only
        $vMod->SetOption('add_topics_by_registered_only', true);
                // messages addition by registered users only
        $vMod->SetOption('add_messages_by_registered_only', false);
                // add topics/posts as published from not authorized visitors
        $vMod->SetOption('publish_from_not_athorized', FALSE);
                // add topics/posts as published from authorized visitors
        $vMod->SetOption('publish_from_athorized', true);
                // message can be updated for this period by its authorized author
        $vMod->SetOption('updatable_period', '6 hour');
                // Frame extarnal links in messages by <noindex> tags
        $vMod->SetOption('noindex_external_links', true);
                // Display sys user username as "Administration"
        $vMod->SetOption('sys_user_as_administration', true);

        $vMod->SetOption('notify_admin_about_new_topic', false);
        $vMod->SetOption('notify_admin_about_new_message', true);
                // email address that will receive questions from the site
        $Core->TTlI1ll($vMod, 'forum_admin_email', 'core_module', 'company_email');
                // Shared mode from mailbox option. Without domain! Domain will be appended by script
        $Core->TTlI1ll($vMod, 'from_mbox', 'core_module', 'from_mbox');

        $vMod->SetOption( 'multicat',                   false);
                // Show list of categories inside item details
        $vMod->SetOption( 'multicat_in_body_details',   false);
        $vMod->SetOption( 'show_last_items',            0); ### ??? was 10

                // Count of categories' columns per page
        $vMod->SetOption( 'body_cats_cols',             1);
                // Count of questions columns on spec block
        $vMod->SetOption( 'body_small_cols',            1);
                // Count of items, which will be shown. If category(is) is specified, then count of items from each category.
        $vMod->SetOption('small_number_items',          5);
                // List of categories id, from which the items will be shown
                //(0 - first N categories, which is specified in an option 'small_number_categories').
        $vMod->SetOption('small_category_ids',          0);
                // Number categories, from which the items will be shown.
                // Only when option 'small_category_ids' eq. 0.
                // (if 0  and option 'small_category_ids' eq. 0, then categories will be not specified)
        $vMod->SetOption('small_number_categories',     0);
                // Sort field of categories 'name', 'position'
        $vMod->SetOption('small_categories_sort_col',   'name');
                // Sort dimension of categories 'asc', 'desc'
        $vMod->SetOption('small_categories_sort_dim',   'asc');
                // Sort field of articles 'date', 'header'
        $vMod->SetOption('small_items_sort_col',        'date');
                // Sort dimension of articles 'asc', 'desc'
        $vMod->SetOption('small_items_sort_dim',        'desc');
                // Sort fields 'date', 'topic'
        $vMod->SetOption( 'front_subitem_sort_col',     'date');
                // Sort dimensions 'asc', 'desc'
        $vMod->SetOption( 'front_subitem_sort_dim',     'desc');

        $vMod->SetOption('sort_pages_setup', array (
                'body_items;body_urgent_items' => array ('msg_date', 'date', 'subject', 'votes_rate'),
                'body_cats;body_urgent_cats'   => array ('name', 'position')
        ));

                // Currently available 'ext_twist_prevention', 'ext_rss'
        $vMod->SetOption('extensions', array ('ext_twist_prevention', 'ext_reindex'));
                // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));
        $vMod->SetOption('html_title_template',    '##object_name## - ##cat_name## - ##current_page_name## | ##site_title##');
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
            // Disable search engine indexing for following cases
        $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
                // Additional template file for spec block
        $vMod->SetOption('spec_block_template', '');
                // Additional template file for spec block
        $vMod->SetOption('spec_id_pages', array(-1));
        $vMod->SetOption('spec_cat_id_pages', array(-1));

        $vMod->SetOption('avatar_maxwidth', 64);
        $vMod->SetOption('avatar_maxheight', 64);
                // allowed front images
        $vMod->SetOption('front_images', array ('registered_users_only', 'internal_links', 'external_links'));

        // {{{ twist prevention extension options

                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add '_twist' postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');
                // Force expire time (strtotime format), '' - auto
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');

        // }}}

                // Front: number of messages per page
        $vMod->SetOption('messages_per_page', 20);
                // Front: number of messages per page
        $vMod->SetOption('messages_dim', 'asc');
                // Front: number of pages in messages pager
        $vMod->SetOption('messages_pages', 5);
                // Front: maximum topic length in TITLE tag
        $vMod->SetOption('topic_tool_tip_length', 200);

        //-- RSS extension FORUM module constants
               // number of RSS channel elements
//        $Core->SetOptionInherited($vMod, 'rss_num_elements', 'ext_rss', 'rss_num_elements');
        $vMod->SetOption('rss_elements_period', '1 week');
        $vMod->SetOption('rss_elements_period_field', 'date');
               // display on page
        $Core->TTlI1ll($vMod, 'rss_display_page', 'ext_rss', 'rss_display_page');
               // type of display image on page
        $Core->TTlI1ll($vMod, 'rss_display_image', 'ext_rss', 'rss_display_image');
               // rss channel title (only to module) = field from news
        $vMod->SetOption( "rss_channel_title",             "");
               // rss channel description (only to module)
        $vMod->SetOption( "rss_channel_description",       "");
               // rss channel webmaster (only to module)
        $Core->TTlI1ll($vMod, 'rss_channel_webmaster', 'ext_rss', 'rss_channel_webmaster');
               // rss channel generator (only to module, god_mode)
        $Core->TTlI1ll($vMod, 'rss_channel_generator', 'ext_rss', 'rss_channel_generator');
               // rss item title (only to module)
        $vMod->SetOption( "rss_item_title",                "rss_topic");
               // rss item description (only to module) = field from news
        $vMod->SetOption( "rss_item_description",          "rss_message");
               // rss item enclosure (only to module) = field from news
        $vMod->SetOption( "rss_item_enclosure",            "rss_small_image");
               // rss item guid (only to module) = field from news
        $vMod->SetOption( "rss_item_guid",                 "none");
               // rss item guid (only to module) = field from news
        $vMod->SetOption( "rss_item_pubdate",              "rss_c_date");
                // rss channel (only to module, list of files in "_img/")
        $Core->TTlI1ll($vMod, 'rss_channel_image', 'ext_rss', 'rss_channel_image');
                // rss channel (only to module, list of files in "_img/")
        $Core->TTlI1ll($vMod, 'rss_channel_style', 'ext_rss', 'rss_channel_style');
        //-- end RSS

        // specblock {{{
        $vMod->SetOption('page_size_small', 5);
        $vMod->SetOption('small_display_message', false);
        $vMod->SetOption('small_topic_length', 100);
        $vMod->SetOption('small_message_length', 250);
###        $vMod->SetOption('small_cache_expire', '1 hour');
        // }}}

                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
}

// } [ami_forum|forum]
// [ami_forum|forum|cat] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    // FORUM CATEGORIES module constants
    $vMod = &$Core->GetModule($modName);
        // Engine version. Set version greater than 0302 to turn on class engine support
        $vMod->SetOption('engine_version', '0303');

        $vMod->SetOption( 'admin_as_submenu_caption', true);
        // 'auto' (first time only or for empty fields), 'force' (everytime), 'none' (never)
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                // Count of categories per page
        $vMod->SetOption('page_size', 10);
                // Sort field of categories 'name', 'position'
        $vMod->SetOption('page_sort_col', 'position');
                // Sort dimension of categories 'asc', 'desc'
        $vMod->SetOption('page_sort_dim', 'asc');
                // Sort field of categories 'name', 'position'
        $vMod->SetOption('front_page_sort_col', 'position');
                // Sort dimension of categories 'asc', 'desc'
        $vMod->SetOption('front_page_sort_dim', 'asc');
                // Count of categories' columns per page
        $vMod->SetOption('cols', 2);
                // Show empty categories
        $vMod->SetOption('show_empty_cats', true);
                // Fill empty description/body with announce on details page
        $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description', true, false);
                // topic field will be stripped to
        $vMod->SetOption('topic_len_in_cats', 30);
                // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

        // Show counters of questions in subjects:
        $vMod->SetOption( 'show_counters',     true);
        $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
                // Extensions
        $vMod->SetOption("extensions", array('ext_reindex'));

                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
}

// } [ami_forum|forum|cat]
// [ami_data_exchange|forum] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    // FORUM DATA EXCHANGE module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
        // Engine version. Set version greater than 0302 to turn on class engine support
        $vMod->SetOption('engine_version', '0303');
        $vMod->SetOption('admin_as_submenu_caption', true);

        $vMod->SetOption('buffer_size', 256 * 1024);

                // Import path
                // used prefix - $MODULE_PICTURES_PATH
        $vMod->SetOption('import_path', '_upload/');
                // Import tmp path (for tmp files)
                // used prefix - $MODULE_PICTURES_PATH
        $vMod->SetOption('import_tmp_path', '_upload/tmp/');
                // Import log file name
                // used prefix - $LOG_PATH
        $vMod->SetOption('import_log_file_name', 'forum_import.log');
                // Export path
                // used prefix - $MODULE_PICTURES_PATH
        $vMod->SetOption('export_path', '_upload/tmp/');
                // Files that users cannot upload
        $vMod->SetOption('forbidden_files', array ('exe', 'pif', 'bat', 'scr', 'reg', 'cmd', 'dll', 'com', 'lnk', 'vbs', 'php'));
                // Save methods, currently available: "file", "email".
        $vMod->SetOption("export_save method",     "file");

                // Import log file name
                // used prefix - $LOG_PATH
//        $vMod->SetOption("import_log_file_name",   "photoalbum_import.log");
//                // Image import module params
//        $vMod->SetOption("PhotoExchangeDriver_allowed_actions",   Array("add", "apply"));
//        $vMod->SetOption("PhotoExchangeDriver_overwrite_images",  true);
//        $vMod->SetOption("PhotoExchangeDriver_use_transliterate", true);
//        $vMod->SetOption("PhotoExchangeDriver_fields_map",   Array(
//                "IMAGE"=>Array(
//                          //"IMAGE_MAIN"=>Array("type"=>"proc_data", "value"=>"store_name"),
//                          //"IMAGE_SMALL"=>Array("type"=>"value", "value"=>""),
//                          "IMAGE_POPUP"=>Array("type"=>"proc_data", "value"=>"store_name"),
//                           ),
//                "CATEGORY"=>Array(
//                          "DESCRIPTION"=>Array("type"=>"proc_data", "value"=>"dir"),
//                          "IS_DELETED"=>Array("type"=>"value", "value"=>"false"),
//                          "ID_EXTERNAL"=>Array("type"=>"proc_data", "value"=>"id"),
//                           ),
//                "CATALOG"=>Array(
//                          "IS_DELETED"=>Array("type"=>"value", "value"=>"false"),
//                          "DESCRIPTION"=>Array("type"=>"proc_data", "value"=>"name"),
//                          "ID_EXTERNAL"=>Array("type"=>"proc_data", "value"=>"id"),
//                          "ID_PARENT_EXTERNAL"=>Array("type"=>"proc_data", "value"=>"cid"),
//                          "IMAGE",
//                        ),
//              ));
}

// } [ami_data_exchange|forum]
// [ami_eshop_discounts|discounts] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // ESHOP DISCOUNTS module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption("engine_version", '0303');
    // discounts syncopation method: "discounts_sum" or "max_discount"
    $vMod->SetOption("discounts_syncopation", "max_discount");
    // products discounts syncopation method: "products_discount", "max_of_products_and_calculated_discount" or "sum_of_calculated_and_products_discount"
    $vMod->SetOption("products_discounts_syncopation", "max_of_products_and_calculated_discount");
    // order details discount view: emtpty, "column" and/or "row"
    $vMod->SetOption("order_details_discount_view", array ("column", "row"));
}

// } [ami_eshop_discounts|discounts]
// [ami_eshop_coupons|coupons] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // ESHOP COUPONS module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption('extensions', array());
    $vMod->SetOption('engine_version', '0303');
    $vMod->SetOption('time_limited', false);
    $vMod->SetOption('default_number_of_activations', 0);
    $vMod->SetOption('id_creation_type', 'digits');
    $vMod->SetOption('id_length', 16);
    $vMod->SetOption('id_splitter', '-');
    $vMod->SetOption('id_splitter_period', 4);
    $vMod->SetOption('number_of_coupons', 100);
    // Size of owners list dropdown
    $vMod->SetOption('owners_list_size', 50);
    // Enable external ID generating during creating
    $vMod->SetOption('generate_id_external', true);
    $vMod->SetOption('auto_gen_id_external', 'Amiro_gen_');
    // Order statuses list meaning coupon is unused (god mode)
    $vMod->SetOption('order_statuses_unused', array ('draft', 'printed', 'rejected', 'cancelled'));

    $vMod->SetOption('use_categories', true);
}

// } [ami_eshop_coupons|coupons]
// [ami_eshop_coupons|coupons|cat] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // ESHOP COUPONS CATEGORIES module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption('engine_version', '0303');
    $vMod->SetOption('generate_id_external', true);
    $vMod->SetOption('auto_gen_id_external', 'Amiro_gen_');
}

// } [ami_eshop_coupons|coupons|cat]
// [ami_eshop_shipping|methods] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // SHIPPING METHODS module constants
    $vMod = &$Core->GetModule($modName);
    // Engine version. Set version greater than 0302 to turn on class engine support
    $vMod->SetOption("engine_version", "0303");
    $vMod->SetOption("use_shipping_module", true);
    // Method of displaing shipping conflicts (for group of shipping modules), "show_intersection" or "show_shipping_for_each_type"
    $vMod->SetOption("shipping_conflicts", "show_intersection");
    // What to do in case of shipping methods intersection emptiness: "ask_to_change_order" or "use_each_shipping_type_mode"
    $vMod->SetOption("on_intersection_emptiness", "ask_to_change_order");
    $vMod->SetOption("page_sort_col", "position");
    $vMod->SetOption("page_sort_dim", "asc");
    $vMod->SetOption("fieldsets", array("custom_shipping_00", "custom_shipping_01", "custom_shipping_02", "custom_shipping_03", "custom_shipping_04", "custom_shipping_05", "custom_shipping_09"));
    $vMod->SetOption("fieldsets_options", Array("custom_shipping_01" => 'fieldsets_options_01'));
    $vMod->SetOption("available_shipping_fields", array('rest', 'weight', 'size'));
    $vMod->SetOption("show_tax_classes_in_admin", 20);
    $vMod->SetOption('range_field', 'size');
    $vMod->SetOption('use_yandex_fast_order', false);
}

// } [ami_eshop_shipping|methods]
// [ami_eshop_shipping|types] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // SHIPPING TYPES module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    // Engine version. Set version greater than 0302 to turn on class engine support
    $vMod->SetOption("engine_version", "0303");
}

// } [ami_eshop_shipping|types]
// [ami_eshop_shipping|fields] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // SHIPPING TYPES module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption("admin_as_submenu_caption", true);
    $vMod->SetOption("engine_version", "0600");
}

// } [ami_eshop_shipping|fields]
// [ami_eshop_tax|classes] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // TAX CLASSES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    $vMod->SetOption("engine_version", "0303");
    $vMod->SetOption("page_sort_col", "is_default");
    $vMod->SetOption("page_sort_dim", "desc");
    $vMod->SetOption("tax_system", $Core->GetOption("default_data_lang") == 'ru' ? "ru" : "us");
    $vMod->SetOption("tax_scheme", "sum");
    $vMod->SetOption("charge_tax_type", "detach");
    $vMod->SetOption("shipping_tax", 0);
}

// } [ami_eshop_tax|classes]
// [ami_ext|eshop_custom_fields] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // Custom fields module constants
    $vMod = &$Core->GetModule($modName);
    // The common name part for the custom items. Name will be "thisname_x" where x is 1,2,3, etc. DB and HTML names should be the same
    $vMod->SetOption( "custom_name", "custom_field_");
    // Property - show price, rest, weight, size [1 = yes, 0 = no]
    $vMod->SetOption("property_price", "1");
    $vMod->SetOption("property_rest", "1");
    $vMod->SetOption("property_weight", "1");
    $vMod->SetOption("property_size", "1");
    // Field types. array - through the first element to last, subarray - type (float, char, set), reference to the number of existing reference.
    // Ex. Array(Array("float"), Array("char"), Array("char", "1"), Array("set", "2"), Array("char", "1", "select"), Array("char", "2", "multiple_select",  "id asc")
    $vMod->SetOption(
        "custom_types",
            array(
                array("float"),
                array("char", "1", "select"),
                array("set", "1"),
                array("related_items"),
                array("related_items")
            )
    );
    // Field types (for system references). array - through the first element to last, subarray - type (float, char, set), reference to the number of existing reference.
    // Ex. Array(Array("float"), Array("char"), Array("char", "1001"), Array("set", "1002"))
    $vMod->SetOption(
        "system_custom_types",
        array(
            "1001" => array("char", "1001"),
            "1002" => array("char", "1002"),
        )
    );
    // Fillter fields for some body types:
    // Array( "{body_type}"=>Array({fields}) ... )
    // Allowed char and fields are "ext_custom_1", "ext_custom_2", ...
    // Allowed float fields are "ext_custom_1_from", "ext_custom_1_to", ...
    $vMod->SetOption("filter_pages_setup", array("body_items;body_search" => array("ext_custom_2")));
        // Modules to be updated
    $vMod->SetOption("enrolled_modules", "eshop_item");
}

// } [ami_ext|eshop_custom_fields]
// [ami_ext|kb_custom_fields] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // Custom fields module constants
    $vMod = &$Core->GetModule($modName);
    // The common name part for the custom items. Name will be "thisname_x" where x is 1,2,3, etc. DB and HTML names should be the same
    $vMod->SetOption( "custom_name", "custom_field_");
    // Property - show price, rest, weight, size [1 = yes, 0 = no]
    $vMod->SetOption("property_price", "1");
    $vMod->SetOption("property_rest", "1");
    $vMod->SetOption("property_weight", "1");
    $vMod->SetOption("property_size", "1");
    // Field types. array - through the first element to last, subarray - type (float, char, set), reference to the number of existing reference.
    // Ex. Array(Array("float"), Array("char"), Array("char", "1"), Array("set", "2"), Array("char", "1", "select"), Array("char", "2", "multiple_select",  "id asc")
    $vMod->SetOption(
        "custom_types",
            array(
                array("float"),
                array("char", "1", "select"),
                array("set", "1"),
                array("related_items"),
                array("related_items")
            )
    );
    // Field types (for system references). array - through the first element to last, subarray - type (float, char, set), reference to the number of existing reference.
    // Ex. Array(Array("float"), Array("char"), Array("char", "1001"), Array("set", "1002"))
    $vMod->SetOption(
        "system_custom_types",
        array(
            "1001" => array("char", "1001"),
            "1002" => array("char", "1002"),
        )
    );
    // Fillter fields for some body types:
    // Array( "{body_type}"=>Array({fields}) ... )
    // Allowed char and fields are "ext_custom_1", "ext_custom_2", ...
    // Allowed float fields are "ext_custom_1_from", "ext_custom_1_to", ...
    $vMod->SetOption("filter_pages_setup", array("body_items;body_search" => array("ext_custom_2")));
        // Modules to be updated
    $vMod->SetOption("enrolled_modules", "kb_item");
}

// } [ami_ext|kb_custom_fields]
// [ami_ext|portfolio_custom_fields] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // Custom fields module constants
    $vMod = &$Core->GetModule($modName);
    // The common name part for the custom items. Name will be "thisname_x" where x is 1,2,3, etc. DB and HTML names should be the same
    $vMod->SetOption( "custom_name", "custom_field_");
    // Property - show price, rest, weight, size [1 = yes, 0 = no]
    $vMod->SetOption("property_price", "1");
    $vMod->SetOption("property_rest", "1");
    $vMod->SetOption("property_weight", "1");
    $vMod->SetOption("property_size", "1");
    // Field types. array - through the first element to last, subarray - type (float, char, set), reference to the number of existing reference.
    // Ex. Array(Array("float"), Array("char"), Array("char", "1"), Array("set", "2"), Array("char", "1", "select"), Array("char", "2", "multiple_select",  "id asc")
    $vMod->SetOption(
        "custom_types",
            array(
                array("float"),
                array("char", "1", "select"),
                array("set", "1"),
                array("related_items"),
                array("related_items")
            )
    );
    // Field types (for system references). array - through the first element to last, subarray - type (float, char, set), reference to the number of existing reference.
    // Ex. Array(Array("float"), Array("char"), Array("char", "1001"), Array("set", "1002"))
    $vMod->SetOption(
        "system_custom_types",
        array(
            "1001" => array("char", "1001"),
            "1002" => array("char", "1002"),
        )
    );
    // Fillter fields for some body types:
    // Array( "{body_type}"=>Array({fields}) ... )
    // Allowed char and fields are "ext_custom_1", "ext_custom_2", ...
    // Allowed float fields are "ext_custom_1_from", "ext_custom_1_to", ...
    $vMod->SetOption("filter_pages_setup", array("body_items;body_search" => array("ext_custom_2")));
        // Modules to be updated
    $vMod->SetOption("enrolled_modules", "portfolio_item");
}

// } [ami_ext|portfolio_custom_fields]
// [ami_ext|zones] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // TAX ZONES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    $vMod->SetOption("engine_version", "0303");
    $vMod->SetOption("page_sort_col", "is_default");
    $vMod->SetOption("page_sort_dim", "desc");
}

// } [ami_eshop_tax|zones]
// [ami_clean|ami_seopult] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    $vMod->setOption('domain', '');
    $vMod->setOption('hash', '');
    $vMod->setOption('crypt_key', '');
//    $vMod->setOption('admin_menu_allowed', FALSE);
//    $vMod->SetOption('start_disable', TRUE);
}

// } [ami_clean|ami_seopult]
// [ami_ext|rss] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    //--  EXT RSS module constants
    $vMod = &$Core->GetModule($modName); //--
        $vMod->SetOption( "rss_num_elements",              10);
        $vMod->SetOption( "rss_display_page",              "rss_generate");
        $vMod->SetOption( "rss_display_image",             "rss_rss20image");
        $vMod->SetOption( "rss_channel_copyright",         "");
        $vMod->SetOption( "rss_channel_webmaster",         "");
        $vMod->SetOption( "rss_channel_generator",         "");
        $vMod->SetOption( "rss_channel_image",             -1);
        $vMod->SetOption( "rss_channel_style",             -1);
}

// } [ami_ext|rss]
// [ami_fake|rss] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    // EXT RSS RULES module constants
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
}

// } [ami_fake|rss]
// [ami_async|private_messages] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('engine_version', '0600');
    $vMod->SetOption('module_link', array('owner' => 'services'));
    $vMod->SetOption('notify_by_email', FALSE);
}

// } [ami_async|private_messages]
// [ami_clean|ami_market] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('engine_version', '0600');
    $vMod->SetOption('module_link', array('owner' => 'plugins'));
    // $vMod->SetOption('admin_menu_allowed', TURE);
}
$modName = 'mod_manager';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('engine_version', '0600');
    $vMod->SetOption('module_link', array('owner' => 'plugins'));
    $vMod->SetOption('ext_templates_imported', FALSE);
}

// } [ami_clean|ami_market]
// [ami_clean|data_import] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
}

// } [ami_clean|data_import]
// [ami_clean|webservice] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)) {
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
}

// } [ami_clean|webservice]
// [ami_multifeeds5|articles] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // ARTICLES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    // $vMod->SetOption('rule_test', Array('r1'));
    $vMod->SetOption('cols', 1);

            // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
    $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
            // Array with available pictures
    ###        $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
    $vMod->SetOption("item_pictures",           Array("picture", "popup_picture", "small_picture"));
            // Type of picture, which will be shown in admin item's list:
            // "none", "picture", "popup_picture", "small_picture"
    $Core->TTlI1ll($vMod, 'col_picture_type', 'ext_images', 'col_picture_type');
            // Picture generator options
    ###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
    $vMod->SetOption("generate_pictures",   Array("picture", "popup_picture", "small_picture"));
    $Core->TTlI1ll($vMod, 'prior_source_picture', 'ext_images', 'prior_source_picture');
    $Core->TTlI1ll($vMod, 'picture_maxwidth', 'ext_images', 'picture_maxwidth');
    $Core->TTlI1ll($vMod, 'picture_maxheight', 'ext_images', 'picture_maxheight');
    $Core->TTlI1ll($vMod, 'popup_picture_maxwidth', 'ext_images', 'popup_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'popup_picture_maxheight', 'ext_images', 'popup_picture_maxheight');
    $Core->TTlI1ll($vMod, 'small_picture_maxwidth', 'ext_images', 'small_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'small_picture_maxheight', 'ext_images', 'small_picture_maxheight');
    $Core->TTlI1ll($vMod, 'generate_bigger_image', 'ext_images', 'generate_bigger_image');

            //Use categories
    $vMod->SetOption("use_categories",             true);
    if($vMod->GetOption( "use_categories")){
        $vMod->SetOption("stop_arg_names", $Core->GetModProperty("##modId##_cat", "stop_arg_names"));
    } else {
        $vMod->SetOption("stop_arg_names", $Core->GetModProperty("##modId##", "stop_arg_names"));
    }

    $vMod->SetOption("subitems_total_items_limit", 30);
    $vMod->SetOption("spec_total_items_limit", 30);

            // Count of articles per page
    $vMod->SetOption("page_size",                  10);
            // Sort field of articles "date", "header"
    $vMod->SetOption("page_sort_col",              "date");
            // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("page_sort_dim",              "desc");
    // Sort field of articles "date", "header"
    $vMod->SetOption("front_subitem_sort_col",     "date");
            // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("front_subitem_sort_dim",     "desc");
            // Sort field of articles "date", "header"
    $vMod->SetOption("front_page_sort_col",        "date");
            // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("front_page_sort_dim",        "desc");
            // Suport multi pages
    $vMod->SetOption("multi_page",                 true);
            // type of archiving method: "manual", "date"
    $vMod->SetOption("archive_type",               "manual");
            // strings containing an english date format
            // Valid only when archive type is date
            // Examples:
            // "10 September 2000"
            // "-1 day"
            // "-1 week"
            // "-12 month"
    $vMod->SetOption("archive_period",             "-1 year");
            // type of articles to show: "all", "active", "archive"
    $vMod->SetOption("show_type",                  "all");
            // Show list of categories inside category
    $vMod->SetOption("multicat",                   false);
            // Show list of categories inside item details
    $vMod->SetOption("multicat_in_body_details",   false);
            // Show N last items, when url parametr "show_last=1" is present
            // If N=0, then working in normal mode
    $vMod->SetOption("show_last_items",            10);
            // Show forum_count_replies, true, false
    $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
            // Show forum_count_topics, true, false
    //        $Core->SetOptionInherited($vMod, 'show_forum_count_topics', 'ext_discussion', 'show_forum_count_topics');
            // Show forum links in news list, true, false
    $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
            // Show forum links in small news block, true, false
    $Core->TTlI1ll($vMod, 'show_forum_link_in_small', 'ext_discussion', 'show_forum_link_in_small');
            // Show forum at element details page right away
    $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details');
            // Display element numbers in messages list
    $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
            // Discussion admin notification
    $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
            // Webmaster email
    $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
            // Use tree view
    $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');
            // Anonymous user email
    //        $vMod->SetOption("forum_anonymous_user_email",       "anonymous@localhost.ru");
            // Are attaches allowed
    //        $Core->SetOptionInherited($vMod, 'forum_attaches_allowed', 'ext_discussion', 'forum_attaches_allowed');
            // False - one level tree messages, true - normal tree
    //        $Core->SetOptionInherited($vMod, 'forum_only_one_level', 'ext_discussion', 'forum_only_one_level');
            // Set type of pager, "items", "topics"
    //        $Core->SetOptionInherited($vMod, 'forum_pager_type', 'ext_discussion', 'forum_pager_type');
            // Count of forum items per page
    //        $Core->SetOptionInherited($vMod, 'forum_page_size', 'ext_discussion', 'forum_page_size');
            // Only one topic per item
    //        $Core->SetOptionInherited($vMod, 'forum_multi_topics', 'ext_discussion', 'forum_multi_topics');

            // Count of categories' columns per page
    $vMod->SetOption("body_cats_cols",             1);
            // Count of articles columns on spec block
    $vMod->SetOption("body_small_cols",            1);
            // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
    $vMod->SetOption("show_subitems",              -1);
            // The number of sub items, after which is inserted splitter, 0 - no splitter
    $vMod->SetOption("subitems_splitter_period",    0);
            // Count of subitems' columns per page
    $vMod->SetOption("subitems_cols",               1);
    // #CMS-11147
    $vMod->SetOption('subitems_grp_by_cat', TRUE);
            // Count of items, which will be shown. If category(is) is specified, then count of items from each category.
    $vMod->SetOption("small_number_items",          5);
            // List of categories id, from which the items will be shown
            //(0 - first N categories, which is specified in an option "small_number_categories").
    $vMod->SetOption("small_category_ids",          0);
    // Number categories, from which the items will be shown.
    // Only when option "small_category_ids" eq. 0.
    // (if 0  and option "small_category_ids" eq. 0, then categories will be not specified)
    $vMod->SetOption('small_number_categories', 0);
            // Sort field of categories "name", "position"
    $vMod->SetOption("small_categories_sort_col",   "name");
            // Sort dimension of categories "asc", "desc"
    $vMod->SetOption("small_categories_sort_dim",   "asc");
            // Sort field of articles "date", "header"
    $vMod->SetOption("small_items_sort_col",        "date");
            // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("small_items_sort_dim",        "desc");
            // Fill empty description/body with announce on details page
    $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description');
            // Currently available "ext_discussion", "ext_tags"
    $vMod->SetOption('extensions', array('ext_twist_prevention', 'ext_rss', 'ext_reindex'));
            // Show urgent elements at pages
    //        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
    $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

    // {{{ twist prevention extension options

            // period of next active action preventing, e. g. adding message to forum (into current module)
    ###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
    $vMod->SetOption('action_period', '5 second');
            // show captcha (image to prevent from robots actions)
    $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
            // check captcha without page reloading
    $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
            // add "_twist" postfix to module action in case of twist detection
    $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
            // add status message in case of twist detection
    $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');

    // }}}

    //-- RSS extension ARTICLES module constants
           // number of RSS channel elements
    $Core->TTlI1ll($vMod, 'rss_num_elements', 'ext_rss', 'rss_num_elements');
           // display on page
    $Core->TTlI1ll($vMod, 'rss_display_page', 'ext_rss', 'rss_display_page');
           // type of display image on page
    $Core->TTlI1ll($vMod, 'rss_display_image', 'ext_rss', 'rss_display_image');
           // rss channel title (only to module) = field from news
    $Core->TTlI1ll($vMod, 'rss_channel_title', 'core_module', 'company_name');
           // rss channel description (only to module)
    $vMod->SetOption("rss_channel_description",       "");
           // rss channel webmaster (only to module)
    $Core->TTlI1ll($vMod, 'rss_channel_webmaster', 'ext_rss', 'rss_channel_webmaster');
           // rss channel generator (only to module, god_mode)
    $Core->TTlI1ll($vMod, 'rss_channel_generator', 'ext_rss', 'rss_channel_generator');
           // rss item title (only to module)
    $vMod->SetOption("rss_item_title",                "rss_header");
           // rss item description (only to module) = field from news
    $vMod->SetOption("rss_item_description",          "rss_announce");
           // rss item enclosure (only to module) = field from news
    $vMod->SetOption("rss_item_enclosure",            "rss_small_image");
           // rss item guid (only to module) = field from news
    $vMod->SetOption("rss_item_guid",                 "none");
           // rss item guid (only to module) = field from news
    $vMod->SetOption("rss_item_pubdate",              "rss_c_date");
            // rss channel (only to module, list of files in "_img/")
    $Core->TTlI1ll($vMod, 'rss_channel_image', 'ext_rss', 'rss_channel_image');
            // rss channel (only to module, list of files in "_img/")
    $Core->TTlI1ll($vMod, 'rss_channel_style', 'ext_rss', 'rss_channel_style');
    //-- end RSS

            // Sort fields for some body types:
            // Array(
            //        "{body_type1};..;{body_typeN}"=>Array({field1}, ...{fieldN}),
            //        ...
            //        "{body_type(N+1)};..;{body_type(N+M)}"=>Array({field1}, ...{fieldN})
            //      )
            // Currently available body types: body_items, body_cats.
            // Currently available fileds for body_items: "header", "date"
            // Currently available fileds for body_cats: "name", "position"
    $vMod->SetOption("sort_pages_setup",  Array(
            "body_items;body_urgent_items"=>Array("header", "date"),
            "body_cats;body_urgent_cats"=>Array("name", "position")
    ));
            // Adv place
            // Adv place
    $vMod->SetOption("adv_place_list",  -1);
    $vMod->SetOption("adv_place_details",  -1);
    $vMod->SetOption("adv_place_sb",  -1);
            // Show advertisement statistics counter in admin's list table
    $vMod->SetOption("show_adv_stat_columns",    false);
            // Show advertisement place name in admin's list table
    $vMod->SetOption("show_adv_place_columns",    false);

    $vMod->SetOption("stop_arg_names", array("catid"=>"##modId##_cat", "id"=>"##modId##"));
    $vMod->SetOption("html_title_template",    "##object_name## - ##cat_name## - ##current_page_name## | ##site_title##");
    $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
            // Displayed fields' properties (used for audit module ONLY)
    $vMod->SetOption("audit_displayed_fields", Array("field_date"=>"visible", "field_author"=>"visible", "field_source"=>"visible", "field_picture"=>"visible", "field_popup_picture"=>"visible", "field_small_picture"=>"visible", "field_body"=>"visible", "field_html_title"=>"hidden"));
            // Array of required fields (used for audit module ONLY)
    $vMod->SetOption("audit_required_fields",  Array());
            // Audit changes made in admin interface
    $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
            // Send notification on user's item changing
    $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
            // Audit action handling rules
    ###        $Core->SetOptionInherited($vMod, 'audit_actions_handling', 'srv_audit', 'audit_actions_handling');
    $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
            // Additional template file for spec block
    $vMod->SetOption("spec_block_template",    "");
            // Additional template file for spec block
    $vMod->SetOption("spec_id_pages",          Array(-1));
    $vMod->SetOption("spec_id_pages",          Array(-1));
    $vMod->SetOption('spec_cat_id_pages', array(-1));
    $vMod->SetOption('mod_id_pages', array(-2, 0));
    $vMod->SetOption('mod_cat_id_pages', array(-2, 0));
            // Set pages view in pager (numbers or bounds)
    $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');
            // Diplay or not on front module items having date in the future
    $Core->TTlI1ll($vMod, 'hide_future_items', 'common_settings', 'hide_future_items');
            // Force expire time (strtotime format), "" - auto
    $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');
            // Small block view mode "usual" or "calendar"
    $vMod->SetOption("small_view_mode", "usual");
            // number cols in body_filtered mode
    $vMod->SetOption("body_filtered_cols", 1);
            // number of page items in body_filtered mode
    $vMod->SetOption("body_filtered_page_size", 10);
    $vMod->SetOption("filter_pages_setup",  Array(
        "body_filtered"=>Array("date_from", "date_to"))
    );
            // 404 header for not found pages
    $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
    // Disable search engine indexing for following cases
    $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
    // Add date-prefix to URL
    $vMod->SetOption("add_date_prefix", false);
}

// } [ami_multifeeds5|articles]
// [ami_multifeeds5|articles|cat] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // ARTICLES CATEGORIES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
            // Suport multi pages
            // Array with available pictures
###                $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
    $vMod->SetOption("item_pictures",           Array("picture", "popup_picture", "small_picture"));
            // Type of picture, which will be shown in admin item's list:
            // "none", "picture", "popup_picture", "small_picture"
    $Core->TTlI1ll($vMod, 'col_picture_type', 'ext_images', 'col_picture_type');
            // Picture generator options
###                $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
    $vMod->SetOption("generate_pictures",   Array("picture", "popup_picture", "small_picture"));
    $Core->TTlI1ll($vMod, 'prior_source_picture', 'ext_images', 'prior_source_picture');
    $Core->TTlI1ll($vMod, 'picture_maxwidth', 'ext_images', 'picture_maxwidth');
    $Core->TTlI1ll($vMod, 'picture_maxheight', 'ext_images', 'picture_maxheight');
    $Core->TTlI1ll($vMod, 'popup_picture_maxwidth', 'ext_images', 'popup_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'popup_picture_maxheight', 'ext_images', 'popup_picture_maxheight');
    $Core->TTlI1ll($vMod, 'small_picture_maxwidth', 'ext_images', 'small_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'small_picture_maxheight', 'ext_images', 'small_picture_maxheight');
    $Core->TTlI1ll($vMod, 'generate_bigger_image', 'ext_images', 'generate_bigger_image');
            // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
    $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
            // Default category: "all", "none", "NN" - id of category
    //$vMod->SetOption("default_category",        "all");
            // Module extensions 'ext_reindex', 'ext_rating'
    $vMod->SetOption("extensions", array('ext_reindex'));
            // Count of categories per page
    $vMod->SetOption("page_size",               10);
            // Sort field of categories "name"
    $vMod->SetOption("page_sort_col",           "name");
            // Sort dimension of categories "asc", "desc"
    $vMod->SetOption("page_sort_dim",           "asc");
            // Sort field of categories "name"
    $vMod->SetOption("front_page_sort_col",     "name");
            // Sort dimension of categories "asc", "desc"
    $vMod->SetOption("front_page_sort_dim",     "asc");
            // Count of categories' columns per page
    $vMod->SetOption("cols",                    2);
            // Show empty categories
    $vMod->SetOption("show_empty_cats",         false);
            // Fill empty description/body with announce on details page
    $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description', true, false);
            // Show urgent elements at pages
//                $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
    $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

            // Show advertisement statistics counter in admin's list table
    $vMod->SetOption("show_adv_stat_columns",    false);
            // Show advertisement place name in admin's list table
    $vMod->SetOption("show_adv_place_columns",    false);

    $vMod->SetOption("average_cat_rating", true);
    $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
    $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');

    /*        // Displayed fields' properties (used for audit module ONLY)
    $vMod->SetOption("audit_displayed_fields", Array("field_cdate"=>"visible", "field_mdate"=>"visible", "field_name"=>"visible", "field_announce"=>"visible", "field_body"=>"visible", "field_filename"=>"visible"));
            // Array of required fields (used for audit module ONLY)
    $vMod->SetOption("audit_required_fields",  Array());*/
            // Audit changes made in admin interface
    $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
            // Send notification on user's item changing
    $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
            // Audit action handling rules
    $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
            // 404 header for not found pages
    $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
}

// } [ami_multifeeds5|articles|cat]
// [ami_multifeeds5|stickers] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // STICKERS module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);

    $vMod->SetOption("item_pictures", Array("picture", "popup_picture", "small_picture"));
    // Type of picture, which will be shown in admin item's list:
    // "none", "picture", "popup_picture", "small_picture"
    $Core->TTlI1ll($vMod, 'col_picture_type', 'ext_images', 'col_picture_type');
    // Picture generator options
    $vMod->SetOption("generate_pictures", Array("picture", "popup_picture", "small_picture"));
    $Core->TTlI1ll($vMod, 'prior_source_picture', 'ext_images', 'prior_source_picture');
    $Core->TTlI1ll($vMod, 'picture_maxwidth', 'ext_images', 'picture_maxwidth');
    $Core->TTlI1ll($vMod, 'picture_maxheight', 'ext_images', 'picture_maxheight');
    $Core->TTlI1ll($vMod, 'popup_picture_maxwidth', 'ext_images', 'popup_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'popup_picture_maxheight', 'ext_images', 'popup_picture_maxheight');
    $Core->TTlI1ll($vMod, 'small_picture_maxwidth', 'ext_images', 'small_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'small_picture_maxheight', 'ext_images', 'small_picture_maxheight');
    $Core->TTlI1ll($vMod, 'generate_bigger_image', 'ext_images', 'generate_bigger_image');

    //Use categories
    $vMod->SetOption("use_categories", true);
    // Count of articles per page
    $vMod->SetOption("page_size", 10);
    // Sort field of articles "date", "header"
    $vMod->SetOption("page_sort_col", "id");
    // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("page_sort_dim", "desc");
    // Sort field of articles "date", "header"

    $vMod->SetOption("search_field_cat", array(-1));
    $vMod->SetOption("search_field_item", array(-1));

    // Sort field of articles "date", "header"
    $vMod->SetOption("small_items_sort_col", "date");
    // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("small_items_sort_dim", "desc");
    // Currently available "ext_discussion", "ext_tags"
    $vMod->SetOption("extensions", array());

    $vMod->SetOption("small_number_items", 4);
    $vMod->SetOption("body_small_cols", 1);

    // Additional template file for spec block
    $vMod->SetOption("spec_block_template", "");
    // Force expire time (strtotime format), "" - auto
    $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force', true, '1 hour');
    // Outputs full announce in small mode
    $vMod->SetOption("announce_mode_full", true);
    $vMod->SetOption("announce_small_length", 120);
    $vMod->SetOption("header_small_length", 120);
}

// } [ami_multifeeds5|stickers]
// [ami_multifeeds5|stickers|cat] {

$modName = "##modId##";
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // STICKERS CATEGORIES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    // Sort field of categories "name"
    $vMod->SetOption("page_sort_col", "id");
    // Sort dimension of categories "asc", "desc"
    $vMod->SetOption("page_sort_dim", "desc");
    // Sort field of categories "name"
    $vMod->SetOption("show_empty_cats", false);
}

// } [ami_multifeeds5|stickers|cat]
// [ami_multifeeds5|news] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // NEWS module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    $isCoreV5 = $oDeclarator->getAttr($modName, 'core_v5', FALSE);
    $vMod->SetOption('page_size', $Core->GetOption('default_page_size'));
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption('front_page_sort_dim', 'desc');
    $vMod->SetOption('page_sort_dim_small', 'desc');
    $vMod->SetOption('cols', 1);

    $vMod->SetOption('use_categories', FALSE);
    if($vMod->GetOption('use_categories')){
        $vMod->SetOption('stop_arg_names', $Core->GetModProperty('##modId##_cat', 'stop_arg_names'));
    }else{
        $vMod->SetOption("stop_arg_names", $Core->GetModProperty('##modId##', 'stop_arg_names'));
    }

    $vMod->SetOption("subitems_total_items_limit", 30);
    $vMod->SetOption("spec_total_items_limit", 30);

    $vMod->SetOption('body_cats_cols', 1);
    $vMod->SetOption('multicat', FALSE);
    $vMod->SetOption('multicat_in_body_details', FALSE);
    $vMod->SetOption('show_last_items', 10);

                // Suport multi pages
        $vMod->SetOption("multi_page",              true);
                // Sort field of news "date", "header", "position", "votes_rate"
        $vMod->SetOption("front_page_sort_col",        "date");
                // Sort field of news in specblock "date", "header", "position", "votes_rate"
        $vMod->SetOption("page_sort_col_small", "date");
                // Count of news columns on spec block
        $vMod->SetOption("body_small_cols", 1);
                // Array with available pictures
###        $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
        $vMod->SetOption("item_pictures",           Array("picture", "popup_picture", "small_picture"));
                // Type of picture, which will be shown in admin item's list:
                // "none", "picture", "popup_picture", "small_picture"
        $Core->TTlI1ll($vMod, 'col_picture_type', 'ext_images', 'col_picture_type');
                // Picture generator options
###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
        $vMod->SetOption("generate_pictures",   Array("picture", "popup_picture", "small_picture"));
        $Core->TTlI1ll($vMod, 'prior_source_picture', 'ext_images', 'prior_source_picture');
        $Core->TTlI1ll($vMod, 'picture_maxwidth', 'ext_images', 'picture_maxwidth');
        $Core->TTlI1ll($vMod, 'picture_maxheight', 'ext_images', 'picture_maxheight');
        $Core->TTlI1ll($vMod, 'popup_picture_maxwidth', 'ext_images', 'popup_picture_maxwidth');
        $Core->TTlI1ll($vMod, 'popup_picture_maxheight', 'ext_images', 'popup_picture_maxheight');
        $Core->TTlI1ll($vMod, 'small_picture_maxwidth', 'ext_images', 'small_picture_maxwidth');
        $Core->TTlI1ll($vMod, 'small_picture_maxheight', 'ext_images', 'small_picture_maxheight');
        $Core->TTlI1ll($vMod, 'generate_bigger_image', 'ext_images', 'generate_bigger_image');
                // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                // Outputs full announce in small mode
        $vMod->SetOption("announce_mode_full",      false);
                // max length of announce string on small block. [1..250]
        $vMod->SetOption("announce_small_length",      250);
                // max length of header string on small block. [1..100]
        $vMod->SetOption("header_small_length",        200);
                // type of archiving method: "manual", "date"
        $vMod->SetOption("archive_type",               "manual");
                // all $..._ARCHIVE_PERIOD are strings containing an english date format
                // Valid only when archive type is date
                // Examples:
                // "10 September 2000"
                // "-1 day"
                // "-1 week"
                // "-12 month"
        $vMod->SetOption("archive_period",             "-12 month");
                // type of items to show: "all", "active", "archive"
        $vMod->SetOption("show_type",                  "all");
                // Currently available "ext_twist_prevention", "ext_discussion", "ext_rss", "ext_tags")
        $vMod->SetOption('extensions', array('ext_twist_prevention', 'ext_rss', 'ext_reindex'));
                // Fill empty description/body with announce on details page
        $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description');
                // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));
                // Set pages view in pager (numbers or bounds)
        $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');
                // Diplay or not on front module items having date in the future
        $Core->TTlI1ll($vMod, 'hide_future_items', 'common_settings', 'hide_future_items');

        // RSS extension NEWS module constants
               // number of RSS channel elements
        $Core->TTlI1ll($vMod, 'rss_num_elements', 'ext_rss', 'rss_num_elements');
               // display on page
        $Core->TTlI1ll($vMod, 'rss_display_page', 'ext_rss', 'rss_display_page');
               // type of display image on page
        $Core->TTlI1ll($vMod, 'rss_display_image', 'ext_rss', 'rss_display_image');
               // rss channel title (only to module) = field from news
        $Core->TTlI1ll($vMod, 'rss_channel_title', 'core_module', 'company_name');
               // rss channel description (only to module)
        $vMod->SetOption("rss_channel_description",       "");
               // rss channel webmaster (only to module)
        $Core->TTlI1ll($vMod, 'rss_channel_webmaster', 'ext_rss', 'rss_channel_webmaster');
               // rss channel generator (only to module, god_mode)
        $Core->TTlI1ll($vMod, 'rss_channel_generator', 'ext_rss', 'rss_channel_generator');
               // rss item title (only to module)
        $vMod->SetOption("rss_item_title",                "rss_header");
               // rss item description (only to module) = field
        $vMod->SetOption("rss_item_description",          "rss_announce");
               // rss item yandex fulltext (only to module) = field
        $vMod->SetOption("rss_item_fulltext",             "none");
               // rss item enclosure (only to module) = field from news
        $vMod->SetOption("rss_item_enclosure",            "rss_small_image");
               // rss item guid (only to module) = field
        $vMod->SetOption("rss_item_guid",                 "none");
               // rss item guid (only to module) = field
        $vMod->SetOption("rss_item_pubdate",              "rss_c_date");

                // rss channel (only to module, list of files in "_img/")
        $Core->TTlI1ll($vMod, 'rss_channel_image', 'ext_rss', 'rss_channel_image');
                // rss channel (only to module, list of files in "_img/")
        $Core->TTlI1ll($vMod, 'rss_channel_style', 'ext_rss', 'rss_channel_style');
        //-- end RSS
                // Force expire time (strtotime format), "" - auto
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');

        $vMod->SetOption("filter_pages_setup",  Array(
            "body_filtered"=>Array("date_from", "date_to"))
        );


//// Obsolete 0302 version options

        // {{{ twist prevention extension options

                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');

        // }}}
        // {{{ discussion extension

        if($isCoreV5){
            // Show news body, when forum
            $Core->TTlI1ll($vMod, 'show_body_when_forum', 'ext_discussion', 'show_body_when_forum');
        }
                // Show forum_count_replies, true, false
        $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
                // Show forum_count_topics, true, false
//        $Core->SetOptionInherited($vMod, 'show_forum_count_topics', 'ext_discussion', 'show_forum_count_topics');
                // Show forum links in news list, true, false
        $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
                // Show forum links in small news block, true, false
        $Core->TTlI1ll($vMod, 'show_forum_link_in_small', 'ext_discussion', 'show_forum_link_in_small');
                // Show forum at element details page right away
        $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details');
                // Display element numbers in messages list
        $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
                // Discussion admin notification
        $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
                // Webmaster email
        $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
                // Use tree view
        $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');
                // Anonymous user email
//        $Core->SetOptionInherited($vMod, 'forum_anonymous_user_email', 'ext_discussion', 'forum_anonymous_user_email');
                // Are attaches allowed
//        $Core->SetOptionInherited($vMod, 'forum_attaches_allowed', 'ext_discussion', 'forum_attaches_allowed');
                // False - one level tree messages, true - normal tree
//        $Core->SetOptionInherited($vMod, 'forum_only_one_level', 'ext_discussion', 'forum_only_one_level');
                // Set type of pager, "items", "topics"
//        $Core->SetOptionInherited($vMod, 'forum_pager_type', ext_discussion', 'forum_pager_type');
                // Count of forum items per page
//        $Core->SetOptionInherited($vMod, 'forum_page_size', 'ext_discussion', 'forum_page_size');
                // Only one topic per item
//        $Core->SetOptionInherited($vMod, 'forum_multi_topics', 'ext_discussion', 'forum_multi_topics');

        // }}}

//// End of obsolete 0302 ver options

                // Show body browse
        $vMod->SetOption("show_body_browse", false);
                // Count of pictures per page for browse list
        $vMod->SetOption("body_browse_page_size",      5);
                // Browse active item position
        $vMod->SetOption("browse_active_item_position",3);
                // Count of pictures columns on browse mode
        $vMod->SetOption("body_browse_cols",           5);
                // Adv place initial parameters. Should not be any but -1 because this is callback parameters
        $vMod->SetOption("adv_place_list",  -1);
        $vMod->SetOption("adv_place_details",  -1);
        $vMod->SetOption("adv_place_sb",  -1);
                // Show advertisement statistics counter in admin's list table
        $vMod->SetOption("show_adv_stat_columns",    false);
                // Show advertisement place name in admin's list table
        $vMod->SetOption("show_adv_place_columns",    false);

        $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
                // Displayed fields' properties (used for audit module ONLY)
        $vMod->SetOption("audit_displayed_fields", Array("field_date"=>"visible", "field_body"=>"visible", "field_picture"=>"visible", "field_popup_picture"=>"visible", "field_small_picture"=>"visible", "field_html_title"=>"hidden"));
                // Array of required fields (used for audit module ONLY)
        $vMod->SetOption("audit_required_fields",  Array());
                // Audit changes made in admin interface
        $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
                // Send notification on user's item changing
        $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
                // Audit action handling rules
###        $Core->SetOptionInherited($vMod, 'audit_actions_handling', 'srv_audit', 'audit_actions_handling');
        $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
                // Additional template file for spec block
        $vMod->SetOption("spec_block_template",    "");
        $vMod->SetOption("spec_id_pages",          Array(-1));
        $vMod->SetOption('spec_cat_id_pages', array(-1));
        $vMod->SetOption('mod_id_pages', array(-2, 0));
        $vMod->SetOption('mod_cat_id_pages', array(-2, 0));
        if($isCoreV5){
            // Small block view mode "usual" or "calendar"
            $vMod->SetOption("small_view_mode", "usual");
        }else{
            $vMod->SetOption('small_number_items', 4);
            $vMod->SetOption('small_grp_by_cat', FALSE);
        }

        $vMod->SetOption('page_size_small', 3);
                // number cols in body_filtered mode
        $vMod->SetOption("body_filtered_cols", 1);
                // number of page items in body_filtered mode
        $vMod->SetOption("body_filtered_page_size", 10);
                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
        // Disable search engine indexing for following cases
        $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
        // Add date-prefix to URL
        $vMod->SetOption("add_date_prefix", false);

    // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
    $vMod->SetOption("show_subitems",              -1);
    // The number of sub items, after which is inserted splitter, 0 - no splitter
    $vMod->SetOption("subitems_splitter_period",    0);
    // Count of subitems' columns per page
    $vMod->SetOption("subitems_cols",               1);
    // #CMS-11147
    $vMod->SetOption('subitems_grp_by_cat', TRUE);
    // Sort field of articles "date", "header"
    $vMod->SetOption("front_subitem_sort_col",     "date");
    // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("front_subitem_sort_dim",     "desc");
}

// } [ami_multifeeds5|news]
// [ami_multifeeds5|blog] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // blog module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
    $isCoreV5 = $oDeclarator->getAttr($modName, 'core_v5', FALSE);
    $vMod->SetOption('page_size', $Core->GetOption('default_page_size'));
    $vMod->SetOption('page_sort_col', 'id');
    $vMod->SetOption('page_sort_dim', 'desc');
    $vMod->SetOption('front_page_sort_dim', 'desc');
    $vMod->SetOption('page_sort_dim_small', 'desc');
    $vMod->SetOption('cols', 1);

    $vMod->SetOption('use_categories', FALSE);
    if($vMod->GetOption('use_categories')){
        $vMod->SetOption('stop_arg_names', $Core->GetModProperty('##modId##_cat', 'stop_arg_names'));
    }else{
        $vMod->SetOption("stop_arg_names", $Core->GetModProperty('##modId##', 'stop_arg_names'));
    }

    $vMod->SetOption("subitems_total_items_limit", 30);
    $vMod->SetOption("spec_total_items_limit", 30);

    $vMod->SetOption('body_cats_cols', 1);
    $vMod->SetOption('multicat', FALSE);
    $vMod->SetOption('multicat_in_body_details', FALSE);
    $vMod->SetOption('show_last_items', 10);

    // Suport multi pages
    $vMod->SetOption("multi_page",              true);
    // Sort field of blog "date", "header", "position", "votes_rate"
    $vMod->SetOption("front_page_sort_col",        "date");
    // Sort field of blog in specblock "date", "header", "position", "votes_rate"
    $vMod->SetOption("page_sort_col_small", "date");
    // Count of blog columns on spec block
    $vMod->SetOption("body_small_cols", 1);
    // Array with available pictures
###        $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
    $vMod->SetOption("item_pictures",           Array("picture", "popup_picture", "small_picture"));
    // Type of picture, which will be shown in admin item's list:
    // "none", "picture", "popup_picture", "small_picture"
    $Core->TTlI1ll($vMod, 'col_picture_type', 'ext_images', 'col_picture_type');
    // Picture generator options
###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
    $vMod->SetOption("generate_pictures",   Array("picture", "popup_picture", "small_picture"));
    $Core->TTlI1ll($vMod, 'prior_source_picture', 'ext_images', 'prior_source_picture');
    $Core->TTlI1ll($vMod, 'picture_maxwidth', 'ext_images', 'picture_maxwidth');
    $Core->TTlI1ll($vMod, 'picture_maxheight', 'ext_images', 'picture_maxheight');
    $Core->TTlI1ll($vMod, 'popup_picture_maxwidth', 'ext_images', 'popup_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'popup_picture_maxheight', 'ext_images', 'popup_picture_maxheight');
    $Core->TTlI1ll($vMod, 'small_picture_maxwidth', 'ext_images', 'small_picture_maxwidth');
    $Core->TTlI1ll($vMod, 'small_picture_maxheight', 'ext_images', 'small_picture_maxheight');
    $Core->TTlI1ll($vMod, 'generate_bigger_image', 'ext_images', 'generate_bigger_image');
    // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
    $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
    // Outputs full announce in small mode
    $vMod->SetOption("announce_mode_full",      false);
    // max length of announce string on small block. [1..250]
    $vMod->SetOption("announce_small_length",      120);
    // max length of header string on small block. [1..100]
    $vMod->SetOption("header_small_length",        100);
    // type of archiving method: "manual", "date"
    $vMod->SetOption("archive_type",               "manual");
    // all $..._ARCHIVE_PERIOD are strings containing an english date format
    // Valid only when archive type is date
    // Examples:
    // "10 September 2000"
    // "-1 day"
    // "-1 week"
    // "-12 month"
    $vMod->SetOption("archive_period",             "-12 month");
    // type of items to show: "all", "active", "archive"
    $vMod->SetOption("show_type",                  "all");
    // Currently available "ext_twist_prevention", "ext_discussion", "ext_rss", "ext_tags")
    $vMod->SetOption('extensions', array('ext_twist_prevention', 'ext_rss', 'ext_reindex'));
    // Fill empty description/body with announce on details page
    $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description', false, true);
    // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
    $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));
    // Set pages view in pager (numbers or bounds)
    $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');
    // Diplay or not on front module items having date in the future
    $Core->TTlI1ll($vMod, 'hide_future_items', 'common_settings', 'hide_future_items');

    // RSS extension blog module constants
    // number of RSS channel elements
    $Core->TTlI1ll($vMod, 'rss_num_elements', 'ext_rss', 'rss_num_elements');
    // display on page
    $Core->TTlI1ll($vMod, 'rss_display_page', 'ext_rss', 'rss_display_page');
    // type of display image on page
    $Core->TTlI1ll($vMod, 'rss_display_image', 'ext_rss', 'rss_display_image');
    // rss channel title (only to module) = field from blog
    $Core->TTlI1ll($vMod, 'rss_channel_title', 'core_module', 'company_name');
    // rss channel description (only to module)
    $vMod->SetOption("rss_channel_description",       "");
    // rss channel webmaster (only to module)
    $Core->TTlI1ll($vMod, 'rss_channel_webmaster', 'ext_rss', 'rss_channel_webmaster');
    // rss channel generator (only to module, god_mode)
    $Core->TTlI1ll($vMod, 'rss_channel_generator', 'ext_rss', 'rss_channel_generator');
    // rss item title (only to module)
    $vMod->SetOption("rss_item_title",                "rss_header");
    // rss item description (only to module) = field
    $vMod->SetOption("rss_item_description",          "rss_announce");
    // rss item yandex fulltext (only to module) = field
    $vMod->SetOption("rss_item_fulltext",             "none");
    // rss item enclosure (only to module) = field from blog
    $vMod->SetOption("rss_item_enclosure",            "rss_small_image");
    // rss item guid (only to module) = field
    $vMod->SetOption("rss_item_guid",                 "none");
    // rss item guid (only to module) = field
    $vMod->SetOption("rss_item_pubdate",              "rss_c_date");

    // rss channel (only to module, list of files in "_img/")
    $Core->TTlI1ll($vMod, 'rss_channel_image', 'ext_rss', 'rss_channel_image');
    // rss channel (only to module, list of files in "_img/")
    $Core->TTlI1ll($vMod, 'rss_channel_style', 'ext_rss', 'rss_channel_style');
    //-- end RSS
    // Force expire time (strtotime format), "" - auto
    $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');

    $vMod->SetOption("filter_pages_setup",  Array(
            "body_filtered"=>Array("date_from", "date_to"))
    );


//// Obsolete 0302 version options

    // {{{ twist prevention extension options

    // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
    $vMod->SetOption('action_period', '5 second');
    // show captcha (image to prevent from robots actions)
    $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
    // check captcha without page reloading
    $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
    // add "_twist" postfix to module action in case of twist detection
    $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
    // add status message in case of twist detection
    $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');

    // }}}
    // {{{ discussion extension

    if($isCoreV5){
        // Show blog body, when forum
        $Core->TTlI1ll($vMod, 'show_body_when_forum', 'ext_discussion', 'show_body_when_forum');
    }
    // Show forum_count_replies, true, false
    $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
    // Show forum_count_topics, true, false
//        $Core->SetOptionInherited($vMod, 'show_forum_count_topics', 'ext_discussion', 'show_forum_count_topics');
    // Show forum links in blog list, true, false
    $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
    // Show forum links in small blog block, true, false
    $Core->TTlI1ll($vMod, 'show_forum_link_in_small', 'ext_discussion', 'show_forum_link_in_small');
    // Show forum at element details page right away
    $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details');
    // Display element numbers in messages list
    $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
    // Discussion admin notification
    $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
    // Webmaster email
    $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
    // Use tree view
    $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');
    // Anonymous user email
//        $Core->SetOptionInherited($vMod, 'forum_anonymous_user_email', 'ext_discussion', 'forum_anonymous_user_email');
    // Are attaches allowed
//        $Core->SetOptionInherited($vMod, 'forum_attaches_allowed', 'ext_discussion', 'forum_attaches_allowed');
    // False - one level tree messages, true - normal tree
//        $Core->SetOptionInherited($vMod, 'forum_only_one_level', 'ext_discussion', 'forum_only_one_level');
    // Set type of pager, "items", "topics"
//        $Core->SetOptionInherited($vMod, 'forum_pager_type', ext_discussion', 'forum_pager_type');
    // Count of forum items per page
//        $Core->SetOptionInherited($vMod, 'forum_page_size', 'ext_discussion', 'forum_page_size');
    // Only one topic per item
//        $Core->SetOptionInherited($vMod, 'forum_multi_topics', 'ext_discussion', 'forum_multi_topics');

    // }}}

//// End of obsolete 0302 ver options

    // Show body browse
    $vMod->SetOption("show_body_browse", false);
    // Count of pictures per page for browse list
    $vMod->SetOption("body_browse_page_size",      3);
    // Browse active item position
    $vMod->SetOption("browse_active_item_position",2);
    // Count of pictures columns on browse mode
    $vMod->SetOption("body_browse_cols",           3);
    // Adv place initial parameters. Should not be any but -1 because this is callback parameters
    $vMod->SetOption("adv_place_list",  -1);
    $vMod->SetOption("adv_place_details",  -1);
    $vMod->SetOption("adv_place_sb",  -1);
    // Show advertisement statistics counter in admin's list table
    $vMod->SetOption("show_adv_stat_columns",    false);
    // Show advertisement place name in admin's list table
    $vMod->SetOption("show_adv_place_columns",    false);

    $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
    $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
    // Displayed fields' properties (used for audit module ONLY)
    $vMod->SetOption("audit_displayed_fields", Array("field_date"=>"visible", "field_body"=>"visible", "field_picture"=>"visible", "field_popup_picture"=>"visible", "field_small_picture"=>"visible", "field_html_title"=>"hidden"));
    // Array of required fields (used for audit module ONLY)
    $vMod->SetOption("audit_required_fields",  Array());
    // Audit changes made in admin interface
    $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
    // Send notification on user's item changing
    $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
    // Audit action handling rules
###        $Core->SetOptionInherited($vMod, 'audit_actions_handling', 'srv_audit', 'audit_actions_handling');
    $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
    // Additional template file for spec block
    $vMod->SetOption("spec_block_template",    "");
    $vMod->SetOption("spec_id_pages",          Array(-1));
    $vMod->SetOption('spec_cat_id_pages', array(-1));
    $vMod->SetOption('mod_id_pages', array(-2, 0));
    $vMod->SetOption('mod_cat_id_pages', array(-2, 0));
    if($isCoreV5){
        // Small block view mode "usual" or "calendar"
        $vMod->SetOption("small_view_mode", "usual");
    }else{
        $vMod->SetOption('small_number_items', 4);
        $vMod->SetOption('small_grp_by_cat', FALSE);
    }

    $vMod->SetOption('page_size_small', 3);
    // number cols in body_filtered mode
    $vMod->SetOption("body_filtered_cols", 1);
    // number of page items in body_filtered mode
    $vMod->SetOption("body_filtered_page_size", 10);
    // 404 header for not found pages
    $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
    // Disable search engine indexing for following cases
    $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
    // Add date-prefix to URL
    $vMod->SetOption("add_date_prefix", false);

    // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
    $vMod->SetOption("show_subitems",              -1);
    // The number of sub items, after which is inserted splitter, 0 - no splitter
    $vMod->SetOption("subitems_splitter_period",    0);
    // Count of subitems' columns per page
    $vMod->SetOption("subitems_cols",               1);
    // #CMS-11147
    $vMod->SetOption('subitems_grp_by_cat', TRUE);
    // Sort field of articles "date", "header"
    $vMod->SetOption("front_subitem_sort_col",     "date");
    // Sort dimension of articles "asc", "desc"
    $vMod->SetOption("front_subitem_sort_dim",     "desc");
}

// } [ami_multifeeds5|blog]
// [ami_multifeeds5|faq] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // FAQ module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                // Suport multi pages
        $vMod->SetOption("multi_page",              true);

                //Use categories
        $vMod->SetOption('use_categories', true);
        if($vMod->GetOption('use_categories')){
            $vMod->SetOption('stop_arg_names', $Core->GetModProperty('##modId##_cat', 'stop_arg_names'));
        }else{
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty('##modId##', 'stop_arg_names'));
        }
        $vMod->SetOption("page_sort_col", "answered");
        $vMod->SetOption("page_sort_dim", "asc");
        $vMod->SetOption("front_page_sort_col", "date");
        $vMod->SetOption("front_page_sort_dim", "desc");

        $vMod->SetOption("multicat",                   false);
                // Show list of categories inside item details
        $vMod->SetOption("multicat_in_body_details",   false);
        $vMod->SetOption("show_last_items",            10);

                // confirm email
        $Core->TTlI1ll($vMod, 'confirm_from_email', 'core_module', 'company_email');
                // email address that will receive questions from the site
        $Core->TTlI1ll($vMod, 'faq_email', 'core_module', 'company_email');
        $Core->TTlI1ll($vMod, 'company_robot_email', 'core_module', 'company_robot_email');
        $Core->TTlI1ll($vMod, 'company_name', 'core_module', 'company_name');

        $vMod->SetOption("page_size",                  10);

                // Count of categories' columns per page
        $vMod->SetOption("body_cats_cols",             1);
                // Count of questions columns on spec block
        $vMod->SetOption("body_small_cols",            1);
                // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
        $vMod->SetOption("show_subitems",              -1);
                // The number of sub items, after which is inserted splitter, 0 - no splitter
        $vMod->SetOption("subitems_splitter_period",    0);
                // Count of subitems' columns per page
        $vMod->SetOption("subitems_cols",               1);
                // Count of items, which will be shown. If category(is) is specified, then count of items from each category.
        $vMod->SetOption("small_number_items",          5);
                // List of categories id, from which the items will be shown
                //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->SetOption("small_category_ids",          0);
                // Number categories, from which the items will be shown.
                // Only when option "small_category_ids" eq. 0.
                // (if 0  and option "small_category_ids" eq. 0, then categories will be not specified)
        $vMod->SetOption("small_number_categories",     0);
                // Sort field of categories "name", "position"
        $vMod->SetOption("small_categories_sort_col",   "name");
                // Sort dimension of categories "asc", "desc"
        $vMod->SetOption("small_categories_sort_dim",   "asc");
                // Sort field of articles "date", "header"
        $vMod->SetOption("small_items_sort_col",        "date");
                // Sort dimension of articles "asc", "desc"
        $vMod->SetOption("small_items_sort_dim",        "desc");
                // Sort field of FAQ "date", "subject"
        $vMod->SetOption("front_subitem_sort_col",     "date");
                // Sort dimension of FAQ "asc", "desc"
        $vMod->SetOption("front_subitem_sort_dim",     "desc");
                // Sort field of FAQ "date", "subject"
        $vMod->SetOption("front_page_sort_col",        "date");
                // Sort dimension of FAQ "asc", "desc"
        $vMod->SetOption("front_page_sort_dim",        "desc");

        $vMod->SetOption("sort_pages_setup",  Array(
                "body_items;body_urgent_items"=>Array("date","subject"),
                "body_cats;body_urgent_cats"=>Array("name", "position")
        ));
        $vMod->SetOption("required_fields", array ("author", "email", "question"));

        // question list layout:
        // "link_to_same_page", "link_to_separate_page", "no_links"
        $vMod->SetOption("question_list_layout",     "link_to_separate_page");

         // Question number type: "arabic", "roman" or "no_numbering"
        $vMod->SetOption("question_number_type", "bullet");

        // FAQ addition by registered users only:
        $vMod->SetOption("faq_add_by_registered_only",     false);

        // default value for the "Send the answer to author"
        $vMod->SetOption("send_answer_to_author",     true);
                // Currently available "ext_twist_prevention")
        $vMod->SetOption("extensions", array("ext_twist_prevention", 'ext_reindex'));
                // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));
        $vMod->SetOption("html_title_template",    "##object_name## - ##cat_name## - ##current_page_name## | ##site_title##");
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
                // Additional template file for spec block
        $vMod->SetOption("spec_block_template",    "");
                // Additional template file for spec block
        $vMod->SetOption("spec_id_pages",          Array(-1));
        $vMod->SetOption('spec_cat_id_pages', array(-1));
        $vMod->SetOption('mod_id_pages', array(-2, 0));
        $vMod->SetOption('mod_cat_id_pages', array(-2, 0));

        // {{{ twist prevention extension options

                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');
                // Force expire time (strtotime format), "" - auto
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');

        // }}}
                // Set pages view in pager (numbers or bounds)
        $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');
               // Diplay or not on front module items having date in the future
        $Core->TTlI1ll($vMod, 'hide_future_items', 'common_settings', 'hide_future_items');
                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
        // Disable search engine indexing for following cases
        $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
}

// } [ami_multifeeds5|faq]
// [ami_multifeeds5|faq|cat] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // FAQ CATEGORIES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);

        $vMod->SetOption("admin_as_submenu_caption", true);
        // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');

        // Default category: "all", "none", "NN" - id of category
        //$vMod->SetOption("default_category",        "all");
                        // Count of categories per page
        $vMod->SetOption("page_size",               10);
                        // Sort field of categories "name", "position"
        $vMod->SetOption("page_sort_col",           "position");
                        // Sort dimension of categories "asc", "desc"
        $vMod->SetOption("page_sort_dim",           "asc");
                        // Sort field of categories "name", "position"
        $vMod->SetOption("front_page_sort_col",     "position");
                        // Sort dimension of categories "asc", "desc"
        $vMod->SetOption("front_page_sort_dim",     "asc");
                        // Count of categories' columns per page
        $vMod->SetOption("cols",                    2);
                        // Show empty categories
        $vMod->SetOption("show_empty_cats",         false);
                // Fill empty description/body with announce on details page
        $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description', true, false);
                // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

         // Category number type: "arabic", "roman", "bullet" or "no_numbering"
        $vMod->SetOption("category_number_type",         "bullet");
        // category (subject) list layout:
        // "link_to_same_page" or "no_links"
        $vMod->SetOption("cat_list_layout",     "link_to_same_page");

        // Show counters of questions in subjects:
        $vMod->SetOption("show_counters",     true);
        $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');

                // Extensions
        $vMod->SetOption("extensions", array('ext_reindex'));
                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
}

// } [ami_multifeeds5|faq|cat]
// [ami_multifeeds5|photoalbum] {
$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // PHOTOALBUM module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);

                // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                //Use categories
        $vMod->SetOption("use_categories",             true);
        if($vMod->GetOption( "use_categories")){
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty("##modId##_cat", "stop_arg_names"));
        } else {
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty("##modId##", "stop_arg_names"));
        }
        $vMod->SetOption("subitems_total_items_limit", 30);
        $vMod->SetOption("spec_total_items_limit", 30);

                // Array with available pictures
###        $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
        $vMod->SetOption("item_pictures",           Array("picture", "popup_picture", "small_picture"));
                // Count of pictures per page
        $vMod->SetOption("page_size",                  12);
                // Sort field of pictures "date", "header"
        $vMod->SetOption("page_sort_col",              "date");
                // Sort dimension of pictures "asc", "desc"
        $vMod->SetOption("page_sort_dim",              "desc");
                // Sort field of pictures "date", "header"
        $vMod->SetOption("front_subitem_sort_col",     "date");
                // Sort dimension of pictures "asc", "desc"
        $vMod->SetOption("front_subitem_sort_dim",     "desc");
                // Sort field of pictures "date", "header"
        $vMod->SetOption("front_page_sort_col",        "position");
                // Sort dimension of pictures "asc", "desc"
        $vMod->SetOption("front_page_sort_dim",        "desc");
                // Suport multi pages
        $vMod->SetOption("multi_page",                 true);
                // Show list of categories inside category
        $vMod->SetOption("multicat",                   false);
                // Show list of categories inside item details
        $vMod->SetOption("multicat_in_body_details",   false);
                // Show N last items, when url parametr "show_last=1" is present
                // If N=0, then working in normal mode
        $vMod->SetOption("show_last_items",            10);

                // Show forum_count_replies, true, false
        $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
                // Show forum_count_topics, true, false
//        $Core->SetOptionInherited($vMod, 'show_forum_count_topics', 'ext_discussion', 'show_forum_count_topics');
                // Show forum links in news list, true, false
        $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
                // Show forum links in small news block, true, false
        $Core->TTlI1ll($vMod, 'show_forum_link_in_small', 'ext_discussion', 'show_forum_link_in_small');
                // Show forum at element details page right away
        $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details', TRUE, TRUE);
                // Display element numbers in messages list
        $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
                // Discussion admin notification
        $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
                // Webmaster email
        $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
                // Use tree view
        $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');
                // Anonymous user email
//        $vMod->SetOption("forum_anonymous_user_email",       "anonymous@localhost.ru");
                // Are attaches allowed
//        $Core->SetOptionInherited($vMod, 'forum_attaches_allowed', 'ext_discussion', 'forum_attaches_allowed');
                // False - one level tree messages, true - normal tree
//        $Core->SetOptionInherited($vMod, 'forum_only_one_level', 'ext_discussion', 'forum_only_one_level');
                // Set type of pager, "items", "topics"
//        $Core->SetOptionInherited($vMod, 'forum_pager_type', 'ext_discussion', 'forum_pager_type');
                // Count of forum items per page
//        $Core->SetOptionInherited($vMod, 'forum_page_size', 'ext_discussion', 'forum_page_size');
                // Only one topic per item
//        $Core->SetOptionInherited($vMod, 'forum_multi_topics', 'ext_discussion', 'forum_multi_topics');

                // Count of categories' columns per page
        $vMod->SetOption("body_cats_cols", 3);
                // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
        $vMod->SetOption("cols", 3);
                // Count of pictures columns on spec block
        $vMod->SetOption("body_small_cols",            1);
                // Show category items, -1 - do not show, 0 - show all items, N - show N items (N > 0)
        $vMod->SetOption("show_subitems",              -1);
                // The number of sub items, after which is inserted splitter, 0 - no splitter
        $vMod->SetOption("subitems_splitter_period",    0);
                // Count of subitems' columns per page
        $vMod->SetOption("subitems_cols",               1);
        $vMod->SetOption('subitems_grp_by_cat', TRUE);
                // Count of items, which will be shown. If category(is) is specified, then count of items from each category.
        $vMod->SetOption("small_number_items",          3);
                // List of categories id, from which the items will be shown
                //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->SetOption("small_category_ids",          0);
        if($oDeclarator->getAttr($modName, 'core_v5')){
            // Number categories, from which the items will be shown.
            // Only when option "small_category_ids" eq. 0.
            // (if 0  and option "small_category_ids" eq. 0, then categories will be not specified)
            $vMod->SetOption('small_number_categories', 0);
        }else{
            $vMod->SetOption('small_grp_by_cat', FALSE);
        }
                // Sort field of categories "name", "position"
        $vMod->SetOption("small_categories_sort_col",   "name");
                // Sort dimension of categories "asc", "desc"
        $vMod->SetOption("small_categories_sort_dim",   "asc");
                // Sort field of pictures "date", "header"
        $vMod->SetOption("small_items_sort_col",        "date");
                // Sort dimension of pictures "asc", "desc"
        $vMod->SetOption("small_items_sort_dim",        "desc");
                // Currently available "ext_discussion"
        $vMod->SetOption('extensions',
            array(
                'ext_images',
                'ext_twist_prevention',
                'ext_reindex',
                'ext_discussion',
                'ext_rating'
            )
        );
                // Fill empty description/body with announce on details page
        $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description');
                // Show urgent elements at pages
//        $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));
                // Diplay or not on front module items having date in the future
        $Core->TTlI1ll($vMod, 'hide_future_items', 'common_settings', 'hide_future_items');

                // Sort fields for some body types:
                // Array(
                //        "{body_type1};..;{body_typeN}"=>Array({field1}, ...{fieldN}),
                //        ...
                //        "{body_type(N+1)};..;{body_type(N+M)}"=>Array({field1}, ...{fieldN})
                //      )
                // Currently available body types: body_items, body_cats.
                // Currently available fileds for body_items: "header", "date"
                // Currently available fileds for body_cats: "name", "position"
        $vMod->SetOption("sort_pages_setup",  Array(
                "body_items;body_urgent_items"=>Array(),
                "body_cats;body_urgent_cats"=>Array()
        ));
                // Type of picture, which will be shown in admin item's list:
                // "none", "picture", "popup_picture", "small_picture"
        $vMod->SetOption("col_picture_type",    "small_picture");
                // Auto-generate pictures options
###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
        $vMod->SetOption("generate_pictures",   Array("picture", "popup_picture", "small_picture"));
        $Core->TTlI1ll($vMod, 'prior_source_picture', 'ext_images', 'prior_source_picture');
        $vMod->SetOption("picture_maxwidth", 400);
        $vMod->SetOption("picture_maxheight", 400);
        $Core->TTlI1ll($vMod, 'popup_picture_maxwidth', 'ext_images', 'popup_picture_maxwidth');
        $Core->TTlI1ll($vMod, 'popup_picture_maxheight', 'ext_images', 'popup_picture_maxheight');
        $Core->TTlI1ll($vMod, 'small_picture_maxwidth', 'ext_images', 'small_picture_maxwidth', TRUE, 275);
        $Core->TTlI1ll($vMod, 'small_picture_maxheight', 'ext_images', 'small_picture_maxheight', TRUE, 275);
        $Core->TTlI1ll($vMod, 'generate_bigger_image', 'ext_images', 'generate_bigger_image');
                // Set static watermark
        $vMod->SetOption("static_watermark", "_mod_files/ce_images/icons/static_watermark.gif");
                // Position, where watermark should be created. Allowed values: "upleft", "upright", "center", "downleft", "downright", "tile", "none"
        $vMod->SetOption("static_watermark_method", "downright");
                // Alpha level of layer image transparency [0-127]
        $vMod->SetOption("static_watermark_alpha", "85");
                // Show body browse
        $vMod->SetOption("show_body_browse", true);
                // Count of pictures per page for browse list
        $vMod->SetOption("body_browse_page_size",      9);
                // Browse active item position
        $vMod->SetOption("browse_active_item_position",5);
                // Count of pictures columns on browse mode
        $vMod->SetOption("body_browse_cols",           3);
        $vMod->SetOption("html_title_template",    "##object_name## - ##cat_name## - ##current_page_name## | ##site_title##");
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
                // Additional template file for spec block
        $vMod->SetOption("spec_block_template",    "");
                // Additional template file for spec block
        $vMod->SetOption("spec_id_pages",          Array(-1));
        $vMod->SetOption('spec_cat_id_pages', array(-1));
        $vMod->SetOption('mod_id_pages', array(-2, 0));
        $vMod->SetOption('mod_cat_id_pages', array(-2, 0));
        // {{{ twist prevention extension options

                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');
                // Force expire time (strtotime format), "" - auto
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');

        /*        // Displayed fields' properties (used for audit module ONLY)
        $vMod->SetOption("audit_displayed_fields", Array("field_cdate"=>"visible", "field_mdate"=>"visible", "field_name"=>"visible", "field_announce"=>"visible", "field_body"=>"visible", "field_filename"=>"visible"));
                // Array of required fields (used for audit module ONLY)
        $vMod->SetOption("audit_required_fields",  Array());*/
                // Audit changes made in admin interface
        $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
                // Send notification on user's item changing
        $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
                // Audit action handling rules
        $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));

        // }}}
                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
        // Disable search engine indexing for following cases
        $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
}

// } [ami_multifeeds5|photoalbum]
// [ami_multifeeds5|photoalbum|cat] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    // PHOTOALBUM CATEGORIES module constants
    $vMod = &$Core->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod, FALSE);
                        // Suport multi pages
                        // Array with available pictures
###                $Core->SetOptionInherited($vMod, 'item_pictures', 'common_settings', 'item_pictures');
                $vMod->SetOption("item_pictures",           Array("picture", "popup_picture", "small_picture"));
                        // Type of picture, which will be shown in admin item's list:
                        // "none", "picture", "popup_picture", "small_picture"
                $vMod->SetOption("col_picture_type",    "small_picture");
                        // "auto" (first time only or for empty fields), "force" (everytime), "none" (never)
                $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
                        // Default category: "all", "none", "NN" - id of category
                //$vMod->SetOption("default_category",        "all");
                        // Count of categories per page
                $vMod->SetOption("page_size",               16);
                        // Sort field of categories "name"
                $vMod->SetOption("page_sort_col",           "name");
                        // Sort dimension of categories "asc", "desc"
                $vMod->SetOption("page_sort_dim",           "asc");
                        // Sort field of categories "name"
                $vMod->SetOption("front_page_sort_col",     "votes_rate");
                        // Sort dimension of categories "asc", "desc"
                $vMod->SetOption("front_page_sort_dim",     "desc");
                        // Count of categories' columns per page
                $vMod->SetOption("cols",                    2);
                        // Show empty categories
                $vMod->SetOption("show_empty_cats",         false);
                       // Extensions: "ext_rating"
                $vMod->SetOption("extensions", array("ext_rating", 'ext_reindex','ext_images') );
                        // Show urgent elements at pages
//                $Core->SetOptionInherited($vMod, 'show_urgent_elements', 'common_settings', 'show_urgent_elements');
                $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));

                      // Set album rating as average of its elements ratings
                $vMod->SetOption("average_cat_rating", true);
                $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
                $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');

                /*        // Displayed fields' properties (used for audit module ONLY)
                $vMod->SetOption("audit_displayed_fields", Array("field_cdate"=>"visible", "field_mdate"=>"visible", "field_name"=>"visible", "field_announce"=>"visible", "field_body"=>"visible", "field_filename"=>"visible"));
                        // Array of required fields (used for audit module ONLY)
                $vMod->SetOption("audit_required_fields",  Array());*/
                        // Audit changes made in admin interface
                $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
                        // Send notification on user's item changing
                $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
                        // Audit action handling rules
                $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));

                // Auto-generate pictures options
###        $Core->SetOptionInherited($vMod, 'generate_pictures', 'common_settings', 'generate_pictures');
        $vMod->SetOption("generate_pictures",   Array("picture", "popup_picture", "small_picture"));
        $Core->TTlI1ll($vMod, 'prior_source_picture', 'ext_images', 'prior_source_picture');
        $vMod->SetOption("picture_maxwidth", 300);
        $vMod->SetOption("picture_maxheight", 300);
        $Core->TTlI1ll($vMod, 'popup_picture_maxwidth', 'ext_images', 'popup_picture_maxwidth');
        $Core->TTlI1ll($vMod, 'popup_picture_maxheight', 'ext_images', 'popup_picture_maxheight');
        $Core->TTlI1ll($vMod, 'small_picture_maxwidth', 'ext_images', 'small_picture_maxwidth', TRUE, 275);
        $Core->TTlI1ll($vMod, 'small_picture_maxheight', 'ext_images', 'small_picture_maxheight', TRUE, 275);
        $Core->TTlI1ll($vMod, 'generate_bigger_image', 'ext_images', 'generate_bigger_image');
                // Set static watermark
        $vMod->SetOption("static_watermark", "_mod_files/ce_images/icons/static_watermark.gif");
                // Position, where watermark should be created. Allowed values: "upleft", "upright", "center", "downleft", "downright", "tile", "none"
        $vMod->SetOption("static_watermark_method", "downright");
                // Alpha level of layer image transparency [0-127]
        $vMod->SetOption("static_watermark_alpha", "85");
                // 404 header for not found pages
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");

        // {{{ twist prevention extension options

                // period of next active action preventing, e. g. adding message to forum (into current module)
###        $Core->SetOptionInherited($vMod, 'action_period', 'srv_twist_prevention', 'action_period');
        $vMod->SetOption('action_period', '5 second');
                // show captcha (image to prevent from robots actions)
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
                // check captcha without page reloading
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
                // add "_twist" postfix to module action in case of twist detection
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
                // add status message in case of twist detection
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');

        // }}}
        // {{{ discussion extension

                // Show forum_count_replies, true, false
        $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
                // Show forum_count_topics, true, false
        $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
                // Show forum at element details page right away
        $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details');
                // Display element numbers in messages list
        $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
                // Discussion admin notification
        $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
                // Webmaster email
        $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
                // Use tree view
        $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');
                // Are attaches allowed
//        $Core->SetOptionInherited($vMod, 'forum_attaches_allowed', 'ext_discussion', 'forum_attaches_allowed');
                // False - one level tree messages, true - normal tree

        // }}}

}

// } [ami_multifeeds5|photoalbum|cat]
// [ami_clean|ami_service] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('engine_version', '0600');
    $vMod->SetOption('module_link', array('owner' => 'services'));
}

// } [ami_clean|ami_service]
// [ami_fake|options_data] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('engine_version', '0600');
    $vMod->SetOption('module_link', array('owner' => 'services'));
    $vMod->SetOption("admin_menu_allowed", false);
}
// } [ami_fake|options_data]

// [ami_clean|active_sessions] {

$modName = '##modId##';
if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
    $vMod = &$Core->GetModule($modName);
    $vMod->SetOption('engine_version', '0600');
    $vMod->SetOption('module_link', array('owner' => 'services'));
    $vMod->SetOption("admin_menu_allowed", true);
}

// } [ami_clean|active_sessions]
