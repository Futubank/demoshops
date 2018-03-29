##--!ver=0200 rules="-SETVAR|+DEBUG"--##
%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/srv_options.lng"%%

<!--#set var="view_mode_style" value=" style="cursor: default; border-bottom: none; font-weight: bold;""-->
<!--#set var="view_mode_icon" value="<img src="skins/vanilla/images/extensions/ext_adv_audit.gif" width="16" hiight="16" alt="" title="%%view_mode_0%%" />"-->

<!--#set var="js_new_array" value="[##array##]"-->
<!--#set var="js_new_array_s" value="['##array##']"-->

<!--#set var="inheritance_scripts_short" value="

var
    optionsParents = [##optionsParents##],
    optionsParentsCaptions = [##optionsParentsCaptions##],
    optionsParentsChildren = [##optionsParentsChildren##];
"-->

<!--#set var="inheritance_scripts" value="
var
    optionsParents = [##optionsParents##],
    optionsParentsCaptions = [##optionsParentsCaptions##],
    optionsParentsChildren = [##optionsParentsChildren##],
    inheritableOptions = [##inheritableOptions##],
    inheritableOptionsParentModules = [##inheritableOptionsParentModules##],
    inheritableOptionsParentModulesCaptions = [##inheritableOptionsParentModulesCaptions##],
    parentOptions = [##parentOptions##],
    parentOptionsCaptions = [##parentOptionsCaptions##],
    parentOptionsValues = [##parentOptionsValues##],
    selectedParentModules = [##selectedParentModules##],
    selectedParentOptions = [##selectedParentOptions##];

function getOptionValueObject(inheritedOptionName){
    var optionValueName = typeof(document.getElementById('option_edit_' + inheritedOptionName).valueNameForInheritance) == 'undefined' ? 'option_value_' + inheritedOptionName : document.getElementById('option_edit_' + inheritedOptionName).valueNameForInheritance;
    var optionValueNameArray = optionValueName + '[]';
    var elems = document.getElementById('option_edit_' + inheritedOptionName).getElementsByTagName('*');
    for(var i = 0; i < elems.length; i++){
        if(elems[i].name == optionValueName || elems[i].name == optionValueNameArray){
            var obj = elems[i];
            elems = null;
            return obj;
        }
    }
}

function buildInheritedOptionsForms(inheritedOptionName){
    errFunc = buildInheritedOptionsForms;

    if (typeof(_cms_group_operations_form) == 'undefined' || typeof(document.forms[_cms_group_operations_form]) == 'undefined') {
        return true;
    }
    var oForm = document.forms[_cms_group_operations_form];
    var buildModulesSelector = typeof(inheritedOptionName) == 'undefined';
    var options = buildModulesSelector ? inheritableOptions : [inheritedOptionName];
    for (var index = 0, qty = options.length ; index < qty ; index++) {
        var realIndex = inheritableOptions.indexOf(options[index]);
        var prevSelectedParentModule = selectedParentModules[realIndex];
        if (typeof(oForm.elements['parent_module_name_' + options[index]]) == 'undefined') {
            continue;
        }
        var oSelect = oForm.elements['parent_module_name_' + options[index]];
        var oSelectIndex = oSelect.options.length;
        if (buildModulesSelector) {
            var oOption = document.createElement('OPTION');
            oOption.text = '%%dont_inherit%%';
            oOption.value = '';
            oOption.oldSelected = selectedParentModules[realIndex] == '';
            oSelect.options[oSelect.options.length] = oOption;
        } else {
            selectedParentModules[realIndex] = oSelect.value;
        }
        var selectedModuleIndex = -1;
        var entities = inheritableOptionsParentModules[realIndex];
        var entitiesCaptions = inheritableOptionsParentModulesCaptions[realIndex];
        for (var i = 0, q = entities.length ; i < q ; i++) {
            if (buildModulesSelector) {
                var oOption = document.createElement('OPTION');
                oOption.text = entitiesCaptions[i];
                oOption.value = entities[i];
                oOption.oldSelected = selectedParentModules[realIndex] == entities[i];
                oSelect.options[oSelect.options.length] = oOption;
            }
            if (selectedParentModules[realIndex] == entities[i]) {
                if (buildModulesSelector) {
                    oSelect.selectedIndex = i + 1;
                    selectedModuleIndex = i;
                } else if (oSelect.selectedIndex > 0) {
                    selectedModuleIndex = i;
                }
            }
        }
        var oSelect = oForm.elements['parent_option_name_' + options[index]];
        for (var i = 0, q = oSelect.options.length ; i < q ; i++) {
            oSelect.options[0] = null;
        }
        var bValueDisabled = selectedModuleIndex >= 0;
        var prevValue;
        if (inheritedOptionName) {
            oSelect.disabled = !bValueDisabled;
            document.getElementById('parent_option_name_row_' + inheritedOptionName).style.display = bValueDisabled ? tableRowShowStyle : 'none';
            document.getElementById('icon_inherited_' + inheritedOptionName).style.display = bValueDisabled ? 'inline' : 'none';
            var oValue = getOptionValueObject(inheritedOptionName);
            oValue.disabled = bValueDisabled;
            if (bValueDisabled) {
                var valueIndex = parentOptions[realIndex][selectedModuleIndex].indexOf(selectedParentOptions[realIndex]);
                if (valueIndex < 0) {
                    valueIndex = 0;
                }
                prevValue = oValue.value;
                oValue.value = parentOptionsValues[realIndex][selectedModuleIndex][valueIndex];
                if(document.getElementById('multioptions_' + inheritedOptionName)){
                    var oMultipleListDiv = document.getElementById('multioptions_' + inheritedOptionName).style.display = 'none';
                }
            } else {
                prevValue = oValue.value;
                if (typeof(oValue.oldValue) != 'undefined') {
                    oValue.value = oValue.oldValue;
                } else if (oValue.tagName == 'SELECT') {
                    for (var j = 0, q = oValue.options.length ; j < q ; j++) {
                        oValue.options[j].selected = oValue.options[j].oldSelected;
                    }
                }
                if(document.getElementById('multioptions_' + inheritedOptionName)){
                    var oMultipleListDiv = document.getElementById('multioptions_' + inheritedOptionName).style.display = 'block';
                }
            }
        }
        if (bValueDisabled) {
            if (inheritedOptionName) {
                setDisabledAttributes(options[index], true, prevValue);
            }
        } else {
            if (inheritedOptionName) {
                setDisabledAttributes(options[index], false);
            }
            continue;
        }
        if (typeof(parentOptions[realIndex][selectedModuleIndex]) == 'undefined') {
            continue;
        }
        var entities = parentOptions[realIndex][selectedModuleIndex];
        var entitiesCaptions = parentOptionsCaptions[realIndex][selectedModuleIndex];
        for (var i = 0, q = entities.length ; i < q ; i++) {
            var oOption = document.createElement('OPTION');
            oOption.text = entitiesCaptions[i];
            oOption.value = entities[i];
            oOption.oldSelected = selectedParentOptions[realIndex] == entities[i];
            oSelect.options[oSelect.options.length] = oOption;
            if (selectedParentOptions[realIndex] == entities[i]) {
                oSelect.selectedIndex = i;
            }
        }
    }
    return true;
}

function setSelectedOptionName(oSelect, optionName){
    errFunc = setSelectedOptionName;

    var parentModuleName = oSelect.form.elements['parent_module_name_' + optionName].value;
    var realIndex = selectedParentModules.indexOf(parentModuleName);
    var selectedModuleIndex = inheritableOptionsParentModules[realIndex].indexOf(parentModuleName);
    var optionIndex = inheritableOptions.indexOf(optionName);
    selectedParentOptions[realIndex] = oSelect.value;
    if (selectedModuleIndex > -1 && oSelect.selectedIndex > -1) {
        getOptionValueObject(optionName).value = parentOptionsValues[optionIndex][selectedModuleIndex][oSelect.selectedIndex];
    }
}

function setDisabledAttributes(id, disabled, prevValue)
{
    errFunc = setDisabledAttributes;

    var oInputs = getOptionValueObject(id).getElementsByTagName("*");
    for (var i = 0 ; i < oInputs.length ; i++) {
        var tagName = oInputs[i].tagName;
        if ((oInputs[i].name == 'option_value_' + id) && ((tagName == 'INPUT' && oInputs[i].type != 'hidden') || oInputs[i].tagName == 'TEXTAREA' || oInputs[i].tagName == 'SELECT')) {
            oInputs[i].disabled = disabled;
            if (disabled) {
                oInputs[i].savedValue = prevValue;
            } else if (typeof(oInputs[i].savedValue) != 'undefined') {
                oInputs[i].value = oInputs[i].savedValue;
            }
        }
    }
}

function resetInheritedOption(id, oForm)
{
    errFunc = resetInheritedOption;

    var realIndex = inheritableOptions.indexOf(id);
    if (realIndex < 0) {
        return false;
    }
    selectedParentModules[realIndex] = inheritableOptionsParentModules[realIndex][inheritableOptionsParentModules[realIndex].length - 1];
    var oSelect = oForm.elements['parent_module_name_' + id];
    oSelect.selectedIndex = oSelect.options.length - 1;
    selectedParentOptions[realIndex] = parentOptions[realIndex][parentOptions[realIndex].length - 1];
    buildInheritedOptionsForms(id);
    return true;
}

"-->

<!--#set var="option_inheritance" value="
<div id="option_inheritance_##name##" style="display:none;padding:0px;margin:0px">
<table cellPadding="0" cellSpacing="0">
    <tr>
        <td style="border:0px;vertical-align:middle">%%inherit_from%%:&nbsp;</td>
        <td style="border:0px"><select id="parent_module_name_##name##" name="parent_module_name_##name##" onChange="buildInheritedOptionsForms('##name##')" disabled></select></td>
    </tr>
    <tr id="parent_option_name_row_##name##">
        <td style="border:0px;vertical-align:middle">%%option%%:&nbsp;</td>
        <td style="border:0px"><select name="parent_option_name_##name##" onChange="setSelectedOptionName(this, '##name##')" disabled></select></td>
    </tr>
</table>
</div>
"-->

<!--#set var="option_inherited" value="
<img id="icon_inherited_##name##" src="skins/vanilla/icons/icon-inherited.gif" width="6" height="12" align="absmiddle" title="%%inherited_option%%" style="display:##icon_inherited_style##" srcDisplay="##icon_inherited_style##" />
"-->

<!--#set var="icons_grp_apply" value="
<button id="cancelActionButton" onclick="parent.postMessage('closeModule', editorBaseHref); return false;" class="btn btn-warning">%%cancell_btn_skin%%</button>
<button id="saveActionButton" type=submit class="btn btn-primary">%%apply_btn_skin%%</button>
"-->

<!--#set var="modules_item" value="
&nbsp;&nbsp;&nbsp;<input class=check type=checkbox name="del_set_##id##[]" value=##name##> ##page_name##<br>
"-->

<!--#set var="specblocks_item" value="
&nbsp;&nbsp;&nbsp;<input class=check type=checkbox name="del_set_##id##[]" value=##name##> '##caption##' %%in_page%% '##page_name##'<br>
"-->

<!--#set var="specblocks_in_blocks_item" value="
&nbsp;&nbsp;&nbsp;<input class=check type=checkbox name="del_set_##id##[]" value=##name##> '##caption##' %%in_block%% '##block_name##'<br>
"-->

<!--#set var="specblocks_in_protected_blocks_item" value="
&nbsp;&nbsp;&nbsp;<input class=check type=checkbox name="del_set_##id##[]" value=##name##> '##caption##' %%in_protected_block%% '##block_name##' %%on_page%% '##page_name##'<br>
"-->

<!--#set var="modules_panel" value="
&nbsp;<b>%%set_modules%%</b><br><br>
##modules_items##
<br>
"-->
<!--#set var="specblocks_panel" value="
&nbsp;<b>%%set_specblocks%%</b><br><br>
##specblocks_items##
##specblocks_in_blocks_items##
##specblocks_in_protected_blocks_items##
<br>
"-->

<!--#set var="group_operations_footer" value="
<table width="100%" border=0 cellspacing=0 cellpadding=3>
<tr><td colspan=2 height=15 nowrap>&nbsp;</td></tr>
<tr height=30><td style="vertical-align: middle;" colspan=2>
##modules_panel##
##specblocks_panel##
<br><div id="formButtons" class="amiro-form-action-btn">##_group_actions##</div><br>
</td></tr>
</table>
"-->

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="edit" value="##if(bEnabled)##<a id=option_icon_edit_##name## href="javascript:" onclick="javascript:showBlock('##name##');return false;"><img title="%%icon_edit%%" class=icon src="skins/vanilla/icons/icon-edit.gif"></a><a id=option_icon_view_##name## href="javascript:" onclick="javascript:hideBlock('##name##');return false;" style="display:none;"><img title="%%icon_undo%%" class=icon src="skins/vanilla/icons/icon-undo.gif"></a>##endif##"-->

<!--#set var="default" value="##if(bEnabled)##<a href="javascript:" onclick="javascript:resetBlock('##name##');return false;"><img title="%%icon_default%%" class=icon src="skins/vanilla/icons/icon-default.gif"></a>##endif##"-->

##-- God mode --##

<!--#set var="array_value_view" value="<div style="word-wrap: break-word;width:300px;overflow-x:hidden;height:##height##;border:1px #808080 solid;overflow:auto;##if(bEnabled)##cursor:pointer##endif##;" id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##name##');"##endif##>##value_view##</div>
"-->
<!--#set var="array_value_edit" value="<div id="option_edit_##name##" style="display:none;"><textarea name="option_value_##name##" class=ta cols=100 rows="##rows##" disabled>##value_edit##</textarea></div>
"-->

<!--#set var="string_value_view" value="<div style="word-wrap: break-word;width:300px;overflow-x:hidden;border:1px #808080 solid;##if(bEnabled)##cursor:pointer##endif##;" id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##name##');"##endif##>##value_view##</div>
"-->
<!--#set var="string_value_edit" value="<div id="option_edit_##name##" style="display:none;"><input name="option_value_##name##" class="field field40" type=text value="##value_edit##" disabled></div>
"-->


##-- RLT_UINT, RLT_SINT, RLT_CHAR, RLT_FLOAT, RLT_EMAIL, RLT_DTIME, RLT_DATE, RLT_TIME --##

<!--#set var="char_value_view" value="<div style="word-wrap: break-word;width:300px;overflow-x:hidden;##if(bEnabled)##cursor:pointer##endif##;" id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##name##');"##endif##>##value_view##&nbsp;</div>
"-->
<!--#set var="char_value_edit" value="<div id="option_edit_##name##" style="display:none;"><input name="option_value_##name##" class=field type=text size=##control_length## value="##value_edit##" disabled defValue="##default_value##"></div>
"-->

##-- RLT_TEXT --##

<!--#set var="text_value_view" value="<div style="word-wrap: break-word;width:300px;overflow-x:hidden;" id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##name##');"##endif##><textarea style="##if(bEnabled)##cursor:pointer##endif##;" class=ta cols=100 rows="##rows##" readonly>##value_view##&nbsp;</textarea></div>
"-->
<!--#set var="text_value_edit" value="<div id="option_edit_##name##" style="display:none;"><textarea name="option_value_##name##" class=ta cols=100 rows="##rows##" disabled>##value_edit##</textarea></div>
"-->

##-- VIEW OF RLT_UINT, RLT_SINT, RLT_CHAR, RLT_FLOAT --##

<!--#set var="char_value_view_20;char_value_view_40" value="<div style="word-wrap: break-word;width:300px;overflow-x:hidden;color:blue;##if(bEnabled)##cursor:pointer##endif##;" id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##name##');"##endif##>##value_view##</div>
"-->

##-- RLT_BOOL, RLT_ENUM, RLT_ENUM_MULTI_STRING, RLT_ENUM_MULTI_ARRAY, RLT_SYS_INSTALLED --##

<!--#set var="enum_value_view_splitter" value="<br>
"-->
<!--#set var="enum_value_view_item" value="<nobr>##caption##</nobr>
"-->
<!--#set var="enum_value_view" value="<div style="word-wrap: break-word;width:300px;overflow-x:hidden;##if(bEnabled)##cursor:pointer##endif##" id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##if(blockname)####blockname####else####name####endif##');##endif##">##caption##</div>
"-->
<!--#set var="enum_value_edit_item;enum_value_edit_item_10010_80;enum_value_edit_item_10010_60;enum_value_edit_item_10010_70" value="
<option value="##name##" ##selected## defSelected="##def_selected##">##caption##</option>
"-->
<!--#set var="enum_value_edit_item_70;enum_value_edit_item_80" value="
<div fieldName="##parent_option_name##" optionValue="##name##" selectionDefault="##def_selected##" class="multiSelectOption##selected##" onClick="onClickMultiSelect(event, this)" onMouseDown="onMDownMultiSelect(event, this)">##caption##</div>
"-->

<!--#set var="enum_value_edit_start_group" value="<optgroup label="##caption##">"-->
<!--#set var="enum_value_edit_end_group" value="</optgroup>"-->

<!--#set var="enum_value_edit" value="<div id="option_edit_##name##" style="display:none;"><select name="option_value_##name##" disabled>##items##</select>
</div>
"-->

<!--#set var="enum_value_edit_10010_80;enum_value_edit_10010_70" value="<div id="option_edit_##name##" style="display:none;"><select multiple name="option_value_##name##[##additional_name##][]" disabled
##IF (allow_empty==1)##
onchange="document.getElementById('option_value_##name##[##additional_name##][]_').disabled = (this.value.length != 0);"
##ENDIF##
>##items##</select>
##IF(allow_empty == 1)##
<input id="option_value_##name##[##additional_name##][]_" type="hidden" value="##empty_value##" name="option_value_##name##[##additional_name##][]" disabled defValue="##empty_value##">
##ENDIF##
</div>
"-->

<!--#set var="enum_value_edit_10010_60" value="<div id="option_edit_##name##" style="display:none;"><select name="option_value_##name##[##additional_name##][]" disabled>##items##</select>
</div>
"-->

<!--#set var="empty_value_view_10010_70;empty_value_view_10010_80" value="<div style="word-wrap:break-word;width:300px;overflow-x:hidden;##if(bEnabled)##cursor:pointer##endif##;" id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##name##');"##endif##><nobr><font color=gray id="font_##name##">&bull;</font>&nbsp;##caption##</nobr><font color="red">%%not_set%%</font></div>
"-->

##-- RLT_ENUM_MULTI_STRING, RLT_ENUM_MULTI_ARRAY --##
<!--#set var="enum_value_view_item_70;enum_value_view_item_80" value="<nobr><font color=gray id="font_##name##">&bull;</font>&nbsp;##caption##</nobr>"-->

<!--#set var="enum_value_edit_70;enum_value_edit_80;" value="<div id="option_edit_##name##" style="display:none;">

<div id="multioptions_##name##" style="width: 300px; height: 50px; background: #fff; overflow: auto; border: 1px solid grey; white-space: nowrap">
##items##
</div>

<select multiple name="option_value_##name##[]" disabled style="display:none"></select>
##IF(allow_empty == 1)##
<input id="option_value_##name##_" type="hidden" value="##empty_value##" name="option_value_##name##[]" disabled defValue="##empty_value##">
##ENDIF##

<script>initMultiselect('##name##', '##control_length##')</script>
"-->

<!--#set var="empty_value_view_70;empty_value_view_80" value="<div style="word-wrap:break-word;width:300px;overflow-x:hidden;##if(bEnabled)##cursor:pointer##endif##;" id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##name##');"##endif##><font color="red">%%not_set%%</font></div>
"-->

##-- VIEW OF RLT_BOOL, RLT_SYS_INSTALLED --##

<!--#set var="enum_value_view_10;enum_value_view_1000" value="<div id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##name##');"##endif##
style="word-wrap: break-word;width:300px;overflow-x:hidden;##if(bEnabled)##cursor:pointer##endif##;color:##IF (value=1)##
blue
##else##
red
##endif##">
##caption##
</div>
"-->

##-- RLT_DATE_PERIOD, RLT_DATE_PERIOD_POSITIVE, RLT_DATE_PERIOD_NEGATIVE --##

<!--#set var="period_enum_value_view" value="<div style="word-wrap: break-word;width:300px;overflow-x:hidden;##if(bEnabled)##cursor:pointer##endif##;" id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##name##');"##endif##>##caption##</div>
"-->

<!--#set var="period_enum_value_edit" value="<div id="option_edit_##name##" style="display:none;"><input class="field field4" type=text name="option_value_##name##[num]" value="##data_value##" disabled defValue="##default_value##">&nbsp;<select name="option_value_##name##[period]" disabled style="margin-bottom:-1px;">##items##</select></div>
"-->

##-- RLT_ARRAY_OF --##

<!--#set var="array_of_value_caption_view" value="##item_caption##:<br>##caption##"-->
<!--#set var="array_of_value_caption_view_60" value="##item_caption##:&nbsp;##caption##"-->

<!--#set var="array_of_value_caption_edit" value="##item_caption##"-->

<!--#set var="array_of_value_view_item" value="<tr><td style="border:0px">##caption##:&nbsp;</td><td style="border:0px">##value##</td></tr>
"-->
<!--#set var="array_of_value_view" value="<table cellspacing=0 cellpadding=0 id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##name##');"##endif## style="##if(bEnabled)##cursor:pointer##endif##;">##caption_view##</table>
"-->
<!--#set var="array_of_value_edit_item" value="<tr><td style="border:0px">##caption##:&nbsp;</td><td style="border:0px"><input class="field field20" type=text name="option_value_##option_name##[##name##]" value="##value##" defValue="##default_value##" disabled></td></tr>
"-->

<!--#set var="array_of_value_edit_item_60;array_of_value_edit_item_70;array_of_value_edit_item_80" value="<tr><td style="border:0px">##caption_edit##:&nbsp;</td><td style="border:0px">##item##</td></tr>
"-->

<!--#set var="array_of_value_edit" value="<table cellspacing=0 cellpadding=0 id="option_edit_##name##" style="display:none;">##items##</table>
"-->

##-- RLT_ENUM_WITH_UINT, RLT_ENUM_WITH_SINT, RLT_ENUM_WITH_FLOAT, RLT_ENUM_WITH_CHAR, RLT_ENUM_WITH_EMAIL --##

<!--#set var="enum_with_value_view" value="<div style="word-wrap: break-word;width:300px;overflow-x:hidden;##if(bEnabled)##cursor:pointer##endif##;" id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##name##');"##endif##>##caption##</div>
"-->
<!--#set var="enum_with_value_edit_item" value="<option value="##name##" ##selected## defSelected="##def_selected##" enum='##enum_only##'>##caption##</option>
"-->

<!--#set var="enum_with_value_edit" value="<div id="option_edit_##name##" style="display:none;"><select  name="option_value_##name##[enum]" disabled style="margin-bottom:-1px;" onchange="if (this.options[this.selectedIndex].getAttribute('enum')==1) {this.form.elements['option_value_##name##[input]'].style.display='none';} else {if (this.form.elements['option_value_##name##[input]'].value < 1) {this.form.elements['option_value_##name##[input]'].value = 1} this.form.elements['option_value_##name##[input]'].style.display='inline';}">##items##</select>&nbsp;<input class="field field4" type=text name="option_value_##name##[input]" value="##data_value##" style="display:##display_enter##" size="##size##" disabled defValue="##default_value##"></div>
"-->

<!--#set var="enum_with_value_edit_250;enum_with_value_edit_260" value="<div id="option_edit_##name##" valueNameForInheritance="option_value_##name##[enum]" style="display:none;"><select  name="option_value_##name##[enum]" disabled style="margin-bottom:-1px;" onchange="if (this.options[this.selectedIndex].getAttribute('enum')==1) {this.form.elements['option_value_##name##[period]'].style.display='none';this.form.elements['option_value_##name##[num]'].style.display='none';} else {if (this.form.elements['option_value_##name##[period]'].value < 1) {this.form.elements['option_value_##name##[period]'].value = 1} this.form.elements['option_value_##name##[period]'].style.display='inline';this.form.elements['option_value_##name##[num]'].style.display='inline';}">##items##</select>&nbsp;<input class="field field4" type=text name="option_value_##name##[num]" value="##sub_data_value##" disabled defValue="##default_value##">&nbsp;<select name="option_value_##name##[period]" style="display:##display_enter##" disabled>##sub_items##</select></div>
"-->

##-- RLT_ITEM_WITH_ENUM --##

<!--#set var="item_with_enum_value_view" value="<div style="word-wrap: break-word;width:300px;overflow-x:hidden;##if(bEnabled)##cursor:pointer##endif##;" id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##name##');"##endif##>##caption##</div>
"-->

<!--#set var="item_with_enum_value_edit_item" value="<option value="##name##" ##selected## defSelected="##def_selected##" enum='##enum_only##'>##caption##</option>
"-->

<!--#set var="item_with_enum_value_edit" value="<div id="option_edit_##name##" style="display:none;"><input class=field type=text name="option_value_##name##[input]" value="##data_value##" size="##size##" disabled defValue="##default_value##">&nbsp;<select  name="option_value_##name##[enum]" disabled style="margin-bottom:-1px;">##items##</select></div>
"-->


##-- VALUE IS NOT SET --##

<!--#set var="empty_value_view" value="<div style="word-wrap:break-word;width:300px;overflow-x:hidden;##if(bEnabled)##cursor:pointer##endif##;" id="option_view_##name##" ##if(bEnabled)##onclick="switchBlock('##name##');"##endif##><font color="red">%%not_set_error%%</font></div>"-->



<!--#set var="row" value="
##if(is_splitter==1 && stub==1)##
<tr##view_mode_style##><td style="border-top: 1px #AAAAAA solid;" colspan="4" height="15" nowrap="nowrap">&nbsp;</td></tr>
##elseif(is_splitter==1 && stub!=1)##
<tr id="switch_group_buttons_##sysname##" vm="##view_mode##" title="%%switch_group%%" onclick="switchGroup(event)" style="cursor:pointer;##view_mode_style##">
    <td class="first_row_left_td">##view_mode_icon##</td>
    <td class="first_row_left_td" colspan="2">##description##</td>
    <td class="first_row_all" align=center><img src="skins/vanilla/icons/icon_switch_group.gif" /></td>
</tr>
##elseif(is_splitter!=1)##
<tr id="group_row_##name##" vm="##view_mode##" class="##style## ##if(style_class=='custom')####custom_style_class####else####style_class####endif##" style="display:none" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)">
  <td>##view_mode_icon##</td>
  <td><div title="##sysname##">##description##</div>&nbsp;</td>
  <td>##value_view####value_edit##</td>
  <td width="60"><nobr>##action_edit## ##action_default##</nobr></td>
</tr>
##endif##
"-->

<!--#set var="list_body;empty" value="
<style>
    #filter-box {
        padding-top: 22px;
        background: #f9fafc;
        border-radius: 0;
        border-bottom: 1px solid #EAEDF1;
    }
    
    .ami-select__container {
        background: none;
    }
    
    .ami-select__inner,
    #srv_options_search_settings {
        border: 1px solid #DBE1E8;
    }
    
    .center_area {
        padding: 0 !important;
    }
    
    table {
        overflow: hidden;
    }
    
    tr.row2 {
        background: #FCFCFC;
    }
    
    .ami-select-rolloverbutton {
        border-top: 7px solid #000;
    }
    
    .amiro-form-action-btn {
        text-align: right;
        padding-right: 20px;
    }
    
    .btn {
        border: 1px #F6F8FF solid;
        font-size: 12px;
        padding: 8px 20px;
        border-radius: 3px;
        width: auto;
        height: auto;
        cursor: pointer;
        font-weight: normal;
        min-width: 140px;
    }
    
    .btn-primary {
        background: #6ad2eb;
        border-color: #1bbae1;
        color: #ffffff;
    }
    
    .btn-warning {
        background: #fff;
        border: 1px solid #e74c3c;
        color: #e74c3c;
    }
    
    #options_table tr td {
        border-top: none !important;
    }
    
    #options_table tr td.first_row_left_td,
    #options_table tr td.first_row_all,
    #options_table tr td.first_row_left_td {
        border-bottom: 1px solid #EAEDF1;
        border-top: 1px solid #EAEDF1 !important;
        margin: 10px 0;
        background: #f9fafc;
        color: #1BBAE1;
        font-size: 16px;
        font-weight: normal;
		white-space: normal;
    }
	
	#options_table td div nobr {
		white-space: normal;
	}
    
    td.first_row_left_td h3,
    td.first_row_all h3,
    td.first_row_left_td h3 {
        color: #555;
        font-size: 16px;
        font-weight: normal;
    }
    
    #options_table td div {
        vertical-align: middle;
        display: inline;
        font-size: 12px;
    }
	
	#options_table td div.multiSelectOptionselected,
	#options_table td div.multiSelectOption,
	#options_table td div#multioptions_extensions,
	#options_table td div#multioptions_show_urgent_elements	{
		display: block;
	}
    
    #options_table td select,
    #options_table td input {
        border: 1px solid #DBE1E8;
        border-radius: 6px;
        padding: 2px 4px;
        font-size: 12px;
    }
    
    #options_table td select:focus,
    #options_table td input:focus {
        border: 1px solid #1bbae1;
    }
    
    td.first_row_all img {
        display: none;
    }
	
	#options_table td.first_row_left_td:first-child {
		background: #f9fafc url(/_img/arrow_submenu.gif) no-repeat 6px center;
	}
	
	#options_table tr:first-child td.first_row_left_td {
		background: #f9fafc !important;
	}
	
	.ami-select__msgOverflow {
		width: 100%;
		left: auto;
		right: 8px;
	}
    
    @media screen and (max-width: 990px) {
        #srv_options_select_module,
        #srv_options_select_option,
        #select-options-container {
            float: none;
        }
        
        #filter-box {
            height: auto !important;
            padding-top: 30px;
        }
        
        .group_operations_form td div,
        .group_operations_form td input {
            width: auto !important;
        }
            
        #srv_options_select_option {
            height: auto;
        }
        
        .ami-select__container {
            width: 100% !important;
            padding: 0;
            max-width: 100%;
        }
        
        .ami-select__resultrow {
            position: relative;
        }
        
        #srv_options_search_settings {
            top: 21px;
        }
    }
