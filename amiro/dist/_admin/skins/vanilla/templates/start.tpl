%%include_language "templates/lang/start.lng"%%
%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/_menu_owners.lng"%%

<!--#set var="quick_start" value="
##IF (pmanager_link != "")##
<br>
<img id="img_pmanager" src="skins/vanilla/icons/arr_right_icon_small.gif" align=absmiddle border=0>
<a href="##pmanager_link##"
onmouseover="document.getElementById('img_pmanager').src=oQSImgOver.src;"
onmouseout="document.getElementById('img_pmanager').src='skins/vanilla/icons/arr_right_icon_small.gif'"
>%%pmanager%%</a>
<div style="padding-left:20px">%%welcome_pmanager%%</div>
##ENDIF##
##IF (modules_link != "")##
<br>
<img id="img_modules" src="skins/vanilla/icons/arr_right_icon_small.gif" align=absmiddle border=0>
<a href="##modules_link##"
onmouseover="document.getElementById('img_modules').src=oQSImgOver.src;"
onmouseout="document.getElementById('img_modules').src='skins/vanilla/icons/arr_right_icon_small.gif'"
>%%modules%%</a>
<div style="padding-left:20px">%%welcome_modules%%</div>
##ENDIF##
##IF (eshop_link != "")##
<br>
<img id="img_eshop" src="skins/vanilla/icons/arr_right_icon_small.gif" align=absmiddle border=0>
<a href="##eshop_link##"
onmouseover="document.getElementById('img_eshop').src=oQSImgOver.src;"
onmouseout="document.getElementById('img_eshop').src='skins/vanilla/icons/arr_right_icon_small.gif'"
>%%eshop%%</a>
<div style="padding-left:20px">%%welcome_eshop%%</div>
##ENDIF##
##IF (portfolio_link != "")##
<br>
<img id="img_portfolio" src="skins/vanilla/icons/arr_right_icon_small.gif" align=absmiddle border=0>
<a href="##portfolio_link##"
onmouseover="document.getElementById('img_portfolio').src=oQSImgOver.src;"
onmouseout="document.getElementById('img_portfolio').src='skins/vanilla/icons/arr_right_icon_small.gif'"
>%%portfolio%%</a>
<div style="padding-left:20px">%%welcome_portfolio%%</div>
##ENDIF##
##IF (kb_link != "")##
<br>
<img id="img_kb" src="skins/vanilla/icons/arr_right_icon_small.gif" align=absmiddle border=0>
<a href="##kb_link##"
onmouseover="document.getElementById('img_kb').src=oQSImgOver.src;"
onmouseout="document.getElementById('img_kb').src='skins/vanilla/icons/arr_right_icon_small.gif'"
>%%kb%%</a>
<div style="padding-left:20px">%%welcome_kb%%</div>
##ENDIF##
##IF (services_link != "")##
<br>
<img id="img_services" src="skins/vanilla/icons/arr_right_icon_small.gif" align=absmiddle border=0>
<a href="##services_link##"
onmouseover="document.getElementById('img_services').src=oQSImgOver.src;"
onmouseout="document.getElementById('img_services').src='skins/vanilla/icons/arr_right_icon_small.gif'"
>%%services%%</a>
<div style="padding-left:20px">%%welcome_services%%</div>
##ENDIF##
"-->

<!--#set var="module_descr" value="
"-->

<!--#set var="module_descr_default" value="
<div class="teach_videoblock" style="display: none;">
    <div class="teach_videoblock__background"></div>
    <div class="teach_videoblock__close-btn"><img onclick="openTeachVideo();" src="skins/vanilla/images/custom_/glass-frame-close.png" /></div>
    <div class="teach_videoblock_iframe"></div>
