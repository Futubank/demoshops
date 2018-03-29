##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/locales.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr><td class="row1" align="center"><h3>%%empty%%</h3></td></tr>
</table>
"-->

<!--#set var="is_installed_on" value="<img title="%%icon_installed_on%%" class="icon" src="skins/vanilla/icons/icon-installed.gif" border="0" />"-->
<!--#set var="is_installed_off" value="<img title="%%icon_installed_off%%" class="icon" src="skins/vanilla/icons/icon-notinstalled.gif" border="0" />"-->

<!--#set var="del" value="<a href="javascript:" onclick="if (confirm('%%warn_data_deletion%%')){user_click('del', '##del_id##');}return false;"><img title="%%icon_del%%" class="icon" src="skins/vanilla/icons/icon-del.gif" /></a>"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
    ##_group_operations_col##
    <td width="30" align="center">##installed##</td>
    <td width="60">##lang##&nbsp;</td>
    <td>##name##&nbsp;</td>
    <td>##default_title##&nbsp;</td>
    <td align="center">##action_edit####action_del##</td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
<form name="group_operations_form">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
    ##_group_operations_header##
    <td class="first_row_all" align="center" valign="middle" width="30">##sort_installed##</td>
    <td class="first_row_all" width="60">%%lang%% ##sort_lang##</td>
    <td class="first_row_all">%%locale%% ##sort_name##</td>
    <td class="first_row_all">%%default_title%% ##sort_default_title##</td>
    <td class="first_row_all" align="center" width="100">%%actions%%</td>
</tr>
##list##
</table>
##_group_operations_footer##
</form>

<a name="anchor"></a>
"-->