</style>
<script type="text/javascript">

window.skinMode = 1;

$(document).click(function(){parent.postMessage('closeSubmenu', editorBaseHref)});
parent.postMessage('openModule', editorBaseHref);

if(window.addEventListener){
    window.addEventListener("message", eventListener, false);
}else{
    window.attachEvent("onmessage", eventListener);
}

function eventListener(event){
    var action = event.data;
    switch(action){
        case 'save':
            if(grpApplyOptions()){
                document.getElementsByName('group_operations_form')[0].submit();
            }
            break;
    }
};

setInterval(function(){
    if(AMI.$('.row3').length){
        parent.postMessage('formChanged', editorBaseHref);
    }else{
        parent.postMessage('formUnchanged', editorBaseHref);
    }
}, 1000);

var _cms_script_link = '##script_link##?';
var _cms_document_form = 'emptyPagerForm';

var viewMode = parseInt(amiCookies.get('opt_view_mode'));
if(!viewMode){
    viewMode = 0;
}
var openedGroupIndices = [];

function switchGroup(evt, oRow, bChangeOpenedStatus){
    if(typeof(oRow) == 'undefined'){
        evt = amiCommon.getValidEvent(evt);
        var oEl = amiCommon.getEventTarget(evt);
        if (oEl.tagName == "TD"){
            oRow = oEl.parentNode;
        }else if(oEl.tagName == "IMG"){
            oRow = oEl.parentNode.parentNode;
        }else{
            return;
        }
    }
    var
        i = oRow.rowIndex + 1,
        t = 1,
        rows = oRow.parentNode.rows,
        bFromSettingViewMode = typeof(bChangeOpenedStatus) != 'undefined';

    if(!bFromSettingViewMode){
        bChangeOpenedStatus = true;
    }
    while(typeof(rows[i]) == "object" && rows[i].tagName == "TR" && rows[i].id.substr(0, 10) == "group_row_"){
        var show = rows[i].getAttribute('vm') >= viewMode;
        if(
            bFromSettingViewMode
                ? (rows[i].style.display == 'none' ? show : !show)
                : show
        ){
            setTimeout(function(obj){return function(){switchRow(obj)}}(rows[i]), t*15);
            t++;
        }
        i++;
    }
    setTimeout(function(obj){return function(){stripeGroup(obj)}}(oRow), t*15);
    if(bChangeOpenedStatus){
        if(openedGroupIndices.indexOf(oRow.rowIndex) > -1){
            openedGroupIndices[openedGroupIndices.indexOf(oRow.rowIndex)] = undefined;
        }else{
            openedGroupIndices.push(oRow.rowIndex);
        }
    }
}

