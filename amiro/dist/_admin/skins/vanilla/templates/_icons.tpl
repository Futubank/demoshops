##--!ver=0200 rules="-SETVAR|-IF"--##
%%include_language "templates/lang/_icons.lng"%%
<!--#set var="sort_asc"      value="<span><a href="javascript:" onclick="javascript:resort('##key##','asc');return false;"><img title="%%icon_sort_asc%%" helpId="icon_sort_asc" align=baseline class=icon_sort src=skins/vanilla/icons/icon-inc.gif hspace="0"></a></span>"-->
<!--#set var="sort_desc"     value="<span><a href="javascript:" onclick="javascript:resort('##key##','desc');return false;"><img title="%%icon_sort_desc%%" helpId="icon_sort_desc" align=baseline class=icon_sort src=skins/vanilla/icons/icon-dec.gif hspace="0"></a></span>"-->
<!--#set var="sort_asc_sel"  value="<span><img align=baseline class=icon_sort src=skins/vanilla/icons/icon-inc-sel.gif hspace="0" onload="this.parentNode.parentNode.style.color='#ba4600'"></span>"-->
<!--#set var="sort_desc_sel" value="<span><img align=baseline class=icon_sort src=skins/vanilla/icons/icon-dec-sel.gif hspace="0" onload="this.parentNode.parentNode.style.color='#ba4600'"></span>"-->

<!--#set var="sort_block" value="<div class="sort_block">##content##</div>"--> ##-- guys, please, parse sort icons trough this block--##

<!--#set var="public_on"     value="<a href="javascript:" onclick="javascript:publish('##pub_id##','off');return false;"><img title="%%icon_public_on%%" helpId="icon_public_on" class=icon src="skins/vanilla/icons/icon-published.gif" border="0"></a>"-->
<!--#set var="public_off"    value="<a href="javascript:" onclick="javascript:publish('##pub_id##','on');return false;"><img title="%%icon_public_off%%" helpId="icon_public_off" class=icon src="skins/vanilla/icons/icon-notpublished.gif" border="0"></a>"-->

<!--#set var="spec_public_on"     value="<a href="javascript:" onclick="javascript:publish('##pub_id##','off');return false;"><img title="%%icon_spec_public_on%%" helpId="icon_spec_public_on" class=icon src="skins/vanilla/icons/icon-spec_published.gif" border="0"></a>"-->
<!--#set var="spec_public_off"    value="<a href="javascript:" onclick="javascript:publish('##pub_id##','on');return false;"><img title="%%icon_spec_public_off%%" helpId="icon_spec_public_off" class=icon src="skins/vanilla/icons/icon-spec_notpublished.gif" border="0"></a>"-->

<!--#set var="operation_on"     value="<img title="%%icon_operation_on%%" helpId="icon_operation_on" class=leg_icon src="skins/vanilla/icons/icon-operation_on.gif" border="0">"-->
<!--#set var="operation_off"    value="<img title="%%icon_operation_off%%" helpId="icon_operation_off" class=leg_icon src="skins/vanilla/icons/icon-operation_off.gif" border="0">"-->

<!--#set var="public_on_multi"     value="<a href="javascript:" onClick="if (confirm('%%publish_warn_multi%%')) {publish('##pub_id##','off');};retirn false"><img title="%%icon_public_on%%" helpId="icon_public_on" class=icon src="skins/vanilla/icons/icon-published.gif" border="0"></a>"-->
<!--#set var="public_off_multi"    value="<a href="javascript:" onClick="if (confirm('%%publish_warn_multi%%')){publish('##pub_id##','on');};return false"><img title="%%icon_public_off%%" helpId="icon_public_off" class=icon src="skins/vanilla/icons/icon-notpublished.gif" border="0"></a>"-->

<!--#set var="locked_on"     value="<a href="javascript:" onclick="javascript:lock('##lock_id##','off');return false;"><img title="%%icon_locked_on%%" helpId="icon_locked_on" class=icon src="skins/vanilla/icons/icon-locked.gif"></a>"-->
<!--#set var="locked_off"    value="<a href="javascript:" onclick="javascript:lock('##lock_id##','on');return false;"><img title="%%icon_locked_off%%" helpId="icon_locked_off" class=icon src="skins/vanilla/icons/icon-unlocked.gif"></a>"-->