</div>
<script>
    function addTeachVideo() {
        AMI.$('.teach_videoblock_iframe').html('<iframe id="iframe_video_learn" allowtransparency="true" class="iframe_videoblock" width="100%" height="100%" frameborder="0" src="http://www.amiro.ru/teachvideo?width='+$(window).width()+'&height='+$(window).height()+'"></iframe>');

        function windowIframeMessage(event){
            if ( event.origin == '*')
                return;
                if(event.data == 'closeTeachVideo') {
                    openTeachVideo();
                }
        }

        if (window.addEventListener){
            window.addEventListener("message", windowIframeMessage,false);
        } else {
            window.attachEvent("onmessage", windowIframeMessage);
        }

         if(AMI.$(window).width() > 1280 && AMI.$(window).height() > 865) {
            AMI.$('.iframe_videoblock').css({minWidth: 1292, height: 1065});
            AMI.$('.teach_videoblock__close-btn').css('width', '1292px');
        } else if (AMI.$(window).width() > 1024 && AMI.$(window).height() > 720) {
            AMI.$('.iframe_videoblock').css({minWidth: 1037, height: 920});
            AMI.$('.teach_videoblock__close-btn').css('width', '1037px');
        } else if (AMI.$(window).width() > 992 && AMI.$(window).height() > 565) {
            AMI.$('.iframe_videoblock').css({minWidth: 980, height: 765});
            AMI.$('.teach_videoblock__close-btn').css('width', '992px');
        } else {
            AMI.$('.iframe_videoblock').css({minWidth: 800, height: 800});
            AMI.$('.teach_videoblock__close-btn').css('width', '672px');
        }

    }

    function openTeachVideo() {
        if(AMI.$('.teach_videoblock').css('display') == 'none') {
            AMI.$('.teach_videoblock').fadeIn().css('display', 'block');
        } else {
            AMI.$('.teach_videoblock').fadeOut();
            AMI.$('.iframe_videoblock').remove();
        }
    }

    AMI.$(document).keydown(function(e) {
        if (e.keyCode == 27 && AMI.$('.teach_videoblock').css('display') == 'block') {
            openTeachVideo();
        }
    });

    AMI.$('.teach_videoblock__background').click(function() {
        openTeachVideo();
    });
    AMI.$(function(){
      AMI.$(document).click(function(event) {
        if ($(event.target).closest("#amiro-header__setting-block").length) return;
        AMI.$('#amiro-header__setting-form').fadeOut(150);
        AMI.$('#amiro-header__setting-block').removeClass('amiro-header__control-option-block-on');
        if ($(event.target).closest("#favorites_block").length) return;
        AMI.$('#favorites_block').fadeOut();
        if ($(event.target).closest("#calendar_block").length) return;
        AMI.$('#calendar_block').fadeOut();
        event.stopPropagation();
      });
    });
</script>

<style>
    .start__amiro-market {
        opacity: 0.8;
        display: block;
        position: relative;
        top: 15px;
        left: -64px;
        height: 211px;
    }
    .start__amiro-market a,
    .start__amiro-market a:hover {
        text-decoration: none;
    }
    .start__amiro-market:hover {
        opacity: 1;
    }
    .start__amiro-market-title {
        color: #3F3F3F;
        font-size: 18px;
        top: -2px;
        text-align: center;
    }
    .start__amiro-market-title span {
        color: #E03431;
        font-size: 18px;
    }
  </style>
                                    <div class="start__amiro-row start__amiro-row-gray">
                                        <div class="start__amiro-row-header">
                                            <i class="fa fa-user"></i>
                                            %%start__amiro-row-header-user%%
                                        </div>
                                        <div class="start__amiro-row-content">
                                            <div class="start__amiro-row-info-block">
                                                <ul>
                                                    <li>
                                                        ##firstname## ##lastname## ( ##login## )
                                                    </li>
                                                    ##if(!empty(email))##<li>
                                                        ##email##
                                                    </li>##endif##
                                                    ##if(!empty(link_members))##<li>
                                                        <a href="##link_members##"><i class="fa fa-user-plus"></i>%%start__amiro-row-content-user_management%%</a>
                                                    </li>##endif##
                                                    ##if(!empty(link_sys_groups))##<li>
                                                        <a href="##link_sys_groups##"><i class="fa fa-unlock"></i>%%start__amiro-row-content-access_rights%%</a>
                                                    </li>##endif##
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="start__amiro-row start__amiro-row-border">
                                        <div class="start__amiro-row-content">
                                            <div class="start__amiro-row-info-block">
                                                <div data-helpid="start_market_logo" class="start__amiro-market">
                                                    <a href="engine.php?mod_id=ami_market">
                                                    <div class="start__amiro-market-title">
                                                        <span>%%start__amiro-market-title-amiro%%</span>%%start__amiro-market-title-market%%
                                                    </div> <img src="skins/vanilla/images/amiro-market.png"> </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="start__amiro-row start__amiro-row-sky">
                                        <div class="start__amiro-row-header">
                                            <i class="fa fa-question-circle"></i>
                                            %%start__amiro-row-header-support%%
                                        </div>
                                        <div class="start__amiro-row-content">
                                            <div class="start__amiro-row-info-block">
                                                <ul>
                                                    <li>
                                                        <a target="_blank" href="http://www.amiro.ru/support/about"><i class="fa fa-map-o"></i>%%start__amiro-row-content-what_and_where%%</a>
                                                    </li>
                                                    <li>
                                                        <a target="_blank" href="http://www.amiro.ru/support/faq"><i class="fa fa-lightbulb-o"></i>%%start__amiro-row-content-frequently_questions%%</a>
                                                    </li>
                                                    <li>
                                                        <a target="_blank" href="http://manual.amiro.ru/"><i class="fa fa-book"></i>%%start__amiro-row-content-help_documentation%%</a>
                                                    </li>
                                                    <li>
                                                        <a target="_blank" href="http://www.amiro.ru/forum"><i class="fa fa-graduation-cap"></i>%%start__amiro-row-content-forum%%</a>
                                                    </li>
                                                    ##if(!empty(link_srv_host_support))##<li>
                                                        <a target="_blank" href="##link_srv_host_support##"><i class="fa fa-life-ring"></i>%%start__amiro-row-content-contact_support%%</a>
                                                    </li>##endif##
                                                </ul>
                                            </div>
                                            <div class="start__amiro-row-info-block">
                                                <div title="%%teach_video_title%%" class="teach-video" onclick="addTeachVideo(); openTeachVideo();">
                                                    <div class="teach-video__video">
                                                        <img src="skins/vanilla/images/videolessons.png">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    ##if(trim(external_informer) != '')##
                                    <div class="start__amiro-row start__amiro-row-border">
                                        <div class="start__amiro-row-header">
                                            <i class="fa fa-newspaper-o"></i>
                                            %%start__amiro-row-header-news%%
                                        </div>
                                        <div class="start__amiro-row-content">
                                            ##external_informer##
                                        </div>
                                    </div>
                                    ##endif##
