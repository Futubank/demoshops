<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
    <td class="row1" align="center"><h3>%%empty%%</h3></td>
</tr>
</table>
<center style="padding-top:10px"><button class="but-mid" onClick="javascript:if(!categoriesIds.length){alert('%%warn_no_categories_on_gemerate%%');}else{openDialog('%%coupons_creation%%', '##CURRENT_OWNER##_coupons.php?action=generate', 500, 340);}return false">%%generate_btn%%</button></center>
"-->

<!--#set var="icons_grp_generate_coupons" value="<b>&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;</b><button onClick="javascript:if(!categoriesIds.length){alert('%%warn_no_categories_on_gemerate%%');}else{openDialog('%%coupons_creation%%', '##CURRENT_OWNER##_coupons.php?action=generate', 500, 340);}return false" class="but-mid">%%generate_btn%%</button>"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
    ##_group_operations_col##
    <td nowrap>##coupon##</td>
##category_col##
    <td width="60">##username##&nbsp;</td>
    <td width="60">##discount##&nbsp;</td>
##if(TIME_LIMITED)##
    <td>##fdate_start##</td>
    <td>##fdate_end##</td>
##endif##
    <td align="right" width="100">##activations_left##</td>
    <td align="right" width="80">##activation_count##</td>
    <td align="center" nowrap="nowrap">##action_edit## ##action_del##</td>
</tr>
"-->

<!--#set var="list_body" value="
<div width="100%" align="right" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
<form name="group_operations_form">
<table width="100%" align="center" border="0" cellspacing="0" cellpadding="4">
<tr>
##_group_operations_header##
    <td class="first_row_all">%%coupon%%</td>
##category_list_header##
    <td class="first_row_all" width="60">%%username%%</td>
    <td class="first_row_all" width="60">%%discount%%</td>
##if(TIME_LIMITED)##
    <td class="first_row_all" width="80">
        %%sort_date_start%%
        ##sort_date_start##
    </td>
    <td class="first_row_all" width="80">
        %%sort_date_end%%
        ##sort_date_end##
    </td>
##endif##
    <td class="first_row_all" width="100">
        %%sort_activations_left%%
        ##sort_activations_left##
    </td>
    <td class="first_row_all" width="80">
        %%sort_activation_count%%
        ##sort_activation_count##
    </td>
    <td class="first_row_all" align="center" width="100">%%actions%%</td>
</tr>
##list##
</table>
##_group_operations_footer##
</form>


<a name="anchor"></a>
"-->