function stripeGroup(oRow){
    var
        i = oRow.rowIndex + 1,
        rows = oRow.parentNode.rows,
        even = false;

    while(typeof(rows[i]) == 'object' && rows[i].tagName == 'TR' && rows[i].id.substr(0, 10) == 'group_row_'){
        if(rows[i].style.display != 'none'){
            rows[i].className = even ? 'row2' : 'row1';
            even = !even;
        }
        i++;
    }
}

function switchFirstGroup(){
    if(document.getElementById("options_table") == null){
        return;
    }
    var
        i = 1,
        t = 1,
        doShowFirstGroup = false,
        oTBody = document.getElementById("options_table").tBodies[0],
        oRow = null;

    while(typeof(oTBody.rows[i]) == "object" && oTBody.rows[i].tagName == "TR"){
        if((oTBody.rows[i].id.substr(0, 10) == "group_row_" || oTBody.rows[i].id.substr(0, 20) == "switch_group_buttons")){
            if(oTBody.rows[i].id.substr(0, 20) == 'switch_group_buttons'){
                if(!doShowFirstGroup){
                    openedGroupIndices.push(oTBody.rows[i].rowIndex);
                    oRow = oTBody.rows[i];
                    doShowFirstGroup = true;
                }else{
                    break;
                }
            }else if(oTBody.rows[i].getAttribute('vm') >= viewMode){
                setTimeout(function(obj){return function(){switchRow(obj)}}(oTBody.rows[i]), t*15);
                t++;
            }
        }
        i++;
    }
    if(oRow){
        setTimeout(function(obj){return function(){stripeGroup(obj)}}(oRow), t*15);
    }
}

