%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/forum.lng"%%

<!--#set var="path_splitter" value=" |"-->
<!--#set var="path_category" value="&nbsp;<a href="javascript:" onclick="resetThreadId(document.forms[_cms_document_form]); document.forms[_cms_filter_form].flt_section_id.value = ##id##; return filterFullSubmit();"><b>##caption##</b></a>"-->
<!--#set var="path_topic" value="&nbsp;<b>##caption##</b>"-->

<!--#set var="category_list_col" value="<td class="td_small_text"><a href="javascript:" onclick="resetThreadId(document.forms[_cms_document_form]); document.forms[_cms_filter_form].flt_section_id.value = ##id_cat##; return filterFullSubmit();" title="%%to_section%%">##category_name##&nbsp;&raquo;</a>&nbsp;</td>"-->

<!--#set var="action_del" value="<a href="javascript:" onClick="if (confirm('%%delete_topic_warn%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="icons_grp_del" value="<a href="javascript:grpAction('del');" onClick="return (grpCheckSelection() && checkTopicsOnGrpDel());"><img title="%%icon_grp_del%%" class=icon src="skins/vanilla/icons/icon-del.gif" align=absmiddle hspace=3></a>"-->

<!--#set var="reply" value="<a href="##forum_link##?id=##msg_id##&action=reply&flt_id_thread=##id_thread##&flt_topics_only=0##flt_module_body_only##&flt_go_last_page=1#anchor"><img title="%%icon_reply%%" class=icon src="skins/vanilla/icons/icon-reply.gif"></a>"-->

<!--#set var="icons_grp_lock_on" value="<a href="javascript:grpAction('lock_on');" onClick="return (grpCheckSelection() && confirm('%%grp_lock_on_warn%%'));"><img title="%%icon_grp_lock_on%%" class=icon src="skins/vanilla/icons/icon-locked.gif" border="0" helpId="btn_grp_lock_on" align="absmiddle" hspace="3" /></a>"-->

<!--#set var="icons_grp_lock_off" value="<a href="javascript:grpAction('lock_off');" onClick="return (grpCheckSelection() && confirm('%%grp_lock_off_warn%%'));"><img title="%%icon_grp_lock_off%%" class=icon src="skins/vanilla/icons/icon-unlocked.gif" border="0" helpId="btn_grp_lock_off" align="absmiddle" hspace="3" /></a>"-->

<!--#set var="leg_bold_in_topic_list" value="<nobr><b>%%leg_bold_item%%</b> - %%leg_bold_in_topic_list%%&nbsp;&nbsp;</nobr>"-->


<!--#set var="empty" value="
<script>

function setFilterToDisplayThread(threadId)
{
    document.forms[_cms_document_form].flt_topics_only.value = threadId ? 0 : 1;
    document.forms[_cms_document_form].enc_flt_topics_only.value = threadId ? 0 : 1;
    document.forms[_cms_document_form].flt_id_thread.value = threadId;
    document.forms[_cms_document_form].enc_flt_id_thread.value = threadId;
}

function filterFullSubmit()
{
    fireEvent2(document.forms[_cms_filter_form], 'submit');
    document.forms[_cms_filter_form].submit();
    return false;
}

function displayThread(threadId)
{
    _filter_anchor = '#anchor';
    setFilterToDisplayThread(threadId);
    return filterFullSubmit();
}

function resetThreadId(itemForm)
{
    if (itemForm.flt_id_thread) {
        setFilterToDisplayThread(0);
    }
}

function filterOnSubmit(filterForm, itemForm)
{
    if (filterForm.flt_section_id && (filterForm.flt_section_id.value != itemForm.flt_section_id.value)) {
        resetThreadId(itemForm);
    }
}

function filterOnReset(filterForm, itemForm)
{
##-- alert('filterOnReset');//// --##
    if (filterForm.flt_section_id) {
        resetThreadId(itemForm);
    }
}

</script>

<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr><td>##path##</td></tr>
<tr><td class="row1" align="center"><h3>%%empty%%</h3></td></tr>
</table>
"-->

<!--#set var="answers" value="<td align="right">##if(is_topic)##<a href="javascript:" onClick="return displayThread(##id_thread##)" title="%%display_topic_messages%%">##msg_answers##&nbsp;&raquo;</a>##endif##&nbsp;</td>"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
##_group_operations_col##
##_positions_col##
##if(!NOT_THREAD)##
  <td align="center">##public##</td>
##endif##
##--
  <td align="center">##locked##</td>
--##
##if(DISPLAY_CATEGORIES)##
##category_col##
##endif##
##if(NOT_THREAD)##
  <td class="td_small_text">##--if(is_topic)--##<a href="javascript:" onClick="return displayThread(##id_thread##)" title="%%display_topic_messages%%">##topic##&nbsp;&raquo;</a>##--else####topic####endif--##&nbsp;</td>
##endif##
##if(DISPLAY_MESSAGES)##
<td class="td_small_text">##message##&nbsp;</td>
##endif##
  <td><nobr>##if(id_member)##<a href="##members_link##?id=##id_member##&action=edit##flt_module_body_only###anchor" target="_blank">##author##&nbsp;&raquo;</a>##else####author####if(!NOT_THREAD)## %%guest%%##endif####endif##<nobr></td>
