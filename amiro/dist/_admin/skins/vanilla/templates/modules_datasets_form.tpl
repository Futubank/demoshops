%%include_language "templates/lang/modules_datasets.lng"%%

##--
<div style="border: 1px solid red; padding: 10px; margin: 10px;">
@todo:
<ol>
    <li>В ami.customfields.js сделать многократную попытку загрузки и нотификации о неудачах</li>
</ol>
</div>
--##

<!--#set var="select_option" value="<option value="##value##"##selected##>##caption##</option>"-->

<!--#set var="js_module_usage_type" value="##module##: '##usage_type##'"-->

<!--#set var="free_field" value="['##id##', '##name##', '##caption##', '##is_used##', '##is_shared##', '##is_unique##', '##need_caption##', 0, '##is_filter##']"-->

<!--#set var="init_fields" value="fieldsList.insertFieldRow('##id##');
"-->

<script type="text/javascript">
var editor_enable = '##editor_enable##';
var _cms_document_form = 'datasetForm';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
var moduleUsageTypes = {##js_module_usage_types##};
var ajaxCustomFields = new amiCustomFields(new amiDictionary({'cannot_load_custom_fields': '%%js_cannot_load_custom_fields%%'}));
var moduleNameIndex = 0, newModuleNameIndex = 0;

function validateForm(form){
    if(form.module_name.value == ''){
        form.module_name.focus();
        alert('%%js_warn_module_name%%');
        form.module_name.focus();
        return false;
    }
    if(form.name.value == ''){
        form.name.focus();
        alert('%%name_warn%%');
        form.name.focus();
        return false;
    }
    if(form.postfix.value == ''){
        form.postfix.focus();
        alert('%%postfix_warn%%');
        form.postfix.focus();
        return false;
    }
    _cms_document_form_changed = false;
    return true;
}

var selectedItemId = 0;

function fieldsList(){
    this.oForm = document.datasetForm;
    this.freeFields = [##free_fields##];
    this.hcFields = [##hc_fields##];
    this.realFieldsObj = document.getElementById('realFields');
    this.rowNumber = 1;

    this.init = function(){
        this.freeFields = this.freeFields.concat(this.hcFields);
    }

    this.fillFreeFields = function(){
        var ff = this.oForm.free_fields;

        // remove all options
        for(i = ff.options.length; i > 0; i--){
            ff.options[ff.options.length - 1] = null;
        }
        // add options
        for(i = 0; i < this.freeFields.length; i++){
            if(this.freeFields[i][3] != '1'){
                ff.options[ff.options.length] = new Option(this.freeFields[i][1], this.freeFields[i][0]);
            }
        }
        // hide the fields if required
        this.watchFreeFieldsDiv();
    }

    this.moveField = function(evt, oImage, fieldId){
        var mousePos = amiCommon.getMousePosition(evt);
        var elementPos = amiCommon.getElementPosition(oImage);
        elementHalfX = oImage.offsetWidth / 2;
        elementHalfY = oImage.offsetHeight / 2;
        isOneStep = (mousePos[0] > elementPos[0] + elementHalfX);
        isUp = (mousePos[1] < elementPos[1] + elementHalfY);
        isUp ? this.moveFieldUp(fieldId, !isOneStep) : this.moveFieldDown(fieldId, !isOneStep);
    }

    this.moveFieldUp = function(curId, isTop){
        if(curId != ''){
            for(i = 1; i < this.realFieldsObj.rows.length; i++){
                if('realFields_' + curId == this.realFieldsObj.rows[i].getAttribute('id')){
                    if(i > 1){
                        lastElem = isTop ? 2 : i;
                        for(j = i; j >= lastElem; j--){
                            crossSwapNodes(this.realFieldsObj.rows[j-1], this.realFieldsObj.rows[j]);
                        }
                        this.updateFieldMap();
                    }
                    break;
                }
            }
        }
    }

    this.moveFieldDown = function(curId, isBottom){
        if(curId != ''){
            for(i = 1; i < this.realFieldsObj.rows.length; i++){
                if("realFields_"+curId == this.realFieldsObj.rows[i].getAttribute("id")){
                    if(i < this.realFieldsObj.rows.length-1){
                        lastElem = isBottom ? this.realFieldsObj.rows.length-2 : i;
                        for(j = i; j <= lastElem; j++){
                            crossSwapNodes(this.realFieldsObj.rows[j], this.realFieldsObj.rows[j + 1]);
                        }
                        this.updateFieldMap();
                    }
                    break;
                }
            }
        }
    }

    this.deleteField = function(curId, skipConfirmation){
        if(curId != ''){
            if(this.oForm.initial_shared.value.indexOf(';'+curId+';') >= 0){
                if(!confirm('%%remove_shared%%')) {
                    return;
                }
            }
            for(i = 1; i < this.realFieldsObj.rows.length; i++){
                if('realFields_' + curId == this.realFieldsObj.rows[i].getAttribute('id')){
                    this.freeFields[this.realFieldsObj.rows[i].getAttribute('arrayid')][3] = '0';
                    this.realFieldsObj.rows[i].parentNode.removeChild(this.realFieldsObj.rows[i]);
                    this.rowNumber--;
                    this.fillFreeFields();
                    this.updateFieldMap();
                    break;
                }
            }
        }
    }

    this.deleteAllFields = function(){
        while(this.realFieldsObj.rows.length > 1 && this.realFieldsObj.rows[1].getAttribute('id').indexOf('realFields_') == 0){
            this.realFieldsObj.rows[1].parentNode.removeChild(this.realFieldsObj.rows[1]);
            this.rowNumber--;
        }
        this.fillFreeFields();
        this.updateFieldMap();
    }

    this.insertFieldRow = function(fieldId){
        for(i = 0; i < this.freeFields.length; i++){
            if(this.freeFields[i][0] == fieldId){
                if(this.freeFields[i][3] != '1'){
                    realfieldId = fieldId;
                    if(this.freeFields[i][5] == '1'){
                        this.freeFields[i][3] = '1';
                    }else{
                        this.freeFields[i][7] += 1;
                        fieldId = fieldId + '_' + this.freeFields[i][7];
                    }
                    oRow = this.realFieldsObj.insertRow(this.rowNumber++);
                    oRow.setAttribute('id', 'realFields_' + fieldId);
                    oRow.setAttribute('clearid', fieldId);
                    oRow.setAttribute('arrayid', i);
                    oCell = oRow.insertCell(0);
                    oCell.innerHTML = this.freeFields[i][1];
                    oCell = oRow.insertCell(1);
                    if(realfieldId < 100000){
                        oCell.innerHTML = '<input type="checkbox" name="shared_' + fieldId + '" value="1" id="chkshared_' + fieldId + '"' + (this.freeFields[i][4] == '1' ? ' checked' : '') + ' />';
                    }else{
                        oCell.innerHTML = '<input type="checkbox" name="shared_' + fieldId + '" value="1" disabled id="chkshared_' + fieldId + '" checked />';
                    }
                    oCell.setAttribute('align', 'center');
##--
                    oCell = oRow.insertCell(2);
                    if(realfieldId < 100000){
                        oCell.innerHTML = '<input type="checkbox" name="filter_' + fieldId + '" value="1" id="chkfilter_' + fieldId + '"' + (this.freeFields[i][8] == '1' ? ' checked' : '') + ' />';
                    }else{
                        oCell.innerHTML = '<input type="checkbox" name="filter_' + fieldId + '" value="1" disabled id="chkfilter_' + fieldId + '" checked />';
                    }
                    oCell.setAttribute('align', 'center');
--##
                    oCell = oRow.insertCell(2);##-- 3 --##
                    oCell.innerHTML = '<img src="skins/vanilla/icons/icon-pos_control.gif" width="19" height="19" border="0" onmouseover="this.style.cursor = \'pointer\';" onmouseout="this.style.cursor = \'default\';" onclick="fieldsList.moveField(event, this, \'' + fieldId + '\')" />';
                    oCell = oRow.insertCell(3);##-- 4 --##
                    if(this.freeFields[i][6] == '1'){
                        oCell.innerHTML = '<input type="text" name="caption_' + fieldId + '" value="' + this.freeFields[i][2] + '" class="field" />';
                    }else{
                        oCell.innerHTML = '&nbsp;';
                    }
                    oCell = oRow.insertCell(4);##-- 5 --##
                    oCell.innerHTML =
                        '<nobr><a href="javascript:;" onclick="fieldsList.deleteField(\'' + fieldId + '\');return false;"><img src="skins/vanilla/icons/icon-del.gif" border="0" /></a> ' +
                        (realfieldId < 100000
                            ? '<a href="javascript:;" onClick="openExtDialog(\'%%popup_title_edit%%\', \'modules_custom_fields.php?mode=popup&src_id=' + realfieldId + '&module=' + document.datasetForm.module_name.value + '&id=' + realfieldId + '&action=edit#anchor\', 1);return false;"><img src="skins/vanilla/icons/icon-edit.gif" border="0" /></a></nobr>'
                            : ''
                        );
                    this.fillFreeFields();
                    this.updateFieldMap();
                }
                break;
            }
        }
    }

    this.updateFieldMap = function(){
        this.oForm.fields_map.value = '';
        for(var i = 1, q = this.realFieldsObj.rows.length; i < q; i++){
            this.oForm.fields_map.value += (this.oForm.fields_map.value == '' ? '' : ';') + this.realFieldsObj.rows[i].getAttribute('clearid');
        }
        this.watchRealFieldsDiv();
    }

    this.watchFreeFieldsDiv = function(){
        document.getElementById('free_fields_div').style.display = this.oForm.free_fields.options.length <= 0 ? 'none' : 'inline';
    }

    this.watchRealFieldsDiv = function(){
        if(this.oForm.fields_map.value == ''){
            document.getElementById('tr_fields').style.display = this.oForm.free_fields.options.length > 0 ? tableRowShowStyle : 'none';
            document.getElementById('realFields').style.display = 'none';
            document.getElementById('realFieldsDesc').style.display = 'none';
        }else{
            document.getElementById('tr_fields').style.display = tableRowShowStyle;
            document.getElementById('realFields').style.display = 'block';
            document.getElementById('realFieldsDesc').style.display = 'block';
        }
    }
}

function OnObjectChanged_modules_datasets_form(name, firstChange, evt, skipAjax){
    var oForm = document.datasetForm;
    firstChange = typeof(firstChange) != 'undefined' && firstChange;

    if(name.indexOf('shared_') == 0){
        if(oForm.initial_shared.value.indexOf(';' + name.substr(7) + ';') >= 0){
            eval('chkObj = document.datasetForm.' + name);
            if(chkObj && !chkObj.checked){
                alert('%%uncheck_shared%%');
            }
        }
    }else if(name == 'module_name'){
        if(typeof(skipAjax) == 'undefined' && moduleNameIndex != 0 && oForm.fields_map.value != '' && !confirm('%%js_confirm_change_module%%')){
            oForm.module_name.selectedIndex = moduleNameIndex;
            oForm = null;
            return false;
        }
        var
            moduleName = oForm.module_name.value,
            activeType = moduleUsageTypes[moduleName],
            usageTypes = ['simple', 'categories', 'pages'];

        for(var i = 0, q = usageTypes.length; i < q; i++){
            var hide = activeType != usageTypes[i];
            document.getElementById('tr_module_usage_' + usageTypes[i]).style.display = hide ? 'none' : tableRowShowStyle;
            if(!hide && !firstChange){
                document.getElementById('id_module_usage_' + usageTypes[i]).disabled = hide;
            }
        }
        if(typeof(skipAjax) == 'undefined' && moduleName != ''){
            document.getElementById('tr_fields').style.display = tableRowShowStyle;
            oForm.module_name.disabled = true;
            newModuleNameIndex = oForm.module_name.selectedIndex;
            oForm.module_name.selectedIndex = moduleNameIndex;
///            oForm.module_name.options[0].disabled = true;
            ajaxCustomFields.loadFields(moduleName, firstChange);
            return false;
        }
        moduleNameIndex = oForm.module_name.selectedIndex;
    }
    oForm = null;
    return true;
}
addFormChangedHandler(OnObjectChanged_modules_datasets_form);
</script>

<br />
<form action=##script_link## method="post" enctype="multipart/form-data" name="datasetForm" onSubmit="return validateForm(this);">
<input type="hidden" name="publish" value="" />
<input type="hidden" name="fields_map" value="" />
<input type="hidden" name="initial_shared" value="##initial_shared##" />
##form_common_hidden_fields##
##filter_hidden_fields##
<table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
<tr>
    <td>%%module_name%%*: </td>
    <td><select name="module_name"##module_name_readonly##>##module_name_list##</select></td>
</tr>
<tr>
    <td></td>
    <td><div class="tooltip" style="margin-bottom: 5px;">%%tooltip_module_name%%</div></td>
</tr>
<tr id="tr_module_usage_simple" style="display: none;">
    <td><label for="id_module_usage_simple">%%module_usage_simple%%</label>: </td>
    <td><input type="checkbox" id="id_module_usage_simple" name="module_usage_simple" value="1"##used_simple## /></td>
</tr>
<tr id="tr_module_usage_categories" style="display: none;">
    <td valign="top">%%module_usage_categories%%: </td>
    <td>
        <select##if(!module_usage_categories)## style="display: none;"##endif## id="id_module_usage_categories" name="module_usage_categories[]" multiple="true" size="3" onfocus="this.size = Math.max(this.options.length, 3);" onblur="this.size = 3;">##module_usage_categories##</select>
        <a href="javascript:;" onClick="##if(id)##openExtDialog('%%module_usage_categories_list%% &quot;##js_name##&quot;', 'modules_datasets.php?dataset_id=##id##&mode=categories&module_name=' + document.datasetForm.module_name.value, 1);##else##alert('%%warn_apply_item%%');##endif##return false;"><img title="%%module_usage_edit_list%%" class="icon" src="skins/vanilla/icons/icon-dicget-many.gif" helpid="btn_module_usage_pages" align="absmiddle" /></a>
        [%%categories_counter%%:<input name="categories_counter" type="text" value="##categories_counter##" readonly class="counter">]</font>
    </td>
</tr>
<tr id="tr_module_usage_pages" style="display: none;">
    <td valign="top">%%module_usage_pages%%: </td>
    <td>
        <select##if(!module_usage_pages)## style="display: none;"##endif## id="id_module_usage_pages" name="module_usage_pages[]" multiple="true" size="3" onfocus="this.size = Math.max(this.options.length, 3);" onblur="this.size = 3;">##module_usage_pages##</select>
        <a href="javascript:;" onClick="##if(id)##openExtDialog('%%module_usage_pages_list%% &quot;##js_name##&quot;', 'modules_datasets.php?dataset_id=##id##&mode=pages&module_name=' + document.datasetForm.module_name.value, 1);##else##alert('%%warn_apply_item%%');##endif##return false;"><img title="%%module_usage_edit_list%%" class="icon" src="skins/vanilla/icons/icon-dicget-many.gif" helpid="btn_module_usage_pages" align="absmiddle" /></a>
        [%%pages_counter%%:<input name="pages_counter" type="text" value="##pages_counter##" readonly class="counter">]</font>
    </td>
</tr>
<tr>
    <td>%%name%%*: </td>
    <td><input type="text" name="name" class="field field40" value="##name##"  maxlength="64" /></td>
</tr>
<tr>
    <td>%%postfix%%*: </td>
    <td><input type="text" name="postfix" class="field field40" value="##postfix##"  maxlength="16" /></td>
</tr>
<tr id="tr_fields" style="display: none; vertical-align: top;">
    <td>%%fields%%: </td>
    <td>
        <div class="tooltip" id="realFieldsDesc">%%dataset_desc%%</div>
        <table border="0" id="realFields" class="frm">
        <tr>
            <td><br /><nobr>%%fields_name%%<br />&nbsp;</nobr></td><td><br /><nobr>&nbsp;%%fields_shared%%&nbsp;<br />&nbsp;</nobr></td>##--<td><br /><nobr>&nbsp;%%fields_filter%%&nbsp;<br />&nbsp;</nobr></td>--##<td></td><td><br /><nobr>%%fields_caption%%<br />&nbsp;</nobr></td>
            <td></td>
        </tr>
        </table>
        <div id="free_fields_div" style="display:none">
            <select name="free_fields"></select>
            <input type="button" value="%%button_add%%" class="but" onClick="fieldsList.insertFieldRow(document.datasetForm.free_fields.value)" />
        </div>
    </td>
</tr>
<tr>
    <td></td>
    <td>
        <br /><br />
        <input type="button" value="%%button_edit_fields%%" class="but-long" onClick="if(confirm('%%js_popup_mode%%')){openExtDialog('%%popup_title_add%%', 'modules_custom_fields.php?mode=popup&flt_module_name=' + document.datasetForm.module_name.value + '&module=' + document.datasetForm.module_name.value + '&src_dataset_id=##if(id)####id##&flt_dataset_id=##id####else##-1##endif##', 1);}return false;" onfucus="if(parseInt(this.form.alert.value)){alert(1);}" />
        <input type="hidden" name="alert" value="0" disabled="disabled" />
    </td>
</tr>
</table>
<table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
<tr>
    <td colspan="2" align="right"><br/>##form_buttons##<br /><br /></td>
</tr>
<tr>
    <td colspan="2"><sub>%%required_fields%%</sub></td>
</tr>
</table>
##endif##
</form>

<script type="text/javascript">
var fieldsList = new fieldsList();
fieldsList.init();
ajaxCustomFields.oSourceObject = fieldsList;
fieldsList.fillFreeFields();
##if(id)##
##init_fields##
fieldsList.updateFieldMap();
##--else##
OnObjectChanged_modules_datasets_form('module_name', true);--##
##endif##
OnObjectChanged_modules_datasets_form('module_name', true, null, true);
</script>