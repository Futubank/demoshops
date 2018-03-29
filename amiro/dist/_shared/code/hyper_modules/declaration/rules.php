<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       417599 xkqwlrylkspyquygsuqmpygqtqmrlgizinnquqngqlzurxuxllzmklqszrmlqplsnxwgpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


// [ami_users|users] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    $vMod->TTlTTIl($vModName."_rules_values.lng");

    $vMod->removeRules(array("page_size_small", "page_sort_col_small", "page_sort_dim_small", "front_page_sort_col", "front_page_sort_dim", "cols"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_col", RLT_ENUM, Array("firstname", "lastname", "username", "company", "email", "date", "active"), "date");
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_dim", RLT_ENUM, array("asc", "desc"), "desc");

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array('ext_modules_custom_fields', RLC_EMPTY))), array(RLC_EMPTY), false, array());
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "form_template", RLT_CHAR, RLC_NONE, "_admin/templates/member.tpl");
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "username_minlen", RLT_UINT, array("min"=>1), 3);
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "password_minlen", RLT_UINT, array("min"=>1), 5);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forgot_custom", RLT_ENUM, array("", "username", "firstname", "lastname", "city", "phone", "icq"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_pass_len", RLT_UINT, array("min"=>1), 10);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_share_warn", RLT_BOOL, RLC_NONE,  true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "confirmation_type", RLT_ENUM_MULTI_STRING, array("none", "email", "admin"), "none");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "used_fields", RLT_ENUM_MULTI_ARRAY,
        array ("firstname", "lastname", "username", "email", 'nickname', "address1", "address2", "zip","country", "state", "city", "phone", "phone_work", "phone_cell", "icq", "company", "companyweb", "password", "ip", "photo", "forum_sign"),
        array ("firstname", "username", "email", 'nickname', "password", "photo")
    );
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "required_fields", RLT_ENUM_MULTI_ARRAY,
        array ("firstname", "lastname", "username", "email", 'nickname', "address1", "address2", "zip", "country", "state", "city", "phone", "phone_work", "phone_cell", "icq", "company", "companyweb", "password", "ip", "photo", "forum_sign"),
        array ("firstname", "lastname", "username", "email", 'nickname', "password")
    );
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "admin_required_fields", RLT_ENUM_MULTI_ARRAY, array("firstname", "lastname", "username", "email", 'nickname', "address1", "address2", "zip","country", "state", "city", "phone", "phone_work", "phone_cell", "icq", "company", "companyweb", "password", "ip", "photo", 'forum_sign'), array("username","email", 'nickname'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "view_fields", RLT_ENUM_MULTI_ARRAY,
        array ('registration_date', "email", 'nickname', "address1", "address2", "zip","country", "state", "city", "phone", "phone_work", "phone_cell", "icq", "company", "companyweb", "ip", "photo", 'forum_sign', 'user_status', 'posts_count', 'rating_data'),
        array ("firstname", "lastname", "username", 'nickname', "photo", "forum_sign")
    );

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'login_field', RLT_ENUM, array('username', 'email', 'phone'), 'email');

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "username_symbols", RLT_CHAR, RLC_NONE, "a-zA-Z0-9_.@\\-");

//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "external_modules_integration", RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "external_integration_modules_list", RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (RLC_EMPTY), false, array (), "api_rules:getExternalModulesListCB");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "autoredirect_forms", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "add", "login"), array(RLC_EMPTY));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'autoredirect_to_modules',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (array ('all')), false, array (), '##modId##_popup:ruleDisplayModulesCB');
                // time given to user to activate his account (in hours)
        // $vMod->SetOption("activate_time", 1);
                // the list of modules dependent from members module
                //   ("sys_groups","subscribe","eshop_user","aff_users","wz_host_users")

    // {{{ twist prevention extension options
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "user_source_app", RLT_BOOL, RLC_NONE, false, false);

    // #CMS-11748: List of modules allowing "edit in place" at front side
    if(!empty($GLOBALS['AMI_ALLOW_EFNSU'])){
        $style = '';
        $lLI11LL = $GLOBALS['Core']->IsInstalled('sys_users');
        if($lLI11LL){
            $style = 'disabled';
        }elseif(!AMI::getOption('core', 'allow_edit_at_front')){
            $style = 'off';
        }
        $vMod->addRule(
            CMS_CoreRules::RLR_ROOT,
            CMS_CoreRules::VIEW_MODE_NOVICE,
            'edit_front_allowed_modules',
            RLT_ENUM_MULTI_ARRAY,
            $style ? array('subtype' => RLC_CALLBACK, 'style_class' => $style) : RLC_CALLBACK,
            array(RLC_EMPTY),
            FALSE,
            array(),
            "##modId##:ruleFrnEditableModulesCB"
        );
        unset($lLI11LL, $style);
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_notification', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "confirm_from_email", RLT_EMAIL, RLC_NONE, $GLOBALS['COMPANY_EMAIL']);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "notify_admin_on_registration", RLT_BOOL, RLC_NONE,  true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "admin_email", RLT_EMAIL, RLC_NONE, $GLOBALS['COMPANY_EMAIL']);
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "notify_on_status_changing", RLT_ENUM_MULTI_STRING, array("active", "not_active", RLC_EMPTY), RLC_EMPTY);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_twist_prevention", RLT_BOOL, RLC_NONE, true, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, true, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

    // }}}

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_specblock", RLT_SPLITTER, RLC_NONE, false, true);

    $lLI11L1 = Array("aff_users", "eshop_user", /*"eshop_user_items", */"eshop_order_history", "eshop_item", "eshop_order", "eshop_cart", 'private_messages', "subscribe", "adv_campaign_types", "adv_advertisers", "user_discounts", "srv_audit_adv_banners", "srv_audit_adv_campaigns", "adv_stats", "adv_modules_stats", "srv_audit_news", "srv_audit_blog", "srv_audit_articles", "srv_audit_articles_cat", "srv_audit_files", "srv_audit_files_cat", "srv_audit_jobs", "srv_audit_jobs_cat", "srv_audit_photoalbum", "srv_audit_photoalbum_cat", "srv_audit_eshop_item");
    if($GLOBALS['Core']->IsInstalled('srv_audit')){
        $lLI11L1[] = 'eshop_user_items';
    }

    $aModules = Array(RLC_EMPTY);

    foreach($lLI11L1 as $modName) {
        if($GLOBALS["Core"]->IsFrontAllowed($modName)) {
          $aModules[] = $modName;
          $tmpMod = &$GLOBALS["Core"]->GetModule($modName);
          $caption = $GLOBALS["adm"]->GetModHeader($tmpMod);
          $lLI11ll = &$tmpMod->TTlIIIT();
          if(is_object($lLI11ll)) {
              $caption = $GLOBALS["adm"]->GetModHeader($lLI11ll)."::".$caption;
          }
          $vMod->setSpecialCaption("show_user_menu_links", $modName, $caption);
        }
    }
    //unset($aModuleCaption);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_user_menu_links", RLT_ENUM_MULTI_ARRAY, $aModules, array("aff_users", /*"eshop_user", "eshop_user_items",*/ "eshop_order_history", 'private_messages', /*"eshop_item", "eshop_order", "eshop_cart",*/ "subscribe", "adv_campaign_types", "adv_advertisers", "srv_audit_adv_banners", "srv_audit_adv_campaigns", "adv_stats", "adv_modules_stats", "srv_audit_news", "srv_audit_blog", "srv_audit_articles", "srv_audit_articles_cat", "srv_audit_files", "srv_audit_files_cat", "srv_audit_jobs", "srv_audit_jobs_cat", "srv_audit_photoalbum", "srv_audit_photoalbum_cat", "srv_audit_eshop_item"));

    $vMod->finishModule();
}

// } [ami_users|users]
// [ami_fake|users] {

// } [ami_fake|users]
// [ami_access_rights|groups] {

// } [ami_access_rights|groups]
// [ami_users|access_rights] {

// } [ami_users|access_rights]
// [ami_access_rights|users_popup] {

// } [ami_access_rights|users_popup]
// [ami_access_rights|groups_popup] {

// } [ami_access_rights|groups_popup]
// [ami_access_rights|modules_popup] {

// } [ami_access_rights|modules_popup]
// [ami_access_rights|departments] {

// } [ami_access_rights|departments]
// [ami_access_rights|groups] {

// } [ami_access_rights|groups]
// [ami_multifeeds|articles] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $useCats = $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories');

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'rule_test', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false,'##modId##:ruleTest', array('r1', 'r2', 'r3'));

    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->removeRules( array("page_size_small", "page_sort_col_small", "page_sort_dim_small") );

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("date_created", "header", "position", 'ext_rate_count', 'ext_rate_rate'), "date_created", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_stat_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_place_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, TRUE);
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_twist_prevention", "ext_discussion", "ext_rating", "ext_audit", "ext_rss", "ce_page_break", 'ext_reindex', "ext_tags", 'ext_relations', 'ext_images', 'ext_modules_custom_fields',  RLC_EMPTY))), array(RLC_EMPTY), false, array());

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array('ext_twist_prevention', 'ext_reindex', 'ext_discussion', 'ext_rating', 'ext_rss'), false, false, '##modId##:ruleExtensionsCB', array('ext_twist_prevention', 'ext_discussion', 'ext_rating', 'ext_audit', 'ext_rss', 'ce_page_break', 'ext_reindex', 'ext_tags', 'ext_relations', 'ext_images', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'hide_future_items', RLT_BOOL, RLC_NONE, true);
    if($useCats){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_fields', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'), false, array("spec_module_body", "spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_list_col', RLT_ENUM, array('none', 'ext_img', 'ext_img_popup', 'ext_img_small'), array('none'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_creatable', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_source', RLT_ENUM, array('ext_img', 'ext_img_popup', 'ext_img_small'), array("ext_img_popup"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxwidth', RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxheight', RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxwidth', RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxheight', RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxwidth', RLT_UINT, array("min"=>1), 275);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxheight', RLT_UINT, array("min"=>1), 275);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_create_bigger', RLT_BOOL, RLC_NONE, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "add_date_prefix", RLT_BOOL, RLC_NONE, false, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_filtered", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_cols", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    // #CMS-11173: $GLOBALS['Core']->IsInstalled('articles') check is added
    if('free' !== AMI::getEdition()){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "##modId##:correctStopArgNames");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10);
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_ext_discussion", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_replies", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_topics", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_list", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_small", RLT_BOOL, RLC_NONE, false, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_at_details", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_pager_page_number_as_bound', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_webmaster_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'use_tree_view', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_anonymous_user_email", RLT_EMAIL, RLC_NONE, "anonymous@localhost.ru");
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_attaches_allowed", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_only_one_level", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_multi_topics", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_pager_type", RLT_ENUM, array("items", "topics"), "items");

    // #CMS-11173: $GLOBALS['Core']->IsInstalled('articles') check is added
    if('free' !== AMI::getEdition()){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'subitems_total_items_limit', RLT_UINT, array("min"=>3, "max"=>1000), 30, false, array('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_subitem_sort_col', RLT_ENUM, array('date_created', 'header', 'position'), 'date_created', false, array('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_SINT, array('min' => 1), 1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));
        $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
        $vMod->Captions['show_subitems'] .= $aCaptions['show_subitems_no_cat_mode'];
        unset($aCaptions);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'subitems_grp_by_cat', RLT_BOOL, RLC_NONE, TRUE, false, array('spec_module_body'));
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_specblock_60', RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(
        CMS_CoreRules::RLR_ROOT,
        CMS_CoreRules::VIEW_MODE_NOVICE,
        'small_number_items',
        RLT_UINT,
        array('min' => 1),
        4,
        false,
        array('spec_small_##modId##')
    );
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_total_items_limit", RLT_UINT, array("min"=>3, "max"=>1000), 30, false, array("spec_small_##modId##"));
    if($useCats){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'small_grp_by_cat', RLT_BOOL, RLC_NONE, false, false, array('spec_small_##modId##'));
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");

#    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_category_ids",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, 0, false, array("spec_small_##modId##"), "##modId##_cat:getOptionsModCB");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_col", RLT_ENUM, array("header", "position"), "header", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date_created", "header", "position", "ext_rate_rate"), "date_created", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "desc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_small_".$vModName));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_##modId##"), "modules_templates:GetCustomModuleTemplatesWithPath");
    if($useCats){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(-1), false, array('spec_small_##modId##'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_##modId##"), "common_settings:rulePageIdsCB");
    }
    // $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
    // $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_adv", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_list", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_details", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_sb", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        //--  Audit extension for ARTICLES
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
            array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)),
            array("visible", "visible"));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_author", "field_source", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
            array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
            array("not_publish", "not_publish", "not_publish"));
    }

    //--  RSS extension for ARTICLES
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_rss_extension", RLT_SPLITTER, RLC_NONE, false, true, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_num_elements", RLT_UINT, array("min"=>1), 10, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_page", RLT_ENUM_MULTI_ARRAY, array("rss_generate", "rss_autolink"), array("rss_generate"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_image", RLT_ENUM, array("rss_xmlimage", "rss_rss20image", "rss_rssimage"),  array("rss_rss20image"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_title", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_description", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_image", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssImage");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_style", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssStyle");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_webmaster", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_title", RLT_ENUM, array("rss_header", "rss_announce"), array("rss_header"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_description", RLT_ENUM, array("rss_announce", "rss_header"), array("rss_announce"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_enclosure", RLT_ENUM, array("rss_small_image", "rss_image", "rss_popup_image", "none"), array("rss_small_image"), false, array("spec_module_body"));// = field from
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_guid", RLT_ENUM, array("rss_link", "none"), array("none"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_pubdate", RLT_ENUM, array("rss_m_date", "rss_c_date", "none"), array("rss_c_date"), false, array("spec_module_body"));// = field
    //-- end RSS

    // #CMS-11482, ext_rating {

    if($GLOBALS['Core']->IsInstalled('ext_rating')){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_ext_rating', RLT_SPLITTER, RLC_NONE, false, true, array('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'form_template', RLT_ENUM, RLC_CALLBACK, 'rating_like.tpl', false, array('spec_module_body'), 'modules_templates:GetCustomModuleTemplates');
    }

    // } ext_rating

    $vMod->finishModule();
    unset($useCats);
}

// } [ami_multifeeds|articles]
// [ami_multifeeds|articles|cat] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->removeRules( array( "page_size_small", "page_sort_col_small", "page_sort_dim_small", "cols") );

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, '##modId##:ruleExtensionsCB', array('ext_audit', 'ext_reindex', 'ext_rating', 'ext_relations', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "front_page_sort_col", RLT_ENUM, array("header", "position", 'ext_rate_count', 'ext_rate_rate'),   "header", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_empty_cats", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, TRUE);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_stat_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_place_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_fields', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'), false, array("spec_module_body", "spec_small_##parentModId##"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_list_col', RLT_ENUM, array('none', 'ext_img', 'ext_img_popup', 'ext_img_small'), array('none'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_creatable', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_source', RLT_ENUM, array('ext_img', 'ext_img_popup', 'ext_img_small'), array("ext_img_popup"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxwidth', RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxheight', RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxwidth', RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxheight', RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxwidth', RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxheight', RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_create_bigger', RLT_BOOL, RLC_NONE, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);

        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
        //    array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)), // , "adding_allow"=>0
        //    array("visible", "visible"));
        //
        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
            array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
            array("not_publish", "not_publish", "not_publish"));
    }
    // $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
    // $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);    $vMod->finishModule();

    $vMod->finishModule();
}

// } [ami_multifeeds|articles|cat]
// [ami_multifeeds|stickers] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);

    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

     $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_specblock", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "search_field_cat", RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, -1, false, array("spec_small_stickers"),"stickers_cat:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "search_field_item", RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, -1, false, array("spec_small_stickers"),"stickers:getOptionsModColsCB");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_number_items", RLT_UINT, RLC_NONE, 4, false, array("spec_small_stickers"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "announce_mode_full", RLT_BOOL, RLC_NONE, true, false, array("spec_small_stickers"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "announce_small_length", RLT_UINT, RLC_NONE, 250, false, array("spec_small_stickers"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "header_small_length", RLT_UINT, RLC_NONE, 100, false, array("spec_small_stickers"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_small_stickers"));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_##modId##"), "modules_templates:GetCustomModuleTemplatesWithPath");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "", false, array("spec_small_stickers"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date_created", "position", "header", "rand"), "rand", false, array("spec_small_stickers"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_stickers"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_images'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "item_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), array("picture", "popup_picture", "small_picture"), false, array("spec_small_stickers"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "col_picture_type", RLT_ENUM, array("none", "picture", "popup_picture", "small_picture"), array("none"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "prior_source_picture", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("popup_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxwidth", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxheight", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxwidth", RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxheight", RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxwidth", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxheight", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_bigger_image", RLT_BOOL, RLC_NONE, true);

    $vMod->finishModule();
}

// } [ami_multifeeds|stickers]
// [ami_multifeeds|stickers|cat] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_empty_cats", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));

    $vMod->finishModule();
}