##if(NOT_THREAD)##
  <td class="td_small_text">##if(msg_id)##<a href="##forum_link##?id=##msg_id##&action=reply&flt_id_thread=##id_thread##&flt_topics_only=0##flt_module_body_only##&flt_go_last_page=1#anchor" title="%%to_message%%"><span id="d##id##">##msg_date##</span><script>replaceDateTitle('d##id##')</script>&nbsp;&raquo;</a><br /><a href="##forum_link##?flt_id_thread=##id_thread####flt_module_body_only##&flt_topics_only=0" title="%%to_topic%%">##msg_topic##&nbsp;&raquo;</a><br />%%from%% ##if(msg_id_member)##<a href="##members_link##?id=##msg_id_member##&action=edit##flt_module_body_only###anchor">##msg_author##&nbsp;&raquo;</a>##else####msg_author####endif####else##&nbsp;##endif##</td>
##endif##
##answers##
##if(EXTENSION_RATING=="1")##
  <td align="center">##votes_count##</td>
  <td align="center">##votes_rate##</td>
##endif##
  <td nowrap class="td_small_text"><span id="fd##id##">##fdate##</span><script>replaceDateTitle('fd##id##')</script>&nbsp;</td>
  <td align="center">##if(is_topic)##<div id="isT##id##"></div>##endif####action_reply####action_edit####action_del##&nbsp;</td>
</tr>
"-->

<!--#set var="list_body" value="
<script type="text/javascript">
function checkTopicsOnGrpDel()
{
    var selectedFields = document.forms[_cms_document_form].elements[_groupFieldName].value;
    var fields = selectedFields.substring(1, selectedFields.length - 1).split(';');
    var topicsQty = 0;
    for (var i = 0, l = fields.length ; i < l ; i++) {
        if (document.getElementById('isT' + fields[i])) {
            topicsQty++;
        }
    }
    if (topicsQty > 0) {
        return confirm(topicsQty == 1 ? '%%delete_topic_warn%%' : '%%grp_delete_topics_warn%%');
    }
    return confirm('%%grp_delete_warn%%');
}

function setFilterToDisplayThread(threadId)
{
    document.forms[_cms_document_form].flt_topics_only.value = threadId ? 0 : 1;
    document.forms[_cms_document_form].enc_flt_topics_only.value = threadId ? 0 : 1;
    document.forms[_cms_document_form].flt_id_thread.value = threadId;
    document.forms[_cms_document_form].enc_flt_id_thread.value = threadId;
    document.forms[_cms_document_form].flt_go_last_page.value = 1;
    document.forms[_cms_document_form].enc_flt_go_last_page.value = 1;
}

function filterFullSubmit()
{
    fireEvent2(document.forms[_cms_filter_form], 'submit');
    document.forms[_cms_filter_form].submit();
    return false;
}

function displayThread(threadId)
{
    _filter_anchor = '#anchor';
    setFilterToDisplayThread(threadId);
    return filterFullSubmit();
}

function resetThreadId(itemForm)
{
    if (itemForm.flt_id_thread) {
        setFilterToDisplayThread(0);
    }
}

function filterOnSubmit(filterForm, itemForm)
{
    if (filterForm.flt_section_id && (filterForm.flt_section_id.value != itemForm.flt_section_id.value)) {
        resetThreadId(itemForm);
    }
}

function filterOnReset(filterForm, itemForm)
{
    if (filterForm.flt_section_id) {
        resetThreadId(itemForm);
    }
}

</script>

<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td>##path##</td></tr>
</table>

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
##_positions_data##
<form name="group_operations_form">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
##_group_operations_header##
##_positions_header##
##if(!NOT_THREAD)##
    <td class="first_row_left_td" align="center" valign="middle" width="30">##sort_public##</td>
##endif##
##--
    <td class="first_row_all" align="center" valign="middle" width="30">##sort_locked##</td>
--##
##if(DISPLAY_CATEGORIES)##
##category_list_header##
##endif##
##if(NOT_THREAD)##
    <td class="first_row_all list_name_col">
     %%topic%%
     ##sort_topic##
    </td>
##endif##
##if(DISPLAY_MESSAGES)##
    <td class="first_row_all">
     %%message%%
    </td>
##endif##
    <td class="first_row_all">
     %%author%%
      ##sort_author##
    </td>
##if(NOT_THREAD)##
    <td class="first_row_all">%%last_message%% ##sort_msg_date##</td>
##endif##
##if(display_answers)##
    <td class="first_row_all" width="30">
     %%answers%%
    ##sort_msg_answers##
    </td>
##endif##
##if(EXTENSION_RATING=="1")##
    <td class="first_row_all" width="30">
    %%votes_count%%
    ##sort_votes_count##
    </td>
    <td class="first_row_all" width="30">
    %%votes_rate%%
    ##sort_votes_rate##
    </td>
##endif##
    <td class="first_row_all"##-- width="130"--##>
     %%date%%
     ##sort_date##
    </td>
    <td class="first_row_all" align="center" width="100">
     %%actions%%
    </td>
  </tr>
  ##list##
</table>
##_group_operations_footer##
</form>
<a name="anchor"></a>
"-->

<!--#set var="admin_nickname" value="%%administration%% (##author##)"-->