function switchRow(rowObj){
  if (rowObj.style.display!="none"){
    rowObj.style.display='none';
  }else{
    rowObj.style.display = tableRowShowStyle;
  }
}

function _setElementDisplayStyle(elName, style){
  el = document.getElementById(elName);
  if(el != null){
      makeElementVisible(el, style);
      if (el.tagName.toLowerCase() == 'table') {
        var elems = el.getElementsByTagName('div');
        for (var i = 0, q = elems.length ; i < q ; i++) {
            if (elems[i].id == elName) {
                makeElementVisible(elems[i], style);
            }
        }
      }
  }
}

function hideBlock(id) {
  var bChanged = false;

  var oInputs = document.getElementById("option_edit_"+id).getElementsByTagName("*");
  for (var i=0;i<oInputs.length;i++){
    if (oInputs[i].tagName == "INPUT" || oInputs[i].tagName == "TEXTAREA"){
      bChanged |= oInputs[i].value != oInputs[i].oldValue;
    }
    if (oInputs[i].tagName == "SELECT" ){
      for (var j=0;j<oInputs[i].options.length;j++){
        bChanged |= oInputs[i].options[j].selected != oInputs[i].options[j].oldSelected;
      }
    }
  }

  // inheritance
  var oInputs = document.getElementById('option_inheritance_' + id);
  if (oInputs != null) {
    oInputs = oInputs.getElementsByTagName("*");
    for (var i = 0 ; i < oInputs.length ; i++) {
      if (oInputs[i].tagName == 'SELECT') {
        for (var j = 0 ; j < oInputs[i].options.length ; j++) {
          bChanged |= oInputs[i].options[j].selected != oInputs[i].options[j].oldSelected;
        }
      }
    }
  }

  if ( !bChanged || (bChanged  && confirm('%%undo_changes_msg%%'))){
    //document.getElementById("option_view_"+id).style.display = "block";
    _setElementDisplayStyle("option_edit_"+id, "none");
    
    _setElementDisplayStyle("option_view_"+id, "block");
    
    _setElementDisplayStyle("option_inheritance_"+id, "none");
    _setElementDisplayStyle("option_icon_view_"+id, "none");
    _setElementDisplayStyle("option_icon_edit_"+id, "inline");

    document.getElementById("group_row_"+id).className="row1";

    var oInputs = document.getElementById("option_edit_"+id).getElementsByTagName("*");
    for (var i=0;i<oInputs.length;i++){
      if (oInputs[i].tagName == "INPUT" || oInputs[i].tagName == "TEXTAREA"){
        oInputs[i].value = oInputs[i].oldValue;
        oInputs[i].savedValue = oInputs[i].oldValue;
        oInputs[i].disabled = true;
      }
      if (oInputs[i].tagName == "SELECT" ){
        for (var j=0;j<oInputs[i].options.length;j++){
          oInputs[i].options[j].selected = oInputs[i].options[j].oldSelected;
        }
        oInputs[i].disabled = true;
        if(oInputs[i].multiple){
            multipleSelectUpdate(oInputs[i]);
        }
      }
    }
    // inheritance
    var oInputs = document.getElementById('option_inheritance_' + id);
    if (oInputs != null) {
      oInputs = oInputs.getElementsByTagName("*");
      for (var i = 0 ; i < oInputs.length ; i++) {
        if (oInputs[i].tagName == 'SELECT') {
          var name = oInputs[i].name.substr(19);
          for (var j = 0 ; j < oInputs[i].options.length ; j++) {
            oInputs[i].options[j].selected = oInputs[i].options[j].oldSelected;
          }
          if (oInputs[i].name.substr(0, 19) == 'parent_option_name_') {
            selectedParentOptions[inheritableOptions.indexOf(name)] = oInputs[i].value;
          }
          oInputs[i].disabled = true;
          var oIcon = document.getElementById('icon_inherited_' + name);
          oIcon.style.display = oIcon.srcDisplay;
        }
      }
    }
  }
}

