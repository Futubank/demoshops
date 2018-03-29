<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
##_group_operations_col##
##_positions_col##
    <td width="30" align=center>##public##</td>
##_picture_col##
    <td width="150"><nobr>##name##&nbsp;</nobr></td>
    <td>##description##&nbsp;</td>
    <td width="80">##bind_member##</td>
    <td width="40" align=center>##action_edit####action_del##</td>
</tr>
"-->

<!--#set var="list_body" value="
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
##_positions_data##
<form name="group_operations_form">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
##_group_operations_header##
##_positions_header##
    <td class="first_row_all" align="center" valign="middle" width="30">##sort_public##&nbsp;</td>
##_picture_header##
    <td class="first_row_all list_name_col">##sort_name## %%name%%</td>
    <td class="first_row_all">%%description%%</td>
    <td class="first_row_all" width="80">##sort_bind_member## %%sort_bind_member%%</td>
    <td class="first_row_all" align="center" width="100">%%actions%%</td>
</tr>
##list##
</table>
##_group_operations_footer##
</form>

<a name="anchor"></a>
"-->
