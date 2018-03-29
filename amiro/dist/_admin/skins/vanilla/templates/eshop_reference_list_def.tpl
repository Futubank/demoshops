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
  <td width="150">##name##</td>
  ##if(!DONOTUSEVALUE)##
  <td width="150">##value##&nbsp;</td>
  ##endif##
  ##_picture_col##
  <td width="150">##sku_code##&nbsp;</td>
  <td class="td_small_text">##description##&nbsp;</td>
  <td width="60">##fdate##&nbsp;</td>
  <td width="40" align=center>##actions##</td>
</tr>
"-->

<!--#set var="list_body" value="
##_positions_data##
           <div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##

          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                ##_positions_header##
                <td class="first_row_left_td list_name_col" width="150">
                  %%name%%
                  ##sort_name##
                </td>
                ##if(!DONOTUSEVALUE)##
                <td class="first_row_all" width="150">
                  %%value%%
                  ##sort_value##
                </td>
                ##endif##
                ##_picture_header##
                <td class="first_row_all" width="150">
                  %%sku_code%%
                </td>
                <td class="first_row_all">
                 %%description%%
                </td>
                <td class="first_row_all" width="60">
                 %%cdate%%
                 ##sort_date##
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