"-->

<!--#set var="owner" value="
<tr><td valign=middle>
<table style="cursor:pointer;" width="100%" cellspacing="0" cellpadding="0" border="0" onclick="window.location='##link##'"  height=55><tr><td width=55><img src="skins/vanilla/images/owner_##name##_icon##type##.gif" border="0" width="55" height="60"></td>
<td style="vertical-align:middle;width:125px;height:55px;font-size:11px;font-family:Tahoma;white-space:nowrap;background: url(skins/vanilla/images/owner_##name##_label_bg.gif) no-repeat left top;">##caption##<img id="submenu_btn" onclick="displaySubModulesBlock(event, '##name##')"
            style="cursor:pointer;"
            align="baseline"
            src="skins/vanilla/images/owner-open.gif" border="0" /></td>
<td background="skins/vanilla/images/owner_##name##_line_bg.gif" style="padding-top:12px">&nbsp;</td>
<td width=19><img src="skins/vanilla/images/owner_##name##_line_end.gif"></td>
</table>
##--<div class="owner-descr-block" id="owner-descr-##name##">%%##name##%%</div>--##

<div style="padding:0px 0px 0px 50px" class="##name##_block">
##modules##
</span>
</td></tr>
"-->

<!--#set var="HSplitter" value=""-->

<!--#set var="VSplitter" value=""-->

<!--#set var="module" value="
<div class="start-module-block-1" id="start-module-block-##name##">
  <div class="start-module-block" id="mod-cap-##name##">
##--
    <div class="l-lt-c"></div><div class="l-rt-c"></div>
    <div class="l-lb-c"></div><div class="l-rb-c"></div>
--##
    <div class="mod-cap##class_disabled##"
    ##IF(name=="srv_host_webstat")##
      onclick="window.open('##link##');"
    ##ELSE##
      onclick="window.location='##link##';"
    ##ENDIF##
    onmouseover="document.getElementById('mod-cap-##name##').className='start-module-block-over';showModuleDescription('##name##');"
    onmouseout="document.getElementById('mod-cap-##name##').className='start-module-block';hideModuleDescription('##name##');"
    ##title_disabled##
    >
    <nobr>
    ##if(module_icon)##
      <img src="##module_icon##" align=absmiddle class="module-icon">
    ##else##
      <img src="skins/vanilla/images/##name##_icon##type##.gif" align=absmiddle  class="module-icon">
    ##endif##
    ##caption##</nobr>
    </div>
    <div class="mod-descr-block" id="mod-descr-##name##">%%##name##%%</div>
  </div>
</div>
"-->

<!--#set var="block_pages" value="
##if(
    (isset(pages_count_public) && isset(pages_count_all)) ||
    !empty(link_pages) || !empty(link_stickers) || !empty(link_templates) || !empty(link_ce_img_proc) ||
    !empty(link_ami_market) || !empty(link_mod_manager) || !empty(link_google_sitemap) || isset(pages_last_update) ||
    (isset(last_reindex) && !empty(link_reindex))
)##
<div class="start__amiro-row start__amiro-row-sky">
    <div class="start__amiro-row-header">
        <i class="fa fa-list-alt"></i>
        %%start__amiro-row-header-site_control%%
    </div>
    <div class="start__amiro-row-content">
        <div class="start__amiro-row-info-block">
            <ul>
                ##if(isset(pages_count_public) && isset(pages_count_all))##
                <li>
                    %%start__amiro-row-content-total_pages%%: <span>##pages_count_public##/##pages_count_all##</span>
                </li>
                ##endif##
                ##if(!empty(link_pages))##<li>
                    <a href="##link_pages##"><i class="fa fa-sitemap"></i>%%start__amiro-row-content-structure_pages%%</a>
                </li>##endif##
                ##if(!empty(link_stickers))##<li>
                    <a href="##link_stickers##"><i class="fa fa-sticky-note-o"></i>%%start__amiro-row-content-stickers%%</a>
                </li>##endif##
                ##if(!empty(link_templates))##<li>
                    <a href="##link_templates##"><i class="fa fa-file-text-o"></i>%%start__amiro-row-content-billets%%</a>
                </li>##endif##
                ##if(!empty(link_ce_img_proc))##<li>
                    <a href="javascript:void()" onclick="javascript:openExtDialog('%%start__amiro-row-content-media%%', '##link_ce_img_proc##?cat=&lang=&img=null', 1, 1 );return false;"><i class="fa fa-picture-o"></i>%%start__amiro-row-content-media%%</a>
                </li>##endif##
                ##if(!empty(link_ami_market))##<li>
                    <a href="##link_ami_market##"><i class="fa fa-shopping-bag"></i>%%start__amiro-row-content-amiro_market%%</a>
                </li>##endif##
                ##if(!empty(link_mod_manager))##<li>
                    <a href="##link_mod_manager##"><i class="fa fa-cube"></i>%%start__amiro-row-content-module_manager%%</a>
                </li>##endif##
                ##if(!empty(link_google_sitemap))##<li>
                    <a href="##link_google_sitemap##"><i class="fa fa-google"></i>%%start__amiro-row-content-google_sitemaps%%</a>
                </li>##endif##
                ##if(isset(pages_last_update))##<li>
                    %%start__amiro-row-content-updated%%:  <span>##pages_last_update##</span>
                </li>##endif##
                 ##if(isset(last_reindex) && !empty(link_reindex))##<li>
                    %%start__amiro-row-content-indexed%%:  <span>##last_reindex##</span> <a href="##link_reindex##">%%start__amiro-row-content-index%%</a> 
                </li>
                ##endif##
            </ul>
        </div>
    </div>
