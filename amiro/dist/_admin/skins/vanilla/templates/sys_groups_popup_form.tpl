%%include_language "templates/lang/sys_groups.lng"%%
%%include_template "templates/_icons.tpl"%%

<script type="text/javascript">
var editor_enable = '##editor_enable##';
var _cms_document_form = 'groupsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {
   var errmsg = "";
   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }
   return true;
}

function OnObjectChanged_sys_groups_form(name, first_change, evt){
    var oForm = document.forms[_cms_document_form];

    if(name == 'guest'){
        var hasAdminLogin = oForm.elements['login'].checked;
        if(oForm.elements['guest'].checked){
            oForm.elements['login'].checked = false;
        }
        oForm.elements['login'].disabled = oForm.elements['guest'].checked;
        if(oForm.elements['guest'].checked && hasAdminLogin){
            alert('%%warn_admin_guest%%');
        }
    }

    return true;
}
addFormChangedHandler(OnObjectChanged_sys_groups_form);
</script>

  <form action=##script_link## method=post enctype="multipart/form-data" name="groupsform" onSubmit="return CheckForm(this);">
   <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
   <tr>
     <td colspan="2">
##--       <input type="checkbox" name="is_default" ##is_default## ##is_default_disabled## value="1" helpId="form_is_default">
       %%is_default%%--##
     </td>
   </tr>
   <tr>
     <td colspan="2">
       <input type="checkbox" name="guest" ##guest## ##guest_disabled## value="1" helpId= "form_guest">
       %%guest%%
     </td>
   </tr>
   <tr>
     <td colspan="2">
       <input type="checkbox" name="login" ##login## value="1" helpId= "form_guest"##login_disabled##>
       %%login_full%%
     </td>
   </tr>
   ##IF(AMI_ALLOW_EFNSU)##
   <tr>
     <td colspan="2">
       <label><input type="checkbox" name="edit_front_allowed" value="1"##edit_front_allowed## />
       %%edit_front_allowed%%</label>
     </td>
   </tr>
   <tr><td colspan="2"><div class="tooltip">
   ##IF(allow_edit_at_front)##
   %%allow_edit_at_front_on%%
   ##ELSE##
   %%allow_edit_at_front_off%%
   ##ENDIF##
   </div></td></tr>
   ##ENDIF##
   <tr>
     <td>
        %%name%%*:
     </td>
     <td>
       <input type=text name=name class="field field50" value="##name##" maxlength="255"  helpId= "form_name" />
     </td>
   </tr>

		 <tr>
        <td colspan="2"><br><input type=checkbox name="add_to_list" value="1" ##add_to_list##>&nbsp;%%add_to_list%%</td>
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
   </table>
    ##form_common_hidden_fields##
 <input type="hidden" name="userId" value="##user_id##">
 <input type="hidden" name="group_ids" value="##group_ids##">

##filter_hidden_fields##
</form>