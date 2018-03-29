<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'referenceform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {
   var errmsg = "";

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }
   if (form.postfix.value=="") {
       return focusedAlert(form.postfix, '%%postfix_warn%%');
   }
   return true;
}

var rowNumber = 1;
var selectedItemId = 0;
var freeFields = new Array();
##free_fields##
function createArray(){
    return new Array();
}
function fillFreeFields(){
    var ff = this.document.referenceform.free_fields;

    // Remove all options
    for(i = ff.options.length; i > 0; i--){
        ff.options[ff.options.length-1] = null;
    }

    // Add options
    for(i = 0; i < freeFields.length; i++){
        if(freeFields[i][3] != '1')
            ff.options[ff.options.length] = new Option(freeFields[i][1], freeFields[i][0]);
    }

    // Hide the fields if required
    watchFreeFieldsDiv();
}

function insertFieldRow(fieldId){
    for(i = 0; i < freeFields.length; i++){
        if(freeFields[i][0] == fieldId){
            if(freeFields[i][3] != '1'){
                realfieldId = fieldId;
                if(freeFields[i][5] == '1')
                    freeFields[i][3] = '1';
                else{
                    freeFields[i][7] += 1;
                    fieldId = fieldId+'_'+freeFields[i][7];
                };
                
                oRow = realFieldsObj.insertRow(rowNumber++);
                oRow.setAttribute("id", "realFields_"+fieldId);
                oRow.setAttribute("clearid", fieldId);
                oRow.setAttribute("arrayid", i);
                oCell = oRow.insertCell(0);
                oCell.innerHTML = freeFields[i][1];
                oCell = oRow.insertCell(1);
                if(realfieldId < 100000)
                    oCell.innerHTML = '<input type=checkbox name=shared_'+fieldId+' value="1" id="chkshared_'+fieldId+'"'+(freeFields[i][4] == '1' ? ' checked' : '')+'>';
                else
                    oCell.innerHTML = '<input type=checkbox name=shared_'+fieldId+' value="1" disabled id="chkshared_'+fieldId+'" checked>';
                oCell.setAttribute("align", "center");
                oCell = oRow.insertCell(2);
                if(realfieldId < 100000)
                    oCell.innerHTML = '<input type=checkbox name=filter_'+fieldId+' value="1" id="chkfilter_'+fieldId+'"'+(freeFields[i][8] == '1' ? ' checked' : '')+'>';
                else
                    oCell.innerHTML = '<input type=checkbox name=filter_'+fieldId+' value="1" disabled id="chkfilter_'+fieldId+'" checked>';
                oCell.setAttribute("align", "center");

                oCell = oRow.insertCell(3);
                if(realfieldId < 100000)
                    oCell.innerHTML = '<input type=checkbox name=showempty_'+fieldId+' value="1" id="chkshowempty_'+fieldId+'"'+(freeFields[i][9] == '1' ? ' checked' : '')+'>';
                else
                    oCell.innerHTML = '<input type=checkbox name=showempty_'+fieldId+' value="1" disabled id="chkshowempty_'+fieldId+'" checked>';
                oCell.setAttribute("align", "center");

                oCell = oRow.insertCell(4);
                oCell.innerHTML = '<img src=skins/vanilla/icons/icon-pos_control.gif width=19 height=19 border=0 onmouseover="this.style.cursor=\'pointer\'" onmouseout="this.style.cursor=\'default\'" onclick="moveField(event, this, \''+fieldId+'\')">';
                oCell = oRow.insertCell(5);
                if(freeFields[i][6] == '1')
                    oCell.innerHTML = '<input type=text name=caption_'+fieldId+' value="'+freeFields[i][2]+'" class="field">';
                else
                    oCell.innerHTML = '&nbsp;';
                oCell = oRow.insertCell(6);
                oCell.innerHTML = '<nobr><a href="javascript:void('+fieldId+')" onClick="deleteFld(\''+fieldId+'\');return false;"><img src="skins/vanilla/icons/icon-del.gif" border=0></a> '+
                                  (realfieldId < 100000 ? '<a href="javascript:void('+fieldId+')" onClick="openExtDialog(\'Window dialog\', \'##CURRENT_OWNER##_custom_types.php?mode=popup&id='+realfieldId+'&action=edit#anchor\', 1);return false;"><img src="skins/vanilla/icons/icon-edit.gif" border=0></a></nobr>' : '');
                fillFreeFields();
                updateFieldMap();
            }
            break;
        }
    }
}