function showBlock(id) {
  //document.getElementById("option_view_"+id).style.display = "none";
  _setElementDisplayStyle("option_edit_"+id, "block");
  
  _setElementDisplayStyle("option_view_"+id, "none");
  
  _setElementDisplayStyle("option_inheritance_"+id, "block");
  _setElementDisplayStyle("option_icon_view_"+id, "inline");
  _setElementDisplayStyle("option_icon_edit_"+id, "none");
  document.getElementById("group_row_"+id).className="row3";

  var oInputs = document.getElementById("option_edit_"+id).getElementsByTagName("*");
  for (var i=0;i<oInputs.length;i++){
    if ((oInputs[i].tagName == "INPUT" && oInputs[i].type != "hidden") || oInputs[i].tagName == "TEXTAREA"){
      oInputs[i].disabled = false;
      oInputs[i].oldValue = oInputs[i].value;
      oInputs[i].savedValue = oInputs[i].value;
      fireEvent2(oInputs[i], "change");
    }
    if (oInputs[i].tagName == "SELECT" ){
      oInputs[i].disabled = false;
      for (var j=0;j<oInputs[i].options.length;j++){
        oInputs[i].options[j].oldSelected = oInputs[i].options[j].selected;
      }
      oInputs[i].savedValue = oInputs[i].value;
      fireEvent2(oInputs[i], 'change');
    }
  }
  // inheritance
  var oInputs = document.getElementById('option_inheritance_' + id);
  if (oInputs != null) {
    oInputs = oInputs.getElementsByTagName("*");
    for (var i = 0 ; i < oInputs.length ; i++) {
      if (oInputs[i].tagName == 'SELECT') {
        oInputs[i].disabled = oInputs[i].id ? false : document.getElementById('parent_module_name_' + id).value == '';
        for (var j = 0 ; j < oInputs[i].options.length ; j++) {
          oInputs[i].options[j].oldSelected = oInputs[i].options[j].selected;
        }
        fireEvent2(oInputs[i], 'change');
      }
    }
  }
}