// } [ami_multifeeds|stickers|cat]
// [ami_multifeeds|news] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $useCats = $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories');
    $isCoreV5 = $oDeclarator->getAttr($vModName, 'core_v5', FALSE);

    if(!$isCoreV5){
        $vMod->removeRules(array('page_size_small'));
    }

    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("date_created", "header", "position", 'ext_rate_count', 'ext_rate_rate'), "date_created", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_stat_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_place_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array('ext_twist_prevention', 'ext_rss', 'ext_reindex'), false, false, '##modId##:ruleExtensionsCB', array('ext_twist_prevention', 'ext_discussion', 'ext_rating', 'ext_audit', 'ext_rss', 'ce_page_break', 'ext_reindex', 'ext_tags', 'ext_relations', 'ext_images', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, TRUE);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'hide_future_items', RLT_BOOL, RLC_NONE, true);
    if($useCats && !$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_fields', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'), false, array("spec_module_body", "spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_list_col', RLT_ENUM, array('none', 'ext_img', 'ext_img_popup', 'ext_img_small'), array('none'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_creatable', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_source', RLT_ENUM, array('ext_img', 'ext_img_popup', 'ext_img_small'), array("ext_img_popup"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxwidth', RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxheight', RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxwidth', RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxheight', RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxwidth', RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxheight', RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_create_bigger', RLT_BOOL, RLC_NONE, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "add_date_prefix", RLT_BOOL, RLC_NONE, false, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_browse", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_body_browse", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_browse_page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "browse_active_item_position", RLT_ENUM_WITH_UINT, array("enum"=>array("0", 1), "enum_only"=>array("0"), "result_type"=>"simple"), 3, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_browse_cols", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_filtered", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_cols", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    if(!$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "##modId##:correctStopArgNames");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10);
    }

    /* PM 5587
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_archive", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "archive_type", RLT_ENUM, array("manual", "date"), "manual");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "archive_period", RLT_DATE_PERIOD_NEGATIVE, RLC_NONE, "-12 month");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_type", RLT_ENUM, array("all", "active", "archive"), "all", false, array("spec_module_body"));
    */

    if($useCats && !$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_col", RLT_ENUM, array("date_created", "header", "position"), "date_created", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_SINT, array('min' => 1), 1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));
        $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
        $vMod->Captions['show_subitems'] .= $aCaptions['show_subitems_no_cat_mode'];
        unset($aCaptions);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'subitems_grp_by_cat', RLT_BOOL, RLC_NONE, TRUE, false, array('spec_module_body'));
    }
    if(!$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_total_items_limit", RLT_UINT, array("min"=>3, "max"=>1000), 30, false);
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, $isCoreV5 ? 'spl_specblock' : 'spl_specblock_60', RLT_SPLITTER, RLC_NONE, false, true);
    if($isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "small_view_mode", RLT_ENUM, TlIIII1($vModName), "usual", false, array("spec_small_##modId##"));
    }else{
        $vMod->addRule(
            CMS_CoreRules::RLR_ROOT,
            CMS_CoreRules::VIEW_MODE_NOVICE,
            'small_number_items',
            RLT_UINT,
            $isCoreV5 ? RLC_NONE : array('min' => 1),
            4,
            false,
            array('spec_small_##modId##')
        );
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_total_items_limit", RLT_UINT, array("min"=>3, "max"=>1000), 30, false, array("spec_small_##modId##"));
    }
    if($isCoreV5){
        $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
        $vMod->Captions['small_number_items'] = $aCaptions['small_number_items'] . $aCaptions['small_number_items_50'];
        unset($aCaptions);
        /*
        // List of categories id, from which the items will be shown
        //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->addRule(
            CMS_CoreRules::RLR_ROOT,
            CMS_CoreRules::VIEW_MODE_NOVICE,
            'small_number_categories',
            RLT_ENUM_WITH_UINT,
            array('enum' => array('0', 1), 'enum_only' => array('0'), 'result_type' => 'simple'),
            0,
            FALSE,
            array('spec_small_##modId##')
        );
        */
    }elseif($useCats){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'small_grp_by_cat', RLT_BOOL, RLC_NONE, false, false, array('spec_small_##modId##'));
    }
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_col_small", RLT_ENUM, array("date_created", "header", "position", "ext_rate_rate"), "ext_rate_rate", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_dim_small", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_col", RLT_ENUM, array("header", "position"), "header", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date_created", "header", "position", "ext_rate_rate"), "date_created", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "desc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_small_".$vModName));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "announce_mode_full", RLT_BOOL, RLC_NONE, false, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "announce_small_length", RLT_UINT, array("min"=>3, "max"=>0xFFFF), 128, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "header_small_length", RLT_UINT, array("min"=>3, "max"=>255), 200, false, array("spec_small_##modId##"));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_##modId##"), "modules_templates:GetCustomModuleTemplatesWithPath");

    if($useCats && !$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(-1), false, array('spec_small_##modId##'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_##modId##"), "common_settings:rulePageIdsCB");
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_ext_discussion", RLT_SPLITTER, RLC_NONE, false, true);
    if($isCoreV5){
        // $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_body_when_forum", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    }
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_replies", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_topics", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_list", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_small", RLT_BOOL, RLC_NONE, false, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_webmaster_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'use_tree_view', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_anonymous_user_email", RLT_EMAIL, RLC_NONE, "anonymous@localhost.ru");
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_attaches_allowed", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_only_one_level", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_multi_topics", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_pager_type", RLT_ENUM, array("items", "topics"), "items");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_at_details", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_pager_page_number_as_bound', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));

    if($isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_adv", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_list", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_details", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_sb", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
    }

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
        array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)/*, "adding_allow"=>0*/),
        array("field_date"=>"visible", "field_body"=>"visible", "field_picture"=>"visible", "field_popup_picture"=>"visible", "field_small_picture"=>"visible", "field_html_title"=>"hidden"));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
        array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
        array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
    }

    //--  RSS extension for NEWS
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_rss_extension", RLT_SPLITTER, RLC_NONE, false, true, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_num_elements", RLT_UINT, array("min"=>1), 10, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_page", RLT_ENUM_MULTI_ARRAY, array("rss_generate", "rss_autolink"), array("rss_generate"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_image", RLT_ENUM, array("rss_xmlimage", "rss_rss20image", "rss_rssimage"),  array("rss_rss20image"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_title", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_description", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_image", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssImage");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_style", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssStyle");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_webmaster", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_title", RLT_ENUM, array("rss_header", "rss_announce"), array("rss_header"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_description", RLT_ENUM, array("rss_announce", "rss_header"), array("rss_announce"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_fulltext", RLT_ENUM, array("rss_body", "rss_announce", "rss_header", "none"), array("none"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_enclosure", RLT_ENUM, array("rss_small_image", "rss_image", "rss_popup_image", "none"),array("rss_small_image"), false, array("spec_module_body"));// = field from news
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_guid", RLT_ENUM, array("rss_link", "none"), array("none"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_pubdate", RLT_ENUM, array("rss_m_date", "rss_c_date", "none"), array("rss_c_date"), false, array("spec_module_body"));// = field
    //-- end RSS

    // #CMS-11482, ext_rating {

    if($GLOBALS['Core']->IsInstalled('ext_rating')){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_ext_rating', RLT_SPLITTER, RLC_NONE, false, true, array('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'form_template', RLT_ENUM, RLC_CALLBACK, 'rating_like.tpl', false, array('spec_module_body'), 'modules_templates:GetCustomModuleTemplates');
    }

    // } ext_rating

//    $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);

    $vMod->finishModule();
}

// } [ami_multifeeds|news]
// [ami_multifeeds|news|cat] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->removeRules( array( "page_size_small", "page_sort_col_small", "page_sort_dim_small", "cols") );

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, '##modId##:ruleExtensionsCB', array('ext_audit', 'ext_reindex', 'ext_rating', 'ext_relations', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "front_page_sort_col", RLT_ENUM, array("header", "position", 'ext_rate_count', 'ext_rate_rate'), "header", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_empty_cats", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, TRUE);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_stat_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_place_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_fields', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'), false, array("spec_module_body", "spec_small_##parentModId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_list_col', RLT_ENUM, array('none', 'ext_img', 'ext_img_popup', 'ext_img_small'), array('none'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_creatable', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_source', RLT_ENUM, array('ext_img', 'ext_img_popup', 'ext_img_small'), array("ext_img_popup"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxwidth', RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxheight', RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxwidth', RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxheight', RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxwidth', RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxheight', RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_create_bigger', RLT_BOOL, RLC_NONE, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);

        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
        //    array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)), // , "adding_allow"=>0
        //    array("visible", "visible"));
        //
        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
            array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
            array("not_publish", "not_publish", "not_publish"));
    }
    // $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
    // $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);    $vMod->finishModule();

    $vMod->finishModule();
}

// } [ami_multifeeds|news|cat]
// [ami_multifeeds|blog] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $useCats = $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories');
    $isCoreV5 = $oDeclarator->getAttr($vModName, 'core_v5', FALSE);

    if(!$isCoreV5){
        $vMod->removeRules(array('page_size_small'));
    }

    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("date_created", "header", "position", 'ext_rate_count', 'ext_rate_rate'), "date_created", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_stat_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_place_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array('ext_twist_prevention', 'ext_reindex', 'ext_discussion', 'ext_rating', 'ext_rss'), false, false, '##modId##:ruleExtensionsCB', array('ext_twist_prevention', 'ext_discussion', 'ext_rating', 'ext_audit', 'ext_rss', 'ce_page_break', 'ext_reindex', 'ext_tags', 'ext_relations', 'ext_images', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, TRUE);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'hide_future_items', RLT_BOOL, RLC_NONE, true);
    if($useCats && !$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_fields', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'), false, array("spec_module_body", "spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_list_col', RLT_ENUM, array('none', 'ext_img', 'ext_img_popup', 'ext_img_small'), array('none'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_creatable', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_source', RLT_ENUM, array('ext_img', 'ext_img_popup', 'ext_img_small'), array("ext_img_popup"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxwidth', RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxheight', RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxwidth', RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxheight', RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxwidth', RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxheight', RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_create_bigger', RLT_BOOL, RLC_NONE, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "add_date_prefix", RLT_BOOL, RLC_NONE, false, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_browse", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_body_browse", RLT_BOOL, RLC_NONE, TRUE, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_browse_page_size", RLT_UINT, array("min"=>1), 3, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "browse_active_item_position", RLT_ENUM_WITH_UINT, array("enum"=>array("0", 1), "enum_only"=>array("0"), "result_type"=>"simple"), 3, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_browse_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_filtered", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_cols", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    if(!$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "##modId##:correctStopArgNames");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10);
    }

    /* PM 5587
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_archive", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "archive_type", RLT_ENUM, array("manual", "date"), "manual");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "archive_period", RLT_DATE_PERIOD_NEGATIVE, RLC_NONE, "-12 month");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_type", RLT_ENUM, array("all", "active", "archive"), "all", false, array("spec_module_body"));
    */

    if($useCats && !$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_col", RLT_ENUM, array("date_created", "header", "position"), "date_created", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_SINT, array('min' => 1), 1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));
        $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
        $vMod->Captions['show_subitems'] .= $aCaptions['show_subitems_no_cat_mode'];
        unset($aCaptions);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'subitems_grp_by_cat', RLT_BOOL, RLC_NONE, TRUE, false, array('spec_module_body'));
    }
    if(!$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_total_items_limit", RLT_UINT, array("min"=>3, "max"=>1000), 30, false);
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, $isCoreV5 ? 'spl_specblock' : 'spl_specblock_60', RLT_SPLITTER, RLC_NONE, false, true);
    if($isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "small_view_mode", RLT_ENUM, TlIIII1($vModName), "usual", false, array("spec_small_##modId##"));
    }else{
        $vMod->addRule(
            CMS_CoreRules::RLR_ROOT,
            CMS_CoreRules::VIEW_MODE_NOVICE,
            'small_number_items',
            RLT_UINT,
            $isCoreV5 ? RLC_NONE : array('min' => 1),
            4,
            false,
            array('spec_small_##modId##')
        );
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_total_items_limit", RLT_UINT, array("min"=>3, "max"=>1000), 30, false, array("spec_small_##modId##"));
    }
    if($isCoreV5){
        $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
        $vMod->Captions['small_number_items'] = $aCaptions['small_number_items'] . $aCaptions['small_number_items_50'];
        unset($aCaptions);
        /*
        // List of categories id, from which the items will be shown
        //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->addRule(
            CMS_CoreRules::RLR_ROOT,
            CMS_CoreRules::VIEW_MODE_NOVICE,
            'small_number_categories',
            RLT_ENUM_WITH_UINT,
            array('enum' => array('0', 1), 'enum_only' => array('0'), 'result_type' => 'simple'),
            0,
            FALSE,
            array('spec_small_##modId##')
        );
        */
    }elseif($useCats){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'small_grp_by_cat', RLT_BOOL, RLC_NONE, false, false, array('spec_small_##modId##'));
    }
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_col_small", RLT_ENUM, array("date_created", "header", "position", "ext_rate_rate"), "ext_rate_rate", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_dim_small", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_col", RLT_ENUM, array("header", "position"), "header", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date_created", "header", "position", "ext_rate_rate"), "date_created", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "desc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_small_".$vModName));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "announce_mode_full", RLT_BOOL, RLC_NONE, false, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "announce_small_length", RLT_UINT, array("min"=>3, "max"=>0xFFFF), 128, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "header_small_length", RLT_UINT, array("min"=>3, "max"=>255), 200, false, array("spec_small_##modId##"));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_##modId##"), "modules_templates:GetCustomModuleTemplatesWithPath");

    if($useCats && !$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(-1), false, array('spec_small_##modId##'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_##modId##"), "common_settings:rulePageIdsCB");
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_ext_discussion", RLT_SPLITTER, RLC_NONE, false, true);
    if($isCoreV5){
        // $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_body_when_forum", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    }
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_replies", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_topics", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_list", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_small", RLT_BOOL, RLC_NONE, false, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_webmaster_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'use_tree_view', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_anonymous_user_email", RLT_EMAIL, RLC_NONE, "anonymous@localhost.ru");
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_attaches_allowed", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_only_one_level", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_multi_topics", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_pager_type", RLT_ENUM, array("items", "topics"), "items");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_at_details", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_pager_page_number_as_bound', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));

    if($isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_adv", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_list", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_details", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_sb", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
    }

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
        array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)/*, "adding_allow"=>0*/),
        array("field_date"=>"visible", "field_body"=>"visible", "field_picture"=>"visible", "field_popup_picture"=>"visible", "field_small_picture"=>"visible", "field_html_title"=>"hidden"));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
        array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
        array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
    }

    //--  RSS extension for NEWS
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_rss_extension", RLT_SPLITTER, RLC_NONE, false, true, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_num_elements", RLT_UINT, array("min"=>1), 10, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_page", RLT_ENUM_MULTI_ARRAY, array("rss_generate", "rss_autolink"), array("rss_generate"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_image", RLT_ENUM, array("rss_xmlimage", "rss_rss20image", "rss_rssimage"),  array("rss_rss20image"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_title", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_description", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_image", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssImage");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_style", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssStyle");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_webmaster", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_title", RLT_ENUM, array("rss_header", "rss_announce"), array("rss_header"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_description", RLT_ENUM, array("rss_announce", "rss_header"), array("rss_announce"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_fulltext", RLT_ENUM, array("rss_body", "rss_announce", "rss_header", "none"), array("none"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_enclosure", RLT_ENUM, array("rss_small_image", "rss_image", "rss_popup_image", "none"),array("rss_small_image"), false, array("spec_module_body"));// = field from news
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_guid", RLT_ENUM, array("rss_link", "none"), array("none"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_pubdate", RLT_ENUM, array("rss_m_date", "rss_c_date", "none"), array("rss_c_date"), false, array("spec_module_body"));// = field
    //-- end RSS

    // #CMS-11482, ext_rating {

    if($GLOBALS['Core']->IsInstalled('ext_rating')){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_ext_rating', RLT_SPLITTER, RLC_NONE, false, true, array('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'form_template', RLT_ENUM, RLC_CALLBACK, 'rating_like.tpl', false, array('spec_module_body'), 'modules_templates:GetCustomModuleTemplates');
    }

    // } ext_rating

//    $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);

    $vMod->finishModule();
}

// } [ami_multifeeds|blog]
// [ami_multifeeds|blog|cat] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->removeRules( array( "page_size_small", "page_sort_col_small", "page_sort_dim_small", "cols") );

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, '##modId##:ruleExtensionsCB', array('ext_audit', 'ext_reindex', 'ext_rating', 'ext_relations', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "front_page_sort_col", RLT_ENUM, array("header", "position", 'ext_rate_count', 'ext_rate_rate'), "header", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_empty_cats", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, TRUE);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_stat_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_place_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_fields', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'), false, array("spec_module_body", "spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_list_col', RLT_ENUM, array('none', 'ext_img', 'ext_img_popup', 'ext_img_small'), array('none'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_creatable', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_source', RLT_ENUM, array('ext_img', 'ext_img_popup', 'ext_img_small'), array("ext_img_popup"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxwidth', RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxheight', RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxwidth', RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxheight', RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxwidth', RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxheight', RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_create_bigger', RLT_BOOL, RLC_NONE, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);

        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
        //    array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)), // , "adding_allow"=>0
        //    array("visible", "visible"));
        //
        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
            array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
            array("not_publish", "not_publish", "not_publish"));
    }
    // $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
    // $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);    $vMod->finishModule();

    $vMod->finishModule();
}

