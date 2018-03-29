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
  <td align=center>##public##</td>
  <td width="100">##fnum##</td>
  <td width="100">##sys_name##</td>
  <td width="150">##name##</td>
  <td>##default_caption##&nbsp;</td>
  <td width="120">##ftype##</td>
  <td width="150">##value_type##</td>
  <td width="110" align=right>##datasets##</td>
  <td align=center>##actions##</td>
</tr>
"-->

<!--#set var="list_body" value="
           <div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_left_td" align="center" valign="middle" width="30">
                 ##sort_public##
                </td>
                <td class="first_row_all" width="100">
                  %%fnum%%
                  ##sort_fnum##
                </td>
                <td class="first_row_all" width="100">
                  %%sys_name%%
                  ##sort_sys_name##
                </td>
                <td class="first_row_all list_name_col" width="150">
                  ##sort_name##
                  %%name%%
                </td>
                <td class="first_row_all">
                 %%default_caption%%
                </td>
                <td class="first_row_all" width="120">
                 %%ftype%%
                  ##sort_ftype##
                </td>
                <td class="first_row_all" width="150">
                 %%value_type%%
                  ##sort_value_type##
                </td>
                <td class="first_row_all" width="110" align=right>
                  %%used_datasets%%
                  ##sort_used_datasets##
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
