%%include_language "templates/lang/pay_drivers.lng"%%

<script type="text/javascript">
var editor_enable = '##editor_enable##';
var _cms_document_form = 'pay_drivers_form';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {
   return true;
}
</script>


<br>
<form action=##script_link## method=post enctype="multipart/form-data" name="pay_drivers_form" onSubmit="return CheckForm(window.document.pay_drivers_form);">
 ##form_common_hidden_fields##
 ##filter_hidden_fields##
 <input type="hidden" name="step" value="1">
 <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
<col width="*">
 <tr>
   <td align="center">
     <input type="submit" name="check" value="  %%check_btn%%  " class="but-250" onClick="this.form.action.value='check'">
   </td>
 </tr>
 </table>

</form>
