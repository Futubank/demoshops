%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/_srv_updates_msgs.lng"%%

<!--#set var="licence_note" value="
<div class="licence">
    <span class="licence-warn">
        <span class="licence-warn__message"><a href="http://%%licence_site%%/" title="%%licence_title%%" target="_blank">%%licence_note%%: ##lic_date##</a></span>
        <span onclick="licenceWarnClose();" class="licence-warn__close"></span>
    </span>
</div>
"-->

<!--#set var="licence_warn" value="
<div class="licence">
    <span class="licence-warn">
        <span class="licence-warn__message"><a href="http://%%licence_site%%/" title="%%licence_title%%" target="_blank">%%licence_warn%%: ##lic_date##</a></span>
        <span onclick="licenceWarnClose();" class="licence-warn__close"></span>
    </span>
</div>
"-->

<!--#set var="licence_ver_warn" value="
<div class="licence">
    <span class="licence-warn">
        <span class="licence-warn__message">%%licence_ver_warn%%</span>
        <span onclick="licenceWarnClose();" class="licence-warn__close"></span>
    </span>
</div>
"-->

<!--#set var="lang_select_form" value="
<span class="lang_select_form">
    <form action="" name="langSel" style="margin:0px;">
        ##if(mod_id)##<input type=hidden name=mod_id value="##mod_id##">##endif##
        <select name="lang_data" onchange="javascript:langSel.submit();" helpId="panel-lang">
            ##rows##
        </select>
    </form>
</span>
"-->

<!--#set var="lang_select_form_row" value="
<option ##active## value="##lang_val##">##lang_name##</option>
"-->

<!--#set var="site_select_form" value="
<span class="site_select_form">
    <form action="" name="siteSel" style="margin:0px;">
        <select name="id_site" onchange="javascript:siteSel.submit();" helpId="panel-subsite">
            <option value="0">%%main_site%%</option>
            ##rows##
        </select>
    </form>
</span>
"-->

<!--#set var="site_select_form_row" value="
<option ##active## value="##id##">##name##</option>
"-->

<!--#set var="client_site_select_form" value="
<span class="client_site_select_form">
    <form action="" name="client_site_sel" style="margin:0px;" method="post">
        <input type=hidden name=client_site_select value=1>
        <select name="id_client_site" onchange="javascript:client_site_sel.submit();" helpId="panel-site">
            <option value="0">%%select_site%%</option>
            ##rows##
        </select>
    </form>
</span>
"-->

<!--#set var="server_name" value="
<a data-helpid="header_siteurl" target="_blank" href="##front_link##">##server##</a> • <span class="amiro-header__site-url__username">##username##</span> <a title="%%icon_logout%%" helpId="panel-logout" href="#" onclick="javascript: if(confirm('%%icon_logout%%?')) window.location='##if(ADM_COPY_PREF!="")##custom_login.php##else##login.php##endif##'; return false;" class="amiro-header__site-url__block__logout"></a>
"-->

##--
<!--#set var="help" value="<a class="help_btn_link" title="%%help_btn_title%%" href="#" onclick="if(typeof(oHelp) != 'undefined'){oHelp.showPopup();} return false;" target="_blank"><img id=help-btn hspace=10 src="skins/vanilla/images/empty.gif" width=26 height=26 ></a>"-->
<!--#set var="start_page" value="<a href="start.php">%%start_page%%</a>"-->
<!--#set var="logout" value=""-->
--##


<!--#set var="options" value="
<span id="amiro-header__setting-block" class="amiro-header__control-option-block">
    <div class="amiro-header__control-option-area">
        <script type="text/javascript">top._mtloc = '';</script>
        <a ##ActivePageHeader## title="%%icon_options%%" class="amiro-header__control-option" data-helpid="panel_options" href="javascript:void()" onclick="javascript:openExtDialog('%%module_options%%', 'srv_options.php?flt_mode=simple&flt_owner=##owner_name##&flt_module=##module_name##&_mt=##_mt##&_mtloc=' + top._mtloc + '&_rv=' + top.rights_version + '&_cv=' + top.cms_version + '&lang=' + top.interface_lang, 1, 1 );return false;"></a>
        <span onclick="showSettingForm();" class="amiro-header__control-option-search"></span>
    </div>
    <div id="amiro-header__setting-form" class="amiro-header__control-option-input pre-loader__setting"></div>