<!--#set var="locked_on_disabled"     value="<img title="%%icon_locked_on_disabled%%" helpId="icon_locked_on_disabled" class=icon src="skins/vanilla/icons/icon-locked.gif">"-->
<!--#set var="locked_off_disabled"    value="<img title="%%icon_locked_off_disabled%%" helpId="icon_locked_off_disabled" class=icon src="skins/vanilla/icons/icon-unlocked.gif">"-->

<!--#set var="active_on"     value="<a href="javascript:" onclick="javascript:activate('##act_id##','off');return false;"><img title="%%icon_active_on%%" helpId="icon_active_on" class=icon src="skins/vanilla/icons/icon-ok.gif"></a>"-->
<!--#set var="active_off"    value="<a href="javascript:" onclick="javascript:activate('##act_id##','on');return false;"><img title="%%icon_active_off%%" helpId="icon_active_off" class=icon src="skins/vanilla/icons/icon-close.gif"></a>"-->

<!--#set var="icon_active_on"     value="<img alt="%%icon_active_on%%" title="%%icon_active_on%%" class="icon" src="skins/vanilla/icons/icon-ok.gif" />"-->
<!--#set var="icon_active_off"    value="<img alt="%%icon_active_off%%" title="%%icon_active_off%%" class="icon" src="skins/vanilla/icons/icon-close.gif" />"-->

<!--#set var="spec_active_on"     value="<img title="%%icon_spec_active_on%%" helpId="icon_spec_active_on" class=icon src="skins/vanilla/icons/icon-spec_ok.gif"></a>"-->
<!--#set var="spec_active_off"    value="<a href="javascript:" onclick="javascript:activate('##spec_act_id##','on');return false;"><img title="%%icon_spec_active_off%%" helpId="icon_spec_active_off" class=icon src="skins/vanilla/icons/icon-spec_close.gif"></a>"-->

<!--#set var="spec2_active_on"     value="<img title="%%icon_spec2_active_on%%" helpId="icon_spec2_active_on" class=icon src="skins/vanilla/icons/icon-spec2_ok.gif"></a>"-->
<!--#set var="spec2_active_off"    value="##--<a href="javascript:" onclick="javascript:activate2('##spec2_act_id##','on');return false;"><img title="%%icon_spec2_active_off%%" helpId="icon_spec2_active_off" class=icon src="skins/vanilla/icons/icon-spec2_close.gif"></a>--##&nbsp;"-->

<!--#set var="spec3_active_on"     value="<img title="%%icon_spec3_active_on%%" helpId="icon_spec3_active_on" class=icon src="skins/vanilla/icons/icon-spec_ok.gif"></a>"-->
<!--#set var="spec3_active_off"    value="&nbsp;"-->

<!--#set var="spec4_active_on"     value="<img title="%%icon_spec4_active_on%%" helpId="icon_spec4_active_on" class=icon src="skins/vanilla/icons/icon-spec_ok.gif"></a>"-->
<!--#set var="spec4_active_off"    value="&nbsp;"-->

<!--#set var="deleted_on"    value="<img title="%%icon_deleted_on%%" helpId="icon_deleted_on" class=icon src="skins/vanilla/icons/icon-close.gif">"-->
<!--#set var="deleted_off"     value="<img title="%%icon_deleted_off%%" helpId="icon_deleted_off" class=icon src="skins/vanilla/icons/icon-ok.gif">"-->

<!--#set var="archive_on"     value="<a href="javascript:" onclick="javascript:archive('##arch_id##','off');return false;"><img title="%%icon_archive_on%%" helpId="icon_archive_on" class=icon src="skins/vanilla/icons/icon-archived.gif"></a>"-->
<!--#set var="archive_off"    value="<a href="javascript:" onclick="javascript:archive('##arch_id##','on');return false;"><img title="%%icon_archive_off%%" helpId="icon_archive_off" class=icon src="skins/vanilla/icons/icon-not_archived.gif"></a>"-->

