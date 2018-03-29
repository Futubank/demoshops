##--system info: module_owner="" module="" system="1"--##
%%include_language "templates/lang/modules/_form.lng"%%

##-- form { --##

<!--#set var="hidden_field" value="<input name="##name##" value="##value##" type="hidden"##attributes## />
"-->

<!--#set var="file_field" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td>
       <div id="file_##name##"></div>
       <script type="text/javascript">
            var oUploader_##name## = new AMI.Uploader('##name##', AMI.find('#file_##name##')##if(value)##,'##value##'##endif##);
            ##IF(validators)##oUploader_##name##.setValidators('##validators##');##endif##
        </script>
    </td>
</tr>
"-->

<!--#set var="hint" value="
<a class="##if(label)##icon-template-name-filter##else##icon-template-help-filter##endif##" href="javascript:void;" onclick="return false;" id="##tooltip_id##" class="amiTooltip">##label##</a>
<script type="text/javascript">
AMI.$("###tooltip_id##").tooltip({
    bodyHandler: function(){
        return '##value##';
    },
    showURL: false
});
</script>
"-->

<!--#set var="input_field" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td><input type="text" name="##name##" class="field field50##IF(is_invalid)## fieldInvalid##ENDIF## ##classes## ##if(name == 'header')##input-header##endif##" value="##value##" ##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />##hint##</td>
</tr>
"-->

<!--#set var="password_field" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td>
        <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td><input type="password" name="##name##" class="field field50##IF(is_invalid)## fieldInvalid##ENDIF## ##classes##"
         value="##value##" ##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />##hint##</td>
            ##IF(show_password)##
            <td style="padding-top: 3px;">
                <input type="checkbox" title="%%form_field_show_password%%"
                 onclick="var oField = this.form.elements['##name##']; oField.type = 'text' === oField.type ? 'password' : 'text'; return true;" />
            </td>
            ##ENDIF##
        </tr>
        </table>
    </td>
</tr>
"-->

<!--#set var="static_field" value="
<tr>
    <td>##element_caption##:&nbsp;</td>
    <td>##value## ##hint## ##IF(name)##<input type="hidden" name="##name##" class="##classes##" disabled="disabled" />##ENDIF##</td>
</tr>
"-->

<!--#set var="input_field(caption=sublink)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td>
        <input type="text" name="##name##" class="field field56##IF(is_invalid)## fieldInvalid##ENDIF## ##classes##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
        <input type="hidden" name="original_sublink" collect_link_ignore="1" value="##value##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
    </td>
</tr>
"-->

<!--#set var="input_field(caption=html_title)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td>
        <input type="text" name="##name##" class="field field56##IF(is_invalid)## fieldInvalid##ENDIF## ##classes##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF## prop="on"##attributes## />
        <span class="input_opt" id="html_title_prop">&nbsp;</span>
        <input type="hidden" name="original_html_title" collect_link_ignore="1" value="##value##" />
    </td>
</tr>
"-->

<!--#set var="date_field" value="
<tr>
    <td width="80">##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td>
        <input type="text" name="##name##" class="field fieldDate##IF(is_invalid)## fieldInvalid##ENDIF## ##classes##" value="##value##" maxlength="30"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes####attributes_date## />
        <a href="javascript:void(0);" onclick="return getCalendar(event, document.##_mod_id##form.##name##);"><img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
    </td>
</tr>
"-->

<!--#set var="time_field" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td>
        <input type="text" name="##name##" class="field fieldTime##IF(is_invalid)## fieldInvalid##ENDIF## ##classes##" value="##value##" maxlength="5"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
    </td>
</tr>
"-->

<!--#set var="datetime_field" value="
<tr>
    <td width="80">##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td>
        <input type="text" name="##name##" class="field fieldDate##IF(is_invalid)## fieldInvalid##ENDIF## ##classes##" value="##value##" maxlength="30" helpId="form_date"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes_date##/>
        <a href="javascript:void(0);" onclick="return getCalendar(event, document.##_mod_id##form.##name##);"><img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId="clnd_date" /></a>
        <input type="text" name="##name##_time" class="field field10field##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value_time##" maxlength="10" helpId="form_time" data-ami-validators="time"##attributes_time## />
    </td>
</tr>
"-->

