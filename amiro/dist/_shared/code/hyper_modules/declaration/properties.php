<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       110511 xkqwylxpstumrpggrzmgkmyptusymqgurwpxnzgqwnxnnukxpptuwuinwyigrsyqsttlpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


// [ami_users|users] {
/*
$vMod = &$Core->GetModule('##modId##');
  $vMod->setProperty('sort_fields', array('date', 'active', 'firstname', 'lastname', 'company', 'email', 'username', 'nickname'));
  $vMod->AddDataCustom('module', 'skip_reindex_main', true); // specail value for module reindex skipping
  $vMod->SetProperty('taborder', '##taborder##');
  $vMod->SetProperty('spec_blocks', array('spec_member_menu'));
  // $vMod->SetProperty('srv_order_allow', 0);
  $vMod->SetProperty('cache_front_post', 'not expire');
  // the list of modules dependent from members module
  $vMod->SetProperty('dependent_modules', array(
  // 'create'      => array('forum', 'discussion', 'guestbook'),
  // 'update'      => array('forum', 'discussion', 'guestbook'),
  // 'get_count'   => array('forum', 'discussion', 'guestbook', 'eshop_coupons'),
  // 'del'         => array('forum', 'discussion', 'guestbook', 'eshop_coupons'),
  // 'small'       => array('sys_groups', 'subscribe', 'eshop_user', 'aff_users', 'wz_host_users'),
  // 'dependent'   => array('forum', 'discussion', 'guestbook', 'eshop_coupons'),
  // 'clear_cache' => array('forum', 'discussion', 'guestbook', 'eshop_coupons')
  ));
  // Turning help on \ off
  $vMod->SetProperty('help_on', false);
  // Array of actions to protect from SPAM (extension twist_prevention)
  $vMod->SetProperty('twist_actions', array('add', 'forgot'));
  $vMod->SetProperty('splitter_before', 1);

  $vMod->SetProperty('possible_modules_list', array(
  // modules
  'news', 'blog', 'articles', 'photoalbum', 'faq', 'classifieds', 'feedback', 'files', 'discussion', 'forum', 'guestbook', 'jobs',
  // eshop
  'eshop_item', 'eshop_cat', 'eshop_order', 'eshop_cart',
  // portfolio
  'portfolio',
  // kb
  'kb'
  ));
  // Module class name
  $vMod->SetProperty('engine_classes', array('ModuleMembers'));
  $vMod->SetProperty('actions', array('add', 'apply', 'activate', 'reset', 'edit', 'del'));
 */

// } [ami_users|users]
// [ami_fake|users] {

    $vMod = &$Core->GetModule('##modId##');
        $vMod->SetProperty('engine_classes',    'ModuleMembersPopup');

// } [ami_fake|users]
// [ami_access_rights|groups] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',       array('name', 'is_default', 'guest', 'group_mask', 'login', 'moderator', 'mask_force_allow', 'mask_force_deny'));
        $vMod->SetProperty("actions",           false);
        $vMod->SetProperty("engine_classes",    "ModuleSysGroups");
        $vMod->SetProperty("function_class",    "SysFunctions");
        $vMod->SetProperty("taborder",          '##taborder##');
        // $vMod->SetProperty("srv_order_allow", 0);
        $vMod->SetProperty("help_on",           false); // Turning help on \ off
        $vMod->SetProperty("force_owners",      "system");
        $vMod->SetProperty("force_modules",     array("sitemap", "sectionmap", "print_version", "popup", "spell"));

// } [ami_access_rights|groups]
// [ami_users|access_rights] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',       array('username', 'active', 'firstname', 'lastname', 'email', 'balance'));
        $Core->SetModProperty('members', 'dependent_modules',
            array_merge_recursive(
                $Core->GetModProperty('members', 'dependent_modules'),
                array(
                    'get_count'     => array('sys_groups'),
                    'del'           => array('sys_groups'),
                    'small'         => array('sys_groups'),
                    'dependent'     => array('sys_groups'),
                    'clear_cache'   => array('sys_groups')
                )
            )
        );
        $vMod->SetProperty("actions",           false);
        $vMod->SetProperty("engine_classes",    array("CMS_Member", "ModuleSysUsers"));
        $vMod->SetProperty("function_class",    "SysFunctions");
        // $vMod->SetProperty("srv_order_allow", 0);
        $vMod->SetProperty("help_on",           false); // Turning help on \ off

// } [ami_users|access_rights]
// [ami_access_rights|users_popup] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',       array('username', 'active', 'firstname', 'lastname', 'email'));
        $vMod->SetProperty("actions",           false);
        $vMod->SetProperty("engine_classes",    array("CMS_Member", "ModuleSysUsersPopup"));
        $vMod->SetProperty("admin_only",        true); // special case, admin only
        $vMod->SetProperty("help_on",           false); // Turning help on \ off

// } [ami_access_rights|users_popup]
// [ami_access_rights|groups_popup] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',       array('name', 'is_default', 'guest', 'group_mask', 'login', 'mask_force_allow', 'mask_force_deny'));
        $vMod->SetProperty("actions",           false);
        $vMod->SetProperty("engine_classes",    "ModuleSysGroupsPopup");
        $vMod->SetProperty("admin_only",        true); // special case, admin only
        $vMod->SetProperty("help_on",           true); // Turning help on \ off

// } [ami_access_rights|groups_popup]
// [ami_access_rights|modules_popup] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty("actions",           false);
        $vMod->SetProperty("engine_classes",    'ModuleSysModulesPopup');
        $vMod->SetProperty("admin_only",        true); // special case, admin only
        $vMod->SetProperty("help_on",           false);  // Turning help on \ off

// } [ami_access_rights|modules_popup]
// [ami_access_rights|departments] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty("actions",           false);
        $vMod->SetProperty("engine_classes",    "ModuleSysDepartments");
        $vMod->SetProperty("function_class",    "SysFunctions");
        // $vMod->SetProperty("srv_order_allow", 0);
        $vMod->SetProperty("help_on",           false); // Turning help on \ off

// } [ami_access_rights|groups]
// [ami_multifeeds|articles] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        // Set properties
        $vMod->SetProperty('front_request_types', array('plain'));
        $vMod->SetProperty('unsupported_extensions', array());
        $vMod->setProperty('sort_fields', array('date_created', 'public', 'header', 'cat_header', 'ext_rate_count', 'ext_rate_rate', 'position'));
        // $vMod->SetProperty("actions",                   array("publish", "archive", "add", "edit", "apply", "save", "del", "repair", "publish_on", "publish_off", "archive_on", "archive_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesFunctions", "ModuleArticles"));
        $vMod->SetProperty('taborder', '##taborder##');
        $vMod->SetProperty('stop_arg_names', array('id' => '##modId##'));
        $vMod->SetProperty('stop_arg_filters', array('##modId##' => 'id_cat=%catid')); // ???s
        $vMod->SetProperty('stop_use_sublinks', TRUE);
        $vMod->SetProperty('spec_blocks', array('spec_small_##modId##'));
        // $vMod->SetProperty("archive_field",             "date"); // Archive field name
        $vMod->SetProperty('support_rights', TRUE); // Suport item rights
        $vMod->SetProperty('use_special_list_view', TRUE); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("required_fields",           array("header", "announce", "cat_id")); // Required fields (it is used now for audit module ONLY)
        $vMod->SetProperty('help_on', TRUE); // Turning help on \ off
        $vMod->SetProperty('twist_actions', array('forum_add', 'rate')); // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('picture_cat', '##modId##'); // Front pictures folder
        $vMod->SetProperty('rss_link_smallblock', FALSE); // RSS Extension
        $vMod->SetProperty('actions', array('edit'));
        // Set parameters for search index
        $vMod->TTlIIlT('index', array(array('header', 'author'), array('announce', 'source'), 'body'));
        $vMod->TTlIIlT('index_fields', array('header', 'author', 'announce', 'source', 'body'));
        $vMod->TTlIIlT('public_field', 'public');
        $vMod->TTlIIlT('title', 'header');
        $vMod->TTlIIlT('announce', 'announce');
        $vMod->TTlIIlT('relative_module', array('##modId##_cat', 'id_cat'));
        $vMod->TTlIIlT('robots_noindex_field', 'details_noindex');
        $vMod->TTlIIlT('date_modified', 'date_modified');
        $vMod->TTlIIlT('hide_in_list', 'hide_in_list');

// } [ami_multifeeds|articles]
// [ami_multifeeds|articles|cat] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->SetProperty('engine_classes',            array('CMS_CategoriesModule', 'ModuleArticlesCat'));
        $vMod->SetProperty('unsupported_extensions', array('ext_twist_prevention', 'discussion', 'ce_page_break', 'tags', 'ext_rss'));
        $vMod->setProperty('sort_fields', array('header', 'public', 'position', 'ext_rate_count', 'ext_rate_rate'));
        // $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "top", "bottom", "up", "down", "repair","publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty('stop_arg_names', array('catid' => '##modId##', 'id' => '##parentModId##'));
        $vMod->SetProperty('search_by_parent', TRUE);
        // $vMod->SetProperty("use_special_list_view", TRUE); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty('help_on', FALSE); // Turning help on \ off
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index', array('header', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields', array('header', 'announce', 'body'));
        $vMod->TTlIIlT('public_field', 'public');
        $vMod->TTlIIlT('title', 'header');
        $vMod->TTlIIlT('announce', 'announce');
        $vMod->TTlIIlT('robots_noindex_field', '');
        $vMod->TTlIIlT('script', '?id=');
        $vMod->TTlIIlT('date_modified', 'date_modified');
        $vMod->TTlIIlT('hide_in_list', 'hide_in_list');