<!--#set var="images_add"     value="<a href="javascript:" onclick="javascript:openDialog('%%add_images%%', '##url##');return false;"><img id="##id##" title="%%add_images%%" helpId="add_images" class=icon src="skins/vanilla/icons/icon-no_scrnshot.gif" style='vertical-align:middle;'></a>"-->
<!--#set var="images_edit"    value="<a href="javascript:" onclick="javascript:openDialog('%%edit_images%%', '##url##');return false;"><img id="##id##" title="%%edit_images%%" helpId="edit_images" class=icon src="skins/vanilla/icons/icon-scrnshot.gif" style='vertical-align:middle;'></a>"-->
<!--#set var="image_edit"     value="<a href="ce_img_proc.php?cat=##cat##&img=##field##&lang=##admin_lang##" target="_blank"><img title="%%edit_image%%" helpId="edit_image" class=icon src="skins/vanilla/icons/icon-scrnshot.gif"></a>"-->
<!--#set var="image_show"     value="<a href="javascript:" onclick="javascript:show_picture('##src##','##alt_js##', '##width##', '##height##');return false;"><img title="##name##" class=icon src="skins/vanilla/icons/icon-scrnshot.gif"></a>"-->

<!--#set var="special_on"     value="<a href="javascript:" onclick="javascript:special('##spec_id##','off');return false;"><img title="%%icon_special_on%%" helpId="icon_special_on" class=icon src="skins/vanilla/icons/icon-special1.gif" border="0"></a>"-->
<!--#set var="special_off"    value="<a href="javascript:" onclick="javascript:special('##spec_id##','on');return false;"><img title="%%icon_special_off%%" helpId="icon_special_off" class=icon src="skins/vanilla/icons/icon-notspecial1.gif" border="0"></a>"-->

<!--#set var="special_advanced_on"     value="<a href="javascript:" onClick="javascript:openDialog('%%eshop_special_form%%', '##script_link##?action=special&id=##spec_id##', 380, 280); return false;"><img title="%%icon_special_on%%" helpId="icon_special_on" class=icon src="skins/vanilla/icons/icon-special1.gif" border="0"></a>"-->
<!--#set var="special_advanced_off"    value="<a href="javascript:" onClick="javascript:openDialog('%%eshop_special_form%%', '##script_link##?action=special&id=##spec_id##', 380, 280);return false;"><img title="%%icon_special_off%%" helpId="icon_special_off" class=icon src="skins/vanilla/icons/icon-notspecial1.gif" border="0"></a>"-->

<!--#set var="is_default_on"     value="<img title="%%icon_is_default_on%%" helpId="icon_is_default_on" class=icon src="skins/vanilla/icons/icon-ok.gif" border="0">"-->
<!--#set var="is_default_off"    value="<a href="javascript:" onclick="javascript:user_click('default', '##def_id##');return false;"><img title="%%icon_is_default_off%%" helpId="icon_is_default_off" class=icon src="skins/vanilla/icons/icon-empty.gif" border="0"></a>"-->


<!--#set var="icon_attach"     value="<a href="ftpgetfile.php?id=##att_id##&module=##module##" target="_blank"><img title="##name##" class=icon src="skins/vanilla/icons/icon-clip.gif"></a>"-->

<!--#set var="icon_public_on"     value="<img title="%%icon_public_on%%" helpId="icon_public_on" class=icon src="skins/vanilla/icons/icon-published.gif" border="0">"-->
<!--#set var="icon_public_off"    value="<img title="%%icon_public_off%%" helpId="icon_public_off" class=icon src="skins/vanilla/icons/icon-notpublished.gif" border="0">"-->

<!--#set var="icon_archive_on"     value="<img title="%%static_icon_archive_on%%" helpId="static_icon_archive_on" class=icon src="skins/vanilla/icons/icon-archived.gif">"-->
<!--#set var="icon_archive_off"    value="<img title="%%static_icon_archive_off%%" helpId="static_icon_archive_off" class=icon src="skins/vanilla/icons/icon-not_archived.gif">"-->

<!--#set var="icon_paid"     value="<img title="%%paid%%" helpId="paid" class=icon src="skins/vanilla/icons/icon-paid.gif">"-->

<!--#set var="icon_view" value="
 <a href="javascript:" onclick="javascript:user_click('view','##view_id##');return false;"><img title="%%icon_view%%" helpId="icon_view" class=icon src="skins/vanilla/icons/icon-view.gif"></a>
"-->

<!--#set var="icon_print" value="
 <a href="javascript:" onclick="javascript:user_click_blank('print','##print_id##');return false;"><img title="%%icon_print%%" helpId="icon_print" class=icon src="skins/vanilla/icons/icon-print.gif"></a>