function resetBlock(id) {
  if (document.getElementById("option_edit_"+id).style.display != "block"){
    showBlock(id);
  }
  var oInputs = document.getElementById("option_edit_"+id).getElementsByTagName("*");
  for (var i=0;i<oInputs.length;i++){
    if (oInputs[i].tagName == "INPUT" || oInputs[i].tagName == "TEXTAREA"){
      oInputs[i].disabled = typeof(resetInheritedOption) == 'function' ? resetInheritedOption(id, oInputs[i].form) : false;
      oInputs[i].value = oInputs[i].getAttribute("defValue");
      fireEvent2(oInputs[i], "change");
    }
    if (oInputs[i].tagName == "SELECT" ){
      oInputs[i].disabled = typeof(resetInheritedOption) == 'function' ? resetInheritedOption(id, oInputs[i].form) : false;
      for (var j=0;j<oInputs[i].options.length;j++){
        oInputs[i].options[j].selected = oInputs[i].options[j].getAttribute("defSelected");
      }
      if(oInputs[i].multiple){
          multipleSelectUpdate(oInputs[i]);
      }
      fireEvent2(oInputs[i], "change");
    }
  }
}

var switchBlockSkip = false, bIsIEorOpera = bIsIE || navigator.userAgent.indexOf('Opera') > -1;