</span>
<script>
    function showSettingForm() {
        if(AMI.$('#amiro-header__setting-form').css('display') == 'none') {
            AMI.$('#amiro-header__setting-block').addClass('amiro-header__control-option-block-on');
            AMI.$('#amiro-header__setting-form').fadeIn(150);
            AMI.$('#select-options-resultrow input').focus();
        } else {
            AMI.$('#amiro-header__setting-form').fadeOut(150);
            AMI.$('#amiro-header__setting-block').removeClass('amiro-header__control-option-block-on');
        }
    }
</script>
"-->

<!--#set var="templates" value="
<a class="amiro-header__control-template" data-helpid="panel_templates" helpId="panel-templates" title="%%icon_templates%% ##ActivePageHeader##" href="javascript:void()" onclick="javascript:openExtDialog('%%module_modules_templates%%', '##if(is_new_interface)##engine.php?mod_id=modules_templates&mode=popup&modname=##owner_name##.##module_name####else##modules_templates.php?flt_mode=simple&flt_tpl_modules=##owner_name##.##module_name####endif##', 1, 1 );return false;"></a>
<a class="amiro-header__control-template-langs" title="%%icon_templates_langs%% ##ActivePageHeader##" data-helpid="panel_templates_lang" helpId="panel-templates-langs" href="javascript:void()" onclick="javascript:openExtDialog('%%module_modules_templates_langs%%', '##if(is_new_interface)##engine.php?mod_id=modules_templates_langs&mode=popup&modname=##owner_name##.##module_name####else##modules_templates_langs.php?flt_mode=simple&flt_tpl_modules=##owner_name##.##module_name####endif##', 1, 1 );return false;"></a>
<a class="amiro-header__control-media" title="%%media_files%%" data-helpid="panel_media" helpId="panel-media" href="javascript:void()" onclick="javascript:openExtDialog('%%media_files%%', 'ce_img_proc.php?cat=##module_name##&lang=##admin_lang##&img=null', 1, 1 );return false;"></a>
"-->

##-- style for help popup, need to clean-up --##
<style>
    .help-h3 {font-weight:bold;font-size:14px;margin: 4px 0; padding 0;}
    .help-h4 {font-weight:bold;font-size:12px;margin: 3px 0; padding 0;}
</style>
<script>

    AMI.$(document).ready(function () {
        if (typeof (oHelp) != 'undefined') {
            if (module_name == 'start' || module_name == 'pages') {
                oHelp.show(true);
            }
        }
    });

</script>

##setglobalvar @module_name = module_name##
<div id=page_loading style="height:100%">
    <div class="loadingTop"></div>
    <div class="loadingBottom">
            <div class="cssload-thecube">
                <div class="cssload-cube cssload-c1"></div>
                <div class="cssload-cube cssload-c2"></div>
                <div class="cssload-cube cssload-c4"></div>
                <div class="cssload-cube cssload-c3"></div>
            </div>
    </div>
</div>

