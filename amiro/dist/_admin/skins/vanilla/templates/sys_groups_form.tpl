%%include_language "templates/lang/sys_groups.lng"%%
%%include_template "templates/_icons.tpl"%%

<script type="text/javascript">
var editor_enable = '##editor_enable##';
var _cms_document_form = 'groupsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {

   editor_updateHiddenField("description");

   var errmsg = "";
   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   var inp = form.getElementsByTagName('input');
   var ma = form.moduleAccess;
   ma.value = '';
   for(var i=0; i<inp.length; i++) {
        if(inp[i].type!='hidden' || inp[i].name.substr(0,7)!='modacc_')
            continue;
        var modname = inp[i].name.substr(7);
        ma.value += modname+';'+inp[i].value+';';
        inp[i].disabled = true;
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
 ##--   <tr>
     <td colspan="2">
      <label><input type="checkbox" name="is_default" ##is_default## ##is_default_disabled## value="1" helpId="form_is_default">
       %%is_default%%</label>
     </td>
   </tr>--##
   <tr>
     <td colspan="2">
       <label><input type="checkbox" name="guest" ##guest## ##guest_disabled## value="1" helpId= "form_guest">
       %%guest_full%%</label>
     </td>
   </tr>
   <tr>
     <td colspan="2">
       <label><input type="checkbox" name="moderator" ##moderator## value="1" helpId= "form_moderator">
       %%moderator_full%%</label>
       <div class="tooltip">%%moderator_help%%</div>
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
     <td colspan="2">
       <label><input type="checkbox" name="login" ##login## value="1" helpId= "form_login"##login_disabled##>
       %%login_full%%</label>
     </td>
   </tr>
   <tr>
     <td>
        %%name%%*:
     </td>
     <td>
       <input type=text name=name class="field field50" value="##name##" maxlength="255"  helpId= "form_name" />
   </td>
   </tr>
   <tr>
     <td>
       %%users%%:
     </td>
     <td>
        <input type="hidden" name="user_ids" value="##user_ids##">
        <a href="javascript:void(0);" onClick="openExtDialog('%%users_add_list%%', 'sys_users_popup.php?groupId=##id##&user_ids='+document.groupsform.user_ids.value, 1, 1); return false;"><img title="%%users_add_list%%" class=icon src="skins/vanilla/icons/icon_small_users.gif" helpId="btn_users_add" align=absmiddle></a>
        <font style="font-size:9px">[%%number_users%%:<input name="num_users" type="text" value="##users##" readonly style="width: 20px;text-align: right; background-color: #FFFFFF;font-size:11px; BORDER: #FFFFFF 0px solid; ">]</font>
     </td>
   </tr>
   <tr>
     <td>
       %%modules%%:
     </td>
     <td>
     ##module_list##
     <input type="hidden" name="moduleAccess">
        <a href="javascript:void(0);" onClick="openExtDialog('%%modules_add_list%%', 'sys_modules_popup.php?groupId=##id##', 1, 1); return false;"><img title="%%modules_add_list%%" class=icon src="skins/vanilla/icons/icon-modules.gif" helpId="btn_modules_add" align=absmiddle></a>
        <font style="font-size:9px">[%%number_modules%%:<input name="num_modules" type="text" value="##modules##" readonly style="width: 20px;text-align: right; background-color: #FFFFFF;font-size:11px; BORDER: #FFFFFF 0px solid; ">]</font>
     </td>
   </tr>
   </table>
   <table cellspacing="5" cellpadding="0" border="0" class="frm" width="100%">
	<col width="150">
	<col width="*">
     <tr vAlign="top">
       <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-description">
              <textarea class="field" style="width:100%" rows="14" name="description" id="description">##description##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('description', cmD_STB, true);}
              </script>
            </div>
          </div>
        </div>
        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'description' : ['%%description%%', 'active', '', false],
          '':''});

        </script>

       </td>
     </tr>
     </table>
   <table cellspacing="5" cellpadding="0" border="0" width=100% class="frm">
	<col width="150">
	<col width="*">
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
 <!--<input type="hidden" name="activate" value="">
 <input type="hidden" name="activate2" value="">
 <input type="hidden" name="publish" value="">-->
 ##form_common_hidden_fields##

##filter_hidden_fields##
</form>