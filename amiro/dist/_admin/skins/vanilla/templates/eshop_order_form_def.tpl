<!--#set var="payment_tax" value="
<tr>
  <td>%%payment_tax%%:</td>
  <td>##payment_tax##</td>
</tr>
"-->

<!--#set var="eshop_digitals_expire" value="
     <tr>
       <td>
        %%expire_date%%:
       </td>
       <td>
         <input type=text name="expire_date" class='field fieldDate' value="##eshop_digitals_expire##" maxlength="30" helpId= "form_date" />
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.eshop_form.expire_date);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId= "clnd_date"/></a>
       </td>
     </tr>
"-->

<!--#set var="eshop_digitals_header" value="
<td class="first_row_all" align=center>%%eshop_digitals_attempts%%</td>
"-->

<!--#set var="eshop_digitals_row" value="
<tr>
  <td>
    <span title="##filename##"><font color="##name_color##">##short_filename##</font></span>&nbsp;
  </td>
  <td align="right">
    <input type=text name="number_attempts##file_id##" value="##number_attempts##" class="field field2" maxlength="3"  ##atempts_disabled##>
    <input type=hidden name="file_id##id##[]" value="##file_id##">
    <input type=hidden name="number_attempts_old##file_id##" value="##number_attempts##">
  </td>
  <td width="50">&nbsp;%%is_of%%&nbsp;##number_initial_attempts##
  </td>
</tr>
"-->

<!--#set var="eshop_digitals_col" value="
<td class="##style##" align=right>
<table cellspacing="0" cellpadding="0" width=100% border="0">
  ##eshop_digitals_rows##
</table>
<input type=hidden name="id##index##" value="##id##">
</td>
"-->

<!--#set var="item_row_ownername_header" value="
<td class="first_row_all" align=right>%%order_owner%%</td>
"-->

<!--#set var="item_row_ownername" value="
<td class="##style##" align=right>##owner_name##</td>
"-->

<!--#set var="eshop_digitals_col_na" value="
<td class="##style##" align=right>%%not_available%%</td>
"-->

<!--#set var="print_popup" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>%%site_title%% - %%eshop_print_form%%</TITLE>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css">
<script type="text/javascript">
<!--

function onBtnOk(){
    var oArgs = {};

    for(var i = 0; i < document.printForm.type.length; i++){
        if(document.printForm.type[i].checked){
            oArgs.type = document.printForm.type[i].value;
            break;
        }
    }
    top.user_click_blank('print_confirm', '##id##', oArgs);
    closeDialogWindow();
    return false;
}
-->
</script>

</HEAD>
<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">
<center>
##form##
</center>
</BODY>
</HTML>
"-->

<!--#set var="print_type" value="
<input type="radio" id="type_##type_value##" name="type" value="##type_value##" ##checked##>&nbsp;<label for="type_##type_value##">##type_name##</label><br />
"-->

<!--#set var="print_popup_form" value="
<form name="printForm" action="##script_link##" enctype="multipart/form-data" method="POST">
<table cellspacing="0" cellpadding="10" align="center" width=100%>
  <tr>
   <td align="center">
    <table cellspacing="0" cellpadding="0" align="center">
     <tr>
      <td>
      ##print_type##
      </td>
     </tr>
    </table>
   </td>
  </tr>
  <tr>
    <td align="center">
        <input type="hidden" name="action" value="print">
        <input type="button" name="add" value="  %%show_btn%%  " class="but" onClick="return onBtnOk();">&nbsp;
        <input type="button" name="add" value="  %%close_btn%%  " class="but" OnClick="closeDialogWindow();">
    </td>
   </tr>
</table>
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'eshop_form';
var _cms_script_link = '##script_link##?';

function CheckForm(form) {
   return true;
}
-->
</script>

<!--#set var="history" value="
  <table border=0 cellspacing=0 cellpadding=0>
  <tr>
    <td class="first_row_left_td">%%date%%</td>
    <td class="first_row_all">%%status%%</td>
    <td class="first_row_all">%%changed_by%%</td>
    <td class="first_row_all">%%ip%%</td>
    <td class="first_row_all">%%comments%%</td>
  </tr>
  ##status_list##
  </table>