</div>
##endif##"-->

<!--#set var="block_eshop" value="
##if(
    (edition == 'business' || edition == 'minimarket') &&
    (
        (
            isset(orders_count_accepted_per_day) && isset(orders_total_accepted_per_day) &&
            isset(orders_count_confirmed_per_day) && isset(orders_total_confirmed_per_day)
        ) || (
            isset(orders_count_accepted_per_week) && isset(orders_total_accepted_per_week) &&
            isset(orders_count_confirmed_per_week) && isset(orders_total_confirmed_per_week)
        ) ||
        isset(eshop_item_last_update) || !empty(link_eshop_order) || !empty(link_eshop_item) || !empty(link_eshop_user) ||
        !empty(link_eshop_order_reports) || !empty(link_eshop_shipping_methods) || !empty(link_pay_drivers) ||
        !empty(link_pay_drivers) || !empty(link_eshop_discounts) || !empty(link_eshop_coupons)
    )
)##
<div class="start__amiro-row start__amiro-row-red">
    <div class="start__amiro-row-header">
        <i class="fa fa-shopping-cart"></i>
        %%start__amiro-row-header-online_shop%%
    </div>
    <div class="start__amiro-row-content">
        ##if(
            isset(orders_count_accepted_per_day) && isset(orders_total_accepted_per_day) &&
            isset(orders_count_confirmed_per_day) && isset(orders_total_confirmed_per_day)
        )##
        <div class="start__amiro-row-info-block">
            <span>%%start__amiro-row-content-24_hours_orders%%</span>
            <ul>
                <li>
                    %%start__amiro-row-content-accepted%%: <span>##orders_count_accepted_per_day## - ##orders_total_accepted_per_day##</span>
                </li>
                <li>
                    %%start__amiro-row-content-paid%%: <span>##orders_count_confirmed_per_day## - ##orders_total_confirmed_per_day##</span>
                </li>
            </ul>
        </div>##endif##
        ##if(
            isset(orders_count_accepted_per_week) && isset(orders_total_accepted_per_week) &&
            isset(orders_count_confirmed_per_week) && isset(orders_total_confirmed_per_week)
        )##
        <div class="start__amiro-row-info-block">
            <span>%%start__amiro-row-content-7_days_orders%%</span>
            <ul>
                <li>
                    %%start__amiro-row-content-accepted%%: <span>##orders_count_accepted_per_week## - ##orders_total_accepted_per_week##</span>
                </li>
                <li>
                    %%start__amiro-row-content-paid%%: <span>##orders_count_confirmed_per_week## - ##orders_total_confirmed_per_week##</span>
                </li>
            </ul>
        </div>##endif##
        ##if(isset(eshop_item_last_update))##<div class="start__amiro-row-info-block">
            <span>%%start__amiro-row-content-catalog_updated%%: ##eshop_item_last_update##</span>
        </div>##endif##
        <br>
        <div class="start__amiro-row-info-block">
            <div class="start__amiro-row-info-block-two_columns">
                ##if(!empty(link_eshop_order))##<a href="##link_eshop_order##"><i class="fa fa-list-ol"></i>%%start__amiro-row-content-orders%%</a>##endif##
                ##if(!empty(link_eshop_item))##<a href="##link_eshop_item##"><i class="fa fa-shopping-bag"></i>%%start__amiro-row-content-catalog%%</a>##endif##
                ##if(!empty(link_eshop_user))##<a href="##link_eshop_user##"><i class="fa fa-users"></i>%%start__amiro-row-content-buyers%%</a>##endif##
                ##if(!empty(link_eshop_order_reports))##<a href="##link_eshop_order_reports##"><i class="fa fa-bar-chart"></i>%%start__amiro-row-content-reports%%</a>##endif##
                ##if(!empty(link_eshop_shipping_methods))##<a href="##link_eshop_shipping_methods##"><i class="fa fa-truck"></i>%%start__amiro-row-content-delivery_methods%%</a>##endif##
                ##if(!empty(link_pay_drivers))##<a href="##link_pay_drivers##"><i class="fa fa-credit-card"></i>%%start__amiro-row-content-payment_methods%%</a>##endif##
                ##if(!empty(link_eshop_discounts))##<a href="##link_eshop_discounts##"><i class="fa fa-percent"></i>%%start__amiro-row-content-discounts%%</a>##endif##
                ##if(!empty(link_eshop_coupons))##<a href="##link_eshop_coupons##"><i class="fa fa-ticket"></i>%%start__amiro-row-content-coupons%%</a>##endif##
                ##if(!empty(link_eshop_data_exchange))##<a href="##link_eshop_data_exchange##"><i class="fa fa-exchange"></i>%%start__amiro-row-content-exchange%%</a>##endif##
                ##if(!empty(link_eshop_currency))##<a href="##link_eshop_currency##"><i class="fa fa-rub"></i>%%start__amiro-row-content-currency%%</a>##endif##
            </div>
        </div>
    </div>
