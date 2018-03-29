<!--#set var="del" value="
  <a href="javascript:" onClick="if (##if(delete_nothing <= 0)##confirm('%%delete_warn%%')##else##confirm('%%delete_ref_warn%%')##endif##){##if(modify_allowed)##;if(confirm('%%delete_modify_warn%%')){document.eshop_form.delete_type.value='2';}##endif##user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

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
  <td width="30" align=center>&nbsp;##public##</td>
  <td width="70">##table_num##</td>
  <td width="150">##name##</td>
  <td>##default_caption##&nbsp;</td>
  <td width="150">##ftype##</td>
  <td width="150">##sys_alias##</td>
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
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_public##
                </td>
                <td class="first_row_left_td" width="70">
                  %%table_num%%
                  ##sort_table_num##
                </td>
                <td class="first_row_left_td list_name_col" width="150">
                  %%name%%
                  ##sort_name##
                </td>
                <td class="first_row_all">
                 %%default_caption%%
                </td>
                <td class="first_row_all" width="150">
                 %%ftype%%
                  ##sort_ftype##
                </td>
                <td class="first_row_all" width="150">
                 %%sys_alias%%
                  ##sort_sys_alias##
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