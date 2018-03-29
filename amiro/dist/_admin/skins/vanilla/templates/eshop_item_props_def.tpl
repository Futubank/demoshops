<!--#set var="prop_table" value="
    <form name="addprop" method="POST" id="itemPropsForm" onSubmit="return(wasOpersChanged ? confirm('%%opers_changed%%') : true)">
    <input type=hidden name=action value=save>
    <input type=hidden name=fields_map value=''>
    <input type=hidden name=isPropsShown value=1>
    <input type=hidden name=isOpersShown value=0>
    <input type=checkbox name=show_all_props value="1" ##show_all_props## id=id_show_all_props> <label for="id_show_all_props">%%show_all_props%%</label><br>
    <table id="itemProps" border="0" width="100%" cellspacing="0" cellpadding="0">
        ##header##
        ##add_row##
    </table>
    <br>
    <table border=0 width=100% cellpadding=0 cellspacing=0>
        <tr><td align=right>
            <input type="submit" value='%%button_apply%%' class=but>
        </td></tr>
    </table>
    </form>
"-->

<!--#set var="prop_Hrow" value="<tr>##data##<td class="first_row_all" width=65 align=center>%%prop_rest%%</td><td class="first_row_all" width=70 align=center>%%actions%%</td></tr>"-->
<!--#set var="prop_Hcell" value="<td class="##if(is_first)##first_row_left_td##else##first_row_all##endif##">##name##</td>"-->

<!--#set var="prop_Arow" value="<tr vAlign=top>##data##<td class="" align=center><br><input type="text" class="field field8" name="add_prop_rest" value="0" ></td><td width=70 align=center><br><input type="submit" value="%%button_add%%" class=but onClick="onAddNewRow();return false;"></td></tr>"-->
<!--#set var="prop_Acell_text" value="<td class=""><br><input type=text name='add_prop_##fnum##' class="field field25" ></td>"-->
<!--#set var="prop_Acell_picture" value="<td class=""><br><input type=hidden name=add_prop_##fnum## class=field value="" onChange="addPropChanged('add_prop_##fnum##')"><span id="div_img_add_prop_##fnum##">##edit_picture##</span></td>"-->
<!--#set var="prop_Acell_select" value="<td class=""><br><select name='add_prop_##fnum##' class=field>##options##</select></td>"-->
<!--#set var="prop_Acell_select_option" value="<option value="##value##">##name##</option>"-->
<!--#set var="prop_Acell_checkbox" value="<td class=""><br><input type='hidden' name='add_prop_##fnum##' class=field><input type='hidden' name='add_prop_val_##fnum##' class=field>##flags##</select></td>"-->
<!--#set var="prop_Acell_checkbox_item" value="<input type=checkbox name=add_prop_##fnum##_##num## value="##num##" onClick="setCheckFld('##fnum##', '##num##', this.checked, 1)">##name##<br>"-->

<!--#set var="prop_add" value="addPropRow(new Array(##prop_data##, ##rest##));"-->
<!--#set var="props_nums" value="propsNums[##num##]=##fnum##;propsTypes[##num##]='##htype##';"-->
<!--#set var="flag_names_new" value="flagCaptions[##fnum##]=Array();"-->
<!--#set var="flag_names" value="flagCaptions[##fnum##][##num##]='##name##';"-->

<!--#set var="oper_table" value="
    <form name="addoper" method="POST" id="itemOpersForm" onSubmit="return checkOperForm(this);">
    <input type=hidden name=action value=apply>
    <input type=hidden name=fields_map_oper value=''>
    <input type=hidden name=isPropsShown value=1>
    <input type=hidden name=isOpersShown value=0>
    <div class="tooltip">%%opers_note%%</div><br>
    <table id="itemOpers" border="0" width="100%" cellspacing="0" cellpadding="0">
        ##header##
        ##add_row##
    </table>
    <br>
    <table border=0 width=100% cellpadding=0 cellspacing=0>
        <tr><td align=right>
            <input type="submit" value='%%button_apply_oper%%' class=but>
        </td></tr>
    </table>
    </form>
"-->