"-->
<!--#set var="icon_print_popup" value="
 <a href="javascript:void(0);" onClick="javascript:openDialog('%%eshop_print_form%%', '##script_link##?action=print&id=##print_id##', 320, 180); return false;"><img title="%%icon_print%%" helpId="icon_print" class=icon src="skins/vanilla/icons/icon-print.gif"></a>
"-->

<!--#set var="icon_view_external" value="
 <a href="##view_link##" target="_blank"><img title="%%icon_view%%" helpId="icon_view" class=icon src="skins/vanilla/icons/icon-view.gif"></a>
"-->

<!--#set var="icons_view_del"     value="
<a href="javascript:" onclick="javascript:user_click('view','##view_id##');return false;"><img title="%%icon_view%%" helpId="icon_view" class=icon src="skins/vanilla/icons/icon-view.gif"></a>
<a href="javascript:" onClick="if (confirm('%%delete_warn%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icons_view"     value="
<a href="javascript:" onclick="javascript:user_click('view','##view_id##');return false;"><img title="%%icon_view%%" helpId="icon_view" class=icon src="skins/vanilla/icons/icon-view.gif"></a>
"-->

<!--#set var="icon_email"     value="
<a href="javascript:" onClick="if (confirm('%%email_warn%%')){user_click('email','##email_id##');}return false;"><img title="%%icon_email%%" helpId="icon_email" class=icon src="skins/vanilla/icons/icon-email.gif"></a>
"-->

<!--#set var="icons_edit"     value="
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
"-->

<!--#set var="icon_del_popup"     value="
<a href="javascript:" OnClick="javascript:openDialog('%%delete_popup%%', '##script_link##?action=del&id=##del_id##', 450, 230);return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icons_edit_del"     value="
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
<a href="javascript:" onClick="if (confirm('%%delete_warn%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icons_edit_deloff"     value="
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
"-->

<!--#set var="icons_edit_del_multi"     value="
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
<a href="javascript:" onClick="if (confirm('%%delete_warn_multi%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icons_votes"     value="
<nobr>
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
<a href="javascript:" onclick="javascript:user_click('result','##edit_id##');return false;"><img title="%%icon_result%%" helpId="icon_result" class=icon src="skins/vanilla/icons/icon-result.gif"></a>
<a href="javascript:" onClick="if (confirm('%%reset_warn%%')){user_click('reset','##edit_id##');}return false;"><img title="%%icon_reset_num%%" helpId="icon_reset_num" class=icon src="skins/vanilla/icons/icon-reset_num.gif"></a>
<a href="javascript:" onClick="if (confirm('%%delete_warn%%')){user_click('del','##del_id##');};return false"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
</nobr>
"-->

<!--#set var="icons_edit_reset_del"     value="
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
<a href="javascript:" onClick="if (confirm('%%reset_pass_warn%%')){user_click('reset','##reset_id##');}return false;"><img title="%%icon_reset%%" helpId="icon_reset" class=icon src="skins/vanilla/icons/icon-reset_pass.gif"></a>
<a href="javascript:" onClick="if (confirm('%%delete_warn%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icons_edit_reset"     value="
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
<a href="javascript:" onClick="if (confirm('%%reset_pass_warn%%')){user_click('reset','##reset_id##');}return false;"><img title="%%icon_reset%%" helpId="icon_reset" class=icon src="skins/vanilla/icons/icon-reset_pass.gif"></a>
"-->

<!--#set var="icons_edit_del_reply"     value="
<a href="javascript:" onclick="javascript:##if(is_topic)##setFilterToDisplayThread(##id_thread##);##endif##user_click('reply','##reply_id##');return false;"><img title="%%icon_reply%%" helpId="icon_reply" class=icon src="skins/vanilla/icons/icon-reply.gif"></a>
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
<a href="javascript:" onClick="if (confirm('%%delete_warn%%')){user_click('del','##del_id##');};return false"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icons_layouts"     value="
<a href="##view_link##" target="_blank" onClick="return show_layout_check('##page_id##');return false;"><img title="%%icon_view%%" helpId="icon_view" class=icon src="skins/vanilla/icons/icon-view.gif"></a>
<a href="javascript:" onclick="javascript:user_click('copy','##copy_id##');return false;" ><img title="%%icon_copy%%" helpId="icon_copy" class=icon src="skins/vanilla/icons/icon-copy.gif"></a>
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;" ><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
<a href="javascript:" onClick="if(confirm('%%restore_warn%%')) { user_click('restore','##restore_id##');} return false;" ><img title="%%icon_restore%%" helpId="icon_restore" class=icon src="skins/vanilla/icons/icon-restore.gif"></a>
<a href="javascript:" onClick="if(confirm('%%backup_warn%%')) { user_click('backup','##backup_id##');} return false;" ><img title="%%icon_backup%%" helpId="icon_backup" class=icon src="skins/vanilla/icons/icon-backup.gif"></a>
"-->

