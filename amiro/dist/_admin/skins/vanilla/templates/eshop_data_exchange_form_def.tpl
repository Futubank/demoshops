%%include_language "templates/lang/audit_form.lng"%%

<style type="text/css">
input.smallCheckBox {
    margin-top: 2px;
}
tr.metaAlert {
    background-color: pink;
}
FORM#exchange_form{
  opacity: 0.3;
}
</style>


<script type="text/javascript">
function checkImportModeEshop(drvName, oInputRadio){
    if(drvName.indexOf('CSVEshopDriver') >= 0){
        wizardTabIsAllowed = oInputRadio.value == 'eshop_item';
        enableWizardTab(false);
    }
    return checkImportMode(drvName);
}
</script>

<!--#set var="audit_owner_hidden" value="
<input type=hidden name="audit_current_owner" id="audit_current_owner" value="0">
<input type=hidden name="audit_new_owner" value="0">

<script type="text/javascript">
  function ShowAuditOwnerText() {
    errFunc = ShowAuditOwnerText;
    document.getElementById("audit_text_owner").style.display = "inline";
    if(document.getElementById("audit_select_owner") != null) {
      document.getElementById("audit_select_owner").style.display = "none";
      document.getElementById("audit_select_owner").style.disabled = true;
    }
  }
</script>

<div id="audit_text_owner" style="display:none;">
<input name="audit_owner_name" type=text readonly class=field maxlength="30" helpId="audit_owner_name" value="%%audit_default_owner%%" >
</div>
<a href="javascript:void(0);" onClick="ShowAuditOwnerText();openExtDialog('%%audit_owner_select%%', 'members_popup.php?owner_id='+encodeURIComponent(document.getElementById('audit_current_owner').value), 1); return false;"><img title="%%audit_members_popup%%" border="0" src="skins/vanilla/icons/icon_small_users.gif" helpId="audit_members_popup" align=absmiddle class=icon></a>
"-->

<!--#set var="audit_owner_single" value="
##hidden_field##

<script type="text/javascript">
  ShowAuditOwnerText();
</script>
"-->

<!--#set var="audit_owner_row" value="
<option value="##id##" ##if(SELECTED_ITEM==1)## selected ##endif##>##username##, ##firstname## ##lastname##</option>
"-->

<!--#set var="audit_owner_list" value="
<div id="audit_select_owner" style="display:inline;">
<select name="audit_owner" OnChange="ChangeAuditOwner(this);">
<option value=0>%%audit_default_owner%%</option>
##list##
</select>
</div>

<script type="text/javascript">

  oldAuditOwnerSelIndex = document.forms[_cms_document_form].elements["audit_owner"].selectedIndex;

  function ChangeAuditOwner(selectCtrl) {
    if(oldAuditOwnerSelIndex == 0 || confirm('%%audit_change_owner_warn%%')) {
      document.forms[_cms_document_form].elements["audit_new_owner"].value = selectCtrl.value;
    } else {
      selectCtrl.selectedIndex = oldAuditOwnerSelIndex;
    }
  }
</script>

##hidden_field##
"-->

<!--#set var="audit_owner" value="
<tr name="import_eshop_item">
  <td>%%audit_owner%%:&nbsp;</td>
  <td colspan=2>##audit_owner##</td>
</tr>
"-->


<!--#set var="import_module_form" value="
<tr id="id_tr_eshop_additional_params">
  <td colspan=3><br><b>%%eshop_additional_params%%</b><br><br>
  </td>
</tr>
<tr name="import_mode">
<td>%%imported_data%%:</td>
<td>
##--<select name="module">
<option value="eshop_item">%%eshop_catalogue%%</option>
<option value="eshop_user">%%eshop_users%%</option>
<option value="eshop_order">%%eshop_orders%%</option>
</select>--##
<input name="module" id="id_module_eshop_item" type="radio" value="eshop_item" selected OnClick="return checkImportModeEshop(document.forms[_cms_document_form].import_driver.value, this);"><label for="id_module_eshop_item">%%eshop_catalogue%%</label>
<input name="module" id="id_module_eshop_user" type="radio" value="eshop_user" OnClick="return checkImportModeEshop(document.forms[_cms_document_form].import_driver.value, this);"><label for="id_module_eshop_user">%%eshop_users%%</label>
<input name="module" id="id_module_eshop_order" type="radio" value="eshop_order" OnClick="return checkImportModeEshop(document.forms[_cms_document_form].import_driver.value, this);"><label for="id_module_eshop_order">%%eshop_orders%%</label>
</td>
</tr>
<tr name="import_eshop_item">
  <td>%%dest_category%%:&nbsp;</td>
  <td colspan=2><select name="cat_id">
  ##categories_list##
  </select></td>
</tr>
<tr name="import_eshop_item">
  <td>%%delete_mode%%:&nbsp;</td>
 <td colspan=2><select name="delete_mode">
    <option value="none">%%delete_none%%</option>
    <option value="del_in_cat">%%delete_all%%</option>
    <option value="items">%%delete_items%%</option>
##if(empty(audit_owner))##
    <option value="notmodif_items">%%delete_notmodif_items%%</option>
##else##
    <option value="owner_notmodif_items">%%delete_owner_notmodif_items%%</option>
##endif##
  </select></td>
</tr>
<tr name="import_eshop_item">
  <td colspan="3"><label for="id_meta_update">%%meta_update_mode%%</label>:&nbsp;<input type="checkbox" id="id_meta_update" name="meta_update" checked="checked" />
   </td>
</tr>
##import_module_form_extension##
"-->

<!--#set var="export_eshop_item_form" value="
<tr name="export_eshop_item">
<td colspan="3" style="padding-left: 40px">%%eshop_catalogue%%</td>
</tr>
"-->

<!--#set var="export_eshop_order_form" value="
<tr name="export_eshop_user">
<td colspan="3" style="padding-left: 40px">%%eshop_orders%%</td>
</tr>
##--
<tr>
<td colspan="3" style="padding-left: 40px">
  <table cellspacing="0" cellpadding="0" border="0" id="export_eshop_order">
  <tr>
    <td>%%order_date_from%%:</td>
    <td id="export_eshop_order">
      <nobr><input type=text name=order_date_from class='field fieldDate' value="##order_date_from##" maxlength="30" helpId= "order_date_from" id="export_eshop_order"/>
      <a href="javascript: void(0);" onclick="return getCalendar(event, document.forms[_cms_document_form].order_date_from);"><img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId= "clnd_date"/></a></nobr>
    </td>
  </tr>
  <tr>
    <td>%%order_date_to%%:</td>
    <td id="export_eshop_order">
      <nobr><input type=text name=order_date_to class='field fieldDate' value="##order_date_to##" maxlength="30" helpId= "order_date_to" id="export_eshop_order" />
      <a href="javascript: void(0);" onclick="return getCalendar(event, document.forms[_cms_document_form].order_date_to);"><img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId= "clnd_date"/></a></nobr>
    </td>
  </tr>
  </table>
 </td>
</tr>--##
"-->


<!--#set var="export_eshop_user_form" value="
<tr name="export_eshop_user">
<td colspan="3" style="padding-left: 40px">%%eshop_users%%</td>
</tr>
"-->

<!--#set var="wizard_js" value="
var
    wizardTabIsAllowed = ##wizardTabIsAllowed##,
    wizardDrivers = '##wizardDrivers##'.split(','),
    wizardStep = '##wizardStep##'
    wizardTabConfigTitle = '',
    wizardDataMetaCSV = ##data_meta_csv##,
    wizardDataFirstLine = ##data_first_line##;

function enableWizardTab(isConfigTabActive){
    if(!AMI.find('#tab-control-config')){
        return false;
    }
    //baseTabs.setTabState('config', wizardTabIsAllowed ? 'normal' : 'disabled');
	
    if(wizardTabConfigTitle == '') {
        wizardTabConfigTitle = AMI.find('#tab-control-config').title;
    }
    //document.getElementById('tab-control-config').title = wizardTabIsAllowed ? '' : wizardTabConfigTitle;

    var oForm = AMI.find('#'+_cms_document_form);
    oForm.config.style.display = isConfigTabActive && (wizardStep > 0) ? 'inline' : 'none';
    oForm.run.style.display = isConfigTabActive || (wizardStep > 0) ? 'none' : 'inline';

    if (wizardStep > 0) {
        AMI.find('#required_fields').style.display = 'none';
        baseTabs.setTabState('export', 'disabled');
    }
	//baseTabs.setTabState('config', 'normal');
}

