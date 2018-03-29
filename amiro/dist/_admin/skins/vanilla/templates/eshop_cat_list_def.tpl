<!--#set var="path_root_item" value="
<b><a href="javascript:void();" onClick="return changePath(0);" title="%%root_cat%%">%%root_cat%%</a></b>
"-->

<!--#set var="path_item_link" value="
| <b><a href="javascript:void();" onClick="return changePath(##id##);" title="##alt##">##title##</a></b>
"-->

<!--#set var="path_item_current" value="
| <b><span title="##alt##">##title##</span></b>
"-->

<!--#set var="path_skip_item" value="
| <b>##title##</b>
"-->


<!--#set var="empty" value="
<div class="cat-path">##path##</div>
<div class="empty-list">%%empty%%</div>
"-->

<!--#set var="counter_product_header" value="
<td class="first_row_all" width="50">
 %%counter_product%%
</td>
"-->

<!--#set var="counter_product_row" value="
  <td width="50" align=right>##all_count##/##public_count##</td>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_positions_col##
  <td width="30" align=center>##cat_public##</td>
  ##_picture_col##
##if(PARENT_COL=="1")##
  <td width="150" class="td_small_text">##parentname##&nbsp;</td>
##endif##
  <td width="240"><a href="" onClick="return changeCategory(##id##);">##name##&nbsp;&raquo;</a></td>
  <td width="120" class="td_small_text">##dataset_name##&nbsp;</td>
  <td class="td_small_text">##announce##&nbsp;</td>
##if(INSTRUCTIONS_ON=="1")##
  <td width="30" align="center class="td_small_text"">##instruct##&nbsp;</td>
##endif##
  ##counter_product_row##
##if(SHOW_ADV_PLACE_COLUMNS == 1)##
<td width=140>##adv_place##&nbsp;</td>
##endif##
##if(SHOW_ADV_STAT_COLUMNS == 1)##
<td width=115 align=righ class="td_small_text">##shown_items##/##shown_details##/##shown_ctr##</td>
##endif##
  <td align=center><nobr>##actions##</nobr></td>
</tr>
"-->


<!--#set var="list_body" value="
##_positions_data##

            <div class="cat-path">##path##</div>
            <div style="text-align:right;" style="margin-top: 15px;" >##pager##</div>
##--
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><nobr>##path##</nobr>&nbsp;</td>
              <td align="right">##pager##</td>
            </tr>
            </table>
--##

            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_positions_header##
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_cat_public##
                </td>
                ##_picture_header##
##if(PARENT_COL=="1")##
                <td class="first_row_all" valign="middle" width="150">
                 %%parentname%%
                  ##sort_parentname##
                </td>
##endif##
                <td class="first_row_all list_name_col" width="240">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all" width="120">
                 %%dataset%%
                 ##sort_dataset##
                </td>
                <td class="first_row_all">
                 %%announce%%
                  ##sort_announce##
                </td>
##if(INSTRUCTIONS_ON=="1")##
                <td class="first_row_all" width="30">
                ##sort_instruct##
                </td>
##endif##
                ##counter_product_header##

##if(SHOW_ADV_PLACE_COLUMNS == 1)##
<td class="first_row_all" width=140>%%col_adv_place%%</td>
##endif##
##if(SHOW_ADV_STAT_COLUMNS == 1)##
<td class="first_row_all" width=115>%%col_adv_stats%%</td>
##endif##

                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
              </table>
              <a name="anchor"></a>
"-->