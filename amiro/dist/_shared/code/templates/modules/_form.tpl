%%include_language "templates/lang/modules/_form.lng"%%
%%include_template "templates/_bb_common.tpl"%%

##-- form { --##

<!--#set var="hidden_field" value="<input name="##name##" value="##value##" type="hidden"##attributes## />
"-->

<!--#set var="input_field" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td><input type="text" name="##name##" class="field field50##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## /></td>
</tr>
"-->

<!--#set var="input_field(caption=sublink)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td>
        <input type="text" name="##name##" class="field field56##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
        <input type="hidden" name="original_sublink" collect_link_ignore="1" value="##value##"##attributes## />
    </td>
</tr>
"-->

<!--#set var="input_field(caption=html_title)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td>
        <input type="text" name="##name##" class="field field56##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF## prop="on"##attributes## />
        <span class="input_opt" id="html_title_prop">&nbsp;</span>
        <input type="hidden" name="original_html_title" collect_link_ignore="1" value="##value##" />
    </td>
</tr>
"-->

<!--#set var="date_field" value="
<tr>
    <td width="80">##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td>
        <input type="text" name="##name##" class="field fieldDate##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="30"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
        <a href="javascript:void(0);" onclick="return getCalendar(event, document.##_mod_id##form.##name##);"><img class="clnd_img" src="/_admin/skins/vanilla/images/spacer.gif" /></a>
    </td>
</tr>
"-->

<!--#set var="datetime_field" value="
<tr>
    <td width="80">##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td>
        <input type="text" name="##name##" class="field fieldDate##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="30" helpId="form_date"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes_date## />
        <a href="javascript:void(0);" onclick="return getCalendar(event, document.##_mod_id##form.##name##);"><img class="clnd_img" src="/_admin/skins/vanilla/images/spacer.gif" helpId="clnd_date" /></a>
        <input type="text" name="##name##_time" class="field field10field##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value_time##" maxlength="10" helpId="form_time"##attributes_time## />
    </td>
</tr>
"-->

<!--#set var="checkbox_field" value="
<tr>
    <td>
        <label>
            <input type="checkbox" id="cb_##name##" name="##name##" value="1"##checked## class="##filter_class##" helpId="form_##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
            ##element_caption####IF(validator_filled)##*##ENDIF##
        </label>
    </td>
    <td align=right></td>
</tr>
"-->

<!--#set var="textarea_field(caption='html_keywords')" value="
<tr>
    <td valign="top" width="250">##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td class="seo">
        <textarea name="##name##" class="field##IF(is_invalid)## fieldInvalid##ENDIF##" wrap="soft" cols="##cols##" rows="##rows##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##value##</textarea>
        <span class="input_opt" id="html_keywords_prop">&nbsp;</span>
        <input type="hidden" name="original_html_keywords" collect_link_ignore="1" value="##value##" />
    </td>
</tr>
"-->

<!--#set var="textarea_field(caption='html_description')" value="
<tr>
    <td valign="top" width="250">##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td class="seo">
        <textarea name="##name##" class="field##IF(is_invalid)## fieldInvalid##ENDIF##" wrap="soft" cols="##cols##" rows="##rows##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##value##</textarea>
        <span class="input_opt" id="html_description_prop">&nbsp;</span>
        <input type="hidden" name="original_html_description" collect_link_ignore="1" value="##html_description##" />
    </td>
</tr>
<tr>
    <td width="250">&nbsp;</td>
    <td>
        <span class=text_button onclick="clearHTMLFields(document.forms[_cms_document_form])">%%clear_fields%%</span>
        <script type="text/javascript">
            var oForm = document.forms[_cms_document_form];
            if(oForm){
                var aSEOFields = ['html_title', 'html_keywords', 'html_description'];
                for(var i = 0; i < aSEOFields.length; i++){
                    var oField = oForm.elements[aSEOFields[i]];
                    showInputProperties(oField);
                    AMI.Browser.Event.addHandler(oField, 'blur', function(_oField){return function(){showInputProperties(_oField, true)}}(oField));
                    AMI.Browser.Event.addHandler(oField, 'keyup', function(_oField){return function(){showInputProperties(_oField)}}(oField));
                    AMI.Browser.Event.addHandler(oField, 'click', function(_oField){return function(){showInputProperties(_oField)}}(oField));
                }
            }
        </script>
    </td>
