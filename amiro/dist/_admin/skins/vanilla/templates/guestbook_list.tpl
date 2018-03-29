%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/guestbook.lng"%%

##--
<!--#set var="quote" value="<a href="javascript:" onclick="javascript:user_click('quote','##quote_id##');return false;"><img title="%%icon_quote%%" class="icon" src="skins/vanilla/icons/icon-view.gif" /></a>&nbsp;"-->
<!--#set var="leg_quote" value="<nobr><img title="%%icon_quote%%" class="leg_icon" src="skins/vanilla/icons/icon-view_leg.gif" align="absmiddle" helpId="legend" /> - %%leg_quote%%&nbsp;&nbsp;</nobr>"-->
--##

<!--#set var="reply" value="<a href="javascript:" onclick="javascript:user_click('reply','##reply_id##');return false;"><img title="%%icon_reply%%" class="icon" src="skins/vanilla/icons/icon-reply.gif" /></a>"-->

<!--#set var="action_del_with_children" value=" <a href="javascript:" onClick="if (confirm('%%delete_with_cildren_warn%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
##_group_operations_col##
  <td align="center">##public##</td>
  <td>##subject##&nbsp;</td>
  <td class="td_small_text">##message##&nbsp;</td>
  <td><nobr>##if(id_member)##<a href="##members_link##?id=##id_member##&action=edit#anchor" target="_blank">##author## &raquo;</a>##else####author####endif##<nobr></td>
  <td class="td_small_text"><span id="d##id##">##fdate##</span><script>replaceDateTitle('d##id##')</script>&nbsp;</td>
  <td align="center">##--action_quote--####action_reply####action_edit####action_del##&nbsp;</td>
</tr>
"-->

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr><td class="row1" align="center"><h3>%%empty%%</h3></td></tr>
</table>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
##_positions_data##
<form name="group_operations_form">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
##_group_operations_header##
    <td class="first_row_left_td" align="center" valign="middle" width="30">##sort_public##</td>
    <td class="first_row_all list_name_col">%%subject%% ##sort_subject##</td>
    <td class="first_row_all">%%message%%</td>
    <td class="first_row_all">%%author%% ##sort_author##</td>
    <td class="first_row_all" width="130">##sort_date## %%date%%</td>
    <td class="first_row_all" align="center" width="100">%%actions%%</td>
</tr>
##list##
</table>
##_group_operations_footer##
</form>
<a name="anchor"></a>
"-->

<!--#set var="admin_nickname" value="%%administration%% (##author##)"-->