// } [ami_multifeeds|blog|cat]
// [ami_multifeeds|photoalbum] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);
    $vMod->removeRules( array("page_size_small", "page_sort_col_small", "page_sort_dim_small") );
    $isCoreV5 = $oDeclarator->getAttr($vModName, 'core_v5', FALSE);
    $useCats = $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories');

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'page_sort_col', RLT_ENUM, array('date_created', 'header', 'position', 'ext_rate_rate'), 'date_created');
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, 'page_sort_dim', RLT_ENUM, array('asc', 'desc'), 'desc');
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_page_sort_col', RLT_ENUM, array('date_created', 'header', 'position', 'ext_rate_count', 'ext_rate_rate'), 'date_created', false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_page_sort_dim', RLT_ENUM, array('asc', 'desc'), 'desc', false, array('spec_module_body'));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_audit", "ext_twist_prevention", "ext_discussion", "ext_rating", 'ext_reindex', "ext_tags", 'ext_modules_custom_fields', RLC_EMPTY))), array(RLC_EMPTY), false, array());
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array('ext_twist_prevention', 'ext_discussion', 'ext_rating', 'ext_reindex'), false, false, '##modId##:ruleExtensionsCB', array('ext_audit', 'ext_twist_prevention', 'ext_discussion', 'ext_rating', 'ext_reindex', 'ext_tags', 'ext_modules_custom_fields'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'cols', RLT_UINT, array('min' => 1), 3);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, TRUE);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'hide_future_items', RLT_BOOL, RLC_NONE, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, TRUE);
    if(
        $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories') &&
        !$oDeclarator->getAttr($vModName, 'core_v5')
    ){
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_fields', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'), false, array("spec_module_body", "spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_list_col', RLT_ENUM, array('none', 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img_small'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_creatable', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_source', RLT_ENUM, array('ext_img', 'ext_img_popup', 'ext_img_small'), array("ext_img_popup"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxwidth', RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxheight', RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxwidth', RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxheight', RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxwidth', RLT_UINT, array("min"=>1), 275);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxheight', RLT_UINT, array("min"=>1), 275);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_create_bigger', RLT_BOOL, RLC_NONE, true);
    //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "static_watermark", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "static_watermark", RLT_CHAR, RLC_CALLBACK, "", false, array(), "##modId##:setImagesWatermark");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multi_page",                 true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_browse", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_body_browse", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_browse_page_size", RLT_UINT, array("min"=>1), 9, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "browse_active_item_position", RLT_UINT, array("min"=>1), 3);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "browse_active_item_position", RLT_ENUM_WITH_UINT, array("enum"=>array("0", 1), "enum_only"=>array("0"), "result_type"=>"simple"), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_browse_cols", RLT_UINT, array("min"=>1), 3, false, array("spec_module_body"));


    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);

    //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "##modId##:correctStopArgNames");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 3, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_ext_discussion", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_replies", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_topics", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_list", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_small", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body", "spec_small_photoalbum"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_at_details", RLT_BOOL, RLC_NONE, true, TRUE, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_pager_page_number_as_bound', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_webmaster_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'use_tree_view', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_anonymous_user_email", RLT_EMAIL, RLC_NONE, "anonymous@localhost.ru");
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_attaches_allowed", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_only_one_level", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_multi_topics", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_pager_type", RLT_ENUM, array("items", "topics"), "items");


    // #CMS-11482, ext_rating {

    if($GLOBALS['Core']->IsInstalled('ext_rating')){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_ext_rating', RLT_SPLITTER, RLC_NONE, false, true, array('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'form_template', RLT_ENUM, RLC_CALLBACK, 'rating_like.tpl', false, array('spec_module_body'), 'modules_templates:GetCustomModuleTemplates');
    }

    // } ext_rating

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);

    if($GLOBALS['Core']->TTlI1T1($vModName, 'use_categories') && !$oDeclarator->getAttr($vModName, 'core_v5')){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'subitems_total_items_limit', RLT_UINT, array("min"=>3, "max"=>1000), 30, false, array('spec_module_body'));
    }
    if(!$oDeclarator->getAttr($vModName, 'core_v5')){
        $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
        $vMod->Captions['show_subitems'] .= $aCaptions['show_subitems_no_cat_mode'];
        unset($aCaptions);
    }
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_col", RLT_ENUM, array("date_created", "header", "position"), "date_created", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_SINT, array('min' => 1), 1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));
    if(!$oDeclarator->getAttr($vModName, 'core_v5')){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'subitems_grp_by_cat', RLT_BOOL, RLC_NONE, TRUE, false, array('spec_module_body'));
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, $isCoreV5 ? 'spl_specblock' : 'spl_specblock_60', RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_number_items", RLT_UINT, RLC_NONE, 4, false, array("spec_small_##modId##"));
    if(!$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_total_items_limit", RLT_UINT, array("min"=>3, "max"=>1000), 30, false, array("spec_small_##modId##"));
    }
    if($isCoreV5){
        $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
        $vMod->Captions['small_number_items'] = $aCaptions['small_number_items'] . $aCaptions['small_number_items_50'];
        unset($aCaptions);

        // List of categories id, from which the items will be shown
        //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->addRule(
            CMS_CoreRules::RLR_ROOT,
            CMS_CoreRules::VIEW_MODE_NOVICE,
            'small_number_categories',
            RLT_ENUM_WITH_UINT,
            array('enum' => array('0', 1), 'enum_only' => array('0'), 'result_type' => 'simple'),
            0,
            FALSE,
            array('spec_small_##modId##')
        );
    }elseif($useCats){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'small_grp_by_cat', RLT_BOOL, RLC_NONE, false, false, array('spec_small_##modId##'));
    }
    // $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_category_ids",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, 0, false, array("spec_small_##modId##"), "##modId##_cat:getOptionsModCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_col", RLT_ENUM, array("header", "position"), "header", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date_created", "header", "position", "ext_rate_rate"), "date_created", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "desc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_small_".$vModName));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_##modId##"), "modules_templates:GetCustomModuleTemplatesWithPath");
    if(
        $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories') &&
        !$oDeclarator->getAttr($vModName, 'core_v5')
    ){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(-1), false, array('spec_small_##modId##'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_##modId##"), "common_settings:rulePageIdsCB");
    }

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);

        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
        //    array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)), // , "adding_allow"=>0
        //    array("visible", "visible"));
        //
        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
            array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
            array("not_publish", "not_publish", "not_publish"));
    }

    $vMod->finishModule();
}

// } [ami_multifeeds|photoalbum]
// [ami_multifeeds|photoalbum|cat] {

    $vModName = '##modId##';
    if($GLOBALS["Core"]->IsInstalled($vModName)){
        $vMod = &$oCoreRules->addModule($vModName);
        $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
        $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);
        $vMod->removeRules( array( "page_size_small", "page_sort_col_small", "page_sort_dim_small", "cols") );

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "front_page_sort_col", RLT_ENUM, array("header", "position", 'ext_rate_count', 'ext_rate_rate'), "header", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_empty_cats", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_audit", "ext_rating", 'ext_reindex', 'ext_twist_prevention', 'ext_discussion', 'ext_modules_custom_fields', RLC_EMPTY))), array(RLC_EMPTY), false, array());
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, '##modId##:ruleExtensionsCB', array('ext_audit', 'ext_twist_prevention', 'ext_discussion', 'ext_rating', 'ext_reindex', 'ext_modules_custom_fields'));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_fields', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'), false, array("spec_module_body", "spec_small_##modId##"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_list_col', RLT_ENUM, array('none', 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img_small'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_creatable', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_source', RLT_ENUM, array('ext_img', 'ext_img_popup', 'ext_img_small'), array("ext_img_popup"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxwidth', RLT_UINT, array("min"=>1), 300);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_maxheight', RLT_UINT, array("min"=>1), 300);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxwidth', RLT_UINT, array("min"=>1), 800);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_popup_maxheight', RLT_UINT, array("min"=>1), 600);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxwidth', RLT_UINT, array("min"=>1), 275);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_small_maxheight', RLT_UINT, array("min"=>1), 275);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_create_bigger', RLT_BOOL, RLC_NONE, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "static_watermark", RLT_CHAR, RLC_NONE, "");

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "average_cat_rating", RLT_BOOL, RLC_NONE, true, true, array("spec_module_body"));

        if($GLOBALS["Core"]->IsInstalled("srv_audit")){
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);

            //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
            //    array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)/*, "adding_allow"=>0*/),
            //    array("visible", "visible"));
            //
            //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
                array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
                array("not_publish", "not_publish", "not_publish"));
        }
/*
        $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);
*/

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_twist_prevention', RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'action_period', RLT_DATE_PERIOD_POSITIVE, RLC_NONE, '5 second', false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_captcha', RLT_BOOL, RLC_NONE, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'js_checking', RLT_BOOL, RLC_NONE, true, false);
//            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'generate_twist_action', RLT_BOOL, RLC_NONE, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_alert', RLT_BOOL, RLC_NONE, true, false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_ext_discussion', RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_forum_count_replies', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_forum_link_in_list', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_webmaster_email', RLT_EMAIL, RLC_NONE, $GLOBALS['COMPANY_EMAIL'], false, array ('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'use_tree_view', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
//            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_attaches_allowed', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_forum_at_details', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_pager_page_number_as_bound', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));

        $vMod->finishModule();
    }

// } [ami_multifeeds|photoalbum|cat]
// [ami_data_exchange|photoalbum|data_exchange] {

// } [ami_data_exchange|photoalbum|data_exchange]
// [ami_files|files] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){

    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->removeRules(Array("page_sort_col_small", "page_sort_dim_small", "page_size_small"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, Array("name", "ftype", "position", "cdate", "mdate", "num_downloaded"), "name", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "item_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "col_picture_type", RLT_ENUM, array("none", "picture", "popup_picture", "small_picture"), Array("none"));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "files_path", RLT_CHAR, RLC_NONE, $MODULE_PICTURES_PATH."ftpfiles/");
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, 'buffer', RLT_UINT, array('min' => 1, 'max'=> 1048576), 512000);
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "timelimit", RLT_UINT, array("min"=>1), 30);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "partial_download_on", RLT_BOOL, RLC_NONE, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_download_counter", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_audit", "ext_rss", "ce_page_break", 'ext_reindex', "ext_tags", 'ext_relations', 'ext_images', 'ext_modules_custom_fields', RLC_EMPTY))), array(RLC_EMPTY), false, array());
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_audit', 'ext_rss', 'ce_page_break', 'ext_reindex', 'ext_tags', 'ext_relations', 'ext_images', 'ext_modules_custom_fields'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'hide_future_items', RLT_BOOL, RLC_NONE, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);
    //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "##modId##:correctStopArgNames");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_col", RLT_ENUM, Array("name", "ftype", "position", "cdate", "mdate", "num_downloaded"), "name", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);

        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
        //    array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)/*, "adding_allow"=>0*/),
        //    array("visible", "visible"));
        //
        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
            array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
            array("not_publish", "not_publish", "not_publish"));
    }
    //--  RSS extension for FILES
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_rss_extension", RLT_SPLITTER, RLC_NONE, false, true, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_num_elements", RLT_UINT, array("min"=>1), 10, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_page", RLT_ENUM_MULTI_ARRAY, array("rss_generate", "rss_autolink"), array("rss_generate"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_image", RLT_ENUM, array("rss_xmlimage", "rss_rss20image", "rss_rssimage"),  array("rss_rss20image"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_title", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_description", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_image", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssImage");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_style", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssStyle");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_webmaster", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_title", RLT_ENUM, array("rss_f_name", "rss_announce", "rss_description"), array("rss_f_name"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_description", RLT_ENUM, array("rss_announce", "rss_f_name", "rss_description"), array("rss_announce"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_enclosure", RLT_ENUM, array("rss_small_image", "rss_image", "rss_popup_image", "none"),array("rss_small_image"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_guid", RLT_ENUM, array("rss_link", "none"), array("none"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_pubdate", RLT_ENUM, array("rss_m_date", "rss_c_date", "none"), array("rss_c_date"), false, array("spec_module_body"));// = field
    //-- end RSS

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "item_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), array("picture", "popup_picture", "small_picture"), false, array("spec_module_body", "spec_small_blog"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "col_picture_type", RLT_ENUM, array("none", "picture", "popup_picture", "small_picture"), array("none"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "prior_source_picture", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("popup_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxwidth", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxheight", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxwidth", RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxheight", RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxwidth", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxheight", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_bigger_image", RLT_BOOL, RLC_NONE, true);

    $vMod->finishModule();
}

// } [ami_files|files]
// [ami_files|files|cat] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
        $vMod = &$oCoreRules->addModule($vModName);
        $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
        $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);
        $vMod->removeRules( array( "page_size_small", "page_sort_col_small", "page_sort_dim_small") );
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_audit', 'ext_reindex', 'ext_relations', 'ext_images', 'ext_modules_custom_fields'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "front_page_sort_col", RLT_ENUM, array("name", "position"),   "name", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_empty_cats", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "item_pictures", RLT_ENUM_MULTI_ARRAY, array("none", "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"), false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "prior_source_picture", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("popup_picture"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxwidth", RLT_UINT, array("min"=>1), 300);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxheight", RLT_UINT, array("min"=>1), 300);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxwidth", RLT_UINT, array("min"=>1), 800);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxheight", RLT_UINT, array("min"=>1), 600);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxwidth", RLT_UINT, array("min"=>1), 80);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxheight", RLT_UINT, array("min"=>1), 80);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_bigger_image", RLT_BOOL, RLC_NONE, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "col_picture_type", RLT_ENUM, array("none", "picture", "popup_picture", "small_picture"), Array("none"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
        if($GLOBALS["Core"]->IsInstalled("srv_audit")){
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
                array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
                array("not_publish", "not_publish", "not_publish"));
        }
        $vMod->finishModule();
}

// } [ami_files|files|cat]
// [ami_data_exchange|files] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);
    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, array("min"=>1), 10);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "max_import_size", RLT_UINT, RLC_NONE, 50000000);
    $vMod->finishModule();
}

// } [ami_data_exchange|files]
// [ami_relations|relations] {

$vModName  = '##modId##';
if ($GLOBALS['Core']->IsInstalled($vModName)) {
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . '_rules_captions.lng');
    $vMod->TTlTTIl($vModName . '_rules_values.lng');
    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_specblock', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'small_display_modules',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (array ('all')), false, array ('spec_small_##modId##'), 'relations:ruleSmallDisplayModulesCB');
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_block_template', RLT_ENUM, RLC_CALLBACK, '', false, array ('spec_small_##modId##'), 'modules_templates:GetCustomModuleTemplatesWithPath');
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'source', RLT_ENUM, array ('item', 'cat'), 'item', false, array("spec_small_##modId##"));

    $vMod->finishModule();
}

// } [ami_relations|relations]
// [ami_ext|category] {

// } [ami_ext|category]
// [ami_ext|adv] {

// } [ami_ext|adv]
// [ami_ext|reindex] {

// } [ami_ext|reindex]
// [ami_ext|discussion] {

$vModName = '##modId##';
if($GLOBALS['Core']->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);
    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_page_sort_col', RLT_ENUM, array('date'), 'date', false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_page_sort_dim', RLT_ENUM, array('asc', 'desc'), 'desc', false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'page_size', RLT_UINT, RLC_NONE, 10);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'messages_pages', RLT_UINT, array ('min' => 1), 5, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'add_messages_by_registered_only', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'updatable_period', RLT_DATE_PERIOD_POSITIVE, RLC_NONE, '6 hour', false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'noindex_external_links', RLT_BOOL, RLC_NONE, true, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'sys_user_as_administration', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_images', RLT_ENUM_MULTI_ARRAY, array (RLC_EMPTY, 'registered_users_only', 'internal_links', 'external_links'), array ('registered_users_only', 'internal_links', 'external_links'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'watch_comments', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_common', RLT_SPLITTER, RLC_NONE, false, true);
    // $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_body_when_forum', RLT_BOOL, RLC_NONE, true, false, array( 'spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_forum_count_replies', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_forum_link_in_list', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_forum_link_in_small', RLT_BOOL, RLC_NONE, false, false, array ('spec_small_news'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'use_tree_view', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_forum_at_details', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_pager_page_number_as_bound', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
    //publishing options
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'publish_from_not_authorized', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'publish_from_authorized', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_notification', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_webmaster_email', RLT_EMAIL, RLC_NONE, $GLOBALS['COMPANY_EMAIL'], false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'from_mbox', RLT_CHAR, RLC_NONE, 'info');

    $vMod->finishModule();
}

