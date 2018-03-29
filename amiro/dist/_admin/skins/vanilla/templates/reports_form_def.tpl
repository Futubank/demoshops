##--!ver=0200 rules="-SETVAR"--##

<!--#set var="select_field" value="##select_name##[##select_name##.length] = new Array('##id##', '##name##', '##is_used##', '##is_unique##', '##custom_1##', '##custom_2##', '##custom_3##', '##custom_4##');
"-->
<!--#set var="init_fields" value="insertFieldRow('##select_name##', '##id##');
"-->
<!--#set var="array_row" value="##array_name##[##array_name##.length] = Array('##key##', '##value##');
"-->

<!--#set var="insert_field_row" value="
##if(is_string(custom_1) && custom_1!=="")## ##select_name##[##index##][4] = '##custom_1##'; ##endif##
##if(is_string(custom_2) && custom_2!=="")## ##select_name##[##index##][5] = '##custom_2##'; ##endif##
insertFieldRow('##ctrl_name##', '##id##');
"-->

<!--#set var="type_row" value="<option value="##value##" ##selected##>##name##</option>"-->


<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'reportform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

var arrTabs = Array('grouping', 'filter_fields');

var aSort = Array();
aSort[0] = Array('asc', '%%asc%%');
aSort[1] = Array('desc', '%%desc%%');

var aGroups = Array();

var aMethods = Array();
##calc_methods##

var levelFieldCnt = 0;

var details_tpls = Array();
details_tpls[0] = Array('', '%%select_file%%');
##details_tpls##

var stats_tpls = Array();
stats_tpls[0] = Array('', '%%select_file%%');
##stats_tpls##

var oldSelectIndex;

function changeType(value) {
    cform = document.forms[_cms_document_form];
    var anchor = '#anchor';
    if(typeof(cform) == "object") {
        if(confirm('%%change_type_warning%%')) {
            if(cform.elements["action"].value != "apply") {
                cform.elements["action"].value = "";
                document.location = _cms_script_link + collect_link(cform)+"&type="+value+anchor;
            } else {
                cform.elements["action"].value = "edit";
                id=cform.elements["id"].value;
                document.location = _cms_script_link + collect_link(cform)+"&type="+value+"&id="+id+anchor;
            }
        } else {
          cform.elements["type"].selectedIndex=oldSelectIndex;
        }
    }
}

function OnObjectChanged_reports_form_def(name, first_change, evt){
  if(name=="type") {
    changeType(document.forms[_cms_document_form].elements["type"].value);
  }
  return true;
}
addFormChangedHandler(OnObjectChanged_reports_form_def);

function CheckForm(form) {
   var errmsg = "";

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   if (form.template.value=="") {
       return focusedAlert(form.template, '%%template_warn%%');
   }

   return true;
}

function fillStdSelectCtrl(selectCtrl, optionsArr, currVal) {
    // Remove all options
    for(var i = selectCtrl.options.length; i > 0; i--){
        selectCtrl.options[selectCtrl.options.length-1] = null;
    }

    // Add options
    for(i = 0; i < optionsArr.length; i++){
        selectCtrl.options[selectCtrl.options.length] = new Option(optionsArr[i][1], optionsArr[i][0]);
	selectCtrl.options[selectCtrl.options.length-1].selected = (currVal == optionsArr[i][0]);
    }
}

function rebuildGroups() {
    groupsCtrl = this.document.forms.reportform.group_fields;

    aGroups = Array();
    aGroups[0] = Array('', '%%total%%');

    var groupsTable = this.document.getElementById('group_fields_table');
    for(var i = 0; i < groupsTable.rows.length; i++){
        var attr = groupsTable.rows[i].getAttribute("arrayid");
	if(typeof(attr) == 'number') {
	    // Fill global array of existing levels
            aGroups[aGroups.length] = Array(group_fields_def[attr][0], group_fields_def[attr][1]);
	}
    }

    var formElems = this.document.forms[_cms_document_form].elements;
    for(var i = 0; i < formElems.length; i++){
        if(formElems[i].name.substr(0,11) == 'calc_level_') {
	    // Rebuild existing selectbox with levels in calculation section
	    fillStdSelectCtrl(formElems[i], aGroups, formElems[i].value);
	}
    }
}

