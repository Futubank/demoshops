%%include_language "templates/lang/srv_host_payments.lng"%%
%%include_language "templates/lang/_srv_host_payments_msgs.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="balance_warn" value="
<span style="color:blue">##balance##</span>
"-->

<!--#set var="is_debtor" value="
<span style="color:red">##balance##</span>
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'payform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';

function isFloat(field,msg) {

    var re = /^[\-]?\d+(\.\d*)?$/;
    if(re.test(field.value))
        return true;
    alert(msg);
    field.focus();
    return false;
}

function CheckForm(form) {

    if(!isFloat(form.amount_month,'%%invalid_value%%'))
        return false;
    if(!isFloat(form.amount_min,'%%invalid_value%%'))
        return false;

    if(!isFloat(form.traf_amount,'%%invalid_value%%'))
        return false;

    if(parseFloat(form.traf_amount.value)==0) {
        alert('%%cannot_be_zero%%');
        form.traf_amount.focus();
        return false;
    }

    if(!isFloat(form.traf_price,'%%invalid_value%%'))
        return false;

    var re = /^\d+$/;
    if(!re.test(form.remind_period.value)) {
        alert('%%invalid_value%%');
        form.remind_period.focus();
        return false;
    }

    return true;
}

-->
</script>

  <form action=##script_link## method=post enctype="multipart/form-data" name="payform" onSubmit="return CheckForm(window.document.forms.payform);">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="type">
     <input type="hidden" name="action" value="##action##">
     ##filter_hidden_fields##
   <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
   <tr>
     <td>
     %%date_registered%%:
     </td>
       <td>
       ##date_registered##
     </td>
   </tr>
   <tr>
     <td>
     %%username%%:
     </td>
       <td>
       ##username##
     </td>
   </tr>
   <tr>
     <td>
     %%domain%%:
     </td>
       <td>
       ##domain##
     </td>
   </tr>
##if(USER=="admin")##
   <tr>
     <td>
     %%type%%:
     </td>
       <td>
       ##licence_type##
     </td>
   </tr>
   <tr>
     <td>
     %%date_amount_zero%%:
     </td>
       <td>
       ##date_amount_zero##
     </td>
   </tr>
   <tr>
     <td>
     %%billing_on%%:
     </td>
       <td>
       <input type="checkbox" name="billing_on" value="1" ##billing_on##>
     </td>
   </tr>
   <tr>
     <td>
     %%last_down_payment%%:
     </td>
       <td>
       ##last_down_payment##
     </td>
   </tr>
   <tr>
     <td>
     %%billing_date%%:
     </td>
       <td>
       <input type="text" name="billing_date" value="##billing_date##" class="field fieldDate field10" >
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.forms.payform.billing_date);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
     </td>
   </tr>
##endif##
   <tr>
     <td>
     %%note%%:
     </td>
       <td>
##if(USER=="admin")##
         <textarea name="note" class="field" cols=40 rows=5>##note##</textarea>
##else##
       ##note##
##endif##
     </td>
   </tr>
##if(USER=="admin")##
   <tr>
     <td>
     %%hidden_note%%:
     </td>
       <td>
         <textarea name="hidden_note" class="field" cols=40 rows=5>##hidden_note##</textarea>
     </td>
   </tr>
##endif##
   <tr>
     <td>
     %%last_payment%%:
     </td>
       <td>
       ##last_payment##
     </td>
   </tr>
   <tr>
     <td>
     %%balance%%:
     </td>
       <td>
       ##balance##
     </td>
   </tr>
##if(USER!="admin")##
   <tr>
     <td>
     %%min_balance%%:
     </td>
       <td>
       ##amount_min_str##
       ##if(amount_min<0)##
       &nbsp;<span style="font-weight: bold; font-style: italic; color: #B74700;">(%%delay_of_payment_on%%)</span>
       ##endif##
     </td>
   </tr>
   <tr>
     <td>
     %%amount_month%%:
     </td>
       <td>
       ##amount_month_str##
     </td>
   </tr>
   <tr>
     <td>
     %%traf_included%%:
     </td>
       <td>
       ##traf_quota##
     </td>
   </tr>
   <tr>
     <td>
     %%traffic_over%%:
     </td>
       <td>
       ##traf_price_str## / ##traf_amount_str##
     </td>
   </tr>
##endif##
##if(USER=="user")##
   <tr>
     <td colspan=2 align=center>
		 <br>
  ##if(amount_min==0 && licence_type_real=="paid")##
		 <button class=but-mid id="delay_payment_button">%%delay_of_payment_on%%</button>&nbsp;&nbsp;&nbsp;
		 <div id="delay_payment_info" style="display:none;position:absolute;margin-top:-98px; width:500px;height:auto;background:#fff;border: 1px #c7c7c7 solid; border-radius:10px;padding:20px;text-align:left;">
			 %%delay_of_payment_info%%
			 <div style="text-align:center">
				<button class=but-long onclick="location.href='##script_link##?action=delay_payment'; return false;">%%delay_of_payment_do%%</button>
			</div>
		 </div>
		 <script>
		 AMI.$('#delay_payment_button').click(function(){
		  AMI.$('#delay_payment_info').show();
		  return false;
		 });
		 AMI.$(document).click(function(){
		  if(AMI.$('#delay_payment_info').is(':visible')){
			 AMI.$('#delay_payment_info').hide();
		  }
		 });
		 </script>
  ##endif##
		<button class=but-mid onclick="location.href='##payments_add_url##'; return false;">%%add_funds%%</button>
     </td>
   </tr>
##endif##
##if(USER=="admin")##
   <tr>
     <td>
     %%min_balance%%:
     </td>
       <td>
       <input type="text" name="amount_min" class="field field10" value="##amount_min##" >
     </td>
   </tr>
   <tr>
     <td>
     %%min_payment%%:
     </td>
       <td>
       <input type="text" name="payment_amount_min" class="field field10" value="##payment_amount_min##" >
     </td>
   </tr>
   <tr>
     <td>
     %%amount_month%%:
     </td>
       <td>
       <input type="text" name="amount_month" class="field field10" value="##amount_month##" >
     </td>
   </tr>
   <tr>
     <td>
     %%traffic_over%%:
     </td>
       <td>
       <input type="text" name="traf_price" class="field field10" value="##traf_price##" > / <input type="text" name="traf_amount" class="field field10" value="##traf_amount##" > Mb
     </td>
   </tr>
   <tr>
     <td>
     %%remind%%:
     </td>
       <td>
       <input type="text" name="remind_period" class="field field10" value="##remind_period##" >
       <select name="remind_units">
       <option value="days" ##days##>%%days%%</option>
       <option value="weeks" ##weeks##>%%weeks%%</option>
       <option value="months" ##months##>%%months%%</option>
       </select>
     </td>
   </tr>
##endif##
##if(action=="apply")##
     <tr>
        <td colspan="2" align="right">
        <br>
        <input type="submit" name="apply" value="  %%apply_btn%%  " class="but" ##apply##>
        <input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
        </td>
     </tr>
##endif##
   </table>
    </form>
