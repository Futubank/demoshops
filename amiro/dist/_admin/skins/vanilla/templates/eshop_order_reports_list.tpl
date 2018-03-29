%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/eshop_order_reports.lng"%%
%%include_language "templates/lang/eshop_order.lng"%%

<!--#set var="empty" value="
<div width="100%" align="right">##cat_list##</div>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="no_report_selected" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%select_report%%</h3></td>
</tr>
</table>
"-->

<!--#set var="no_reports_found" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%create_report%%</h3></td>
</tr>
</table>
"-->

<!--#set var="order_member_name" value="
 (##order_member_name##)
"-->

<!--#set var="row" value="
<tr class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)">
  <td align="right">##id##</td>
  <td class="td_small_text">##member_name####order_member_name##&nbsp;</td>
  <td width="130" class="td_small_text">##o_date##</td>
  <td width="70" class="td_small_text">##status##</td>
  <td width="150" class="td_small_text">##item_name##&nbsp;</td>
  <td width="80" align=right>##qty##&nbsp;</td>
  <td width="120" align=right>##item_price_money##&nbsp;</td>
  <td width="120" align=right>&nbsp;##item_amount_money##</td>
</tr>
"-->

<!--#set var="list_body" value="
           
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_left_td" valign="middle" width="40">
                 %%order_id%%
                </td>
                <td class="first_row_all" valign="middle">
                 %%username%%
                </td>
                <td class="first_row_all" width="130">
                 %%o_timestamp%%
                </td>
                <td class="first_row_all" width="70">
                 %%status%%
                </td>
                <td class="first_row_all" valign="middle" width="150">
                 %%item_name%%
                </td>
                <td class="first_row_all" width="80">
                 %%qty%%
                </td>
                <td class="first_row_all" width="120">
                 %%price%%
                </td>
                <td class="first_row_all" width="120">
                 %%amount%%
                </td>
              </tr>
              ##list##
              </table>

"-->