// } [ami_ext|discussion]
// [ami_ext|rating] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);
    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rating_by_registered_only", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "weighted_rating", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "weight_formula", RLT_CHAR, RLC_NONE, "((REGDAYS+1)/365) + (LOGGEDIN*10)", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "minimum_votes_to_display", RLT_UINT, array("min"=>1), 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "history_allow_same_ip", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "7 day", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "history_allow_same_user", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "1 year", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "history_clear_interval", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "1 day", false, array("spec_module_body"));


    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_new_items_defaults", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "allow_ratings", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "display_ratings", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sort_by_ratings", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "display_votes", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_rating_display", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_form_in", RLT_ENUM_MULTI_ARRAY, array("body_items", "body_filtered", 'body_urgent_items', "body_itemD"), Array("body_items", 'body_urgent_items', "body_itemD"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "form_type", RLT_ENUM, array("radio", "select"), "radio");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "grade_size", RLT_UINT, array("min"=>2,"max"=>10), 5);

    // allowed minimum is 2
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "default_rating", RLT_UINT, array("min"=>2), 3);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rating_decimal_places", RLT_UINT, array("min"=>0,"max"=>6), 2);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "form_template", RLT_ENUM, RLC_CALLBACK, "rating_stars_oneblock.tpl", false, array("spec_module_body"), "modules_templates:GetCustomModuleTemplates");

    $vMod->finishModule();
}

// } [ami_ext|rating]
// [ami_ext|image] {

// } [ami_ext|image]
// [ami_ext|tags] {

// } [ami_ext|tags]
// [ami_ext|relations] {

// } [ami_ext|relations]
// [ami_antispam|antispam] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    $vMod->TTlTTIl($vModName."_rules_values.lng");

    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_parameters", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "visitors_originality_parameters", RLT_ENUM_MULTI_ARRAY, array("ip_address", "cookie"/*, "php_session"*/), Array("ip_address", "cookie"), false/*, array("spec_module_body")*/);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "allow_disabled_cookies", RLT_BOOL, RLC_NONE, false, false/*, array("spec_module_body")*/);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "record_ttl", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "1 year", false/*, array("spec_module_body")*/);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_js_protection", RLT_BOOL, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_captcha_parameters", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha_for_registered_users", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "image_digits_qty", RLT_UINT, array("min"=>3, "max" =>10), 4);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "image_symbols_set", RLT_ENUM, array("digits", "letters", "letters_and_digits"), "digits");

    // {{{ options from const_system / Show num image module constants

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "type", RLT_ENUM, array("png", "gif", "jpg", "wbmp"), "png", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "jitter_amplitude", RLT_UINT, array("min" => 0), 3);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "wave_amplitude", RLT_FLOAT, array("min" => 0), 1.0);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "noise_level", RLT_FLOAT, array("min" => 0), 100);
	$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "noise_color", RLT_CHAR, RLC_NONE, '808080');
	$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "split_image", RLT_BOOL, RLC_NONE, 'false');

    // }}}

    $vMod->finishModule();
}

// } [ami_antispam|antispam]
// [ami_ext|antispam] {

// } [ami_ext|antispam]
// [ami_multifeeds5|jobs] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    $vMod->TTlTTIl($vModName."_rules_values.lng");
//    $vMod->removeRules();
     $vMod->removeRules( array("page_size_small", "page_sort_col_small", "page_sort_dim_small") );

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("name", "date_expire", "date", "position", "salary"), "name", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_type", RLT_ENUM, array("all", "active"), "active", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "jobs_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_audit", "ext_rss", 'ext_reindex', 'ext_modules_custom_fields', RLC_EMPTY))), array(RLC_EMPTY), false, array());
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_audit', 'ext_rss', 'ext_reindex', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'hide_future_items', RLT_BOOL, RLC_NONE, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);

    //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "##modId##:correctStopArgNames");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
    //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_col", RLT_ENUM, array("name", "position"), "name", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_SINT, array('min' => 1), 1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_specblock", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_number_items", RLT_UINT, RLC_NONE, 4, false, array("spec_small_jobs"));
    // List of categories id, from which the items will be shown
    //(0 - first N categories, which is specified in an option "small_number_categories").
    $vMod->addRule(
        CMS_CoreRules::RLR_ROOT,
        CMS_CoreRules::VIEW_MODE_NOVICE,
        'small_number_categories',
        RLT_ENUM_WITH_UINT,
        array('enum' => array('0', 1), 'enum_only' => array('0'), 'result_type' => 'simple'),
        0,
        FALSE,
        array('spec_small_##modId##')
    );
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_col", RLT_ENUM, array("name", "position"), "name", false, array("spec_small_jobs"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_jobs"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date", "name", "position"), "date", false, array("spec_small_jobs"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "desc", false, array("spec_small_jobs"));

    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_jobs"), "modules_templates:GetCustomModuleTemplatesWithPath");
    if(
        $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories') &&
        !$oDeclarator->getAttr($vModName, 'core_v5')
    ){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(-1), false, array('spec_small_##modId##'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_##modId##"), "common_settings:rulePageIdsCB");
    }

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);

        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
        //    array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)/*, "adding_allow"=>0*/),
        //    array("visible", "visible"));
        //
        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
            array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
            array("not_publish", "not_publish", "not_publish"));
    }
/*
    $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);
*/

    //--  RSS extension for JOBS
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_rss_extension", RLT_SPLITTER, RLC_NONE, false, true, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_num_elements", RLT_UINT, array("min"=>1), 10, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_page", RLT_ENUM_MULTI_ARRAY, array("rss_generate", "rss_autolink"), array("rss_generate"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_image", RLT_ENUM, array("rss_xmlimage", "rss_rss20image", "rss_rssimage"),  array("rss_rss20image"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_title", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_description", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_image", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssImage");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_style", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssStyle");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_webmaster", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_title", RLT_ENUM, array("rss_jobs_name"), array("rss_jobs_name"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_description", RLT_ENUM, array("rss_duty", "rss_requirements1", "rss_requirements2"), array("rss_duty"), false, array("spec_module_body"));//        = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_guid", RLT_ENUM, array("rss_link", "none"), array("none"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_pubdate", RLT_ENUM, array("rss_m_date", "rss_c_date", "none"), array("rss_c_date"), false, array("spec_module_body"));// = field
    //-- end RSS

    $vMod->finishModule();
}

// } [ami_multifeeds5|jobs]
// [ami_multifeeds5|jobs|cat] {

    $vModName = '##modId##';
    if($GLOBALS["Core"]->IsInstalled($vModName)){

        $vMod = &$oCoreRules->addModule($vModName);
        $vMod->TTlTTII($vModName."_rules_captions.lng");

        $vMod->removeRules( array( "page_size_small", "page_sort_col_small", "page_sort_dim_small") );

//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_audit", 'ext_reindex', 'ext_modules_custom_fields', RLC_EMPTY))), array(RLC_EMPTY), false, array());
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_audit', 'ext_reindex', 'ext_modules_custom_fields'));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "front_page_sort_col", RLT_ENUM, array("name", "position"),   "name", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_empty_cats", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages'/* there are categories names in specblock always, 'at_spec_block'*/), array('at_first_page', 'at_next_pages'));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);

        if($GLOBALS["Core"]->IsInstalled("srv_audit")){
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);

            //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
            //    array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)/*, "adding_allow"=>0*/),
            //    array("visible", "visible"));
            //
            //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
                array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
                array("not_publish", "not_publish", "not_publish"));
        }
/*
        $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);
*/
        $vMod->finishModule();
}

// } [ami_multifeeds5|jobs|cat]
// [ami_jobs|history|history] {

    $vModName  = "##modId##";
    if($GLOBALS["Core"]->IsInstalled($vModName)){
        $vMod = &$oCoreRules->addModule($vModName);
        $vMod->TTlTTII($vModName."_rules_captions.lng");
        $vMod->removeRules();

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "message_topic", RLT_ARRAY_OF, array("items_type"=>RLT_CHAR, "remove_disabled"=>array("en"), "adding_allow"=>1), array("ru"=>"Ответ на ваше резюме", "en"=>"An answer to your resume"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "message_sign", RLT_ARRAY_OF, array("items_type"=>RLT_CHAR, "remove_disabled"=>array("en"), "adding_allow"=>1),  array("ru"=>"С уважением,\nВебмастер", "en"=>"Sincerely yours,\nWebmaster"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "def_request_text", RLT_ARRAY_OF, array("items_type"=>RLT_CHAR, "remove_disabled"=>array("en"), "adding_allow"=>1), array("ru"=>"Интересует данная вакансия.", "en"=>"I am interested in the position."));

        $vMod->finishModule();
    }

// } [ami_jobs|history|history]
// [ami_jobs|resume|resume] {

    $vModName = '##modId##';
    if($GLOBALS["Core"]->IsInstalled($vModName)){
        $vMod = &$oCoreRules->addModule($vModName);
        $vMod->TTlTTII($vModName."_rules_captions.lng");
        $vMod->TTlTTIl($vModName."_rules_values.lng");
        $vMod->removeRules(array("page_size_small", "page_sort_col_small", "page_sort_dim_small"));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("date", "lname", "title"), "date", false, array("spec_module_body"));
        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array("ext_audit", "ext_rss", 'ext_reindex', RLC_EMPTY), array(RLC_EMPTY), false, array());

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "enabled_fields", RLT_ENUM_MULTI_ARRAY, array("fname", "lname", "email", "website", "phone", "resume", "addon"), array("fname", "lname", "resume", "addon"), false, array("spec_module_body"));

//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array('ext_modules_custom_fields', RLC_EMPTY))), array(RLC_EMPTY), false, array());
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_modules_custom_fields'));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_seo_settings", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "html_title_splitter", RLT_CHAR, RLC_NONE, "");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "html_title_template", RLT_CHAR, RLC_NONE, "");

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_col", RLT_ENUM, array("date", "lname", "title"), "date", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_SINT, array('min' => 1), 1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_specblock", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_number_items", RLT_UINT, RLC_NONE, 4, false, array("spec_small_jobs_resume"));
        // List of categories id, from which the items will be shown
        //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->addRule(
            CMS_CoreRules::RLR_ROOT,
            CMS_CoreRules::VIEW_MODE_NOVICE,
            'small_number_categories',
            RLT_ENUM_WITH_UINT,
            array('enum' => array('0', 1), 'enum_only' => array('0'), 'result_type' => 'simple'),
            0,
            FALSE,
            array('spec_small_##modId##')
        );
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_col", RLT_ENUM, array("name", "position"), "name", false, array("spec_small_jobs_resume"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_jobs_resume"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date", "lname"), "date", false, array("spec_small_jobs_resume"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "desc", false, array("spec_small_jobs_resume"));

        $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), "jobs_");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_jobs_resume"), "modules_templates:GetCustomModuleTemplatesWithPath");
        if(
            $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories') &&
            !$oDeclarator->getAttr($vModName, 'core_v5')
        ){
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(-1), false, array('spec_small_##modId##'), 'common_settings:rulePageIdsCB');
        }else{
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_##modId##"), "common_settings:rulePageIdsCB");
        }

        $vMod->finishModule();
}

// } [ami_jobs|resume|resume]
// [ami_jobs|employer|employer] {

    $vModName = '##modId##';
    if($GLOBALS["Core"]->IsInstalled($vModName)){
        $vMod = &$oCoreRules->addModule($vModName);
        $vMod->TTlTTII($vModName."_rules_captions.lng");
        $vMod->removeRules();
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "def_request_text", RLT_ARRAY_OF, array("items_type"=>RLT_CHAR, "remove_disabled"=>array("en"), "adding_allow"=>1), array("ru"=>"Интересует данный соискатель.", "en"=>"I am interested in the competitor."));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_twist_prevention", RLC_EMPTY))), array(RLC_EMPTY), false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_twist_prevention'));

        // {{{ twist prevention extension options
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

        $vMod->finishModule();
    }

// } [ami_jobs|employer|employer]
// [ami_votes|votes] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){

    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    $vMod->TTlTTIl($vModName."_rules_values.lng");

    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("date_start", "date_end", "question", "position", "total", "status"), "date_start", false);
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_dim", RLT_ENUM, array("asc", "desc"), "asc", false);
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_col_small", RLT_ENUM, array("date_start", "date_end", "question", "position", "total","rand"), "date_start", false);
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_dim_small", RLT_ENUM, array("asc", "desc"), "asc", false);

    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, array("min"=>1), $oCoreRules->Core->GetOption("default_page_size"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "default_answers_count", RLT_UINT, RLC_NONE, 5, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "bar_width", RLT_UINT, RLC_NONE, 300, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_bar_width", RLT_UINT, RLC_NONE, 70, false, array("spec_small_votes"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "question_length", RLT_UINT, array("min"=>1, "max"=>255), 45, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "+1 hour");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_cache_expire", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "+1 day");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "view_results_before_voting", RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "show_after_voices_count", RLT_UINT, array("min"=>0), 0);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_numeric", RLT_ENUM_MULTI_ARRAY, array ("show_numeric_total", "show_numeric_percentage", RLC_EMPTY), array ("show_numeric_total", "show_numeric_percentage", RLC_EMPTY), false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "registered_users_only", RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, 'result_answers_sort_col', RLT_ENUM, array('id', 'voices'), 'voices', false);
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, 'result_answers_sort_dim', RLT_ENUM, array('asc', 'desc'), 'desc', false);

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array ('ext_twist_prevention', 'ext_reindex', 'ext_images', RLC_EMPTY))), array (RLC_EMPTY), false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_twist_prevention', 'ext_reindex', 'ext_images'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'keywords_generate', RLT_ENUM, 'KEYW_GEN', 'auto');
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, false, false);

    $vMod->finishModule();
}

// } [ami_votes|votes]
// [ami_ext|ce_page_break] {

// } [ami_ext|ce_page_break]
// [ami_subscribe|subscribe] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){

    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    $vMod->TTlTTIl($vModName."_rules_values.lng");

    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "topics", RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "allow_unregistered", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "topics_in_list", RLT_UINT, array("min"=>1), 10);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "export_delimiter", RLT_ENUM, array(",", ";"), ",");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "export_filename", RLT_CHAR, RLC_NONE, "subscribers.csv");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "fast_signup", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "send_registration_email", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    // {{{ twist prevention extension options
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_twist_prevention", RLT_BOOL, RLC_NONE, true, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);
    // }}}
    $vMod->finishModule();
}

// } [ami_subscribe|subscribe]
// [ami_subscribe|topic|topic] {

$vModName = '##modId##';
    if($GLOBALS["Core"]->IsInstalled($vModName)){

        $vMod = &$oCoreRules->addModule($vModName);
        $vMod->TTlTTII($vModName."_rules_captions.lng");

        $vMod->removeRules();

        $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, array("min"=>1), $oCoreRules->Core->GetOption("default_page_size"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "manual_price", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "name_length", RLT_UINT, array("min"=>1), 50, false, array("spec_module_body"));

        $vMod->finishModule();
    }

// } [ami_subscribe|topic|topic]
// [ami_subscribe|send|send] {

$vModName = '##modId##';
    if($GLOBALS["Core"]->IsInstalled($vModName)){
        $vMod = &$oCoreRules->addModule($vModName);
        $vMod->TTlTTII($vModName."_rules_captions.lng");
        $vMod->TTlTTIl($vModName."_rules_values.lng");

        $vMod->removeRules();

        $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, array("min"=>1), $oCoreRules->Core->GetOption("default_page_size"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "send_only_active", RLT_ENUM, array(true, false), false);
        $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "attempts", RLT_UINT, array("min"=>1), 2);
        $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "max_subs_direct", RLT_UINT, array("min"=>1), 50);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "from_mbox", RLT_CHAR, RLC_NONE, "info");

        $vMod->finishModule();
    }

// } [ami_subscribe|send|send]
// [ami_subscribe|export|export] {

$vModName = '##modId##';
if($GLOBALS['Core']->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    // $vMod->initSpecialCaptions($vModName."_rules_values.lng");

    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'autoexport_enabled', RLT_BOOL, RLC_NONE, FALSE, TRUE);

    $vMod->finishModule();
}

// } [ami_subscribe|export|export]
// [ami_search|search] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    $vMod->TTlTTIl($vModName."_rules_values.lng");

    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, RLC_NONE, 10);
//        $vMod->SetOption( "relevance",                  10, 5, 1);
//        $vMod->SetOption( "relevance_by_entries",       false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "min_len", RLT_UINT, RLC_NONE, 3);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("id", "name"), "date_start", false);
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_dim", RLT_ENUM, array("asc", "desc"), "asc", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "advanced_search_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array ('all'), false, array("spec_module_body", "spec_small_search"), "##modId##:GetSearchPagesCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'is_advanced_search', RLT_BOOL, RLC_NONE, false, false, array("spec_module_body", "spec_small_search"));

//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, false);

    $vMod->finishModule();
}

// } [ami_search|search]
// [ami_search|search|reindex] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . '_rules_captions.lng');
    $vMod->TTlTTIl($vModName . '_rules_values.lng');
    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'allow_runtime_indexing', RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_full_announce', RLT_BOOL, RLC_NONE, FALSE, FALSE);
    $vMod->finishModule();
}

// } [ami_search|search|reindex]
// [ami_feedback|feedback] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){

    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . '_rules_captions.lng');
    $vMod->TTlTTIl($vModName . '_rules_values.lng');

    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "email_to", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "enabled_fields", RLT_ENUM_MULTI_ARRAY,
        array("firstname", "lastname", "birthdate", "email", "phone", 'fax', 'title', "address1", "address2", "web", "city", "country", "info", 'company'),
        array("firstname", "lastname", "email", "phone", "address1", "address2", "city", "country", "info"),
        false, array("spec_module_body")
    );
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "required_fields", RLT_ENUM_MULTI_ARRAY, array("firstname", "lastname", "birthdate", "email", "phone", 'title', "address1", "address2", "web", "city", "country", "info", 'company'),
                                                                       array("firstname", "lastname", "email", "info"), false, array("spec_module_body"));

