##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/feedback.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  <td width="60" class="td_small_text">##fdate##&nbsp;</td>
  <td class="td_small_text">##info##&nbsp;</td>
  <td width="160">##author##&nbsp;</td>
  <td width="160">##email##&nbsp;</td>
  <td align=center>##action_view####action_del##</td>
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
    <td class="first_row_all" width="60">
     %%date%%
     ##sort_date##
    </td>
    <td class="first_row_all list_name_col">
     %%info%%
     ##sort_info##
    </td>
    <td class="first_row_all" align="center" width="160">
     %%author%%
     ##sort_author##
    </td>
    <td class="first_row_all" align="center" width="160">
     %%email%%
     ##sort_email##
    </td>
    <td class="first_row_all" align="center" width="40">
     %%actions%%
    </td>
  </tr>
  ##list##
</table>
##_group_operations_footer##
</form>
<a name="anchor"></a>
"-->
