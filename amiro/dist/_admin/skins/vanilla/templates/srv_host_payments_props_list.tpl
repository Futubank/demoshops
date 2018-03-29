%%include_language "templates/lang/srv_host_payments_props.lng"%%
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
  <td width="30" align=center>##active##</td>
  <td><b>##domain_orig##</b>&nbsp;</td>
  <td>##name##&nbsp;</td>
  <td>##code##&nbsp;</td>
  <td>##email##&nbsp;</td>
  <td align=center>##actions##</td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                ##_positions_header##
                <td class="first_row_all" align="center" valign="middle" width="30">
                 %%active%%
                 ##sort_active##
                </td>
                <td class="first_row_all">
                 %%domain%%
                </td>
                <td class="first_row_all list_name_col">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all">
                 %%code%%
                 ##sort_code##
                </td>
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