<!--#set var="oper_Hrow" value="
<tr>
    ##data##
    <td class="first_row_all" width=180 align=center colspan=3>
    <table cellpadding=0 cellspacing=0 width=100%>
        <tr><td colspan=3 align=center><b>%%props_operate_at%%</b><br>&nbsp;</td></tr>
        <tr>
            <td width=65 align=center><b>%%oper_price%%</b></td>
            <td width=65 align=center><b>%%oper_weight%%</b></td>
            <td width=65 align=center><b>%%oper_size%%</b></td>
        </tr>
    </table>
    </td>
    <td class="first_row_all" width=60 align=center>%%oper_stop%%</td>
    <td class="first_row_all" width=70 align=center>%%actions%%</td>
</tr>
"-->
<!--#set var="oper_Hcell" value="<td class="##if(is_first)##first_row_left_td##else##first_row_all##endif##">##name##</td>"-->

<!--#set var="oper_Arow" value="
    <tr vAlign=top>
        ##data##
        <td class="" width=65 align=center><br><input type="text" class="field field8" name="add_oper_price" value="" ></td>
        <td class="" width=65 align=center><br><input type="text" class="field field8" name="add_oper_weight" value="" ></td>
        <td class="" width=65 align=center><br><input type="text" class="field field8" name="add_oper_size" value="" ></td>
        <td class="" align=center><br><input type="checkbox" name="add_oper_stop" value="1" class="field6"></td>
        <td width=70 align=center><br><input type="submit" value="%%button_add%%" class=but onClick="onAddNewOperRow();return false;"></td>
        </tr>
"-->
<!--#set var="oper_Acell_text" value="<td class=""><br><input type=text name='add_oper_##fnum##' class="field field25" ></td>"-->
<!--#set var="oper_Acell_picture" value="<td class=""><br><input type=hidden name=add_oper_##fnum## class=field value="" onChange="addPropChanged('add_oper_##fnum##')"><span id="div_img_add_oper_##fnum##">##edit_picture##</span></td>"-->
<!--#set var="oper_Acell_select" value="<td class=""><br><select name='add_oper_##fnum##' class=field>##options##</select></td>"-->
<!--#set var="oper_Acell_select_option" value="<option value="##value##">##name##</option>"-->
<!--#set var="oper_Acell_checkbox" value="<td class=""><br><input type='hidden' name='add_oper_##fnum##' class=field><input type='hidden' name='add_oper_val_##fnum##' class=field>##flags##</select></td>"-->
<!--#set var="oper_Acell_checkbox_item" value="<input type=checkbox name=add_oper_##fnum##_##num## value="##num##" onClick="setCheckFld('##fnum##', '##num##', this.checked, 2)">##name##<br>"-->

<!--#set var="oper_add" value="addOperRow(new Array(##oper_data##, ##price##, ##weight##, ##size##, ##stop##));"-->
<!--#set var="opers_nums" value="opersNums[##num##]=##fnum##;opersTypes[##num##]='##htype##';"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - %%title%%</TITLE>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css">
<link rel="stylesheet" href="##skin_path##_css/scroll_bars.css" type="text/css">
<script type="text/javascript">
var editorBaseHref = '##root_path_www##';
var cms_version = '##cms_version##';
var interface_lang = '##admin_lang##';
</script>

##scripts##

<script type="text/javascript">

##pictures_js_vars##

function addPropChanged(name){
  ##pictures_js_script##
  return true;
}

##images_preload##

function HandleError(message, url, line) {
  return true;
}


function Init() {

  var editorBaseHref = top.editorBaseHref;

  top.document.forms['eshop_form'].rest.value = document.forms['pagersform'].rest_total.value;
}

function applyForm() {
  closeDialogWindow();
  return false;
}

var wasOpersChanged = 0;
var wasPropsChanged = 0;

var flagCaptions = new Array();
var flagMaps = new Array();
var flagNames = new Array();

var numProps = parseInt('##num_props##');
var propsNums = new Array();
var opersNums = new Array();
var propsTypes = new Array();
var opersTypes = new Array();
var fieldsMap = new Array();
var fieldsMapOper = new Array();
var fieldIDtoMap = new Array();
var fieldIDtoMapOper = new Array();
var curPropType=1;
var selectedItemId=0;
##props_nums##
##opers_nums##
##flag_names##
var indexCount = 0;
var numOfProps = 0;
var numOfOps = 0;
var oItemProps = null;
var oItemOpers = null;