<!--#set var="time_period_field" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td>
        <input type="text" name="##name##_first" class="field fieldTimePeriod fieldTime##IF(is_invalid)## fieldInvalid##ENDIF## ##classes##" value="##value_first##" maxlength="5"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## /> -
        <input type="text" name="##name##_second" class="field fieldTimePeriod fieldTime##IF(is_invalid)## fieldInvalid##ENDIF## ##classes##" value="##value_second##" maxlength="5"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
        <input type="hidden" name="##name##" value="##value##" id="##name##_hidden" />
        <script type="text/javascript">
            AMI.$(function() {
                AMI.$('input[name=##name##_first],input[name=##name##_second]').change(function(){
                    var mergedValue = AMI.$('input[name=##name##_first]').val() + '-' + AMI.$('input[name=##name##_second]').val();
                    AMI.$('###name##_hidden').val(mergedValue);
                });
            });
        </script>
    </td>
</tr>
"-->

<!--#set var="checkbox_field" value="
<tr>
    <td colspan="2">
        <label>
            <input type="checkbox" id="cb_##name##" name="##name##" value="1"##checked## class="##filter_class## ##classes##" helpId="form_##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
            ##element_caption####IF(validator_filled)##*##ENDIF##
        </label>
    </td>
</tr>
"-->

<!--#set var="checkbox_wide_field" value="
<tr>
    <td colspan="2">
        <label>
            <input type="checkbox" id="cb_##name##" name="##name##" value="1"##checked## class="##filter_class## ##classes##" helpId="form_##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
            ##element_caption####IF(validator_filled)##*##ENDIF##
        </label>
    </td>
</tr>
"-->

<!--#set var="textarea_field(caption='html_keywords')" value="
<tr>
    <td valign="top" width="250">##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td class="seo">
        <textarea name="##name##" class="field##IF(is_invalid)## fieldInvalid##ENDIF## ##classes##" wrap="soft" cols="##cols##" rows="##rows##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##value##</textarea>
        <span class="input_opt" id="html_keywords_prop">&nbsp;</span>
        <input type="hidden" name="original_html_keywords" collect_link_ignore="1" value="##value##" />
    </td>
</tr>
"-->

<!--#set var="textarea_field(caption='html_description')" value="
<tr>
    <td valign="top" width="250">##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td class="seo">
        <textarea name="##name##" class="field##IF(is_invalid)## fieldInvalid##ENDIF## ##classes##" wrap="soft" cols="##cols##" rows="##rows##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##value##</textarea>
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
            <input type="checkbox" name="##name##" id="##name##" value="1"##checked## class="##filter_class## ##classes##" helpId="form_##name##"##if(validators)## data-ami-validators="##validators##"##endif####attributes## />
            ##element_caption####IF(validator_filled)##*##ENDIF##
        </label>
    </td>
</tr>
"-->


<!--#set var="textarea_field" value="
<tr>
    <td colspan="2">##element_caption####IF(validator_filled)##*##ENDIF##:<br />
        <textarea name="##name##" class="field##IF(is_invalid)## fieldInvalid##ENDIF## ##classes##" wrap="soft" cols="##cols##" rows="##rows##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##value##</textarea>
    </td>
</tr>
"-->

