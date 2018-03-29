<!--#set var="total_row" value="
<tr id="total_##num##" clearid="##num##">
    <td>%%from%%:</td>
    <td><input type="text" name="min_total_##num##" class="field field5" value="" maxlength="10"  disabled="disabled" /></td>
    <td>&nbsp;%%to%%:</td>
    <td><input type="text" name="max_total_##num##" class="field field12" value="##max_total##" maxlength="10" onfocus="return rangeOnFocus(event, 'total', ##num##, this)" onblur="return rangeOnBlur('total', ##num##, this.value)" /></td>
    <td>&nbsp;%%range_amount_caption%%:</td>
    <td><input type="text" name="amount_total_##num##" class="field field5" value="##amount##" maxlength="10" /></td>
    <td><select name="type_total_##num##">
       ##type_options##
    </select></td>
    <td><a href="#" onclick="deleteRow('total', ##num##); return false"><img title="%%delete%%" src="skins/vanilla/icons/icon-del.gif" border="0" /></a></td>
</tr>
"-->

<!--#set var="weight_row" value="
<tr id="weight_##num##" clearid="##num##">
    <td>%%from%%:</td>
    <td><input type="text" name="min_weight_##num##" class="field field5" value="" maxlength="10"  disabled="disabled" /></td>
    <td>&nbsp;%%to%%:</td>
    <td><input type="text" name="max_weight_##num##" class="field field12" value="##max_weight##" maxlength="10" onfocus="return rangeOnFocus(event, 'weight', ##num##, this);" onblur="return rangeOnBlur('weight', ##num##, this.value);" /></td>
    <td>&nbsp;%%range_amount_caption%%:</td>
    <td><input type="text" name="amount_weight_##num##" class="field field5" value="##amount##" maxlength="10" /></td>
    <td><select name="type_weight_##num##">
       ##type_options##
    </select></td>
    <td><a href="#" onclick="deleteRow('weight', ##num##); return false"><img title="%%delete%%" src="skins/vanilla/icons/icon-del.gif" border="0" /></a></td>
</tr>
"-->

<!--#set var="value_row" value="
<tr id="value_##num##" clearid="##num##">
    <td>%%from%%:</td>
    <td><input type="text" name="min_value_##num##" class="field field5" value="" maxlength="10"  disabled="disabled" /></td>
    <td>&nbsp;%%to%%:</td>
    <td><input type="text" name="max_value_##num##" class="field field12" value="##max_value##" maxlength="10" onfocus="return rangeOnFocus(event, 'value', ##num##, this);" onblur="return rangeOnBlur('value', ##num##, this.value);" /></td>
    <td>&nbsp;</td>
    <td><select name="type_value_##num##">##available_options##</select></td>
    <td><a href="#" onclick="deleteRow('value', ##num##); return false;"><img title="%%delete%%" src="skins/vanilla/icons/icon-del.gif" border="0" /></a></td>
</tr>
"-->

<!--#set var="list_ctrl_hidden_field" value="
<input type="hidden" name="##ctrl_field_name##_source" value="##ctrl_field_value##" disabled />
<input type="hidden" name="##ctrl_field_name##" id="##ctrl_field_name##" value="##ctrl_field_value##" onChange="FormChanged(event);" disabled />
"-->

<!--#set var="list_ctrl_row_single" value="
<input type="text" name="##ctrl_field_name_single##" value="##ctrl_field_value_single##" class="field field30"  disabled />
"-->

<!--#set var="list_ctrl_row" value="
<option value="##id##"##selected##>##name##</option>
"-->

<!--#set var="CHOOSE_CHARGE_TAX_TYPE" value="
   &nbsp;
       <input type="radio" name="charge_tax_type" value="charge" ##charge_tax_type_charge##>
       %%charge_tax_type_charge%%
   &nbsp;
       <input type="radio" name="charge_tax_type" value="detach" ##charge_tax_type_detach##>
       %%charge_tax_type_detach%%
"-->

<!--#set var="option_row" value="
<option value="##id##"##selected##>##name##</option>
"-->

<!--#set var="checkbox_row" value="
<tr><td style="vertical-align:top;width:10px;padding:3px;"><input id="l_##field_name##_##id##" type="checkbox" name="##field_name##[]" value="##id##"##selected##></td><td style="padding:3px;"><label for="l_##field_name##_##id##">##name##</label></td></tr>
"-->