// } [ami_multifeeds|articles|cat]
// [ami_multifeeds|stickers] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->SetProperty("unsupported_extensions",    array('custom_fields', 'ext_twist_prevention', 'reindex', 'discussion', 'ce_page_break', 'rating', 'relations', 'tags', 'ext_rss', 'adv'));
        $vMod->setProperty('sort_fields',               array('public', 'header', 'announce', 'date', 'category', 'position'));
        $vMod->SetProperty("spec_blocks",               array("spec_small_##modId##"));
        $vMod->SetProperty('dont_show_in_pm',           true);
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("splitter_before",           1);
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesFunctions", "ModuleStickers"));
        $vMod->SetProperty('actions', array('edit'));

// } [ami_multifeeds|stickers]
// [ami_multifeeds|stickers|cat] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        $vMod->SetProperty("unsupported_extensions",    array('custom_fields', 'ext_twist_prevention', 'image', 'reindex', 'discussion', 'ce_page_break', 'rating', 'relations', 'tags', 'ext_rss', 'adv'));
        $vMod->setProperty('sort_fields',               array('header', 'announce', 'public', 'position'));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesModule", "ModuleStickersCat"));
        $vMod->SetProperty("admin_only",                true);
        $vMod->SetProperty('dont_show_in_pm',           true);
        $vMod->SetProperty('actions', array('edit'));

// } [ami_multifeeds|stickers|cat]
// [ami_multifeeds|news] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        if(!$oDeclarator->getAttr('##modId##', 'core_v5')){
            $vMod->SetProperty('front_request_types', array('plain'));
        }

        // Set properties
        $vMod->SetProperty('stop_arg_names', array('id' => '##modId##'));
        $vMod->SetProperty("unsupported_extensions",    array());
        $vMod->setProperty('sort_fields',               array('date_created', 'public', 'header', 'ext_rate_count', 'ext_rate_rate', 'position'));
        // $vMod->SetProperty("actions",                   array("edit", "add", "apply", "save", "del", "publish", "archive", "publish_on", "publish_off","archive_on", "archive_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            "ModuleNews");
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("spec_blocks",               array("spec_small_##modId##"));
        // $vMod->SetProperty("archive_field",             "date"); // Archive field name
        $vMod->SetProperty("support_rights",            true); // Suport item rights
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        // $vMod->SetProperty("required_fields",           array("header", "announce")); // Required fields (it is used now for audit module ONLY)
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty('twist_actions',             array('forum_add', 'rate')); // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('picture_cat',               'news'); // Front pictures folder
        $vMod->SetProperty("rss_link_smallblock",       true); // Extension RSS
        $vMod->SetProperty('clear_cache_on_discussion_post', array('##modId##_archive'));
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('header', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('header', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "header");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT('relative_module', array('##modId##_cat', 'id_cat'));
        $vMod->TTlIIlT("robots_noindex_field",    "details_noindex");
        $vMod->TTlIIlT("script",                  "?id=");
        $vMod->TTlIIlT('date_modified', 'date_modified');
        $vMod->TTlIIlT('hide_in_list', 'hide_in_list');

// } [ami_multifeeds|news]
// [ami_multifeeds|news|cat] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->SetProperty('engine_classes',            array('CMS_CategoriesModule', 'ModuleArticlesCat'));
        $vMod->SetProperty("unsupported_extensions",    array('ext_twist_prevention', 'discussion', 'ce_page_break', 'tags', 'ext_rss'));
        $vMod->setProperty('sort_fields',               array('header', 'public', 'position', 'ext_rate_count', 'ext_rate_rate'));
        // $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "top", "bottom", "up", "down", "repair","publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("stop_arg_names",            array("catid" => "##modId##", "id" => "##parentModId##"));
        $vMod->SetProperty("search_by_parent",          true);
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("help_on",                   false); // Turning help on \ off
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('header', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('header', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "header");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "");
        $vMod->TTlIIlT("script",                  "?id=");
        $vMod->TTlIIlT('date_modified', 'date_modified');
        $vMod->TTlIIlT('hide_in_list', 'hide_in_list');

// } [ami_multifeeds|news|cat]
// [ami_multifeeds|blog] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        if(!$oDeclarator->getAttr('##modId##', 'core_v5')){
            $vMod->SetProperty('front_request_types', array('plain'));
        }

        // Set properties
        $vMod->SetProperty('stop_arg_names', array('id' => '##modId##'));
        $vMod->SetProperty("unsupported_extensions",    array());
        $vMod->setProperty('sort_fields',               array('date_created', 'public', 'header', 'ext_rate_count', 'ext_rate_rate', 'position'));
        // $vMod->SetProperty("actions",                   array("edit", "add", "apply", "save", "del", "publish", "archive", "publish_on", "publish_off","archive_on", "archive_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            "ModuleNews");
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("spec_blocks",               array("spec_small_##modId##"));
        // $vMod->SetProperty("archive_field",             "date"); // Archive field name
        $vMod->SetProperty("support_rights",            true); // Suport item rights
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("required_fields",           array("header", "announce")); // Required fields (it is used now for audit module ONLY)
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty('twist_actions',             array('forum_add', 'rate')); // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('picture_cat',               'blog'); // Front pictures folder
        $vMod->SetProperty("rss_link_smallblock",       true); // Extension RSS
        $vMod->SetProperty('clear_cache_on_discussion_post', array('##modId##_archive'));
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('header', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('header', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "header");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "details_noindex");
        $vMod->TTlIIlT("script",                  "?id=");
        $vMod->TTlIIlT('date_modified', 'date_modified');
        $vMod->TTlIIlT('hide_in_list', 'hide_in_list');

// } [ami_multifeeds|blog]
// [ami_multifeeds|blog|cat] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->SetProperty('engine_classes',            array('CMS_CategoriesModule', 'ModuleArticlesCat'));
        $vMod->SetProperty("unsupported_extensions",    array('ext_twist_prevention', 'discussion', 'ce_page_break', 'tags', 'ext_rss'));
        $vMod->setProperty('sort_fields',               array('header', 'public', 'position', 'ext_rate_count', 'ext_rate_rate'));
        // $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "top", "bottom", "up", "down", "repair","publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("stop_arg_names",            array("catid" => "##modId##", "id" => "##parentModId##"));
        $vMod->SetProperty("search_by_parent",          true);
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("help_on",                   false); // Turning help on \ off
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('header', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('header', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "header");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT('relative_module', array('##modId##_cat', 'id_cat'));
        $vMod->TTlIIlT("robots_noindex_field",    "");
        $vMod->TTlIIlT("script",                  "?id=");
        $vMod->TTlIIlT('date_modified', 'date_modified');
        $vMod->TTlIIlT('hide_in_list', 'hide_in_list');

// } [ami_multifeeds|blog|cat]
// [ami_fake|news|archive] {

    $vMod = &$Core->GetModule("##modId##");
        // Set properties
        $vMod->SetProperty('support_rights',            true); // #4669
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty('clear_cache_on_discussion_post', array('##parentModId##'));
        // Specifies real module for modules custom fields extension
        // @see ExtModulesCustomFields::init()
        $vMod->SetProperty('ext_mod_cf_module', '##parentModId##');

// } [ami_fake|news|archive]
// [ami_fake|blog|archive] {

    $vMod = &$Core->GetModule("##modId##");
        // Set properties
        $vMod->SetProperty('support_rights',            true); // #4669
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty('clear_cache_on_discussion_post', array('##parentModId##'));
        // Specifies real module for modules custom fields extension
        // @see ExtModulesCustomFields::init()
        $vMod->SetProperty('ext_mod_cf_module', '##parentModId##');

// } [ami_fake|blog|archive]
// [ami_multifeeds|faq] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->SetProperty("unsupported_extensions",    array('image', 'discussion', 'ce_page_break', 'rating', 'relations', 'tags', 'ext_rss', 'adv'));
        $vMod->setProperty('sort_fields',               array('date_created', 'public', 'author', 'subject', 'question', 'answered', 'ext_rate_count', 'ext_rate_rate', 'position'));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesFunctions", "ModuleFaq"));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("cache_front_post",          "not expire");
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("stop_arg_names",            array("id" => "##modId##"));
        $vMod->SetProperty("stop_arg_filters",          array("##modId##" => "id_cat=%catid"));
        $vMod->SetProperty("spec_blocks",               array("spec_small_faq"));
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "repair","publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty('twist_actions',             array('add')); // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('question', 'author', 'answer'));
        $vMod->TTlIIlT('index_fields',            array('question', 'author', 'answer'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "question");
        $vMod->TTlIIlT("announce",                "answer");
        $vMod->TTlIIlT("robots_noindex_field",    "details_noindex");
        $vMod->TTlIIlT("script",                  "#q");
        $vMod->TTlIIlT('relative_module',         array('##modId##_cat', 'id_cat'));
        $vMod->TTlIIlT('date_modified', 'date_modified');
        $vMod->TTlIIlT('hide_in_list', 'hide_in_list');

// } [ami_multifeeds|faq]
// [ami_multifeeds|faq|cat] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->SetProperty("unsupported_extensions",    array('ext_twist_prevention', 'image', 'discussion', 'ce_page_break', 'rating', 'relations', 'tags', 'ext_rss', 'adv'));
        $vMod->setProperty('sort_fields',               array('header', 'public', 'position'));
        $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "top", "bottom", "up", "down", "repair","publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesModule", "ModuleFaqCat"));
        $vMod->SetProperty("stop_arg_names",            array("catid" => "##modId##", "id" => "##parentModId##"));
        $vMod->SetProperty("search_by_parent",          true);
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("help_on",                   false); // Turning help on \ off
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('header', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('header', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "header");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "");
        $vMod->TTlIIlT("script",                  "?id=");
        $vMod->TTlIIlT('date_modified', 'date_modified');
        $vMod->TTlIIlT('hide_in_list', 'hide_in_list');

