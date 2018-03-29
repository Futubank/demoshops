%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/stickers.lng"%%


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
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)"
onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  ##_positions_col##
  <td width="30" align=center>##public##</td>
  <td width="60" class="td_small_text">##fdate##&nbsp;</td>
   ##category_col##
	<td>##header##</td>
	<td>##announce##&nbsp;</td>
   <td nowrap align=center>##action_edit####action_del##&nbsp;</td>
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
                <td class="first_row_left_td" align="center" valign="middle" width="30">
                 ##sort_public##
                </td>
                <td class="first_row_all">
                 %%date%%
                 ##sort_date##
                </td>
                ##category_list_header##
                <td class="first_row_all list_name_col">
                 %%header%%
                 ##sort_header##
                </td>
                <td class="first_row_all">
                 %%announce%%
                 ##sort_announce##
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