<!--#set var="radio_row" value="
<tr><td style="vertical-align:top;width:10px;padding:3px;"></td>
    <td style="vertical-align:top;padding:3px;">
    <input ##disabled## type="radio" id="##radio_id##" name="custom_field_groups_##parent_id##" ##checked## value="##id##"/>&nbsp;&nbsp;<label for="##radio_id##">##name##</label></td>
</tr>
"-->

<script type="text/javascript">

var editor_enable = '##editor_enable##';
var _cms_document_form = 'shippingMethodsForm';
var _cms_script_link = '##script_link##?';
var _cms_document_form_changed = false;
var _cms_form_changed_alert = "%%form_changed%%";

function OnObjectChanged_eshop_shipping_methods_form_def(name, first_change, evt){
    errFunc = OnObjectChanged_eshop_shipping_methods_form_def;

    if (name.substr(0, 14) == 'custom_fields[') {

        var form = document.forms[_cms_document_form];
        var form_elements = form.elements;
        var changed_element = document.getElementsByName(name);

        for (var i = 0 ; i < form_elements.length; i++) {
            for (var j = 0; j < changed_element.length; j++) {
                if((form_elements[i].name == 'custom_field_groups_' + changed_element[j].value)){
                    if(changed_element[j].checked){
                        form_elements[i].disabled = false;
                    }else{
                        form_elements[i].disabled = true;
                    }
                }
            }
        }
    }

    return true;
}
addFormChangedHandler(OnObjectChanged_eshop_shipping_methods_form_def);

function conditionOnChange(custom_conditions)
{
    errFunc = conditionOnChange;

    var form = document.forms[_cms_document_form];
    var commonOptionDisabled = true;
    switch (custom_conditions) {
        case 'total':
            makeElementVisible(document.getElementById('trTotals'), 'block');
            makeElementVisible(document.getElementById('trWeights'), 'none');
            makeElementVisible(document.getElementById('trValues'), 'none');
            ResortAndRecalculateMinimum(custom_conditions);
            break;
        case 'weight':
            makeElementVisible(document.getElementById('trTotals'), 'none');
            makeElementVisible(document.getElementById('trWeights'), 'block');
            makeElementVisible(document.getElementById('trValues'), 'none');
            ResortAndRecalculateMinimum(custom_conditions);
            break;
        case 'value':
            makeElementVisible(document.getElementById('trTotals'), 'none');
            makeElementVisible(document.getElementById('trWeights'), 'none');
            makeElementVisible(document.getElementById('trValues'), 'block');
            ResortAndRecalculateMinimum(custom_conditions);
            break;
        default:
            commonOptionDisabled = false;
            makeElementVisible(document.getElementById('trTotals'), 'none');
            makeElementVisible(document.getElementById('trWeights'), 'none');
            makeElementVisible(document.getElementById('trValues'), 'none');
            break;
    }
    form.elements['amount'].disabled = commonOptionDisabled;
    form.elements['type'].disabled = commonOptionDisabled;
    return true;
}

function DisableRefSelect(name) {
  if(typeof(document.shippingMethodsForm.elements[name]) == 'object') {
    document.shippingMethodsForm.elements[name].disabled = true;
  }
}

