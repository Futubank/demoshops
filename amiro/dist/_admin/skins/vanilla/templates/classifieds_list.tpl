%%include_language "templates/lang/classifieds.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr><td class=row1 align=center><h3>%%empty%%</h3></td></tr>
</table>
"-->

<!--#set var="views_col" value="<td align="center">##views_count##</td>"-->

<!--#set var="views_header" value="<td class="first_row_all" width="30">%%views_count%%</td>"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
    ##_group_operations_col##
    ##_positions_col##
    <td width="30" align="center">##public##</td>
    ##_picture_col##
    <td width="60"><span id="ds##id##">##fdate_start##</span><script>replaceDateTitle('ds##id##')</script>&nbsp;</td>
    <td width="60"><span id="dc##id##">##fdate_end##</span><script>replaceDateTitle('dc##id##')</script>&nbsp;</td>
    ##category_col##
    <td>##header##&nbsp;</td>
    <td class="td_small_text">##announce##&nbsp;</td>
##if(SHOW_ADV_PLACE_COLUMNS == 1)##
    <td width=140>##adv_place##&nbsp;</td>
##endif##
##if(SHOW_ADV_STAT_COLUMNS == 1)##
    <td width=115 align=right>##shown_items##/##shown_details##/##shown_ctr##</td>
##endif##
    <td align="center">##--actions--####action_edit####action_view####action_del##</td>
</tr>
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
    ##_positions_header##
    <td class="first_row_all" align="center" valign="middle" width="30">##sort_public##</td>
    ##_picture_header##
    <td class="first_row_all"  width="60">%%date_start%% ##sort_date_start##</td>
    <td class="first_row_all"  width="60">%%date_end%% ##sort_date_end##</td>
    ##category_list_header##
    <td class="first_row_all list_name_col">%%header%% ##sort_header##</td>
    <td class="first_row_all">%%announce%% ##sort_announce##</td>
##if(SHOW_ADV_PLACE_COLUMNS == 1)##
    <td class="first_row_all" width=140>%%col_adv_place%%</td>
##endif##
##if(SHOW_ADV_STAT_COLUMNS == 1)##
    <td class="first_row_all" width=115>%%col_adv_stats%%</td>
##endif##
    <td class="first_row_all" align="center" width="100">%%actions%%</td>
</tr>
##list##
</table>
##_group_operations_footer##
</form>

<a name="anchor"></a>
"-->