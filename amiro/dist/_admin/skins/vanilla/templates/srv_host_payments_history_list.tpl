%%include_language "templates/lang/srv_host_payments.lng"%%
%%include_language "templates/lang/srv_host_payments_history.lng"%%
%%include_language "templates/lang/_srv_host_payments_history_msgs.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="domain_url" value="
<a href="http://##domain_href##" title="##domain##" target="_blank">##domain##</a>
"-->

<!--#set var="charge" value="
<span style="color:red">##balance##</span>
"-->

<!--#set var="charge_owed" value="
<span style="color:red;font-weight:bold">##balance##</span>
"-->

<!--#set var="rest" value="
(<span style="color:blue">##rest##</span>)
"-->

<!--#set var="balance_url" value="
[<a href="javascript:void()" onclick="javascript:openExtDialog('%%balance_title%%', '##payments_href##?action=locate&amp;id=##pid##&flt_mode=simple#anchor', 1, 1 );return false;">%%balance%%</a>]
"-->

<!--#set var="payments_docs_url" value="
[<a href="javascript:void()" onclick="javascript:openExtDialog('%%payments_docs_title%%', '##payments_docs_href##&flt_mode=simple#anchor', 1, 1 );return false;">%%payments_docs%%</a>]
"-->
<!--#set var="document_num" value="
##doc_num## %%from%% ##doc_date##
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td>##date_str##</td>
##if(USER=="admin")##
  <td><b>##domain##</b><br><span style="font-size:9px;">##balance_url## ##payments_docs_url##</span></td>
  ##--<td  style="font-size:9px;"><b>##username##</b></td>
  <td>##client_name##&nbsp;</td>--##
  <td>##contractor_name##&nbsp;</td>
##endif##
  <td align=right>##amount##<br>##rest## </td>
  <td>##payment_type##</td>
  <td>##payment_num##<br><nobr>##document_num##&nbsp;</nobr></td>
  <td>##note##&nbsp;</td>
##if(USER=="admin")##
  <td align=left nowrap>##actions##&nbsp;</td>
##endif##
</tr>
##row_total##
"-->

<!--#set var="row_total" value="
<tr><td colspan=9>
<b>%%total_paid%%:</b>&nbsp;+##plus##&nbsp;&nbsp;<b>%%total_charged%%:</b>&nbsp;##minus##&nbsp;&nbsp;<b>%%total_balance%%:</b>&nbsp;##total##
</td></tr>
"-->

<!--#set var="list_body" value="
           
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_all">
                 %%date%%
                 ##sort_date##
                </td>
##if(USER=="admin")##
                <td class="first_row_all">
                 %%domain%%
                 ##sort_domain##
                </td>
##--                <td class="first_row_all">
                 %%username%%
                 ##sort_username##
                </td>
                <td class="first_row_all">
                 %%client%%
                </td>--##
                <td class="first_row_all">
                 %%contractor%%
                </td>
##endif##
                <td class="first_row_all">
                 %%amount%%
                 ##sort_amount##
                </td>
                <td class="first_row_all">
                 %%payment_type%%
                 ##sort_payment_type##
                </td>
                <td class="first_row_all">
                 %%documents_num%%
                 ##sort_payment_num##
                </td>
                <td class="first_row_all">
                 %%note%% 
                </td>
##if(USER=="admin")##
                <td class="first_row_all" width="100" nowrap>
                 %%actions%%
                </td>
##endif##
              </tr>
              ##list##
            </table>

<a name="anchor"></a>
"-->
