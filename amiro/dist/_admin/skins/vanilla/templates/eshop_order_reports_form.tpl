%%include_language "templates/lang/eshop_order_reports.lng"%%

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'eshop_form';
var _cms_script_link = '##script_link##?';

function CheckForm(form) {
   var errmsg = "";

   return true;
}
-->
</script>

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="eshop_form" onSubmit="return CheckForm(window.document.eshop_form);">
     ##form_common_hidden_fields##
     <input type="hidden" name="type" value="">
##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
        <td align="right">
<input type="button" name="print" value="  %%print_report%%  " class="but-long" onClick="user_click_blank('print');return false;">
        </td>
     </tr>
     </table>
    </form>

