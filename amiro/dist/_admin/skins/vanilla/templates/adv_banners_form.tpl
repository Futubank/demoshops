%%include_language "templates/lang/adv_banners.lng"%%

<!--#set var="select_option" value="<option value="##value##" ##selected##>##name##</option>"-->
<!--#set var="field_row_item" value="insertFieldRow('##type##', '##bcond##', '##cond##', '##data##', '##data1##', '##data2##');"-->
<!--#set var="text_banner" value="
     <tr id=id_field_##id## style="display: none">
       <td width=150>
         ##field_name##:
       </td>
       <td>
         <input type=text class="field field50" name=field_##id## maxlen="##maxlen##" value="##value##">
       </td>
     </tr>
"-->
<!--#set var="text_banner_JS" value="
    if(type == 1)
        document.getElementById("id_field_##id##").style.display = tableRowShowStyle;
    else
        document.getElementById("id_field_##id##").style.display = 'none';
"-->

<!--#set var="audit_select_status" value="
    if(form.audit_status.value=='approve') {
        form.status.options[1].selected = true;
    }
    if(form.audit_status.value=='reject') {
        form.status.options[2].selected = true;
    }
"-->


<script type="text/javascript">
<!--
var _cms_document_form = 'advbannersform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
var editor_enable = '0';

function onTypeChange(){
    type = document.forms.advbannersform.type.value;
    if(type == 1){
        document.getElementById("id_file").style.display = 'none';
    }else{
        document.getElementById("id_file").style.display = tableRowShowStyle;
    }
    ##text_banner_JS##
}

