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
    <td align="right">##amount##&nbsp;</td>
    <td class="td_small_text">##delivery_time##&nbsp;</td>
    <td>##custom_conditions##&nbsp;</td>
    <td class="td_small_text">##custom_fields##&nbsp;</td>
    ##-- <td align="right">##regions_count##&nbsp;</td> --##
    <td align="center" nowrap="nowrap">
        ##action_edit##
        ##action_copy##
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
        <td class="first_row_all" width="70">
            %%sort_amount%%
            ##sort_amount##
        </td>
        <td class="first_row_all">
            %%sort_delivery_time%%
            ##sort_delivery_time##
        </td>
        <td class="first_row_all" width="70">
            %%sort_custom_conditions%%
            ##sort_custom_conditions##
        </td>
        <td class="first_row_all">
            %%fieldsets%%
        </td>
        ##-- <td class="first_row_all" width="70" align="right">
            %%sort_regions_count%%
            ##sort_regions_count##
        </td> --##
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