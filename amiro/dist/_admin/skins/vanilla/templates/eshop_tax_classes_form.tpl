##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/eshop_tax_classes.lng"%%
%%include_language "templates/lang/_eshop_tax_classes_msgs.lng"%%

<!--#set var="option_row" value="<option value="##id##"##selected##>##name##</option>
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'tax_classes_form';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function OnObjectChanged_tax_classes_form(name, first_change, evt){
  return true;
}
addFormChangedHandler(OnObjectChanged_tax_classes_form);

function CheckForm(form) {
   var errmsg = "";

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }
##--
   if (form.tax_class_code.value=="") {
       return focusedAlert(form.tax_class_code, '%%tax_class_code_warn%%');
   }
--##

   ##if(TAX_SYSTEM == 'ru')##
   if (form.tax_rate.value=="") {
       return focusedAlert(form.tax_rate, '%%tax_rate_warn%%');
   }
   ##endif##

   return true;
}
//-->
</script>


  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="tax_classes_form" onSubmit="return CheckForm(window.document.tax_classes_form);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type="hidden" name="ltime" value="##ltime##">
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
     ##_id_page_field##

     ##if(TAX_SYSTEM == 'ru')##
     <tr>
       <td>%%name%%*:</td>
       <td>
         <input type="text" name="name" class="field field50" value="##name##" maxlength="64">
       </td>
     </tr>
     <tr>
       <td>%%tax_class_code%%:</td>
       <td>
         <input type="text" name="tax_class_code" class="field field15" value="##tax_class_code##" maxlength="32">
       </td>
     </tr>
     <tr>
       <td>%%tax_rate%%*:</td>
       <td>
         <input type="text" name="tax_rate" class="field field15" value="##tax_rate##" maxlength="6">&nbsp;
         <select name="tax_type">
            ##type_options##
         </select>
       </td>
     </tr>
     <tr>
     <td>%%tax_apply_type%%:</td>
     <td>
       <select name=tax_apply_type>
          <option value="detach" ##detach##>%%detach%%</option>
          <option value="charge" ##charge##>%%charge%%</option>
       </select>
     </td>
     </tr>
     <tr>
        <td colspan="2" align="right">
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
     ##else##
     <tr>
       <td colspan="2">%%tax_classes_us_desc%%</td>
     </tr>
     ##endif##
     </table>

    </form>