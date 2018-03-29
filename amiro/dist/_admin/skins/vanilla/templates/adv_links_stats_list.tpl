%%include_language "templates/lang/adv_links_stats.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="new_wnd_url" value="<a href="##url##" target="_blank" title="##title##">##name##</a>"-->
<!--#set var="plain_url" value="<a title="##title##">##name##</a>"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  ##if(DONTSHOW_COL_PAGE != 1)##
  <td>##page_url##&nbsp;</td>
  ##endif##
  ##if(DONTSHOW_COL_MODS != 1)##
  <td>##module_name##&nbsp;</td>
  ##endif##
  ##if(DONTSHOW_COL_URL != 1)##
  <td>##url##&nbsp;</td>
  ##endif##
  ##if(DONTSHOW_COL_NAME != 1)##
  <td>##name##&nbsp;</td>
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
        <script>
            function groupResBy(type){
                document.fltform.flt_groupby.value = type;
                document.fltform.submit();
            }
        </script>
        <style>
            a.groupBy##groupBy##{font-weight: bold;}
        </style>
        %%flt_groupby%%:
        <a class="groupBy0" href="javascript:groupResBy(0)">%%byall%%</a> |
        <a class="groupBy1" href="javascript:groupResBy(1)">%%bypages%%</a> |
        <a class="groupBy2" href="javascript:groupResBy(2)">%%bymodules%%</a> |
        <a class="groupBy3" href="javascript:groupResBy(3)">%%bylinks%%</a> |
        <a class="groupBy4" href="javascript:groupResBy(4)">%%byhrefs%%</a> |
        <a class="groupBy5" href="javascript:groupResBy(5)">%%byperiod%%</a>

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                ##if(DONTSHOW_COL_PAGE != 1)##
                <td class="first_row_all">
                 ##sort_page_url##
                 %%page_url%%
                </td>
                ##endif##
                ##if(DONTSHOW_COL_MODS != 1)##
                <td class="first_row_all">
                 ##sort_module_name##
                 %%module_name%%
                </td>
                ##endif##
                ##if(DONTSHOW_COL_URL != 1)##
                <td class="first_row_all">
                 ##sort_url##
                 %%url%%
                </td>
                ##endif##
                ##if(DONTSHOW_COL_NAME != 1)##
                <td class="first_row_all list_name_col">
                 ##sort_name##
                 %%name%%
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