function switchBlock(id){
  if (id == '') {
    return;
  }
  if (switchBlockSkip) {
    switchBlockSkip = false;
    return;
  }
  if (bIsIEorOpera) {
    switchBlockSkip = true;
  }
  if(document.getElementById("option_edit_"+id).style.display != "none"){
    hideBlock(id);
  }else{
    showBlock(id);
  }
}

function grpApplyOptions() {
    var gform = document.forms[_cms_group_operations_form];
    if (typeof(optionsParents) != 'undefined' && optionsParents.length) {
        var oInputs = gform.elements;
        var parents = [];
        var parentsCaptions = [];
        var inheritedOptions = [];
        for (var i = 0 ; i < oInputs.length ; i++) {
            if (!oInputs[i].disabled && oInputs[i].name.substr(0, 13) == 'option_value_' && oInputs[i].id.substr(oInputs[i].id.length - 1) != '_') {
                var name = oInputs[i].name.substr(13);
                var realIndex = optionsParents.indexOf(name);
                if(realIndex < 0 && name.indexOf('[]') > 0){
                    name = name.substr(0, name.length - 2);
                    realIndex = optionsParents.indexOf(name);
                }
                if (realIndex >= 0) {
                    var parentIndex = parents.indexOf(name);
                    if (parentIndex < 0) {
                        parents.push(name);
                        parentsCaptions.push(optionsParentsCaptions[realIndex]);
                        parentIndex = parents.length - 1;
                    }
                    if (!inheritedOptions[parentIndex]) {
                        inheritedOptions[parentIndex] = [];
                    }
                    inheritedOptions[parentIndex].push(optionsParentsChildren[realIndex].join(',\n  '));
                }
            }
        }
        if (parents.length) {
            var sText = '%%following_inherited_options%%:';
            for (var i = 0 ; i < parentsCaptions.length ; i++) {
                sText += '\n\n%%from_parameter%% "' + parentsCaptions[i] + '":\n  ' + inheritedOptions[i];
            }
            sText += '\n\n%%continue%%?';
            if (!confirm(sText)) {
                return false;
            }
        }
    }
    var sform = document.forms[_cms_document_form];
    sform.action.value = 'grp_apply';
    var link = _cms_script_link + collect_link(sform);
    gform.action = link + '&frn_skin_popup=1';

/*
    // CMS-11497
    AMI.$(gform).append('<INPUT TYPE="hidden" name="ajax_save" value="1">');
    var formData = new FormData(gform);
    $.ajax({
        url: link,
        data: formData,
        processData: false,
        contentType: false,
        dataType: 'json',
        type: 'POST',
        success: function(data){
            if(typeof(data.data) == 'undefined'){
                alert('Error');
                return;
            }
            var aData = data.data;
            for(var optionName in aData.aNewValues){
                // switchBlock(optionName);
            }
            if(aData.aStatusMessages.length){
                alert(aData.aStatusMessages[0].msg);
            }
        },
        error: function(){
            alert('Error!');
        }
    });
    return false;
*/

    return true;
}

##js##
##js_titles##
##js_owners##

var currentModule='##current_module##';

function rebuildModList(el) {
  if(el.name=='flt_owner') {
    form=el.form;
    var num = form.elements['flt_module'].length - 1;
    for(i=num;i>=0;i--) {
      form.elements['flt_module'].options[i]=null;
    }
    var own=mOwnersData[el.value];
    num = mData[own].length;
    iSelectedItem = -1;
    for(i=0;i<num;i++) {
      if(currentModule == mData[own][i]){
        iSelectedItem = i;
      }
      opt = new Option(mTitlesData[own][i], mData[own][i]);
      form.elements['flt_module'].options[i] = opt;
    }
    if(iSelectedItem >= 0){
        form.elements['flt_module'].options[iSelectedItem].selected = true;
    }
  }
}

/* Multiselect control handlers */

function initMultiselect(name, controlLength){
    var selectObject = document.getElementById('multioptions_' + name);
    var maxLength = 0;
    if(selectObject != null){
        var realField = document.getElementsByName('option_value_' + name + '[]')[0];
        var optionObjects = selectObject.getElementsByTagName('div');
        var rowHeight = 18;
        for(var i = 0; i < optionObjects.length; i++){
            var fieldValue = optionObjects[i].getAttribute('optionValue');
            var fieldSelected = optionObjects[i].className == 'multiSelectOptionselected';
            var currentIndex = realField.options.length;
            realField.options[currentIndex] = new Option(fieldValue, fieldValue, fieldSelected, fieldSelected);
            realField.options[currentIndex].setAttribute('defSelected', optionObjects[i].getAttribute('selectionDefault'));

            var widthAddon = 0;
            if(name == 'extensions'){
                rowHeight = 22;
                var extName = optionObjects[i].getAttribute('optionValue');
                if(extName.length > 0){
                    var extImage = document.createElement('img');
                    extImage.src = amiCommon.getModResourceURL(
                        'ext_icon',
                        {
                            modId:  extName,
                            locale: interface_lang
                        }
                    );
                    extImage.className = 'multiSelectExtImage';
                    optionObjects[i].insertBefore(extImage, optionObjects[i].firstChild);
                    optionObjects[i].style.height = '17px';
                    optionObjects[i].style.paddingTop = '3px';
                    widthAddon = 23;
                }
            }
            maxLength = Math.max(maxLength, fromHTMLToText(optionObjects[i].innerHTML).length);
        }
        if(maxLength > 0){
            if(maxLength < 20)
                maxLength = 20;
            selectObject.style.width = (maxLength * 8 + 15 + widthAddon) + 'px';
        }
        var maxRows = optionObjects.length;
        if(maxRows > 8){
            maxRows = parseInt(controlLength);
            if(isNaN(maxRows)){
                maxRows = 3;
            }
        }
        selectObject.style.height = (maxRows * rowHeight + (bIsIE ? 2 : 0)) + 'px';
    }
}

