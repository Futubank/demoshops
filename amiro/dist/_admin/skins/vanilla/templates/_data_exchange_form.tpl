##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/_data_exchange.lng"%%

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'exchange_form';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
var prevDrvName = '';
var arrTabs = Array('import'##if(!DISABLEDATAEXPORT)##, 'export'##endif####custom_tabs_js##);
var currDataSourceType;
var autoRunLink = '##auto_run_params##';
var exportModules = Array(##export_modules_js##);
var exportRecipients = Array();
var exportRecipientsTitles = Array();
var exportDriverModList = Array();
var exportFileNames = {##export_filenames_js##};
var exportRecipientEmails = {##export_save_email_list_js##};
##export_recipients_js##
##export_drivers_js##

var importModList = Array();
var importIncludedModList = Array();
var driversOnSubmitHandlers = new Array ();
##import_modules_js##

function exportPopupClose() {
  //document.location = '##script_link##';
}

function LocalBodyOnLoad() {
  currDataSourceType = '##data_source_type##';
  setDataSourceType();
  baseTabs.showTab('##exchange_type##');
  if(autoRunLink != "") {
      openExtDialog('%%import_popup_title%%', '##script_link##' + autoRunLink, 0, 0, 550, 330, -1, -1, 1, 1);
  }
  ##if(!DISABLEDATAEXPORT)##
  changeRecipient(document.forms["exchange_form"].elements["export_recipient"].value);
  ##endif##
  initExportModuleCheckbox();
  ##if(!DISABLEDATAEXPORT)##
  changeSaveMethod('##export_save_method##');
  ##endif##
  initDrivers();
}

function addDriverOnSubmitHandler(handlingFunction)
{
    if (typeof(handlingFunction) == 'function') {
        driversOnSubmitHandlers.push(handlingFunction);
    }
}

function CheckForm(form) {
    var
        popupTitle,
        exchangeType = form.elements['exchange_type'].value;

    if (exchangeType == 'import') {
       popupTitle = '%%import_popup_title%%';

       if(form.elements["import_driver"].value == '') {
           alert('%%import_driver_warn%%');
           form.elements["import_driver"].focus();
           return false;
       }
       if(currDataSourceType == 'file') {
           ext = form.data_source_file.value.substring(form.data_source_file.value.lastIndexOf('.') + 1, form.data_source_file.value.length);
           ext = ext.toLowerCase();
           if(form.data_source_file.value=='' || (form.data_source_file.value!='' && !CheckExtension(ext))) {
               return focusedAlert(form.data_source_file, '%%file_warn%%');
           }
       }
       if(currDataSourceType == 'ftp') {
           if(form.elements["data_source_ftp"].value == '') {
               alert('%%data_source_ftp_warn%%');
               form.elements["data_source_ftp"].focus();
               return false;
           }
       }
    }
    if (exchangeType == 'export') {
       popupTitle = '%%export_popup_title%%';
       if(form.elements["export_recipient"].value == '') {
           alert('%%export_recipient_warn%%');
           form.elements["export_recipient"].focus();
           return false;
       }
       if(form.elements["export_driver"].value == '') {
           alert('%%export_driver_warn%%');
           form.elements["export_driver"].focus();
           return false;
       }
       if(typeof(form.elements["export_module[]"].length) != 'undefined') {
         var num = form.elements["export_module[]"].length;
         var flag = false;
         for(var i=0; i<num; i++) {
            if(form.elements["export_module[]"][i].checked) {
              flag = true;
              break;
            }
         }
         if(!flag) {
           alert('%%export_module_warn%%');
           form.elements["export_module[]"][0].focus();
           return false;
         }
       }

       num = form.elements["export_data_type[]"].length;
       flag = false;
       for(i=0; i<num; i++) {
          if(form.elements["export_data_type[]"][i].checked) {
            flag = true;
            break;
          }
       }
       if(!flag) {
         alert('%%export_data_type_warn%%');
         form.elements["export_data_type[]"][0].focus();
         return false;
       }
       if(form.elements['export_save_filename'].value == '' || form.elements['export_save_filename'].value.substr(form.elements['export_save_filename'].value.length-4, 4) == '.php'){
           alert('%%export_save_file_warn%%');
           form.elements["export_save_filename"].focus();
           return false;
       }
    }
    for (var i = 0, qty = driversOnSubmitHandlers.length ; i < qty ; i++) {
        if (!driversOnSubmitHandlers[i](form)) {
            return false;
        }
    }
    if(form.method == "get") {
      openExtDialog(popupTitle, '##script_link##?'+collect_link(document.forms['exchange_form'], true), 0, 0, 550, 330, -1, -1, 1, 1);
    } else {
      form.submit();
    }
    return true;
}

function CheckExtension(ext) {
  var err=false;
  var i;
  var img_ext = new Array(##ext_check##);
  for(i=0;i<img_ext.length;i++) {
    if(img_ext[i]==ext) {
      err=true;
      break;
    }
  }
  return !err;
}

var currImportDrive = '##import_driver##_import';
var currExportDrive = '##export_driver##_export';

function setExchangeType(type) {
  document.forms[_cms_document_form].elements["exchange_type"].value = type;
}

function setDataSourceType(type) {
  var form = document.forms[_cms_document_form];
  var num = form.elements["data_source_type"].length;
  var i;

  if(num != undefined){
      for(i=0; i<num; i++) {
        if(form.elements["data_source_type"][i].checked) {
          currDataSourceType = form.elements["data_source_type"][i].value;
          disabled = false;
          if(form.elements["data_source_type"][i].value == "file") {
            form.method = "post";
            form.elements["action"].value = "add";
          } else {
            form.method = "get";
            form.elements["action"].value = "run";
          }
        } else {
          disabled = true;
        }
        idName = "data_source_type_" + form.elements["data_source_type"][i].value;
        elements = document.getElementById(idName);
        if(typeof(elements.length) != "undefined") {
          for(var j=0; j<elements.length; j++) {
            elements[j].disabled = disabled;
          }
        } else {
          if(elements.tagName.tagName == 'input'){
            elements.disabled = disabled;
          }
        }
      }
  }else{
      if(form.elements["data_source_type"].value == "file") {
        form.method = "post";
        form.elements["action"].value = "add";
      } else {
        form.method = "get";
        form.elements["action"].value = "run";
      }
  }
}

function initDrivers(){
    // For import only for a while
    if(document.exchange_form)
        if(document.exchange_form.import_driver)
            if(document.exchange_form.import_driver.length) {
                for(var i = document.exchange_form.import_driver.options.length - 1; i >=0; i--) {
                    if(document.exchange_form.import_driver.options[i].selected) {
                        changeDrive("import", document.exchange_form.import_driver.options[i].value);
                    }
                }
            }
}

function SetBlocksVisibility(blockName, visible) {
  var display = visible? 'block' : "none";
  var disabled = !visible;
  var elms = getObjectsByName('tr', blockName);
  if(elms.length > 0) {
      for(var i=0; i<elms.length; i++) {
        makeElementVisible(elms[i], display);
        elms[i].disabled = disabled;
      }
  } else {
      var elm = document.getElementById(blockName);
      if(elm != null){
          makeElementVisible(elm, display);
          elm.disabled = disabled;
      }
  }
}

function checkImportMode(drvName) {
    var elms = getObjectsByName('tr', "module");
    if(elms.length > 0) {
        var optSelect = elms;
        var i;
        for(i = 0; i < optSelect.length; i++) {
            if(optSelect[i].checked) {
                // Enable modules' specific settings
                SetBlocksVisibility("import_" + optSelect[i].value, true);
            } else {
                // Disable all modules' specific settings
                SetBlocksVisibility("import_" + optSelect[i].value, false);
            }
        }

        if(typeof(importIncludedModList[drvName]) == "object") {
            // Enable modules' specific settings
            var num = importIncludedModList[drvName].length;
            for (i = 0; i < num; i++) {
                SetBlocksVisibility("import_" + importIncludedModList[drvName][i], true);
            }
        }
    }
    return true;
}


function changeDrive(type, driverName) {
    if (typeof(onChangeDrive) == 'function' && !onChangeDrive(type, driverName)) {
        return false;
    }
  if(type == "import") {
    currentType = currImportDrive;
  } else {
    currentType = currExportDrive;
    setFileName();
  }

  drvName = driverName;
  driverName += '_' + type;

  // Functions defined to driver: on and off
  var FuncExists;
  eval("FuncExists = (typeof(driverFunc_" + prevDrvName + ") == 'function')");
  if(FuncExists) {
          var driverFunc = eval('driverFunc_' + prevDrvName);
      driverFunc('off');
  }
  eval("FuncExists = (typeof(driverFunc_" + driverName + ") == 'function')");
  if(FuncExists) {
          var driverFunc = eval('driverFunc_' + driverName);
      driverFunc('on');
  }
  prevDrvName = driverName;

  SetBlocksVisibility(currentType, false);

  if(type == "import") {
    currImportDrive = driverName;
  } else {
    currExportDrive = driverName;
    disableExportModuleCheckbox(drvName);
  }

  SetBlocksVisibility(driverName, true);

  var optSelect = getObjectsByName('tr', "module");
  if(type == "import" && optSelect.length > 0 && typeof(importModList[drvName]) == "object") {
    // Change selectbox of modules for import
    var modNames = ";" + importModList[drvName].join(";") + ";";
    var optNum = optSelect.length;
    var i;
    var sel = -1;
    var selMin = -1;
    for(i = 0; i < optNum; i++) {
        if(modNames.indexOf(";" + optSelect[i].value + ";") > -1) {
            // Item is found in modules list
            optSelect[i].disabled = false;
            if(optSelect[i].checked) {
                sel = i;
            }
            if(selMin == -1) {
                selMin = i;
            }
        } else {
            optSelect[i].disabled = true;
        }
    }

    if(sel == -1 && selMin > -1) {
        // Select first item that can be selected
        optSelect[selMin].checked = true;
    }

    checkImportMode(drvName);


    // Check if "import_mode" block exists and set its visibility status if required
    var elm = document.getElementById('import_mode');
    if(elm != null) {
      if(importModList[drvName].length == 1 && importModList[drvName][0] == '') {
        makeElementVisible(elm, 'none');
        elm.disabled = true;
      } else {
        makeElementVisible(elm, 'block');
        elm.disabled = false;
      }
    }
  }

}

function disableExportModuleCheckbox(driverName) {
  var num = exportModules.length;
  var i, j;
  if(num > 1) {
    var els = document.forms["exchange_form"].elements["export_module[]"];
    for(i=0; i<num; i++) {
      var flag = false;
      if(typeof(exportDriverModList[driverName]) != "undefined") {
        num2 = exportDriverModList[driverName].length;
        for(j=0; j<num2; j++) {
          if(exportDriverModList[driverName][j] == els[i].value) {
            flag = true;
            break;
          }
        }
      }
      if(flag) {
        els[i].disabled = false;
      } else {
        els[i].disabled = true;
        els[i].checked = false;
        changeExportModuleCheckbox(false, exportModules[i]);
      }
    }
  } else {
      changeExportModuleCheckbox(true, exportModules[0]);
  }
}

function updateExportCheckboxes(checked, forceNoChecked) {
  for(i=1; i<document.forms["exchange_form"].elements["export_data_type[]"].length; i++) {
    document.forms["exchange_form"].elements["export_data_type[]"][i].checked = checked && !forceNoChecked;
    document.forms["exchange_form"].elements["export_data_type[]"][i].disabled = checked;
  }
}

function changeExportModuleCheckbox(checked, moduleName) {
  var elms = getObjectsByName('tr', "export_"+moduleName);
  var elm = document.getElementById("export_"+moduleName);
  if(elms.length > 0) {
      for(i=0; i<elms.length; i++) {
        elms[i].disabled = !checked;
      }
  } else if (document.getElementById("export_"+moduleName)) {
      elm.disabled = !checked;
  }
}

function changeExportModules(moduleName){
  var curDriver = document.getElementById('export_driver');
  if(curDriver && curDriver.value == 'CSVEshopDriver'){
      var cbEsItem = document.getElementById('id_export_module_eshop_item');
      var cbEsOrder = document.getElementById('id_export_module_eshop_order');
      var cbEsUser = document.getElementById('id_export_module_eshop_user');
      if(moduleName == 'eshop_item'){
          if(cbEsItem.checked){
              cbEsOrder.checked = false;
              cbEsOrder.disabled = true;
              cbEsUser.checked = false;
              cbEsUser.disabled = true;
          }else{
              cbEsOrder.disabled = false;
              cbEsUser.disabled = false;
          }
      }else if(moduleName == 'eshop_order' || moduleName == 'eshop_user'){
          if(cbEsOrder.checked || cbEsUser.checked){
              cbEsItem.checked = false;
              cbEsItem.disabled = true;
          }else{
              cbEsItem.disabled = false;
          }
      }
  }
}

function initExportModuleCheckbox() {
  var num = exportModules.length;
  var i;
  if(num > 1) {
    for(i=0; i<num; i++) {
      changeExportModuleCheckbox(document.forms["exchange_form"].elements["export_module[]"][i].checked, exportModules[i]);
    }
  } else {
      changeExportModuleCheckbox(true, exportModules[0]);
  }
}

function changeRecipient(exportRecipient) {
  rebuildExportDriversList(exportRecipient);
  var recipients = document.forms["exchange_form"].elements["export_recipient"];
  if(typeof(recipients.options) != "undefined") {
    var aStyle = Array();
    for(var i=0; i<recipients.options.length; i++) {
      if(exportRecipient == recipients.options[i].value) {
        aStyle["display"] = "inline";
      } else {
        aStyle["display"] = "none";
      }
      //setStylesForElements("export_form_recipient_" + recipients.options[i].value, aStyle, "setDisplayStyle");
    }
  }
  setFileName();
  setRecipientEmail();
}

function rebuildExportDriversList(exportRecipient) {
  var expDrvList = document.forms["exchange_form"].elements["export_driver"];
  var num = expDrvList.length - 1;
  for(i=num;i>0;i--) {
    expDrvList.options[i]=null;
  }

  var recipient = document.forms["exchange_form"].elements["export_recipient"].value;
  if(typeof(exportRecipients[recipient]) != 'undefined') {
    num = exportRecipients[recipient].length;

    for(i=0;i<num;i++) {
      opt = new Option(exportRecipientsTitles[exportRecipients[recipient][i]], exportRecipients[recipient][i], false, false);
      expDrvList.options[i+1] = opt;
    }
  }
  disableExportModuleCheckbox(expDrvList.value);
}

function changeSaveMethod(methodName) {
  var i, aStyle;
  aStyle = Array();
  var el = document.forms["exchange_form"].elements["export_save_method"];
  for(i=0; i<el.length; i++) {
    if(el[i].value == methodName) {
      aStyle["display"] = "inline";
    } else {
      aStyle["display"] = "none";
    }
    setStylesForElements("export_form_save_" + el[i].value, aStyle, "setDisplayStyle");
  }
}

function setStylesForElements(elName, aStyle, styleCB) {
  var els = getObjectsByName('tr', elName);
  var el = document.getElementById(elName);
  if(els.length > 0) {
      for(var i = 0; i<els.length; i++) {
        eval(styleCB + "(els[" + i +"], aStyle" + ")");
      }
  } else if(el != null) {
        eval(styleCB + "(el, aStyle" + ")");
  }
}

function setDisplayStyle(el, aStyle) {
  el.style.display = aStyle["display"];
}

function setDisableStyle(el, aStyle) {
  el.disabled = aStyle["disable"];
}

function setDisableAndDisableStyle(el, aStyle) {
  el.style.display = aStyle["display"];
  el.disabled = aStyle["disable"];
}

function setFileName() {
  var form = document.forms["exchange_form"];
  var recipient = form.elements["export_recipient"].value;
  var exportDriver = form.elements["export_driver"].value;
  if(typeof(exportFileNames[exportDriver]) != "undefined" && typeof(exportFileNames[exportDriver][recipient]) != "undefined") {
    form.elements["export_save_filename"].value = exportFileNames[exportDriver][recipient];
  }
}

function setRecipientEmail() {
  var form = document.forms["exchange_form"];
  var recipient = form.elements["export_recipient"].value;
  if(typeof(exportRecipientEmails[recipient]) != "undefined") {
    form.elements["export_save_email"].value = exportRecipientEmails[recipient];
  }
}


function onTabSelectedCustom(idTab, bState){

  if (idTab=='import' && bState){
    setExchangeType('import');
  }
  if (idTab=='export' && bState){
    setExchangeType('export');
  }
  return true;
}

##custom_js##
-->
</script>

<!--#set var="import_allowed_small" value="
<br><br><center><font color="blue">%%import_of_small_file%%</font></center><br>
"-->


<!--#set var="import_not_allowed" value="
<br><br><center><font color="red"><b>%%import_not_allowed_because_of_time%%</b></font></center><br>
"-->


<!--#set var="open_import_log_link" value="
##script_link##?action=view&type=import
"-->

<!--#set var="log_popup_form" value="
##if(error_message != "")##
<font color="red">##error_message##</font>
##else##
##content##
##endif##
"-->

<!--#set var="log_popup" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - %%import_viewlog_popup_title%%</TITLE>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css">

</HEAD>
<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">
<center>
<br>
<form name="view_log">
##form##
<br>
<input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="closeDialogWindow();">
</form>
</center>
</BODY>
</HTML>
"-->

<!--#set var="driver_option_row;export_recipient_row" value="
<option value="##name##" ##selected##>##title##</option>
"-->

<!--#set var="file_option_row" value="
<option value="##name##" ##selected##> ##title##&nbsp;&nbsp;&nbsp;&nbsp;##IF(file_size)####file_size## (##file_size_bytes## %%byte%%)##else##0 %%byte%%##endif##</option>
"-->

<!--#set var="import_modules_js_row" value="
importModList['##name##'] = new Array(##modules_list##);
importIncludedModList['##name##'] = new Array(##included_modules_list##);
"-->

<!--#set var="export_drivers_js_row" value="
exportRecipientsTitles['##name##'] = '##title##';
exportDriverModList['##name##'] = new Array(##modules_list##);
"-->

<!--#set var="export_recipient_js_row" value="
exportRecipients['##name##'] = new Array(##drivers_list##);
"-->

<!--#set var="export_recipient_text" value="
##title##<input type="hidden" name="export_recipient" value="##name##">
"-->

<!--#set var="export_recipients_select" value="
<select name="export_recipient" onChange="changeRecipient(this.value);">
<option value="">%%select_export_recipient%%</option>
##export_recipients_list##
</select>
"-->

<!--#set var="driver_form" value="
##driver_form##
"-->

<!--#set var="export_modules_row" value="
<tr>
<td ##--style="padding-left: 20px"--## onClick="changeExportModules('##export_module_name##');"><nobr><input id="id_export_module_##export_module_name##" type="checkbox" name="export_module[]" value="##export_module_name##" onClick="changeExportModuleCheckbox(this.checked, '##export_module_name##');"><label for="id_export_module_##export_module_name##">##export_module_title##</label></nobr></td>
<td colspan="2">&nbsp;</td>
</tr>
##export_{export_module_name}_form##
"-->

<!--#set var="export_modules_text" value="
<tr>
<td style="padding-left: 20px"><input type="hidden" name="export_module[]" value="##export_module_name##"></td>
<td colspan="2">&nbsp;</td>
</tr>
##export_{export_module_name}_form##
"-->

<!--#set var="export_form_save_method_row" value="
<input id="id_export_save_method_##value##" type="radio" name="export_save_method" value="##value##" ##checked## onClick="changeSaveMethod(this.value);"><label for="id_export_save_method_##value##">##title##</label>
"-->

<!--#set var="export_form" value="
     <tr>
       <td>
        %%export_recipient%%:
       </td>
       <td colspan="2">
          ##export_recipients##
       </td>
     </tr>
     <tr>
       <td>
        <b>%%driver_list%%:</b>
       </td>
       <td colspan="2">
          <select name="export_driver" id="export_driver" style="width: 170px;" onChange="changeDrive('export', this.value);">
          <option value="">%%select_driver%%</option>
          ##drivers_list##
          </select>
       </td>
     </tr>
     <tr>
       <td colspaqn=3><br>
       </td>
     </tr>
     <tr>
       <td valign="top">
        <b>%%export_modules%%:</b>
       </td>
       <td colspan="2"><table>##export_modules##</table>&nbsp;</td>
     </tr>
     
     <tr>
       <td valign="top"><br><b>%%type_objects%%:</b></td>
       <td colspan="2"><br>
          ##--<nobr><input type="checkbox" name="export_data_type[]" value="all" onclick="updateExportCheckboxes(this.checked, false);">%%data_type_all%%&nbsp;</nobr>--##
          <nobr><input id="id_export_data_type_full" type="checkbox" name="export_data_type[]" value="full" onclick="updateExportCheckboxes(this.checked, true);"><label for="id_export_data_type_full">%%data_type_full%%</label>&nbsp;</nobr>
          <nobr><input id="id_export_module_changed" type="checkbox" name="export_data_type[]" value="changed"><label for="id_export_module_changed">%%data_type_changed%%</label>&nbsp;</nobr><nobr><input id="id_export_data_type_new" type="checkbox" name="export_data_type[]" value="new"><label for="id_export_data_type_new">%%data_type_new%%</label>&nbsp;</nobr>##--<nobr><input type="checkbox" name="export_data_type[]" value="deleted">%%data_type_deleted%%&nbsp;</nobr>--##
       </td>
     </tr>
     <tr>
       <td><br>%%export_save_methods%%:</td>
       <td colspan="2"><br>
       ##export_form_save_methods##
       </td>
     </tr>
     <tr>
       <td width="190"><div id="export_form_save_file">%%export_save_file_title%%</div><div id="export_form_save_email">%%export_save_email_attachname%%</div>:</td>
       <td colspan="2">
       <input type=text name="export_save_filename" class="field field50" value="##export_save_file##" ">
       </td>
     </tr>
     <tr id="export_form_save_email">
       <td>%%export_save_email_title%%:</td>
       <td colspan="2">
        <input type=text name="export_save_email" class="field field50" value="##export_save_email##" >
       </td>
     </tr>
"-->

<!--#set var="import_form" value="
   <tr>
     <td>
      <b>%%driver_list%%:</b>
     </td>
     <td colspan="2">
        <select name="import_driver" id="import_driver" onChange="changeDrive('import', this.value);"##driver_selection_disabled##>
        <option value="">%%select_driver%%</option>
        ##drivers_list##
        </select>
     </td>
   </tr>
   <tr>
     <td colspan=3><br>
     </td>
   </tr>
   ##--
   <tr>
     <td><b>%%data_source%%:</b>
     </td>
     <td>
      <input type=radio name="data_source_type" value="url" ##data_source_url_checked## onClick="setDataSourceType();">%%source_url%%:
     </td>
     <td>
      <input id="data_source_type_url" type="text" name="data_source_url" class=field>
     </td>
   </tr>--##
   ##if(!DONOTUSEFILESOURCE)##
   <tr valign="top">
     <td nowrap><b>%%data_source%%:</b></td>
     <td valign="top">
      <input type="radio" id="radio_data_source_type_file" name="data_source_type" value="file" ##data_source_file_checked## onClick="setDataSourceType();"><label for="radio_data_source_type_file">%%source_file%%</label>:
     </td>
     <td nowrap>
      <input id="data_source_type_file" type="file" name="data_source_file" class=field onclick="AMI.find('#radio_data_source_type_file').checked=true; setDataSourceType();"><br>
      <label><input type=checkbox name="put_to_ftp" value="1" ##put_to_ftp_checked##>&nbsp;%%put_to_ftp%%</label>
      <br><br>
     </td>
   </tr>
   ##endif##

   ##--SET NAME OF FTP SOURCE--##
   <script>
   ##if(SOURCE_FTP_FOLDERS && !SOURCE_FTP_FILES)##
     var source_ftp_name = "%%select_ftp_folder%%";
   ##elseif(SOURCE_FTP_FOLDERS && SOURCE_FTP_FILES)##
     var source_ftp_name = "%%select_ftp_filefolder%%";
   ##else##
     var source_ftp_name = "%%select_ftp_file%%";
   ##endif##
   </script>

   ##if(!DONOTUSEFTPSOURCE)##
   <tr>
     <td>&nbsp;</td>
     <td nowrap>
      <label><input type="radio" id="radio_data_source_type_ftp" name="data_source_type" value="ftp" ##data_source_ftp_checked## onClick="setDataSourceType();"> %%source_ftp%%</label>:
     </td>
     <td>
        <div id="data_source_type_ftp"><select id="id_data_source_ftp" name="data_source_ftp" style="width:245px;">
        <option value="">%%select_ftp_file%%</option>
        ##files_list##
        </select></div>
     </td>
   </tr>
   <script>
        if(source_ftp_name && document.exchange_form.data_source_ftp){
            document.exchange_form.data_source_ftp.options[0].text = source_ftp_name;
        }

        if(document.exchange_form.data_source_ftp && document.exchange_form.data_source_ftp.value != '' && document.exchange_form.data_source_ftp.value != source_ftp_name) {
            document.exchange_form.import_driver.value = 'RapidCSVEshopDriver';
        }
   </script>
   ##endif##
"-->

<!--#set var="progress_popup_header" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%eshop_data_exchange%%</TITLE>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css">
<script src="jsapi.php" type="text/javascript"></script>
<script type="text/javascript" src="##admin_root####skin_path##_js/ami.jquery.js"></script>
<script type="text/javascript" src="##admin_root####skin_path##_js/ami.admin.js"></script>

</HEAD>
<BODY id=bdy leftmargin="20" topmargin="0" bgcolor="#FFFFFF">
<div id="progressBar" style="display: none;">
<center>
<br>
##if(exchange_type == "import")##
%%importing%%
##else##
%%exporting%%
##endif##
<br>
<table border=0 cellspacing=0 cellpadding=0>
<tr><td width=400 style="border: 1px blue solid;">
<div id="percent" align="center" style="width: 0%; color: #FFFFFF; background-color: blue"></div>
</td>
</tr>
</table>
%%elapsed_time%%:&nbsp;<div id="time" style="display: inline;"></div>
</center>
</div>
<script type="text/javascript">
var elPercent = document.getElementById("percent");
var elElapsedTime = document.getElementById("time");
var elProgressBar = document.getElementById("progressBar");
</script>

<script>
    var currentPercent = 0;
    var currentElapsedTime = 0;

    function setProgressData(receivedData){
        stopProgressDownloader();

        var aData = receivedData.split('|');
        if(aData.length == 2){
            var intPercent = parseInt(aData[0]);
            var elapsedTime = aData[1];
            if(currentPercent < intPercent || currentElapsedTime != aData[1]){
                currentPercent = intPercent;
                currentElapsedTime = aData[1];
                elPercent.style.width = currentPercent + '%';
                elPercent.innerHTML = currentPercent + '%';
                elProgressBar.style.display = "inline";
                elElapsedTime.innerHTML = elapsedTime;
            }
        }

        if(currentPercent < 100){
            startProgressDownloader('##progress_id##');
        }
    }

    startProgressDownloader('##progress_id##');
</script>
"-->

<!--#set var="progress_popup_iterator" value="
<script type="text/javascript">
<!--
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

setProgressData('##percent##|##elapsed_time##');
-->
</script>
"-->

<!--#set var="progress_popup_footer" value="
<br>
<div style="padding: 0 20px;">##status##</div>
<br><br>
<form name="progressForm">
<center>
##if(exchange_type == "import")##
<input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="closeDialogWindow();">
##else##
<input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="javascript:top.exportPopupClose();closeDialogWindow();">
##endif##
</center>
</form>
</BODY>
</HTML>
"-->

<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
"-->

  <br>
   <form action=##script_link## method=post enctype="multipart/form-data" name="exchange_form" id="exchange_form" onsubmit="return CheckForm(this);">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="exchange_type" value="##exchange_type##">
     <input type="hidden" name="action" value="##action##">
     ##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">
        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-import">
              <table cellspacing="10" cellpadding="0" border="0" width="100%">
               <tr valign="top" height=288>
                <td>
                 ##--<div class="tooltip">%%import_tooltip%%</div><br />--##
                 <table cellspacing="5" cellpadding="0" border="0">
                 ##import_form##
                 </table>
                 <table cellspacing="5" cellpadding="0" border="0" id="id_table_import">
                 ##import_module_form##
                 ##import_drivers_forms##
                 </table>
                </td>
              </table>
            </div>
         ##if(!DISABLEDATAEXPORT)##
            <div class="tab-page" id="tab-page-export">
              <table cellspacing="5" cellpadding="0" border="0" width="100%">
               <tr>
                 <td colspan=1 height=10></td>
               </tr>
               <tr valign="top" height=288>
                <td>
                 <table cellspacing="5" cellpadding="0" border="0">
                   ##export_form##
                 </table>
                 <table cellspacing="5" cellpadding="0" border="0">
                   ##--export_module_form--##
                   ##export_drivers_forms##
                 </table>
                </td>
                </tr>
              </table>
            </div>
         ##endif##
         ##custom_tabs_content##
          </div>

          <script type="text/javascript">
            var baseTabs = new cTabs('tab-control', {
                'import' : ['%%import%%', 'active', '', false],
         ##if(!DISABLEDATAEXPORT)##
                'export' : ['%%export%%', 'normal', '', false],
         ##endif##
                ##custom_tabs##
            '':''}, false);
          </script>

       </td>
     </tr>
     <tr>
        <td colspan="2" align="right">
        <br>
        ##custom_buttons##
        <input style="display: block" type="button" name="run" id="run_btn" value="  %%run_btn%%  " class="but" onClick="CheckForm(this.form);">
        <br><br>
        </td>
     </tr>
     <tr>
       <td colspan="2" id="required_fields">
         <sub>%%required_fields%%</sub>
       </td>
     </tr>
     </table>
    </form>
