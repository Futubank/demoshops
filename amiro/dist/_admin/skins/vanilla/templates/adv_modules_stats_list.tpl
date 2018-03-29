%%include_language "templates/lang/adv_modules_stats.lng"%%
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
  ##if(DONTSHOW_COL_PLACES != 1)##
  <td>##place_name##&nbsp;</td>
  ##endif##
  ##if(DONTSHOW_COL_MODS != 1)##
  <td>##module_name##&nbsp;</td>
  ##endif##
  ##if(DONTSHOW_COL_ITEMS != 1)##
  <td>##item_name##&nbsp;</td>
  ##endif##
  <td align=center>##day####if(HAS_FLD_WEEK)## / ##week####endif##</td>
  ##if(DONTSHOW_COL_HOUR != 1)##
  <td align=center>##hour##</td>
  ##endif##
  <td align=right>##views##</td>
  <td align=right>##clicks##</td>
  <td align=right>##ctr##</td>
##_id_page_row_col##
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
                ##if(DONTSHOW_COL_PLACES != 1)##
                <td class="first_row_all">
                 ##sort_place_name##
                 %%place_name%%
                </td>
                ##endif##
                ##if(DONTSHOW_COL_MODS != 1)##
                <td class="first_row_all">
                 ##sort_module_name##
                 %%module_name%%
                </td>
                ##endif##
                ##if(DONTSHOW_COL_ITEMS != 1)##
                <td class="first_row_all">
                 ##sort_item_name##
                 %%item_name%%
                </td>
                ##endif##
                <td class="first_row_all" align=center>
                 ##sort_day##
                 %%day%%
                </td>
                ##if(DONTSHOW_COL_HOUR != 1)##
                <td class="first_row_all" align=center>
                 ##sort_hour##
                 %%hour%%
                </td>
                ##endif##
                <td class="first_row_all" align=right>
                 ##sort_views##
                 %%views%%
                </td>
                <td class="first_row_all" align=right>
                 ##sort_clicks##
                 %%clicks%%
                </td>
                <td class="first_row_all" align=right>
                 ##sort_ctr##
                 %%ctr%%
                </td>
##_id_page_header##
              </tr>
              ##list##
              <tr><td align=right colspan="##span_column_count##"><br><b>%%sum_all%%:</b></td><td align=right><br>##sum_views##</td><td align=right><br>##sum_clicks##</td><td align=right><br>##sum_ctr##</td></tr>
            </table>
##_group_operations_footer##
</form>

##button_add##
<div align="right" width="100%">##pager##</div>

<a name="anchor"></a>
"-->