function insertFieldRow(selectName, fieldId){
    var selDefField = eval(selectName + '_def');
    var selTable = this.document.getElementById(selectName + '_table');
    
    for(var i = 0; i < selDefField.length; i++){
        if(selDefField[i][0] == fieldId){
	    if(selDefField[i][2] != '1') {
                var oRow = selTable.insertRow(selTable.rows.length);
                oRow.setAttribute("id", selectName + "_" + fieldId);
                oRow.setAttribute("clearid", fieldId);
                oRow.setAttribute("arrayid", i);

		var insertRowFuncExists;
		eval("insertRowFuncExists = (typeof(" + selectName + "_addRow) == 'function')");
		if(insertRowFuncExists) {
		    var insertRowFunc = eval(selectName + "_addRow");
		    insertRowFunc(oRow, selDefField, selDefField[i], selectName, fieldId);
		}

		if(selDefField[i][3] == '1') {
		    selDefField[i][2] = '1';
		    fillSelectCtrl(selectName, selDefField);
		}
	    }
        }
    }
}

function watchSelectDiv(selFieldName){

    selFieldCtrl = this.document.forms.reportform.elements[selFieldName];

    if(selFieldCtrl.options.length <= 0){
        document.getElementById(selFieldName + '_div').style.display = 'none';
    }else{
        document.getElementById(selFieldName + '_div').style.display = 'inline';
    }
}

function fillSelectCtrl(selFieldName, selDefField){
    selFieldCtrl = this.document.forms.reportform.elements[selFieldName];

    // Remove all options
    for(var i = selFieldCtrl.options.length; i > 0; i--){
        selFieldCtrl.options[selFieldCtrl.options.length-1] = null;
    }

    // Add options
    for(i = 0; i < selDefField.length; i++){
        if(selDefField[i][2] != '1')
            selFieldCtrl.options[selFieldCtrl.options.length] = new Option(selDefField[i][1], selDefField[i][0]);
    }

    // Hide the fields if required
    watchSelectDiv(selFieldName);
}

function moveField(evt, oImage, selectName, fieldId){
    var mousePos = amiCommon.getMousePosition(evt);
    var elementPos = amiCommon.getElementPosition(oImage);
    elementHalfX = oImage.offsetWidth / 2;
    elementHalfY = oImage.offsetHeight / 2;
    isOneStep = (mousePos[0] > elementPos[0] + elementHalfX);
    isUp = (mousePos[1] < elementPos[1] + elementHalfY);
    if(isUp){
        moveFldUp(selectName, fieldId, !isOneStep);
    }else{
        moveFldDown(selectName, fieldId, !isOneStep);
    }
}

function moveFldUp(selectName, curId, isTop){
    if(curId != ''){
        var selTable = this.document.getElementById(selectName + '_table');
        for(var i = 1; i < selTable.rows.length; i++){
            if((selectName + "_" + curId) == selTable.rows[i].getAttribute("id")){
                if(i > 2){
                    var lastElem = isTop ? 2 : i;
                    for(j = i; j >= lastElem; j--){
                        crossSwapNodes(selTable.rows[j-1], selTable.rows[j]);
                    }
                }
                break;
            }
        }

	var moveFldUpFuncExists;
	eval("moveFldUpFuncExists = (typeof(" + selectName + "_moveFldUp) == 'function')");
	if(moveFldUpFuncExists) {
	    var moveFldUpFunc = eval(selectName + "_moveFldUp");
	    moveFldUpFunc(oRow, selDefField, selDefField[i], selectName, fieldId);
	}
    }
}

function moveFldDown(selectName, curId, isBottom){
    if(curId != ''){
        var selTable = this.document.getElementById(selectName + '_table');
        for(var i = 1; i < selTable.rows.length; i++){
            if((selectName + "_"+curId) == selTable.rows[i].getAttribute("id")){
                if(i < selTable.rows.length-1){
                    var lastElem = isBottom ? selTable.rows.length-2 : i;
                    for(j = i; j <= lastElem; j++){
                        crossSwapNodes(selTable.rows[j], selTable.rows[j + 1]);
                    }
                }
                break;
            }
        }

	var moveFldDownFuncExists;
	eval("moveFldDownFuncExists = (typeof(" + selectName + "_moveFldDown) == 'function')");
	if(moveFldDownFuncExists) {
	    var moveFldDownFunc = eval(selectName + "_moveFldDown");
	    moveFldDownFunc(oRow, selDefField, selDefField[i], selectName, fieldId);
	}
    }
}