"-->

<!--#set var="status_row" value="
    <tr>
      <td class="##style##">##date##&nbsp;</td>
      <td class="##style##">##status##&nbsp;</td>
      <td class="##style##">##changed_by##&nbsp;</td>
      <td class="##style##">##ip##&nbsp;</td>
      <td class="##style##">##comments##&nbsp;</td>
    </tr>
"-->

<!--#set var="price_caption" value="
<br>(##price_caption##)
"-->

<!--#set var="item_row_newname" value="
<br>(<span title="##name##">##name_short##</span>)
"-->

<!--#set var="order_username" value="
&nbsp;(##order_username##)
"-->

<!--#set var="item_row" value="
    <tr>
      <td class="##style##" >&nbsp;##sku####IF(purchase_sku!="")##(##purchase_sku##)##endif##</td>
      <td class="##style##" ><span title="##order_name## ##order_property_caption##">##order_name_short## ##order_property_caption_short##</span>##new_name##&nbsp;<br></td>
      <td class="##style##" align=right>&nbsp;##curr_price##</td>
      <td class="##style##" align=right>&nbsp;##purchase_price####price_caption##</td>
      <td class="##style##" align=right>&nbsp;##qty##</td>
      <td class="##style##" align=right>&nbsp;##total##</td>
##if(ENABLE_WEIGHT_COL)##
      <td class="##style##" align=right>&nbsp;##weight##</td>
      <td class="##style##" align=right>&nbsp;##total_weight##</td>
##endif##
##if(ENABLE_SIZE_COL)##
      <td class="##style##" align=right>&nbsp;##size##</td>
##endif##
##if(shipping_conflicts == "show_shipping_for_each_type")##
      <td class="##style##">##shipping_method_name##&nbsp;</td>
##endif##
      ##owner_name##
      ##eshop_digitals_col##
    </tr>
"-->

<!--#set var="form" value="
"-->

<!--#set var="print_btn" value="
<input type="button" name="print" value="  %%print_order%%  " class="but-mid" onClick="user_click_blank('print','##id##');return false;">
"-->

<!--#set var="print_btn_popup" value="
<input type="button" name="print" value="  %%print_order%%  " class="but-mid" onClick="javascript:openDialog('%%eshop_print_form%%', '##script_link##?action=print&id=##id##', 320, 180); return false;">
"-->

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="eshop_form" onSubmit="return CheckForm(window.document.eshop_form);">
     ##form_common_hidden_fields##
     <input type="hidden" name="type" value="">
##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">

     <tr>
        <td width=220 valign=top>%%send_notification%%:</td>
        <td><input type="radio" name="send_notification" id="send_notification1" value="default" checked> <label for="send_notification1">%%default%%</label><br>
          <input type="radio" name="send_notification" id="send_notification2" value="force"> <label for="send_notification2">%%force_send%%</label><br>
          <input type="radio" name="send_notification" id="send_notification3" value="dont"> <label for="send_notification3">%%dont_send%%</label><br>
        </td>
   </tr>
     <tr>
       <td colspan="2">
         <br>
       </td>
     </tr>
     <tr>
       <td>
%%item_name%%:
</td>
       <td>
         ##name##
       </td>
     </tr>
     <tr>
       <td>
%%username%%:
</td>
       <td>
         ##username####if(username != order_username)## ##order_username####endif##
       </td>
     </tr>
     <tr>
       <td>
%%o_timestamp%%:
</td>
       <td>
         ##o_date##
       </td>
     </tr>
     <!--tr>
       <td>
%%a_timestamp%%:
</td>
       <td>
         ##a_date##
       </td>
     </tr-->
     ##eshop_digitals_expire##
     <tr>
       <td>
%%status%%:
</td>
       <td>
         <select name=status>
           <option value="draft" ##draft_selected##>%%draft%%</option>
           <option value="printed" ##printed_selected##>%%printed%%</option>
           <option value="pending" ##pending_selected##>%%pending%%</option>
           <option value="checkout" ##checkout_selected##>%%checkout%%</option>
           <option value="waiting" ##waiting_selected##>%%waiting%%</option>
           <option value="shipped" ##shipped_selected##>%%shipped%%</option>
           <option value="delivered" ##delivered_selected##>%%delivered%%</option>
           <option value="rejected" ##rejected_selected##>%%rejected%%</option>
           <option value="accepted" ##accepted_selected##>%%accepted%%</option>
           <option value="cancelled" ##cancelled_selected##>%%cancelled%%</option>
           <option value="confirmed" ##confirmed_selected##>%%confirmed%%</option>
           <option value="confirmed_conditionally" ##confirmed_conditionally_selected##>%%confirmed_conditionally%%</option>
           <option value="confirmed_done" ##confirmed_done_selected##>%%confirmed_done%%</option>
         </select>
       </td>
     </tr>
     <tr>
        <td>
          %%comments%%:
        </td>
        <td>
          <textarea class="field" style="width:230px" rows="3" name="adm_comments" maxlength="65535">##adm_comments##</textarea>
        </td>
     </tr>
     <tr>
       <td>
%%goods_value%%:
</td>
       <td>
         ##total##
       </td>
     </tr>
     <tr>
       <td>
%%tax%%:
</td>
       <td>
         ##tax##
       </td>
     </tr>
##if(SHOW_DISCOUNTS && grand_discount)##
     <tr>
       <td>%%applied_discount%%:</td>
       <td>##grand_discount## (##grand_discount_percent## %)</td>
     </tr>
##endif##
##if(coupon)##
     <tr>
       <td>%%coupon_category%%:</td>
       <td>##coupon_category## (##coupon##)</td>
     </tr>
##endif##
     <tr>
       <td>
%%shipping%%:
</td>
       <td>
         ##shipping##
       </td>
     </tr>
     <tr>
       <td>
<b>%%amount%%:</b>
</td>
       <td>
         <b>##amount##</b>
       </td>
     </tr>
##payment_tax##
     <tr>
       <td valign="top">
%%customer_info%%:
</td>
       <td>
         %%ordered%% : ##firstname## ##lastname##<br>
         %%email%% : ##cust_email##<br>
         ##cust_info##
       </td>
     </tr>
     <tr>
       <td valign="top">
%%comments%%:
</td>
       <td>
         ##comments##
       </td>
     </tr>
     <tr>
       <td valign="top">
%%sysinfo%%:
</td>
       <td>
         ##sysinfo##
       </td>
     </tr>
     <tr>
       <td colspan="2">
         %%order_details%%:
       </td>
     </tr>
     <tr>
       <td colspan=2 class="td_small_text">
        <table border=0 cellspacing=0 cellpadding=0>
        <tr>
          <td class="first_row_left_td">%%sku%%</td>
          <td class="first_row_all">%%product%%</td>
          <td class="first_row_all" align=center>%%curr_price%%</td>
          <td class="first_row_all" align=center>%%purchase_price%%</td>
          <td class="first_row_all" align=center>%%quantity%%</td>
          <td class="first_row_all" align=center>%%total%%</td>
##if(ENABLE_WEIGHT_COL)##
          <td class="first_row_all" align=center>%%weight%%</td>
          <td class="first_row_all" align=center>%%total_weight%%</td>
##endif##
##if(ENABLE_SIZE_COL)##
          <td class="first_row_all" align=center>%%size%%</td>
##endif##
##if(shipping_conflicts == "show_shipping_for_each_type")##
          <td class="first_row_all" align=center>%%shipping_method%%</td>
##endif##
          ##owner_name_header##
          ##eshop_digitals_header##
        </tr>
        ##product_list##
        </table>

        <table>
        <tr><td valign="top">
        <td valign="top" align="left">
        ##eshop_digitals_legend##
        </td>
        </tr></table>

    </td>
     </tr>
     <tr>
       <td colspan="2">
         %%statuses_history%%:
       </td>
     </tr>
     <tr>
       <td colspan=2 class="td_small_text">
       ##history##
</td>
     </tr>
     <tr>
        <td>
        ##print_btn##
        </td>
        <td align="right">
        <br>
         ##form_buttons##
        <br><br>
        </td>
     </tr>
     <tr>
       <td colspan="2">
         <sub>%%required_fields%%</sub>
       </td>
     </tr>
     </table>
    </form>