</div>
##endif##"-->

<!--#set var="block_feed" value="
##if(
    (!empty(link_feedback) && isset(feedback_activity_per_day)) ||
    (!empty(link_jobs_employer) && isset(jobs_employer_activity_per_day)) ||
    (!empty(link_jobs_history) && isset(jobs_history_activity_per_day)) ||
    (!empty(link_classifieds) && isset(classifieds_activity_per_day)) ||
    (!empty(link_discussion) && isset(discussion_activity_per_day)) ||
    (!empty(link_faq) && isset(faq_activity_per_day)) ||
    (!empty(link_forum) && isset(forum_activity_per_day)) ||
    (!empty(link_guestbook) && isset(guestbook_activity_per_day))
)##
<div class="start__amiro-row start__amiro-row-blue">
    <div class="start__amiro-row-header">
        <i class="fa fa-child"></i>
        %%start__amiro-row-header-visitors_activity%%
    </div>
    <div class="start__amiro-row-content">
        <div class="start__amiro-row-info-block">
            <ul>
                <li>
                    %%start__amiro-row-content-untreated_received_over_24_hours%%:
                </li>
                ##if(!empty(link_feedback) && isset(feedback_activity_per_day))##<li>
                    <a href="##link_feedback##"><i class="fa fa-reply-all"></i>%%start__amiro-row-content-feedback%%</a>: <span>##feedback_activity_per_day##</span>
                </li>##endif##
                ##if(!empty(link_jobs_history) && isset(jobs_history_activity_per_day))##<li>
                    <a href="##link_jobs_history##"><i class="fa fa-users"></i>%%start__amiro-row-content-request_applicants%%</a>: <span>##jobs_history_activity_per_day##</span>
                </li>##endif##
                ##if(!empty(link_jobs_employer) && isset(jobs_employer_activity_per_day))##<li>
                    <a href="##link_jobs_employer##"><i class="fa fa-user"></i>%%start__amiro-row-content-request_employers%%</a>: <span>##jobs_employer_activity_per_day##</span>
                </li>##endif##
                ##if(!empty(link_classifieds) && isset(classifieds_activity_per_day))##<li>
                    <a href="##link_classifieds##"><i class="fa fa-bullhorn"></i>%%start__amiro-row-content-ads%%</a>: <span>##classifieds_activity_per_day##</span>
                </li>##endif##
                ##if(!empty(link_discussion) && isset(discussion_activity_per_day))##<li>
                    <a href="##link_discussion##"><i class="fa fa-commenting-o"></i>%%start__amiro-row-content-comments%%</a>: <span>##discussion_new_activity_per_day## / ##discussion_activity_per_day##</span>
                </li>##endif##
                ##if(!empty(link_faq) && isset(faq_activity_per_day))##<li>
                    <a href="##link_faq##"><i class="fa fa-question"></i>%%start__amiro-row-content-question_answer%%</a>: <span>##faq_activity_per_day##</span>
                </li>##endif##
                ##if(!empty(link_forum) && isset(forum_activity_per_day))##<li>
                    <a href="##link_forum##"><i class="fa fa-comments-o"></i>%%start__amiro-row-content-forum_posts%%</a>: <span>##forum_new_activity_per_day## / ##forum_activity_per_day##</span>
                </li>##endif##
                ##if(!empty(link_guestbook) && isset(guestbook_activity_per_day))##<li>
                    <a href="##link_guestbook##"><i class="fa fa-book"></i>%%start__amiro-row-content-guestbook%%</a>: <span>##guestbook_new_activity_per_day## / ##guestbook_activity_per_day##</span>
                </li>##endif##
            </ul>
        </div>
    </div>
</div>
##endif##"-->

