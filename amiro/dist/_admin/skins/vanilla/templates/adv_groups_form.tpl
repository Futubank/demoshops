%%include_language "templates/lang/adv_groups.lng"%%

<!--#set var="option" value="<option value="##value##" ##selected##>##name##</option>"-->

<script type="text/javascript">
<!--
var _cms_document_form = 'advgroupform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {
   var errmsg = "";

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   msobj = form.elements('adv_places[]');
   hasMS = false;
   for(i = 0; i < msobj.options.length; i++){
    if(msobj.options[i].selected){
        hasMS = true;
        break;
    }
   }
   if(!hasMS) {
       return focusedAlert(msobj, '%%adv_places_warn%%');
   }

   return true;
}
-->
</script>

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="advgroupform" onSubmit="return CheckForm(this);">
     <input type="hidden" name="publish" value="">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td>
        %%name%%*:
       </td>
       <td>
         <input type=text name=name class="field field40" value="##name##" maxlength="64">
       </td>
     </tr>
     <tr>
       <td>
        %%adv_places%%*:
       </td>
       <td>
         <select name="adv_places[]" multiple=1 size=5>
            ##adv_places##
         </select>
       </td>
     </tr>
     </table>
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
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
     </table>
    </form>
