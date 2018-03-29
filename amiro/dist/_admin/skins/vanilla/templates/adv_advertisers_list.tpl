%%include_language "templates/lang/adv_advertisers.lng"%%
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
  <td width="30" align=center>##active##</td>
  <td width="60" class="td_small_text"><nobr>##fdate##</nobr></td>
  <td width="100">##username##&nbsp;</td>
  <td width="180">##email##&nbsp;</td>
  <td width="110">##firstname##&nbsp;</td>
  <td width="110">##lastname##&nbsp;</td>
  <td class="td_small_text">##company##<br>##webcompany##&nbsp;</td>
  <td width="110" align=right>##balance##</td>
  <td align=center nowrap>##actions##</td>
</tr>
"-->

<!--#set var="list_body" value="
           
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_all" align="center" valign="middle" width="30">
                 &nbsp;
                 ##sort_active##
                </td>
                <td class="first_row_all" width="60" valign="middle">
                 %%date%%
                 ##sort_date##
                </td>
                <td class="first_row_all" width="100">
                 ##sort_username##
                 %%username%%
                </td>
                <td class="first_row_all" width="180">
                 %%email%%
                 ##sort_email##
                </td>
                <td class="first_row_all" width="110">
                  ##sort_firstname##
                 %%firstname%%
                </td>
                <td class="first_row_all" width="110">
                 %%lastname%%
                  ##sort_lastname##
                </td>
                <td class="first_row_all">
                 %%company%%
                 ##sort_company##
                </td>
                <td class="first_row_all" width="110">
                  %%balance%%
                  ##sort_balance##
                </td>
                <td class="first_row_all" align="center" width="70">
                 %%actions%%
                </td>
              </tr>
              ##list##
             </table>
            ##_group_operations_footer##
            </form>
        <a name="anchor"></a>
"-->