<!--#set var="icon_layout_del" value="
<a href="javascript:" OnClick="javascript:openDialog('%%are_you_sure%%', '##script_link##?action=del&id=##del_id##', 360, 180);return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icon_layout_del_default" value="
<a href="javascript:" OnClick="javascript:alert('%%default_layout_del%%');return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icon_prt_type_del" value="
<a href="javascript:" OnClick="javascript:openDialog('%%are_you_sure%%', '##script_link##?action=del&id=##del_id##', 400, 230);return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icon_prt_type_del_last" value="
<a href="javascript:" OnClick="javascript:alert('%%last_type_del%%');return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->



<!--#set var="icon_hostuser_edit" value="
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
"-->

<!--#set var="icon_hostuser_del" value="
<a href="javascript:" onClick="javascript:openDialog('%%title_del_popup%%', '##script_link##?action=del&id=##del_id##&type=popup', 340, 320); return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icon_hostuser_copy" value="
<a href="javascript:" onClick="javascript:openDialog('%%title_copy%%', '##script_link##?action=copy&id=##copy_id##&type=popup', 380, 420); return false;"><img
    title="%%icon_copy%%" helpId="icon_copy" class=icon src="skins/vanilla/icons/icon-copy.gif"></a>
"-->

<!--#set var="icon_payments_reset" value="
<a href="javascript:" onClick="if (confirm('%%payments_reset_warn%%')){user_click('reset','##edit_id##');}return false;"><img title="%%icon_payments_reset%%" helpId="icon_payments_reset" class=icon src="skins/vanilla/icons/icon-default.gif"></a>
"-->


<!--#set var="icons_mailmanage" value="
<nobr>
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
<a href="javascript:" onClick="if(confirm('%%purge_mbox_confirm%% \'##email##\' ?')) {user_click('purge','##del_id##');} return false;"><img title="%%icon_purge%%" helpId="icon_purge" class=icon src="skins/vanilla/icons/icon-default.gif"></a>
<a href="javascript:" onClick="if(confirm('%%delete_mbox_confirm%% \'##email##\' ?')) {user_click('del','##del_id##');} return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
</nobr>
"-->

