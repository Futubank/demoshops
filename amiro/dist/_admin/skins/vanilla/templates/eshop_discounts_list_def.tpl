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
    <td width="30" align="center">##public##</td>
    <td>##name##&nbsp;</td>
    <td width="60">%%##kind##%%&nbsp;</td>
    <td width="120" class="td_small_text">%%##condition##%%&nbsp;</td>
    <td width="60" class="td_small_text">##fdate_start##&nbsp;</td>
    <td width="60" class="td_small_text">##fdate_end##&nbsp;</td>
    <td align="right">##amount####type##&nbsp;</td>
    <td align="right">##categories_count##&nbsp;</td>
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
    <form name="group_operations_form">
    <table width="100%" align="center" border="0" cellspacing="0" cellpadding="4">
    <tr>
        ##_group_operations_header##
        <td class="first_row_left_td" align="center" valign="middle" width="30">
            ##sort_public##
        </td>
        <td class="first_row_all">
            %%sort_name%%
            ##sort_name##
        </td>
        <td class="first_row_all" width="80">
            %%sort_kind%%
            ##sort_kind##
        </td>
        <td class="first_row_all" width="70">
            %%sort_condition%%
            ##sort_condition##
        </td>
        <td class="first_row_all" width="80">
            %%sort_date_start%%
            ##sort_date_start##
        </td>
        <td class="first_row_all" width="80">
            %%sort_date_end%%
            ##sort_date_end##
        </td>
        <td class="first_row_all" width="60">
            %%sort_amount%%
            ##sort_amount##
        </td>
        <td class="first_row_all" width="70" title="%%sort_categories_count_help%%">
            %%sort_categories_count%%
            ##sort_categories_count##
        </td>
        <td class="first_row_all" align="center">
            %%actions%%
        </td>
    </tr>
    ##list##
    </table>
##_group_operations_footer##
</form>


<a name="anchor"></a>
"-->