function onTabSelectedCustom(tab, bState){
    var res = true;
    if(bState){
        switch(tab) {
            case 'import':
                setExchangeType('import');
                enableWizardTab(false);
                break;
            case 'config':
                enableWizardTab(bState);
                //res = wizardTabIsAllowed;
				//if (AMI.find('#import_driver_v2')){                
                    //AMI.find('#import_driver_v2').value = wizardDrivers[0];
                //}
				//changeDrive('import', wizardDrivers[0]);
                break;
            case 'export':
                res = wizardStep == 0;
                if(res){
                    setExchangeType('export');
                }
                enableWizardTab(false);
                break;
        }
    }
    return res;

}

##--
function onChangeDrive(type, driverName){
    //wizardTabIsAllowed = type == 'export' ? false : (wizardDrivers.indexOf(driverName) > -1);
	wizardTabIsAllowed = true; 
    if(wizardTabIsAllowed){
        var modules = ['eshop_user', 'eshop_order'];
        for(var i = 0; i < 2; i++){
            if(
                document.getElementById('id_module_' + modules[i]) &&
                document.getElementById('id_module_' + modules[i]).checked
            ){
                wizardTabIsAllowed = false;
                break;
            }
        }
    }
    if (wizardTabIsAllowed) {
        var oSelect = document.getElementById('import_driver');
        //document.getElementById('wizardCurrentDriver').innerHTML = oSelect.options[oSelect.selectedIndex].text;
    }
    //enableWizardTab(false);
	enableWizardTab(true);
    return true;
}

function onChangeDrive(type, driverName){
    wizardTabIsAllowed = type == 'export' ? false : (wizardDrivers.indexOf(driverName) > -1);
    if(wizardTabIsAllowed){
        var modules = ['eshop_user', 'eshop_order'];
        for(var i = 0; i < 2; i++){
            if(
                document.getElementById('id_module_' + modules[i]) &&
                document.getElementById('id_module_' + modules[i]).checked
            ){
                wizardTabIsAllowed = false;
                break;
            }
        }
    }
    /*
    if (wizardTabIsAllowed) {
        var oSelect = document.getElementById('import_driver');
        document.getElementById('wizardCurrentDriver').innerHTML = oSelect.options[oSelect.selectedIndex].text;
    }
    */
	enableWizardTab(wizardTabIsAllowed);
    return true;
}

--##


function wizardSetImportTabAccess(bAccessDisabled)
{
    var
        oForm = document.getElementById(_cms_document_form),
        aFields = ['radio_data_source_type_file', 'data_source_type_file', 'put_to_ftp', 'data_source_ftp', 'rapid_delim', 'delim'];

    for (var i = 0, q = aFields.length ; i < q ; i++) {
        if (oForm.elements[aFields[i]]) {
            oForm.elements[aFields[i]].disabled = bAccessDisabled;
        }
    }
    oForm = null;
}

##--
function wizardBodyOnReady(){
  if (wizardStep > 0) {
    AMI.find('#'+_cms_document_form).style.opacity = '0.4';
  }
}
--##

function wizardBodyOnLoad()
{
    var oForm = document.getElementById(_cms_document_form);
    oForm.style.opacity='1';
    if (wizardStep > 0) {
        document.getElementById('tab-control-config').title = '';
        baseTabs.showTab('config');
        oForm.run.style.display = 'none';
        oForm.run.disabled = true;
        if (oForm.data_source_ftp) {
            wizardSetImportTabAccess(true);
        }
        var
            aRows = document.getElementById('id_table_import').rows,
            startRowIndex = document.getElementById('id_tr_eshop_additional_params').rowIndex,
            nameTail = '_import';
        for (var i = startRowIndex, q = aRows.length ; i < q ; i++) {
            if (aRows[i].name) {
                var len = aRows[i].name.length;
                if (len > 0 && aRows[i].name.indexOf(nameTail) == len - nameTail.length) {
                    break;
                }
            }
            makeElementVisible(aRows[i], 'none');
        }
        oForm = null;
        var funcName = 'wizardBodyOnLoadStep' + wizardStep;
        eval("if (typeof(" + funcName + ") == 'function') { " + funcName + "();}");
    }
    
}
window.onload = wizardBodyOnLoad;
##--//AMI.$(document).ready(wizardBodyOnReady());--##

"-->

<!--#set var="wizard_tabs_line" value="##-- is not required more --##"-->

<!--#set var="wizard_tabs" value="'config' : ['%%config_wizard%%', 'normal', '##--%%to_start_config_wizard%%--##', true],
"-->

<!--#set var="wizard_tabs_content" value="
<div class="tab-page" id="tab-page-config" style="min-width: 680px;">
    <table cellspacing="10" cellpadding="0" border="0">
    ##--<tr><td><br><h1>%%driver_list%%: <span id="wizardCurrentDriver"></span></h1></td></tr>--##
    <tr valign="top" height="210">
        <td><div>##wizard_tab_content##</div></td>
    </tr>
    </table>
</div>
"-->

<!--#set var="wizard_buttons" value="
    ##if(wizardStep == 1)##
        <button id="config_cancel" name="config_cancel" class="but" onClick="window.location='##script_link##';return false;">%%btn_config_cancel%%</button>
    ##endif##
    ##if(wizardStep > 1)##
    <script type="text/javascript">
        function wizardBack(oForm) {
            for (var i = 0, q = oForm.elements.length ; i < q ; i++) {
                    if(oForm.elements[i].name != null && oForm.elements[i].name.indexOf('step') == 0) {
                    oForm.elements[i].value -= 2;
                }
                oForm.elements[i].disabled = false;
            }
            oForm.method = 'post';
            oForm.action.value = 'config';
            oForm.onsubmit = '';
            oForm.submit();
        }
    </script>
    <button id="config_back" name="config_back" class="but" onClick="wizardBack(this.form);return false;">%%btn_config_previous%%</button>
    ##endif##
    <button id="config" name="config" class="but" onClick="wizardOnSubmit(this.form);return false;" style="display:none">%%btn_config_next%%</button>
"-->

<!--#set var="wizard_option_step0" value="
<script type="text/javascript">
function onSubmitStep0(oForm)
{
    //AMI.find('#import_driver').value = AMI.find('#import_driver_v2').value;
    AMI.find('#import_driver').value = wizardDrivers[0];
    oForm.method = 'post';
    oForm.action.value = 'config';
    oForm.onsubmit = '';
    oForm.step.value = 1;
    oForm.submit();
}
</script>
<input type="hidden" name="step" value="0" />
<div class="tooltip">%%wizard_step0_tooltip%%</div>
<br>
<table cellspacing="5" cellpadding="0" border="0">
##--
	<tr>
	 <td>&nbsp;</td>
	 <td>
	  %%driver_list%%:
	 </td>
	 <td>
		<div id="import_driver_block">
			<select id="import_driver_v2" name="import_driver_v2" style="width:245px;">
              <script>
                document.write(AMI.find('#import_driver').innerHTML);
                for(i=0;i<AMI.find('#import_driver_v2').getElementsByTagName('option').length;i++) {
                  AMI.find('#import_driver_v2').getElementsByTagName('option')[i].style.display = 'none';
                  if(i == 1 || i == 4){
                    AMI.find('#import_driver_v2').getElementsByTagName('option')[i].style.display = 'block';
                  }
                }
                AMI.find('#import_driver_v2').value = AMI.find('#import_driver_v2').getElementsByTagName('option')[1].value;
              </script>
			</select>
		</div>
	 </td>
   </tr>
   <tr><td><br></td></tr>
   --##

    <tr>
	 <td><b>%%data_source%%:</b></td>
	 <td>
	  <label id="radio_data_label"><input type="radio" id="radio_data_source_type_file_v2" name="data_source_type_v2" value="file">%%source_file%%</label>:
	 </td>
	 <td>
            <input id="data_source_type_file_v2" type="file" name="data_source_file_v2" class=field onclick="AMI.find('#radio_data_source_type_file_v2').checked=true;"/>
	 </td>
   </tr>
   <tr>
	 <td>&nbsp;</td>
	 <td>
	  <label id="radio_data_label"><input type="radio" id="radio_data_source_type_ftp_v2" name="data_source_type_v2" value="ftp" checked>%%source_ftp%%</label>:
	 </td>
	 <td>
		<div id="data_source_type_ftp">
			<select id="id_data_source_ftp_v2" name="data_source_ftp_v2" style="width:245px;">
				<script>document.write(AMI.find('#id_data_source_ftp').innerHTML)</script>
			</select>
		</div>
	 </td>
   </tr>
