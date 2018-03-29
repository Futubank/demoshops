%%include_language "templates/lang/_categories.lng"%%
##--include_template "templates/_icons.tpl"--##

<!--#set var="empty" value="
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td align="right">
      ##--cat_list--##
    </td>
  </tr>
  <tr>
    <td class=row1 align=center><h3>%%empty%%</h3></td>
  </tr>
  </table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  ##_positions_col##
  <td width="30" align=center>##public##</td>
  ##_picture_col##
  <td width="150"><nobr>##name##</nobr></td>
  <td class="td_small_text">##announce##&nbsp;</td>
##list_custom_fields##
##if(NUM_ITEMS_COL=="1")##
  <td width="80" align=right>##num_items##/##num_public_items##&nbsp;</td>
##endif##

  ##if(EXTENSION_AUDIT=="1")##
    <td align="center">
      <b>##audit_status##</b><br>
      ##audit_role##<br>
      ##audit_username##
    </td>
##endif##

##if(EXTENSION_RATING=="1")##
    <td align="center">
      ##votes_count##
  </td>
    <td align="center">
      ##votes_rate##
  </td>
##endif##
##_id_page_row_col##
##if(SHOW_ADV_PLACE_COLUMNS == 1)##
<td width=140>##adv_place##&nbsp;</td>
##endif##
##if(SHOW_ADV_STAT_COLUMNS == 1)##
<td width=115 align=right>##shown_items##/##shown_details##/##shown_ctr##</td>
##endif##
  <td width="100" align=center>##action_edit####action_del##</td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            ##_group_operations_script##
            ##_positions_data##
            <form name="group_operations_form">
             <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                ##_group_operations_header##
                ##_positions_header##
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_public##
                </td>
                ##_picture_header##
                <td class="first_row_all list_name_col">
                 %%name%%
                  ##sort_name##
                </td>
                <td class="first_row_all">
                 %%announce%%
                  ##sort_announce##
                </td>
##list_custom_fields##
##if(NUM_ITEMS_COL=="1")##
                <td class="first_row_all" width=100>
                 %%counter_items%%
                </td>
##endif##

##if(EXTENSION_AUDIT=="1")##
                <td class="first_row_all">
                %%audit_status%%
                </td>
##endif##

##if(EXTENSION_RATING=="1")##
                <td class="first_row_all">
                %%votes_count%%
                ##sort_votes_count##
                </td>
                <td class="first_row_all">
                %%votes_rate%%
                ##sort_votes_rate##
                </td>
##endif##
##_id_page_header##
##if(SHOW_ADV_PLACE_COLUMNS == 1)##
<td class="first_row_all">%%col_adv_place%%</td>
##endif##
##if(SHOW_ADV_STAT_COLUMNS == 1)##
<td class="first_row_all">%%col_adv_stats%%</td>
##endif##
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