function deleteRow(selectName, fieldId){
    if(fieldId != ''){
        var selDefField = eval(selectName + '_def');
        var selTable = this.document.getElementById(selectName + '_table');
	    for(var i = 1; i < selTable.rows.length; i++){
                if((selectName + "_" + fieldId) == selTable.rows[i].getAttribute("id")){
                    selDefField[selTable.rows[i].getAttribute("arrayid")][2] = '0';
                    selTable.rows[i].parentNode.removeChild(selTable.rows[i]);
                    fillSelectCtrl(selectName, selDefField);
                    break;
                }
            }

	    var deleteRowFuncExists;
	    eval("deleteRowFuncExists = (typeof(" + selectName + "_deleteRow) == 'function')");
	    if(deleteRowFuncExists) {
	        var deleteRowFunc = eval(selectName + "_deleteRow");
	        deleteRowFunc(selectName, fieldId);
	    }
    }
}

function group_fields_addRow(oRow, selDefField, selItem, selectName, fieldId){
  var oCell = oRow.insertCell(0);
  oCell.innerHTML = '<img src=skins/vanilla/icons/icon-pos_control.gif width=19 height=19 border=0 onmouseover="this.style.cursor=\'pointer\'" onmouseout="this.style.cursor=\'default\'" onclick="moveField(event, this, \''+selectName+'\', \''+fieldId+'\')">';

  oCell = oRow.insertCell(1);
  oCell.innerHTML = selItem[1] + '<input type=hidden name="arr_group_fields[]" value="' + fieldId + '">';

  oCell = oRow.insertCell(2);
  oCell.innerHTML = '<select name="sort_order_' + fieldId + '"></select>';
  // Fill selectbox with sort options
  selSortCtrl = this.document.forms.reportform.elements['sort_order_' + fieldId];
  fillStdSelectCtrl(selSortCtrl, aSort, selItem[4]);

  oCell = oRow.insertCell(3);
  oCell.innerHTML = '<a href="javascript:void(1)" onClick="deleteRow(\'' + selectName + '\', \'' + fieldId + '\');return false;"><img src="skins/vanilla/icons/icon-del.gif" title="%%delete%%" border=0></a>';

  rebuildGroups();
}

function group_fields_deleteRow(selectName, fieldId){
  rebuildGroups();
}

function calc_fields_addRow(oRow, selDefField, selItem, selectName, fieldId){
  var oCell = oRow.insertCell(0);
  oCell.innerHTML = selItem[1] + '<input type=hidden name="calc_field_' + levelFieldCnt + '" value="' + selItem[0] + '">';

  oCell = oRow.insertCell(1);
  oCell.innerHTML = '<select name="calc_method_' + levelFieldCnt + '"></select>';
  // Fill selectbox with method options
  selMethodCtrl = this.document.forms.reportform.elements['calc_method_' + levelFieldCnt];
  fillStdSelectCtrl(selMethodCtrl, aMethods, selItem[4]);

  oCell = oRow.insertCell(2);
  oCell.innerHTML = '<select name="calc_level_' + levelFieldCnt + '"><option value="' + selItem[5] + '" selected></option></select>';

  oCell = oRow.insertCell(3);
  oCell.innerHTML = '<a href="javascript:void(1)" onClick="deleteRow(\'' + selectName + '\', \'' + fieldId + '\');return false;"><img src="skins/vanilla/icons/icon-del.gif" title="%%delete%%" border=0></a>';

  levelFieldCnt++;

  rebuildGroups();
}

function filter_fields_addRow(oRow, selDefField, selItem, selectName, fieldId){
  var oCell = oRow.insertCell(0);
  oCell.innerHTML = selItem[1] + '<input type=hidden name="arr_filter_fields[]" value="' + fieldId + '">';

  oCell = oRow.insertCell(1);
  if(selItem[4] == "select") {
    // Draw select
    oCell.innerHTML = '<select name="filter_value_' + fieldId + '"></select>';
    // Fill selectbox with values
    selFltValCtrl = this.document.forms.reportform.elements['filter_value_' + fieldId];
    var tmpArr = Array();
    var valuesArr = selItem[6].split('|');
    for(var i = 0; i < valuesArr.length; i++) {
      var optArr = valuesArr[i].split('=', 2);
      if(optArr.length == 2) {
        tmpArr[i] = Array(optArr[0], optArr[1]);
      }
    }
    fillStdSelectCtrl(selFltValCtrl, tmpArr, selItem[5]);
  }

  if(selItem[4] == "date") {
    // Draw text control
    oCell.innerHTML = '<input class=field name="filter_value_' + fieldId + '" type="text" value="' + selItem[5] + '">';
  }

  oCell = oRow.insertCell(2);
  oCell.innerHTML = '<a href="javascript:void(1)" onClick="deleteRow(\'' + selectName + '\', \'' + fieldId + '\');return false;"><img src="skins/vanilla/icons/icon-del.gif" title="%%delete%%" border=0></a>';
}