function moveField(evt, oImage, fieldId){
    var mousePos = amiCommon.getMousePosition(evt);
    var elementPos = amiCommon.getElementPosition(oImage);
    elementHalfX = oImage.offsetWidth / 2;
    elementHalfY = oImage.offsetHeight / 2;
    isOneStep = (mousePos[0] > elementPos[0] + elementHalfX);
    isUp = (mousePos[1] < elementPos[1] + elementHalfY);
    if(isUp){
        moveFldUp(fieldId, !isOneStep);
    }else{
        moveFldDown(fieldId, !isOneStep);
    }
}

function moveFldUp(curId, isTop){
    if(curId != ''){
        for(i = 1; i < realFieldsObj.rows.length; i++){
            if("realFields_"+curId == realFieldsObj.rows[i].getAttribute("id")){
                if(i > 1){
                    lastElem = isTop ? 2 : i;
                    for(j = i; j >= lastElem; j--){
                        crossSwapNodes(realFieldsObj.rows[j-1], realFieldsObj.rows[j]);
                    }
                    updateFieldMap();
                }
                break;
            }
        }
    }
}

function moveFldDown(curId, isBottom){
    if(curId != ''){
        for(i = 1; i < realFieldsObj.rows.length; i++){
            if("realFields_"+curId == realFieldsObj.rows[i].getAttribute("id")){
                if(i < realFieldsObj.rows.length-1){
                    lastElem = isBottom ? realFieldsObj.rows.length-2 : i;
                    for(j = i; j <= lastElem; j++){
                        crossSwapNodes(realFieldsObj.rows[j], realFieldsObj.rows[j + 1]);
                    }
                    updateFieldMap();
                }
                break;
            }
        }
    }
}

function deleteFld(curId){
    if(curId != ''){
        if(document.referenceform.initial_shared.value.indexOf(';'+curId+';') >= 0){
            if(!confirm('%%remove_shared%%'))
                return;
        }
        for(i = 1; i < realFieldsObj.rows.length; i++){
            if("realFields_"+curId == realFieldsObj.rows[i].getAttribute("id")){
                freeFields[realFieldsObj.rows[i].getAttribute("arrayid")][3] = '0';
                realFieldsObj.rows[i].parentNode.removeChild(realFieldsObj.rows[i]);
                rowNumber--;
                fillFreeFields();
                updateFieldMap();
                break;
            }
        }
    }
}

function deleteRow(curId){
    for(i = 1; i < realFieldsObj.rows.length; i++){
        if("realFields_"+curId == realFieldsObj.rows[i].getAttribute("id")){
            realFieldsObj.rows[i].parentNode.removeChild(realFieldsObj.rows[i]);
            rowNumber--;
            break;
        }
    }
}

function updateFieldMap(){
    document.referenceform.fields_map.value = '';
    for(i = 1; i < realFieldsObj.rows.length; i++){
        document.referenceform.fields_map.value += (document.referenceform.fields_map.value == '' ? '' : ';')+realFieldsObj.rows[i].getAttribute('clearid');
    }
    watchRealFieldsDiv();
}

function watchFreeFieldsDiv(){
    if(this.document.referenceform.free_fields.options.length <= 0){
        document.getElementById('free_fields_div').style.display = 'none';
    }else{
        document.getElementById('free_fields_div').style.display = 'inline';
    }
}