// } [ami_multifeeds|faq|cat]
// [ami_multifeeds|photoalbum] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        if(!$oDeclarator->getAttr('##modId##', 'core_v5')){
            $vMod->SetProperty('front_request_types', array('plain'));
        }

        // Set properties
        $vMod->SetProperty("unsupported_extensions",    array('reindex', 'relations', 'adv'));
        $vMod->setProperty('sort_fields',               array('date_created', 'public', 'header', 'cname', 'archive', 'ext_rate_count', 'ext_rate_rate', 'position'));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesFunctions", "ModulePhotoalbum"));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("stop_arg_names",            array("id" => "##modId##"));
        $vMod->SetProperty("stop_arg_filters",          array("##modId##" => "id_cat=%catid"));
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("spec_blocks",               array("spec_small_##modId##"));
        $vMod->SetProperty("generate_picture_postf",    "_pc");
        $vMod->SetProperty("generate_small_picture_postf", "_sm");
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty('twist_actions',             array('forum_add', 'rate')); // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('actions', array('edit'));
        $vMod->SetProperty('support_rights', TRUE); // Suport item rights

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array(array('header', 'author'), array('announce', 'source'), 'body'));
        $vMod->TTlIIlT('index_fields',            array('header', 'author', 'announce', 'source', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "header");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "details_noindex");
        $vMod->TTlIIlT("script",                  "?id=");
        $vMod->TTlIIlT('relative_module',         array('##modId##_cat', 'id_cat'));
        $vMod->TTlIIlT('date_modified', 'date_modified');
        $vMod->TTlIIlT('hide_in_list', 'hide_in_list');

// } [ami_multifeeds|photoalbum]
// [ami_multifeeds|photoalbum|cat] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->SetProperty("unsupported_extensions",    array('ce_page_break', 'relations', 'tags', 'ext_rss', 'adv'));
        $vMod->setProperty('supported_extensions', array('ami_ext/antispam'));

        $vMod->setProperty('sort_fields',               array('header', 'public', 'position', 'ext_rate_count', 'ext_rate_rate'));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesModule", "ModulePhotoalbumCat"));
        $vMod->SetProperty("stop_arg_names",            array("catid" => "##modId##", "id" => "##parentModId##"));
        $vMod->SetProperty("search_by_parent",          true);
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty("generate_picture_postf",    "_pc");
        $vMod->SetProperty("generate_small_picture_postf", "_sm");
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty('twist_actions',             array('forum_add', 'rate')); // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('header', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('header', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "header");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "");
        $vMod->TTlIIlT("script",                  "?id=");
        $vMod->TTlIIlT('date_modified', 'date_modified');
        $vMod->TTlIIlT('hide_in_list', 'hide_in_list');

// } [ami_multifeeds|photoalbum|cat]
// [ami_data_exchange|photoalbum|data_exchange] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->SetProperty("engine_classes",            array("CMS_DataExchangeModule", "CMS_CategoriesFunctions", "ModulePhotoalbumDataExchange"));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("dont_show_in_pm",           true);
        $vMod->SetProperty("grp_ids_field",             "_grp_ids");
        $vMod->SetProperty('skip_filter',               true);
        $vMod->SetProperty("allowed_sources",           array("ftp"));
        $vMod->SetProperty("import_sleep_params",       array("default" => array("sleep_time" => 1, "sleep_pereod" => 50)));
        $vMod->SetProperty("allowed_exchange_drivers",  "PhotoExchangeDriver");
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off

// } [ami_data_exchange|photoalbum|data_exchange]
// [ami_files|files] {

    // FILES module constants
    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->setProperty('sort_fields',               array('cdate', 'public', 'name', 'category_name', 'ftype', 'num_downloaded', 'votes_count', 'votes_rate', 'position'));
        $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "repair","publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            "ModuleFiles");
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("stop_arg_names",            array("id" => "##modId##"));
        $vMod->SetProperty("stop_arg_filters",          array("##modId##" => "id_cat=%catid"));
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty("rss_link_smallblock",       false); // Extension RSS
        // $vMod->SetProperty('spec_blocks', array('spec_small_files')); // not implemented yet
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('name', 'announce', 'description'));
        $vMod->TTlIIlT('index_fields',            array('name', 'announce', 'description'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "name");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "details_noindex");
        $vMod->TTlIIlT("script",                  "?id=");
        $vMod->TTlIIlT("relative_module",         array("##modId##_cat", "id_cat"));

// } [ami_files|files]
// [ami_files|files|cat] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->setProperty('sort_fields',               array('name', 'public', 'position'));
        $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "top", "bottom", "up", "down", "repair", "publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesModule", "ModuleFilesCat"));
        $vMod->SetProperty("stop_arg_names",            array("catid" => "##modId##", "id" => "##parentModId##"));
        $vMod->SetProperty("search_by_parent",          true);
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('name', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('name', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "name");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "");
        $vMod->TTlIIlT("script",                  "?id=");

// } [ami_files|files|cat]
// [ami_data_exchange|files] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        //$vMod->SetAdminAllowed(1);
        $vMod->SetProperty("actions",                   "apply");
        $vMod->SetProperty("engine_classes",            array("CMS_FilesImportModule", "CMS_IteratorArray", "CMS_IteratorFiles", "ModuleFilesImport"));
        $vMod->SetProperty('skip_filter',               true);
        $vMod->SetProperty("admin_only",                true);
        $vMod->SetProperty("allowed_exchange_drivers",  "FilesExchangeDriver");
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off

// } [ami_data_exchange|files]
// [ami_relations|relations] {

    $vMod = &$Core->GetModule('##modId##');
        $vMod->setProperty('sort_fields',               array('module'));
        $vMod->SetProperty('actions',                   array ('edit','add','apply','save', 'del', 'publish', 'publish_on','publish_off', 'reply'));
        $vMod->SetProperty('taborder',                  '##taborder##');
        $vMod->SetProperty('dont_show_in_pm',           true);
        $vMod->SetProperty('cache_front_post',          'not expire');
        $vMod->SetProperty('engine_classes',            'ModuleRelations');
        $vMod->SetProperty('spec_blocks',               array ('spec_small_##modId##'));
        $vMod->SetProperty('possible_modules_list',     array (
                                                            'eshop_item', 'eshop_cat',                                  // eshop
                                                            'kb_item', 'kb_cat',                                        // kb
                                                            'portfolio_item', 'portfolio_cat'                           // portfolio
                                                        )
        );
        $vMod->SetProperty('help_on', true);
        $vMod->SetProperty('restrict_web_access_by_rights', TRUE);

// } [ami_relations|relations]
// [ami_ext|category] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty(
            'hypermod_subtypes',
            array(
                'ami_multifeeds'    => array('root' => true, 'cat' => true),
                'ami_multifeeds5'   => array('root' => true, 'cat' => true),
                'ami_data_exchange' => array('root' => true, 'cat' => true)
            )
        );
        // $vMod->SetProperty("subtypes_table_affected_fields", array('root' => array(), 'cat' => array()));

// } [ami_ext|category]
// [ami_ext|adv] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty(
            'hypermod_subtypes',
            array(
                'ami_multifeeds'  => array('root' => true, 'cat' => true),
                'ami_multifeeds5' => array('root' => true, 'cat' => true)
            )
        );
        // $vMod->SetProperty("subtypes_table_affected_fields", array('root' => array(), 'cat' => array()));

// } [ami_ext|adv]
// [ami_ext|reindex] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty('class',                     'ExtReindex');
        $vMod->SetProperty(
            'hypermod_subtypes',
            array(
                'ami_multifeeds'  => array('root' => true, 'cat' => true),
                'ami_multifeeds5' => array('root' => true, 'cat' => true),
                'ami_catalog'     => array('root' => true, 'cat' => true)
            )
        );
        // $vMod->SetProperty("subtypes_table_affected_fields", array('root' => array(), 'cat' => array()));

// } [ami_ext|reindex]
// [ami_ext|discussion] {

    $vMod = &$Core->GetModule('##modId##');
        $vMod->SetProperty('class',                     'ExtDiscussion');
        $vMod->SetProperty('dont_show_in_pm',           true);
        $vMod->SetProperty(
            'hypermod_subtypes',
            array(
                'ami_multifeeds'  => array('root' => true, 'cat' => true),
                'ami_multifeeds5' => array('root' => true, 'cat' => true),
                'ami_catalog'     => array('root' => TRUE, 'cat' => FALSE)
            )
        );
        // $vMod->SetProperty("subtypes_table_affected_fields", array('root' => array('disable_comments'), 'cat' => false));

// } [ami_ext|discussion]
// [ami_ext|rating] {

    $vMod = &$Core->GetModule('##modId##');
        $vMod->SetProperty("class",                     "ExtRating");
        $vMod->SetProperty('always_allowed',            true); // for sys right modules
        $vMod->SetProperty(
            'hypermod_subtypes',
            array(
                'ami_multifeeds'  => array('root' => true, 'cat' => true),
                'ami_multifeeds5' => array('root' => true, 'cat' => true),
                'ami_catalog'     => array('root' => true, 'cat' => true)
            )
        );
        // $vMod->SetProperty("subtypes_table_affected_fields", array('root' => array('rate_opt', 'votes_rate', 'votes_count', 'votes_weight'), 'cat' => array('rate_opt', 'votes_rate', 'votes_count', 'votes_weight')));

// } [ami_ext|rating]
// [ami_ext|image] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty(
            'hypermod_subtypes',
            array(
                'ami_multifeeds'  => array('root' => true, 'cat' => true),
                'ami_multifeeds5' => array('root' => true, 'cat' => true),
                'ami_catalog'     => array('root' => true, 'cat' => true)
            )
        );
        // $vMod->SetProperty("subtypes_table_affected_fields", array('root' => array(), 'cat' => array()));