</table>
<script>

AMI.find('#radio_data_label').onclick = function () {AMI.find('#radio_data_source_type_ftp').checked = 'checked';}
AMI.find('#radio_data_source_type_ftp').onclick = function () {AMI.find('#radio_data_source_type_ftp_v2').checked = 'checked';}
AMI.find('#radio_data_source_type_file').onclick = function () {AMI.find('#radio_data_source_type_ftp_v2').checked = '';}

AMI.find('#id_data_source_ftp').setAttribute('onchange','ex(this.value, "ftpOne")');
AMI.find('#id_data_source_ftp_v2').setAttribute('onchange','ex(this.value, "ftpTwo")');


function ex(val, typef) {
	if(typef == 'ftpOne') {
		for(i=0;i<AMI.find('#id_data_source_ftp_v2').getElementsByTagName('option').length;i++) {
			if(AMI.find('#id_data_source_ftp_v2').getElementsByTagName('option')[i].value == val) {
				AMI.find('#id_data_source_ftp_v2').getElementsByTagName('option')[i].selected = 'selected'
			}
		}
	} else {
		for(i=0;i<AMI.find('#id_data_source_ftp').getElementsByTagName('option').length;i++) {
			if(AMI.find('#id_data_source_ftp').getElementsByTagName('option')[i].value == val) {
				AMI.find('#id_data_source_ftp').getElementsByTagName('option')[i].selected = 'selected'
			}
		}
	}
	AMI.find('#radio_data_source_type_ftp').checked = 'checked';
	AMI.find('#radio_data_source_type_ftp_v2').checked = 'checked';	
}

##--


AMI.find('#import_driver').setAttribute('onchange','exi(this.value, "importDriver")');

AMI.find('#import_driver_v2').setAttribute('onchange','exi(this.value, "importDriver2")');

function exi(val, typef) {
	if(typef == 'importDriver') {
		for(i=0;i<AMI.find('#import_driver_v2').getElementsByTagName('option').length;i++) {
			if(AMI.find('#import_driver_v2').getElementsByTagName('option')[i].value == val) {
				AMI.find('#import_driver_v2').getElementsByTagName('option')[i].selected = 'selected'
			}
		}
	} else {
		for(i=0;i<AMI.find('#import_driver').getElementsByTagName('option').length;i++) {
			if(AMI.find('#import_driver').getElementsByTagName('option')[i].value == val) {
				AMI.find('#import_driver').getElementsByTagName('option')[i].selected = 'selected'
			}
		}
	}
}
--##
</script>
<br>
<br>
<button name="wizard_start" class="but but-130" onClick="onSubmitStep0(this.form);">%%btn_config_start%%</button>
"-->

<!--#set var="wizard_option_value_step1" value="
    <tr><td><input id="chk_##group##_##field##" type="checkbox" name="wizard_##group##[##field##]" class="smallCheckBox"##checked## /></td><td style="padding:0px"><label for="chk_##group##_##field##" title="##field##">##caption##</label></td></tr>
"-->

<!--#set var="wizard_option_value_custom_field_step12" value="<i>##caption## (##type##)</i>"-->

<!--#set var="wizard_option_group_step1" value="
<td valign="top">
    <table cellpadding="0" cellspacing="0" border="0">
        <tr><td colspan="2"><hr /></td></tr>
        <tr><td><input id="ow_##group##" type="checkbox" name="ow_##group##" class="smallCheckBox" detectchanges="off" onclick="return wizardCheckboxOnClick(this);" title="%%check_uncheck_group%%" /></td><td style="padding:0px"><h3><label for="ow_##group##" title="%%check_uncheck_group%%">##caption##</label></h3></td></tr>
        <tr><td colspan="2"><hr /></td></tr>
        ##fields##
    </table>
</td>
"-->

<!--#set var="wizard_option_step1" value="
<script type="text/javascript">
function wizardCheckboxOnClick(oInput)
{
    var
        name = oInput.name,
        state = document.getElementById(name).checked,
        oForm = document.forms[_cms_document_form],
        namePart = 'chk_' + name.substr(3) + '_';
    for (var i = 0, q = oForm.elements.length ; i < q ; i++) {
        if (oForm.elements[i].id.indexOf(namePart) == 0) {
            oForm.elements[i].checked = state;
        }
    }
    return true;
}

function wizardOnSubmit(oForm)
{
    var errFunc = wizardOnSubmit;

    // validate checked fields
    var
        aParts = new Array('cats', 'items'),
        pQ = aParts.length,
        notChecked = true;
    for (var i = 0, q = oForm.elements.length ; i < q ; i++) {
        for (j = 0 ; j < pQ ; j++) {
            if (oForm.elements[i].id.indexOf('chk_' + aParts[j]) == 0 && oForm.elements[i].checked) {
                notChecked = false;
                break;
            }
        }
        if (!notChecked) {
            break;
        }
    }
    if (notChecked) {
        alert('%%warn_wizard_check_fields%%');
        return false;
    }
    baseTabs.showTab('import');

    // validate import fields (file)
    oForm.import_driver.disabled = false;
    wizardSetImportTabAccess(false);
##--    if (CheckForm(oForm, true)) {
        baseTabs.showTab('config');--##
        oForm.method = 'post';
        oForm.action.value = 'config';
        oForm.onsubmit = '';
        oForm.submit();
##--    } else {
        alert('%%warn_wizard_return_to_tab%%');
    }--##
}
</script>
<div>
    <h1>%%wizard_step%% 1: %%wizard_step1_header%%</h1>
<br /><div class="tooltip">%%wizard_step1_tooltip%%</div><br />
    <input type="hidden" name="step" value="2" />
    <table cellpadding="0" cellspacing="0" border="0" align="center" style="padding-bottom: 3px;">
    <tr>##html##</tr>
    </table>
</div>
"-->

<!--#set var="wizard_option_row" value="<option value="##value##"##selected##>##caption##</option>
"-->

<!--#set var="wizard_option_value_price_header_step2" value="
<tr id="price_type_##price_number##"><td>&nbsp;</td><td colspan="4"><i><b>%%field_cats_other_price%% ##price_number##</b></i></td></tr>
"-->

<!--#set var="wizard_reference_extra_parameters_step2" value="
%%wizard_reference_operation%% <span id="q_##ref_field##" class="wizard_reference_operation" onmouseover="showAlt(this.id, this.className);" onmouseout="hideAlt(this.id, this.className);">?</span>:
<span class="popup-tooltip" style="display: none;" id="b_q_##ref_field##"></span>
<select name="wizard_extra[##group##][##ref_field##]">##extra_options##</select>
"-->

<!--#set var="wizard_image_extra_parameters_step2" value="
%%wizard_images_source%% <span id="q_##ref_field##" class="wizard_images_source" onmouseover="showAlt(this.id, this.className);" onmouseout="hideAlt(this.id, this.className);">?</span>:
<span class="popup-tooltip" style="display: none;" id="b_q_##ref_field##"></span>
<select name="wizard_extra[##group##][##ref_field##]">##extra_options##</select>
"-->

