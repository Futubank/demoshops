%%include_language "templates/lang/modules_custom_fields.lng"%%

<!--#set var="select_option" value="<option value="##value##"##selected##>##caption##</option>"-->

<!--#set var="js_dataset" value="{id: ##id##, module: '##module##', caption: '##caption##'}"-->

<!--#set var="form_cancel_btn" value="<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:##if(source_id)##closeDialogWindow();##else##user_click('none','');##endif##" style="width: 100px;">
"-->

##--<!--#set var="reference_option" value="referencesArr[referencesArr.length] = new Array('##ftype##', '##value##', '##name##', '##selected##', '##field_id##');
"-->

<!--#set var="flag_item" value="showMoreFlags('##flag_selected##', '##flag_filter_selected##', '##flag_splitter_selected##', '##flag_capt##');
"-->
--##

<script type="text/javascript">
var editor_enable = '##editor_enable##';
var _cms_document_form = 'customFieldForm';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
var datasets = [##js_datasets##];
var ftypeSelectedIndex;
var ftypeChangeCalled = false;

function validateForm(oForm){
    if(oForm.system_name.value == ''){
        oForm.system_name.focus();
        alert('%%js_warn_missing_system_name%%');
        oForm.system_name.focus();
        return false;
    }
    if(!oForm.system_name.value.match(/^[a-z0-9\_]+$/gi)){
        oForm.system_name.focus();
        alert('%%js_warn_invalid_system_name%%');
        oForm.system_name.focus();
        return false;
    }
    if(oForm.name.value == ''){
        oForm.name.focus();
        alert('%%js_warn_missing_name%%');
        oForm.name.focus();
        return false;
    }
    if(oForm.default_caption.value == ''){
        oForm.default_caption.focus();
        alert('%%js_warn_missing_default_caption%%');
        oForm.default_caption.focus();
        return false;
    }
    editor_updateHiddenField('description');
##--if(source_id || popup)--##
##if(source_id)##
    var
        fieldId = parseInt('##id##'),
        found = false;

    for(var i in top.fieldsList.freeFields){
        if(top.fieldsList.freeFields[i][0] == fieldId){
            top.fieldsList.freeFields[i][1] = oForm.name.value;
            top.fieldsList.freeFields[i][2] = oForm.default_caption.value;
            found = true;
            break;
        }
    }
    for (var i = 1, q = top.fieldsList.realFieldsObj.rows.length; i < q; i++){
        if(top.fieldsList.realFieldsObj.rows[i].id.substr(11) == fieldId){
            top.fieldsList.realFieldsObj.rows[i].cells[0].innerHTML = oForm.name.value;
##--
            // it produces broken data on i.e. oForm.default_caption.value == деф '"\ кээ 234
            var elems = top.fieldsList.realFieldsObj.rows[i].cells[4].getElementsByTagName('input');
            elems[0].value = oForm.default_caption.value;
--##
            break;
        }
    }
##--
    if(!found && oForm.elements['datasets[]']){
        var sourceDatasetId = parseInt('##source_dataset_id##');
        for(var i in oForm.elements['datasets[]'].options){
            if(oForm.elements['datasets[]'].options[i].checked && oForm.elements['datasets[]'].options[i].value == sourceDatasetId){
                found = true;
                break;
            }
        }
    }
--##
    if(!found){
        if(!confirm('%%js_warn_popup_other_dataset%%')){
            return false;
        }
    }
##endif##
    return true;
}

##if(source_dataset_id)##
if(top.document.forms.datasetForm){
    top.document.forms.datasetForm.alert.value = 1;
}
##endif##

top.amiPopupOnClose = function(){
   if(top.document.forms.datasetForm && parseInt(top.document.forms.datasetForm.alert.value)){
        alert('%%js_popup_from_dataset%%');
   }
}

function OnObjectChanged_modules_custom_fields_form(name, firstChange, evt){
    var oForm = document.getElementById(_cms_document_form);
    switch(name){
        case 'module_name':
            if(oForm.elements['datasets[]']){
                var
                    moduleName = oForm.module_name.value,
                    options = oForm.elements['datasets[]'].options,
                    oOption, re = /^inst_/;

                for(var i = 0, q = options.length; i < q; i++){
                    options[0] = null;
                }
                for(var i = 0; i < datasets.length; i++){
                    if(datasets[i].module == moduleName){
                        oOption = document.createElement('option');
                        oOption.value = datasets[i].id;
                        oOption.text = datasets[i].caption;
##if(!id)##
                        if(datasets[i].id == ##filtered_dataset_id##){
                            oOption.selected = true;
                        }
##endif##
                        options.add(oOption);
                    }
                }
                options = null;
                options = oForm.elements['show_body_type[]'].options;
                if(re.test(moduleName)){
                    if('undefined' == typeof(options[3])){
                        oOption = document.createElement('option');
                        oOption.value = 'body_small';
                        oOption.text  = '%%body_type_body_small%%';
                        options.add(oOption);
                        $('#show_body_type').trigger('chosen:updated');
                    }
                }else{
                    if('undefined' != typeof(options[3])){
                        $("#show_body_type option[value='body_small']").remove();
                        $('#show_body_type').trigger('chosen:updated');
                    }
                }
                options = null;
            }
            break; // case 'module_name'
        case 'ftype':
##if(id)##
            if(ftypeChangeCalled && !confirm('%%js_on_ftype_change%%')){
                return false;
            }
            ftypeChangeCalled = true;
##endif##
            var show = oForm.ftype.value == 'char';
            document.getElementById('tr_admin_ui').style.display = show ? tableRowShowStyle : 'none';
##--            document.getElementById('td_admin_ui1').style.borderBottom = show ? 'none' : '1px solid #000';
            document.getElementById('td_admin_ui2').style.borderBottom = show ? 'none' : '1px solid #000';--##
            if(!show){
                oForm.admin_ui.value = 'text';
            }
            break; // case 'ftype'
    }
    oForm = null;

    return true;
}
addFormChangedHandler(OnObjectChanged_modules_custom_fields_form);
</script>

<br />
<form action="##script_link##" method="post" enctype="multipart/form-data" id="customFieldForm" name="customFieldForm" onSubmit="return validateForm(this);">
<input type="hidden" name="publish" value="" />
<input type="hidden" name="flags_number" value="" />
##form_common_hidden_fields##
##filter_hidden_fields##
<table cellpadding="0" cellspacing="0" border="0" class="frm frm1" width="100%">
##if(source_dataset_id)##
<tr><td colspan="2"><div class="tooltip" style="margin-bottom: 5px;">%%tooltip_popup_mode%%</div></td></tr>
##endif##
<tr>
    <td><input type="checkbox" id="id_public" name="public" value="1"##public## />
    &nbsp;<label for="id_public">%%public%%</label></td>
</tr>
<tr>
    <td>%%system_name%%*: </td>
    <td><input type="text" name="system_name" class="field field40" value="##system_name##" ##system_name_readonly## /></td>
</tr>
<tr>
    <td>%%module_name%%*: </td>
    <td><select name="module_name"##module_name_readonly##>##module_name_list##</select></td>
</tr>
<tr>
    <td></td>
    <td><div class="tooltip" style="margin-bottom: 5px;">%%tooltip_system_name_module_name%%</div></td>
</tr>
<tr>
    <td>%%name%%*: </td>
    <td><input type="text" name="name" class="field field40" value="##name##"  /></td>
</tr>
<tr>
    <td>%%default_caption%%*: </td>
    <td><input type="text" name="default_caption" class="field field40" value="##default_caption##"  /></td>
</tr>
<tr>
    <td>%%prefix%%: </td>
    <td><input type="text" name="prefix" class="field field40" value="##prefix##"  /></td>
</tr>
<tr>
    <td>%%postfix%%: </td>
    <td><input type="text" name="postfix" class="field field40" value="##postfix##"  /></td>
</tr>
<tr>
    <td>%%ftype%%: </td>
    <td>
        <select name="ftype"##-- onChange="onChageSomeType(1, 0)"--##>
            <option value="char"##ftype_char##>%%ftype_char%%</option>
            <option value="int"##ftype_int##>%%ftype_int%%</option>
            <option value="float"##ftype_float##>%%ftype_float%%</option>
##--            <option value="date"##ftype_date##>%%ftype_date%%</option>
            <option value="picture"##ftype_picture##>%%ftype_picture%%</option>
            <option value="flagmap"##ftype_flagmap##>%%ftype_flagmap%%</option>--##
        </select>##--<span id="is_link_div"><input type=checkbox name=is_link id=id_is_link ##is_link##><label for="id_is_link"> %%is_link%%</label></span>--##
    </td>
</tr>
<tr>
    <td>%%show_body_type%%: </td>
    <td>
        <select id="show_body_type" name="show_body_type[]" multiple="true" size="4">
##--            <option value="body_search" ##show_body_type_body_search##>%%body_type_body_search%%</option>--##
            <option value="body_items"##show_body_type_body_items##>%%body_type_body_items%%</option>
            <option value="body_urgent_items"##show_body_type_body_urgent_items##>%%body_type_body_urgent_items%%</option>
            <option value="body_itemD"##show_body_type_body_itemD##>%%body_type_body_itemD%%</option>
            <option value="body_small"##show_body_type_body_small##>%%body_type_body_small%%</option>
        </select>
    </td>
</tr>

##--
<tr>
    <td style="border: 1px solid #000; border-bottom: none; padding: 0; padding: 5px;"><b>%%admin_interface%%</b></td>
</tr>
<tr>
    <td style="padding: 5px; border-left: 1px solid #000;">%%show_in_admin_form%%: </td>
    <td style="padding: 5px 5px 5px 0px; border-top: 1px solid #000; border-right: 1px solid #000;"><select name="admin_form">##admin_form##</select></td>
</tr>
<tr id="tr_admin_ui" style="display: none;">
    <td style="padding: 5px; border-left: 1px solid #000;">%%admin_ui%%: </td>
    <td style="padding: 5px 5px 5px 0px; border-right: 1px solid #000;"><select name="admin_ui">##admin_ui##</select></td>
</tr>
<tr>
    <td style="padding: 5px; border-left: 1px solid #000; border-bottom: 1px solid #000;"><label for="id_show_in_admin_filter">%%show_in_admin_filter%%</label>: </td>
    <td style="padding: 5px 5px 5px 0px; border-bottom: 1px solid #000; border-right: 1px solid #000;"><input type="checkbox" id="id_admin_filter" name="admin_filter" value="1"##admin_filter## /></td>
</tr>

--##


<tr>
    <td><label for="id_isnot_all">%%isnot_all%%</label>: </td>
    <td><input type="checkbox" id="id_isnot_all" name="isnot_all" value="1" ##isnot_all## /></td>
</tr>
<tr>
    <td></td>
    <td><div class="tooltip">%%isnot_all_desc%%</div><br /></td>
</tr>
##if(!source_id && datasets)##
<tr>
    <td>%%datasets%%: </td>
    <td><select name="datasets[]" multiple="true" size="3" onfocus="this.size = Math.max(this.options.length, 3);" onblur="this.size = 3;">##datasets##</select></td>
</tr>
##endif##
##if(!source_id)##
<tr>
    <td></td>
    <td><div class="tooltip">%%datasets_desc%%</div><br /></td>
</tr>
##endif##
</table>

<table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
<tr valign="top">
    <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-description">
              <textarea class="field" style="width:100%" rows="14" name=description id="description">##description##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('description', cmD_STB , false);}
              </script>
            </div>
            <div class="tab-page" id="tab-page-admin_ui">
            <table cellpadding="0" cellspacing="5" border="0" width= class="frm frm1">
              <tr>
                  <td><input type="checkbox" id="id_admin_filter" name="admin_filter" value="1"##admin_filter## />
                  &nbsp;<label for="id_admin_filter">%%show_in_admin_filter%%</label>
                  </td>
              </tr>
              <tr>
                  <td##-- id="td_admin_ui1"--##>%%show_in_admin_form%%: </td>
                  <td##-- id="td_admin_ui2"--##><select name="admin_form">##admin_form##</select></td>
              </tr>
              <tr id="tr_admin_ui" style="display: none;">
                  <td>%%admin_ui%%: </td>
                  <td><select name="admin_ui">##admin_ui##</select></td>
              </tr>
              </table>
            </div>


          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'description' : ['%%description%%', 'active', '%%description_help%%', false],
              'admin_ui' : ['%%admin_interface%%', 'normal', '', false],


          '':''});

        </script>
    </td>
</tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
	<col width="150">
	<col width="*">
<tr>
    <td colspan="2" align="right"><br />##form_buttons##<br /><br /></td>
</tr>
<tr>
    <td colspan="2"><sub>%%required_fields%%</sub></td>
</tr>
</table>
</form>

<script type="text/javascript">
##if(!id)##
OnObjectChanged_modules_custom_fields_form('module_name');
##endif##
ftypeSelectedIndex = OnObjectChanged_modules_custom_fields_form('ftype');
</script>
