<!--#set var="empty" value="
<div width="100%" align="right">##cat_list##</div>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->


<!--#set var="order_member_name" value="
 (##order_member_name##)
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  <td align="right">##id##</td>
  <td >##member_name####order_member_name##&nbsp;</td>
  <td width="70">##member_username##&nbsp;</td>
  <td width="150" class="td_small_text" class="td_small_text">##name##&nbsp;</td>
  <td width="130" class="td_small_text">##o_date##</td>
  <td width="70" class="td_small_text">##status##</td>
  <td width="120" align=right>&nbsp;##amount##</td>
  <td align=center>##action_print####action_edit####action_del##</td>
</tr>
"-->

<!--#set var="row_total" value="
<tr class="##style##">
  <td colspan="7"><b>%%total%%</b></td>
  <td align="right"><b>##list_total##</b></td>
  <td>&nbsp;</td>
</tr>
"-->

<!--#set var="list_body" value="
           <div width="100%" align="right">##cat_list##</div>
           <div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_left_td" valign="middle" width="40">
                 %%order_id%%
                  ##sort_id##
                </td>
                <td class="first_row_all" valign="middle">
                 %%username%%
                  ##sort_member_name##
                </td>
                <td class="first_row_all" valign="middle">
                 %%member_username%%
                  ##sort_member_username##
                </td>
                <td class="first_row_all" valign="middle" width="150">
                 %%item_name%%
                  ##sort_name##
                </td>
                <td class="first_row_all" width="130">
                 %%o_timestamp%%
                 ##sort_order_date##
                </td>
                <td class="first_row_all" width="70">
                 %%status%%
                  ##sort_status##
                </td>
                <td class="first_row_all" width="120">
                 %%amount%%
                  ##sort_amount##
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
              ##row_total##
              </table>
##_group_operations_footer##
</form>
<a name="anchor"></a>
"-->