//    $vMod->SetOption("custom_fields", array());
//    $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "email_subject", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "form_template", RLT_ENUM, RLC_CALLBACK, "feedback_mail.tpl", false, array("spec_module_body"), "modules_templates:GetCustomLetterTemplates");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "feedback_text_mode_html", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "feedback_copy_send", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_twist_prevention", RLC_EMPTY))), array("ext_twist_prevention", RLC_EMPTY), false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array('ext_twist_prevention'), false, false, 'common_settings:ruleExtensionsCB', array('ext_twist_prevention'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
/*
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));
*/

    // {{{ twist prevention extension options
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);
    // }}}
    $vMod->finishModule();
}

// } [ami_feedback|feedback]
// [ami_datasets|datasets] {

// } [ami_datasets|datasets]
// [ami_datasets|custom_fields] {

$vModName  = '##modId##';
if($GLOBALS['Core']->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . '_rules_captions.lng');
    $vMod->TTlTTIl($vModName . '_rules_values.lng');
    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'admin_form', RLT_ENUM, array('none', 'top', 'tab', 'bottom'), 'top');
    $vMod->finishModule();
}

// } [ami_datasets|custom_fields]
// [ami_ext|custom_fields] {

// } [ami_ext|custom_fields]
// [ami_multifeeds5|classifieds] {

$vModName  = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)) {
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . '_rules_captions.lng');
    $vMod->TTlTTIl(array (
        $vMod->IlllLL1 . $vModName . '_rules_values.lng',
        $GLOBALS['LOCAL_FILES_REL_PATH'] . '_admin/templates/lang/options/' . $vModName . '_rules_values.lng'
    ));

    $vMod->removeRules(array ('page_size_small', 'page_sort_col_small', 'page_sort_dim_small'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("date_start", "header", "position"), "date_start", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_stat_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_place_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, false);
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_twist_prevention", "ext_rss", 'ext_reindex', 'ext_images', 'ext_modules_custom_fields', RLC_EMPTY))), array("ext_twist_prevention", RLC_EMPTY), false, array());
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array('ext_twist_prevention'), false, false, 'common_settings:ruleExtensionsCB', array('ext_twist_prevention', 'ext_rss', 'ext_reindex', 'ext_images', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'custom_fields', RLT_ENUM_MULTI_ARRAY, array (1, 2, 3, 4, 5, 6, 7, 8, 9, RLC_EMPTY), array (array (1, 2, RLC_EMPTY)), false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_allow_to_add', RLT_BOOL, RLC_NONE, true, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_allow_to_add_registered_only', RLT_BOOL, RLC_NONE, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_add_as_published', RLT_BOOL, RLC_NONE, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'display_inactive_by_direct_link', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_allow_attach', RLT_BOOL, RLC_NONE, true, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'max_upload_size', RLT_UINT, array('min' => 1024, 'max' => $GLOBALS['Core']->GetOption('max_upload_size')), RLC_NONE, min(1048576, $GLOBALS['Core']->GetOption('max_upload_size')), array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_allow_attach_images', RLT_BOOL, RLC_NONE, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'default_life_time', RLT_DATE_PERIOD_POSITIVE, RLC_NONE, '1 month', false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'autodeletion_period', RLT_DATE_PERIOD_POSITIVE, RLC_NONE, '0 second', false, array ('spec_module_body'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_notification', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'noticiation_email', RLT_EMAIL, RLC_NONE, $GLOBALS['COMPANY_EMAIL'], false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'from_mbox', RLT_CHAR, RLC_NONE, 'info', false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_on_submission', RLT_BOOL, RLC_NONE, true, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_author_when_published', RLT_BOOL, RLC_NONE, true, array ('spec_module_body'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "item_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture"), false, array("spec_module_body", "spec_small_classifieds"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "col_picture_type", RLT_ENUM, array("none", "picture", "popup_picture", "small_picture"), Array("none"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "prior_source_picture", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("popup_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxwidth", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxheight", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxwidth", RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxheight", RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxwidth", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxheight", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_bigger_image", RLT_BOOL, RLC_NONE, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_filtered", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_cols", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_sections", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "classifieds:correctStopArgNames");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_col", RLT_ENUM, array("date_start", "header", "position"), "date_start", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_SINT, array('min' => 1), 1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_specblock", RLT_SPLITTER, RLC_NONE, false, true);

    if($oDeclarator->getAttr('##modId##', 'core_v5')){
        $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "small_view_mode", RLT_ENUM, TlIIII1($vModName), "usual", false, array("spec_small_classifieds"));
    }
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_number_items", RLT_UINT, RLC_NONE, 4, false, array("spec_small_classifieds"));
    // List of categories id, from which the items will be shown
    //(0 - first N categories, which is specified in an option "small_number_categories").
    $vMod->addRule(
        CMS_CoreRules::RLR_ROOT,
        CMS_CoreRules::VIEW_MODE_NOVICE,
        'small_number_categories',
        RLT_ENUM_WITH_UINT,
        array('enum' => array('0', 1), 'enum_only' => array('0'), 'result_type' => 'simple'),
        0,
        FALSE,
        array('spec_small_##modId##')
    );
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_category_ids",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, 0, false, array("spec_small_classifieds"), "classifieds_cat:getOptionsModCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_col", RLT_ENUM, array("name", "position"), "name", false, array("spec_small_classifieds"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_classifieds"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date_start", "header", "position"), "date_start", false, array("spec_small_classifieds"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "desc", false, array("spec_small_classifieds"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_small_".$vModName));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_classifieds"), "modules_templates:GetCustomModuleTemplatesWithPath");
    if(
        $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories') &&
        !$oDeclarator->getAttr($vModName, 'core_v5')
    ){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(-1), false, array('spec_small_##modId##'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_##modId##"), "common_settings:rulePageIdsCB");
    }


//    $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);


    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_adv", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_list", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_classifieds"), "adv_places:getOptionsPlacesCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_details", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_classifieds"), "adv_places:getOptionsPlacesCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_sb", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_classifieds"), "adv_places:getOptionsPlacesCB");

    //--  RSS extension for CLASSIFIEDS
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_rss_extension", RLT_SPLITTER, RLC_NONE, false, true, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_num_elements", RLT_UINT, array("min"=>1), 10, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_page", RLT_ENUM_MULTI_ARRAY, array("rss_generate", "rss_autolink"), array("rss_generate"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_image", RLT_ENUM, array("rss_xmlimage", "rss_rss20image", "rss_rssimage"),  array("rss_rss20image"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_title", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_description", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_image", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssImage");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_style", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssStyle");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_webmaster", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_title", RLT_ENUM, array("rss_header", "rss_announce"), array("rss_header"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_description", RLT_ENUM, array("rss_announce", "rss_header"), array("rss_announce"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_enclosure", RLT_ENUM, array("rss_small_image", "rss_image", "rss_popup_image", "none"), array("rss_small_image"), false, array("spec_module_body"));// = field from
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_guid", RLT_ENUM, array("rss_link", "none"), array("none"), false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_pubdate", RLT_ENUM, array("rss_m_date", "rss_c_date", "none"), array("rss_c_date"), false, array("spec_module_body"));// = field
    //-- end RSS

    $vMod->finishModule();
}

// } [ami_multifeeds5|classifieds]
// [ami_multifeeds5|classifieds|cat] {

    $vModName  = '##modId##';
    if($GLOBALS["Core"]->IsInstalled($vModName)) {

        $vMod = &$oCoreRules->addModule($vModName);
        $vMod->TTlTTII($vModName."_rules_captions.lng");

        $vMod->removeRules( array( "page_size_small", "page_sort_col_small", "page_sort_dim_small", "cols") );

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_counters", RLT_BOOL, RLC_NONE, false, false, array ("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("name", "position"),   "name", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_empty_cats", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array('ext_reindex', 'ext_images', 'ext_modules_custom_fields', RLC_EMPTY))), array(RLC_EMPTY), false, array());
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_reindex', 'ext_images', 'ext_modules_custom_fields'));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_stat_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_place_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "item_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"), false, array("spec_module_body", "spec_small_classifieds"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "col_picture_type", RLT_ENUM, array("none", "picture", "popup_picture", "small_picture"), Array("none"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "prior_source_picture", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("popup_picture"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxwidth", RLT_UINT, array("min"=>1), 300);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxheight", RLT_UINT, array("min"=>1), 300);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxwidth", RLT_UINT, array("min"=>1), 800);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxheight", RLT_UINT, array("min"=>1), 600);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxwidth", RLT_UINT, array("min"=>1), 80);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxheight", RLT_UINT, array("min"=>1), 80);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_bigger_image", RLT_BOOL, RLC_NONE, true);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_seo_settings", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);

        $vMod->finishModule();
    }

// } [ami_multifeeds5|classifieds|cat]
// [ami_login_history|login_history] {

// } [ami_login_history|login_history]
// [ami_tags|tags] {

$vModName  = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)) {

    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    $vMod->TTlTTIl($vModName."_rules_values.lng");

//        $vMod->removeRules(array("front_page_sort_col"));

    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, array("min"=>1), 200, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, Array("tag", "count"), "tag", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_dim", RLT_ENUM, array("asc", "desc"), "asc", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col_result", RLT_ENUM, Array("date_modified", "name"), "name", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_dim_result", RLT_ENUM, array("asc", "desc"), "asc", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size_result", RLT_UINT, array("min"=>1), 10, false, array("spec_module_body"));


    //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, array("min"=>1), 10, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_browse_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "tags_presense_number", RLT_ENUM, array("lev3", "lev4", "lev5", "lev6", "lev7", "lev8", "lev9", "lev10"), "lev5", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_col", RLT_ENUM, Array("tag", "count"), "tag", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_dim", RLT_ENUM, array("asc", "desc"), "asc", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_seo_settings", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'set_404_header', RLT_BOOL, RLC_NONE, 1);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_specblock", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_col_small", RLT_ENUM, Array("tag", "count"), "tag", false, array("spec_module_body", "spec_small_tags"));
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_dim_small", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_module_body", "spec_small_tags"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size_small", RLT_UINT, array("min"=>1), 30, false, array("spec_module_body", "spec_small_tags"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_small_tags"));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_tags"), "modules_templates:GetCustomModuleTemplatesWithPath");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_view_type", RLT_ENUM, Array("cloud", "list"), "cloud", false, array("spec_module_body", "spec_small_tags"));

    //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_number_tags", RLT_UINT, RLC_NONE, 10, false, array("spec_small_tags"));

    $vMod->finishModule();
}

// } [ami_tags|tags]
// [ami_tags|tags|reindex] {

// } [ami_tags|tags|reindex]
// [ami_page_manager|layouts] {

$vModName  = '##modId##';
if($GLOBALS['Core']->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . '_rules_captions.lng');
    $vMod->removeRules();

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mobile_layout_id', RLT_UINT, RLC_NONE, 0, false);
    // Cache starts before modules declaration, we need the callback to store mobile_layout_id option to cache options
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mobile_layout_id', RLT_UINT, RLC_CALLBACK, 0, false, false, "common_settings:ruleMobileLayoutIdCB");

    $vMod->finishModule();
}

// } [ami_page_manager|layouts]
// [ami_clean|templates] {

// } [ami_clean|templates]
// [ami_modules_templates|templates] {

$vModName = "##modId##";
if($GLOBALS["Core"]->IsInstalled($vModName)) {
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    $vMod->TTlTTIl($vModName."_rules_values.lng");

    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_col", RLT_ENUM, Array("path", "name", "module", "modified"), "modified");
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE,  "page_sort_dim", RLT_ENUM, array("asc", "desc"), "desc");
    $vMod->finishModule();
}

// } [ami_modules_templates|templates]
// [ami_modules_templates|langs] {

$vModName = "##modId##";
if($GLOBALS["Core"]->IsInstalled($vModName)) {
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    $vMod->TTlTTIl($vModName."_rules_values.lng");

    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_col", RLT_ENUM, Array("path", "name", "module", "modified"), "modified");
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE,  "page_sort_dim", RLT_ENUM, array("asc", "desc"), "desc");
    $vMod->finishModule();
}

// } [ami_modules_templates|langs]
// [ami_fake|google_sitemap] {

$vModName = "##modId##";
if($GLOBALS["Core"]->IsInstalled($vModName)) {

    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    $vMod->TTlTTIl($vModName."_rules_values.lng");

    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sitemap_ping_google", RLT_ENUM, Array("daily", "weekly", "monthly"), "weekly");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sitemap_modules", RLT_ARRAY_OF,
        array('items_type'=>RLT_ENUM, "items_values"=>array(0, 5, 6, 7, 8, 9, 10), "default_value"=>array(5), "remove_disabled"=>array(), "adding_allow"=>0), array(5));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sitemap_changefreq", RLT_ARRAY_OF,
        array('items_type'=>RLT_ENUM, "items_values"=>array(1, 7, 30, 365, 0), "default_value"=>array(7), "remove_disabled"=>array(), "adding_allow"=>0), array(7));

    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "sitemap_auto_update", RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sitemap_auto_update_pages", RLT_UINT, array("min"=>10), 10);
    //$vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "sitemap_compress", RLT_BOOL, RLC_NONE, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'autodeletion_period', RLT_DATE_PERIOD_POSITIVE, RLC_NONE, '1 month', false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sitemaps_disabled",  RLT_BOOL, RLC_CALLBACK, false, false, array(), "google_sitemap:disableSitemaps");

    $vMod->finishModule();
}

// } [ami_fake|google_sitemap]
// [ami_discussion|discussion] {

$vModName = "##modId##";
if ($GLOBALS['Core']->IsInstalled($vModName)) {
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_reindex', 'ext_user_rating'));
    $vMod->finishModule();
}

// } [ami_discussion|discussion]
// [ami_discussion|guestbook] {

$vModName = "##modId##";
if($GLOBALS['Core']->IsInstalled($vModName)) {
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . '_rules_captions.lng');
    $vMod->TTlTTIl($vModName . '_rules_values.lng');

    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_common', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_page_sort_col', RLT_ENUM, array ('date', 'subject', 'author'), 'date', false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_page_sort_dim', RLT_ENUM, array ('asc', 'desc'), 'desc', false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'page_size', RLT_UINT, RLC_NONE, 10);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'messages_pages', RLT_UINT, array ('min' => 1), 5, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'add_messages_by_registered_only', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'updatable_period', RLT_DATE_PERIOD_POSITIVE, RLC_NONE, '6 hour', false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'noindex_external_links', RLT_BOOL, RLC_NONE, true, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'sys_user_as_administration', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_images', RLT_ENUM_MULTI_ARRAY, array (RLC_EMPTY, 'registered_users_only', 'internal_links', 'external_links'), array ('registered_users_only', 'internal_links', 'external_links'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'force_publish', RLT_ENUM, array (true, false), true, false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'use_tree_view', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array('ext_twist_prevention', 'ext_reindex', RLC_EMPTY))), array(RLC_EMPTY), false, array ());
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_twist_prevention', 'ext_reindex'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_notification', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_webmaster_email', RLT_EMAIL, RLC_NONE, $GLOBALS['COMPANY_EMAIL'], false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'from_mbox', RLT_CHAR, RLC_NONE, 'info');

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

    $vMod->finishModule();
}

// } [ami_discussion|guestbook]
// [ami_forum|forum] {

$vModName = "##modId##";
if ($GLOBALS['Core']->IsInstalled($vModName)) {
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . '_rules_captions.lng');
    $vMod->TTlTTIl($vModName . '_rules_values.lng');
    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_common', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'page_size', RLT_UINT, RLC_NONE, 10);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_page_sort_col', RLT_ENUM, array('msg_date', 'date', 'topic'), 'msg_date', false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_page_sort_dim', RLT_ENUM, array('asc', 'desc'), 'desc', false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'messages_per_page', RLT_UINT, array ('min' => 1), 20, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'messages_dim', RLT_ENUM, array('asc', 'desc'), 'asc', false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'messages_pages', RLT_UINT, array ('min' => 1), 5, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'topic_tool_tip_length', RLT_UINT, array ('min' => 1), 200, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'add_topics_by_registered_only', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'add_messages_by_registered_only', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'publish_from_not_athorized', RLT_BOOL, RLC_NONE, FALSE, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'publish_from_athorized', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'updatable_period', RLT_DATE_PERIOD_POSITIVE, RLC_NONE, '6 hour', false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'noindex_external_links', RLT_BOOL, RLC_NONE, true, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'sys_user_as_administration', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array ('ext_twist_prevention', 'ext_rss', 'ext_reindex', RLC_EMPTY))), array('ext_twist_prevention'), false, array());
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array('ext_twist_prevention'), false, false, 'common_settings:ruleExtensionsCB', array('ext_twist_prevention', 'ext_rss', 'ext_reindex', 'ext_user_rating'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'cache_expire_force', RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array ('enum' => array('', 1), 'enum_only' => array(''), 'result_type' => 'simple'), '');
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "forum:correctStopArgNames");

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10);