//-->
</script>

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="reportform" id="reportform" onSubmit="return CheckForm(window.document.reportform);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
     <tr>
       <td>
%%name%%*:
</td>
       <td>
         <input type=text name=name class="field field50" value="##name##" maxlength="255">
       </td>
     </tr>
     <tr vAlign=top>
       <td>
%%type%%:
</td>
       <td>
         <select name="type">##type_rows##</select>
	 <br>
	 <div class=tooltip id="realFieldsDesc">##type_descr##<br>%%common_descr%%</div>
       </td>
     </tr>
     <tr>
       <td>
%%template%%*:
</td>
       <td>
         <select name="template" id="template">
	 </select>
       </td>
     </tr>
    </table>
    <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-grouping">
             <table cellspacing="5" cellpadding="0" border="0" class=tab_screen width="100%">
               <tr><td>
          ##if(group_fields!="")##
                     <table cellSpacing="0" cellPadding="2" border="0" id="group_fields_table" width=100%>
               <tr><td colspan=4><div class="tooltip" id="realFieldsDesc">%%grouping_descr%%</div></td></tr>
               <tr><td width="20"></td><td>%%group_by%%</td><td width="110">%%sort_over%%</td><td width="20"></td></tr>
                     ##group_list##
                     </table>
                     <div id="group_fields_div" style="display:none">
                       <select name="group_fields">
                       </select>
                       <span class="text_button" onClick="insertFieldRow('group_fields', document.forms.reportform.group_fields.value)">%%add_group%%</span>
               </div>
          ##endif##
          ##if(calc_fields!="")##
               <table cellSpacing="0" cellPadding="2" border="0" id="calc_fields_table" width=100%>
               <tr><td colspan=4><div class="tooltip" id="realFieldsDesc">%%calc_descr%%</div></td></tr>
               <tr><td>%%calc_by%%</td><td width="110">%%calc_method%%</td><td width="100">%%level%%</td><td width="20"></td></tr>
                     ##calc_list##
                     </table>
                     <div id="calc_fields_div" style="display:none">
                       <select name="calc_fields">
                       </select>
                       <span class="text_button" onClick="insertFieldRow('calc_fields', document.forms.reportform.calc_fields.value)">%%add_calc_field%%</span>
               </div>
          ##endif##
               <br><br><br>
               </td></tr>
             </table>
           </div>


            <div class="tab-page" id="tab-page-filter_fields">
               <table cellspacing="5" cellpadding="0" border="0" class=tab_screen width="100%">
                 <tr><td>
            ##if(filter_fields!="")##
                       <table cellSpacing="0" cellPadding="2" border="0" id="filter_fields_table" width=100%>
                 <tr><td colspan=4><div class="tooltip" id="realFieldsDesc">%%filter_descr%%</div></td></tr>
                 <tr><td>%%filter_by%%</td><td width="110">%%default%%</td><td width="20"></td></tr>
                       ##filter_fields_list##
                       </table>
                       <div id="filter_fields_div" style="display:none">
                         <select name="filter_fields">
                         </select>
                          <span class="text_button"  onClick="insertFieldRow('filter_fields', document.forms.reportform.filter_fields.value)">%%add_filter_field%%</span>
                 </div>
            ##endif##
                 <br><br><br>
                 </td></tr>
               </table>
           </div>
         </div>
       </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'grouping' : ['%%grouping%%*', 'active', '', false],
              'filter_fields' : ['%%filter_fields%%', 'normal', '', false],
          '':''});
          
        </script>

       </td>
     </tr>
    </table>
    <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
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

    <script>
	var selectedItemId;
	var selectCtrlName;

	var group_fields_def = new Array();
	##group_fields##
##if(group_fields!="")##
        fillSelectCtrl("group_fields", group_fields_def);
	##group_insert_fields##
##endif##

	var calc_fields_def = new Array();
	##calc_fields##
##if(calc_fields!="")##
        fillSelectCtrl("calc_fields", calc_fields_def);
	##calc_insert_fields##
##endif##

        var filter_fields_def = new Array();
	##filter_fields##
##if(filter_fields!="")##
        fillSelectCtrl("filter_fields", filter_fields_def);
	##filter_insert_fields##
##endif##

##if(group_fields!="")##
	rebuildGroups();
##endif##

	fillStdSelectCtrl(document.getElementById("template"), eval("##type##_tpls"), "##template##");

	oldSelectIndex = document.forms[_cms_document_form].elements["type"].selectedIndex;
    </script>