<!--#set var="wizard_meta_alert_attributes_step2" value=" class="metaAlert" title="%%wizard_meta_alert_title%%""-->
<!--#set var="wizard_meta_alert_attributes_excess_step2" value=" class="metaAlert" title="%%wizard_meta_alert_title_excess%%""-->

<!--#set var="wizard_option_value_step2" value="
    <tr id="tr_##group##_##field##"##price_type_last####meta_alert_attributes## class="wizard_option_line">
        <td><input detectchanges="off" ##price_num_attr## id="chk_##group##_##field##" type="checkbox"##IF(field == "[SUBLINK]")## onclick="AMI.find('#tr_sublink_tooltip').style.display = this.checked ? tableRowShowStyle : 'none'; return true;"##ENDIF## name="wizard_##group####field##" class="smallCheckBox"##if(price_num)## onclick="wizardCheckExtraPrice(this);"##endif####if(custom)## value="##caption##"##endif####checked## /></td>
        <td style="padding: 0px;"><label for="chk_##group##_##field##" title="##title##">##caption##</label></td>
        <td>##--[##src_type##]--##
            ##if(type)##
            <select name="wizard_type_##group####field##">
            ##type##
            </select>
            ##else##
            <input type="hidden" name="wizard_type_##group####field##" value= "add_price_type" />
            ##endif##
        </td>
        <td>
            ##if(type)##
            <input type="text" name="wizard_value_##group####field##" class="field field5"  value="##value##"##disabled_value## />
            ##else##
            <input type="hidden" name="wizard_value_##group####field##" value= "" />
            ##endif##
        </td>
        <td>##extra_parameters##</td>
    </tr>
##IF(field == "[SUBLINK]")##
    <tr id="tr_sublink_tooltip" ##IF(checked == "")## style="display: none;"##ENDIF##><td colspan="5"><div class="tooltip">%%wizard_sublink_tooltip%%</tooltip></td></tr>
##ENDIF##
"-->

<!--#set var="wizard_option_group_step2" value="
<tr><td colspan="5"><br></td></tr>
<tr><td><input id="ow_##group##" type="checkbox" name="ow_##group##" class="smallCheckBox" detectchanges="off" onclick="return wizardCheckboxOnClick(this);" title="%%check_uncheck_group%%" /></td><td style="padding:0px"><h3><label for="ow_##group##" title="%%check_uncheck_group%%">##caption##</label></h3></td></tr>
##fields##
<tr>
	<td>&nbsp;</td>
	<td colspan="4">
		<br>
		##if(group == 'CATEGORY')##<button class="but-long but" onclick="wizardAddRule('CATEGORY', '%%group_CATEGORY%%');return false;" onsubmit="return false;">%%group_CATEGORY_btn%%</button>##endif##
		##if(group == 'CATALOG')##<button class="but-long but" onclick="wizardAddRule('CATALOG', '%%group_CATALOG%%');return false;" onsubmit="return false;">%%group_CATALOG_btn%%</button>##endif##
		##if(group == 'PRICE_TYPE')##<button class="but but-long" onclick="wizardAddRule('PRICE_TYPE', '%%group_PRICE_TYPE%%');return false;" onsubmit="return false;">%%group_PRICE_TYPE_btn%%</button>##endif##
	</td>
</tr>
"-->

<!--#set var="wizard_option_group_splitter_step2" value="</tr><tr>"-->

<!--#set var="wizard_disabled_names_values_step2" value="wizardDisabledNamesValues.push(new Array ('##values##'));
"-->

<!--#set var="wizard_option_step2" value="
<style>
    .wizard_option_line:hover, .metaAlert:hover {
        background-color: #ddf8e4;
    }
</style>