<div id="page_content" style="display: none;">
    <table width="100%" height=100% border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td class="header-area" valign="top">
                <table class="amiro-header" id="amiro-header-block" width="100%" height=100% border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="amiro-header__logo" rowspan="2">
                            ##if(module_name == 'start')##
                            <span data-helpid="panel_logo" class="amiro-header__logo-img"></span>
                            ##else##
                            <span data-helpid="panel_logo" class="amiro-header__logo-img-block">
                                <a title="%%go_start_page%%" href="start.php" class="amiro-header__logo-img"></a>
                                <a title="%%go_start_page%%" href="start.php" class="amiro-header__logo-img__to-home"></a>
                            </span>
                            ##endif##
                        </td>
                        <td class="amiro-header__favourites" rowspan="2"><span id="fav_open_btn" helpId="favorites" data-helpid="panel_favorites" onclick="switchFavorites()" title="%%favorites%%" class="amiro-header__favourites-icon"></span></td>
                        <td class="amiro-header__select-modules" rowspan="1"><div id="select_module" data-helpid="locator_modules"></div></td>
                        <td class="amiro-header__site-url"><div class="amiro-header__site-url__block">##server_name##</div></td>
                        <td class="amiro-header__amiro-edition"><div class="amiro-header__amiro-edition__block"><a target="_blank" href="http://www.amiro.ru" title="%%amiro_cms%%">Amiro.CMS %%amiro_cms_edition_##edition##%%</a> <a target="_blank" class="amiro-header__amiro-history" title="%%amiro_cms_history%%" href="http://www.amiro.ru/product/amiro.cms/changes-history">##cms_version##</a>##php_version##</div></td>
                    </tr>
                    <tr>
                        <td class="amiro-header__control" colspan="3">
                            ##if(script_link!="start.php")####lang_select_form####endif##
                            ##site_select_form##

                            ##if(script == '' && pm_link == '' && module_name != "start")##
                            ##else##
                            <span class="amiro-header__control__page-nav">
                                ##if(module_name == "start")##
                                    <a data-helpid='header_viewpage' id="amiro-header__control__view-page" title="%%amiro-header__control__view-page%%" target="_blank" href="##front_link##" class="amiro-header__control__view-page"></a>
                                    <a title="%%amiro-header__control__pmanager%%" data-helpid='header_editpage' target="_blank" href="pmanager.php" class="amiro-header__control__edit-page"></a>
                                ##else##
                                    ##if(script && pm_link || (module_name == 'pages'))##
                                    <a data-helpid='header_viewpage' id="amiro-header__control__view-page" title="%%amiro-header__control__view-page%%" target="_blank" href="##script##" class="amiro-header__control__view-page"></a>
                                    ##elseif(script && !pm_link && (module_name != 'pages'))##
                                    <a id="amiro-header__control__view-page" title="%%amiro-header__control__view-page__none%%" href="#" onclick="return false;" class="amiro-header__control__view-page amiro-header__control__view-page__none"></a>
                                    <a title="%%amiro-header__control__add-page%%" target="_blank" href="##script##" class="amiro-header__control__add-page"></a>
                                    ##endif##
                                    ##if(pm_link)##<a title="%%amiro-header__control__edit-page%%" data-helpid='header_editpage' target="_blank" href="##pm_link##" class="amiro-header__control__edit-page"></a>##endif##
                                ##endif##
                            </span>
                            ##endif##
                            ##options##
                            ##templates##
                            ##if(AMI_IS_SYS_USER == '1')##<script src="skins/vanilla/_js/private_messages.js?v=1" type="text/javascript"></script>##endif##
                            <a data-helpid="manual_btn" data-helpid-docurl="http://manual.amiro.ru/topic.php?id=##module_name##" data-helpid-page="##module_name##" class="amiro-header__control-help" title="%%help_btn_title%%" href="#" onclick="if (typeof (oHelp) != 'undefined'){oHelp.showPopup();}
                                        return false;" target="_blank"></a></td>
                    </tr>
                </table>
                <!--<iframe id="submenu_block" width=100% height=100% src="about:blank" frameborder=0 scrolling=no style="display:none; position:absolute; background-color:#fff; border-top:1px #aaa solid;border-left:1px #aaa solid;border-right:2px #aaa solid;border-bottom:2px #aaa solid; width:210px; height:115px; overflow:hidden;z-index:10;"></iframe>-->
                <div id="submenu_block" width=100% height=100% style="display:none; position:absolute; background-color:#fff; border-top:1px #aaa solid;border-left:1px #aaa solid;border-right:2px #aaa solid;border-bottom:2px #aaa solid; width:210px; height:115px; overflow:hidden;z-index:10;">
                    <div id="submenu">
                        <table id="resultTable" cellpadding="0" cellspacing="0" border="0" style="width: 100%">
                            <tbody>
                                <tr>
                                    <td class="submenu-table__td" valign="top" colspan="4">
                                        <div id="links">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-bottom: 7px">
                                                <tbody id="submenu-items"></tbody>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="favorites_block"  style="display:none; position:absolute; left:220px; top:48px; width:362px; height:515px; z-index:100; padding: 15px">
                    <table border="0" cellpadding="0" cellspacing="0" width=100% height=100% background="#fff">
                        <tr>
                            <td style="padding:0px; background: url(images/custom_/loading.gif) 50% 30% no-repeat white;">
                                <input type="hidden" id="favorites_block_link" value="favorites.php?module_name=##module_name##&lang=##lang##&rv=##rv##" />
                                <iframe id="favorites_block_frm" width=362 height=515 src="about:blank" frameborder=0 scrolling=no></iframe>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="calendar_block"  style="display:none; position: absolute; width:220px; height:347px; z-index:10; padding: 15px">
                    <table border="0" cellpadding="0" cellspacing="0" width=100% height=100% background="#fff">
                        <tr>
                            <td style="padding:0px;">
                                <iframe id="calendar_block_frm" width="220" height="347" src="about:blank" frameborder=0 scrolling=no></iframe>
                            </td>
                        </tr>
                    </table>
                </div>
                <script type="text/javascript">
                        var activePageHeader = "##ActivePageHeader##";
                        var startPageHeader = "%%start_page_header%%";
                        var startTypeModName = (module_name == 'start') ? "%%start_type_mod_name%%" : "%%start_type_mod_name%%";
                        var modulesSelectNotFound = "%%not_found_mod_name%%";
                        onCloseConfirm = function (isLoaded){return (isLoaded || confirm('%%win_close_may_cause_err%%'))}
                        ;
                </script>
                
                ##if(licence_warn)##
                ##licence_warn##
                <script>
                    if (AMI.Cookie.get("licenceWarn") == 1) {
                        AMI.$('.licence').css('display', 'none');
                    } else if (AMI.$('.licence')) {
                        AMI.$('.licence').css('display', 'block');
                        AMI.$('.licence').delay(4000).animate({opacity: 0.2}).animate({opacity: 1});
                    }
                    
                    function licenceWarnClose() {
                        AMI.$('.licence').css('display', 'none');
                        AMI.Cookie.set("licenceWarn", "1", 3600 * 24 * 5, "/", true);
                    }
                </script>
                ##else##
                <div id="update-alert" class="have-updates">
                    <span class="have-updates-warn">
                        <span class="have-updates-warn__message">
                            <a class="have-updates-warn__link" href="srv_updates.php">%%haveblock_updates%%</a> <span id="have-updates-warn__message-count-block"></span><span id="have-updates-warn__message-description-block"></span>
                        </span>
                        <span onclick="haveUpdatesWarnClose();" class="have-updates-warn__close"></span>
                    </span>
                </div>
                <script>
                    AMI.$(document).ready(function () {
                        oAMIUpdates = AMI.Cookie.get('amiUpdates');
            
                        var countUpdates = 0;
                        var showUpdates = 0;
            
                        if (oAMIUpdates == null) {
                            oAMIUpdates = {validTill: "ERROR"}
                        }
            
                        var dataUpdates = '<div class="have-updates-warn__message-block">';
                        var infoUpdatesBlock = AMI.$('#have-updates-warn__message-description-block');
            
                        if (oUpdate.length != 0) {
                            for (var key in oUpdate) {
                                value = oUpdate[key];
                                countUpdates += 1;
                                dataUpdates += '<div><span>' + value.ver + ', ' + value.name + '</span><br>' + value.desc + '<div class="have-updates-warn__message-description-link"><a target="_blank" href="' + value.link + '">%%installlock_updates_details%%</a></div></div>';
                            }
                        }
                        var splittable = false;
                        if (typeof (oAMIUpdates.validTill) != 'undefined') {
                            var aUpdatesParts = oAMIUpdates.validTill.toString().split(' ');
                            if (typeof (aUpdatesParts) != 'undefined') {
                                var aFirstPart = aUpdatesParts[0];
                                splittable = (aFirstPart.split('-').length > 2);
                            }
                        }
            
                        if (countUpdates == 0) {
                            if (oAMIUpdates.validTill == 'EXPIRED') {
                                AMI.$('.have-updates-warn__message').html('%%update_expired%%');
                                showUpdates = 1;
                            } else if ((typeof (oAMIUpdates.daysLeft) != 'undefined') && splittable && (oAMIUpdates.daysLeft < 61)) {
                                updateDay = oAMIUpdates.validTill.split(' ')[0].split('-')[2];
                                updateMonth = oAMIUpdates.validTill.split(' ')[0].split('-')[1];
                                updateYear = oAMIUpdates.validTill.split(' ')[0].split('-')[0];
                                updateDate = updateDay + '.' + updateMonth + '.' + updateYear;
                                AMI.$('.have-updates-warn__message').html('%%udpatesblock_updates_at%% ' + updateDate + '%%udpatesblock_updates_at_end%%');
                                showUpdates = 1;
                            }
                        } else {
                            AMI.$('#have-updates-warn__message-count-block').html('<span id="have-updates-warn__message-count">' + countUpdates + '</span>');
                            if (oAMIUpdates.validTill == 'EXPIRED') {
                                infoUpdatesBlock.html('<span id="have-updates-warn__message-description">' + dataUpdates + '</span></div>');
                                AMI.$('.have-updates-warn__message-block').after('<div class="udpates-block-info">%%update_expired%%</div>');
                                AMI.$('#have-updates-warn__message-count-block').after('<br>%%update_expired%%');
                                showUpdates = 1;
                            } else if ((typeof (oAMIUpdates.daysLeft) != 'undefined') && splittable && (oAMIUpdates.daysLeft < 61)) {
                                updateDay = oAMIUpdates.validTill.split(' ')[0].split('-')[2];
                                updateMonth = oAMIUpdates.validTill.split(' ')[0].split('-')[1];
                                updateYear = oAMIUpdates.validTill.split(' ')[0].split('-')[0];
                                updateDate = updateDay + '.' + updateMonth + '.' + updateYear;
                                infoUpdatesBlock.html('<span id="have-updates-warn__message-description">' + dataUpdates + '</span></div>');
                                AMI.$('.have-updates-warn__message-block').after('<div class="udpates-block-info">%%udpatesblock_updates_at%% ' + updateDate + '%%udpatesblock_updates_at_end%%</div>');
                                AMI.$('#have-updates-warn__message-count-block').after('<br>%%udpatesblock_updates_at%% ' + updateDate + '%%udpatesblock_updates_at_end%%');
                                showUpdates = 1;
                            } else {
                                infoUpdatesBlock.html('<span id="have-updates-warn__message-description">' + dataUpdates + '</span></div>');
                                AMI.$('.have-updates-warn__message-block').after('<div class="udpates-block-info"><a id="updates-link__get" href="srv_updates.php">%%installlock_updates%%</a></div>');
                                showUpdates = 1;
                            }
                        }
                        AMI.$('.udpatesblock-warn__message-link').attr('href', AMI.$('.udpatesblock-warn__message-link').attr('href') + '?domain=' + location.hostname);
                        if (AMI.Cookie.get("haveUpdatesWarn") != 1 && showUpdates == 1) {
                            AMI.$('#update-alert').delay(4000).animate({opacity: 0.2}).animate({opacity: 1});
                        } else if (AMI.Cookie.get("haveUpdatesWarn") == 1) {
                            AMI.$('#update-alert').css('display', 'none');
                        }
                    });
                    function haveUpdatesWarnClose() {
                        AMI.$('#update-alert').css('display', 'none');
                        AMI.Cookie.set("haveUpdatesWarn", "1", 3600 * 24 * 5, "/", true);
                    }
                </script>
                ##endif##
            </td>
        </tr>
