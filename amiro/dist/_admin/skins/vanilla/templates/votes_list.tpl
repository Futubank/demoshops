##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/votes.lng"%%
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
  ##_positions_col##
  <td width="30" align=center>##public##</td>
  <td width="60" class="td_small_text">##fdate_start##&nbsp;</td>
  <td width="60" class="td_small_text">##fdate_end##&nbsp;</td>
  <td class="td_small_text">##question##&nbsp;</td>
  <td align=right>##total##&nbsp;</td>
  <td align=center >%%##status##%%&nbsp;</td>
  <td align=center nowrap="nowrap">##action_edit####action_result####action_reset_num####action_del####--actions--##</td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div  width="100%" align="right" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
##_positions_data##
          <form name="group_operations_form">
            <table width="100%" align=center border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                ##_positions_header##
                <td class="first_row_left_td" align="center" valign="middle" width="30">
                 ##sort_public##
                </td>
                <td class="first_row_all" width="80">
                 %%sort_date_start%%
                 ##sort_date_start##
                </td>
                <td class="first_row_all" width="80">
                 %%sort_date_end%%
                 ##sort_date_end##
                </td>
                <td class="first_row_all list_name_col">
                  %%question%%
                  ##sort_question##
                </td>
                <td class="first_row_all" width="80">
                  ##sort_total##
                  %%total%%
                </td>
                <td class="first_row_all" width="80">
                  ##sort_status##
                  %%status%%
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