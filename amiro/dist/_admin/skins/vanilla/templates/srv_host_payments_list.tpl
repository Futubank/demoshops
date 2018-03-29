%%include_language "templates/lang/srv_host_payments.lng"%%
%%include_language "templates/lang/_srv_host_payments_msgs.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="domain_url" value="
<a href="http://##domain_href##" title="##domain##" target="_blank">##domain##</a>
"-->

<!--#set var="history_url" value="
[<a href="javascript:void()" onclick="javascript:openExtDialog('%%history_title%%', '##history_href##&flt_mode=simple#anchor', 1, 1 );return false;" title="%%view_history_for%% ##username## (##domain##)">%%history%%</a>]
"-->

<!--#set var="host_edit_url" value="
<a href="javascript:void()" onclick="javascript:openExtDialog('%%sites_title%%', '##href##&flt_mode=simple#anchor', 1, 1 );return false;">##status##</a>
"-->

<!--#set var="balance_warn" value="
<span style="color:blue">##balance##</span>
"-->

<!--#set var="is_debtor" value="
<span style="color:red">##balance##</span>
"-->


<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td>##date_registered##</td>
  <td nowrap  style="font-size:9px;"><b>##domain##</b><br> ##username## ##history_url##</td>
  <td>##licence_type##<br>##billing_on##</td>
  <td><b>##status##</b><br>##admin_status##</td>
  <td>##note##&nbsp;</td>
  <td align=right><b>##amount##</b><br>##amount_min##</td>
  <td align=right><b>##amount_month##</b></td>
  <td align=right>##amount_total_plus_f##<br>##amount_total_minus_f##</td>
  <td align=right><b>##last_payment_amount##</b><br>##last_payment_date##</td>
  <td align=right>##date_amount_zero##<br>##remind_start##</td>
  <td align=right>##licence_exp_date##</td>
  <td align=center>##actions##</td>
  ##row_total##
</tr>
"-->

<!--#set var="row_total" value="
<tr><td colspan=16>
<b>%%total_paid%%:</b>&nbsp;+##plus##&nbsp;&nbsp;<b>%%total_charged%%:</b>&nbsp;##minus##&nbsp;&nbsp;<b>%%total_balance%%:</b>&nbsp;##total##
</td></tr>
"-->

<!--#set var="list_body" value="
           
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_all">
                 %%date_registered%%
                 ##sort_datereg_sort##
                </td>
                <td class="first_row_all">
                 %%domain%% / %%username%%
                 ##sort_domain##
                </td>
                <td class="first_row_all">
                 %%type_onoff%%
                </td>
                <td class="first_row_all">
                 %%status%% / %%admin_status%%
                </td>
                <td class="first_row_all">
                 %%note%% 
                </td>
                <td class="first_row_all">
                 %%balance%% / %%min_balance%%
                 ##sort_amount##
                </td>
                <td class="first_row_all">
                 %%amount_month%%
                 ##sort_amount_month##
                </td>
                <td class="first_row_all">
                 %%sum_payments%%
                </td>
                <td class="first_row_all">
                 %%last_payment%%
                 ##sort_last_payment##
                </td>
                <td class="first_row_all">
                 %%date_amount_zero%% / %%remind%%
                 ##sort_udate_az##
                </td>
                <td class="first_row_all">
                 %%licence_expire_dates%%
                 ##sort_udate_le##
                </td>
                <td class="first_row_all" width="100" nowrap>
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>

<a name="anchor"></a>

<form action="index.php" method=post name="loginform">
<input type=hidden name=hsid>
<input type=hidden name=tstamp value="##tstamp##">
<input type=hidden name=loginname>
<input type=hidden name=faction value=login>
<input type=hidden name=domain>
</form>
"-->