//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_specblock", RLT_SPLITTER, RLC_NONE, false, true);
//
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_number_items", RLT_UINT, RLC_NONE, 4, false, array("spec_small_forum"));
//            // List of categories id, from which the items will be shown
//            //(0 - first N categories, which is specified in an option "small_number_categories").
////    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_category_ids",          0);
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_number_categories",  RLT_UINT, RLC_NONE, 0, false, array("spec_small_forum"));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_category_ids",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, 0, false, array("spec_small_forum"), "forum_cat:getOptionsModCB");
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_col", RLT_ENUM, array("name", "position"), "position", false, array("spec_small_forum"));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_forum"));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date", "question", "position"), "date", false, array("spec_small_forum"));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_forum"));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_CHAR, RLC_NONE, "", false, array("spec_small_forum"));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_articles"), "common_settings:rulePageIdsCB");

//    $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_pictures_params', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'avatar_maxwidth', RLT_UINT, array('min' => 1), 64);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'avatar_maxheight', RLT_UINT, array('min' => 1), 64);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'front_images', RLT_ENUM_MULTI_ARRAY, array (RLC_EMPTY, 'registered_users_only', 'internal_links', 'external_links'), array ('registered_users_only', 'internal_links', 'external_links'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_notification', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_topic', RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_admin_email', RLT_EMAIL, RLC_NONE, $GLOBALS['COMPANY_EMAIL'], false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'from_mbox', RLT_CHAR, RLC_NONE, 'info');

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_twist_prevention', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'action_period', RLT_DATE_PERIOD_POSITIVE, RLC_NONE, '5 second', false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_captcha', RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'js_checking', RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'generate_twist_action', RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_alert', RLT_BOOL, RLC_NONE, true, true);

    //--  RSS extension for FORUM
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_rss_extension", RLT_SPLITTER, RLC_NONE, false, true, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_num_elements", RLT_UINT, array("min"=>1), 10, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'rss_elements_period', RLT_DATE_PERIOD_POSITIVE, RLC_NONE, '1 week', false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_page", RLT_ENUM_MULTI_ARRAY, array("rss_generate", "rss_autolink"), array("rss_generate"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_image", RLT_ENUM, array("rss_xmlimage", "rss_rss20image", "rss_rssimage"),  array("rss_rss20image"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_title", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_description", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_image", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssImage");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_style", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssStyle");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_webmaster", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_title", RLT_ENUM, array("rss_header", "rss_announce"), array("rss_topic"), false, array("spec_module_body"));// = field
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_description", RLT_ENUM, array("rss_announce", "rss_header"), array("rss_message"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_enclosure", RLT_ENUM, array("rss_small_image", "rss_image", "rss_popup_image", "none"), array("rss_small_image"), false, array("spec_module_body"));// = field from
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_guid", RLT_ENUM, array("rss_link", "none"), array("none"), false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_pubdate", RLT_ENUM, array("rss_m_date", "rss_c_date", "none"), array("rss_c_date"), false, array("spec_module_body"));// = field
    //-- end RSS

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'keywords_generate',  RLT_ENUM, 'KEYW_GEN', 'auto');
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  'html_title_splitter', RLT_CHAR, RLC_NONE, '');
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  'html_title_template', RLT_CHAR, RLC_NONE, '');
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_specblock', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, 'page_size_small', RLT_UINT, array ('min' => 1), 5, false, array ('spec_small_forum'));
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, 'page_sort_dim_small', RLT_ENUM, array ('asc', 'desc'), 'desc', false, array ('spec_small_forum'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'small_display_message', RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'small_topic_length', RLT_UINT, array ('min' => 3, 'max' => 0xFFFF), 100, false, array ('spec_small_forum'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'small_message_length', RLT_UINT, array ('min' => 3, 'max' => 0xFFFF), 250, false, array ('spec_small_forum'));
###        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'small_cache_expire', RLT_DATE_PERIOD_POSITIVE, RLC_NONE, '1 hour');
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_forum"), "modules_templates:GetCustomModuleTemplatesWithPath");

    $vMod->finishModule();
}

// } [ami_forum|forum]
// [ami_forum|forum|cat] {

$vModName = "##modId##";
if($GLOBALS["Core"]->IsInstalled($vModName)) {
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'page_size', RLT_UINT, RLC_NONE, 10);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_counters", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "front_page_sort_col", RLT_ENUM, array("name", "position"),   "name", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_empty_cats", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, false);

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array('ext_reindex', RLC_EMPTY))), array(RLC_EMPTY), false, array());
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_reindex'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'topic_len_in_cats', RLT_UINT, array ('min' => 10), 30);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);

//    $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);

    $vMod->finishModule();
}

// } [ami_forum|forum|cat]
// [ami_data_exchange|forum] {

$vModName = "##modId##";
if ($GLOBALS['Core']->IsInstalled($vModName)) {
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . '_rules_captions.lng');
    $vMod->removeRules();
    $vMod->finishModule();
}

// } [ami_data_exchange|forum]
// [ami_eshop_discounts|discounts] {

$vModName  = "##modId##";
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    $vMod->TTlTTIl($vModName."_rules_values.lng");
    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "discounts_syncopation", RLT_ENUM, array("discounts_sum", "max_discount"), "max_discount");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "products_discounts_syncopation", RLT_ENUM, array("products_discount", "sum_of_calculated_and_products_discount", "max_of_products_and_calculated_discount"), "max_of_products_and_calculated_discount");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "order_details_discount_view", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "column", "row"), array ("column", "row"), false);
    $vMod->finishModule();
}

// } [ami_eshop_discounts|discounts]
// [ami_eshop_coupons|coupons] {

$vModName  = "##modId##";
if($GLOBALS['Core']->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . '_rules_captions.lng');
    $vMod->TTlTTIl($vModName . '_rules_values.lng');
    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'time_limited', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'default_number_of_activations', RLT_ENUM_WITH_SINT, array ('enum' => array('0', 1), 'enum_only' => array('0'), 'result_type' => 'simple'), 0);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'id_creation_type', RLT_ENUM, array ('sequent_numbers', 'digits', 'letters', 'digits_letters'), 'digits');
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'id_length', RLT_UINT, array ('min' => 8, 'max' => 64), 16);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'id_splitter', RLT_CHAR, RLC_NONE, '-');
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'id_splitter_period', RLT_UINT, array ('min' => 0), 4);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'number_of_coupons', RLT_UINT, array ('min' => 1), 100);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'owners_list_size', RLT_UINT, array ('min' => 1), 50);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'generate_id_external', RLT_BOOL, RLC_NONE, true);
    $vMod->finishModule();
}

// } [ami_eshop_coupons|coupons]
// [ami_eshop_coupons|coupons|cat] {

$vModName  = "##modId##";
if($GLOBALS['Core']->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . '_rules_captions.lng');
    $vMod->TTlTTIl($vModName . '_rules_values.lng');
    $vMod->removeRules();
    $vMod->finishModule();
}

// } [ami_eshop_coupons|coupons|cat]
// [ami_eshop_shipping|methods] {

$vModName  = "##modId##";
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . "_rules_captions.lng");
    $vMod->TTlTTIl(array (
    $vMod->IlllLL1 . $vModName . "_rules_values.lng",
    $GLOBALS["LOCAL_FILES_REL_PATH"] . "_admin/templates/lang/options/" . $vModName . "_rules_values.lng"
    ));
    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_shipping_module", RLT_BOOL, RLC_NONE, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "shipping_conflicts", RLT_ENUM, array("show_intersection", "show_shipping_for_each_type"), array("show_intersection"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "on_intersection_emptiness", RLT_ENUM, array("ask_to_change_order", "use_each_shipping_type_mode"), array("ask_to_change_order"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_col", RLT_ENUM, array("position", "name"), array("postition"));
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_dim", RLT_ENUM, array("asc", "desc"), "asc");
    //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "fieldsets", RLT_ENUM_MULTI_ARRAY, array("custom_shipping_00", "custom_shipping_01", "custom_shipping_02", "custom_shipping_03", "custom_shipping_04", "custom_shipping_05", 'custom_shipping_09'), array("custom_shipping_00", "custom_shipping_01", "custom_shipping_02", "custom_shipping_03", "custom_shipping_04", "custom_shipping_05", "custom_shipping_09"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,"fieldsets_options",RLT_ARRAY_OF,
    array('items_type'=>RLT_ENUM_MULTI_STRING, "items_values"=>array("fieldsets_options_01" , "fieldsets_options_06", "fieldsets_options_07", "fieldsets_options_08"), "default_value"=>array("fieldsets_options_01"), "remove_disabled"=>array(0, 1), "adding_allow"=>0),
    array("fieldsets_options_01"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "available_shipping_fields", RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array('rest', 'weight', 'size'), false, false, '##modId##:ruleAvailableShippingFields');
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'range_field', RLT_ENUM, RLC_CALLBACK, -1, false, array(), 'eshop_datasets:getOptionsModTableFieldsCB');
    $vMod->Captions['use_yandex_fast_order'] = $vMod->getCaption('use_yandex_fast_order').sprintf($vMod->getCaption('use_yandex_fast_order_hint'), $GLOBALS['ROOT_PATH_WWW'].'ami_service.php?service=yandex_fast_order&action=set_address');
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_yandex_fast_order", RLT_BOOL, RLC_NONE, false);

    $vMod->finishModule();
}

// } [ami_eshop_shipping|methods]
// [ami_eshop_shipping|types] {

// } [ami_eshop_shipping|types]
// [ami_eshop_shipping|fields] {

// } [ami_eshop_shipping|fields]
// [ami_eshop_tax|classes] {

$vModName  = "##modId##";
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName."_rules_captions.lng");
    $vMod->TTlTTIl($vModName."_rules_values.lng");
    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "tax_system", RLT_ENUM, Array("ru", "us"), $GLOBALS["lang_data"] == 'ru' ? Array("ru") : Array("us"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "tax_scheme", RLT_ENUM, array("sum", "no"), "sum");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "charge_tax_type", RLT_ENUM, array("charge", "detach", "none"), "detach");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "shipping_tax", RLT_FLOAT, array("min"=>0), 0);
    $vMod->finishModule();
}

// } [ami_eshop_tax|classes]
// [ami_eshop_tax|zones] {

$vModName  = "##modId##";
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $oMod = $oDeclarator->getModule('##modId##');
    $oMod->finalize();
}

// } [ami_eshop_tax|zones]
// [ami_clean|ami_seopult] {

$vModName  = '##modId##';
if($GLOBALS['Core']->IsInstalled($vModName)){
    $oMod = $oDeclarator->getModule('##modId##');
    $oMod->finalize();
}

// } [ami_clean|ami_seopult]
// [ami_ext|rss] {

$vModName  = '##modId##';
if($GLOBALS['Core']->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . '_rules_captions.lng');
    $vMod->TTlTTIl($vModName . '_rules_values.lng');
    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_num_elements", RLT_UINT, array("min"=>1), 10);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_page", RLT_ENUM_MULTI_ARRAY, array("rss_generate", "rss_autolink"), array("rss_generate"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_image", RLT_ENUM, array('rss_rssfeedimage', "rss_xmlimage", "rss_rss20image", "rss_rssimage"), array("rss_rss20image"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_image", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssImage");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_style", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssStyle");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_webmaster", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_copyright", RLT_CHAR, RLC_NONE, ""); // rule only to rss
    $vMod->finishModule();
}

// } [ami_ext|rss]
// [ami_async|private_messages] {

$vModName  = '##modId##';
if($GLOBALS['Core']->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->TTlTTII($vModName . '_rules_captions.lng');
    // $vMod->initSpecialCaptions($vModName . '_rules_values.lng');
    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_by_email', RLT_BOOL, RLC_NONE, FALSE);
    $vMod->finishModule();
}

// } [ami_async|private_messages]
// [ami_clean|ami_market] {

$vModName  = '##modId##';
if($GLOBALS['Core']->IsInstalled($vModName)){
    $oMod = $oDeclarator->getModule('##modId##');
    $oMod->finalize();
    $oMod = $oDeclarator->getModule('mod_manager');
    $oMod->finalize();
}

// } [ami_clean|ami_market]
// [ami_multifeeds5|articles] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $useCats = $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories');

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'rule_test', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false,'##modId##:ruleTest', array('r1', 'r2', 'r3'));

    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->removeRules( array("page_size_small", "page_sort_col_small", "page_sort_dim_small") );

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'page_sort_col', RLT_ENUM, array('date', 'header', 'position', 'votes_count', 'votes_rate'), 'date');
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("date", "header", "position", "votes_count", "votes_rate"), "date", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_stat_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_place_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, false);
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_twist_prevention", "ext_discussion", "ext_rating", "ext_audit", "ext_rss", "ce_page_break", 'ext_reindex', "ext_tags", 'ext_relations', 'ext_images', 'ext_modules_custom_fields',  RLC_EMPTY))), array(RLC_EMPTY), false, array());

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array('ext_twist_prevention', 'ext_rss', 'ext_reindex'), false, false, '##modId##:ruleExtensionsCB', array('ext_twist_prevention', 'ext_discussion', 'ext_rating', 'ext_audit', 'ext_rss', 'ce_page_break', 'ext_reindex', 'ext_tags', 'ext_relations', 'ext_images', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'hide_future_items', RLT_BOOL, RLC_NONE, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "item_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"), false, array("spec_module_body", "spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "col_picture_type", RLT_ENUM, array("none", "picture", "popup_picture", "small_picture"), Array("none"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "prior_source_picture", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("popup_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxwidth", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxheight", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxwidth", RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxheight", RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxwidth", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxheight", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_bigger_image", RLT_BOOL, RLC_NONE, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "add_date_prefix", RLT_BOOL, RLC_NONE, false, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_filtered", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_cols", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    // #CMS-11173: $GLOBALS['Core']->IsInstalled('articles') check is added
    if('free' !== AMI::getEdition()){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "##modId##:correctStopArgNames");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10);
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_ext_discussion", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_replies", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_topics", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_list", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_small", RLT_BOOL, RLC_NONE, false, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_at_details", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_pager_page_number_as_bound', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_webmaster_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'use_tree_view', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_anonymous_user_email", RLT_EMAIL, RLC_NONE, "anonymous@localhost.ru");
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_attaches_allowed", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_only_one_level", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_multi_topics", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_pager_type", RLT_ENUM, array("items", "topics"), "items");

    // #CMS-11173: $GLOBALS['Core']->IsInstalled('articles') check is added
    if(($useCats && $GLOBALS['Core']->IsInstalled('articles')) || TRUE){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_col", RLT_ENUM, array("date", "header", "position"), "date", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_SINT, array('min' => 1), 1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_specblock', RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "small_view_mode", RLT_ENUM, TlIIII1($vModName), "usual", false, array("spec_small_##modId##"));
    $vMod->addRule(
        CMS_CoreRules::RLR_ROOT,
        CMS_CoreRules::VIEW_MODE_NOVICE,
        'small_number_items',
        RLT_UINT,
        RLC_NONE,
        4,
        false,
        array('spec_small_##modId##')
    );
    $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
    $vMod->Captions['small_number_items'] = $aCaptions['small_number_items'] . $aCaptions['small_number_items_50'];
    unset($aCaptions);

    // List of categories id, from which the items will be shown
    //(0 - first N categories, which is specified in an option "small_number_categories").
    $vMod->addRule(
        CMS_CoreRules::RLR_ROOT,
        CMS_CoreRules::VIEW_MODE_NOVICE,
        'small_number_categories',
        RLT_ENUM_WITH_UINT,
        array('enum' => array('0', 1), 'enum_only' => array('0'), 'result_type' => 'simple'),
        0,
        FALSE,
        array('spec_small_##modId##')
    );

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");

#    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_category_ids",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, 0, false, array("spec_small_##modId##"), "##modId##_cat:getOptionsModCB");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_col", RLT_ENUM, array("name", "position"), "name", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date", "header", "position", "votes_rate"), "date", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "desc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_small_".$vModName));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_##modId##"), "modules_templates:GetCustomModuleTemplatesWithPath");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_##modId##"), "common_settings:rulePageIdsCB");
    // $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
    // $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_adv", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_list", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_details", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_sb", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        //--  Audit extension for ARTICLES
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
            array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)),
            array("visible", "visible"));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_author", "field_source", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
            array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
            array("not_publish", "not_publish", "not_publish"));
    }

    //--  RSS extension for ARTICLES
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_rss_extension", RLT_SPLITTER, RLC_NONE, false, true, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_num_elements", RLT_UINT, array("min"=>1), 10, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_page", RLT_ENUM_MULTI_ARRAY, array("rss_generate", "rss_autolink"), array("rss_generate"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_image", RLT_ENUM, array("rss_xmlimage", "rss_rss20image", "rss_rssimage"),  array("rss_rss20image"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_title", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_description", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_image", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssImage");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_style", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssStyle");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_webmaster", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_title", RLT_ENUM, array("rss_header", "rss_announce"), array("rss_header"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_description", RLT_ENUM, array("rss_announce", "rss_header"), array("rss_announce"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_enclosure", RLT_ENUM, array("rss_small_image", "rss_image", "rss_popup_image", "none"), array("rss_small_image"), false, array("spec_module_body"));// = field from
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_guid", RLT_ENUM, array("rss_link", "none"), array("none"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_pubdate", RLT_ENUM, array("rss_m_date", "rss_c_date", "none"), array("rss_c_date"), false, array("spec_module_body"));// = field
    //-- end RSS

    $vMod->finishModule();
    unset($useCats);
}