<!--#set var="block_templates" value="
##if(
    !empty(link_layouts) || !empty(link_modules_templates) || !empty(link_locales) || !empty(link_srv_options) ||
    !empty(link_options_data) || !empty(link_ami_webservice) || !empty(link_ami_service)
)##
<div class="start__amiro-row start__amiro-row-green">
    <div class="start__amiro-row-header">
        <i class="fa fa-square-o"></i>
        %%start__amiro-row-header-design_properties%%
    </div>
    <div class="start__amiro-row-content">
        <div class="start__amiro-row-info-block">
            <ul>
                ##if(!empty(link_layouts))##<li>
                    <a href="##link_layouts##"><i class="fa fa-paint-brush"></i>%%start__amiro-row-content-import_export_design%%</a>
                </li>##endif##
                ##if(!empty(link_layouts))##<li>
                    <a href="##link_layouts##"><i class="fa fa-pencil-square-o"></i>%%start__amiro-row-content-page_layouts_styles%%</a>
                </li>##endif##
                ##if(!empty(link_modules_templates))##<li>
                    <a href="##link_modules_templates##"><i class="fa fa-sticky-note-o"></i>%%start__amiro-row-content-modules_templates%%</a>
                </li>##endif##
                ##if(!empty(link_locales))##<li>
                    <a href="##link_locales##"><i class="fa fa-language"></i>%%start__amiro-row-content-localization%%</a>
                </li>##endif##
                <li></li>
                ##if(!empty(link_srv_options))##<li>
                    <a href="##link_srv_options##"><i class="fa fa-wrench"></i>%%start__amiro-row-content-system_options%%</a>
                </li>##endif##
                ##if(!empty(link_options_data))##<li>
                    <a href="##link_options_data##"><i class="fa fa-clock-o"></i>%%start__amiro-row-content-settings_change_log%%</a>
                </li>##endif##
                ##if(!empty(link_ami_webservice))##<li>
                    <a href="##link_ami_webservice##"><i class="fa fa-globe"></i>%%start__amiro-row-content-web_services%%</a>
                </li>##endif##
                ##if(!empty(link_ami_service))##<li>
                    <a href="##link_ami_service##"><i class="fa fa-refresh"></i>%%start__amiro-row-content-service%%</a>
                </li>##endif##
                ##if(!empty(link_ami_service))##<li>
                    <a href="##link_ami_service##"><i class="fa fa-cubes"></i>%%start__amiro-row-content-cache_management%%</a>
                </li>##endif##
            </ul>
        </div>
    </div>
</div>
##endif##"-->

<!--#set var="block_system" value="
##if(
    (!empty(edition) && !empty(link_srv_licence)) ||
    (!empty(cms_version) && !empty(link_srv_updates)) ||
    (hostmode == 'single' && !empty(updates_valid_till) && !empty(domain)) ||
    (!empty(last_login_date) && !empty(last_login_ip) && !empty(link_srv_login_history)) ||
    !empty(link_srv_backups) || !empty(link_choose_lang)
)##
<div class="start__amiro-row start__amiro-row-gray">
    <div class="start__amiro-row-header">
        <i class="fa fa-paper-plane"></i>
        %%start__amiro-row-header-system%%
    </div>
    <div class="start__amiro-row-content">
        <div class="start__amiro-row-info-block">
            <ul>
                ##if(!empty(edition))##<li>
                    %%start__amiro-row-content-edition%%: <a href="http://www.amiro.ru/product/amiro.cms/editions/review">Amiro.CMS %%amiro_cms_edition_##edition##%%</a>
                    ##if(!empty(link_srv_licence))##<a href="##link_srv_licence##">%%start__amiro-row-content-license%%</a>##endif##
                </li>##endif##
                ##if(!empty(domain))##<li>
                    %%start__amiro-row-content-domain%%: <span>##domain##</span>
                </li>
                ##if(!empty(domain_alias))##<li>
                    %%start__amiro-row-content-alias%%: <span>##domain_alias##</span>
                </li>##endif##
                ##if(!empty(cms_version) && !empty(link_srv_updates))##<li>
                    %%start__amiro-row-content-version%%: <span>##cms_version##
                    ##if(hostmode == 'single')##<a href="##link_srv_updates##">%%start__amiro-row-content-update%%</a>##endif##</span>
                </li>##endif##
                ##if(hostmode == 'single' && !empty(updates_valid_till) && !empty(domain))##<li>
                    %%start__amiro-row-content-updates_available_up_to%%: <span>##updates_valid_till##</span>
                    <a href="http://www.amiro.ru/product/amiro.cms/updates?domain=##domain##">%%start__amiro-row-content-extend%%</a>
                </li>##endif##
                ##if(!empty(last_login_date) && !empty(last_login_ip) && !empty(link_srv_login_history) && !empty(link_active_sessions))##<li>
                    %%start__amiro-row-content-last_entrance%%: <span>##last_login_date## ##last_login_ip##</span>
                    <a href="##link_srv_login_history##">%%start__amiro-row-content-history%%</a>
                    <a href="##link_active_sessions##">##caption_active_sessions##</a>
                </li>##endif##
                ##if(!empty(link_srv_backups))##<li>
                    %%start__amiro-row-content-backup%%: <span>##last_backup_date##</span>
                    <a href="##link_srv_backups##">%%start__amiro-row-content-create%%</a>
                </li>##endif##
                ##if(!empty(link_choose_lang))##<li>
                    %%start__amiro-row-content-interface_language%%: <span></span>
                    <a href="##link_choose_lang##">%%start__amiro-row-content-change%%</a>
                </li>##endif##
            </ul>
        </div>
    </div>
