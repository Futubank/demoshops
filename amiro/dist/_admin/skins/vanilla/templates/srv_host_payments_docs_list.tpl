%%include_language "templates/lang/srv_host_payments.lng"%%
%%include_language "templates/lang/srv_host_payments_docs.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="history_url" value="
[<a href="javascript:void()" onclick="javascript:openExtDialog('%%history_title%%', '##history_href##&flt_mode=simple', 1, 1 );return false;" title="%%view_history_for%% ##client_name## (##domain##)">%%history%%</a>]
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  ##_positions_col##
  <td><b>##domain_orig##</b><br>##history_url##&nbsp;</td>
  <td>##document##&nbsp;</td>
  <td nowrap>##doc_num##&nbsp;</td>
  <td>##date##&nbsp;</td>
  <td align=right>##amount##&nbsp;</td>
  <td>##client_name##&nbsp; ##client_inn##</td>
  <td>##contractor_name##&nbsp;</td>
  <td>##payment_type##&nbsp;</td>
  <td nowrap>##status##&nbsp;</td>
  <td align=left nowrap>##actions##&nbsp;</td>
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
                ##_positions_header##
                <td class="first_row_all">
                 %%domain%% 
                 ##sort_domain##
                </td>
                <td class="first_row_all">
                 %%document%%
                 ##sort_type##
                </td>
                <td class="first_row_all">
                 %%doc_num%%
                </td>
                <td class="first_row_all">
                 %%date%%
                 ##sort_date##
                </td>
                <td class="first_row_all">
                 %%amount%%
                </td>
                <td class="first_row_all">
                 %%client_name%%
                </td>
                <td class="first_row_all">
                 %%contractor_name%%
                </td>
                <td class="first_row_all">
                 %%payment_type%%
                </td>
                <td class="first_row_all">
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