// } [ami_ext|image]
// [ami_ext|tags] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty("class",                     array("ModuleTags", "ExtTags"));
        // $vMod->SetProperty("taborder",               2500);
        // $vMod->SetProperty("srv_order_allow",        0);
        $vMod->SetProperty("help_on",                   false);
        $vMod->SetProperty("allow_double_in_pm",        false);
        $vMod->SetProperty('dont_show_in_pm',           true);
        $vMod->SetProperty(
            'hypermod_subtypes',
            array(
                'ami_multifeeds'  => array('root' => true, 'cat' => true),
                'ami_multifeeds5' => array('root' => true, 'cat' => true)
            )
        );
        // $vMod->SetProperty("subtypes_table_affected_fields", array('root' => array('tags'), 'cat' => array('tags')));

// } [ami_ext|tags]
// [ami_ext|relations] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty('class',                     'ExtRelations');
        $vMod->SetProperty('dont_show_in_pm',           true);
        $vMod->SetProperty('drop_cache_on_actions',     array('add', 'del', 'del_all', 'apply', 'publish', 'archive', 'repair', 'grp_del', 'grp_publish_on', 'grp_publish_off', 'grp_archive_on', 'grp_archive_off', 'grp_gen_sublink', 'grp_id_page'));
        $vMod->SetProperty('always_allowed',            true); // for sys right modules
        $vMod->SetProperty(
            'hypermod_subtypes',
            array(
                'ami_multifeeds'  => array('root' => true, 'cat' => true),
                'ami_multifeeds5' => array('root' => true, 'cat' => true),
                'ami_files'       => array('root' => true, 'cat' => true),
                'ami_catalog'     => array('root' => true, 'cat' => true)
            )
        );
        // $vMod->SetProperty("subtypes_table_affected_fields", array('root' => array(), 'cat' => array()));

// } [ami_ext|relations]
// [ami_ext|ce_page_break] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty("class", "ExtCePageBreak");
        $vMod->SetProperty(
            'hypermod_subtypes',
            array(
                'ami_multifeeds'  => array('root' => true, 'cat' => true),
                'ami_multifeeds5' => array('root' => true, 'cat' => true),
                'ami_catalog'     => array('root' => true, 'cat' => true)
            )
        );

// } [ami_ext|ce_page_break]
// [ami_antispam|antispam] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        $vMod->setProperty('sort_fields',               array('date', 'module_name', 'ip', 'vid', 'is_generated', 'session', 'twist', 'reason'));
        $vMod->SetProperty("engine_classes",            "ModuleTwistPrevention");
        $vMod->SetProperty("help_on",                   false); // Turning help on \ off
        $vMod->SetProperty("taborder",                  '##taborder##');

// } [ami_antispam|antispam]
// [ami_ext|antispam] {
//
    // TWIST PREVENTION extension module constants
    $vMod = &$Core->GetModule("##modId##");
        // Extension class name
        $vMod->SetProperty("class",              "ExtTwistPrevention");
        $vMod->SetProperty("no_captcha_actions", array("rate"));
        $vMod->SetProperty(
            'hypermod_subtypes',
            array(
                'ami_multifeeds'  => array('root' => true, 'cat' => true),
                'ami_multifeeds5' => array('root' => true, 'cat' => true),
                'ami_catalog'     => array('root' => true, 'cat' => true)
            )
        );

// } [ami_ext|antispam]
// [ami_multifeeds5|jobs] {

    $vMod = &$Core->GetModule("##modId##");

        // Set properties
        $vMod->SetProperty("unsupported_extensions",    array('ext_twist_prevention', 'image', 'discussion', 'ce_page_break', 'rating', 'relations', 'tags', 'adv'));
        $vMod->setProperty('sort_fields',               array('date', 'public', 'date_expire', 'name', 'category_name', 'salary', 'archive', 'status', 'position'));
        $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "repair", "publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesFunctions", "ModuleJobs"));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("stop_arg_names",            array("id" => "jobs"));
        $vMod->SetProperty("stop_arg_filters",          array("jobs" => "id_cat=%catid"));
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("spec_blocks",               array("spec_small_jobs"));
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty("rss_link_smallblock",       false); // Extension RSS
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array(array('name', 'duty'), 'requirements1', 'requirements1'));
        $vMod->TTlIIlT('index_fields',            array('name', 'duty', 'requirements1', 'requirements1'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "name");
        $vMod->TTlIIlT("announce",                "duty");
        $vMod->TTlIIlT("robots_noindex_field",    "details_noindex");
        $vMod->TTlIIlT("script",                  "?id=");
        $vMod->TTlIIlT('relative_module',         array('jobs_cat', 'id_cat'));
        // $vMod->SetSearchData('date_modified', 'date_modified');
        // $vMod->SetSearchData('hide_in_list', 'hide_in_list');

// } [ami_multifeeds5|jobs]
// [ami_multifeeds5|jobs|cat] {

    $vMod = &$Core->GetModule("##modId##");
        // Set properties
        $vMod->SetProperty("unsupported_extensions",    array('ext_twist_prevention', 'image', 'discussion', 'ce_page_break', 'rating', 'relations', 'tags', 'ext_rss', 'adv'));
        $vMod->setProperty('sort_fields',               array('name', 'public', 'position'));
        $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "top", "bottom", "up", "down", "repair","publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesModule", "ModuleJobsCat"));
        $vMod->SetProperty("stop_arg_names",            array("catid" => "jobs_cat", "id" => "jobs"));
        $vMod->SetProperty("search_by_parent",          true);
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('name', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('name', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "name");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "");
        $vMod->TTlIIlT("script",                  "?id=");
        // $vMod->SetSearchData('date_modified', 'date_modified');
        // $vMod->SetSearchData('hide_in_list', 'hide_in_list');

// } [ami_multifeeds5|jobs|cat]
// [ami_jobs|history|history] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',               array('date', 'title', 'jobname', 'department'));
        $vMod->SetProperty("actions",                   array("edit", "add", "apply", "save", "del", "gen_sublink", "gen_keywords", "view", "print", "print_confirm", "reply"));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesFunctions", "ModuleJobsHistory"));
        $vMod->SetProperty("stop_use_sublinks",         false);
        $vMod->SetProperty("cache_front_post",          "not expire");
        $vMod->SetProperty("custom_fields_prefix",      "custom_field");
        $vMod->SetProperty("fields_name",               array("firstname", "lastname", "email", "phone", "resume", "resume_attach", "resume_addon"));
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty('actions', array('edit'));

// } [ami_jobs|history|history]
// [ami_jobs|resume|resume] {

    $vMod = &$Core->GetModule("##modId##");

        // Set properties
        $vMod->setProperty('sort_fields',               array('date', 'public', 'jobname', 'title', 'category_name'));
        $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "repair", "publish_on", "publish_off", "gen_sublink", "gen_keywords", "view", "print", "print_confirm", "reply"));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesFunctions", "ModuleJobsResume"));
        $vMod->SetProperty("stop_arg_names",            array("id" => "jobs_resume"));
        $vMod->SetProperty("stop_arg_filters",          array("jobs_resume" => "id_cat=%catid"));
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("spec_blocks",               array("spec_small_jobs_resume"));
        $vMod->SetProperty("cache_front_post",          "not expire");
        $vMod->SetProperty("fields_name",               array("fname", "lname", "email", "website", "phone", "resume", "addon"));
        $vMod->SetProperty("use_special_list_view",     true);
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        // Specifies real module for modules custom fields extension
        // @see ExtModulesCustomFields::init()
        $vMod->SetProperty('ext_mod_cf_module',         'jobs');

// } [ami_jobs|resume|resume]
// [ami_jobs|employer|employer] {

    $vMod = &$Core->GetModule("##modId##");

        // Set properties
        $vMod->setProperty('sort_fields',               array('date', 'name', 'jobname'));
        $vMod->SetProperty("actions",                   array("edit", "add", "apply", "save", "del", "gen_sublink", "gen_keywords", "view", "print", "print_confirm", "reply"));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesFunctions", "ModuleJobsEmployer"));
        $vMod->SetProperty("stop_use_sublinks",         false);
        $vMod->SetProperty("cache_front_post",          "not expire");
        $vMod->SetProperty("custom_fields_prefix",      "custom_field");
        $vMod->SetProperty("fields_name",               array("name", "department", "fname", "lname", "email", "website", "phone", "addon"));
        $vMod->SetProperty("help_on",                   true);
        $vMod->SetProperty('twist_actions',             array('add'));