<!--#set var="htmleditor_field" value="
<tr>
    <td colspan="2">##if(show_caption)####element_caption####IF(validator_filled)##*##ENDIF##:<br />##endif##
        <textarea autocomplete="off" name="##name##" id="form_##name##" class="field##IF(is_invalid)## fieldInvalid##ENDIF## ##classes##" wrap="soft" style="width:100%" ##if(rows)## rows="##rows##"##else## rows="14"##endif####IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##value##</textarea>
        <script type="text/javascript">
            if(editor_generate != 'undefined'){
                editor_generate('form_##name##', cmD_STB, true, 0, 0, ##ce_modes##);
            }
        </script>
    </td>
</tr>
"-->

<!--#set var="select_field" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td><select name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##select##</select>##hint##</td>
</tr>
"-->

<!--#set var="select_field(name=id_page)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td><select id="id_##name##" name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## onclick="AMI.$('#commonFieldTooltip')[(AMI.$(this).val() > 0) ? 'hide' : 'show']();">##select##</select>
        <div class="tooltip" style="margin-top: 5px; margin-right: 0px; margin-bottom: 5px; margin-left: 0px; display: ##if(value>0)##none##else##block##endif##; " id="commonFieldTooltip">%%common_page_noindex%%</div>
    </td>
</tr>
"-->

<!--#set var="select_field_row" value="<option value="##value##"##attributes## ##selected##>##caption##</option>"-->

<!--#set var="radio_field" value="
<tr>
    <td style="vertical-align: top; width:10px; padding: 3px;">##element_caption##:&nbsp;</td>
    <td>##select##</td>
</tr>
"-->

<!--#set var="radio_field_row" value="<input ##disabled## type="radio" id="##id##" name="##name##" ##checked## value="##value##" />&nbsp;&nbsp;<label for="##id##">##caption##</label><br>"-->

<!--#set var="form_buttons" value="<div id="form-buttons">##cancel_btn## ##add_btn## ##save_btn## ##apply_btn##</div>"-->

<!--#set var="add_btn" value="<input type="submit"##-- name="add"--## value="%%add_btn%%" class="but" onclick="this.form.elements['ami_full'].value = 1;this.form.action.value='add'"##attributes## />
"-->

<!--#set var="apply_btn" value="<input type="submit"##--  name="apply"--## value="%%apply_btn%%" class="but" onclick="this.form.elements['ami_full'].value = 1;this.form.action.value='apply'"##attributes## />
"-->

<!--#set var="save_btn" value="<input type="submit"##--  name="save"--## value="%%ok_btn%%" class="but" onclick="this.form.elements['ami_full'].value = 1;this.form.action.value='save'"##attributes## />
"-->

<!--#set var="cancel_btn" value="
<input type="reset"##--  name="cancel"--## value="%%cancel_btn%%" class="but" onclick="AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'form_reset', this.form); return false;"##attributes## />
"-->

<!--#set var="tabset" value="
<tr id="tab-row-##name##"><td colspan="2">
<div class="tab-control" id="tab-control-##name##" onselectstart="return false;"></div>
<div class="tabs-container">
##section_html##
</div>
<script type="text/javascript">
  var baseTabs = new cTabs('tab-control-##name##', {##tab_array##'': ''});
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

<!--#set var="checkbox_field(name=sticky)" value="
<tr>
    <td colspan="2" style="padding-left:1px !important">
        <table>
        <tr>
            <td style="padding-left:0px !important;">
                <input style="margin-left: 1px;" type="checkbox" name="sticky" onchange="if(!stickyFromLabel){stickyClick();}stickyFromLabel = false;return true;" id="form_cb_sticky" value="1"##checked## class="##filter_class## ##classes##" helpId="form_##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
                <label for="form_cb_sticky" onclick="stickyFromLabel = true;stickyClick();">
                    ##element_caption####IF(validator_filled)##*##ENDIF##
                </label>
            </td>
"-->

<!--#set var="date_field(name=date_sticky_till)" value="
        <td>
            <table cellspacing="0" cellpadding="0">
            <tr>
                <td width="80" align="right">##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
                <td>
                    <input type="text" name="##name##" id="##name##" class="field fieldDate##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="30"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
                    <a href="javascript:void(0);" onclick="return getCalendar(event, document.##_mod_id##form.##name##);"><img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
                </td>
            </tr>
            </table>
        </td>
        </tr>
        </table>
        <script type="text/javascript">
            var stickyFromLabel = false;

            function stickyClick(onInit){
                var
                    oStickyCheckbx = AMI.find("#form_cb_sticky"),
                    oHideInListCheckbox = AMI.find("#cb_hide_in_list");

                onInit = typeof(onInit) != 'undefined' && onInit;

                if(onInit){
                    if(oStickyCheckbx.checked){
                        oHideInListCheckbox.setAttribute('srcChecked', 0);
                        oHideInListCheckbox.checked = true;
                    }
                    AMI.find('#date_sticky_till').disabled = !oStickyCheckbx.checked;
                    oHideInListCheckbox.disabled = oStickyCheckbx.checked;
                }else{
                    var checked = stickyFromLabel ? oStickyCheckbx.checked : !oStickyCheckbx.checked;
                    if(checked){
                        oHideInListCheckbox.checked = parseInt(oHideInListCheckbox.getAttribute('srcChecked'));
                    }else{
                        oHideInListCheckbox.setAttribute('srcChecked', oHideInListCheckbox.checked ? 1 : 0);
                        oHideInListCheckbox.checked = true;
                    }
                    AMI.find('#date_sticky_till').disabled = checked;
                    oHideInListCheckbox.disabled = !checked;
                }
            }
            stickyClick(true);
        </script>
    </td>
</tr>
"-->

<!--#set var="section_form" value="
<script type="text/javascript">
##scripts##
var
    _cms_document_form = 'ami_form_##_component_id##',
    _cms_document_form_changed = false;
</script>
<div id="div_properties_form" class="main-form">
    <table ccc="1" border="0" cellpadding="0" cellspacing="0" ##if(width != '')##width="##width##"##endif## ##if(height != '')##height="##height##"##endif## class="main-form__table properties_form_table" style="margin: 0 auto;">
    <tr class="properties_form_title">
        <td align=left id="add_left_top_img"></td>
        <td nowrap id="add_center_top_img">
            <span id="form_title" class="form-header">##header##</span>
        </td>
        <td nowrap id="add_right_info_top_img">
            <div id="stModified" style="display: none;" class="form-header"> [ %%modified%% ]</div>
        </td>
        <td id="add_right_top_img"></td>
    </tr>
    <tr>
        <td id="add_left_center_img"></td>
        <td colspan="2" class="table_sticker" valign="top">
            <br />
            <form data-ami-component-id="##_component_id##" id="ami_form_##_component_id##" class="form" action="##action##" method="post" enctype="multipart/form-data" name="##_mod_id##form" onsubmit="AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'form_save', this); return false;">
                <input type="hidden" name="action" value="" />
                <input type="hidden" name="ami_full" value="" />
                <table cellspacing="0" cellpadding="0" border="0" class="frm template_form_table" width=100%>
                    <col class="first_column">
                    <col class="second_column">
                    ##section_html##
                </table>
                <table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
                    <col width="150">
                    <col width="*">
                ##IF(form_buttons)##
                <tr id="tr-form-buttons">
                    <td colspan="2" align="right">##form_buttons##</td>
                </tr>
                ##ENDIF##
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

##-- form_show { --##

<!--#set var="input_field(form_mode=show)" value="
<tr>
    <td>##element_caption##:&nbsp;</td>
    <td>##value##</td>
</tr>
"-->

<!--#set var="date_field(form_mode=show)" value="
<tr>
    <td width="80">##element_caption##:&nbsp;</td>
    <td>##value##</td>
</tr>
"-->

<!--#set var="datetime_field(form_mode=show)" value="
<tr>
    <td width="80">##element_caption##:&nbsp;</td>
    <td>##value##&nbsp;##value_time##</td>
</tr>
"-->

<!--#set var="file_field(form_mode=show)" value="
<tr>
    <td>##element_caption##:&nbsp;</td>
    <td>##value##</td>
</tr>
"-->

<!--#set var="checkbox_field(form_mode=show)" value="
<tr>
    <td>##element_caption##:&nbsp;</td>
    <td>
        <input type="checkbox" id="cb_##name##" name="##name##" value="1"##checked## class="##filter_class##" helpId="form_##name##"##attributes## disabled="disabled"/>
    </td>
</tr>
"-->

<!--#set var="textarea_field(form_mode=show)" value="
<tr>
    <td colspan="2">##element_caption##:<br />
        <div>##value##</div>
    </td>
</tr>
"-->

<!--#set var="htmleditor_field(form_mode=show)" value="
<tr>
    <td colspan="2">##if(show_caption)####element_caption##:<br />##endif##
        <div>##value##</div>
    </td>
</tr>
"-->

<!--#set var="select_field(form_mode=show)" value="
<tr>
    <td>##element_caption##:&nbsp;</td>
    <td>##value##</td>
</tr>
"-->

<!--#set var="select_field_row(form_mode=show)" value=""-->

<!--#set var="radio_field(form_mode=show)" value="
<tr>
    <td style="vertical-align: top; width:10px; padding: 3px;">##element_caption##:&nbsp;</td>
    <td>##value##</td>
</tr>
"-->

<!--#set var="radio_field_row(form_mode=show)" value="<input disabled="yes" type="radio" id="##id##" name="##name##" ##checked## value="##value##" />&nbsp;&nbsp;<label for="##id##">##caption##</label><br>"-->

<!--#set var="section_form(form_mode=show)" value="
<div id="div_properties_form" class="main-form">
        <table ccc="1" border="0" cellpadding="0" cellspacing="0" ##if(width != '')##width="##width##"##endif## ##if(height != '')##height="##height##"##endif## style="margin-left:auto;margin-right:auto;" class="main-form__table properties_form_table">
                <tr class="properties_form_title">
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
                        <td colspan=2 class="table_sticker" valign="top">
<br>
<table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
<col width="150">
<col width="*">
##section_html##
</table>

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

##-- } form_show --##

<!--#set var="section_form(form_type=none)" value="##section_html##"-->

<!--#set var="hint_field(name=no_categories_usage)" value="
<br /><br />
<div style="text-align:center;">
    <div style="
        width: 440px !important;
        margin: 5px auto 0px auto !important;
        font-family: Tahoma !important;
        font-size: 12px !important;
        border-radius: 10px !important;
        border: 2px black solid !important;
        border-color: red !important;
        padding: 10px !important;
        color: #000 !important;
        background-color: #eee !important;
        visibility: visible !important;
        opacity: 1 !important;
        display: block !important;
        text-align:left;
    ">
    <div style="color: #333 !important; font-size: 16px !important; text-align: center;">%%no_categories_usage_header%%</div>
    <p><br />%%no_categories_usage_content%%</p>
    </div>
</div>
"-->
