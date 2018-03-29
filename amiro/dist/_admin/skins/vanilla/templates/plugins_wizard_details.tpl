%%include_template "templates/_common_form_fields.tpl"%%
%%include_language "templates/lang/plugins_wizard.lng"%%

<!--#set var="header_row" value="
<tr><td>##language##</td><td><input type=text class=field name="header_##lang##" value="##value##"></td></tr>
"-->

<!--#set var="install_as_row" value="<option value="##name##" ##selected##>##name##"-->

<!--#set var="available_yes" value="%%yes%%"-->
<!--#set var="available_no" value="<font color="red"><b>%%no%%</b></font>"-->

<!--#set var="files_row" value="
        <tr class="##class##">
	  <td>##header##</td>
	  <td>##files##</td>
	  <td align="center">##available##</td>
	</tr>
"-->

<div id="deprecated_functionality" class="status-block">
<div class="status-msgs">
<div class="status-red">
%%obsolete_functionality%%
</div>
</div>
</div>

<script type="text/javascript">
<!--
AMI.$('#filter-box').before(AMI.$('#deprecated_functionality').detach());
var editor_enable = '##editor_enable##';
var _cms_document_form = 'pluginsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {
    if (form.install_as.value=="") {
        return focusedAlert(form.install_as, '%%install_as_warn%%');
    }

    return true;
}

function OnObjectChanged_plugins_wizard(sObjectName, bChangedFirst, evt)
{
    errFunc = OnObjectChanged_plugins_wizard;

    if (sObjectName != 'copy_files') {
        return true;
    }
    var oForm = document.forms[_cms_document_form];
    oForm.overwrite.disabled = !oForm.copy_files.checked;
    if(oForm.copy_files.checked) {
        alert('%%copy_files_warn%%');
    }

    return true;
}
addFormChangedHandler(OnObjectChanged_plugins_wizard);

</script>


  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="pluginsform" onSubmit="return CheckForm(window.document.pluginsform);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type="hidden" name="step" value="2">
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
  <tr>
    <td>%%header%%:</td>
    <td>##header##</td>
  </tr>
  <tr>
    <td>%%plugin_id%%:</td>
    <td>##plugin_id##</td>
  </tr>
  <tr>
    <td>%%version%%:</td>
    <td>##version##</td>
  </tr>
  <tr>
    <td valign="top">%%admin_header%%*:</td>
    <td>
      <table border="0" cellspacing="0" cellpadding="4">
        ##headers##
      </table>
    </td>
  </tr>
  <tr>
    <td>%%work_modes%%:</td>
    <td>##if(work_mode_error==1)## <font color="red"><b>##work_modes_text##</b></font> ##else## ##work_modes_text## ##endif##</td>
  </tr>
##if(description)##
  <tr>
    <td valign="top">%%description%%:</td>
    <td><div class="tooltip" style="margin-top: 0;">##description##</div></td>
  </tr>
##endif##
  <tr>
    <td>%%author%%:</td>
    <td>##author##</td>
  </tr>
  <tr>
    <td>%%install_as%%:</td>
    <td>
      <select name="install_as">
        <option value=''>%%select_module%%
        ##install_as_rows##
      </select>
    </td>
  </tr>
##if(IS_INSTALL)##
##if(copy_allowed)##
  <tr>
    <td>%%copy_files%%:</td>
    <td><input type="checkbox" name="copy_files" value="1"></td>
  </tr>
  <tr>
    <td>%%overwrite%%:</td>
    <td><input type="checkbox" name="overwrite" value="1" disabled></td>
  </tr>
##endif##
  <tr>
    <td valign="top">%%files%%:</td>
    <td>
      <table border="0" cellspacing="0" cellpadding="4">
        <tr>
          <td class="first_row_left_td" width="200">%%file_type%%</td>
          <td class="first_row_all" width="100">%%file_name%%</td>
          <td class="first_row_all" width="50">%%availability%%</td>
        </tr>
	##files_rows##
      </table>
    </td>
  </tr>
##endif##
     <tr>
       <td colspan="2" align="right">
         <input type="submit" name="check" value="%%install_btn%%" class="but" onClick="this.form.action.value='##if(IS_INSTALL)##install##else##apply##endif##';">
         <input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
       </td>
     </tr>
     </table>

    </form>