// } [ami_multifeeds5|articles]
// [ami_multifeeds5|articles|cat] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);


    $vMod->removeRules( array( "page_size_small", "page_sort_col_small", "page_sort_dim_small", "cols") );

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, '##modId##:ruleExtensionsCB', array('ext_audit', 'ext_reindex', 'ext_rating', 'ext_relations', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "front_page_sort_col", RLT_ENUM, array("name", "position"),   "name", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_empty_cats", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_stat_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_place_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "item_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"), false, array("spec_module_body", "spec_small_##parentModId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "col_picture_type", RLT_ENUM, array("none", "picture", "popup_picture", "small_picture"), Array("none"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "prior_source_picture", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("popup_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxwidth", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxheight", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxwidth", RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxheight", RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxwidth", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxheight", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_bigger_image", RLT_BOOL, RLC_NONE, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);

        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
        //    array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)), // , "adding_allow"=>0
        //    array("visible", "visible"));
        //
        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
            array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
            array("not_publish", "not_publish", "not_publish"));
    }
    // $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
    // $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);    $vMod->finishModule();

    $vMod->finishModule();
}

// } [ami_multifeeds5|articles|cat]
// [ami_multifeeds5|stickers] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);

    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

     $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_specblock", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "search_field_cat", RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, -1, false, array("spec_small_stickers"),"stickers_cat:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "search_field_item", RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, -1, false, array("spec_small_stickers"),"stickers:getOptionsModColsCB");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_number_items", RLT_UINT, RLC_NONE, 4, false, array("spec_small_stickers"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "announce_mode_full", RLT_BOOL, RLC_NONE, true, false, array("spec_small_stickers"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "announce_small_length", RLT_UINT, RLC_NONE, 250, false, array("spec_small_stickers"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "header_small_length", RLT_UINT, RLC_NONE, 100, false, array("spec_small_stickers"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_small_stickers"));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_##modId##"), "modules_templates:GetCustomModuleTemplatesWithPath");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "", false, array("spec_small_stickers"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date", "position", "header", "rand"), "rand", false, array("spec_small_stickers"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_stickers"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, 'common_settings:ruleExtensionsCB', array('ext_images'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "item_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), array("picture", "popup_picture", "small_picture"), false, array("spec_small_stickers"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "col_picture_type", RLT_ENUM, array("none", "picture", "popup_picture", "small_picture"), array("none"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "prior_source_picture", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("popup_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxwidth", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxheight", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxwidth", RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxheight", RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxwidth", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxheight", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_bigger_image", RLT_BOOL, RLC_NONE, true);

    $vMod->finishModule();
}

// } [ami_multifeeds5|stickers]
// [ami_multifeeds5|stickers|cat] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_empty_cats", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));

    $vMod->finishModule();
}

// } [ami_multifeeds5|stickers|cat]
// [ami_multifeeds5|news] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $useCats = $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories');
    $isCoreV5 = $oDeclarator->getAttr($vModName, 'core_v5', FALSE);

    if(!$isCoreV5){
        $vMod->removeRules(array('page_size_small'));
    }

    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("date", "header", "position", "votes_rate"), "date", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_stat_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_place_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array('ext_twist_prevention', 'ext_rss', 'ext_reindex'), false, false, '##modId##:ruleExtensionsCB', array('ext_twist_prevention', 'ext_discussion', 'ext_rating', 'ext_audit', 'ext_rss', 'ce_page_break', 'ext_reindex', 'ext_tags', 'ext_relations', 'ext_images', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'hide_future_items', RLT_BOOL, RLC_NONE, true);
    if($useCats && !$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "item_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), array("picture", "popup_picture", "small_picture"), false, array("spec_module_body", "spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "col_picture_type", RLT_ENUM, array("none", "picture", "popup_picture", "small_picture"), array("none"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "prior_source_picture", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("popup_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxwidth", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxheight", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxwidth", RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxheight", RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxwidth", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxheight", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_bigger_image", RLT_BOOL, RLC_NONE, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "add_date_prefix", RLT_BOOL, RLC_NONE, false, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_browse", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_body_browse", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_browse_page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "browse_active_item_position", RLT_ENUM_WITH_UINT, array("enum"=>array("0", 1), "enum_only"=>array("0"), "result_type"=>"simple"), 3, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_browse_cols", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_filtered", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_cols", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    if(!$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "##modId##:correctStopArgNames");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10);
    }

    /* PM 5587
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_archive", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "archive_type", RLT_ENUM, array("manual", "date"), "manual");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "archive_period", RLT_DATE_PERIOD_NEGATIVE, RLC_NONE, "-12 month");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_type", RLT_ENUM, array("all", "active", "archive"), "all", false, array("spec_module_body"));
    */

    if($useCats && !$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_col", RLT_ENUM, array("date", "header", "position"), "date", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_SINT, array('min' => 1), 1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));
        $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
        $vMod->Captions['show_subitems'] .= $aCaptions['show_subitems_no_cat_mode'];
        unset($aCaptions);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'subitems_grp_by_cat', RLT_BOOL, RLC_NONE, TRUE, false, array('spec_module_body'));
    }
    if(!$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_total_items_limit", RLT_UINT, array("min"=>3, "max"=>1000), 30, false);
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, $isCoreV5 ? 'spl_specblock' : 'spl_specblock_60', RLT_SPLITTER, RLC_NONE, false, true);
    if($isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "small_view_mode", RLT_ENUM, TlIIII1($vModName), "usual", false, array("spec_small_##modId##"));
    }else{
        $vMod->addRule(
            CMS_CoreRules::RLR_ROOT,
            CMS_CoreRules::VIEW_MODE_NOVICE,
            'small_number_items',
            RLT_UINT,
            $isCoreV5 ? RLC_NONE : array('min' => 1),
            4,
            false,
            array('spec_small_##modId##')
        );
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_total_items_limit", RLT_UINT, array("min"=>3, "max"=>1000), 30, false, array("spec_small_##modId##"));
    }
    if($isCoreV5){
        $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
        $vMod->Captions['small_number_items'] = $aCaptions['small_number_items'] . $aCaptions['small_number_items_50'];
        unset($aCaptions);
        /*
        // List of categories id, from which the items will be shown
        //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->addRule(
            CMS_CoreRules::RLR_ROOT,
            CMS_CoreRules::VIEW_MODE_NOVICE,
            'small_number_categories',
            RLT_ENUM_WITH_UINT,
            array('enum' => array('0', 1), 'enum_only' => array('0'), 'result_type' => 'simple'),
            0,
            FALSE,
            array('spec_small_##modId##')
        );
        */
    }elseif($useCats){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'small_grp_by_cat', RLT_BOOL, RLC_NONE, false, false, array('spec_small_##modId##'));
    }
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_col_small", RLT_ENUM, array("date", "header", "position", "votes_rate"), "votes_rate", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_dim_small", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_small_".$vModName));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "announce_mode_full", RLT_BOOL, RLC_NONE, false, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "announce_small_length", RLT_UINT, array("min"=>3, "max"=>0xFFFF), 128, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "header_small_length", RLT_UINT, array("min"=>3, "max"=>255), 200, false, array("spec_small_##modId##"));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_##modId##"), "modules_templates:GetCustomModuleTemplatesWithPath");

    if($useCats && !$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(-1), false, array('spec_small_##modId##'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_##modId##"), "common_settings:rulePageIdsCB");
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_ext_discussion", RLT_SPLITTER, RLC_NONE, false, true);
    if($isCoreV5){
        // $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_body_when_forum", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    }
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_replies", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_topics", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_list", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_small", RLT_BOOL, RLC_NONE, false, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_webmaster_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'use_tree_view', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_anonymous_user_email", RLT_EMAIL, RLC_NONE, "anonymous@localhost.ru");
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_attaches_allowed", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_only_one_level", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_multi_topics", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_pager_type", RLT_ENUM, array("items", "topics"), "items");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_at_details", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_pager_page_number_as_bound', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));

    if($isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_adv", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_list", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_details", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_sb", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
    }

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
        array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)/*, "adding_allow"=>0*/),
        array("field_date"=>"visible", "field_body"=>"visible", "field_picture"=>"visible", "field_popup_picture"=>"visible", "field_small_picture"=>"visible", "field_html_title"=>"hidden"));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
        array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
        array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
    }

    //--  RSS extension for NEWS
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_rss_extension", RLT_SPLITTER, RLC_NONE, false, true, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_num_elements", RLT_UINT, array("min"=>1), 10, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_page", RLT_ENUM_MULTI_ARRAY, array("rss_generate", "rss_autolink"), array("rss_generate"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_image", RLT_ENUM, array("rss_xmlimage", "rss_rss20image", "rss_rssimage"),  array("rss_rss20image"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_title", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_description", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_image", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssImage");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_style", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssStyle");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_webmaster", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_title", RLT_ENUM, array("rss_header", "rss_announce"), array("rss_header"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_description", RLT_ENUM, array("rss_announce", "rss_header"), array("rss_announce"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_fulltext", RLT_ENUM, array("rss_body", "rss_announce", "rss_header", "none"), array("none"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_enclosure", RLT_ENUM, array("rss_small_image", "rss_image", "rss_popup_image", "none"),array("rss_small_image"), false, array("spec_module_body"));// = field from news
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_guid", RLT_ENUM, array("rss_link", "none"), array("none"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_pubdate", RLT_ENUM, array("rss_m_date", "rss_c_date", "none"), array("rss_c_date"), false, array("spec_module_body"));// = field
    //-- end RSS

//    $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);

    $vMod->finishModule();
}

// } [ami_multifeeds5|news]
// [ami_multifeeds5|blog] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $useCats = $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories');
    $isCoreV5 = $oDeclarator->getAttr($vModName, 'core_v5', FALSE);

    if(!$isCoreV5){
        $vMod->removeRules(array('page_size_small'));
    }

    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("date", "header", "position", "votes_rate"), "date", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_stat_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_place_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array('ext_twist_prevention', 'ext_rss', 'ext_reindex', 'ext_images'), false, false, '##modId##:ruleExtensionsCB', array('ext_twist_prevention', 'ext_discussion', 'ext_rating', 'ext_audit', 'ext_rss', 'ce_page_break', 'ext_reindex', 'ext_tags', 'ext_relations', 'ext_images', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'hide_future_items', RLT_BOOL, RLC_NONE, true);
    if($useCats && !$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "item_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), array("picture", "popup_picture", "small_picture"), false, array("spec_module_body", "spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "col_picture_type", RLT_ENUM, array("none", "picture", "popup_picture", "small_picture"), array("none"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "prior_source_picture", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("popup_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxwidth", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxheight", RLT_UINT, array("min"=>1), 300);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxwidth", RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxheight", RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxwidth", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxheight", RLT_UINT, array("min"=>1), 80);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_bigger_image", RLT_BOOL, RLC_NONE, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "add_date_prefix", RLT_BOOL, RLC_NONE, false, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_browse", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_body_browse", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_browse_page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "browse_active_item_position", RLT_ENUM_WITH_UINT, array("enum"=>array("0", 1), "enum_only"=>array("0"), "result_type"=>"simple"), 3, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_browse_cols", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_filtered", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_cols", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

    if(!$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "##modId##:correctStopArgNames");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10);
    }

    /* PM 5587
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_archive", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "archive_type", RLT_ENUM, array("manual", "date"), "manual");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "archive_period", RLT_DATE_PERIOD_NEGATIVE, RLC_NONE, "-12 month");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_type", RLT_ENUM, array("all", "active", "archive"), "all", false, array("spec_module_body"));
    */

    if($useCats && !$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_col", RLT_ENUM, array("date", "header", "position"), "date", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_SINT, array('min' => 1), 1, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));
        $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
        $vMod->Captions['show_subitems'] .= $aCaptions['show_subitems_no_cat_mode'];
        unset($aCaptions);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'subitems_grp_by_cat', RLT_BOOL, RLC_NONE, TRUE, false, array('spec_module_body'));
    }
    if(!$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_total_items_limit", RLT_UINT, array("min"=>3, "max"=>1000), 30, false);
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, $isCoreV5 ? 'spl_specblock' : 'spl_specblock_60', RLT_SPLITTER, RLC_NONE, false, true);
    if($isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "small_view_mode", RLT_ENUM, TlIIII1($vModName), "usual", false, array("spec_small_##modId##"));
    }else{
        $vMod->addRule(
            CMS_CoreRules::RLR_ROOT,
            CMS_CoreRules::VIEW_MODE_NOVICE,
            'small_number_items',
            RLT_UINT,
            $isCoreV5 ? RLC_NONE : array('min' => 1),
            4,
            false,
            array('spec_small_##modId##')
        );
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_total_items_limit", RLT_UINT, array("min"=>3, "max"=>1000), 30, false, array("spec_small_##modId##"));
    }
    if($isCoreV5){
        $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
        $vMod->Captions['small_number_items'] = $aCaptions['small_number_items'] . $aCaptions['small_number_items_50'];
        unset($aCaptions);
        /*
        // List of categories id, from which the items will be shown
        //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->addRule(
            CMS_CoreRules::RLR_ROOT,
            CMS_CoreRules::VIEW_MODE_NOVICE,
            'small_number_categories',
            RLT_ENUM_WITH_UINT,
            array('enum' => array('0', 1), 'enum_only' => array('0'), 'result_type' => 'simple'),
            0,
            FALSE,
            array('spec_small_##modId##')
        );
        */
    }elseif($useCats){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'small_grp_by_cat', RLT_BOOL, RLC_NONE, false, false, array('spec_small_##modId##'));
    }
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_col_small", RLT_ENUM, array("date", "header", "position", "votes_rate"), "votes_rate", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ANY, CMS_CoreRules::VIEW_MODE_NOVICE, "page_sort_dim_small", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_small_".$vModName));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "announce_mode_full", RLT_BOOL, RLC_NONE, false, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "announce_small_length", RLT_UINT, array("min"=>3, "max"=>0xFFFF), 128, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "header_small_length", RLT_UINT, array("min"=>3, "max"=>255), 200, false, array("spec_small_##modId##"));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_##modId##"), "modules_templates:GetCustomModuleTemplatesWithPath");

    if($useCats && !$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(-1), false, array('spec_small_##modId##'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_##modId##"), "common_settings:rulePageIdsCB");
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_ext_discussion", RLT_SPLITTER, RLC_NONE, false, true);
    if($isCoreV5){
        // $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_body_when_forum", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    }
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_replies", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_topics", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_list", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_small", RLT_BOOL, RLC_NONE, false, false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_webmaster_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'use_tree_view', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_anonymous_user_email", RLT_EMAIL, RLC_NONE, "anonymous@localhost.ru");
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_attaches_allowed", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_only_one_level", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_multi_topics", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_pager_type", RLT_ENUM, array("items", "topics"), "items");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_at_details", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_pager_page_number_as_bound', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));

    if($isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_adv", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_list", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_details", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_sb", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_##modId##"), "adv_places:getOptionsPlacesCB");
    }

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
        array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)/*, "adding_allow"=>0*/),
        array("field_date"=>"visible", "field_body"=>"visible", "field_picture"=>"visible", "field_popup_picture"=>"visible", "field_small_picture"=>"visible", "field_html_title"=>"hidden"));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
        array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
        array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
    }

    //--  RSS extension for NEWS
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_rss_extension", RLT_SPLITTER, RLC_NONE, false, true, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_num_elements", RLT_UINT, array("min"=>1), 10, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_page", RLT_ENUM_MULTI_ARRAY, array("rss_generate", "rss_autolink"), array("rss_generate"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_display_image", RLT_ENUM, array("rss_xmlimage", "rss_rss20image", "rss_rssimage"),  array("rss_rss20image"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_title", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_description", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_image", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssImage");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_style", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body"), "ext_rss_rules:getOptionsRssStyle");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_channel_webmaster", RLT_CHAR, RLC_NONE, "", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_title", RLT_ENUM, array("rss_header", "rss_announce"), array("rss_header"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_description", RLT_ENUM, array("rss_announce", "rss_header"), array("rss_announce"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_fulltext", RLT_ENUM, array("rss_body", "rss_announce", "rss_header", "none"), array("none"), false, array("spec_module_body"));// = field
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_enclosure", RLT_ENUM, array("rss_small_image", "rss_image", "rss_popup_image", "none"),array("rss_small_image"), false, array("spec_module_body"));// = field from news
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_guid", RLT_ENUM, array("rss_link", "none"), array("none"), false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "rss_item_pubdate", RLT_ENUM, array("rss_m_date", "rss_c_date", "none"), array("rss_c_date"), false, array("spec_module_body"));// = field
    //-- end RSS

//    $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);

    $vMod->finishModule();
}