function checkForm(form){
    errFunc = checkForm;

    editor_updateHiddenField('comments');

    if (form.name.value.length < 1) {
        alert('%%warn_missing_name%%');
        form.name.focus();
        return false;
    }
    var o = form.elements;
    var custom_conditions = '';
    for (var i = 0 ; i < o.length; i++) {
        if ((o[i].name == 'custom_conditions') && o[i].checked) {
            custom_conditions = o[i].value;
            break;
        }
    }
    if (custom_conditions == 'none') {
        if (!checkFloatField('amount', '%%warn_missing_amount%%', '%%warn_invalid_amount%%')) {
            return false;
        }
    } else {
        updateOrder('total');
        updateOrder('weight');
        var ids = form.elements[custom_conditions + 'sOrder'].value;
        var qty = ids.length;
        if (qty > 0) {
            if (!ResortAndRecalculateMinimum(custom_conditions, true, true)) {
                return false;
            }
            ids = ids.split(';');
            if (qty == 1 && isNaN(targetForm.elements['max_' + custom_conditions + '_' + ids[0]].value)) {
                alert('%%warn_invalid_max_range_limit%%');
                targetForm.elements['max_' + custom_conditions + '_' + ids[0]].focus();
                return false;
            }
        }
        for (var i = 0 ; i < ids.length ; i++) {
            var namePart = custom_conditions + '_' + ids[i];
            if (typeof(o['amount_' + namePart]) != 'undefined' && !checkFloatField('amount_' + namePart, '%%warn_missing_amount%%', '%%warn_invalid_amount%%')) {
                return false;
            }
        }
    }

    if (!(typeof(form.id_tax_class) == 'undefined')) {
       form.id_tax_class.disabled = (form.id_tax_class.value == form.id_tax_class_source.value);
    }

    for (var i = 0 ; i < o.length; i++) {
        if ((o[i].id.substr(0, 16) == 'l_custom_fields_') && o[i].checked) {
            _cms_document_form_changed = false;
            return true;
        }
    }
    alert('%%warn_missing_fieldsets%%');
    baseTabs.showTab('custom_fields');
    return false;
}

</script>

<a name="pureForm"></a>
<br>
<form action="##script_link##" method="post" enctype="multipart/form-data" name="shippingMethodsForm" onSubmit="return checkForm(this);">
##form_common_hidden_fields##
##filter_hidden_fields##
<input type="hidden" id="totalsOrder" name="totalsOrder" value="##totalsOrder##" />
<input type="hidden" id="weightsOrder" name="weightsOrder" value="##weightsOrder##" />
<input type="hidden" id="valuesOrder" name="valuesOrder" value="##valuesOrder##" />
<input type="hidden" id="prices" name="prices" value="##prices##" />
<table cellSpacing="5" cellPadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
<tr>
    <td>%%name%%*:</td>
    <td><input type="text" name="name" class="field field50" value="##name##" maxlength="64" /></td>
 </tr>
<tr>
    <td>%%shipping_cost%%*:</td>
    <td><table cellPadding="0" cellSpacing="0" border="0"><tr>
        <td><input type="text" name="amount" class="field field5" value="##amount##" maxlength="10" /></td>
         <td>&nbsp;</td>
         <td><select name="type">
            ##type_options##
         </select></td>
    </tr></table></td>
</tr>
<tr>
    <td>%%shipping_period%%:<br/><small>%%shipping_period_example%%</small></td>
    <td vAlign="top"><input type="text" name="delivery_time" class="field field50" value="##delivery_time##" maxlength="255" /></td>
 </tr>
