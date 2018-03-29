##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_res_dns_inst.lng"%%

<!--#set var="hint" value="
##if(!IS_USER)##
<div id="form_hint_link" style="text-align: right; font-size: 7pt; width: 100%;">
<a href="modules_templates_langs.php?id=##id##&action=edit&flt_tpl_name=##name##" target="hint_wnd">##if(form_hint != '')##%%hint_edit%%##else##%%hint_add%%##endif##</a>
</div>
##endif##
##if(form_hint != '')##
<div id="form_hint" style="font-size: 7pt; background-color: #FFFFE1; border: 1px #666666 solid; padding: 5px; width: 100%;">##form_hint##</div>
##endif##
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'dnsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
##pictures_js_vars##

var newRecordId = 1;
var recordsRowOffset = 1; // contains count header rows in records table

function OnObjectChanged_resform(name, first_change){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_resform);

function CheckForm(form) {
    var errmsg = "";

##if(IS_ADMIN==1)##
    var tmpFieldName;
    if(records.rows.length > recordsRowOffset) {
        for(i = recordsRowOffset; i < records.rows.length; i++) {
            tmpFieldName = 'dr_value_'+records.rows[i].getAttribute('clearid');
            oTmp = document.getElementById(tmpFieldName);
            if(oTmp && oTmp.value == '') {
                    alert("%%the_field%% '%%value%%' %%is_required_input_it%%");
                    oTmp.focus();
                    return false;
            }
        }
    }
    FormChanged();

##else##
##endif##

    return true;
}

function insertDnsRecordRow() {
	var name_val = "";
	var ttl_val = "600";
	var type_val = "";
	var priority_val = "10";
	var value_val = "";
    var priority_disabled = "";

    var oRow, oCelll, tmpHtml;
	var aTypeOptions = Array("A", "MX", "CNAME");

    if(insertDnsRecordRow.arguments.length == 5) {
    	name_val = insertDnsRecordRow.arguments[0];
    	ttl_val = insertDnsRecordRow.arguments[1];
    	type_val = insertDnsRecordRow.arguments[2];
	    priority_val = insertDnsRecordRow.arguments[3];
    	value_val = insertDnsRecordRow.arguments[4];
    }
    if(type_val != "MX") {
        priority_disabled = ' disabled';
    }

    oRow = records.insertRow();
    oRow.setAttribute("id", "records_"+newRecordId);
    oRow.setAttribute("clearid", newRecordId);

    oCell = oRow.insertCell();
    oCell.innerHTML = '<input class="field field30" name=dr_name_' + newRecordId + ' id=dr_name_' + newRecordId + ' value="' + name_val +'">';
    oCell.setAttribute("align", "center");
    oCell.setAttribute("className", "row1");

    oCell = oRow.insertCell();
    oCell.innerHTML = '<input class="field field12" name=dr_ttl_' + newRecordId + ' id=dr_ttl_' + newRecordId + ' value="' + ttl_val +'">';
    oCell.setAttribute("align", "center");
    oCell.setAttribute("className", "row1");

    oCell = oRow.insertCell();
    tmpHtml = '<select name=dr_type_' + newRecordId + ' id=dr_type_' + newRecordId + ' onChange="javascript:onChangeType(' + newRecordId + ');">';
    for(var i = 0; i < aTypeOptions.length; i++) {
        tmpHtml += '<option value="' + aTypeOptions[i] + '"';
        if(aTypeOptions[i] == type_val) {
            tmpHtml += ' selected';
        }
        tmpHtml += '>' + aTypeOptions[i] + '</option>';
    }
    tmpHtml += '</select>';
    oCell.innerHTML = tmpHtml;
    oCell.setAttribute("align", "center");
    oCell.setAttribute("className", "row1");

    oCell = oRow.insertCell();
    oCell.innerHTML = '<input class="field field12" name=dr_priority_' + newRecordId + ' id=dr_priority_' + newRecordId + ' value="' + priority_val +'" ' + priority_disabled +'>';
    oCell.setAttribute("align", "center");
    oCell.setAttribute("className", "row1");

    oCell = oRow.insertCell();
    oCell.innerHTML = '<input class="field field30" name=dr_value_' + newRecordId + ' id=dr_value_' + newRecordId + ' value="' + value_val +'">';
    oCell.setAttribute("align", "center");
    oCell.setAttribute("className", "row1");

    oCell = oRow.insertCell();
    oCell.innerHTML = '<a id="delDnsRecordRow_' + newRecordId + '" href="javascript:void('+newRecordId+')" onClick="javascript:deleteDnsRecordRow(\''+newRecordId+'\');return false;"><img src="skins/vanilla/icons/icon-del.gif" title="%%delete%%" border=0></a>';
    oCell.setAttribute("align", "center");
    oCell.setAttribute("className", "row1");

    updateDnsRecordsOrder();
    newRecordId ++;
}