</div>
##endif##"-->

<!--#set var="block_hosting" value="
##if(hostmode == 'shared' && !empty(link_srv_host_payments))##
<div class="start__amiro-row start__amiro-row-purple">
    <div class="start__amiro-row-header">
        <i class="fa fa-server"></i>
        %%start__amiro-row-header-hosting%%
    </div>
    <div class="start__amiro-row-content">
        <div class="start__amiro-row-info-block">
            <ul>
                ##if(!empty(hosting_note))##<li>
                    %%start__amiro-row-content-note%%: <span>##hosting_note##</span>
                </li>##endif##
                ##if(isset(last_payment_amount) && !empty(last_payment_date))##<li>
                    %%start__amiro-row-content-paid%%:   <span>##last_payment_amount##, ##last_payment_date##</span>
                    ##if(!empty(link_srv_host_payments_history))##<a href="##link_srv_host_payments_history##">%%start__amiro-row-content-history%%</a>##endif##
                </li>##endif##
                ##if(isset(balance_amount))##<li>
                    %%start__amiro-row-content-balance%%: <span>##balance_amount##</span>
                    ##if(!empty(link_srv_host_payments_add))##<a href="##link_srv_host_payments_add##">%%start__amiro-row-content-add%%</a>##endif##
                    ##if(!empty(link_srv_host_payments))##<a href="##link_srv_host_payments##">%%start__amiro-row-content-deferment_payment%%</a>##endif##
                </li>##endif##
                ##if(isset(balance_amount_min))##<li>
                    %%start__amiro-row-content-minimum_balance%%: <span>##balance_amount_min##</span>
                </li>##endif##
                ##if(isset(payment_amount_month))##<li>
                    %%start__amiro-row-content-rent_per_month%%: <span>##payment_amount_month##</span>
                </li>##endif##
                <li>
                    %%start__amiro-row-content-payer%%: <span>##hosting_client_name##</span>
                    ##if(isset(link_srv_host_payments_props))##<a href="##link_srv_host_payments_props##">%%start__amiro-row-content-change%%</a>##endif##
                    ##if(isset(link_srv_host_payments_docs))##<a href="##link_srv_host_payments_docs##">%%start__amiro-row-content-documentation%%</a>##endif##
                </li>
                <li></li>
                ##if(isset(hosting_disk_space) && isset(hosting_disk_quota))##<li>
                    %%start__amiro-row-content-disk_space%%: <span>##hosting_disk_space## / ##hosting_disk_quota##</span>
                </li>##endif##
                ##if(isset(hosting_db_size))##<li>
                    %%start__amiro-row-content-database%%: <span>##hosting_db_size##</span>
                </li>##endif##
                ##if(isset(hosting_email_space_used) && isset(hosting_email_quota))##<li>
                    %%start__amiro-row-content-mail%%: <span>##hosting_email_space_used## / ##hosting_email_quota##</span>
                </li>##endif##
                ##if(isset(hosting_ftp_status))##<li>
                    %%start__amiro-row-content-ftp_access_enabled%%: <span>##if(intval(hosting_ftp_status))##%%yes%%##else##%%no%%##endif##</span>
                </li>##endif##
                ##if(!empty(link_srv_host_mailmanage))##<li>
                    <a href="##link_srv_host_mailmanage##"><i class="fa fa-inbox"></i>%%start__amiro-row-content-manage_mailboxes%%</a>
                </li>##endif##
            </ul>
        </div>
    </div>
</div>
##endif##"-->