<script type="text/javascript">
var
    wizardDisabledNames = [##wizardDisabledNames##], wizardDisabledNamesValues = [],
    wizardGroups = [##wizardGroups##], wizardGroupsCaptions = [##wizardGroupsCaptions##],
    wizardUsedRules = [##wizardUsedRules##],
    wizardExtraPrices = [##wizardExtraPrices##],
    wizardSpecialFlags = [##wizardSpecialFlags##],
    wizardMaxFileColumn = ##wizardMaxFileColumn##;

##wizardDisabledNamesValues##

buildRelatedColumns = function () {
    var source = (wizardDataMetaCSV.length > 0 ? wizardDataMetaCSV : wizardDataFirstLine);
    var list = '';
    for(var i = 0, e = source.length; i < e; i++) {
        list += '<option value="' + i + '">' + i + 
            (source[i] && source[i].length > 0 ? ( ' (' + source[i] + ')' ) : '') +
            '</option>';
    }

    if(list.length == 0) {
        return;
    }

    list = '<option value=""></option>' + list;

    var elements = [];
    var searchTags = ['input', 'select'];
    for(var t in searchTags) {
        var fields = document.getElementById('rulesTable').getElementsByTagName(searchTags[t]);
        for(var f in fields) {
            elements.push(fields[f]);
        }
    }

    for(var el in elements) {
        if(elements[el] != null && elements[el].type != 'hidden' && elements[el].name != null && elements[el].name.indexOf('wizard_value_') === 0) {
            var row = elements[el].parentNode.parentNode;
            var typeFieldName = elements[el].name.replace('wizard_value_', 'wizard_type_');
            var type = '';
            for(var s in elements) {
                if(elements[s].name == typeFieldName) {
                    type = elements[s].value;
                }
                if(elements[s].name != null && elements[s].name.indexOf('wizard_type_') === 0) {
                    elements[s].onclick = function(e) {
                        buildRelatedColumns();
                        var checkboxes = document.getElementsByName(this.name.replace('wizard_type_', 'wizard_'));
                        if(checkboxes.length > 0) {
                            if(this.value == 'value') {
                                checkboxes[0].checked = true;
                            }
                            else if(this.value == 'column') {
                                var lists = document.getElementsByName(this.name.replace('wizard_type_', 'wizard_value_'));
                                if(lists.length > 0 && typeof lists[0].onclick == 'function') {
                                    lists[0].onclick();
                                }
                            }
                        }
                    };
                }
            }

            var prepared = null;
            if(type == 'column') {
                if(elements[el].tagName != 'SELECT') {
                    prepared = document.createElement('select');
                    prepared.style.width = '200px';
                    prepared.innerHTML = list;
                    var valueFound = false;
                    for(var c in prepared.children) {
                        if(prepared.children[c] != null && prepared.children[c].value == elements[el].value) {
                            prepared.children[c].selected = true;
                            valueFound = true;
                        }
                    }
                    if(!valueFound) {
                        var checkboxes = document.getElementsByName(elements[el].name.replace('wizard_value_', 'wizard_'));
                        if(checkboxes.length > 0) {
                            checkboxes[0].checked = false;
                        }
                    }
                    prepared.onclick = function(e) {
                        var checkboxes = document.getElementsByName(this.name.replace('wizard_value_', 'wizard_'));
                        if(checkboxes.length > 0) {
                            checkboxes[0].checked = (this.value != '');
                        }
                    }
                }
            }
            else {
                if(elements[el].tagName != 'INPUT') {
                    prepared = document.createElement('input');
                    prepared.className = 'field field5';
                }
            }
            if(prepared != null) {
                prepared.name = elements[el].name;
                elements[el].parentNode.appendChild(prepared);
                elements[el].parentNode.removeChild(elements[el]);
            }
        }
    }
}

window.addEventListener('load', buildRelatedColumns);

function OnObjectChanged_eshop_data_exchange_form_def(name, first_change, evt)
{
    errFunc = OnObjectChanged_eshop_data_exchange_form_def;

    var
        oForm = document.forms[_cms_document_form],
        ind = wizardDisabledNames.indexOf(name);

    if (name.indexOf('wizard_PRICE_TYPE') == 0) {
        var re = /\[(\d+)\]/;
        re.exec(name);
        var priceNumber = RegExp.$1, isChecked = oForm.elements[name].checked;
        for (var i = 0, q = oForm.elements.length ; i < q ; i++) {
            if (oForm.elements[i].getAttribute('price_num') == priceNumber) {
                oForm.elements[i].checked = isChecked;
            }
        }
    } else if (ind > -1) {
        oForm.elements['wizard_value_' + name.substring('wizard_type_'.length)].disabled = wizardDisabledNamesValues[ind].indexOf(oForm.elements[name].value) > -1;
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_eshop_data_exchange_form_def);

function wizardCheckboxOnClick(oInput)
{
    var
        name = oInput.name,
        state = document.getElementById(name).checked,
        oForm = document.forms[_cms_document_form],
        namePart = 'chk_' + name.substr(3) + '_';
    for (var i = 0, q = oForm.elements.length ; i < q ; i++) {
        if (oForm.elements[i].id.indexOf(namePart) == 0) {
            oForm.elements[i].checked = state;
        }
    }
    return true;
}

function wizardOnSubmit(oForm)
{
    var errFunc = wizardOnSubmit;

    // validate checked fields
    var pQ = wizardGroups.length, unckeckedCustomRules = false;

    for (var prepareForPost = 0 ; prepareForPost < 2 ; prepareForPost++) {
        // there are two iterations: first for validation, second for disabling useless form fields
        for (var i = 0, q = oForm.elements.length ; i < q ; i++) {
            for (j = 0 ; j < pQ ; j++) {
                if (oForm.elements[i].id.indexOf('chk_' + wizardGroups[j]) == 0) {
                    if (prepareForPost) {
                        oForm.elements[i].disabled = oForm.elements[i].checked ? oForm.elements[i].value == 'on' : true;
                    }
                    if (oForm.elements[i].checked) {
                        if (!prepareForPost) {
                            var group = wizardGroups[j], rule = oForm.elements[i].id.substring(5 + wizardGroups[j].length), name = '';
                            if (rule == '') {
                                break;
                            }

                            var labels = document.getElementsByTagName('label');
                            for(var l in labels) {
                                if(labels[l].attributes != null && labels[l].attributes.for != null && labels[l].attributes.for.value == 'chk_' + group + '_' + rule) {
                                    name = labels[l].innerHTML;
                                }
                            }

                            if (oForm.elements['wizard_type_' + group + rule].value == 'column') {
                                var v = parseInt(oForm.elements['wizard_value_' + group + rule].value);
                                if (v != oForm.elements['wizard_value_' + group + rule].value || v < 0) {
                                    oForm.elements['wizard_value_' + group + rule].focus();
                                    alert('%%wizard_warn_invalid_column%% "' + name + '"');
                                    AMI.find('.tooltip_step2')[0].style.display = 'block';
                                    AMI.find('.tooltip_step2_link')[0].innerHTML = '%%close_rules%%';
                                    oForm.elements['wizard_value_' + group + rule].focus();
                                    return;
                                }
                                if ((wizardMaxFileColumn > -1) && (v > wizardMaxFileColumn)) {
                                    oForm.elements['wizard_value_' + group + rule].focus();
                                    alert('%%wizard_warn_column_bigger_than_file%% "' + name + '"');
                                    oForm.elements['wizard_value_' + group + rule].focus();
                                    return;
                                }
                            }
                        }
                    } else {
                        if(oForm.elements[i].id == 'chk_CATALOG_[ID_EXTERNAL]') {
                            var group = wizardGroups[j], rule = oForm.elements[i].id.substring(5 + wizardGroups[j].length);
                            oForm.elements['wizard_value_' + group + rule].focus();
                            alert('%%wizard_warn_missing_id_external%%');
                            oForm.elements['wizard_value_' + group + rule].focus();
                            return;
                        }
                        if (prepareForPost) {
                            if (oForm.elements[i].value != 'on') {
                                unckeckedCustomRules = true;
                            }
                            var group = wizardGroups[j], rule = oForm.elements[i].id.substring(5 + wizardGroups[j].length);
                            if (rule == '') {
                                break;
                            }
                            oForm.elements['wizard_type_' + group + rule].disabled = true;
                            oForm.elements['wizard_value_' + group + rule].disabled = true;
                        }
                    }
                    break;
                } else if (prepareForPost && oForm.elements[i].id == ('ow_' + wizardGroups[j])) {
                    oForm.elements[i].disabled = true;
                }
            }
        }
        if (!prepareForPost && unckeckedCustomRules) {
            if (!confirm('%%wizard_warn_custom_rules%%')) {
                return;
            }
        }
    }
    baseTabs.showTab('import');
    oForm.wzSpecialFlags.value = wizardSpecialFlags.join(',');

    // validate import fields (file)
    oForm.import_driver.disabled = false;
    wizardSetImportTabAccess(false);
##--    if (CheckForm(oForm, true)) {
        baseTabs.showTab('config');--##
        oForm.method = 'post';
        oForm.action.value = 'config';
        oForm.onsubmit = '';
        oForm.submit();
##--    } else {
        alert('%%warn_wizard_return_to_tab%%');
    }--##
}

function wizardSetOnChange(oOBJ)
{
    oOBJ.onchange = FormChanged;
    oOBJ.onkeydown = OnFieldKeyDown;
    oOBJ.onkeyup = function(){OnFieldKeyUp(this)};
    oOBJ.oldValue = oOBJ.value;
}

function wizardCheckExtraPrice(oCheckbox){
    var
        oForm = document.getElementById(_cms_document_form),
        isChecked = oCheckbox.checked,
        re = /\[(\d+)\]/, priceNumber = re.exec(oCheckbox.name);

    for(var i = 0, q = oForm.elements.length; i < q; i++){
        if(oForm.elements[i].getAttribute('price_num') == priceNumber){
            oForm.elements[i].checked = isChecked;
        }
    }
    return true;
}

function wizardAddExtraPriceRule(groupName, groupCaption)
{
    var errFunc = wizardAddExtraPriceRule;

    var re = /^\d+$/, priceNumber;

    while (true) {
        priceNumber = prompt('%%wizard_enter_extra_price_number%% (2-##max_extra_price##):', '');
        if (priceNumber == null) {
            return;
        }
        priceNumber = parseInt(priceNumber);
        if (re.exec(priceNumber) == null || priceNumber < 2 || priceNumber > ##max_extra_price##) {
            alert('%%wizard_invalid_extra_price_number%%');
            continue;
        }
        if (wizardExtraPrices.indexOf(priceNumber) > -1) {
            alert('%%wizard_extra_price_number_already_exists%%');
            continue;
        }
        break;
    }

    var
        oTABLE = document.getElementById('rulesTable'),
        orderedExtraPrices = wizardExtraPrices.sort(),
        sourceRowIndex, previousPriceNumber = -1, targetRowIndex;

    for (var i = 0, q = oTABLE.rows.length ; i < q ; i++) {
        if (oTABLE.rows[i].id == 'price_type_1') {
            sourceRowIndex = i;
            break;
        }
    }
    for (var i = orderedExtraPrices.length - 1 ; i >= 0 ; i--) {
        if (priceNumber > orderedExtraPrices[i]) {
            previousPriceNumber = orderedExtraPrices[i];
            break;
        }
    }

    wizardExtraPrices.push(priceNumber);

    if(previousPriceNumber >= 0){
        var sourceRowLastIndex = sourceRowIndex;
        while (!oTABLE.rows[++sourceRowLastIndex].getAttribute('last'));

        for (var i = 0, q = oTABLE.rows.length ; i < q ; i++) {
            if (oTABLE.rows[i].id == 'price_type_' + previousPriceNumber) {
                targetRowIndex = i;
                break;
            }
        }

        while (!oTABLE.rows[++targetRowIndex].getAttribute('last'));
        if (previousPriceNumber != 1) {
            targetRowIndex--;
        }

        var oClone = oTABLE.rows[sourceRowIndex].cloneNode(true);
        oClone.id = 'price_type_' + priceNumber;
        oClone.cells[1].innerHTML = oClone.cells[1].innerHTML.replace(/\d+/, priceNumber);
        var oTarget = oTABLE.rows[++targetRowIndex];
        var newTargetRowIndex = targetRowIndex;
        oTarget.parentNode.insertBefore(oClone, oTarget.nextSibling);
        for (var i = sourceRowIndex + 1 ; i <= sourceRowLastIndex ; i++) {
            var oClone = oTABLE.rows[i].cloneNode(true);
            var oTarget = oTABLE.rows[++targetRowIndex];
            oTarget.parentNode.insertBefore(oClone, oTarget.nextSibling);
        }
        rowIndex = ++newTargetRowIndex;

        while (!oTABLE.rows[++rowIndex].getAttribute('last'));
        var re1 = /PRICE_TYPE_\[1\]/, re2 = /PRICE_TYPE\[1\]/;
        for (var i = newTargetRowIndex ; i <= (rowIndex + 1) ; i++) {
            if (oTABLE.rows[i].id.indexOf('tr_PRICE_TYPE_[1]') == 0) {
                oTABLE.rows[i].id = oTABLE.rows[i].id.replace(/\[1\]/, '[' + priceNumber + ']');
                var children = oTABLE.rows[i].getElementsByTagName('*');
                for (var j = 0, q = children.length ; j < q ; j++) {
                    var eventNotSet = true;
                    if (re1.exec(children[j].id)) {
                        children[j].id = children[j].id.replace(re1, 'PRICE_TYPE_[' + priceNumber + ']');
                        if (children[j].id.indexOf('wizard_') == 0) {
                            wizardSetOnChange(children[j]);
                            eventNotSet = false;
                        }
                    }
                    if (re2.exec(children[j].name)) {
                        children[j].name = children[j].name.replace(re2, 'PRICE_TYPE[' + priceNumber + ']');
                        if(children[j].name.indexOf('wizard_PRICE_TYPE') == 0){
                            children[j].setAttribute('price_num', priceNumber);
                        }
                        if (eventNotSet && (children[j].name.indexOf('wizard_') == 0)) {
                            wizardSetOnChange(children[j]);
##--
                            if (children[j].name.indexOf('wizard_value_') == 0 && children[j].name.substr(-7) == '[PRICE]') {
                                children[j].value = '';
                                fireEvent2(children[j], 'onchange');
                            }
--##
                        }
                        wizardUsedRules.push(children[j].name);
                    }else if(children[j].getAttribute('for') && children[j].getAttribute('for').indexOf('chk_PRICE_TYPE_[') == 0){
                        children[j].setAttribute('for', children[j].getAttribute('for').replace(/\[\d+\]/, '[' + priceNumber + ']'));
                    }
                }
            }
        }
        alert('%%wizard_rule%% %%wizard_is_added_to_group%% "' + groupCaption + '"');
    }
}

function wizardAddSpecialFlagRule(groupName, groupCaption)
{
    var errFunc = wizardAddSpecialFlagRule;

    var re = /^\d+$/, flagNumber;

    while (true) {
        flagNumber = prompt('%%wizard_enter_special_flag_number%% (1-15):', '');
        if (flagNumber == null) {
            return;
        }
        flagNumber = parseInt(flagNumber);
        if (re.exec(flagNumber) == null || flagNumber < 1 || flagNumber > 15) {
            alert('%%wizard_invalid_special_flag_number%%');
            continue;
        }
        if (wizardSpecialFlags.indexOf(flagNumber) > -1) {
            alert('%%wizard_extra_price_number_already_exists%%');
            continue;
        }
        break;
    }
    if (wizardAddRule(groupName, groupCaption, 'ONSPECIAL' + flagNumber, '%%wizard_on_special_caption%% ' + flagNumber)) {
        wizardSpecialFlags.push(flagNumber);
    }
}

function wizardAddRule(groupName, groupCaption, forceRuleName, forceRuleCaption)
{
    var errFunc = wizardAddRule;
    var
        oForm = document.forms[_cms_document_form],
        ruleName, realRuleName, ruleCaption,
        re1 = /^\s*/, re2 = /\s*$/, re3 = /^[a-zA-Z][a-zA-Z\d_]*$/;

    if (typeof(forceRuleName) == 'string') {
        ruleName = forceRuleName;
        realRuleName = 'wizard_' + groupName + '[' + ruleName + ']';
        if (wizardUsedRules.indexOf(realRuleName) > -1) {
            alert('%%wizard_duplicate_rule_name%%');
            return false;
        }
        ruleCaption = forceRuleCaption;

    } else {

        if (groupName == 'PRICE_TYPE') {
            wizardAddExtraPriceRule(groupName, groupCaption);
            return;
        }

        if (groupName == 'CATALOG' && confirm('%%wizard_add_special_flag_rule%%')) {
            wizardAddSpecialFlagRule(groupName, groupCaption);
            return;
        }

        while (true) {
            ruleName = prompt('%%wizard_enter_rule_name%% "' + groupCaption + '":', '');
            if (ruleName == null) {
                return;
            }
            ruleName = ruleName.replace(re1, '').replace(re2, '');
            if (ruleName == '') {
                return;
            }
            ruleName = ruleName.toUpperCase();
            if (re3.exec(ruleName) == null) {
                alert('%%wizard_invalid_rule_name%%');
            } else if (ruleName.indexOf('HTML_') == 0) {
                alert('%%wizard_reserved_rule_name%%');
            } else {
                // rule internal name is valid

                realRuleName = 'wizard_' + groupName + '[' + ruleName + ']';
                if (wizardUsedRules.indexOf(realRuleName) > -1) {
                    alert('%%wizard_duplicate_rule_name%%');
                } else {
                    break;
                }
            }
        }

        while (true) {
            ruleCaption = prompt('%%wizard_enter_rule_caption%% "' + groupCaption + '":', '');
            if (ruleCaption == null) {
                return;
            }
            ruleCaption = fromHTMLToText(ruleCaption.replace(re1, '').replace(re2, ''));
            if (ruleCaption == '') {
                    alert('%%wizard_invalid_rule_caption%%');
            } else {
                break;
            }
        }
    }

    var oTABLE = document.getElementById('rulesTable');
    var groupFound = false;
    for (var i = 0, q = oTABLE.rows.length ; i < q ; i++) {
        if (oTABLE.rows[i].id.indexOf('tr_' + groupName) == 0) {
            groupFound = true;
        } else if (groupFound) {
            break;
        }
    }
    var oTR = oTABLE.insertRow(i), oTD;
    oTR.setAttribute('id', 'tr_' + groupName + '[' + ruleName + ']');
    oTD = oTR.insertCell(0);
    oTD.innerHTML = '<input id="chk_' + groupName + '_[' + ruleName + ']" type="checkbox" name="wizard_' + groupName + '[' + ruleName + ']" class="smallCheckBox" checked value="' + ruleCaption + '" />';
    oTD = oTR.insertCell(1);
    oTD.style.padding = '0px';
    oTD.innerHTML = '<label for="chk_' + groupName + '_[' + ruleName + ']" title="' + ruleName + '">' + ruleCaption + '</label>';
    oTD = oTR.insertCell(2);
    oTD.innerHTML = '<select name="wizard_type_' + groupName + '[' + ruleName + ']">##wizardDefaultRuleTypes##</select>';
    oTD = oTR.insertCell(3);
    oTD.innerHTML = '<input type="text" name="wizard_value_' + groupName + '[' + ruleName + ']" class="field field5"  value="" />';

    wizardDisabledNames.push('wizard_type_' + groupName + '[' + ruleName + ']');
    wizardDisabledNamesValues.push(new Array ('add_price_type'));

    wizardSetOnChange(oForm.elements['wizard_' + groupName + '[' + ruleName + ']']);
    wizardSetOnChange(oForm.elements['wizard_type_' + groupName + '[' + ruleName + ']']);
    wizardSetOnChange(oForm.elements['wizard_value_' + groupName + '[' + ruleName + ']']);

    wizardUsedRules.push(realRuleName);

    oForm.elements['wizard_value_' + groupName + '[' + ruleName + ']'].focus();
    alert('%%wizard_rule%% "' + ruleCaption + '" %%wizard_is_added_to_group%% "' + groupCaption + '"');
    oForm.elements['wizard_value_' + groupName + '[' + ruleName + ']'].focus();

    buildRelatedColumns();
    return true;
}

</script>
<div>
    <h1>%%wizard_step%% 2: %%wizard_step2_header%%</h1>
	<br>
    <input type="hidden" name="step" value="3" />
    <input type="hidden" name="wzSpecialFlags" value="" />
	%%import_rules%%
	<br><br>
	##meta_alert##
	<span class="tooltip_step2_link text_button" onclick="openRules();">%%open_rules%%</span>
	<br>
    <table class="tooltip_step2" style="display: none;" id="rulesTable" cellpadding="0" cellspacing="5" border="0">
	<tr>
		<td colspan=5>
			<br>
			<div class="tooltip">%%wizard_step2_tooltip%%</div>
			<div style="display: none;">
				<span id="step1_q1">* - <b>%%wizard_use_extra_prices%%</b>: %%wizard_use_extra_prices_comment%%;<br /><br /></span>
				<span id="step1_q2">** - <b>%%wizard_reference_operation%%</b>: %%wizard_reference_operation_comment%%<br /><br /></span>
				<span id="step1_q3">*** - <b>%%wizard_images_source%%</b><br />
					<span style="padding-left: 33px;"></span>%%wizard_image_source_module%%: &quot;##wizard_image_source_module##&quot;,<br />
					<span style="padding-left: 33px;"></span>%%wizard_image_source_upload%%: &quot;##wizard_image_source_upload##&quot;.<br />
				</span>
			</div>
		</td>
	</tr>
    <tr>
        <th colspan="2">&nbsp;</th>
        <th>%%wizard_field_mapping_type%%</th>
        <th>%%wizard_field_mapping_value%%</th>
        <th>&nbsp;</th>
    </tr>
	##html##
    </table>
	<script>
		function openRules() {
			var rulesBlock = AMI.find('.tooltip_step2')[0];
			var rulesLink = AMI.find('.tooltip_step2_link')[0];
			if(rulesBlock.style.display == 'none') {
				rulesBlock.style.display = 'block';
				rulesLink.innerHTML = '%%close_rules%%';	
			} else {
				rulesBlock.style.display = 'none';
				rulesLink.innerHTML = '%%open_rules%%';
			}
		}
	</script>
	##if(meta_alert)##<script>openRules();</script>##endif##
<br /><br />
</div>
<script>
function showAlt(id, nclass) {
	if(nclass == 'cat_price') {AMI.find('#b_'+id).innerHTML = AMI.find('#step1_q1').innerHTML;}
	if(nclass == 'wizard_reference_operation') {AMI.find('#b_'+id).innerHTML = AMI.find('#step1_q2').innerHTML;}
	if(nclass == 'wizard_images_source') {AMI.find('#b_'+id).innerHTML = AMI.find('#step1_q3').innerHTML;}
	AMI.find('#b_'+id).style.display = 'block';
}

function hideAlt(id, nclass) {
	AMI.find('#b_'+id).style.display = 'none';
}
</script>
"-->

<!--#set var="wizard_meta_alert_step2" value="<span style="color:red">%%wizard_meta_alert%%</span><br><br>"-->

<!--#set var="wizard_correspondence_col_step3" value="<select name="wizard[##group##][##field##][]" multiple=1 style="display:none;" onclick="AMI.$('#commonFieldTooltip')[(AMI.$(this).val() > 0) ? 'hide' : 'show']();">##options##</select>"-->
<!--#set var="wizard_hidden_correspondence_col_step3" value="<input type="hidden" name="wizard[##group##][##field##][]" value="##field_value##" /><i>##field_caption##</i>&nbsp;"-->
<!--#set var="wizard_splitter_correspondence_col_step3" value="%%wizard_splitter%%: <input type="text" name="wizard_splitter[##group##][##field##]" class="field field5"  value="##splitter##" />&nbsp;"-->

<!--#set var="wizard_option_row_step3" value="
##if(!hidden)##
<tr id="tr##id##" class="##class##"##-- onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)"--##>
##if(same_column_prev)##
    <td id="caption_wizard[##group##][##field##][]" class="verMiddle"##if(same_column_both)## style="border:none;"##endif##>##group_caption##: ##field_caption##</td>
    <td class="verMiddle"##if(same_column_both)## style="border:none;"##endif##>##correspondence_col##</td>
##elseif(same_column_next)##
    <td class="pos verMiddle" nowrap rowspan="##same_column_count##"><span id="col##id##">##column##</span>&nbsp;##if(column !== null)##<img src="skins/vanilla/icons/icon-pos_control.gif" width="19" height="19" border="0" onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='default'" onclick="moveField(event, this, ##id##)" />##else##<img src="skins/vanilla/icons/icon-pos_control_dis.gif" width="19" height="19" border="0" detectchanges="off" />##endif##</td>
    <td id="caption_wizard[##group##][##field##][]" class="verMiddle" style="border:none;">##group_caption##: ##field_caption##</td>
    <td class="verMiddle" style="border:none;">##correspondence_col##</td>
##else##
    <td class="pos verMiddle" nowrap><span id="col##id##">##column##</span>&nbsp;##if(column !== null)##<img src="skins/vanilla/icons/icon-pos_control.gif" width="19" height="19" border="0" onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='default'" onclick="moveField(event, this, ##id##)"/>##else##<img src="skins/vanilla/icons/icon-pos_control_dis.gif" width="19" height="19" border="0" detectchanges="off" />##endif##</td>
    <td id="caption_wizard[##group##][##field##][]" class="verMiddle">##group_caption##: ##field_caption##</td>
    <td class="verMiddle">##correspondence_col##</td>
##endif##
</tr>
##else##
<input type="hidden" name="wizard[##group##][##field##][]" value="add_price_type" />
##endif##
"-->

<!--#set var="wizard_option_step3" value="
<script type="text/javascript">
var
    _id, _col,
    wizardOpenAll = false,
    trRealRowsIds = [##trRealRowsIds##], srcTRRealRowsIds = [],
    trRowsGroups = {##trRowsGroups##},
    wzMinRowIndex = -1, wzMaxRowIndex = -1;

for (var i = 0, q = trRealRowsIds.length ; i < q ; i++) {
    srcTRRealRowsIds.push(trRealRowsIds[i]);
}

function wizardBodyOnLoadStep3()
{
    var l = trRealRowsIds.length;
    if (l > 0) {
        var oTABLE = document.getElementById('wzCorrespondence');
        wzMinRowIndex = wzTableRowIndex(oTABLE, 'tr' + trRealRowsIds[0]);
        wzMaxRowIndex = wzTableRowIndex(oTABLE, 'tr' + trRealRowsIds[l - 1]);
    }

    AMI.Template.Locale.set('multiselect_mark', '%%wizard_multiselect_select%%');
    AMI.Template.Locale.set('multiselect_andAlso', '+');

    var forceShowRules = false;
    AMI.$.extend(AMI.$.ech.multiselect.prototype.options, {
        checkAllText: "%%wizard_multiselect_check%%",
        uncheckAllText: "%%wizard_multiselect_uncheck%%",
        noneSelectedText: "%%wizard_multiselect_caption%%",
        selectedText: ""
    });
    AMI.$("[multiple]").each(function() {
        var select = $(this);
        select.multiselect({minWidth: 300, selectedList: 1});
        // Show all selected options in button's title
        select.on('multiselectclick', function() {
            var $this = $(this), titles = [];
            var options = $this.multiselect('getChecked');
            for (var i = 0; i < options.length; i++) {
                titles.push(options[i].title);
            }
            $this.multiselect('getButton').attr('title', titles.join(', '));
        });
        forceShowRules = (forceShowRules || select.context.selectedOptions.length == 0);
    });
    // Workaround to adjust chosen and select width
    setTimeout(function(){
        AMI.$('.chosen-container').each(function(){
            var id = this.id;
            var selId = id.replace('_chosen', '');
            var maxWidth = (selId == 'grpIdCat') ? 168 : 400;
            AMI.$('#' + selId).show();
            var width = AMI.$('#' + selId).width();
            AMI.$('#' + selId).hide();
            if(width && (width < maxWidth)){
                AMI.$('#' + id).width(width + 32);
            }else{
                AMI.$('#' + id).width(maxWidth + 32);
            }
        });
    }, 250);
    if(forceShowRules) {
        openRules();
    }
}

function wzTableRowIndex(oTABLE, id)
{
    var res = -1;

    for (var i = 0, q = oTABLE.rows.length ; i < q ; i++) {
        if (oTABLE.rows[i].id == id) {
            res = i;
            break;
        }
    }
    return res;
}

function swapNodes(node1, node2)
{
    node1.parentNode.insertBefore(node2, node1);
}

function moveField(evt, oImage, id)
{
    var mousePos = amiCommon.getMousePosition(evt);
    var elementPos = amiCommon.getElementPosition(oImage);
    elementHalfX = oImage.offsetWidth / 2;
    elementHalfY = oImage.offsetHeight / 2;
    isOneStep = mousePos[0] > elementPos[0] + elementHalfX;
    if (mousePos[1] < elementPos[1] + elementHalfY) {
        wzClick(isOneStep ? 'up' : 'top', id, trRealRowsIds.indexOf(id));
    } else {
        wzClick(isOneStep ? 'down' : 'bottom', id, trRealRowsIds.indexOf(id));
    }
}

function wzClick(action, srcTRId, colIndex)
{
    if (
        ((action == 'top' || action == 'up') && colIndex == 0) ||
        ((action == 'down' || action == 'bottom') && colIndex >= (trRealRowsIds.length - 1))
    ) {
       return false;
    }
    var
        oForm = document.forms[_cms_document_form],
        oTABLE = document.getElementById('wzCorrespondence'),
        srcIndex = trRealRowsIds.indexOf(srcTRId),
        srcGroupIds = typeof(trRowsGroups[srcTRId]) == 'undefined' ? [srcTRId] : trRowsGroups[srcTRId],
        destIndex, destGroupIds, destTRId, destTRIdOrig;

    switch (action) {
        case 'top':
            while ((wzTableRowIndex(oTABLE, 'tr' + srcTRId) > wzMinRowIndex) && wzClick('up', srcTRId, colIndex--)) {}
            return false;
        case 'up':
            destIndex = srcIndex - 1;
            break;
        case 'down':
            destIndex = srcIndex + 1;
            break;
        case 'bottom':
            while ((wzTableRowIndex(oTABLE, 'tr' + srcTRId) < wzMaxRowIndex) && wzClick('down', srcTRId, colIndex++)) {}
            return false;
        default:
            return false;
    }

    destTRId = trRealRowsIds[destIndex];
    destTRIdOrig = destTRId;
    destGroupIds = typeof(trRowsGroups[destTRId]) == 'undefined' ? [destTRId] : trRowsGroups[destTRId];
    var down = action == 'down';

    if (srcGroupIds.length == 1 && destGroupIds.length == 1) {
        var
            srcRowIndex = wzTableRowIndex(oTABLE, 'tr' + srcTRId),
            destRowIndex = wzTableRowIndex(oTABLE, 'tr' + destTRId);
        if (srcRowIndex < destRowIndex) {
            swapNodes(oTABLE.rows[srcRowIndex], oTABLE.rows[destRowIndex]);
        } else {
            swapNodes(oTABLE.rows[destRowIndex], oTABLE.rows[srcRowIndex]);
        }
    } else {
        if (action == 'down' && destGroupIds.length > 1) {
            destTRId = destGroupIds[destGroupIds.length - 1];
        }
        var
            srcRowIndex = wzTableRowIndex(oTABLE, 'tr' + srcTRId),
            destRowIndex = wzTableRowIndex(oTABLE, 'tr' + destTRId);

        if (action == 'up') {
            for (var i = 0, q = srcGroupIds.length; i < q ; i++) {
                var j = wzTableRowIndex(oTABLE, 'tr' + srcGroupIds[i]), trID = srcGroupIds[i];
                if (j < destRowIndex) {
                    swapNodes(oTABLE.rows[j], oTABLE.rows[destRowIndex]);
                } else {
                    swapNodes(oTABLE.rows[destRowIndex], oTABLE.rows[j]);
                }
                destRowIndex++;
            }
        } else {
            return wzClick('up', destTRIdOrig, colIndex + 1);
        }
    }
    trRealRowsIds[srcIndex] = destTRIdOrig;
    trRealRowsIds[destIndex] = srcTRId;
    var val = document.getElementById('col' + srcTRId).innerHTML;
    document.getElementById('col' + srcTRId).innerHTML = document.getElementById('col' + destTRIdOrig).innerHTML;
    document.getElementById('col' + destTRIdOrig).innerHTML = val;

    return true;
}

function wizardOnSubmit(oForm)
{
    var errFunc = wizardOnSubmit;

    // validate selected fields
    for (var i = 0, q = oForm.elements.length ; i < q ; i++) {
        if (oForm.elements[i].name.indexOf('wizard[') == 0 && typeof(oForm.elements[i].options) != 'undefined') {
            var anySelected = false;
            for (var j = 0, k = oForm.elements[i].options.length ; j < k ; j++) {
                if (oForm.elements[i].options[j].selected) {
                    anySelected = true;
                    break;
                }
            }
            if (!anySelected) {
                alert('%%warn_wizard_select_correspondence%% "' + document.getElementById('caption_' + oForm.elements[i].name).innerHTML + '"');
                AMI.find('.tooltip_step2')[0].style.display = 'block';
		AMI.find('.tooltip_step2_link')[0].innerHTML = '%%close_rules%%';	
                if (wizardOpenAll) {
                    oForm.elements['wizard_chk_all'].checked = false;
                }
                oForm.elements[i].focus();
                return false;
            }
        } else if (oForm.elements[i].name.indexOf('wizard_splitter[') == 0 && (oForm.elements[i].value == '' || oForm.elements[i].value.indexOf(oForm.delim.value) > -1)) {
            oForm.elements[i].focus();
            alert('%%warn_wizard_invalid_splitter%%');
            oForm.elements[i].focus();
            return false;
        }
    }

    var aColumnsOrder = [];
    for (var i = 0, q = srcTRRealRowsIds.length; i < q ; i++) {
        aColumnsOrder.push(document.getElementById('col' + srcTRRealRowsIds[i]).innerHTML);
    }
    oForm.wzColumns.value = aColumnsOrder.join(',');

    baseTabs.showTab('import');
    oForm.import_driver.disabled = false;
    wizardSetImportTabAccess(false);
    oForm.method = 'post';
    oForm.action.value = 'config';
    oForm.onsubmit = '';
    oForm.submit();
}
</script>

<div>
    <h1>%%wizard_step%% 3: %%wizard_step3_header%%</h1>
	<br>
    <input type="hidden" name="step" value="4" />
    <input type="hidden" name="wzColumns" value="" />
	%%wizard_step3_tooltip%%
	<br>
	<br>
	<span class="tooltip_step2_link text_button" onclick="openRules();">%%open_rules%%</span>
	<br>
	<br>
    <table class="tooltip_step2" style="display: none;" id="wzCorrespondence" width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
        <td class="first_row_all" width="30">%%wizard_mapping_type_column%%</td>
        <td class="first_row_all">%%wizard_rule%%</td>
        <td class="first_row_all">%%wizard_correspondence%%</td>
    </tr>
    ##html##
    </table>
		<script>
		function openRules() {
			var rulesBlock = AMI.find('.tooltip_step2')[0];
			var rulesLink = AMI.find('.tooltip_step2_link')[0];
			if(rulesBlock.style.display == 'none') {
				rulesBlock.style.display = 'block';
				rulesLink.innerHTML = '%%close_rules%%';	
			} else {
				rulesBlock.style.display = 'none';
				rulesLink.innerHTML = '%%open_rules%%';
			}
		}
	</script>
	##--
    <input type="checkbox" id="wizard_create_meta" name="wizard_create_meta" checked /><label for="wizard_create_meta">%%wizard_create_meta%%</label>--##
</div>
"-->
