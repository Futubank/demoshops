<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
    <td class="row1" align="center"><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
    ##_group_operations_col##
    ##_positions_col##
    <td>##name##&nbsp;</td>
    <td align="right">##methods_count##&nbsp;</td>
    <td align="center" nowrap="nowrap">
        ##action_edit##
        ##action_del##
    </td>
</tr>
"-->

<!--#set var="list_body" value="
<div width="100%" align="right" style="margin-top: 15px;" >##pager##</div>
    ##_group_operations_script##
    ##_positions_data##
    <form name="group_operations_form">
    <table width="100%" align="center" border="0" cellspacing="0" cellpadding="4">
    <tr>
        ##_group_operations_header##
        ##_positions_header##
        <td class="first_row_left_td">
            %%sort_name%%
            ##sort_name##
        </td>
        <td class="first_row_all" width="70" align="right">
            %%sort_methods_count%%
            ##sort_methods_count##
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