</tr>
"-->

<!--#set var="checkbox_field(name='details_noindex')" value="
<tr>
    <td colspan="2">
        <label>
            <input type="checkbox" name="##name##" id="##name##" value="1"##checked## class="##filter_class##" helpId="form_##name##"##if(validators)## data-ami-validators="##validators##"##endif####attributes## />
            ##element_caption####IF(validator_filled)##*##ENDIF##
        </label>
    </td>
</tr>
"-->


<!--#set var="textarea_field" value="
<tr>
    <td colspan="2">##element_caption####IF(validator_filled)##*##ENDIF##:<br />
        <textarea name="##name##" class="field##IF(is_invalid)## fieldInvalid##ENDIF##" wrap="soft" cols="##cols##" rows="##rows##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##value##</textarea>
    </td>
</tr>
"-->

<!--#set var="bb_field" value="
<tr>
    <td colspan="2" style="padding-top:10px;">##if(show_caption)####element_caption####IF(validator_filled)##*##ENDIF##:<br />##endif##
	<textarea style="display:none" id="amiroTEdSource">##value##</textarea>
        <div id="amiroTEdPreviewHeader"></div>
        <div id="amiroTEdDivPreview" class="amiroTEdDivPreview" style="width:100%;height:100px;overflow:auto;margin:3px;display:none"></div>
        <div id='bbEditor_##name##'></div>
<script type="text/javascript">
    var txtEd = new amiroTEdit('txtEd', new amiDictionary({
        'bold': '%%bb_bold%%',
        'strike': '%%bb_strike%%',
        'insert_olist': '%%bb_insert_olist%%',
        'header': '%%bb_header%%',
        'italic': '%%bb_italic%%',
        'underline': '%%bb_underline%%',
        'quote': '%%bb_quote%%',
        'align_left': '%%bb_align_left%%',
        'align_center': '%%bb_align_center%%',
        'align_right': '%%bb_align_right%%',
        'justify': '%%bb_justify%%',
        'insert_list': '%%bb_insert_list%%',
        'insert_link': '%%bb_insert_link%%',
        'delete_link': '%%bb_delete_link%%',
        'insert_image': '%%bb_insert_image%%',
        'font': '%%bb_font%%',
        'size': '%%bb_size%%',
        'color': '%%bb_color%%',
        'more': '%%bb_more%%',
        'insert_code': '%%bb_insert_code%%',
        'indent': '%%bb_indent%%',
        'outdent': '%%bb_outdent%%',
        'preview': '%%bb_preview%%',
        'hide_preview': '%%bb_hide_preview%%',
        'update_preview': '%%bb_update_preview%%',
        'warn_message_length': '%%bb_warn_message_length%%',
        'warn_invalid_image_url': '%%bb_warn_invalid_image_url%%',
        'warn_image_url_internal_links_forbidden': '%%bb_warn_image_url_internal_links_forbidden%%',
        'warn_image_url_external_links_forbidden': '%%bb_warn_image_url_external_links_forbidden%%',
        'prompt_enter_list_element': '%%bb_prompt_enter_list_element%%',
        'prompt_enter_next_list_element': '%%bb_prompt_enter_next_list_element%%',
        'prompt_enter_url': '%%bb_prompt_enter_url%%',
        'prompt_enter_image_url': '%%bb_prompt_enter_image_url%%',
        'warn_urls_reg_only': '%%bb_warn_urls_reg_only%%'
    }));
    txtEd.allowedImages = new Array ('internal_links', 'external_links');
