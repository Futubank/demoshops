<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @size       13749 xkqwywkuwxyrmklrwxzzgtmkwynuxnkumlikkrnmlxzumqpyuuglnppkngnptsxwygrgpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}


if(isset($modName) && $modName){

    if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
        $vMod = &$Core->GetModule($modName);
        $oDeclarator->setupAsyncInterface($vMod, FALSE);
        $vMod->SetOption('cols', 1);
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
        $vMod->SetOption('ext_img_fields', array('ext_img', 'ext_img_popup', 'ext_img_small'));
        $Core->TTlI1ll(
            $vMod,
            'ext_img_list_col',
            'ext_images',
            'col_picture_type',
            FALSE,
            NULL,
            array('AmiExt_Image_Adm', 'convertOptionValue')
        );
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

        $vMod->SetOption("use_categories", TRUE);
        if($vMod->GetOption( "use_categories")){
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty($modName . "_cat", "stop_arg_names"));
        } else {
            $vMod->SetOption("stop_arg_names", $Core->GetModProperty($modName, "stop_arg_names"));
        }

        $vMod->SetOption("subitems_total_items_limit", 30);
        $vMod->SetOption("spec_total_items_limit", 30);

        $vMod->SetOption("page_size",                  10);
        $vMod->SetOption("page_sort_col",              'date_created');
        $vMod->SetOption("page_sort_dim",              "desc");
        $vMod->SetOption("front_subitem_sort_col",     'date_created');
        $vMod->SetOption("front_subitem_sort_dim",     "desc");
        $vMod->SetOption("front_page_sort_col",        "date_created");
        $vMod->SetOption("front_page_sort_dim",        "desc");
        $vMod->SetOption("multi_page",                 true);
        $vMod->SetOption("archive_type",               "manual");
        $vMod->SetOption("archive_period",             "-1 year");
        $vMod->SetOption("show_type",                  "all");
        $vMod->SetOption("multicat",                   false);
        $vMod->SetOption("multicat_in_body_details",   false);
        $vMod->SetOption("show_last_items",            10);
        $Core->TTlI1ll($vMod, 'show_forum_count_replies', 'ext_discussion', 'show_forum_count_replies');
        $Core->TTlI1ll($vMod, 'show_forum_link_in_list', 'ext_discussion', 'show_forum_link_in_list');
        $Core->TTlI1ll($vMod, 'show_forum_link_in_small', 'ext_discussion', 'show_forum_link_in_small');
        $Core->TTlI1ll($vMod, 'show_forum_at_details', 'ext_discussion', 'show_forum_at_details');
        $Core->TTlI1ll($vMod, 'forum_pager_page_number_as_bound', 'ext_discussion', 'forum_pager_page_number_as_bound');
        $Core->TTlI1ll($vMod, 'notify_admin_about_new_message', 'ext_discussion', 'notify_admin_about_new_message');
        $Core->TTlI1ll($vMod, 'forum_webmaster_email', 'ext_discussion', 'forum_webmaster_email');
        $Core->TTlI1ll($vMod, 'use_tree_view', 'ext_discussion', 'use_tree_view');

        // #CMS-11482, ext_rating {

        if($GLOBALS['Core']->IsInstalled('ext_rating')){
            $Core->TTlI1ll($vMod, 'form_template', 'ext_rating', 'form_template', TRUE, 'rating_like.tpl');
        }

        // } ext_rating

        $vMod->SetOption("body_cats_cols",             1);
        $vMod->SetOption("body_small_cols",            1);
        $vMod->SetOption("show_subitems",              -1);
        $vMod->SetOption("subitems_splitter_period",    0);
        $vMod->SetOption("subitems_cols",               1);
        $vMod->SetOption('subitems_grp_by_cat', TRUE);
        $vMod->SetOption("small_number_items",          5);
        $vMod->SetOption("small_category_ids",          0);
        $vMod->SetOption('small_grp_by_cat', FALSE);
        $vMod->SetOption("small_categories_sort_col",   "header");
        $vMod->SetOption("small_categories_sort_dim",   "asc");
        $vMod->SetOption("small_items_sort_col",        "date_created");
        $vMod->SetOption("small_items_sort_dim",        "desc");
        $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description');
        $vMod->SetOption("extensions", array("ext_twist_prevention", "ext_rss", 'ext_reindex') );
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));
        $vMod->SetOption('action_period', '5 second');
        $Core->TTlI1ll($vMod, 'show_captcha', 'srv_twist_prevention', 'show_captcha');
        $Core->TTlI1ll($vMod, 'js_checking', 'srv_twist_prevention', 'js_checking');
        $Core->TTlI1ll($vMod, 'generate_twist_action', 'srv_twist_prevention', 'generate_twist_action');
        $Core->TTlI1ll($vMod, 'show_alert', 'srv_twist_prevention', 'show_alert');
        $Core->TTlI1ll($vMod, 'rss_num_elements', 'ext_rss', 'rss_num_elements');
        $Core->TTlI1ll($vMod, 'rss_display_page', 'ext_rss', 'rss_display_page');
        $Core->TTlI1ll($vMod, 'rss_display_image', 'ext_rss', 'rss_display_image');
        $Core->TTlI1ll($vMod, 'rss_channel_title', 'core_module', 'company_name');
        $vMod->SetOption("rss_channel_description",       "");
        $Core->TTlI1ll($vMod, 'rss_channel_webmaster', 'ext_rss', 'rss_channel_webmaster');
        $Core->TTlI1ll($vMod, 'rss_channel_generator', 'ext_rss', 'rss_channel_generator');
        $vMod->SetOption("rss_item_title",                "rss_header");
        $vMod->SetOption("rss_item_description",          "rss_announce");
        $vMod->SetOption("rss_item_enclosure",            "rss_small_image");
        $vMod->SetOption("rss_item_guid",                 "none");
        $vMod->SetOption("rss_item_pubdate",              "rss_c_date");
        $Core->TTlI1ll($vMod, 'rss_channel_image', 'ext_rss', 'rss_channel_image');
        $Core->TTlI1ll($vMod, 'rss_channel_style', 'ext_rss', 'rss_channel_style');
        $vMod->SetOption("sort_pages_setup",  Array(
                "body_items;body_urgent_items"=>Array("header", "date"),
                "body_cats;body_urgent_cats"=>Array("name", "position")
        ));
        $vMod->SetOption("adv_place_list",  -1);
        $vMod->SetOption("adv_place_details",  -1);
        $vMod->SetOption("adv_place_sb",  -1);
        $vMod->SetOption("show_adv_stat_columns",    false);
        $vMod->SetOption("show_adv_place_columns",    false);

        $vMod->SetOption("stop_arg_names", array("catid" => $modName . "_cat", "id" => $modName));
        $vMod->SetOption("html_title_template",    "##object_name## - ##cat_name## - ##current_page_name## | ##site_title##");
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
        $vMod->SetOption("audit_displayed_fields", Array("field_date"=>"visible", "field_author"=>"visible", "field_source"=>"visible", "field_picture"=>"visible", "field_popup_picture"=>"visible", "field_small_picture"=>"visible", "field_body"=>"visible", "field_html_title"=>"hidden"));
        $vMod->SetOption("audit_required_fields",  Array());
        $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
        $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
        $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
        $vMod->SetOption("spec_block_template",    "");
        $vMod->SetOption("spec_id_pages",          Array(-1));
        $vMod->SetOption("spec_id_pages",          Array(-1));
        $vMod->SetOption('spec_cat_id_pages', array(-1));
        $vMod->SetOption('mod_id_pages', array(-2, 0));
        $vMod->SetOption('mod_cat_id_pages', array(-2, 0));
        // Set pages view in pager (numbers or bounds)
        $Core->TTlI1ll($vMod, 'pager_page_number_as_bound', 'common_settings', 'pager_page_number_as_bound');
        $Core->TTlI1ll($vMod, 'hide_future_items', 'common_settings', 'hide_future_items');
        $Core->TTlI1ll($vMod, 'cache_expire_force', 'common_settings', 'cache_expire_force');
        $vMod->SetOption("small_view_mode", "usual");
        $vMod->SetOption("body_filtered_cols", 1);
        $vMod->SetOption("body_filtered_page_size", 10);
        $vMod->SetOption("filter_pages_setup",  Array(
            "body_filtered"=>Array("date_from", "date_to"))
        );
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
        $Core->TTlI1ll($vMod, 'disable_se_indexing_pages', 'common_settings', 'disable_se_indexing_pages');
        $vMod->SetOption("add_date_prefix", false);
    }

    $modName .= '_cat';

    if($IIIlILl || in_array($modName, $REBULD_MODULES_LIST)){
        $vMod = &$Core->GetModule($modName);
        $oDeclarator->setupAsyncInterface($vMod, FALSE);
        $vMod->SetOption('ext_img_fields', array('ext_img', 'ext_img_popup', 'ext_img_small'));
        $Core->TTlI1ll(
            $vMod,
            'ext_img_list_col',
            'ext_images',
            'col_picture_type',
            FALSE,
            NULL,
            array('AmiExt_Image_Adm', 'convertOptionValue')
        );
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
        $Core->TTlI1ll($vMod, 'keywords_generate', 'common_settings', 'keywords_generate');
        $vMod->SetOption("extensions", array('ext_reindex'));
        $vMod->SetOption("page_size",               10);
        $vMod->SetOption("page_sort_col",           "header");
        $vMod->SetOption("page_sort_dim",           "asc");
        $vMod->SetOption("front_page_sort_col",     "header");
        $vMod->SetOption("front_page_sort_dim",     "asc");
        $vMod->SetOption("cols",                    2);
        $vMod->SetOption("show_empty_cats",         false);
        $Core->TTlI1ll($vMod, 'fill_empty_description', 'common_settings', 'fill_empty_description');
        $vMod->SetOption('show_urgent_elements', array ('at_first_page', 'at_next_pages'));
        $vMod->SetOption("show_adv_stat_columns",    false);
        $vMod->SetOption("show_adv_place_columns",    false);
        $vMod->SetOption("average_cat_rating", true);
        $Core->TTlI1ll($vMod, 'html_title_template', 'common_settings', 'html_title_template');
        $Core->TTlI1ll($vMod, 'html_title_splitter', 'common_settings', 'html_title_splitter');
        $Core->TTlI1ll($vMod, 'audit_admin_changes', 'srv_audit', 'audit_admin_changes');
        $Core->TTlI1ll($vMod, 'audit_notification', 'srv_audit', 'audit_notification');
        $vMod->SetOption("audit_actions_handling", Array("add" => "not_publish", "apply" => "as_is", "del" => "not_publish"));
        $Core->TTlI1ll($vMod, "set_404_header", "page_404", "set_404_header");
    }

    unset($modName);
}