function OnObjectChanged_adv_banners_form(name, first_change, evt){
    if(name == "is_default"){
        onChangedIsDef();
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_adv_banners_form);

function onChangedIsDef(){
    if(document.forms.advbannersform.is_default.checked){
        document.getElementById("trPlaces").style.display = tableRowShowStyle;
        document.getElementById("trCampaigns").style.display = 'none';
    }else{
        document.getElementById("trPlaces").style.display = 'none';
        document.getElementById("trCampaigns").style.display = tableRowShowStyle;
    }
}

function CheckForm(form) {
   var errmsg = "";

   ##audit_check_form##

   if (form.name.value == "") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

##--
   for(i = 0; i < form.elements.length; i++){
    if(form.elements[i].name == "campaigns[]"){
        if(!(form.elements[i].value > 0)){
           return focusedAlert(form.elements[i], '%%campaigns_warn%%');
        }
        break;
    }
   }
--##

   if (form.url.value == "" || form.url.value == "http://" || form.url.value == "https://") {
       return focusedAlert(form.url, '%%url_warn%%');
   }

   if (form.type.value == 1 && form.field_1 && form.field_1.value == ""){
       return focusedAlert(form.field_1, '%%text_warn%%');
   }

   ##if(FORM_MODE != "EDIT")##
   if (form.type.value != 1 && form.banner.value == ""){
       return focusedAlert(form.banner, '%%banner_warn%%');
   }
   ##endif##

   return true;
}
      
var selectedItemId = 0;
var currentFieldId = 0;

function insertFieldRow(tgtType, tBCond, tCond, tgtData, tgtData1, tgtData2){
    currentFieldId++;
    var tableTargeting = document.getElementById('idTableTargeting');
    oRow = tableTargeting.insertRow(tableTargeting.rows.length);
    oRow.setAttribute("id", "tableTargeting_"+currentFieldId);
    oRow.setAttribute("clearid", currentFieldId);
    oRow.setAttribute("vAlign", "top");
    
    tBCond = tBCond == undefined ? 'AND' : tBCond;
    tCond = tCond == undefined ? '==' : tCond;

    oCell = oRow.insertCell(0);
    oCell.className="row2";
        oCell.innerHTML = '<select name=tgt_bcond_'+currentFieldId+' id=sel_tgt_bcond_'+currentFieldId+'><option value="AND">%%tgt_cond_and%%</option><option value="OR" '+(tBCond == 'OR' ? "selected" : "")+'>%%tgt_cond_or%%</option></select>&nbsp;&nbsp;';

    oCell = oRow.insertCell(1);
    oCell.className="row2";
    if(tgtType == "weekday")
        oCell.innerHTML = '%%targeting_weekday%%&nbsp;&nbsp;&nbsp;';
    else if(tgtType == "time")
        oCell.innerHTML = '%%targeting_time%%&nbsp;&nbsp;&nbsp;';
    else if(tgtType == "date")       
        oCell.innerHTML = '%%targeting_date%%&nbsp;&nbsp;&nbsp;';
    else if(tgtType == "referrer")
        oCell.innerHTML = '%%targeting_referrer%%&nbsp;&nbsp;&nbsp;';

    oCell = oRow.insertCell(2);
    oCell.className="row2";
    cellHtml = "";
    if(tgtType == "weekday"){
        tgtData = tgtData == undefined ? "0000000" : tgtData;
        cellHtml += '<input type=hidden name=tgt_type_'+currentFieldId+' value=weekday><select name=tgt_cond_'+currentFieldId+'><option value="==">%%tgt_cond_equal%%</option><option value="!=" '+(tCond == '!=' ? 'selected' : '')+'>%%tgt_cond_notequal%%</option></select><br>'+
                    '<table><tr><td nowrap><input type=checkbox name=chktgt_'+currentFieldId+'_mo '+(tgtData.charAt(1) == '1' ? 'checked' : '')+'> %%tgt_wd_mo%%</td><td nowrap><input type=checkbox name=chktgt_'+currentFieldId+'_tu '+(tgtData.charAt(2) == '1' ? 'checked' : '')+'> %%tgt_wd_tu%%</td><td nowrap><input type=checkbox name=chktgt_'+currentFieldId+'_we '+(tgtData.charAt(3) == '1' ? 'checked' : '')+'> %%tgt_wd_we%%</td><td nowrap><input type=checkbox name=chktgt_'+currentFieldId+'_th '+(tgtData.charAt(4) == '1' ? 'checked' : '')+'> %%tgt_wd_th%%</td></tr><tr><td nowrap><input type=checkbox name=chktgt_'+currentFieldId+'_fr '+(tgtData.charAt(5) == '1' ? 'checked' : '')+'> %%tgt_wd_fr%%</td><td nowrap><input type=checkbox name=chktgt_'+currentFieldId+'_sa '+(tgtData.charAt(6) == '1' ? 'checked' : '')+'> %%tgt_wd_sa%%</td><td nowrap><input type=checkbox name=chktgt_'+currentFieldId+'_su '+(tgtData.charAt(0) == '1' ? 'checked' : '')+'> %%tgt_wd_su%%</td></tr></table><br>';
    }else if(tgtType == "time"){
        tgtData = tgtData == undefined ? "000000000000000000000000" : tgtData;
        cellHtml += '<input type=hidden name=tgt_type_'+currentFieldId+' value=time><table border=0 cellpadding=0><tr vAlign=top><td><select name=tgt_cond_'+currentFieldId+'><option value="==">%%tgt_cond_equal%%</option><option value="!=" '+(tCond == '!=' ? 'selected' : '')+'>%%tgt_cond_notequal%%</option></select></td><td>'+
                    '<select name="tgt_'+currentFieldId+'[]" multiple size=5>';
        for(i = 0; i <= 23; i++){
            cellHtml += '<option value='+i+' '+(tgtData.charAt(i) == '1' ? 'selected' : '')+'>'+i+':00</option>';
        }
        cellHtml += '</td></tr></table><br>';
    }else if(tgtType == "date"){
        tgtData = tgtData == undefined ? "0" : tgtData;
        tgtData1 = tgtData1 == undefined ? "0" : tgtData1;
        tgtData2 = tgtData2 == undefined ? "0" : tgtData2;
        cellHtml += '<input type=hidden name=tgt_type_'+currentFieldId+' value=date><select name=tgt_cond_'+currentFieldId+'><option value="==">%%tgt_cond_equal%%</option><option value="!=" '+(tCond == '!=' ? 'selected' : '')+'>%%tgt_cond_notequal%%</option><option value=">" '+(tCond == '>' ? 'selected' : '')+'>%%tgt_cond_later%%</option><option value=">=" '+(tCond == '>=' ? 'selected' : '')+'>%%tgt_cond_latereq%%</option><option value="<" '+(tCond == '<' ? 'selected' : '')+'>%%tgt_cond_earlier%%</option><option value="<=" '+(tCond == '<=' ? 'selected' : '')+'>%%tgt_cond_earliereq%%</option></select><br>'+
                    '<select name=tgtday_'+currentFieldId+'>';
        for(i = 1; i <= 31; i++){
            cellHtml += '<option value='+i+' '+(tgtData == i ? "selected" : "")+'>'+(i < 10 ? '0'+i : i)+'</option>';
        }
        cellHtml += '</select> <select name=tgtmon_'+currentFieldId+'>';
        tgtMon = new Array('%%tgt_mon_jan%%', '%%tgt_mon_feb%%', '%%tgt_mon_mar%%', '%%tgt_mon_apr%%', '%%tgt_mon_may%%', '%%tgt_mon_jun%%', '%%tgt_mon_jul%%', '%%tgt_mon_aug%%', '%%tgt_mon_sep%%', '%%tgt_mon_oct%%', '%%tgt_mon_nov%%', '%%tgt_mon_dec%%');
        for(i = 1; i <= 12; i++){
            cellHtml += '<option value='+i+' '+(tgtData1 == i ? "selected" : "")+'>'+tgtMon[i-1]+'</option>';
        }
        cellHtml += '</select> <select name=tgtyear_'+currentFieldId+'>';
        Today = new Date();
        TodayYear = Today.getFullYear();
        for(i = TodayYear; i <= TodayYear+10; i++){
            cellHtml += '<option value='+i+' '+(tgtData2 == i ? "selected" : "")+'>'+i+'</option>';
        }
        cellHtml += '</select><br>&nbsp;';
    }else if(tgtType == "referrer"){
        tgtData = tgtData == undefined ? "" : tgtData;
        cellHtml += '<input type=hidden name=tgt_type_'+currentFieldId+' value=referrer><select name=tgt_cond_'+currentFieldId+'><option value="==">%%tgt_cond_cont%%</option><option value="!=" '+(tCond == '!=' ? 'selected' : '')+'>%%tgt_cond_ncont%%</option></select><br>'+
                    '<input type=text name="tgt_'+currentFieldId+'" class="field field30" value="'+tgtData+'"><br>&nbsp;';
    }
    oCell.innerHTML = cellHtml;

    oCell = oRow.insertCell(3);
    oCell.className="row2";
    oCell.innerHTML = '&nbsp;&nbsp;&nbsp;<img src=skins/vanilla/icons/icon-pos_control.gif width=19 height=19 border=0 onmouseover="this.style.cursor=\'pointer\'" onmouseout="this.style.cursor=\'default\'" onclick="moveField(event, this, \''+currentFieldId+'\')">';
    
    oCell = oRow.insertCell(4);
    oCell.className="row2";
    oCell.innerHTML = '<nobr><a href="javascript:void('+currentFieldId+')" onClick="deleteFld(\''+currentFieldId+'\');return false;"><img src="skins/vanilla/icons/icon-del.gif" border=0></a> ';
    
    if(tableTargeting.rows.length == 2)
        document.getElementById('sel_tgt_bcond_'+currentFieldId).style.display='none';
    
    updateFieldMap();
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
    var tableTargeting = document.getElementById('idTableTargeting');
    if(curId != ''){
        for(i = 1; i < tableTargeting.rows.length; i++){
            if("tableTargeting_"+curId == tableTargeting.rows[i].getAttribute("id")){
                if(i > 1){
                    lastElem = isTop ? 2 : i;
                    for(j = i; j >= lastElem; j--){
                        crossSwapNodes(tableTargeting.rows[j-1], tableTargeting.rows[j]);
                        if(j-1 == 1){
                            id1 = tableTargeting.rows[j-1].getAttribute("clearid");
                            id2 = tableTargeting.rows[j].getAttribute("clearid");
                            document.getElementById('sel_tgt_bcond_'+id1).style.display='none';
                            document.getElementById('sel_tgt_bcond_'+id2).style.display='block';
                        }
                    }
                    
                    updateFieldMap();
                }
                break;
            }
        }
    }
}

function moveFldDown(curId, isBottom){
    var tableTargeting = document.getElementById('idTableTargeting');
    if(curId != ''){
        for(i = 1; i < tableTargeting.rows.length; i++){
            if("tableTargeting_"+curId == tableTargeting.rows[i].getAttribute("id")){
                if(i < tableTargeting.rows.length-1){
                    lastElem = isBottom ? tableTargeting.rows.length-2 : i;
                    for(j = i; j <= lastElem; j++){
                        crossSwapNodes(tableTargeting.rows[j], tableTargeting.rows[j + 1]);
                        if(j == 1){
                            id1 = tableTargeting.rows[j].getAttribute("clearid");
                            id2 = tableTargeting.rows[j+1].getAttribute("clearid");
                            document.getElementById('sel_tgt_bcond_'+id1).style.display='none';
                            document.getElementById('sel_tgt_bcond_'+id2).style.display='block';
                        }
                    }
                    updateFieldMap();
                }
                break;
            }
        }
    }
}

var storedChkData = Array();
function storeChkData(prefx){
    if(prefx == undefined)
        prefx = '';
    for(i = 0; i < document.forms.advbannersform.elements.length; i++){
        if((prefx == '' || document.forms.advbannersform.elements[i].name.indexOf(prefx) >= 0) && document.forms.advbannersform.elements[i].type == 'checkbox'){
            storedChkData[document.forms.advbannersform.elements[i].name] = document.forms.advbannersform.elements[i].checked;
        }
    }
}
function restoreChkData(prefx){
    if(prefx == undefined)
        prefx = '';
    for(i = 0; i < document.forms.advbannersform.elements.length; i++){
        if((prefx == '' || document.forms.advbannersform.elements[i].name.indexOf(prefx) >= 0) && document.forms.advbannersform.elements[i].type == 'checkbox' && storedChkData[document.forms.advbannersform.elements[i].name]){
            document.forms.advbannersform.elements[i].checked = storedChkData[document.forms.advbannersform.elements[i].name];
        }
    }
}

function deleteFld(curId){
    var tableTargeting = document.getElementById('idTableTargeting');
    if(curId != ''){
        for(i = 1; i < tableTargeting.rows.length; i++){
            if("tableTargeting_"+curId == tableTargeting.rows[i].getAttribute("id")){
                tableTargeting.rows[i].parentNode.removeChild(tableTargeting.rows[i]);
                if(i == 1 && tableTargeting.rows.length > 1){
                    id1 = tableTargeting.rows[1].getAttribute("clearid");
                    document.getElementById('sel_tgt_bcond_'+id1).style.display='none';
                }
                updateFieldMap();
                break;
            }
        }
    }
}

function updateFieldMap(){
    var tableTargeting = document.getElementById('idTableTargeting');
    document.forms.advbannersform.fields_map.value = '';
    for(i = 1; i < tableTargeting.rows.length; i++){
        document.forms.advbannersform.fields_map.value += (document.forms.advbannersform.fields_map.value == '' ? '' : ';')+tableTargeting.rows[i].getAttribute('clearid');
    }
}
-->
</script>

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="advbannersform" onSubmit="return CheckForm(this);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type="hidden" name="publish" value="">
     <input type="hidden" name="fields_map" value="">
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
     <tr>
       <td>
         <input type="checkbox" name="public" ##public## value="1" helpId= "form_public">
         %%public%%
       </td>
       <td align=right></td>
     </tr>
     ##_id_page_field##
     <tr>
       <td>
         %%status%%:
       </td>
       <td>
         <select name="status">
            <option value=1 ##status_1##>%%status_waiting%%</option>
            <option value=2 ##status_2##>%%status_approved%%</option>
            <option value=3 ##status_3##>%%status_declined%%</option>
         </select>
       </td>
     </tr>
     <tr>
       <td width=150>
         %%name%%*:
       </td>
       <td>
         <input type=text name=name class="field field50" value="##name##" >
       </td>
     </tr>
     <tr>
       <td width=150>
         <label for=idDef>%%is_default%%</label>
       </td>
       <td><input type="checkbox" name="is_default" ##is_default## value="1" id=idDef></td>
     </tr>
     <tr id=trPlaces style="display: none">
       <td>
         %%places%%*:
       </td>
       <td>
         <select name=places[] size=5 multiple>
            ##places##
         </select>
       </td>
     </tr>
     <tr id=trCampaigns>
       <td>
         %%campaigns%%*:
       </td>
       <td>
         <select name=campaigns[] size=5 multiple>
            ##campaigns##
         </select>
       </td>
     </tr>
     <tr>
       <td width=150>
         %%url%%*:
       </td>
       <td>
         <input type=text name=url class="field field50" value="##url##" >
       </td>
     </tr>
     <tr>
       <td>
         %%type%%:
       </td>
       <td>
         <select name="type" onChange="onTypeChange()">
            <option value=2 ##type_2##>%%type_imgflash%%</option>
            <option value=1 ##type_1##>%%type_text%%</option>
         </select>
       </td>
     </tr>
     <tr id=id_file style="display: none">
       <td width=150>
         %%file%%*:
         ##if(FORM_MODE == "EDIT")##
         <br><small>%%file_notice%%</small>
         ##endif##
       </td>
       <td>
         ##if(FORM_MODE == "EDIT" && banner!="")##
            <a href="##banner##" target=_blank>%%current_image%%</a><br>
         ##endif##

         <input type=file name=banner class="field field100" value="" >
       </td>
     </tr>
     ##text_banner##
     <tr>
       <td colspan=2 height=40>
         <hr>
       </td>
     </tr>
     <tr vAlign=top>
       <td>
         %%targeting%%:
       </td>
       <td>
            <table border=0 cellpadding=5 cellspacing=0 id=idTableTargeting>
                <tr>
                    <td><nobr>&nbsp;<br>&nbsp;</nobr></td>
                    <td><nobr>%%targ_header_criteria%%&nbsp;&nbsp;&nbsp;<br>&nbsp;</nobr></td>
                    <td><nobr>%%targ_header_condition%%<br>&nbsp;</nobr></td>
                    <td><nobr>&nbsp;<br>&nbsp;</nobr></td>
                    <td><nobr>&nbsp;<br>&nbsp;</nobr></td>
                </tr>
            </table>
            <br>
            <select name=opt_targeting_type>
                <option value=weekday>%%targeting_weekday%%</option>
                <option value=time>%%targeting_time%%</option>
                <option value=date>%%targeting_date%%</option>
                <option value=referrer>%%targeting_referrer%%</option>
            </select>
            <input type=button value="%%add_targeting%%" class="but" onClick="insertFieldRow(document.forms.advbannersform.opt_targeting_type.value)">
       </td>
     </tr>
     
##if(EXT_AUDIT=="1")##
     <tr>
       <td colspan=2>
         <hr>
         %%tab_audit%%:<br>
         ##audit_form##
         <script language=javascript>
            if(document.getElementById('div_audit'))document.getElementById('div_audit').style.display='block';
            if(document.getElementById('table_audit'))document.getElementById('table_audit').style.border = '0px';
         </script>
       </td>
     </tr>
##endif##
     
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
    
<script type="text/javascript">
onChangedIsDef();
onTypeChange();
##field_row_items##
</script>