function watchRealFieldsDiv(){
    if(document.referenceform.fields_map.value == ''){
        document.getElementById('realFields').style.display = 'none';
        document.getElementById('realFieldsDesc').style.display = 'none';
    }else{
        document.getElementById('realFields').style.display = 'block';
        document.getElementById('realFieldsDesc').style.display = 'block';
    }
}

function OnObjectChanged_eshop_datasets_form_def(name, first_change, evt){
    if(name.indexOf('shared_') == 0){
        if(document.referenceform.initial_shared.value.indexOf(';'+name.substr(7)+';') >= 0){
            eval('chkObj = document.referenceform.'+name);
            if(chkObj && !chkObj.checked)
                alert('%%uncheck_shared%%');
        }
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_eshop_datasets_form_def);

-->
</script>


<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
"-->

<!--#set var="free_field" value="freeFields[freeFields.length] = new Array('##id##', '##name##', '##caption##', '##is_used##', '##is_shared##', '##is_unique##', '##need_caption##', 0, '##is_filter##', '##is_showempty##');
"-->
<!--#set var="init_fields" value="insertFieldRow('##id##');
"-->

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="referenceform" onSubmit="return CheckForm(this);">
     <input type="hidden" name="publish" value="">
     <input type="hidden" name="fields_map" value="">
     <input type="hidden" name="initial_shared" value="##initial_shared##">
     <input type="hidden" name="is_sys" value="##is_sys##">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     ##if(hasCustomFields)##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td>
        %%name%%*:
       </td>
       <td>
         <input type=text name=name class="field field40" value="##name##" maxlength="64">
       </td>
     </tr>
     <tr>
       <td>
        %%postfix%%*:
       </td>
       <td>
         <input type=text name=postfix class="field field40" value="##postfix##" maxlength="16">
       </td>
     </tr>
     <tr>
       <td>
        %%sku_map%%:
       </td>
       <td>
         <input type=text name=sku_map class="field field40" value="##sku_map##" maxlength="128">
       </td>
     </tr>
     <tr>
       <td>
        %%prop_repeat%%:
       </td>
       <td>
         <input type=text name=prop_repeat class="field field1" value="##prop_repeat##" maxlength="1">
       </td>
     </tr>
     <tr vAlign=top>
       <td>
        %%fields%%:
       </td>
       <td>
        <div class="tooltip" id="realFieldsDesc">%%dataset_desc%%</div>
        <table border=0 id="realFields" class="frm">
	<col width="150">
	<col width="*">
            <tr vAlign=top><td><br><nobr><b>%%fields_name%%</b><br>&nbsp;</nobr></td><td><br><nobr>&nbsp;<b>%%fields_shared%%</b>&nbsp;<br>&nbsp;</nobr></td><td><br><nobr>&nbsp;<b>%%fields_filter%%</b>&nbsp;<br>&nbsp;</nobr></td><td align=center><br><nobr>&nbsp;<b>%%fields_showempty%%</b>&nbsp;<br>&nbsp;</nobr></td><td></td><td><br><nobr><b>%%fields_caption%%</b><br>&nbsp;</nobr></td><td></td></tr>
        </table>
        <div id="free_fields_div" style="display:none">
        <select name="free_fields">
        </select>
        <span class="text_button" onClick="insertFieldRow(document.referenceform.free_fields.value)">%%button_add%%</span>
        </div>
        <br>
        <br>
        <input type=button value="%%button_edit_fields%%" class="but-long" onClick="openExtDialog('title', '##CURRENT_OWNER##_custom_types.php?mode=popup', 1)">

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
     ##else##
        %%fields_no%%
     ##endif##
    </form>

    <script>
        realFieldsObj = document.getElementById('realFields');
        fillFreeFields();
        ##init_fields##
        watchRealFieldsDiv();
    </script>