function onClickMultiSelect(evt, oOption){
    var valueState = false;
    if(oOption.className == 'multiSelectOptionselected'){
        oOption.className = 'multiSelectOption';
    }else{
        oOption.className = 'multiSelectOptionselected';
        valueState = true;
    }

    // Select real field
    var realField = document.getElementsByName('option_value_' + oOption.getAttribute('fieldName') + '[]')[0];
    var fieldValue = oOption.getAttribute('optionValue');
    for(var i = 0; i < realField.options.length; i++){
        if(realField.options[i].value == fieldValue){
            realField.options[i].selected = valueState;
        }
    }

    // Fill empty value if required
    var oEmptyFill = document.getElementById('option_value_' + oOption.getAttribute('fieldName') + '_');
    if(oEmptyFill != null){
        oEmptyFill.disabled = realField.value.length != 0;
    }
}

function onMDownMultiSelect(evt, oOption){
    evt = amiCommon.getValidEvent(evt);
    amiCommon.stopEvent(evt);
}

function multipleSelectUpdate(oSelect){
    var optionName = oSelect.name.substr(13, oSelect.name.length - 15);
    var optionsDiv = document.getElementById('multioptions_' + optionName);
    if(optionsDiv != null){
        var oOptions = optionsDiv.getElementsByTagName('div');
        for(var i = 0; i < oOptions.length; i++){
            if(oSelect.options[i].selected){
                oOptions[i].className = 'multiSelectOptionselected';
            }else{
                oOptions[i].className = 'multiSelectOption';
            }
        }
    }
}

/* */

function LocalBodyOnLoad() {
  var oFonts = document.getElementsByTagName('font');
  for(i = 0; i < oFonts.length; i++){
    if(oFonts[i].id.indexOf('font_ext_img') < 0 && (oFonts[i].id.indexOf('font_ext_') == 0 || oFonts[i].id == 'font_ce_page_break')){
        var extImage = document.createElement('img');
        extImage.src = amiCommon.getModResourceURL(
            'ext_icon',
            {
                modId:  oFonts[i].id.substr(5),
                locale: interface_lang
            }
        );
        extImage.align = 'absmiddle';
        extImage.style.margin = '2px 2px 2px 0px';
        oFonts[i].parentNode.insertBefore(extImage, oFonts[i]);
        oFonts[i].parentNode.removeChild(oFonts[i]);
        i--;
    }
  }

  rebuildModList(document.forms['fltform'].elements['flt_owner']);
  switchFirstGroup();
}

##inheritance_scripts##

function setViewMode(level){
    if(level == viewMode){
        return;
    }
    var oSpan = document.getElementById('view_mode_' + level);
    oSpan.style.cursor = 'default';
    oSpan.style.borderBottom = 'none';
    oSpan.style.fontWeight = 'bold';
    var oSpan = document.getElementById('view_mode_' + (100 - level));
    oSpan.style.cursor = 'pointer';
    oSpan.style.borderBottom = '1px dashed #01A765';
    oSpan.style.fontWeight = 'normal';

    var rows = document.getElementById('options_table').rows;
    viewMode = level;
    amiCookies.set('opt_view_mode', level + '', '/', 1, 0);
    for(var i = 0, q = rows.length; i < q; i++){
        if(
            rows[i].getAttribute('vm') != null &&
            rows[i].id.substr(0, 20) == 'switch_group_buttons'
        ){
            var opened = openedGroupIndices.indexOf(rows[i].rowIndex) > -1;
            if(rows[i].getAttribute('vm') >= level){
                // show
                if(rows[i].style.display == 'none'){
                    rows[i - 1].style.display = tableRowShowStyle;
                    rows[i].style.display = tableRowShowStyle;
                }else if(opened){
                    switchGroup(null, rows[i], false);
                }
            }else{
                // hide
                if(opened){
                    switchGroup(null, rows[i], true);
                }
                rows[i - 1].style.display = 'none';
                rows[i].style.display = 'none';
            }
        }
    }
}
</script>

##IF(_num_rows==0)##
<br><br>
<h3 align=center>%%empty%%</h3>
##ELSE##

##--
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>--##

##_group_operations_script##
<br>
##if(use_view_mode)##
<div style="text-align: right; margin-bottom: 4px; width: 100%;">
<span class="lar">%%view_mode%%:</span>
<span id="view_mode_100" class="text_button"##view_mode_100## onclick="setViewMode(100);">%%view_mode_100%%</span> |
<span id="view_mode_0" class="text_button"##view_mode_0## onclick="setViewMode(0);">%%view_mode_0%%</span>
</div>
##endif##
          <form class="group_operations_form" name="group_operations_form" action="##script_link##" method="post" enctype="multipart/form-data" onsubmit="return grpApplyOptions();">
            <table width="100%" border="0" cellspacing="0" cellpadding="4" id="options_table">
              <tr>
                <td class="first_row_left_td"></td>
                <td class="first_row_left_td">
                 <h3>%%option%%</h3>##--%%name%% / %%description%%--##
                </td>
                <td class="first_row_all">
                 <h3>%%value%%</h3>
                </td>
##_id_page_header##
                <td class="first_row_all" align="center" width="40">
                 <h3>%%actions%%</h3>
                </td>
              </tr>
              ##list##
            </table>
##_group_operations_footer##
<input type="hidden" name="current_module" value="##current_module##">
</form>
##ENDIF##
<a name="anchor"></a>
<script type="text/javascript">
if (typeof(buildInheritedOptionsForms) == 'function') {
    buildInheritedOptionsForms();
}
parent.postMessage('fixMobileBar', editorBaseHref);
</script>
"-->

<!--#set var="popup_html" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - %%title%%</TITLE>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css">
<link rel="stylesheet" href="##skin_path##_css/scroll_bars.css" type="text/css">
<script>
var editorBaseHref = '##root_path_www##';
</script>
##scripts##
<script type="text/javascript">

function HandleError(message, url, line) {
  return true;
}

function Init() {
  var editorBaseHref = top.editorBaseHref;
  switchFirstGroup();
}

</SCRIPT>
</HEAD>

<BODY id=bdy bgcolor="#FFFFFF" style="margin:0px">
<table cellspacing="0" cellpadding="0" align="center" width=100% id="popup_content">
  <tr>
    <td>
##filter##
##if(common_settings_url != '')##
<script type="text/javascript">
var common_settings_link_span = document.getElementById('common_settings_link');
common_settings_link_span.innerHTML = '<b><a href="javascript:void(0);" onClick="openDialog(\'%%module_options%%\', \'##common_settings_url##\', 0, 0, 0, 0);return false;">%%common_settings%%</a></b>';
</script>
##endif##
<br/>
##status##
<br>
##list_table##
##form##
</td></tr>
</table>

<script>
 Init();
 InitForm();
</script>


</BODY>
</HTML>
"-->
