<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @size       3442 xkqwlxyllzqmuluktiikwymmmlynupiqrmggzmkmumlrkqkrmxkrtikqswqruwptururpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}


if(isset($modName) && $modName){
    $vMod = &$GLOBALS['Core']->GetModule($modName);
    $oDeclarator->setupAsyncInterface($vMod);
    $vMod->SetProperty('front_request_types', array('plain'));
    $vMod->SetProperty('unsupported_extensions', array());
    $vMod->setProperty('sort_fields', array('date_created', 'public', 'header', 'cat_header', 'ext_rate_count', 'ext_rate_rate', 'position'));
    $vMod->SetProperty('stop_arg_names', array('id' => $modName));
    $vMod->SetProperty('stop_arg_filters', array($modName => 'id_cat=%catid'));
    $vMod->SetProperty('stop_use_sublinks', TRUE);
    $vMod->SetProperty('spec_blocks', array('spec_small_' . $modName));
    $vMod->SetProperty('support_rights', TRUE);
    $vMod->SetProperty('use_special_list_view', TRUE);
    $vMod->SetProperty("required_fields", array("header", "announce", "cat_id"));
    $vMod->SetProperty('help_on', TRUE);
    $vMod->SetProperty('twist_actions', array('forum_add', 'rate'));
    $vMod->SetProperty('picture_cat', $modName);
    $vMod->SetProperty('rss_link_smallblock', FALSE);
    $vMod->SetProperty('actions', array('edit'));

    $vMod->TTlIIlT('index', array(array('header'), array('announce'), 'body'));
    $vMod->TTlIIlT('index_fields', array('header', 'announce', 'body'));
    $vMod->TTlIIlT('public_field', 'public');
    $vMod->TTlIIlT('title', 'header');
    $vMod->TTlIIlT('announce', 'announce');
    $vMod->TTlIIlT('relative_module', array($modName . '_cat', 'id_cat'));
    $vMod->TTlIIlT('robots_noindex_field', 'details_noindex');
    $vMod->TTlIIlT('date_modified', 'date_modified');
    $vMod->TTlIIlT('hide_in_list', 'hide_in_list');

    if($oDeclarator->isRegistered($modName . '_cat')){
        $vMod = &$GLOBALS['Core']->GetModule($modName . '_cat');
        $oDeclarator->setupAsyncInterface($vMod);
        $vMod->SetProperty('unsupported_extensions', array('ext_twist_prevention', 'discussion', 'ce_page_break', 'tags', 'ext_rss'));
        $vMod->setProperty('sort_fields', array('header', 'public', 'position', 'ext_rate_count', 'ext_rate_rate'));
        $vMod->SetProperty('stop_arg_names', array('catid' => $modName . '_cat', 'id' => $modName));
        $vMod->SetProperty('search_by_parent', TRUE);
        $vMod->SetProperty('help_on', FALSE); // Turning help on \ off
        $vMod->SetProperty('actions', array('edit'));

        $vMod->TTlIIlT('index', array('header', 'announce', 'body'));
        $vMod->TTlIIlT('index_fields', array('header', 'announce', 'body'));
        $vMod->TTlIIlT('public_field', 'public');
        $vMod->TTlIIlT('title', 'header');
        $vMod->TTlIIlT('announce', 'announce');
        $vMod->TTlIIlT('robots_noindex_field', '');
        $vMod->TTlIIlT('script', '?id=');
        $vMod->TTlIIlT('date_modified', 'date_modified');
        $vMod->TTlIIlT('hide_in_list', 'hide_in_list');
    }
    unset($modName);
}