// } [ami_jobs|employer|employer]
// [ami_votes|votes] {

    $vMod = &$Core->GetModule("##modId##");

        // Set properties
        $vMod->setProperty('sort_fields',               array('public', 'date_start', 'date_end', 'question', 'total', 'status', 'position'));
        $vMod->SetProperty("engine_classes",            "ModuleVotes");
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("spec_blocks",               Array("spec_small_votes"));
        $vMod->SetProperty("cache_front_post",          "expire special");
        $vMod->SetProperty("prefix",                    "cms_vote");
        $vMod->SetProperty("actions",                   array("edit", "add", "apply", "save", "del", "publish", "publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("help_on",                   true);
        $vMod->SetProperty('twist_actions',             array('add')); // Array of actions to protect from SPAM (extension twist_prevention)

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('question'));
        $vMod->TTlIIlT('index_fields',            array('question'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "question");
        $vMod->TTlIIlT("announce",                '');
        $vMod->TTlIIlT("robots_noindex_field",    "details_noindex");
        $vMod->TTlIIlT("script",                  "?id=");

// } [ami_votes|votes]
// [ami_subscribe|subscribe] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',               array('date', 'active', 'firstname', 'lastname', 'email', 'username'));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("spec_blocks",               array("spec_small_subscribe"));
        $vMod->SetProperty("cache_front_post",          "not expire");
        $vMod->SetProperty("help_on",                   true);
        $vMod->SetProperty('twist_actions',             array('signup')); // Array of actions to protect from SPAM (extension twist_prevention)

        // specail value for module reindex skipping
        $vMod->TTlIIl1('module', 'skip_reindex_main', true);

        $Core->SetModProperty('members', 'dependent_modules',
            array_merge_recursive(
                $Core->GetModProperty('members', 'dependent_modules'),
                array(
                    'get_count' =>      array('subscribe'),
                    'del' =>            array('subscribe'),
                    'small' =>          array('subscribe'),
                    'dependent' =>      array('subscribe'),
                    'clear_cache' =>    array('subscribe')
                )
            )
        );

// } [ami_subscribe|subscribe]
// [ami_subscribe|topic|topic] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',               array('active', 'name', 'public', 'free'));
        $vMod->TTlIIl1('module',                  'skip_reindex_main', true); // specail value for module reindex skipping
        $vMod->SetProperty("cache_front_post",          "not expire");
        $vMod->SetProperty("help_on",                   true);

// } [ami_subscribe|topic|topic]
// [ami_subscribe|send|send] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',               array('date', 'subject', 'topic', 'send_to', 'attach', 'attempts_left'));
        $vMod->SetProperty("cache_front_post",          "not expire");
        $vMod->SetProperty("admin_only",                true);
        $vMod->SetProperty("help_on",                   true);

        // specail value for module reindex skipping
        $vMod->TTlIIl1('module', 'skip_reindex_main', true);

// } [ami_subscribe|send|send]
// [ami_subscribe|export|export] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty("admin_only",                true);
        $vMod->SetProperty("help_on",                   true);

        // specail value for module reindex skipping
        $vMod->TTlIIl1('module', 'skip_reindex_main', true);

// } [ami_subscribe|export|export]
// [ami_search|search] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',               array('create_date', 'update_date', 'query', 'quantity', 'count_pages'));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("spec_blocks",               array("spec_small_search"));
        $vMod->SetProperty("cache_ignore_spec_blocks",  array("spec_small_search"));
        $vMod->SetProperty("help_on",                   true);
        $vMod->SetProperty("actions",                   array("del", "view"));
        $vMod->SetProperty("engine_classes",            "ModuleSearch");
        $vMod->SetProperty("function_class",            "ModuleSearchFunctions");

// } [ami_search|search]
// [ami_search|search|reindex] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty("actions",                   "reindex");
        $vMod->SetProperty("engine_classes",            "ModuleReindex");
        $vMod->SetProperty("function_class",            "ModuleReindexFunctions");
        $vMod->SetProperty('skip_filter',               true);
        $vMod->SetProperty("help_on",                   true);
        // $vMod->SetProperty("srv_order_allow",        0);
        // $vMod->AddDataCustom("details", "where", "public=1");

// } [ami_search|search|reindex]
// [ami_feedback|feedback] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',               array('date', 'info', 'author', 'email'));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("cache_front_post",          "not expire");
        $vMod->SetProperty("help_on",                   true);
        $vMod->SetProperty("actions",                   array("del"));
        $vMod->SetProperty("engine_classes",            "ModuleFeedback");
        $vMod->SetProperty('twist_actions',             array('add')); // Array of actions to protect from SPAM (extension twist_prevention)

// } [ami_feedback|feedback]
// [ami_datasets|datasets] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',               array('module_name', 'name'));
        $vMod->SetProperty('engine_classes',            array('CMS_API_ModulesCustomFields', 'ModuleModulesDatasets'));
        $vMod->SetProperty('taborder',                  '##taborder##');
        $vMod->SetProperty('help_on',                   true);
        $vMod->SetProperty('hardcoded_fields',          array('Vsplitter' => '5', 'Hsplitter' => '6', 'Sblock' => '7', 'Fblock' => '8'));
        $vMod->SetProperty('splitter_after',            1);

// } [ami_datasets|datasets]
// [ami_fake|datasets] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty('engine_classes',            array('CMS_API_ModulesCustomFields', 'ModuleModulesDatasetsPopup'));
        $vMod->SetProperty('help_on',                   false);
        $vMod->SetProperty('dont_show_in_pm',           true);

// } [ami_fake|datasets]
// [ami_datasets|custom_fields] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',               array('public', 'module_name', 'system_name', 'ftype', 'value_type', 'default_gui_type'));
        $vMod->SetProperty('engine_classes',            array('CMS_API_ModulesCustomFields', 'ModuleModulesCustomFields'));
        $vMod->SetProperty('help_on',                   true);

// } [ami_datasets|custom_fields]
// [ami_ext|custom_fields] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty('class', 'ExtModulesCustomFields');
        $vMod->SetProperty(
            'hypermod_subtypes',
            array(
                'ami_multifeeds'  => array('root' => true, 'cat' => true),
                'ami_multifeeds5' => array('root' => true, 'cat' => true)
            )
        );
        // $vMod->SetProperty("subtypes_table_affected_fields", array('root' => array(), 'cat' => array()));

// } [ami_ext|custom_fields]
// [ami_multifeeds5|classifieds] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty("unsupported_extensions",    array('discussion', 'ce_page_break', 'rating', 'relations', 'tags'));
        $vMod->setProperty('sort_fields',               array('date_start', 'public', 'header', 'position'));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("actions",                   array("publish", "archive", "add", "edit", "apply", "save", "del", "repair", "publish_on", "publish_off", "archive_on", "archive_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesFunctions", "ModuleClassifieds"));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("stop_arg_names",            array("id" => "classifieds"));
        $vMod->SetProperty("stop_arg_filters",          array("classifieds" => "id_cat=%catid"));
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("spec_blocks",               array("spec_small_classifieds"));
        $vMod->SetProperty("archive_field",             "date"); // Archive field name
        $vMod->SetProperty("support_rights",            true); // Suport item rights
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("required_fields",           array("header", "announce", "cat_id")); // Required fields (it is used now for audit module ONLY)
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty('twist_actions',             array('add')); // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('picture_cat',               'classifieds'); // Front pictures folder
        $vMod->SetProperty("rss_link_smallblock",       false); // Extension RSS
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array(array('header', 'author'), 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('header', 'author', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "header");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("relative_module",         array("classifieds_cat", "id_cat"));
        $vMod->TTlIIlT("robots_noindex_field",    "details_noindex");
        $vMod->TTlIIlT("script",                  "?id=");
        // $vMod->SetSearchData('date_modified', 'date_modified');
        // $vMod->SetSearchData('hide_in_list', 'hide_in_list');

// } [ami_multifeeds5|classifieds]
// [ami_multifeeds5|classifieds|cat] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty("unsupported_extensions",    array('discussion', 'ce_page_break', 'rating', 'relations', 'tags', 'ext_rss'));
        $vMod->setProperty('sort_fields',               array('name', 'public', 'position'));
        $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "top", "bottom", "up", "down", "repair", "publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesModule", "ModuleArticlesCat"));
        $vMod->SetProperty("stop_arg_names",            array("catid" => "classifieds_cat", "id" => "classifieds"));
        $vMod->SetProperty("search_by_parent",          true);
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("help_on",                   false); // Turning help on \ off
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('name', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('name', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "name");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "");
        $vMod->TTlIIlT("script",                  "?id=");
        // $vMod->SetSearchData('date_modified', 'date_modified');
        // $vMod->SetSearchData('hide_in_list', 'hide_in_list');

// } [ami_multifeeds5|classifieds|cat]
// [ami_login_history|login_history] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        $vMod->setProperty('sort_fields',               array('date', 'login', 'domain', 'status', 'ip'));
        $vMod->SetProperty("admin_only",                true);
        $vMod->SetProperty("not_suspend",               true);
        $vMod->SetProperty("taborder",                  '##taborder##');

// } [ami_login_history|login_history]
// [ami_tags|tags] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',               array('tag', 'count'));
        $vMod->SetProperty("function_class",            "ModuleSearchFunctions");
        $vMod->SetProperty("engine_classes",            "ModuleTags");
        $vMod->SetProperty("class",                     "ModuleTags");
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("stop_arg_names",            array("id" => "srv_tags"));
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("actions",                   array("gen_sublink", "gen_keywords", "add", "apply", "edit", "cancel"));
        $vMod->SetProperty("spec_blocks",               array("spec_small_tags"));
        $vMod->SetProperty("help_on",                   false);
        $vMod->SetProperty("allow_double_in_pm",        false);
        $vMod->SetProperty('restrict_web_access_by_rights', TRUE);

// } [ami_tags|tags]
// [ami_tags|tags|reindex] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty("actions",                   "reindex");
        $vMod->SetProperty("engine_classes",            "ModuleTagsReindex");
        $vMod->SetProperty("function_class",            "ModuleReindexFunctions");
        $vMod->SetProperty('skip_filter',               true);
        $vMod->SetProperty("help_on",                   true);

// } [ami_tags|tags|reindex]
// [ami_page_manager|layouts] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields',               array('name', 'is_default'));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("admin_only",                true);
        $vMod->SetProperty("help_on",                   false);
        // $vMod->SetProperty("srv_order_allow",        0);

// } [ami_page_manager|layouts]
// [ami_clean|templates] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        $vMod->setProperty('sort_fields',               array('date', 'name'));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("admin_only",                true);
        $vMod->SetProperty("help_on",                   false);
        $vMod->SetProperty("splitter_before",           1);

// } [ami_clean|templates]
// [ami_modules_templates|templates] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->setProperty('sort_fields',               array('path', 'name', 'module', 'modified'));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("admin_only",                true);
        $vMod->SetProperty("engine_classes",            array("CMS_ModulesTemplates", "ModuleModulesTemplates"));
        $vMod->SetProperty("help_on",                   false);

// } [ami_modules_templates|templates]
// [ami_modules_templates|langs] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->setProperty('sort_fields',               array('path', 'name', 'module', 'modified'));
        $vMod->SetProperty("admin_only",                true);
        $vMod->SetProperty("engine_classes",            array("CMS_ModulesTemplates", "ModuleModulesTemplatesLangs"));
        $vMod->SetProperty("help_on",                   false);

// } [ami_modules_templates|langs]
// [ami_fake|google_sitemap] {

    $vMod = &$Core->GetModule("##modId##");
        // Set properties
        $vMod->SetProperty("function_class",            "ModuleGoogleSitemapFunctions");
        $vMod->SetProperty("engine_classes",            "ModuleGoogleSitemap");
        $vMod->SetProperty("class",                     "ModuleGoogleSitemap");
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("actions",                   "gen_sitemap");
        $vMod->SetProperty('skip_filter',               true);
        $vMod->SetProperty("sitemaps_disabled",         false);
        $vMod->SetProperty("help_on",                   false);
        $vMod->SetProperty("allow_double_in_pm",        false);
        $vMod->SetProperty("possible_sitemap_modules",  array("news", "blog", "articles", "photoalbum", "faq", "classifieds", "feedback", "votes", "files", "discussion", "forum", "guestbook", "jobs", "eshop", "portfolio", "kb", "pages"));
        // $vMod->SetProperty("srv_order_allow",        0);

// } [ami_fake|google_sitemap]
// [ami_sitemap_history|sitemap_history] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->setProperty('sort_fields',               array('date', 'action', 'time', 'status'));
        $vMod->SetProperty("actions",                   array("del", "view"));
        $vMod->SetProperty("engine_classes",            "ModuleSitemapHistory");
        $vMod->SetProperty("fields_name",               array("date", "action", "time", "status"));

// } [ami_sitemap_history|sitemap_history]
// [ami_discussion|guestbook] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields', array('date', 'public', 'subject', 'author'));
        // Set parameters for search index
        $vMod->TTlIIlT('index', array('subject', 'author', 'message'));
        $vMod->TTlIIlT('index_fields', array('subject', 'author', 'message'));
        $vMod->TTlIIlT("public_field", "public");
        $vMod->TTlIIlT("title", "subject");
        $vMod->TTlIIlT("announce", "author");
        $vMod->TTlIIlT("robots_noindex_field", "");
        $vMod->TTlIIlT("script", "?id=");
        $vMod->SetProperty('actions', array('edit','add','apply','save', 'del', 'publish', 'publish_on','publish_off', 'reply'));
        $vMod->SetProperty('engine_classes', array('CMS_Forum', 'CMS_Discussion', 'ModuleGuestbook'));
        $vMod->SetProperty("taborder", '##taborder##');
        $Core->SetModProperty('members', 'dependent_modules', array_merge_recursive($Core->GetModProperty('members', 'dependent_modules'), array (
            'create'      => array('guestbook'),
            'update'      => array('guestbook'),
            'get_count'   => array('guestbook'),
            'del'         => array('guestbook'),
            'dependent'   => array('guestbook'),
            'clear_cache' => array('guestbook')
        )));
                // Turning help on \ off
        $vMod->SetProperty('help_on', true);
                // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('twist_actions', array ('add'));

// } [ami_discussion|guestbook]
// [ami_discussion|discussion] {

    $vMod = &$Core->GetModule("##modId##");
    $vMod->setProperty('sort_fields', array('date', 'public', 'author', 'count_public_children'));
    $vMod->SetProperty('restrict_web_access_by_rights', TRUE);
    // Set parameters for search index
    $vMod->TTlIIlT('index', array('topic', 'author', 'message'));
    $vMod->TTlIIlT('index_fields', array('topic', 'author', 'message'));
    $vMod->TTlIIlT("public_field", "public");
    $vMod->TTlIIlT("title", "topic");
    $vMod->TTlIIlT("announce", "message");
    $vMod->TTlIIlT("robots_noindex_field", "");
    $vMod->TTlIIlT("script", "?id=");

    $vMod->SetProperty('actions', array('edit', 'add', 'apply', 'save', 'del', 'publish', 'publish_on', 'publish_off', 'reply'));

    $vMod->SetProperty('engine_classes', array('CMS_Forum', 'CMS_Discussion', 'ModuleDiscussion'));
    $vMod->SetProperty("taborder", '##taborder##');
    $vMod->SetProperty('dont_show_in_pm', true);
    $vMod->SetProperty('cache_front_post', 'not expire');

    $vMod->SetProperty('stop_use_sublinks', true);
    $vMod->SetProperty('stop_arg_names', array('id' => 'discussion'));
    $Core->SetModProperty('members', 'dependent_modules', array_merge_recursive($Core->GetModProperty('members', 'dependent_modules'), array(
        'create'      => array ('discussion'),
        'update'      => array ('discussion'),
        'get_count'   => array ('discussion'),
        'del'         => array ('discussion'),
        'dependent'   => array ('discussion'),
        'clear_cache' => array ('discussion')
    )));
            // Turning help on \ off
    $vMod->SetProperty('help_on', true);
            // Array of actions to protect from SPAM (extension twist_prevention)
    $vMod->SetProperty('twist_actions', array ('forum_add'));

// } [ami_discussion|discussion]
// [ami_forum|forum] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields', array('date', 'public', 'topic', 'author', 'locked', 'msg_date', 'msg_answers'));
        // Set parameters for search index
        $vMod->TTlIIlT('index', array('topic', 'author', 'message'));
        $vMod->TTlIIlT('index_fields', array('topic', 'author', 'message'));
        $vMod->TTlIIlT("public_field", "public");
        $vMod->TTlIIlT("title", "topic");
        $vMod->TTlIIlT("announce", "message");
        $vMod->TTlIIlT("relative_module", array("forum_cat", "id_cat"));
        $vMod->TTlIIlT("robots_noindex_field", "details_noindex");
        $vMod->TTlIIlT("script", "?id=");

        $vMod->SetProperty('actions', array (
            'edit', 'add', 'apply', 'save', 'del', 'publish', 'publish_on', 'publish_off',
            'gen_sublink','gen_keywords', 'lock', 'lock_on', 'lock_off', 'reply'
        ));

        $vMod->SetProperty('engine_classes', array ('CMS_Forum', 'CMS_CategoriesFunctions', 'ModuleForum'));
        $vMod->SetProperty("taborder", '##taborder##');
        $vMod->SetProperty('cache_front_post', 'not expire');

        $vMod->SetProperty('stop_use_sublinks', true);
        $vMod->SetProperty('stop_arg_names', array ('id' => 'forum'));
        $vMod->SetProperty('stop_arg_filters', array ('forum' => 'id_cat=%catid'));
        $vMod->SetProperty('spec_blocks', array ('spec_small_forum'));
        $Core->SetModProperty('members', 'dependent_modules', array_merge_recursive($Core->GetModProperty('members', 'dependent_modules'), array (
            'create'      => array ('forum'),
            'update'      => array ('forum'),
            'get_count'   => array ('forum'),
            'del'         => array ('forum'),
            'dependent'   => array ('forum'),
            'clear_cache' => array ('forum')
        )));

                // Turning help on \ off
        $vMod->SetProperty('help_on', true);
                // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty('use_special_list_view', true);
                // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('twist_actions', array ('add'));

// } [ami_forum|forum]
// [ami_forum|forum|cat] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields', array('name', 'public', 'position'));
        // Set parameters for search index
        $vMod->TTlIIlT('index', array('name', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields', array('name', 'announce', 'body'));
        $vMod->TTlIIlT("public_field", "public");
        $vMod->TTlIIlT("title", "name");
        $vMod->TTlIIlT("announce", "announce");
        $vMod->TTlIIlT("robots_noindex_field", "");
        $vMod->TTlIIlT("script", "?id=");

        $vMod->SetProperty('actions', array (
            'publish', 'add', 'edit', 'apply', 'save', 'del', 'top', 'bottom', 'up', 'down', 'repair',
            'publish_on', 'publish_off', 'gen_sublink', 'gen_keywords'
        ));
        $vMod->SetProperty('engine_classes', array ('CMS_CategoriesModule', 'ModuleForumCat'));
        $vMod->SetProperty('stop_arg_names', array('catid'=>'forum_cat', 'id'=>'forum'));
        $vMod->SetProperty( 'search_by_parent',        true);
                // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty('use_special_list_view', true);
                // Turning help on \ off
        $vMod->SetProperty('help_on',                  false);

// } [ami_forum|forum|cat]
// [ami_data_exchange|forum] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty('engine_classes', array ('CMS_CategoriesFunctions', 'CMS_DataExchangeModule', 'ModuleForumDataExchange'));
        $vMod->SetProperty('dont_show_in_pm', true);
//                $vMod->SetProperty('srv_order_allow', 0);
        $vMod->SetProperty('grp_ids_field', '_grp_ids');
        $vMod->SetProperty('skip_filter', true);
        $vMod->SetProperty('import_sleep_params', array ('default' => array('sleep_time' => 2, 'sleep_pereod' => 20)));
        $vMod->SetProperty('allowed_exchange_drivers', 'ForumBBExchangeDriver');
                // Turning help on \ off
        $vMod->SetProperty('help_on', true);

// } [ami_data_exchange|forum]
// [ami_eshop_discounts|discounts] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields', array('public', 'name', 'kind', 'condition', 'date_start', 'date_end', 'amount', 'categories_count'));
        $vMod->SetProperty("engine_classes", "ModuleEshopDiscounts");
        $vMod->SetProperty("taborder", '##taborder##');
        $vMod->SetProperty("actions", array("publish", "add", "edit", "copy", "apply", "save", "del", "publish_on", "publish_off"));
        $vMod->SetProperty("help_on", false);

// } [ami_eshop_discounts|discounts]
// [ami_eshop_coupons|coupons] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields', array('date_start', 'date_end', 'activations_left', 'activation_count'));
        $vMod->SetProperty('engine_classes', array ('CMS_CategoriesFunctions', 'ModuleEshopCoupons'));
        $vMod->SetProperty('use_special_list_view', false);
        $vMod->SetProperty('actions', array ('publish', 'add', 'edit', 'copy', 'apply', 'save', 'del', 'publish_on', 'publish_off'));
        $vMod->SetProperty('use_id_external', true);
        $vMod->SetProperty('taborder', '##taborder##');
        $vMod->SetProperty('help_on', false);

// } [ami_eshop_coupons|coupons]
// [ami_eshop_coupons|coupons|cat] {

    $vMod = &$Core->GetModule("##modId##");
    $vMod->setProperty('sort_fields', array('public', 'name', 'bind_member'));
        $vMod->SetProperty('engine_classes', array ('CMS_CategoriesModule', 'ModuleEshopCouponsCat'));
        $vMod->SetProperty('use_special_list_view', false);
        $vMod->SetProperty('actions', array ('publish', 'add', 'edit', 'copy', 'apply', 'save', 'del', 'publish_on', 'publish_off'));
        $vMod->SetProperty('use_id_external', true);
        $vMod->SetProperty('help_on', false);

// } [ami_eshop_coupons|coupons|cat]
// [ami_eshop_shipping|methods] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields', array('position', 'name', 'amount', 'delivery_time', 'custom_conditions', 'regions_count'));
        $vMod->SetProperty("engine_classes", "ModuleEshopShippingMethods");
        $vMod->SetProperty("taborder", '##taborder##');
        $vMod->SetProperty("help_on", true);
        $vMod->SetProperty("splitter_after", 1);

// } [ami_eshop_shipping|methods]
// [ami_eshop_shipping|types] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->setProperty('sort_fields', array('is_default', 'name', 'methods_count'));
        $vMod->SetProperty("engine_classes", "ModuleEshopShippingTypes");
        $vMod->SetProperty("taborder", '##taborder##');
        $vMod->SetProperty("help_on", true);

// } [ami_eshop_shipping|types]
// [ami_eshop_shipping|fields] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty("taborder", '##taborder##');
        $vMod->SetProperty("help_on", true);

// } [ami_eshop_shipping|fields]
// [ami_eshop_tax|classes] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        $vMod->setProperty('sort_fields', array('is_default', 'name', 'tax_rate', 'tax_class_code', 'tax_apply_type'));
        $vMod->SetProperty('engine_classes', array('ModuleTaxes', 'ModuleTaxClasses'));
        $vMod->SetProperty("taborder", '##taborder##');
        $vMod->SetProperty("help_on", true);
        $vMod->SetProperty("splitter_after", 1);

// } [ami_eshop_tax|classes]
// [ami_eshop_tax|zones] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        $vMod->setProperty('sort_fields', array('is_default', 'name', 'zip', 'country', 'state', 'tax_rate'));
        $vMod->SetProperty('engine_classes', array('ModuleTaxes', 'ModuleTaxZones'));
        $vMod->SetProperty('use_special_list_view', false);
        $vMod->SetProperty('actions', array('add', 'edit', 'apply', 'save', 'del'));
        $vMod->SetProperty('taborder', '##taborder##');
        $vMod->SetProperty('help_on', false);

// } [ami_eshop_tax|zones]
// [ami_ext|eshop_custom_fields] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty('class',                     'ExtEshopCustomFields');
// } [ami_ext|eshop_custom_fields]
// [ami_ext|kb_custom_fields] {
    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty('class',                     'ExtEshopCustomFields');
// } [ami_ext|kb_custom_fields]
// [ami_ext|portfolio_custom_fields] {
    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty('class',                     'ExtEshopCustomFields');
// } [ami_ext|portfolio_custom_fields]
// [ami_clean|ami_seopult] {
    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        // Module order in admin control panel
        $vMod->setProperty('taborder', 3000 /*'##taborder##'*/);
        // Seopult server addresses
        $vMod->setProperty('register_url', 'http://i.seopult.pro/iframe/getCryptKeyWithUserReg');
        $vMod->setProperty('login_url', 'http://i.seopult.pro/iframe/cryptLogin');

// } [ami_clean|ami_seopult]
// [ami_ext|rss] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty("class", "ExtRSS");
        $vMod->SetProperty("rss_image_ext",  Array("gif","jpeg","png"));
        $vMod->SetProperty("rss_style_ext",  Array("css"));
        $vMod->SetProperty("rss_image_maxsize",  Array("width" => 144, "height" => 400));
        $vMod->SetProperty("rss_channel_dir",  "_img/");
        $vMod->SetProperty("rss_code_lang",  Array("en"=>"iso-8859-1", "gr"=>"el", "cn"=>"zh-cn"));
        $vMod->SetProperty(
            'hypermod_subtypes',
            array(
                'ami_multifeeds'  => array('root' => true, 'cat' => true),
                'ami_multifeeds5' => array('root' => true, 'cat' => true)
            )
        );
        $vMod->SetProperty('always_allowed', true);

// } [ami_ext|rss]
// [ami_fake|rss] {

    $vMod = &$Core->GetModule("##modId##");
        $vMod->SetProperty("engine_classes", "ModuleExtRssRules");
        $vMod->SetProperty('always_allowed', true);

// } [ami_fake|rss]
// [ami_async|private_messages] {

    $vMod = &$Core->GetModule('##modId##');
        $vMod->setProperty('sort_fields', array('date_created', 'is_read', 'id_recipient'));
        $vMod->SetProperty('taborder', '##taborder##');

        $vMod->TTlIIl1('module', 'skip_reindex_main', TRUE); // specail value for module reindex skipping
        $vMod->SetProperty('cache_front_post', 'not expire');

        // 6.0: supported module front modes
        $vMod->SetProperty('front_request_types', array('ajax', 'plain'));
        // Turning help on \ off
        $vMod->SetProperty('help_on', TRUE);

// } [ami_async|private_messages]
// [ami_clean|ami_market] {

    $vMod = &$Core->GetModule('##modId##');
    $vMod->SetProperty('taborder', '##taborder##');
    // Disallow in system modules rights
    $vMod->SetProperty('actions', FALSE);
    $vMod = &$Core->GetModule('mod_manager');
    $vMod->SetProperty('taborder', 2000);
    // Disallow in system modules rights
    $vMod->SetProperty('actions', FALSE);

// } [ami_clean|ami_market]
// [ami_clean|data_import] {

$vMod = &$Core->GetModule("##modId##");
$oDeclarator->setupAsyncInterface($vMod);
$vMod->SetProperty('taborder', 4000);

// } [ami_clean|data_import]
// [ami_multifeeds5|articles] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        // Set properties
        $vMod->SetProperty("unsupported_extensions",    array());
        $vMod->setProperty('sort_fields',               array('date', 'public', 'header', 'cname', 'archive', 'votes_count', 'votes_rate', 'position'));
        $vMod->SetProperty("actions",                   array("publish", "archive", "add", "edit", "apply", "save", "del", "repair", "publish_on", "publish_off", "archive_on", "archive_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesFunctions", "ModuleArticles"));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("stop_arg_names",            array("id" => "##modId##"));
        $vMod->SetProperty("stop_arg_filters",          array("##modId##" => "id_cat=%catid"));
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("spec_blocks",               array("spec_small_##modId##"));
        $vMod->SetProperty("archive_field",             "date"); // Archive field name
        $vMod->SetProperty("support_rights",            true); // Suport item rights
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("required_fields",           array("header", "announce", "cat_id")); // Required fields (it is used now for audit module ONLY)
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty('twist_actions',             array('forum_add', 'rate')); // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('picture_cat',               '##modId##'); // Front pictures folder
        $vMod->SetProperty("rss_link_smallblock",       false); // RSS Extension
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array(array('header', 'author'), array('announce', 'source'), 'body'));
        $vMod->TTlIIlT('index_fields',            array('header', 'author', 'announce', 'source', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "header");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("relative_module",         array("##modId##_cat", "id_cat"));
        $vMod->TTlIIlT("robots_noindex_field",    "details_noindex");

// } [ami_multifeeds5|articles]
// [ami_multifeeds5|articles|cat] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->SetProperty('engine_classes',            array('CMS_CategoriesModule', 'ModuleArticlesCat'));
        $vMod->SetProperty("unsupported_extensions",    array('ext_twist_prevention', 'discussion', 'ce_page_break', 'tags', 'ext_rss'));
        $vMod->setProperty('sort_fields',               array('name', 'public', 'position', 'votes_count', 'votes_rate'));
        $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "top", "bottom", "up", "down", "repair","publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesModule", "ModuleArticlesCat"));
        $vMod->SetProperty("stop_arg_names",            array("catid" => "##modId##", "id" => "##parentModId##"));
        $vMod->SetProperty("search_by_parent",          true);
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("help_on",                   false); // Turning help on \ off
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('name', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('name', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "name");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "");
        $vMod->TTlIIlT("script",                  "?id=");

// } [ami_multifeeds5|articles|cat]
// [ami_multifeeds5|stickers] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->SetProperty("unsupported_extensions",    array('custom_fields', 'ext_twist_prevention', 'reindex', 'discussion', 'ce_page_break', 'rating', 'relations', 'tags', 'ext_rss', 'adv'));
        $vMod->setProperty('sort_fields',               array('public', 'header', 'announce', 'date', 'category', 'position'));
        $vMod->SetProperty("spec_blocks",               array("spec_small_##modId##"));
        $vMod->SetProperty('dont_show_in_pm',           true);
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("splitter_before",           1);
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesFunctions", "ModuleStickers"));
        $vMod->SetProperty('actions', array('edit'));

// } [ami_multifeeds5|stickers]
// [ami_multifeeds5|stickers|cat] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        $vMod->SetProperty("unsupported_extensions",    array('custom_fields', 'ext_twist_prevention', 'image', 'reindex', 'discussion', 'ce_page_break', 'rating', 'relations', 'tags', 'ext_rss', 'adv'));
        $vMod->setProperty('sort_fields',               array('name', 'announce', 'public', 'position'));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesModule", "ModuleStickersCat"));
        $vMod->SetProperty("admin_only",                true);
        $vMod->SetProperty('dont_show_in_pm',           true);
        $vMod->SetProperty('actions', array('edit'));

// } [ami_multifeeds5|stickers|cat]
// [ami_multifeeds5|news] {
    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        if(!$oDeclarator->getAttr('##modId##', 'core_v5')){
            $vMod->SetProperty('front_request_types', array('plain'));
        }

        // Set properties
        $vMod->SetProperty('stop_arg_names', array('id' => '##modId##'));
        $vMod->SetProperty("unsupported_extensions",    array());
        $vMod->setProperty('sort_fields',               array('date', 'archive', 'public', 'header', 'votes_count', 'votes_rate', 'position'));
        $vMod->SetProperty("actions",                   array("edit", "add", "apply", "save", "del", "publish", "archive", "publish_on", "publish_off","archive_on", "archive_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            "ModuleNews");
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("spec_blocks",               array("spec_small_##modId##"));
        $vMod->SetProperty("archive_field",             "date"); // Archive field name
        $vMod->SetProperty("support_rights",            true); // Suport item rights
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("required_fields",           array("header", "announce")); // Required fields (it is used now for audit module ONLY)
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty('twist_actions',             array('forum_add', 'rate')); // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('picture_cat',               'news'); // Front pictures folder
        $vMod->SetProperty("rss_link_smallblock",       true); // Extension RSS
        $vMod->SetProperty('clear_cache_on_discussion_post', array('##modId##_archive'));
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('header', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('header', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "header");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "details_noindex");
        $vMod->TTlIIlT("script",                  "?id=");

// } [ami_multifeeds5|news]
// [ami_multifeeds5|blog] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        if(!$oDeclarator->getAttr('##modId##', 'core_v5')){
            $vMod->SetProperty('front_request_types', array('plain'));
        }

        // Set properties
        $vMod->SetProperty('stop_arg_names', array('id' => '##modId##'));
        $vMod->SetProperty("unsupported_extensions",    array());
        $vMod->setProperty('sort_fields',               array('date', 'archive', 'public', 'header', 'votes_count', 'votes_rate', 'position'));
        $vMod->SetProperty("actions",                   array("edit", "add", "apply", "save", "del", "publish", "archive", "publish_on", "publish_off","archive_on", "archive_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            "ModuleNews");
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("spec_blocks",               array("spec_small_##modId##"));
        $vMod->SetProperty("archive_field",             "date"); // Archive field name
        $vMod->SetProperty("support_rights",            true); // Suport item rights
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("required_fields",           array("header", "announce")); // Required fields (it is used now for audit module ONLY)
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty('twist_actions',             array('forum_add', 'rate')); // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('picture_cat',               'blog'); // Front pictures folder
        $vMod->SetProperty("rss_link_smallblock",       true); // Extension RSS
        $vMod->SetProperty('clear_cache_on_discussion_post', array('##modId##_archive'));
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('header', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('header', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "header");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "details_noindex");
        $vMod->TTlIIlT("script",                  "?id=");

// } [ami_multifeeds5|blog]
// [ami_multifeeds5|faq] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->SetProperty("unsupported_extensions",    array('image', 'discussion', 'ce_page_break', 'rating', 'relations', 'tags', 'ext_rss', 'adv'));
        $vMod->setProperty('sort_fields',               array('date', 'public', 'author', 'subject', 'question', 'answered', 'votes_count', 'votes_rate', 'position'));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesFunctions", "ModuleFaq"));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("cache_front_post",          "not expire");
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("stop_arg_names",            array("id" => "##modId##"));
        $vMod->SetProperty("stop_arg_filters",          array("##modId##" => "id_cat=%catid"));
        $vMod->SetProperty("spec_blocks",               array("spec_small_faq"));
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "repair","publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty('twist_actions',             array('add')); // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('question', 'author', 'answer'));
        $vMod->TTlIIlT('index_fields',            array('question', 'author', 'answer'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "question");
        $vMod->TTlIIlT("announce",                "answer");
        $vMod->TTlIIlT("robots_noindex_field",    "details_noindex");
        $vMod->TTlIIlT("script",                  "#q");
        $vMod->TTlIIlT('relative_module',         array('##modId##_cat', 'id_cat'));

// } [ami_multifeeds5|faq]
// [ami_multifeeds5|faq|cat] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->SetProperty("unsupported_extensions",    array('ext_twist_prevention', 'image', 'discussion', 'ce_page_break', 'rating', 'relations', 'tags', 'ext_rss', 'adv'));
        $vMod->setProperty('sort_fields',               array('name', 'public', 'position'));
        $vMod->SetProperty("actions",                   array("publish", "add", "edit", "apply", "save", "del", "top", "bottom", "up", "down", "repair","publish_on", "publish_off", "gen_sublink", "gen_keywords"));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesModule", "ModuleFaqCat"));
        $vMod->SetProperty("stop_arg_names",            array("catid" => "##modId##", "id" => "##parentModId##"));
        $vMod->SetProperty("search_by_parent",          true);
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("help_on",                   false); // Turning help on \ off
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('name', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('name', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "name");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "");
        $vMod->TTlIIlT("script",                  "?id=");

// } [ami_multifeeds5|faq|cat]
// [ami_multifeeds5|photoalbum] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);
        if(!$oDeclarator->getAttr('##modId##', 'core_v5')){
            $vMod->SetProperty('front_request_types', array('plain'));
        }

        // Set properties
        $vMod->SetProperty("unsupported_extensions",    array('reindex', 'relations', 'adv'));
        $vMod->setProperty('sort_fields',               array('date', 'public', 'header', 'cname', 'archive', 'votes_count', 'votes_rate', 'position'));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesFunctions", "ModulePhotoalbum"));
        $vMod->SetProperty("taborder",                  '##taborder##');
        $vMod->SetProperty("stop_arg_names",            array("id" => "photoalbum"));
        $vMod->SetProperty("stop_arg_filters",          array("photoalbum" => "id_cat=%catid"));
        $vMod->SetProperty("stop_use_sublinks",         true);
        $vMod->SetProperty("spec_blocks",               array("spec_small_##modId##"));
        $vMod->SetProperty("generate_picture_postf",    "_pc");
        $vMod->SetProperty("generate_small_picture_postf", "_sm");
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty('twist_actions',             array('forum_add', 'rate')); // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array(array('header', 'author'), array('announce', 'source'), 'body'));
        $vMod->TTlIIlT('index_fields',            array('header', 'author', 'announce', 'source', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "header");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "details_noindex");
        $vMod->TTlIIlT("script",                  "?id=");
        $vMod->TTlIIlT('relative_module',         array('##modId##_cat', 'id_cat'));

// } [ami_multifeeds5|photoalbum]
// [ami_multifeeds5|photoalbum|cat] {

    $vMod = &$Core->GetModule("##modId##");
        $oDeclarator->setupAsyncInterface($vMod);

        // Set properties
        $vMod->SetProperty("unsupported_extensions",    array('ce_page_break', 'relations', 'tags', 'ext_rss', 'adv'));
        $vMod->setProperty('supported_extensions', array('ami_ext/antispam'));

        $vMod->setProperty('sort_fields',               array('name', 'public', 'position', 'votes_count', 'votes_rate'));
        $vMod->SetProperty("engine_classes",            array("CMS_CategoriesModule", "ModulePhotoalbumCat"));
        $vMod->SetProperty("stop_arg_names",            array("catid" => "##modId##", "id" => "##parentModId##"));
        $vMod->SetProperty("search_by_parent",          true);
        $vMod->SetProperty("help_on",                   true); // Turning help on \ off
        $vMod->SetProperty("generate_picture_postf",    "_pc");
        $vMod->SetProperty("generate_small_picture_postf", "_sm");
        $vMod->SetProperty("use_special_list_view",     true); // Enable/Disable public direct link/urgency functionality
        $vMod->SetProperty('twist_actions',             array('forum_add', 'rate')); // Array of actions to protect from SPAM (extension twist_prevention)
        $vMod->SetProperty('actions', array('edit'));

        // Set parameters for search index
        $vMod->TTlIIlT('index',                   array('name', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields',            array('name', 'announce', 'body'));
        $vMod->TTlIIlT("public_field",            "public");
        $vMod->TTlIIlT("title",                   "name");
        $vMod->TTlIIlT("announce",                "announce");
        $vMod->TTlIIlT("robots_noindex_field",    "");
        $vMod->TTlIIlT("script",                  "?id=");

// } [ami_multifeeds5|photoalbum|cat]
// [ami_clean|ami_service] {

    $vMod = &$Core->GetModule("##modId##");
    $oDeclarator->setupAsyncInterface($vMod);
    $vMod->SetProperty('taborder', 6100);

// } [ami_clean|ami_service]
// [ami_fake|options_data] {

    $vMod = &$Core->GetModule('##modId##');
    $oDeclarator->setupAsyncInterface($vMod);
    $vMod->SetProperty('taborder', 6200);

// } [ami_fake|options_data]

// [ami_clean|active_sessions] {

    $vMod = &$Core->GetModule('##modId##');
    $oDeclarator->setupAsyncInterface($vMod);
    $vMod->SetProperty('taborder', 6300);

// } [ami_clean|active_sessions]
