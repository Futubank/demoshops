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
  <td width="30" align=center>##active##</td>
  <td width="150">##username##</td>
  <td width="150">##firstname##&nbsp;</td>
  <td width="150">##lastname##&nbsp;</td>
##if(ESHOP_ACCOUNT=="1")##
  <td width="70" align=right><nobr>##balance##</nobr></td>
##endif##
  <td width="70" align="right">##eshop_discount##&nbsp;</td>
  <td>##email##&nbsp;</td>
  <td align=center nowrap>##actions##</td>
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
                 ##sort_active##
                </td>
                <td class="first_row_all" valign="middle" width="150">
                 %%username%%
                 ##sort_username##
                </td>
                <td class="first_row_all" width="150">
                 %%firstname%%
                  ##sort_firstname##
                </td>
                <td class="first_row_all" width="150">
                 %%lastname%%
                  ##sort_lastname##
                </td>
##if(ESHOP_ACCOUNT=="1")##
                <td class="first_row_all" width="80">
                 %%balance%%
                  ##sort_balance##
                </td>
##endif##
                <td class="first_row_all" width="80">##sort_eshop_discount## %%personal_discount%%&nbsp;</td>
                <td class="first_row_all">
                 %%email%%
                  ##sort_email##
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
