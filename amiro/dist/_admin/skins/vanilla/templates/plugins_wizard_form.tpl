%%include_language "templates/lang/plugins_wizard.lng"%%

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'pluginsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {
   return true;
}
</script>


  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="pluginsform" onSubmit="return CheckForm(window.document.pluginsform);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type="hidden" name="step" value="1">
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
     <tr>
       <td>
         <input type="submit" name="check" value="  %%check_btn%%  " class="but-long" onClick="this.form.action.value='check'">
       </td>
     </tr>
     </table>

    </form>

<!--#set var="available_yes" value="%%yes%%"-->
<!--#set var="available_no" value="<font color="red"><b>%%no%%</b></font>"-->

<!--#set var="files_row" value="
        <tr class="##class##">
	  <td>##header##</td>
	  <td>##files##</td>
	  <td align="center">##available##</td>
	</tr>
"-->
