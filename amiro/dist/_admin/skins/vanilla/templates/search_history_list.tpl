%%include_language "templates/lang/search_history.lng"%%
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
  <td class="td_small_text">
    <nobr>##if(front_link != '')##<a href="##front_link##" target="_blank">##query##&nbsp;&raquo;</a>##else####query####endif##&nbsp;</nobr>
  </td>
  <td width="80" class="td_small_text">##cdate##&nbsp;</td>
  <td width="80" class="td_small_text">##udate##&nbsp;</td>
  <td width="100" align="right">##quantity##</td>
  ##if(count_pages == '--')##
    <td width="100" align="center"><a href="javascript:void(0)" onClick="fltByQuery('##query_escaped##'); return false;" title="Фильтр по этому запросу">&raquo;</a></td>
  ##else##
    <td width="100" align="right">##count_pages##</td>
  ##endif##
  <td align=center>##action_view####action_del##</td>
</tr>
"-->

<!--#set var="list_body" value="

<script>
    function fltByQuery(query){
        document.fltform.flt_query.value = query;
        document.fltform.flt_query_group.checked = false;
        document.fltform.submit();
    }
</script>

##_group_operations_script##

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
<form name="group_operations_form">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    ##_group_operations_header##
    <td class="first_row_all">
     %%search_query%%
      ##sort_query##
    </td>
    <td class="first_row_all" width="80">
     %%create_date%%
     ##sort_create_date##
    </td>
    <td class="first_row_all" width="80">
     %%update_date%%
     ##sort_update_date##
    </td>
    <td class="first_row_all" align="center" width="100">
     %%quantity%%
      ##sort_quantity##
    </td>
    <td class="first_row_all" align="center" width="100">
     %%count_pages%%
      ##sort_count_pages##
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