##if(disallow_bb_urls)##txtEd.bAllowURLs = false;##endif##
    txtEd.createEditor(600, 180, '##name##', '', false, 'amiroTEdDivPreview', 'bbEditor_##name##');
    txtEd.setUseNoindex(##noindex_external_links##);
    txtEd.editorModeCode = "document.getElementById('amiroTEdPreviewHeader').style.display = 'none';";
    ##if(value)##AMI.find('#id##name##').value = '[Q]' + txtEd.fromHTMLContent(AMI.find('#amiroTEdSource').value) + '[/Q]';##endif##
    ##IF(validators)##AMI.find('#id##name##').setAttribute("data-ami-validators", "##validators##");##ENDIF##
</script>
    ##-- <input type="submit" class="btn" value="%%bb_preview%%" name="preview" onClick="return txtEd.previewButtonOnClick(this)" /> --##
    </td>
</tr>
"-->

<!--#set var="select_field" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td><select name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##select##</select></td>
</tr>
"-->

<!--#set var="select_field(name=id_page)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td><select name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##select##</select>
        <div class="tooltip" style="margin-top: 5px; margin-right: 0px; margin-bottom: 5px; margin-left: 0px; display: block; " id="commonFieldTooltip">%%common_page_noindex%%</div>
    </td>
</tr>
"-->

<!--#set var="select_field_row" value="<option value="##value##" ##selected##>##caption##</option>"-->

<!--#set var="radio_field" value="
<tr>
    <td style="vertical-align: top; width:10px; padding: 3px;">##element_caption##:</td>
    <td>##value##</td>
</tr>
"-->

<!--#set var="radio_field_row" value="<input ##disabled## type="radio" id="##id##" name="##name##" ##checked## value="##value##" />&nbsp;&nbsp;<label for="##id##">##caption##</label><br>"-->

<!--#set var="form_buttons" value="<div id="form-buttons">##add_btn## ##save_btn## ##cancel_btn## ##apply_btn##</div>"-->

<!--#set var="add_btn" value="<input type="submit"##-- name="add"--## value="%%add_btn%%" class="but wd2" onclick="this.form.elements['ami_full'].value = 1;this.form.action.value='add'"##attributes## />
"-->

<!--#set var="apply_btn" value="<input type="submit"##--  name="apply"--## value="%%apply_btn%%" class="but wd2" onclick="this.form.elements['ami_full'].value = 1;this.form.action.value='apply'"##attributes## />
"-->

<!--#set var="save_btn" value="<input type="submit"##--  name="save"--## value="%%ok_btn%%" class="but wd2" onclick="this.form.elements['ami_full'].value = 1;this.form.action.value='save'"##attributes## />
"-->

<!--#set var="cancel_btn" value="
<input type="reset"##--  name="cancel"--## value="%%cancel_btn%%" class="but wd2" onclick="AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'form_reset', this.form); return false;"##attributes## />
"-->


<!--#set var="tabset" value="
<tr><td colspan="2">
<div class="tab-control" id="tab-control-##name##" onselectstart="return false;"></div>
<div class="tabs-container">
##section_html##
</div>
<script type="text/javascript">
//  var baseTabs = new cTabs('tab-control-##name##', {##tab_array##'': ''});
</script>
</td></tr>
"-->

<!--#set var="tab" value="
<div class="tab-page" id="tab-page-##name##">
<table class="frm" cellspacing="0" cellpadding="0" border="0" width="100%">
##section_html##
</table>
</div>
"-->

<!--#set var="tab_options_tab" value="
<div class="tab-page" id="tab-page-##name##" style="padding: 10px">
<table class="frm" cellspacing="0" cellpadding="0" border="0" width="100%">
##section_html##
</table>
</div>
"-->

<!--#set var="tab_array" value="
'##name##' : ['##title##', '##state##', '', false],
"-->

<!--#set var="section_form" value="
<script type="text/javascript">
##scripts##

var
    _cms_document_form = 'ami_form_##_component_id##',
    _cms_document_form_changed = false;

var calendarFormat = '##date_format##';

##-- Form validator --##

function highlight_element_as_error(oForm, name){
    oForm.elements[name].style.backgroundColor = '#fdd';
}

function highlight_element_as_ok(oForm, name){
    oForm.elements[name].style.backgroundColor = '';
}

function show_error(oForm, focusField, customMessage){
    if(focusField){
        oForm.elements[focusField].focus();
    }
    if(typeof(customMessage) == 'undefined'){
        customMessage = '';
    }
    // alert('%%errors_found%%' + customMessage);
    if(customMessage == '' || customMessage == null){
        alert('%%errors_found%%');
    }else{
        alert(customMessage);
    }

    return false;
}

function validateFormField(oForm, oField, validator){
    var error = false;
    var customMessage = '';
    var value = oField.value;
    switch(validator){
        case 'alphanum':
            error = !value.match(/^[0-9a-zA-Z]+$/);
            break;
        case 'float':
        case 'double':
            error = !value.match(/^[0-9]+\.?[0-9]*$/);
            break;
        case 'date':

            dayIndex = calendarFormat.indexOf('DD');
            monthIndex = calendarFormat.indexOf('MM');
            yearLongIndex = calendarFormat.indexOf('YYYY');
            yearIndex = calendarFormat.indexOf('YY');

            day = value.substr(dayIndex,2);
            month = value.substr(monthIndex,2);
            if(yearLongIndex>=0){
                year = value.substr(yearLongIndex,4);
            }else{
                year = value.substr(yearIndex,2);
                if(year<40){
                    year = '20' + year;
                }else{
                    year = '19' + year;
                }
            }

            var oDate = new Date(month + "/" + day + "/" + year);

            if(oDate.getDate() != day ||  oDate.getMonth() != month-1 || oDate.getFullYear() != year){
                error = true;
            }

            break;
        case 'time':
            error = !value.match(/^[0-9]{1,2}\:[0-9]{1,2}\:[0-9]{2,4}$/);
            break;
        case 'email':
            error = value != '' && !value.match(/^(\w+[\w.-]*\@[A-Za-z0-9а-яёА-ЯЁ]+((\.|-+)[A-Za-z0-9а-яёА-ЯЁ]+)*\.[\-A-Za-z0-9а-яёА-ЯЁ]+(;|,|$))+$/);
            break;
        case 'domain':
            error = !value.match(/^([A-Za-z0-9а-яёА-ЯЁ_\-\.])+\.([A-Za-zа-яёА-ЯЁ]{2,4})$/);
            break;
        case 'int':
            error = isNaN(parseInt(value));
            break;
        case 'filled':
            error = (typeof(value) == 'undefined' || value == '');
            break;
        case 'custom':
            oParameters = {
                'oField': oField,
                'error': false,
                'message': '',
            };
            AMI.Message.send('ON_FORM_FIELD_VALIDATE', oParameters);
              customMessage = oParameters.message;
            error = oParameters.error;
            break;
    }
    return {error: error, customMessage: customMessage};
}

AMI.Message.addListener(
    'ON_MODULE_ACTION',
    function(action, oActionData){
        if(action == 'form_save'){
            if(oActionData.oComponent == '##_component_id##'){
                var oForm = document.forms['##_mod_id##form'];
                for (var i = 0; i < oForm.elements.length; i++){
                    var oField = oForm.elements[i];
                    if(oField.className.match(new RegExp('(\\s|^)'+'htmlEditorTextarea'+'(\\s|$)'))){
                        editor_updateHiddenField(oField.name);
                        oActionData.oParameters[oField.name] = oField.value;
                    }
                }
            }
        }
        return true;
    }
);

AMI.Message.addListener(
    'ON_FORM_SUBMIT',
    function(oComponent, oParameters){
        if(oComponent.componentId == '##_component_id##'){
            var
                oForm = document.forms['##_mod_id##form'],
                error = false,
                focusField = false,
                oFirstFocusField = false;

            for (var i = 0; i < oForm.elements.length; i++){
                var oField = oForm.elements[i];
                if(oField.hasAttribute('data-ami-validators')){
                    highlight_element_as_ok(oForm, oField.name);
                }
            }

            for (var i = 0; i < oForm.elements.length; i++){
                var oField = oForm.elements[i];
                if(oField.hasAttribute('data-ami-validators')){
                    var validatorsString = oField.getAttribute('data-ami-validators');
                    var aValidators = validatorsString.split(' ');
                    for (var v = 0; v < aValidators.length; v++){
                        var validator = aValidators[v];
                        if(validator){
                            if((typeof(oField.value) == 'undefined' || oField.value == '') && !validatorsString.match(/filled/)){
                                continue;
                            }
                            aValidate = validateFormField(oForm, oField, validator);
                            if(aValidate.error){
                                error = true;
                                if(!focusField){
                                    oFirstFocusField = oField;
                                }
                                focusField = oField.name;
                                oComponent.focusAt(oField);
                                // highlight_element_as_error(oForm, oField.name);
                                if(validatorsString.match(/stop_on_error/)){
                                    message = aValidate.customMessage;
                                    if(message == ''){
                                        if(AMI.Template.Locale.get('form_field_' + oField.name + '_empty_warn') != null){
                                            message = AMI.Template.Locale.get('form_field_' + oField.name + '_empty_warn');
                                        }
                                        if(AMI.Template.Locale.get('form_field_' + oField.name + '_invalid_warn') != null){
                                            message = AMI.Template.Locale.get('form_field_' + oField.name + '_invalid_warn');
                                        }
                                    }
                                    show_error(oForm, focusField, message);
                                    return false;
                                }
                            }
                        }
                    }
                }
            }
            if(error){
            	message = '';
                if(AMI.Template.Locale.get('form_field_' + oFirstFocusField.name + '_empty_warn') != null){
                	message = AMI.Template.Locale.get('form_field_' + oFirstFocusField.name + '_empty_warn');
                }
                if(AMI.Template.Locale.get('form_field_' + oFirstFocusField.name + '_invalid_warn') != null){
                	message = AMI.Template.Locale.get('form_field_' + oFirstFocusField.name + '_invalid_warn');
				}
                show_error(oForm, oFirstFocusField.name, message);
                return false;
            }
        }
        return true;
    }
);
</script>

<div id="div_properties_form" class="main-form">
	<table id="form_table_add" ccc="1" border="0" cellpadding="0" cellspacing="0" ##if(width != '')##width="##width##"##endif## ##if(height != '')##height="##height##"##endif## style="margin-left:auto;margin-right:auto;">
		<tr id="add_left_tr">
			<td align=left id="add_left_top_img"></td>
			<td nowrap id="add_center_top_img">
				<span id="form_title" class="form-header">##header##</span>
			</td>
			<td nowrap id="add_right_info_top_img">
				<div id=stModified style="display:none;" class=form-header> [ %%modified%% ]</div>
			</td>
			<td id="add_right_top_img"></td>
		</tr>
		<tr>
			<td id="add_left_center_img"></td>
			<td class="table_sticker" valign="top">
<br>
<form data-ami-component-id="##_component_id##" id="ami_form_##_component_id##" class="form" action="##action##" method="post" enctype="multipart/form-data" name="##_mod_id##form" onsubmit="AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'form_save', this); return false;">
<input type="hidden" name="action" value="" />
<input type="hidden" name="ami_full" value="" />
<table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
<col width="150">
<col width="*">
##section_html##
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
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
</form>
			</td>
			<td id="add_right_center_img"></td>
		</tr>
		<tr>
			<td id="add_left_bot_img"></td>
			<td id="add_center_bot_img" colspan=2></td>
			<td id="add_right_bot_img"></td>
		</tr>
	</table>
</div>
"-->

##-- } form --##
