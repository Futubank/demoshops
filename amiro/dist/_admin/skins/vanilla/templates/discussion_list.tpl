%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/discussion.lng"%%

##--
<!--#set var="quote" value="<a href="javascript:" onclick="javascript:user_click('quote','##quote_id##');return false;"><img title="%%icon_quote%%" class="icon" src="skins/vanilla/icons/icon-view.gif" /></a>&nbsp;"-->
<!--#set var="leg_quote" value="<nobr><img title="%%icon_quote%%" class="leg_icon" src="skins/vanilla/icons/icon-view_leg.gif" align="absmiddle" helpId="legend" /> - %%leg_quote%%&nbsp;&nbsp;</nobr>"-->
--##

<!--#set var="reply" value="<a href="javascript:" onclick="javascript:user_click('reply','##reply_id##');return false;"><img title="%%icon_reply%%" class="icon" src="skins/vanilla/icons/icon-reply.gif" /></a>"-->

<!--#set var="post_message" value="<a href="javascript:" onclick="javascript:setFilterToDisplayThread(##id_ext_module##, '##ext_module##', 1);user_click('reply','##reply_id##');return false;"><img title="%%icon_post_message%%" class="icon" src="skins/vanilla/icons/icon-add_sub.gif" /></a>"-->
<!--#set var="leg_post_message" value="<nobr><img title="%%icon_post_message%%" class="leg_icon" src="skins/vanilla/icons/icon-add_sub_leg.gif" align="absmiddle" helpId="legend" /> - %%leg_post_message%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="action_del" value=" <a href="javascript:" onClick="if (confirm('%%delete_element_messages_warn%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="action_del_with_children" value=" <a href="javascript:" onClick="if (confirm('%%delete_with_cildren_warn%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icons_grp_del" value="<a href="javascript:grpAction('del');" onClick="return (grpCheckSelection() && confirm('##if(IN_THREAD)##%%grp_delete_warn%%##else##%%grp_delete_element_messages_warn%%##endif##'));"><img title="%%icon_grp_del%%" class=icon src="skins/vanilla/icons/icon-del.gif" align=absmiddle hspace=3></a>"-->

<!--#set var="path_splitter" value=" | "-->
<!--#set var="path_module" value="<a href="javascript:" onclick="resetThreadId(document.forms[_cms_document_form]);filterFullSubmit();return false;"><b>%%all_modules%%</b></a> | <a href="javascript:" onclick="resetThreadId(document.forms[_cms_document_form], '##module##');filterFullSubmit();return false;"><b>##caption##</b></a>"-->
<!--#set var="path_header" value="<b>##message##</b>##if(element_admin_link)## (<a href="##element_admin_link##?id=##id_ext_module##&action=edit#anchor">%%to_element%%</a>)##endif##"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
##_group_operations_col##
##if(IN_THREAD)##
  <td align="center">##public##</td>
##endif##
##if(DISPLAY_MODULE_COL)##
  <td class="td_small_text"><a href="javascript:" onclick="resetThreadId(document.forms[_cms_document_form], '##ext_module##');filterFullSubmit();return false;">##ext_module_caption##&nbsp;&raquo;</a></td>
##endif##
##if(IN_THREAD)##
  <td class="td_small_text">##message##&nbsp;</td>
  <td class="td_small_text"><nobr>##if(id_member)##<a href="##members_link##?id=##id_member##&action=edit#anchor" target="_blank">##author##&nbsp;&raquo;</a>##else####author####endif##<nobr></td>
##else##
  <td class="td_small_text"><a href="javascript:" onClick="return displayThread(##id_ext_module##, '##ext_module##')" title="%%display_topic_messages%%">##message##&nbsp;&raquo;</a>&nbsp;</td>
  <td class="td_small_text">##if(msg_id)##<a href="##forum_link##?id=##msg_id##&action=reply&ext_module=##ext_module##&id_ext_module=##id_ext_module##" title="%%to_message%%"><span id="d##id##">##fmsg_date##</span><script>replaceDateTitle('d##id##')</script>&nbsp;&raquo;</a><br />%%from%% ##if(msg_id_member)##<a href="##members_link##?id=##msg_id_member##&action=edit#anchor">##msg_author##&nbsp;&raquo;</a>##else####msg_author####endif##</td><td class="td_small_text">##last_message####else##&nbsp;</td><td>&nbsp;##endif##</td>
  <td align="right" class="td_small_text"><a href="javascript:" onClick="return displayThread(##id_ext_module##, '##ext_module##')" title="%%display_topic_messages%%">##count_public_children##&nbsp;&raquo;</a>&nbsp;</td>
