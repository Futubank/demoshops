##--system info: module_owner="eshop" module="eshop_order_history" system="1"--##
%%include_language "_local/_admin/templates/lang/eshop_order_history.lng"%%

##-- common --##
<!--#set var="order_name" value="##name##"-->
<!--#set var="order_date" value="##date##"-->
<!--#set var="order_amount" value="<nobr>##amount##</nobr>"-->
<!--#set var="order_status" value="##status##&nbsp;"-->
<!--#set var="order_customer" value="
##firstname## ##lastname##
##IF(email)##<br /><small><a href="javascript:;">##email##</a></small>
"-->

##-- order's list --##

<!--#set var="order_comments" value="##comments##&nbsp;"-->

<!--#set var="order_row" value="
<tr>
    <td class="eshop-order-history-list__id">
        <div class="eshop-order-history-list__id-block">##id##</div>
        <div class="eshop-order-history-list__id-status">##status##</div>
    </td>
    <td class="eshop-order-history-list__user">##order_customer##</th>
    <td class="eshop-order-history-list__name">##name##&nbsp;</td>
    <td class="eshop-order-history-list__date">##date##</td>
    <td class="eshop-order-history-list__amount">##amount##</td>
    <td class="eshop-order-history-list__status">##status##</td>
    <td class="eshop-order-history-list__comments">&nbsp;##comments##</td>
##skin_tools_actions##
</tr>
"-->

<!--#set var="order_list" value="
##filter##
##IF(!filter)##
<table cellSpacing="0" cellPadding="5" border="0" class="tbl eshop-order-history-list" width="100%">
<tr>
  <th class="eshop-order-history-list__id">%%order_id%%</th>
  <th class="eshop-order-history-list__user">%%order_customer%%</th>
  <th class="eshop-order-history-list__name">%%order_name%%</th>
  <th class="eshop-order-history-list__date">%%order_date%%</th>
  <th class="eshop-order-history-list__amount">%%order_amount%%</th>
  <th class="eshop-order-history-list__status">%%status%%</th>
  <th class="eshop-order-history-list__comments">%%comments%%</th>
  <th>&nbsp;</th>
</tr>
##order_rows##
<tr>
  <td colspan="10" class="eshop-order-history-list__total">%%page_total%%: ##page_total##</td>
</tr>
</table>
##ENDIF##
"-->

<!--#set var="order_empty_list" value="
<div id="eshop-order-edp">
    <div id="eshop-order-edp__area">
        <div id="ami-async-list">%%no_orders%%</div>
    </div>
</div>
<script>
    AMI.$('#eshop-order-edp__area').height(AMI.$(window).height()-AMI.$('#ami-toolbar-block').height()-AMI.$('#eshop-order-edp__links').height());
    AMI.$(window).resize(function(){
        AMI.$('#eshop-order-edp__area').height(AMI.$(window).height()-AMI.$('#ami-toolbar-block').height()-AMI.$('#eshop-order-edp__links').height());
    });
</script>
"-->

<table cellspacing="0" cellpadding="5" width="100%" border="0">
    <tbody>##body##</tbody>
</table>
