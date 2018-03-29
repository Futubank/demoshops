##--!ver=0200 rules="-SETVAR"--##

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
  <td><a href="##reports_link##?flt_report=##id##">##name##</a>&nbsp;</td>
  <td width="80">##type##&nbsp;</td>
  <td width="200">##template##&nbsp;</td>
  <td align=center>##action_edit####action_del####--actions--##</td>
</tr>
"-->

<!--#set var="list_body" value="
        <div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_all list_name_col">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all" width="80">
                 %%type%%
                  ##sort_type##
                </td>
                <td class="first_row_all" width="200">
                 %%template%%
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