##endif##
##if(IN_THREAD)##
  <td nowrap width="130" class="td_small_text"><span id="fd##id##">##fdate##</span><script>replaceDateTitle('fd##id##')</script>&nbsp;</td>
##endif##
  <td align="center">##if(IN_THREAD)####--action_quote--####action_reply####action_edit####else####action_post_message####endif####action_del##&nbsp;</td>
</tr>
"-->

<!--#set var="empty" value="
<script>

function setFilterToDisplayThread(threadId, module, resetParent)
{
    document.forms[_cms_document_form].id_ext_module.value = threadId;
    document.forms[_cms_document_form].enc_id_ext_module.value = threadId;
    document.forms[_cms_document_form].ext_module.value = module;
    document.forms[_cms_document_form].enc_ext_module.value = module;
    document.forms[_cms_filter_form].ext_module.value = module;
    if (resetParent != undefined) {
        document.forms[_cms_document_form].flt_reset_parent.value = 1;
        document.forms[_cms_document_form].enc_flt_reset_parent.value = 1;
    }
}

function filterFullSubmit()
{
    fireEvent2(document.forms[_cms_filter_form], 'submit');
    document.forms[_cms_filter_form].submit();
    return false;
}

function displayThread(threadId, module)
{
    setFilterToDisplayThread(threadId, module);
    return filterFullSubmit();
}

function resetThreadId(itemForm, value)
{
    if (itemForm.id_ext_module) {
        setFilterToDisplayThread(0, value ? value : '');
    }
}

function filterOnSubmit(filterForm, itemForm)
{
    if (filterForm.ext_module && filterForm.ext_module.value != itemForm.ext_module.value) {
        resetThreadId(itemForm, filterForm.ext_module.value);
    }
}
</script>

##if(!POPUP_MODE)##
<div class="cat-path">##path##</div>
<div class="empty-list">%%empty%%</div>
##endif##
"-->

<!--#set var="list_body" value="
<script type="text/javascript">
##IF(POPUP_MODE)##
if(AMI.find('#status-msgs') && AMI.find('#status-msgs').innerHTML.length){
    top.amiReloadList = true;
}
##ENDIF##
function setFilterToDisplayThread(threadId, module, resetParent)
{
    document.forms[_cms_document_form].id_ext_module.value = threadId;
    document.forms[_cms_document_form].enc_id_ext_module.value = threadId;
    document.forms[_cms_document_form].ext_module.value = module;
    document.forms[_cms_document_form].enc_ext_module.value = module;
    document.forms[_cms_filter_form].ext_module.value = module;
    if (resetParent != undefined) {
        document.forms[_cms_document_form].flt_reset_parent.value = 1;
        document.forms[_cms_document_form].enc_flt_reset_parent.value = 1;
    }
}

function filterFullSubmit()
{
    fireEvent2(document.forms[_cms_filter_form], 'submit');
    document.forms[_cms_filter_form].submit();
    return false;
}

function displayThread(threadId, module)
{
    setFilterToDisplayThread(threadId, module);
    return filterFullSubmit();
}

function resetThreadId(itemForm, value)
{
    if (itemForm.id_ext_module) {
        setFilterToDisplayThread(0, value ? value : '');
    }
}

function filterOnSubmit(filterForm, itemForm)
{
    if (filterForm.ext_module && filterForm.ext_module.value != itemForm.ext_module.value) {
        resetThreadId(itemForm, filterForm.ext_module.value);
    }
}
</script>

<br />
##if(!POPUP_MODE)##
<!--path {{{-->
<div class="cat-path">##path##</div>
<!--}}} path-->
##endif##

<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
##_positions_data##
<form name="group_operations_form">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
##_group_operations_header##
##if(IN_THREAD)##
    <td class="first_row_left_td" align="center" valign="middle" width="30">##sort_public##</td>
##endif##
##if(DISPLAY_MODULE_COL)##
    <td class="first_row_all">%%module%%</td>
##endif##
##if(IN_THREAD)##
    <td class="first_row_all list_name_col">%%message%%</td>
    <td class="first_row_all">%%author%% ##sort_author##</td>
##else##
    <td class="first_row_all list_name_col">%%header%%</td>
    <td colspan="2" class="first_row_all">%%last_message%%</td>
    <td class="first_row_all" width="30">%%messages%% ##sort_count_public_children##</td>
##endif##
##if(IN_THREAD)##
    <td class="first_row_all"##-- width="130"--##>%%date%% ##sort_date##
    </td>
##endif##
    <td class="first_row_all" align="center" width="100">%%actions%%</td>
  </tr>
  ##list##
</table>
##_group_operations_footer##
</form>

<a name="anchor"></a>
"-->

<!--#set var="admin_nickname" value="%%administration%% (##author##)"-->