<!--#set var="onlock" value="<nobr><img title="%%onlock%%" helpId="onlock" class=icon_leg src="skins/vanilla/icons/icon-locked_leg.gif"> - %%onlock%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="notlock" value="<nobr><img title="%%notlock%%" helpId="notlock" class=icon_leg src="skins/vanilla/icons/icon-unlocked_leg.gif"> - %%notlock%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="onactive" value="<nobr><img title="%%onactive%%" helpId="onactive" class=icon_leg src="skins/vanilla/icons/icon-ok_leg.gif"> - %%onactive%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="notactive" value="<nobr><img title="%%notactive%%" helpId="notactive" class=icon_leg src="skins/vanilla/icons/icon-close_leg.gif"> - %%notactive%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="spec_onactive" value="<nobr><img title="%%spec_onactive%%" helpId="spec_onactive" class=icon_leg src="skins/vanilla/icons/icon-spec_ok_leg.gif"> - %%spec_onactive%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="spec_notactive" value="<nobr><img title="%%spec_notactive%%" helpId="spec_notactive" class=icon_leg src="skins/vanilla/icons/icon-spec_close_leg.gif"> - %%spec_notactive%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="spec2_onactive" value="<nobr><img title="%%spec2_onactive%%" helpId="spec2_onactive" class=icon_leg src="skins/vanilla/icons/icon-spec2_ok_leg.gif"> - %%spec2_onactive%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="spec2_notactive" value="<nobr><img title="%%spec2_notactive%%" helpId="spec2_notactive" class=icon_leg src="skins/vanilla/icons/icon-spec2_close_leg.gif"> - %%spec2_notactive%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="ondeleted" value="<nobr><img title="%%onactive%%" helpId="onactive" class=icon_leg src="skins/vanilla/icons/icon-close_leg.gif"> - %%ondeleted%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="notdeleted" value="<nobr><img title="%%notdeleted%%" helpId="notdeleted" class=icon_leg src="skins/vanilla/icons/icon-ok_leg.gif"> - %%notdeleted%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="onarchive" value="<nobr><img title="%%onarchive%%" helpId="onarchive" class=icon_leg src="skins/vanilla/icons/icon-archived_leg.gif"> - %%onarchive%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="notarchive" value="<nobr><img title="%%notarchive%%" helpId="notarchive" class=icon_leg src="skins/vanilla/icons/icon-not_archived_leg.gif"> - %%notarchive%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="published"    value="<nobr><img title="%%published%%" helpId="published" class=leg_icon src="skins/vanilla/icons/icon-published_leg.gif" border="0"> - %%published%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="notpublished" value="<nobr><img title="%%notpublished%%" helpId="notpublished" class=leg_icon src="skins/vanilla/icons/icon-notpublished_leg.gif"> - %%notpublished%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="spec_published"    value="<nobr><img title="%%spec_published%%" helpId="spec_published" class=leg_icon src="skins/vanilla/icons/icon-spec_published_leg.gif" border="0"> - %%spec_published%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="spec_notpublished" value="<nobr><img title="%%spec_notpublished%%" helpId="spec_notpublished" class=leg_icon src="skins/vanilla/icons/icon-spec_notpublished_leg.gif"> - %%spec_notpublished%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="select"    value="<nobr><img title="%%icon_select%%" helpId="icon_select" class="leg_icon" src="skins/vanilla/icons/icon-ok_leg.gif" border="0" /> - %%icon_select%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="icon_link_popup" value="
 <a href="javascript:void(0);" onClick="javascript:openDialog('%%external_link%%', '##script_link##?action=external_link&id=##id##', 450, 200); return false;"><img title="%%icon_external_link%%" helpId="icon_external_link" class=icon src="skins/vanilla/icons/icon_external_link.gif"></a>
"-->

##-- ============================= Action Icons =================================== --##


<!--#set var="icons_view_edit_del" value="
 <a href="javascript:" onclick="javascript:user_click('view','##view_id##');return false;"><img title="%%icon_view%%" helpId="icon_view" class=icon src="skins/vanilla/icons/icon-view.gif"></a>
 <a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
 <a href="javascript:" onclick="javascript:user_click('del','##del_id##');return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icon_view_del" value="
<a href="javascript:" onclick="javascript: f=window.open('##view_link##', 'f', 'toolbar=no,scrollbars=no,menubar=no,directories=no,status=no,resizable=no,width=330,height=310'); retirn false;"><img title="%%icon_view%%" helpId="icon_view" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
<a href="javascript:" onclick="javascript:user_click('del','##del_id##');return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icons_payments"     value="
##--<a href="?flt_search_domain=##rev_domain##"><img title="%%icon_add_payment%%" helpId="icon_add_payment" class=icon src="skins/vanilla/icons/icon-add.gif"></a>--##
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
<a href="javascript:" onClick="if (confirm('%%delete_warn%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icons_payments_view"     value="
 <a href="javascript:" onclick="javascript:user_click('view','##view_id##');return false;"><img title="%%icon_view%%" helpId="icon_view" class=icon src="skins/vanilla/icons/icon-view.gif"></a>
"-->

<!--#set var="icon_print;print" value="
 <a href="javascript:" onclick="javascript:user_click_blank('print','##print_id##');return false;"><img title="%%icon_print%%" helpId="icon_print" class=icon src="skins/vanilla/icons/icon-print.gif"></a>
"-->
<!--#set var="icon_print_popup;print_popup" value="
 <a href="javascript:void(0);" onClick="javascript:openDialog('%%eshop_print_form%%', '##script_link##?action=print&id=##print_id##', 320, 180); return false;"><img title="%%icon_print%%" helpId="icon_print" class=icon src="skins/vanilla/icons/icon-print.gif"></a>
"-->