// } [ami_multifeeds5|blog]
// [ami_multifeeds5|faq] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, RLC_NONE, 10);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("date", "subject", "position"), "date", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "question_list_layout", RLT_ENUM, array("link_to_same_page", "link_to_separate_page", "no_links"), "link_to_same_page", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "faq_add_by_registered_only", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "question_number_type", RLT_ENUM, array("arabic", "roman", "bullet", "no_numbering"), "arabic", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "send_answer_to_author", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "confirm_from_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "faq_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_twist_prevention", 'ext_reindex', 'ext_modules_custom_fields', RLC_EMPTY))), array("ext_twist_prevention"), false, array());
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array('ext_twist_prevention'), false, false, '##modId##:ruleExtensionsCB', array('ext_twist_prevention', 'ext_reindex', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'hide_future_items', RLT_BOOL, RLC_NONE, true);
    if(
        $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories') &&
        !$oDeclarator->getAttr($vModName, 'core_v5')
    ){
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);

    //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "##modId##:correctStopArgNames");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_col", RLT_ENUM, array("date", "subject", "position", "votes_rate"), "date", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_SINT, array('min' => 1), 1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_specblock", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_number_items", RLT_UINT, RLC_NONE, 4, false, array("spec_small_faq"));
    // List of categories id, from which the items will be shown
    //(0 - first N categories, which is specified in an option "small_number_categories").
    $vMod->addRule(
        CMS_CoreRules::RLR_ROOT,
        CMS_CoreRules::VIEW_MODE_NOVICE,
        'small_number_categories',
        RLT_ENUM_WITH_UINT,
        array('enum' => array('0', 1), 'enum_only' => array('0'), 'result_type' => 'simple'),
        0,
        FALSE,
        array('spec_small_##modId##')
    );
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_category_ids",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, 0, false, array("spec_small_faq"), "##modId##_cat:getOptionsModCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_col", RLT_ENUM, array("name", "position"), "position", false, array("spec_small_faq"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_faq"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date", "question", "position"), "date", false, array("spec_small_faq"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "desc", false, array("spec_small_faq"));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_faq"), "modules_templates:GetCustomModuleTemplatesWithPath");
    if(
        $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories') &&
        !$oDeclarator->getAttr($vModName, 'core_v5')
    ){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(-1), false, array('spec_small_##modId##'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_##modId##"), "common_settings:rulePageIdsCB");
    }

/*
    $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);
*/

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);

//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, true);

    $vMod->finishModule();

}

// } [ami_multifeeds5|faq]
// [ami_multifeeds5|faq|cat] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);
    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, RLC_NONE, 10);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "category_number_type", RLT_ENUM, array("arabic", "roman", "bullet", "no_numbering"), "no_numbering", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cat_list_layout", RLT_ENUM, array("link_to_same_page", "no_links"), "link_to_same_page", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_counters", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "front_page_sort_col", RLT_ENUM, array("name", "position"),   "name", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_empty_cats", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, '##modId##:ruleExtensionsCB', array('ext_reindex', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);

    $vMod->finishModule();
}

// } [ami_multifeeds5|faq|cat]
// [ami_multifeeds5|faq] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

    $vMod->removeRules();
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, RLC_NONE, 10);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("header", "subject", "position"), "header", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "question_list_layout", RLT_ENUM, array("link_to_same_page", "link_to_separate_page", "no_links"), "link_to_same_page", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "faq_add_by_registered_only", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "question_number_type", RLT_ENUM, array("arabic", "roman", "bullet", "no_numbering"), "arabic", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "send_answer_to_author", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "confirm_from_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "faq_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_twist_prevention", 'ext_reindex', 'ext_modules_custom_fields', RLC_EMPTY))), array("ext_twist_prevention"), false, array());
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array('ext_twist_prevention'), false, false, '##modId##:ruleExtensionsCB', array('ext_twist_prevention', 'ext_reindex', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'pager_page_number_as_bound', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'hide_future_items', RLT_BOOL, RLC_NONE, true);
    if(
        $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories') &&
        !$oDeclarator->getAttr($vModName, 'core_v5')
    ){
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);

    //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "##modId##:correctStopArgNames");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_col", RLT_ENUM, array("date", "subject", "position", "votes_rate"), "date", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_SINT, array('min' => 1), 1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_specblock", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_number_items", RLT_UINT, RLC_NONE, 4, false, array("spec_small_faq"));
    // List of categories id, from which the items will be shown
    //(0 - first N categories, which is specified in an option "small_number_categories").
    $vMod->addRule(
        CMS_CoreRules::RLR_ROOT,
        CMS_CoreRules::VIEW_MODE_NOVICE,
        'small_number_categories',
        RLT_ENUM_WITH_UINT,
        array('enum' => array('0', 1), 'enum_only' => array('0'), 'result_type' => 'simple'),
        0,
        FALSE,
        array('spec_small_##modId##')
    );
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_category_ids",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, 0, false, array("spec_small_faq"), "##modId##_cat:getOptionsModCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_col", RLT_ENUM, array("header", "position"), "position", false, array("spec_small_faq"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_faq"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date_created", "question", "position"), "date_created", false, array("spec_small_faq"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "desc", false, array("spec_small_faq"));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_faq"), "modules_templates:GetCustomModuleTemplatesWithPath");
    if(
        $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories') &&
        !$oDeclarator->getAttr($vModName, 'core_v5')
    ){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(-1), false, array('spec_small_##modId##'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_##modId##"), "common_settings:rulePageIdsCB");
    }

/*
    $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);
*/

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);

//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, true);

    $vMod->finishModule();
}

// } [ami_multifeeds5|faq]
// [ami_multifeeds5|faq|cat] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);
    $vMod->removeRules();

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "category_number_type", RLT_ENUM, array("arabic", "roman", "bullet", "no_numbering"), "no_numbering", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cat_list_layout", RLT_ENUM, array("link_to_same_page", "no_links"), "link_to_same_page", false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_counters", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "front_page_sort_col", RLT_ENUM, array("header", "position"), "header", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_empty_cats", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, '##modId##:ruleExtensionsCB', array('ext_reindex', 'ext_modules_custom_fields'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);

    $vMod->finishModule();
}

// } [ami_multifeeds5|faq|cat]
// [ami_multifeeds5|photoalbum] {

$vModName = '##modId##';
if($GLOBALS["Core"]->IsInstalled($vModName)){
    $vMod = &$oCoreRules->addModule($vModName);
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
    $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);
    $vMod->removeRules( array("page_size_small", "page_sort_col_small", "page_sort_dim_small") );
    $isCoreV5 = $oDeclarator->getAttr($vModName, 'core_v5', FALSE);
    $useCats = $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories');

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_common", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("date", "header", "position", "votes_rate"), "position", false, array("spec_module_body"));
//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_audit", "ext_twist_prevention", "ext_discussion", "ext_rating", 'ext_reindex', "ext_tags", 'ext_modules_custom_fields', RLC_EMPTY))), array(RLC_EMPTY), false, array());
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, '##modId##:ruleExtensionsCB', array('ext_audit', 'ext_twist_prevention', 'ext_discussion', 'ext_rating', 'ext_reindex', 'ext_tags', 'ext_modules_custom_fields'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'cols', RLT_UINT, array('min' => 1), 3);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'hide_future_items', RLT_BOOL, RLC_NONE, true);
    if(
        $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories') &&
        !$oDeclarator->getAttr($vModName, 'core_v5')
    ){
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'mod_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-2, 0), false, array('spec_module_body'), 'common_settings:rulePageIdsCB');
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "item_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"), false, array("spec_module_body", "spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "col_picture_type", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "prior_source_picture", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("popup_picture"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxwidth", RLT_UINT, array("min"=>1), 400);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxheight", RLT_UINT, array("min"=>1), 400);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxwidth", RLT_UINT, array("min"=>1), 800);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxheight", RLT_UINT, array("min"=>1), 600);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxwidth", RLT_UINT, array("min"=>1), 130);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxheight", RLT_UINT, array("min"=>1), 130);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_bigger_image", RLT_BOOL, RLC_NONE, true);
    //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "static_watermark", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "static_watermark", RLT_CHAR, RLC_CALLBACK, "", false, array(), "##modId##:setImagesWatermark");

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'disable_se_indexing_pages', RLT_ENUM_MULTI_ARRAY, array ('body_items', 'body_items_internal', 'body_browse', 'body_filtered', 'body_filtered_internal', 'body_itemD', 'print_version', 'page_ext_rss', 'page_ext_discussion', RLC_EMPTY), array('body_browse', 'body_filtered', 'print_version', 'page_ext_rss', 'page_ext_discussion'), false, array('spec_module_body'));

//    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multi_page",                 true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_browse", RLT_SPLITTER, RLC_NONE, false, true);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_body_browse", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_browse_page_size", RLT_UINT, array("min"=>1), 9, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "browse_active_item_position", RLT_UINT, array("min"=>1), 3);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "browse_active_item_position", RLT_ENUM_WITH_UINT, array("enum"=>array("0", 1), "enum_only"=>array("0"), "result_type"=>"simple"), 5, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_browse_cols", RLT_UINT, array("min"=>1), 3, false, array("spec_module_body"));


    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);

    //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), "##modId##:correctStopArgNames");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 3, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10, false, array("spec_module_body"));

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_twist_action", RLT_BOOL, RLC_NONE, false, false);
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_ext_discussion", RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_replies", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_topics", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_list", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_small", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body", "spec_small_photoalbum"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_at_details", RLT_BOOL, RLC_NONE, true, TRUE, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_pager_page_number_as_bound', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_webmaster_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'use_tree_view', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_anonymous_user_email", RLT_EMAIL, RLC_NONE, "anonymous@localhost.ru");
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_attaches_allowed", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_only_one_level", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_multi_topics", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_pager_type", RLT_ENUM, array("items", "topics"), "items");


    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_subitems", RLT_SPLITTER, RLC_NONE, false, true);

    if($GLOBALS['Core']->TTlI1T1($vModName, 'use_categories') && !$oDeclarator->getAttr($vModName, 'core_v5')){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'subitems_total_items_limit', RLT_UINT, array("min"=>3, "max"=>1000), 30, false, array('spec_module_body'));
    }
    if(!$oDeclarator->getAttr($vModName, 'core_v5')){
        $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
        $vMod->Captions['show_subitems'] .= $aCaptions['show_subitems_no_cat_mode'];
        unset($aCaptions);
    }
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_subitems", RLT_ENUM_WITH_UINT, array("enum"=>array("-1", "0", 1), "enum_only"=>array("-1", "0"), "result_type"=>"simple"), -1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_col", RLT_ENUM, array("date", "header", "position"), "date", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_subitem_sort_dim", RLT_ENUM, array("asc", "desc"), "desc", false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_cols", RLT_SINT, array('min' => 1), 1, false, array("spec_module_body"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "subitems_splitter_period", RLT_UINT, RLC_NONE, 0, false, array("spec_module_body"));
    if(!$oDeclarator->getAttr($vModName, 'core_v5')){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'subitems_grp_by_cat', RLT_BOOL, RLC_NONE, TRUE, false, array('spec_module_body'));
    }

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, $isCoreV5 ? 'spl_specblock' : 'spl_specblock_60', RLT_SPLITTER, RLC_NONE, false, true);

    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_number_items", RLT_UINT, RLC_NONE, 4, false, array("spec_small_##modId##"));
    if(!$isCoreV5){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_total_items_limit", RLT_UINT, array("min"=>3, "max"=>1000), 30, false, array("spec_small_##modId##"));
    }
    if($isCoreV5){
        $aCaptions = $GLOBALS['cms']->Gui->ParseLangFile('templates/lang/options/default_rules_captions.lng');
        $vMod->Captions['small_number_items'] = $aCaptions['small_number_items'] . $aCaptions['small_number_items_50'];
        unset($aCaptions);

        // List of categories id, from which the items will be shown
        //(0 - first N categories, which is specified in an option "small_number_categories").
        $vMod->addRule(
            CMS_CoreRules::RLR_ROOT,
            CMS_CoreRules::VIEW_MODE_NOVICE,
            'small_number_categories',
            RLT_ENUM_WITH_UINT,
            array('enum' => array('0', 1), 'enum_only' => array('0'), 'result_type' => 'simple'),
            0,
            FALSE,
            array('spec_small_##modId##')
        );
    }elseif($useCats){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'small_grp_by_cat', RLT_BOOL, RLC_NONE, false, false, array('spec_small_##modId##'));
    }
    // $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_category_ids",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, 0, false, array("spec_small_##modId##"), "##modId##_cat:getOptionsModCB");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_col", RLT_ENUM, array("name", "position"), "name", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date", "header", "position", "votes_rate"), "date", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "desc", false, array("spec_small_##modId##"));
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_small_".$vModName));
    $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
    $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_##modId##"), "modules_templates:GetCustomModuleTemplatesWithPath");
    if(
        $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories') &&
        !$oDeclarator->getAttr($vModName, 'core_v5')
    ){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(-1), false, array('spec_small_##modId##'), 'common_settings:rulePageIdsCB');
    }else{
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_##modId##"), "common_settings:rulePageIdsCB");
    }

    if($GLOBALS["Core"]->IsInstalled("srv_audit")){
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);

        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
        //    array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)), // , "adding_allow"=>0
        //    array("visible", "visible"));
        //
        //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
            array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
            array("not_publish", "not_publish", "not_publish"));
    }

    $vMod->finishModule();
}

// } [ami_multifeeds5|photoalbum]
// [ami_multifeeds5|photoalbum|cat] {

    $vModName = '##modId##';
    if($GLOBALS["Core"]->IsInstalled($vModName)){
        $vMod = &$oCoreRules->addModule($vModName);
        $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
        $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);
        $vMod->removeRules( array( "page_size_small", "page_sort_col_small", "page_sort_dim_small", "cols") );

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "front_page_sort_col", RLT_ENUM, array("name", "position", "votes_rate"),   "name", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "show_empty_cats", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
//        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "extensions", RLT_ENUM_MULTI_ARRAY, array_values(array_intersect($_aTmpAllModules, array("ext_audit", "ext_rating", 'ext_reindex', 'ext_twist_prevention', 'ext_discussion', 'ext_modules_custom_fields', RLC_EMPTY))), array(RLC_EMPTY), false, array());
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, '##modId##:ruleExtensionsCB', array('ext_audit', 'ext_twist_prevention', 'ext_discussion', 'ext_rating', 'ext_reindex', 'ext_modules_custom_fields'));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_urgent_elements', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'at_first_page', 'at_next_pages', 'at_spec_block'), array('at_first_page', 'at_next_pages'));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_pictures_params", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "item_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"), false, array("spec_module_body", "spec_small_##parentModId##"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "col_picture_type", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_pictures", RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, "picture", "popup_picture", "small_picture"), Array("picture", "popup_picture", "small_picture"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "prior_source_picture", RLT_ENUM, array("picture", "popup_picture", "small_picture"), Array("popup_picture"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxwidth", RLT_UINT, array("min"=>1), 275);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "picture_maxheight", RLT_UINT, array("min"=>1), 275);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxwidth", RLT_UINT, array("min"=>1), 800);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "popup_picture_maxheight", RLT_UINT, array("min"=>1), 600);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxwidth", RLT_UINT, array("min"=>1), 130);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_picture_maxheight", RLT_UINT, array("min"=>1), 130);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "generate_bigger_image", RLT_BOOL, RLC_NONE, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "static_watermark", RLT_CHAR, RLC_NONE, "");

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_seo_settings', RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "keywords_generate",  RLT_ENUM, "KEYW_GEN", "auto");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_splitter", RLT_CHAR, RLC_NONE, "");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "html_title_template", RLT_CHAR, RLC_NONE, "");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "set_404_header", RLT_BOOL, RLC_NONE, 1);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "average_cat_rating", RLT_BOOL, RLC_NONE, true, true, array("spec_module_body"));

        if($GLOBALS["Core"]->IsInstalled("srv_audit")){
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_audit_extension", RLT_SPLITTER, RLC_NONE, false, true);

            //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_displayed_fields", RLT_ARRAY_OF,
            //    array('items_type'=>RLT_ENUM, "items_values"=>array("hidden", "visible"), "default_value"=>"visible", "remove_disabled"=>array(1, 1)/*, "adding_allow"=>0*/),
            //    array("visible", "visible"));
            //
            //$vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_required_fields", RLT_ENUM_MULTI_ARRAY, array("field_date", "field_body", "field_html_title", RLC_EMPTY), array(RLC_EMPTY), false);

            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
                array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
                array("not_publish", "not_publish", "not_publish"));
        }
/*
        $oCoreRules->Core->SetModOption($vModName, "sys_installed", $oCoreRules->Core->isInstalled($vModName));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "sys_installed", RLT_SYS_INSTALLED, true);
*/

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_twist_prevention', RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'action_period', RLT_DATE_PERIOD_POSITIVE, RLC_NONE, '5 second', false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_captcha', RLT_BOOL, RLC_NONE, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'js_checking', RLT_BOOL, RLC_NONE, true, false);
//            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'generate_twist_action', RLT_BOOL, RLC_NONE, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_alert', RLT_BOOL, RLC_NONE, true, false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_ext_discussion', RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_forum_count_replies', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_forum_link_in_list', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_webmaster_email', RLT_EMAIL, RLC_NONE, $GLOBALS['COMPANY_EMAIL'], false, array ('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'use_tree_view', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));
//            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_attaches_allowed', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'show_forum_at_details', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_pager_page_number_as_bound', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));

        $vMod->finishModule();
    }

// } [ami_multifeeds5|photoalbum|cat]
