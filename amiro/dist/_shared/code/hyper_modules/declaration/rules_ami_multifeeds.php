<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @size       26727 xkqwngutluwsguttllrlqqrlsygppkmlwusykllnuyxukkwwpnmnuzpqipurpzstgmimpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}


if(isset($modName) && $modName){

    $vModName = $modName;
    $useCats = false;

    if($GLOBALS["Core"]->IsInstalled($vModName)){
        $oCoreRules->setCurrentOwner($oDeclarator->getSection($vModName));

        $vMod = &$oCoreRules->addModule($vModName);
        $useCats = $GLOBALS['Core']->TTlI1T1($vModName, 'use_categories');

        $vMod->addCaptions("_local/_admin/templates/lang/options/" . $vModName . "_rules_captions.lng");
        $vMod->addCaptions("_local/_admin/templates/lang/options/" . $vModName . "_rules_values.lng", TRUE);

        $vMod->removeRules( array("page_size_small", "page_sort_col_small", "page_sort_dim_small") );

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "front_page_sort_col", RLT_ENUM, array("date_created", "header", "position", "ext_rate_count", "ext_rate_rate"), "date_created", false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_stat_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_adv_place_columns", RLT_BOOL, RLC_CALLBACK, false, false, array (), "adv_places:getOptionsModColsCB");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'fill_empty_description', RLT_BOOL, RLC_NONE, TRUE);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, $vModName . ':ruleExtensionsCB', array('ext_twist_prevention', 'ext_discussion', 'ext_rating', 'ext_audit', 'ext_rss', 'ce_page_break', 'ext_reindex', 'ext_tags', 'ext_relations', 'ext_images', 'ext_modules_custom_fields'));

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
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'ext_img_fields', RLT_ENUM_MULTI_ARRAY, array(RLC_EMPTY, 'ext_img', 'ext_img_popup', 'ext_img_small'), array('ext_img', 'ext_img_popup', 'ext_img_small'), false, array("spec_module_body", "spec_small_" . $vModName));
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

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_body_filtered", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_page_size", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_filtered_cols", RLT_UINT, array("min"=>1), 5, false, array("spec_module_body"));

        if('free' !== AMI::getEdition()){
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_categories", RLT_SPLITTER, RLC_NONE, false, true);
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "use_categories", RLT_BOOL, RLC_CALLBACK, true, false, array (), $vModName . ":correctStopArgNames");
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_cats_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_module_body"));
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat", RLT_BOOL, RLC_NONE, false, false, array("spec_module_body"));
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "multicat_in_body_details", RLT_BOOL, RLC_NONE, false);
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_last_items", RLT_UINT, RLC_NONE, 10);
        }

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_twist_prevention", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "action_period", RLT_DATE_PERIOD_POSITIVE, RLC_NONE, "5 second", false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_captcha", RLT_BOOL, RLC_NONE, false, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "js_checking", RLT_BOOL, RLC_NONE, true, false);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_alert", RLT_BOOL, RLC_NONE, true, false);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_ext_discussion", RLT_SPLITTER, RLC_NONE, false, true);

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_count_replies", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_list", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_link_in_small", RLT_BOOL, RLC_NONE, false, false, array("spec_small_" . $vModName));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "show_forum_at_details", RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'forum_pager_page_number_as_bound', RLT_BOOL, RLC_NONE, true, false, array ('spec_module_body'));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'notify_admin_about_new_message', RLT_BOOL, RLC_NONE, true, false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "forum_webmaster_email", RLT_EMAIL, RLC_NONE, $GLOBALS["COMPANY_EMAIL"], false, array("spec_module_body"));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'use_tree_view', RLT_BOOL, RLC_NONE, false, false, array ('spec_module_body'));

        // #CMS-11482, ext_rating {

        if($GLOBALS['Core']->IsInstalled('ext_rating')){
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spl_ext_rating', RLT_SPLITTER, RLC_NONE, false, true, array('spec_module_body'));
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'form_template', RLT_ENUM, RLC_CALLBACK, 'rating_like.tpl', false, array('spec_module_body'), 'modules_templates:GetCustomModuleTemplates');
        }

        // } ext_rating

        if($useCats && 'free' !== AMI::getEdition()){
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
            array('spec_small_' . $vModName)
        );
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_total_items_limit", RLT_UINT, array("min"=>3, "max"=>1000), 30, false, array("spec_small_" . $vModName));
        if($useCats){
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'small_grp_by_cat', RLT_BOOL, RLC_NONE, false, false, array('spec_small_' . $vModName));
        }

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "cache_expire_force", RLT_ENUM_WITH_DATE_PERIOD_POSITIVE, array("enum"=>array("", 1), "enum_only"=>array(""), "result_type"=>"simple"), "");

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_col", RLT_ENUM, array("header", "position"), "header", false, array("spec_small_" . $vModName));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_categories_sort_dim", RLT_ENUM, array("asc", "desc"),   "asc", false, array("spec_small_" . $vModName));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_col", RLT_ENUM, array("date_created", "header", "position", "ext_rate_rate"), "date_created", false, array("spec_small_" . $vModName));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "small_items_sort_dim", RLT_ENUM, array("asc", "desc"),   "desc", false, array("spec_small_" . $vModName));
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "body_small_cols", RLT_UINT, array("min"=>1), 1, false, array("spec_small_".$vModName));
        $vMod->Captions['spec_block_template'] = $vMod->getCaption('spec_block_template').sprintf($vMod->getCaption('spec_block_template_hint'), $vModName."_");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_block_template", RLT_ENUM, RLC_CALLBACK, "", false, array("spec_small_" . $vModName), "modules_templates:GetCustomModuleTemplatesWithPath");
        if($useCats){
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'spec_cat_id_pages',  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(-1), false, array('spec_small_' . $vModName), 'common_settings:rulePageIdsCB');
        }else{
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spec_id_pages",  RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array (-1), false, array("spec_small_" . $vModName), "common_settings:rulePageIdsCB");
        }
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "spl_adv", RLT_SPLITTER, RLC_NONE, false, true);
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_list", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_" . $vModName), "adv_places:getOptionsPlacesCB");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_details", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_" . $vModName), "adv_places:getOptionsPlacesCB");
        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "adv_place_sb", RLT_ENUM, RLC_CALLBACK, -1, false, array("spec_module_body", "spec_small_" . $vModName), "adv_places:getOptionsPlacesCB");

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
    }

    $vModName .= '_cat';

    if($useCats && $GLOBALS["Core"]->IsInstalled($vModName)){
        $vMod = &$oCoreRules->addModule($vModName);
        $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_captions.lng");
        $vMod->addCaptions("_local/_admin/templates/lang/options/{$vModName}_rules_values.lng", TRUE);

        $vMod->removeRules( array( "page_size_small", "page_sort_col_small", "page_sort_dim_small", "cols") );

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, 'extensions', RLT_ENUM_MULTI_ARRAY, RLC_CALLBACK, array(), false, false, $vModName . ':ruleExtensionsCB', array('ext_audit', 'ext_reindex', 'ext_rating', 'ext_relations', 'ext_modules_custom_fields'));

        $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE,  "front_page_sort_col", RLT_ENUM, array("header", "position", "ext_rate_count", "ext_rate_rate"),   "header", false, array("spec_module_body"));
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
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_admin_changes", RLT_BOOL, RLC_NONE, false, false, false);
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_notification", RLT_BOOL, RLC_NONE, true, true, false);
            $vMod->addRule(CMS_CoreRules::RLR_ROOT, CMS_CoreRules::VIEW_MODE_NOVICE, "audit_actions_handling", RLT_ARRAY_OF,
                array('items_type'=>RLT_ENUM, "items_values"=>array("not_publish", "as_is", "reject"), "default_value"=>"not_publish", "remove_disabled"=>array(1, 1)),
                array("not_publish", "not_publish", "not_publish"));
        }

        $vMod->finishModule();
    }

    unset($useCats);
    unset($modName);
    unset($vModName);
}