<!--#set var="view" value="
  <a href="javascript:" onclick="javascript:user_click('view','##view_id##');return false;"><img title="%%icon_view%%" helpId="icon_view" class=icon src="skins/vanilla/icons/icon-view.gif"></a>
"-->

<!--#set var="edit" value="
  <a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" helpId="icon_edit" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
"-->

<!--#set var="reply" value="
  <a href="javascript:" onclick="javascript:user_click('reply','##reply_id##');return false;"><img title="%%icon_reply%%" helpId="icon_reply" class=icon src="skins/vanilla/icons/icon-reply.gif"></a>
"-->

<!--#set var="icon_none" value="
  <img class=iconEmpty src="skins/vanilla/images/spacer.gif">
"-->

<!--#set var="icon_edit" value="
  <img class=iconEmpty src="skins/vanilla/images/spacer.gif">
"-->

<!--#set var="del" value="
  <a href="javascript:" onClick="if (confirm('%%delete_warn%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="del_cat" value="
  <a href="javascript:" onClick="if (confirm('%%delete_cat_warn%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" helpId="icon_del" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icon_del" value="
  <img class=iconEmpty src="skins/vanilla/images/spacer.gif">
"-->

<!--#set var="copy" value="
  <a href="javascript:" onclick="javascript:user_click('copy','##copy_id##');return false;"><img title="%%icon_copy%%" helpId="icon_copy" class=icon src="skins/vanilla/icons/icon-copy.gif"></a>
"-->

<!--#set var="icon_special_on"     value="<img title="%%icon_special_on%%" helpId="icon_special_on" class=icon src="skins/vanilla/icons/icon-special1.gif" border="0">"-->
<!--#set var="icon_special_off"    value="<img title="%%icon_special_off%%" helpId="icon_special_off" class=icon src="skins/vanilla/icons/icon-notspecial1.gif" border="0">"-->

<!--#set var="icon_reply" value="<a href="javascript:" onclick="javascript:user_click('reply','##reply_id##');return false;"><img title="%%icon_reply%%" helpId="icon_reply" class=icon src="skins/vanilla/icons/icon-reply.gif"></a>
"-->

<!--#set var="icon_file" value="<a href="ftpgetfile.php?module=files&id=##id_file##" target="_blank"><img title="%%icon_file%%" helpId="icon_file" class=icon src="skins/vanilla/icons/icon-clip.gif"></a>
"-->

<!--#set var="icon_file_off" value="<img title="%%icon_file_off%%" helpId="icon_file_off" class=icon src="skins/vanilla/icons/icon-clip-off.gif">"-->

<!--#set var="result"    value="<a href="javascript:" onclick="javascript:user_click('result','##edit_id##');return false;"><img title="%%icon_result%%" helpId="icon_result" class=icon src="skins/vanilla/icons/icon-result.gif"></a>"-->
<!--#set var="reset_num" value="<a href="javascript:" onClick="if (confirm('%%reset_warn%%')){user_click('reset','##edit_id##');}return false;"><img title="%%icon_reset_num%%" helpId="icon_reset_num" class=icon src="skins/vanilla/icons/icon-reset_num.gif"></a>"-->

<!--#set var="select_icon" value="
 <a href="javascript:" onclick="javascript:selectItemFromPopup(this.form, '##sel_id##');return false;"><img title="%%icon_select%%" helpId="icon_select" class=icon src="skins/vanilla/icons/icon-ok.gif"></a>
"-->

<!--#set var="button_add" value="
##if(caption)##
<script type="text/javascript">
    function onLinkAdd(){
        if(typeof(_cms_document_form_changed) != 'undefined' && _cms_document_form_changed && typeof(_cms_form_changed_alert) != 'undefined' && !confirm(_cms_form_changed_alert)){
            //...
        }else{
            var sform = document.forms[_cms_document_form];
            if(sform.action.value == 'apply'){
                var sUrl = get_user_click_link('none', '');
                document.location.href = sUrl + '#anchor';
            }else{
                document.location.hash = 'anchor';
            }
        }
        return false;
    }
</script>
<div class="icon_button_add">
    <a href="/" onClick="return onLinkAdd()">
        <span class="text_button">##caption##</span>
        <img class="icon" src="skins/vanilla/icons/icon-add.gif" align=absmiddle>
    </a>
</div>
##endif##
"-->

##-- ============================= Action Icons end =============================== --##