<!--#set var="block_modules" value="
##if(
    !empty(multifeeds) || !empty(link_files) || !empty(link_subscribe) || !empty(link_votes) ||
    !empty(link_search) || !empty(link_adv_places) || !empty(link_modules_custom_fields)
)##
<div class="start__amiro-row start__amiro-row-ghost-white">
    <div class="start__amiro-row-header">
        <i class="fa fa-cubes"></i>
        %%start__amiro-row-header-modules%%
    </div>
    <div class="start__amiro-row-content">
        <div class="start__amiro-row-info-block">
            <ul>
                ##multifeeds##
                ##if(!empty(link_files))##
                <li>
                    <a href="##link_files##"><i class="fa fa-floppy-o"></i>%%start__amiro-row-content-files%%</a>
                </li>##endif##
                ##if(edition == 'minimarket' && !empty(link_eshop_item))##<li>
                    <a href="##link_eshop_item##"><i class="fa fa-shopping-bag"></i>%%start__amiro-row-content-catalog%%</a>##endif##
                </li>##endif##
                ##if(!empty(link_subscribe))##<li>
                    <a href="##link_subscribe##"><i class="fa fa-feed"></i>%%start__amiro-row-content-subscribe%%</a>
                </li>##endif##
                ##if(!empty(link_votes))##<li>
                    <a href="##link_votes##"><i class="fa fa-bar-chart"></i>%%start__amiro-row-content-polls%%</a>
                </li>##endif##
                ##if(!empty(link_search))##<li>
                    <a href="##link_search##"><i class="fa fa-search"></i>%%start__amiro-row-content-search%%</a>
                </li>##endif##
                ##if(!empty(link_adv_places))##<li>
                    <a href="##link_adv_places##"><i class="fa fa-line-chart"></i>%%start__amiro-row-content-ad_manage%%</a>
                </li>##endif##
                ##if(!empty(link_modules_custom_fields))##<li>
                    <a href="##link_modules_custom_fields##"><i class="fa fa-th-large"></i>%%start__amiro-row-content-fields_sets%%</a>
                </li>##endif##
            </ul>
        </div>
    </div>
</div>
##endif##"-->

<!--#set var="display_menu" value="
    <div style="height: 7px;"></div>

    <table border=0 cellpadding=0 cellspacing=0 width=100% class="startPage">
    ##content##
    </table>
    <div style="height:100px;"></div>
    <div style="padding: 20px"><a href="" onclick="switchMode()"/>%%switch_start_page_mode_new%%</a></div>
"-->

<!--#set var="display_dashboard" value="
    ##content##
    <div style="padding: 20px"><a href="" onclick="switchMode()"/>%%switch_start_page_mode_old%%</a></div>
"-->

<!--#set var="external_informer_amiro_news" value="
##if(!empty(rows))##
    <div class="start__amiro-row-info-block">
        <ul>
            ##rows##
        </ul>
    </div>
##endif##
"-->

<!--#set var="external_informer_partner_news" value="
##if(!empty(rows))##
    <div class="start__amiro-row-info-block">
        <span>%%start__amiro-row-content-partners_events%%</span>
        <ul>
            ##rows##
        </ul>
    </div>
##endif##
"-->

<!--#set var="external_informer_row" value="<li><a target="_blank" href="##url##">##header##</a></li>"-->


<!--#set var="multifeed_row" value="
##setvar @icon=(instance=='news'?'fa-newspaper-o':(instance=='blog'?'fa-pencil-square':(instance=='photoalbum'?'fa-camera-retro':'fa-paste')))##
<li>
    <a href="##link##"><i class="fa ##icon##"></i>##caption##</a>
</li>
"-->

<script>
var oQSImgOver = new Image();
oQSImgOver.src = 'skins/vanilla/icons/arr_right_icon_small_anim.gif';

var lastModule = '';
var showDescInterval;

function showModuleDescription(modName){
  if (document.getElementById('mod-descr-'+modName).innerHTML!=''){
    showDescInterval = window.setInterval( function(){
        document.getElementById('mod-descr-'+modName).style.display='block';
        document.getElementById('mod-cap-'+modName).className='start-module-block-full';
        document.getElementById('start-module-block-'+modName).style.zIndex = 1;
        }, 1200);
  }

}

function hideModuleDescription(modName){

  window.clearInterval(showDescInterval);
  document.getElementById('mod-descr-'+modName).style.display='none';
  document.getElementById('mod-cap-'+modName).className='start-module-block';
  document.getElementById('start-module-block-'+modName).style.zIndex = 0;
}

function displaySubModulesBlock(evt, name){
    evt = amiCommon.getValidEvent(evt);
    var tgtElement = amiCommon.getEventTarget(evt);
    var
        oBlock = document.getElementById('submenu_block'),
        cLeft = getx(tgtElement) + tgtElement.offsetWidth,
        cTop = gety(tgtElement) + tgtElement.offsetHeight;

    showSubMenu(name, cLeft, cTop);

    var
        correctLeft = cLeft + oBlock.offsetWidth - getScrollLeft() - document.body.clientWidth,
        correctTop = cTop + oBlock.offsetHeight - getScrollTop() - document.body.clientHeight;

    oBlock.style.left = cLeft - (correctLeft > 0 ? correctLeft : 0) + 'px';
    oBlock.style.top = cTop - (correctTop > 0 ? correctTop : 0) + 'px';

    amiCommon.stopEvent(evt);
}

function switchMode(mode){
    var current = AMI.Cookie.get("startPageMode");
    if(mode == null) {
        if(current == null || current == 'dashboard') {
            mode = 'menu';
        }
        else {
            mode = 'dashboard';
        }
    }
    AMI.Cookie.set("startPageMode", mode, 3600 * 24 * 30 * 12, "/", true);
    AMI.Cookie.save();
    // setTimeout(function() {window.location.reload();}, 500);
}

</script>

##content##