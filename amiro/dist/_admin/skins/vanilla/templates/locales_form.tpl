##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/locales.lng"%%

<script type="text/javascript">
var editor_enable = '##editor_enable##';
var _cms_document_form = 'frmLocales';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function formOnSubmit(oForm){
    if(oForm.lang){
        if(oForm.lang.value == '' || !oForm.lang.value.match(/^[a-zA-Z]/)){
            oForm.lang.focus();
            alert('%%warn_invalid_lang%%');
            oForm.lang.focus();
            return false;
        }
        if(oForm.name.value == '' || !oForm.name.value.match(/^[a-zA-Z0-9. ]/)){
            oForm.name.focus();
            alert('%%warn_invalid_name%%');
            oForm.name.focus();
            return false;
        }
    }
    if(oForm.default_title.value == ''){
        oForm.default_title.focus();
        alert('%%warn_missing_default_title%%');
        oForm.default_title.focus();
        return false;
    }
    if(oForm.dateformat_front.value == ''){
        oForm.dateformat_front.focus();
        alert('%%warn_missing_dateformat%%');
        oForm.dateformat_front.focus();
        return false;
    }
    if(oForm.dateformat_admin.value == ''){
        oForm.dateformat_admin.focus();
        alert('%%warn_missing_dateformat%%');
        oForm.dateformat_admin.focus();
        return false;
    }
    if(oForm.delete_data && oForm.delete_data.checked && !confirm('%%warn_data_deletion%%')){
        return false;
    }
    return true;
}

function OnObjectChanged_frmLocales(name, first_change, evt){
    if(name == 'installed'){
        var installed = document.getElementById('installed').checked;
        if(document.getElementById('div_delete_data')){
            document.getElementById('delete_data').checked = false;
            document.getElementById('div_delete_data').style.display = installed ? 'none' : 'inline';
        }
        document.getElementById('default').disabled = !installed;
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_frmLocales);

</script>

<br />
<form action="##script_link##" method="post" name="frmLocales" onsubmit="return formOnSubmit(this);">
##form_common_hidden_fields##
##filter_hidden_fields##
<table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
	<col width="150">
	<col width="*">
<tr>
    <td colspan="2">
        <input type="checkbox" name="installed" id="installed"##installed## value="1"##if(default||lang=='en')## disabled##endif## helpId="form_installed" />
        <label for="installed"##if(lang=='en')## title="%%system_locale%%"##endif##>%%installed%%</label>
##if(id&&(installed&&lang!=source_lang)&&!default)##
        <div style="display: none;" id="div_delete_data">
            <input type="checkbox" name="delete_data" id="delete_data" value="1" helpId="form_delete_data" />
            <label for="delete_data">%%delete_data%%</label>
            <div class="tooltip">%%delete_data_tooltip%%</div>
        </div>
##endif##
    </td>
</tr>
<tr>
    <td colspan="2">
        <input type="checkbox" name="default" id="default"##default## value="1"##if(default)## disabled##endif## helpId="form_default" />
        <label for="default">%%default%%</label>
    </td>
</tr>
<tr>
    <td>%%lang%%:&nbsp;</td>
    <td>##if(is_sys||id)####lang####else##<input type="text" name="lang" class="field field3" value="##lang##"  maxlength="3" />##endif##</td>
</tr>
##if(!id)##
<tr>
    <td colspan="2"><div class="tooltip">%%lang_tooltip%%</div></td>
</tr>
##endif##
<tr>
    <td>%%name%%*:&nbsp;</td>
    <td>##if(is_sys)####name####else##<input type="text" name="name" class="field field32" value="##name##"  maxlength="32" />##endif##</td>
</tr>
<tr>
    <td>%%default_title%%*:&nbsp;</td>
    <td><input type="text" name="default_title" class="field field50" value="##default_title##"  maxlength="255" /></td>
</tr>
<tr>
    <td>%%dateformat_front%%*:&nbsp;</td>
    <td><input type="text" name="dateformat_front" class="field field32" value="##dateformat_front##"  maxlength="32" /></td>
</tr>
<tr>
    <td>%%dateformat_admin%%*:&nbsp;</td>
    <td><input type="text" name="dateformat_admin" class="field field32" value="##dateformat_admin##"  maxlength="32" /></td>
</tr>
<tr>
    <td>%%default_country%%*:&nbsp;</td>
    <td><select name="default_country">##default_country##</select></td>
</tr>
<tr>
    <td>%%jquery_cdn%%:&nbsp;</td>
    <td><input type="text" name="jquery_cdn" class="field field50" value="##jquery_cdn##"  maxlength="64" /></td>
</tr>
<tr><td colspan="2" align="right"><br />##form_buttons##<br /><br /></td></tr>
<tr><td colspan="2"><sub>%%required_fields%%</sub></td></tr>
</table>

</form>
<script type="text/javascript">
OnObjectChanged_frmLocales('installed');
</script>