<tr style="display: none;"><td>
##taxes_module_addon##
</td></tr>
<tr><td>%%custom_conditions%%:</td><td></td></tr>
<tr style="display: none;"><td colSpan="2"><img src="skins/vanilla/images/spacer.gif" width="1" height="3"></td></tr>
<tr>
    <td colSpan="2">
        <table cellSpacing="0" cellPadding="2" border="0" width="100%" class="frm delivery_special_conditions">
	<col width="150">
	<col width="*">
        <tr>
            <td valign="top"><input type="radio" id="custom_conditions_none" name="custom_conditions" value="none"##custom_conditions_none## onclick="return conditionOnChange(this.value);" /></td>
            <td><label for="custom_conditions_none">%%custom_conditions_none%%</label></td>
        </tr>
        <tr><td colSpan="2"><img src="skins/vanilla/images/spacer.gif" width="1" height="5"></td></tr>
        <tr>
            <td><input type="radio" id="custom_conditions_total" name="custom_conditions" value="total"##custom_conditions_total## onclick="return conditionOnChange(this.value);" /></td>
            <td><label for="custom_conditions_total">%%custom_conditions_total%%</label></td>
        </tr>
        <tr id="trTotals">
            <td></td>
            <td>
                <div class="tooltip">%%combined_data_help_total%%</div>
                <table cellSpacing="0" cellPadding="2" border="0" class="frm" id="totals" style="margin-top:5px">
	<col width="150">
	<col width="*">
                ##total_list##
                </table>
                ##--<input id="button_total" type="button" class="but" style="margin-top:5px" value="%%add_range%%" onclick="addRow('total', false, this); return false;" />--##
                <span class="text_button" id="button_total"  onclick="addRow('total', false, this); return false;">%%add_range%%</span>

            </td>
        </tr>
        <tr><td colSpan="2"><img src="skins/vanilla/images/spacer.gif" width="1" height="5"></td></tr>
        <tr>
            <td><input type="radio" id="custom_conditions_weight" name="custom_conditions" value="weight"##custom_conditions_weight## onclick="return conditionOnChange(this.value);" /></td>
            <td><label for="custom_conditions_weight">%%custom_conditions_weight%%</label></td>
        </tr>
        <tr id="trWeights">
            <td></td>
            <td>
                <div class="tooltip">%%combined_data_help_weight%%</div>
                <table cellSpacing="0" cellPadding="2" border="0" class="frm" id="weights" style="margin-top:5px">
	<col width="150">
	<col width="*">
                ##weight_list##
                </table>
                <span class="text_button" id="button_weight"  onclick="addRow('weight', false, this); return false;">%%add_range%%</span>
            </td>
        </tr>
        <tr><td colSpan="2"><img src="skins/vanilla/images/spacer.gif" width="1" height="5"></td></tr>
        <tr>
            <td><input type="radio" id="custom_conditions_value" name="custom_conditions" value="value"##custom_conditions_value## onclick="return conditionOnChange(this.value);" /></td>
            <td><label for="custom_conditions_value">%%custom_conditions_value%%</label></td>
        </tr>
        <tr id="trValues">
            <td></td>
            <td>
                <div class="tooltip">%%combined_data_help_value%%</div>
                <table cellSpacing="0" cellPadding="2" border="0" class="frm" id="values" style="margin-top:5px">
    <col width="150">
    <col width="*">
                ##value_list##
                </table>
                <span class="text_button" id="button_value"  onclick="addRow('value', false, this); return false;">%%add_range%%</span>
            </td>
        </tr>
        </table>
    </td>
</tr>
##--
<tr>
    <td vAlign="top">%%regions%%*:</td>
    <td><select multiple id="regions" name="regions[]" style="width:200px;">
        ##regions##
    </select><br />
    <input type="button" class="but" onclick="return openShippingMethodsPopup(); return false;" value="%%edit_regions%%" />
    </td>
</tr>
--##
</table>
<table cellSpacing="5" cellPadding="0" border="0" class="frm">
<col width="150">
<col width="*">
<tr>
    <td colSpan="2" style="padding-top:10px">
        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-custom_fields">
            <table border="0" cellPadding="0" cellSpacing="0">
              ##custom_fields##
            </table>
            </div>
            <div class="tab-page" id="tab-page-shipping_types">
            <table border="0" cellPadding="0" cellSpacing="0">
              ##shipping_types##
            </table>
            </div>
            <div class="tab-page" id="tab-page-comments">
              <textarea class="field" style="width:100%" rows="14" name="comments" id="comments">##comments##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('comments', cmD_STB, true);}
              </script>
            </div>
          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'custom_fields' : ['%%fieldsets%%*', 'active', '', false],
              'shipping_types' : ['%%shipping_types%%', 'normal', '', false],
              'comments' : ['%%comments%%', 'normal', '', false],
          '':''});

        </script>
    </td>
</tr>
</table>
<table cellSpacing="5" cellPadding="0" border="0" class="frm">
<col width="150">
<col width="*">
<tr>
    <td colSpan="2" align="right">
        <br />
        ##form_buttons##
        <br/><br/>
    </td>
</tr>
<tr>
    <td colSpan="2"><sub>%%required_fields%%</sub></td>
</tr>
</table>
</form>

<script type="text/javascript">
isTargetFormLoaded = true;
var
    targetForm     = document.forms[_cms_document_form],
    totalsFieldId  = document.getElementById('totals').rows.length - rowOffset + 1,
    weightsFieldId = document.getElementById('weights').rows.length - rowOffset + 1,
    valuesFieldId  = document.getElementById('values').rows.length - rowOffset + 1;

conditionOnChange('##custom_conditions##');

updateOrder('total');
updateOrder('weight');
updateOrder('value');
</script>