function amiHTMLEntities(s){
    return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/#/g, '&#035;');
}

function amiSingleQuote(s){
    return String(s).replace(/'/g, '&#039;');
}

function addPropRow(propData, fromInterface){
    if(propData.length){
        var
            fromInterface = typeof(fromInterface) != 'undefined' && fromInterface,
            caption, value;

        wasPropsChanged = 1;
        // Check for duplicates
        for(k = 0; k < fieldsMap.length; k++){
            isSimilar = true;
            for(i = 0; i < numProps * 2; i++){
                if(
                    fieldsMap[k] &&
                    (fieldsMap[k][i] != propData[i]) && (fieldsMap[k][i] != amiSingleQuote(amiHTMLEntities(propData[i])))
                ){
                    isSimilar = false;
                    break;
                }else if(!fieldsMap[k]){
                    isSimilar = false;
                }
            }
            if(isSimilar){
                alert('%%props_already_exists%%');
                return;
            }
        }
        setNumOfRows(1, 1);
        indexCount++;
        fieldsMap[fieldsMap.length] = new Array();
        // Add new row
        rowID = oItemProps.rows.length;
        fieldIDtoMap[indexCount] = fieldsMap.length-1;
        oRow = oItemProps.insertRow(rowID-1);
        oRow.setAttribute("id", "itemProp_"+indexCount);
        oRow.setAttribute("clearid", indexCount);
        oRow.setAttribute("className", rowID%2 == 0 ? "row2" : "row1");
        for(i = 0; i < numProps; i++){
            fieldsMap[fieldsMap.length-1][i*2] = propData[i*2];
            fieldsMap[fieldsMap.length-1][i*2+1] = propData[i*2+1];
            oCell = oRow.insertCell(i);
            caption = fromInterface ? amiHTMLEntities(propData[i * 2 + 1]) : propData[i * 2 + 1];
            value = fromInterface ? amiSingleQuote(amiHTMLEntities(propData[i * 2])) : propData[i * 2];
            oCell.innerHTML = (propData[i*2+1] == '' ? '&nbsp;' : (propData[i*2+1].indexOf('_mod_files/ce_images')==0 ? "<img src='##www_path##"+propData[i*2+1]+"'>" : caption))+"<input type='hidden' name='prop_"+propsNums[i]+"_"+indexCount+"' value='" + value + "' />";
        }
        oCell = oRow.insertCell(i);
        value = fromInterface ? amiSingleQuote(amiHTMLEntities(propData[i * 2])) : propData[i * 2];
        oCell.innerHTML = "<input type='text' class=\"field field8\" name='rest_prop_"+indexCount+"' value='" + value + "' />";
        oCell.setAttribute("align", "center");
        oCell = oRow.insertCell(i+1);
        oCell.innerHTML = '<img src=skins/vanilla/icons/icon-pos_control.gif width=19 height=19 border=0 onmouseover="this.style.cursor=\'pointer\'" onmouseout="this.style.cursor=\'default\'" onclick="moveField(event, this, 1, \''+indexCount+'\');">&nbsp;<a href="javascript:void(0)" onClick="deleteFld(\''+indexCount+'\', 1);return false;"><img src="skins/vanilla/icons/icon-del.gif" border=0></a>';
        oCell.setAttribute("align", "center");
        updateFieldMap();
    }
}

var indexCountOper = 0;
function addOperRow(propData){
    if(propData.length){
        wasOpersChanged = 1;
        // Check for duplicates
        for(k = 0; k < fieldsMapOper.length; k++){
            isSimilar = true;
            for(i = 0; i < numProps*2; i++){
                if(fieldsMapOper[k] && fieldsMapOper[k][i] != propData[i]){
                    isSimilar = false;
                    break;
                }else if(!fieldsMapOper[k]){
                    isSimilar = false;
                }
            }
            if(isSimilar){
                alert('%%opers_already_exists%%');
                return;
            }
        }
        setNumOfRows(0, 1);
        indexCountOper++;
        fieldsMapOper[fieldsMapOper.length] = new Array();
        // Add new row
        rowID = oItemOpers.rows.length;
        fieldIDtoMapOper[indexCountOper] = fieldsMapOper.length-1;
        oRow = oItemOpers.insertRow(rowID-1);
        oRow.setAttribute("id", "itemOper_"+indexCountOper);
        oRow.setAttribute("clearid", indexCountOper);
        oRow.setAttribute("className", rowID%2 == 0 ? "row2" : "row1");
        for(i = 0; i < numProps; i++){
            fieldsMapOper[fieldsMapOper.length-1][i*2] = propData[i*2];
            fieldsMapOper[fieldsMapOper.length-1][i*2+1] = propData[i*2+1];
            oCell = oRow.insertCell(i);
            oCell.innerHTML = (propData[i*2+1] == '' ? '&nbsp;' : (propData[i*2+1].indexOf('_mod_files/ce_images')==0 ? "<img src='##www_path##"+propData[i*2+1]+"'>" : propData[i*2+1]))+"<input type='hidden' name='oper_"+opersNums[i]+"_"+indexCountOper+"' value='"+propData[i*2]+"'>";
        }
        oCell = oRow.insertCell(i);
        oCell.innerHTML = "<input type='text' class=\"field field8\" name='price_oper_"+indexCountOper+"' value='"+propData[i*2]+"' >";
        oCell.setAttribute("align", "center");
        oCell = oRow.insertCell(i+1);
        oCell.innerHTML = "<input type='text' class=\"field field8\" name='weight_oper_"+indexCountOper+"' value='"+propData[i*2+1]+"' >";
        oCell.setAttribute("align", "center");
        oCell = oRow.insertCell(i+2);
        oCell.innerHTML = "<input type='text' class=\"field field8\" name='size_oper_"+indexCountOper+"' value='"+propData[i*2+2]+"' >";
        oCell.setAttribute("align", "center");
        oCell = oRow.insertCell(i+3);
        oCell.innerHTML = "<input type='checkbox' id=id_stop_oper_"+indexCountOper+" name='stop_oper_"+indexCountOper+"' value='1' "+(propData[i*2+3] == '1' ? 'checked' : '')+">";
        oCell.setAttribute("align", "center");
        oCell = oRow.insertCell(i+4);
        oCell.innerHTML = '<img src=skins/vanilla/icons/icon-pos_control.gif width=19 height=19 border=0 onmouseover="this.style.cursor=\'pointer\'" onmouseout="this.style.cursor=\'default\'" onclick="moveField(event, this, 2, \''+indexCountOper+'\');">&nbsp;<a href="javascript:void(0)" onClick="deleteFld(\''+indexCountOper+'\', 2);return false;"><img src="skins/vanilla/icons/icon-del.gif" border=0></a>';
        oCell.setAttribute("align", "center");
        updateFieldMapOper();
    }
}

function deleteFld(curId, propType){
    if(curId != ''){
        if(propType == 2){
            for(i = 1; i < oItemOpers.rows.length; i++){
                if("itemOper_"+curId == oItemOpers.rows[i].getAttribute("id")){
                    setNumOfRows(0, -1);
                    wasOpersChanged = 1;
                    oItemOpers.rows[i].parentNode.removeChild(oItemOpers.rows[i]);
                    if(fieldIDtoMapOper[curId]){
                        fieldsMapOper[fieldIDtoMapOper[curId]] = undefined;
                    }
                    break;
                }
            }
            updateFieldMapOper();
        }else{
            for(i = 1; i < oItemProps.rows.length; i++){
                if("itemProp_"+curId == oItemProps.rows[i].getAttribute("id")){
                    setNumOfRows(1, -1);
                    wasPropsChanged = 1;
                    oItemProps.rows[i].parentNode.removeChild(oItemProps.rows[i]);
                    if(fieldIDtoMap[curId]){
                        fieldsMap[fieldIDtoMap[curId]] = undefined;
                    }
                    break;
                }
            }
            updateFieldMap();
        }
    }
}

function moveField(evt, oImage, currentType, fieldId){
    var mousePos = amiCommon.getMousePosition(evt);
    var elementPos = amiCommon.getElementPosition(oImage);
    elementHalfX = oImage.offsetWidth / 2;
    elementHalfY = oImage.offsetHeight / 2;
    isOneStep = (mousePos[0] > elementPos[0] + elementHalfX);
    isUp = (mousePos[1] < elementPos[1] + elementHalfY);
    if(isUp){
        moveFldUp(fieldId, currentType, !isOneStep);
    }else{
        moveFldDown(fieldId, currentType, !isOneStep);
    }
}

function moveFldUp(curId, propType, isTop){
    if(curId != ''){
        var currTable = (propType == 2 ? oItemOpers : oItemProps);
        var currTableIdPref = (propType == 2 ? "itemOper_" : "itemProp_");
        for(i = 1; i < currTable.rows.length; i++){
            if(currTableIdPref + curId == currTable.rows[i].getAttribute("id")){
                if(i > 1){
                    lastElem = isTop ? 2 : i;
                    for(j = i; j >= lastElem; j--){
                        crossSwapNodes(currTable.rows[j-1], currTable.rows[j]);
                    }
                    if(propType == 2){
                        updateFieldMapOper();
                    }else{
                        updateFieldMap();
                    }
                }
                break;
            }
        }
    }
}

function moveFldDown(curId, propType, isBottom){
    if(curId != ''){
        var currTable = (propType == 2 ? oItemOpers : oItemProps);
        var currTableIdPref = (propType == 2 ? "itemOper_" : "itemProp_");
        for(i = 1; i < currTable.rows.length; i++){
            if(currTableIdPref + curId == currTable.rows[i].getAttribute("id")){
                if(i < currTable.rows.length-1){
                    lastElem = isBottom ? currTable.rows.length-2 : i;
                    for(j = i; j <= lastElem; j++){
                        crossSwapNodes(currTable.rows[j], currTable.rows[j + 1]);
                    }
                    if(propType == 2){
                        updateFieldMapOper();
                    }else{
                        updateFieldMap();
                    }
                }
                break;
            }
        }
    }
}

function onAddNewRow(){
    var propData = [];
    for(i = 0; i < numProps; i++){
        var addProp = null;
        var addPropVal = null;
        eval('addProp = document.addprop.add_prop_'+propsNums[i]+';');
        eval('addPropVal = document.addprop.add_prop_val_'+propsNums[i]+';');
        if(propsTypes[i] == 'select'){
            if(addProp.options.selectedIndex >= 0){
                propData[i*2] = addProp.value;
                propData[i*2+1] = fromHTMLToText(addProp.options[addProp.options.selectedIndex].innerHTML);
            }else{
                propData[i*2] = "";
                propData[i*2+1] = "";
            }
        }else if(propsTypes[i] == 'hidden'){
            propData[i*2] = addPropVal.value;
            propData[i*2+1] = addProp.value;
        }else{
            propData[i*2] = addProp.value;
            propData[i*2+1] = propData[i*2];
        }
    }
    propData[i*2] = document.addprop.add_prop_rest.value;
    addPropRow(propData, true);
}

function onAddNewOperRow(){
    if(document.addoper.add_oper_price.value == "" && document.addoper.add_oper_weight.value == "" && document.addoper.add_oper_size.value == ""){
        alert('%%one_inf_field%%');
        return false;
    }
    var operData = Array()
    for(i = 0; i < numProps; i++){
        var addOper = null;
        var addOperVal = null;
        eval('addOper = document.addoper.add_oper_'+propsNums[i]+';');
        eval('addOperVal = document.addoper.add_oper_val_'+propsNums[i]+';');
        if(opersTypes[i] == 'select'){
            operData[i*2] = addOper.value;
            operData[i*2+1] = fromHTMLToText(addOper.options[addOper.options.selectedIndex].innerHTML);
        }else if(opersTypes[i] == 'hidden'){
            operData[i*2] = addOperVal.value;
            operData[i*2+1] = addOper.value;
        }else{
            operData[i*2] = addOper.value;
            operData[i*2+1] = operData[i*2];
        }
    }
    operData[i*2] = document.addoper.add_oper_price.value;
    operData[i*2+1] = document.addoper.add_oper_weight.value;
    operData[i*2+2] = document.addoper.add_oper_size.value;
    operData[i*2+3] = document.addoper.add_oper_stop.checked;
    addOperRow(operData);
}

function setCheckFld(fieldNum, flagNum, isChecked, propType){
    if(isChecked)
        res = flagMapAdd(fieldNum, flagNum, propType);
    else
        res = flagMapDrop(fieldNum, flagNum, propType);
    if(res != -1){
        // Create hexadecimal flag value
        if(propType == 2)
            eval('document.addoper.add_oper_val_'+fieldNum+'.value = "'+arrToHex(res)+'";');
        else
            eval('document.addprop.add_prop_val_'+fieldNum+'.value = "'+arrToHex(res)+'";');
        // Create visible name
        fmName = "";
        for(i = 0; i < res.length; i++){
            if(res[i] && res[i] == '1' && flagCaptions[fieldNum][i+1]){
                fmName += (fmName == '' ? '' : '<br>')+flagCaptions[fieldNum][i+1];
            }
        }
        if(propType == 2)
            eval('document.addoper.add_oper_'+fieldNum+'.value = "'+fmName+'";');
        else
            eval('document.addprop.add_prop_'+fieldNum+'.value = "'+fmName+'";');
    }
}

function flagMapAdd(name, num, propType){
    name = propType+"_"+name;
    if(!isNaN(num)){
        mapID = -1;
        for(i = 0; i < flagNames.length; i++){
            if(flagNames[i] == name){
                mapID = i;
                break;
            }
        }
        if(mapID == -1){
            mapID = flagNames.length;
            flagNames[mapID] = name;
            flagMaps[mapID] = new Array();
        }
        if(flagMaps[mapID].length < num){
            for(i = 0; i < num; i++)
                if(!flagMaps[mapID][i])
                    flagMaps[mapID][i] = 0;
        }
        flagMaps[mapID][num-1] = 1;
        return flagMaps[mapID];
    }
    return -1;
}

function flagMapDrop(name, num, propType){
    name = propType+"_"+name;
    if(!isNaN(num)){
        mapID = -1;
        for(i = 0; i < flagNames.length; i++){
            if(flagNames[i] == name){
                mapID = i;
                break;
            }
        }
        if(mapID >= 0){
            flagMaps[mapID][num-1] = 0;
            return flagMaps[mapID];
        }
    }
    return -1;
}

function arrToHex(arrIn){
    realValTmp = "";
    realVal = "";
    var tmp = "";
    var isLastProcessed = true;
    for(k = 1; k <= arrIn.length; k++){
        isLastProcessed = false;
        tmp = arrIn[k-1]+tmp;
        if(k % 4 == 0){
            realValTmp += parseInt(tmp, 2).toString(16);
            tmp = "";
            isLastProcessed = true;
        }
    }
    if(!isLastProcessed)
        realValTmp += parseInt(tmp, 2).toString(16);
    hexZeroStart = true;
    for(k = realValTmp.length-1; k >= 0; k--){
        if(realValTmp.substr(k, 1) != "0" || !hexZeroStart){
            realVal += realValTmp.substr(k, 1);
            hexZeroStart = false;
        }
    }
    return realVal;
}

function updateFieldMap(){
    document.addprop.fields_map.value = '';
    for(i = 1; i < oItemProps.rows.length-1; i++){
        document.addprop.fields_map.value += (document.addprop.fields_map.value == '' ? '' : ';')+oItemProps.rows[i].getAttribute('clearid');
    }
}

function updateFieldMapOper(){
    document.addoper.fields_map_oper.value = '';
    for(i = 1; i < oItemOpers.rows.length-1; i++){
        document.addoper.fields_map_oper.value += (document.addoper.fields_map_oper.value == '' ? '' : ';')+oItemOpers.rows[i].getAttribute('clearid');
    }
}

var isPropsShown = 1;
var isOpersShown = 1;
function showItemProps(isShow){
    if(isPropsShown && isShow == 2 || isShow == 0){
        isPropsShown = 0;
        document.getElementById('itemPropsForm').style.display='none';
        document.getElementById('showhideProps').value = '%%show_item_table%%';
    }
    else if(!isPropsShown && isShow == 2 || isShow == 1){
        isPropsShown = 1;
        document.getElementById('itemPropsForm').style.display='block';
        document.getElementById('showhideProps').value = '%%hide_item_table%%';
    }
    document.addoper.isPropsShown.value=isPropsShown;
    document.addprop.isPropsShown.value=isPropsShown;
}
function showItemOpers(isShow){
    if(isOpersShown && isShow == 2 || isShow == 0){
        isOpersShown = 0;
        document.getElementById('itemOpersForm').style.display='none';
        document.getElementById('showhideOpers').value = '%%show_item_table%%';
    }
    else if(!isOpersShown && isShow == 2 || isShow == 1){
        isOpersShown = 1;
        document.getElementById('itemOpersForm').style.display='block';
        document.getElementById('showhideOpers').value = '%%hide_item_table%%';
    }
    document.addoper.isOpersShown.value=isOpersShown;
    document.addprop.isOpersShown.value=isOpersShown;
}

function setNumOfRows(isProp, inc){
    if(isProp){
        numOfProps += inc;
        document.getElementById('total_props').innerHTML = numOfProps;
    }else{
        numOfOps += inc;
        document.getElementById('total_opers').innerHTML = numOfOps;
    }
}

function checkOperForm(obj){
    for(i = 1; i < oItemOpers.rows.length; i++){
        rowId = oItemOpers.rows[i].getAttribute("clearid");
        if(rowId != null && rowId != undefined){
            curPrice = ""; eval('curPrice = document.addoper.price_oper_'+rowId+'.value;');
            curWeight = ""; eval('curWeight = document.addoper.weight_oper_'+rowId+'.value;');
            curSize = ""; eval('curSize = document.addoper.size_oper_'+rowId+'.value;');
            if(curPrice == "" && curWeight == "" && curSize == ""){
                alert('%%one_inf_field_form%%');
                return false;
            }
        }
    }

    return (wasPropsChanged ? confirm('%%props_changed%%') : true);
}

</SCRIPT>
</HEAD>

<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">

<table cellspacing="0" cellpadding="10" align="center" width=100% id="popup_content">
  <tr>
    <td>
    <div>##status##</div>
    <br>
    <nobr>
    <BUTTON class="but" ID=btnOK onClick="applyForm();" tabIndex=50>&nbsp;&nbsp;&nbsp;%%close_btn%%&nbsp;&nbsp;&nbsp;</BUTTON>
    </nobr>
    <br>
    <br>
    <h3>%%opers_list%% &nbsp;(%%opers_total%%: <div style="display: inline" id="total_opers">0</div>) <input type=button value='%%hide_item_table%%' onClick="showItemOpers(2)" class="but" id="showhideOpers"></h3><br>
    ##opers_list##
    </td>
   </tr>
   <tr>
    <td>
    <br>
    <h3>%%props_list%% &nbsp;(%%props_total%%: <div style="display: inline" id="total_props">0</div>)  <input type=button value='%%hide_item_table%%' onClick="showItemProps(2)" class="but" id="showhideProps"></h3><br>
    ##props_list##
    <br>
    </td>
  </tr>
   <tr>
    <td align="center">
    <script type="text/javascript">
    <!--
    var _cms_document_form = 'referenceform';
    var _cms_script_link = '##script_link##?';
    -->
    </script>
    <form action=##script_link## method=post name="referenceform" onSubmit="return CheckForm(window.document.referenceform);">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
     ##filter_hidden_fields##
    </form>
    </td>
   </tr>
</table>
<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'referenceform';
var _cms_script_link = '##script_link##?';

function OnObjectChanged_eshop_item_props_def(name, first_change, evt){
  return true;
}
addFormChangedHandler(OnObjectChanged_eshop_item_props_def);

-->
</script>

  <form action="##script_link##" method=post name="pagersform">
  ##filter_hidden_fields##
  <input type="hidden" name="itemd" value="##item_id##">
  <input type="hidden" name="id" value="##id##">
  <input type="hidden" name="action" value="##action##">
  <input type="hidden" name="rest_total" value="##rest_total##">
  </form>

<script type="text/javascript">

 oItemProps = document.getElementById('itemProps');
 oItemOpers = document.getElementById('itemOpers');

 Init();
 InitForm();
 ##add_props##
 ##add_opers##
 showItemProps(##isPropsShown##);
 showItemOpers(##isOpersShown##);
 wasOpersChanged = 0;
 wasPropsChanged = 0;
</script>

</body>
</html>