function deleteDnsRecordRow(curId){
    if (curId != '') {
        for(i = recordsRowOffset; i < records.rows.length; i++){
            if("records_"+curId == records.rows[i].getAttribute("id")){
                if(!confirm('%%remove_record%%')) {
                    return;
                }
                records.rows[i].removeNode(true);
                updateDnsRecordsOrder();
                break;
            }
        }
    }
}

function updateDnsRecordsOrder() {
    var oDnsRecordsOrder=document.getElementById('records_order');
    oDnsRecordsOrder.value = '';
    if(records.rows.length > recordsRowOffset) {
        for(i = recordsRowOffset; i < records.rows.length; i++) {
            oDnsRecordsOrder.value += (oDnsRecordsOrder.value == '' ? '' : ';')+records.rows[i].getAttribute('clearid');
        }
    }
    FormChanged();
}

function onChangeType(id) {
    var oType = document.getElementById('dr_type_' + id);
    var oPriority = document.getElementById('dr_priority_' + id);
    if(oType && oPriority) {
        if(oType.value == "MX") {
            oPriority.disabled = false;
        } else {
            oPriority.disabled = true;
        }
    }
}

//-->
</script>

<!--#set var="records_caption" value="<h3>%%domain%%: ##domain##</h3>"-->

  ##form_hint##
  <br>
    <form action='##script_link##' method=post enctype="multipart/form-data" name="dnsform" onSubmit="return CheckForm(window.document.dnsform);">
     <input type=hidden name=activate>
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type=hidden name='records_order' id='records_order' value=''>
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
##--if(IS_ADMIN==1)--##
     <tr>
       <td>
         ##records_capt##
       </td>
     </tr>
     <tr>
       <td>
         <table id="records" border=0 cellspacing="0" cellpadding="4">
           <tr>
             <td class="first_row_left_td list_name_col" width=200>%%name%%</td>
             <td class="first_row_all">%%ttl%%</td>
             <td class="first_row_all">%%type%%</td>
             <td class="first_row_all">%%priority%%</td>
             <td class="first_row_all">%%value%%*</td>
             <td class="first_row_all">%%actions%%</td>
           </tr>
         </table>
       </td>
     </tr>
     <tr>
       <td>
         <div id="dns_help_hint" style="font-size: 7pt; background-color: #FFFFE1; border: 1px #666666 solid; padding: 5px; width: 100%;">%%dns_help_hint%%</div>
       </td>
     </tr>
     <tr>
       <td>
         <input type=button value="%%add_record%%" class="but" onClick="insertDnsRecordRow()">
       </td>
     </tr>

##--endif--##
     ##res_fields##
      <tr>
        <td align="right">
        <br>
        ##form_buttons##
        <br><br>
        </td>
     </tr>
     <tr>
       <td>
         <sub>%%required_fields%%</sub>
       </td>
     </tr>
     </table>

    </form>
<script type="text/javascript">
<!--
##add_exists_records_rows##
updateDnsRecordsOrder();
-->
</script>