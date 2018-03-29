##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_tariff.lng"%%

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

<!--#set var="cant_change_tariff_hint" value="
<div id="form_hint" style="font-size: 7pt; background-color: #FFFFE1; border: 1px #666666 solid; padding: 5px; width: 100%;">%%hint_subs_exist_cant_change_tariff%%</div>
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'hst_tariff_form';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
var periodMaxRowId = 0;
var periodRowOffset = 1;

var packageRowOffset = 1;

##pictures_js_vars##

function OnObjectChanged_hst_tariff_form(name, first_change){
    var idPkg=0;
    if(name.length > 13) {
        if(name.substring(0, 13) == "pkg_included_") {
            idPkg = name.substring(13);
            togglePriceField(idPkg);
        }
    }

  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_hst_tariff_form);

function CheckForm(form) {
    var errmsg = "";
    var isPeriodsEmpty = true;
    var aPeriodsOrder;
    var focusDest = '';

    if (form.name.value=="") {
        return focusedAlert(form.name, '%%name_warn%%');
    }

    if (form.setup_fee.value=="") {
        return focusedAlert(form.setup_fee, '%%setup_fee_warn%%');
    }

    if (packages.rows.length <= packageRowOffset) {
        errmsg+='%%none_pkg_warn%%';
        alert(errmsg);
        return false;
    }

    if(document.getElementById('periodsOrder').value != "") {
        aPeriodsOrder = document.getElementById('periodsOrder').value.split(';');
        for(i = 0; i < aPeriodsOrder.length; i++) {
            if(document.getElementById('period_len_' + aPeriodsOrder[i]).value.length &&
               document.getElementById('period_fee_' + aPeriodsOrder[i]).value.length) {
                isPeriodsEmpty = false;
                break;
            }
        }
    }
    if (isPeriodsEmpty) {
        focusDest = document.getElementById('period_len_' + aPeriodsOrder[0]);
        if(focusDest.value.length) {
            focusDest = document.getElementById('period_fee_' + aPeriodsOrder[0]);
        }
        return focusedAlert(focusDest, '%%period_warn%%');
    }

    // check resources
    if(##resources_count##) {
        var aResId = new Array(##res_id_list##);
        var i;
        var oTmpField;

        for(i = 0; i < ##resources_count##; i++) {
            oTmpField = document.getElementById("res_bound_" + aResId[i]);
            if(isNegative(oTmpField)) {
                return focusedAlert(oTmpField, '%%res_bound_is_negative_warn%%');
            }
            oTmpField = document.getElementById("res_overbound_price_" + aResId[i]);
            if(isNegative(oTmpField)) {
                return focusedAlert(oTmpField, '%%res_overbound_price_is_negative_warn%%');
            }
            oTmpField = document.getElementById("res_overbound_step_" + aResId[i]);
            if(isNegative(oTmpField)) {
                return focusedAlert(oTmpField, '%%res_overbound_step_is_negative_warn%%');
            }
        }
    }

    return true;
}

function isNegative(obj) {
    var res = false;
    var val;
    if(obj) {
        val = obj.value*1;
        if(val < 0) {
            res = true;
        }
    }
    return res;
}

function insertPeriodRow() {
    var fieldId, oRow, oCelll;
    periodMaxRowId++;
    fieldId = periodMaxRowId;
    oRow = periods.insertRow();
    oRow.setAttribute("id", "periods_"+fieldId);
    oRow.setAttribute("clearid", fieldId);

    oCell = oRow.insertCell();
    oCell.innerHTML = '<input type=text class="field field12" name=period_len_' + fieldId + ' id=period_len_' + fieldId + ' value="">';
    oCell.setAttribute("className", "row1");

    oCell = oRow.insertCell();
    oCell.innerHTML = '<input type=text class="field field12" name=period_fee_' + fieldId + ' id=period_fee_' + fieldId + ' value="">';
    oCell.setAttribute("align", "center");
    oCell.setAttribute("className", "row1");

    oCell = oRow.insertCell();
    oCell.innerHTML = '<a id="delField_' + fieldId + '" href="javascript:void('+fieldId+')" onClick="deletePeriodFld(\''+fieldId+'\');return false;"><img src="skins/vanilla/icons/icon-del.gif" title="%%delete%%" border=0></a>';
    oCell.setAttribute("align", "center");
    oCell.setAttribute("className", "row1");
    updatePeriodsOrder();
}

function updatePeriodsOrder() {
    var oPeriodsOrder=document.getElementById('periodsOrder');
    oPeriodsOrder.value = '';
    periodMaxRowId = 0;
    for(i = periodRowOffset; i < periods.rows.length; i++) {
        oPeriodsOrder.value += (oPeriodsOrder.value == '' ? '' : ';')+periods.rows[i].getAttribute('clearid');
        if(periodMaxRowId < periods.rows[i].getAttribute('clearid')) {
            periodMaxRowId = periods.rows[i].getAttribute('clearid')*1;
        }
    }
    FormChanged();
}

function deletePeriodFld(curId){
    if(periods.rows.length  == periodRowOffset + 1)
    {
        alert("%%period_warn%%");
        return;
    }
    if (curId != '') {
        for(i = periodRowOffset; i < periods.rows.length; i++){
            if("periods_"+curId == periods.rows[i].getAttribute("id")){
                if(document.getElementById('period_fee_' + curId).value.length && !confirm('%%remove_period%%')) {
                    return;
                }
                periods.rows[i].removeNode(true);
                updatePeriodsOrder();
                break;
            }
        }
    }
}

function insertPackageRow() {
	var public_val = "";
	var included_val = "";
	var price_val = "";
	var price_disabled = "";
	var fieldId, oRow, oCelll;
    var oPkgBank = document.getElementById("packages_bank");
    if(insertPackageRow.arguments.length == 3) {
	    public_val = insertPackageRow.arguments[0];
        included_val = insertPackageRow.arguments[1];
        price_val = insertPackageRow.arguments[2];
        if(included_val.length) {
            price_disabled = 'disabled';
        }
    }
    if(oPkgBank.options.length > 0 && oPkgBank.value > 0) {
        fieldId = oPkgBank.value;
        oRow = packages.insertRow();
        oRow.setAttribute("id", "packages_"+fieldId);
        oRow.setAttribute("clearid", fieldId);

        oCell = oRow.insertCell();
        oCell.innerHTML = '<input type=hidden name=pkg_id_' + fieldId + ' id=pkg_id_' + fieldId + ' value="' + oPkgBank.options[oPkgBank.selectedIndex].value +'">'+
                          '<input type=hidden name=pkg_text_' + fieldId + ' id=pkg_text_' + fieldId + ' value="' + oPkgBank.options[oPkgBank.selectedIndex].text +'">'+
                          oPkgBank.options[oPkgBank.selectedIndex].text;
        oCell.setAttribute("className", "row1");

        oCell = oRow.insertCell();
        oCell.innerHTML = '<input type=checkbox name=pkg_public_' + fieldId + ' id=pkg_public_' + fieldId + ' value="1" ' + public_val +' checked##if(subs_count)## disabled##endif##>';
        oCell.setAttribute("align", "center");
        oCell.setAttribute("className", "row1");

        oCell = oRow.insertCell();
        oCell.innerHTML = '<input type=checkbox name=pkg_included_' + fieldId + ' id=pkg_included_' + fieldId + ' value="1" onClick="javascript:togglePriceField(' + fieldId + ');" ' + included_val +'##if(subs_count)## disabled##endif##>';
        oCell.setAttribute("align", "center");
        oCell.setAttribute("className", "row1");

        oCell = oRow.insertCell();
        oCell.innerHTML = '<input class="field field12" name=pkg_price_' + fieldId + ' id=pkg_price_' + fieldId + ' value="' + price_val +'" ' + price_disabled +'##if(subs_count)## readonly##endif##>';
        oCell.setAttribute("align", "center");
        oCell.setAttribute("className", "row1");

        oCell = oRow.insertCell();
        oCell.innerHTML = '<a id="delPkgRow_' + fieldId + '" href="javascript:void('+fieldId+')" onClick="javascript:##if(subs_count==0)##deletePackageRow(\''+fieldId+'\');##endif##return false;"><img src="skins/vanilla/icons/icon-del.gif" title="%%delete%%" border=0></a>';
        oCell.setAttribute("align", "center");
        oCell.setAttribute("className", "row1");

        dropCurrentPackageFromBank();
        updatePackagesOrder();
        $oHintRow = document.getElementById('hint_added_pkgs_div');
        if($oHintRow) {
            $oHintRow.style.display = 'block';
        }
    }
}

function insertPackageToBank(id, name) {
    var oPkgBank = document.getElementById("packages_bank");
    var oPkgBankRow = document.getElementById("pkg_bank_row");

    if(oPkgBank) {
        oPkgBank.options.length++;
        oPkgBank.options[oPkgBank.options.length - 1]=new Option(name, id, false, false);
    }
    if(oPkgBankRow) {
        oPkgBankRow.style.display = "block";
    }

}

function dropCurrentPackageFromBank() {
    var oPkgBank = document.getElementById("packages_bank");
    var oPkgBankRow = document.getElementById("pkg_bank_row");
    if(oPkgBank) {
        newVal = oPkgBank.options[0].value;
        if(oPkgBank.selectedIndex < oPkgBank.options.length) {
            // Drop not last item
            for(i = oPkgBank.selectedIndex; i < oPkgBank.options.length - 1; i++) {
                oPkgBank.options[i]=new Option(oPkgBank.options[i + 1].text, oPkgBank.options[i + 1].value, false, false);
            }
        }
        oPkgBank.options.length -= 1;
        if(oPkgBank.options.length) {
            oPkgBank.value = oPkgBank.options[0].value;
        } else {
            if(oPkgBankRow) {
                oPkgBankRow.style.display = "none";
            }
        }
    }
}

function deletePackageRow(curId){
    if (curId != '') {
        for(i = packageRowOffset; i < packages.rows.length; i++){
            if("packages_"+curId == packages.rows[i].getAttribute("id")){
                if(document.getElementById('pkg_price_' + curId).value.length && !confirm('%%remove_package%%')) {
                    return;
                }
                insertPackageToBank(document.getElementById('pkg_id_' + curId).value, document.getElementById('pkg_text_' + curId).value);
                packages.rows[i].removeNode(true);
                updatePackagesOrder();
                break;
            }
        }
    }
    if(packages.rows.length == packageRowOffset) {
        $oHintRow = document.getElementById('hint_added_pkgs_div');
        if($oHintRow) {
            $oHintRow.style.display = 'none';
        }
    }
}

function updatePackagesOrder() {
    var oPackagesOrder=document.getElementById('packagesOrder');
    oPackagesOrder.value = '';
    if(packages.rows.length > 1) {
        for(i = packageRowOffset; i < packages.rows.length; i++) {
            oPackagesOrder.value += (oPackagesOrder.value == '' ? '' : ';')+packages.rows[i].getAttribute('clearid');
        }
    }
    FormChanged();
}

function togglePriceField(id) {
    document.getElementById('pkg_price_' + id).disabled = document.getElementById('pkg_included_' + id).checked;
}

//-->
</script>

<!--#set var="option" value="<option value="##id##" ##selected##>##name##</option>
"-->

<!--#set var="period_line" value="
     <tr id="periods_##num##" clearid="##num##">
        <td class="row1">
          <input type=text class="field field12" name=period_len_##num## value="##period_len##"##if(subs_count)## readonly##endif##>
        </td>
        <td class="row1" align=center>
          <input type=text class="field field12" name=period_fee_##num## value="##period_fee##"##if(subs_count)## readonly##endif##>
        </td>
        <td class="row1" align=center>
          <a id="delPkgRow_##num##" href="javascript:void(##num##)"  onClick="##if(subs_count==0)##deletePeriodFld('##num##')##endif##;return false;"><img src="skins/vanilla/icons/icon-del.gif" title="%%delete%%" border=0></a>
        </td>
     </tr>
"-->

<!--#set var="res_row" value="
<tr>
  <td class="##class##">##name##&nbsp;##if (res_unit != '')## (##res_unit##)##endif##</td>
  <td class="##class##" align="center">##if(subtype != "on-off")##<input class="field" style="width: 100px;" name="res_bound_##id##" value="##bound##" maxlength="64"##if(subs_count)## readonly##endif##>##endif##&nbsp;</td>
  <td class="##class##" align="center">##if(subtype != "on-off")##<input class="field" style="width: 70px;" name="res_overbound_price_##id##" value="##overbound_price##" maxlength="64"##if(subs_count)## readonly##endif##>##endif##&nbsp;</td>
  <td class="##class##" align="center">##if(subtype != "on-off")##<input class="field" style="width: 70px;" name="res_overbound_step_##id##" value="##overbound_step##" maxlength="64"##if(subs_count)## readonly##endif##>##endif##&nbsp;</td>
</tr>"-->
<!--#set var="empty_res_row" value="
<tr><td class="row1" colspan=4>%%no_resources%%</td></tr>"-->


<style type='text/css'>
.yellow_hint {
    font-size: 7pt;
    background-color: #FFFFE1;
    border: 1px #666666 solid;
    padding: 5px;
    width: 100%;
}
</style>
  ##form_hint##
  ##no_change_hint##
  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="hst_tariff_form" onSubmit="return CheckForm(window.document.hst_tariff_form);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type=hidden name="arch" value="">
     <input type=hidden name="periodsOrder" id="periodsOrder" value="">
     <input type=hidden name="packagesOrder" id="packagesOrder" value="">
     <table cellspacing="5" cellpadding="0" border="0" width=100%>
     <tr>
       <td>
         %%archive%%:
       </td>
       <td>
         <input type=checkbox name=archive ##if(archive)## checked##endif##>
       </td>
     </tr>
     <tr>
       <td>
         %%name%%*:
       </td>
       <td>
         <input type=text name=name class="field field50" value="##name##" maxlength="255"##if(subs_count)## readonly##endif##>
       </td>
     </tr>
     <tr>
       <td>
         %%setup_fee%%*##if(currency_postfix)##, ##currency_postfix####endif##:
       </td>
       <td>
         <input type=text name=setup_fee class="field field50" value="##setup_fee##" maxlength="255"##if(subs_count)## readonly##endif##>
       </td>
     </tr>
     <tr>
       <td colspan=2><hr></td>
     </tr>
     <tr>
       <td style="vertical-align: top;">
         %%accessible_packages_in_tariff%%*:
       </td>
       <td>
         <table id="packages" border=0 cellspacing="0" cellpadding="4">
           <tr>
             <td class="first_row_left_td" width=200>%%name%%</td>
             <td class="first_row_all">%%public%%</td>
             <td class="first_row_all">%%included%%</td>
             <td class="first_row_all" width=80>%%price%%##if(currency_postfix)##, ##currency_postfix####endif##</td>
             <td class="first_row_all">%%actions%%</td>
           </tr>
         </table>
       </td>
     </tr>
     <tr id="hint_added_pkgs_div" style='display: none;'><td></td><td><div class='yellow_hint'>%%hint_added_pkgs%%</div>&nbsp;</td></tr>
     <tr id="pkg_bank_row">
       <td colspan=2 align="right">
         <br>
         <select name="packages_bank" id="packages_bank" class="field">
         ##packages_bank_options##
         </select>
         <input type=button value="%%button_add_package%%" class="but" onClick="insertPackageRow()"##if(subs_count)## disabled##endif##>
         <br><br>
       </td>
     </tr>

     <tr>
       <td colspan=2><hr></td>
     </tr>

     <tr>
       <td style="vertical-align: top;">
         %%period%%*:
       </td>
       <td>
         <table id="periods" border=0 cellspacing="0" cellpadding="4">
           <tr>
             <td class="first_row_left_td">%%period_mon%%</td>
             <td class="first_row_all">%%period_fee%%##if(currency_postfix)##, ##currency_postfix####endif##</td>
             <td class="first_row_all">%%actions%%</td>
           </tr>
           ##periods_rows##
         </table>
       </td>
     </tr>
     <tr>
       <td></td>
       <td align="center">
         <br>
           <input type=button value="%%button_add_period%%" class="but" onClick="insertPeriodRow()"##if(subs_count)## disabled##endif##>
         <br><br>
       </td>
     </tr>

     <tr>
       <td colspan=2><hr></td>
     </tr>

    <tr>
      <td valign=top>
         %%resources%%:
      </td>
      <td>
         <table id="resources" border=0 cellspacing="0" cellpadding="4" width="100%">
           <tr>
             <td class="first_row_left_td">%%name%%</td>
             <td class="first_row_all" width=100>%%bound%%</td>
             <td class="first_row_all" width=90>%%overbound_price%%</td>
             <td class="first_row_all" width=90>%%overbound_step%%</td>
           </tr>
           ##res_rows##
         </table>
       </td>
     </tr>

     <tr>
       <td colspan=2><hr></td>
     </tr>

     <tr>
       <td style="vertical-align: top;">
         %%comments%%:
       </td>
       <td>
         <textarea class="field" style="width:100%" rows="14" name="comments"##if(subs_count)## readonly##endif##>##comments##</textarea>
       </td>
     </tr>
     <tr>
       <td style="vertical-align: top;">
         %%hidden_comments%%:
       </td>
       <td>
         <textarea class="field" style="width:100%" rows="14" name="hidden_comments"##if(subs_count)## readonly##endif##>##hidden_comments##</textarea>
       </td>
     </tr>
     <tr>
       <td style="vertical-align: top;">
         %%tariff_link%%:
       </td>
       <td>
         <input name="tariff_link" class="field"  style="width:100%" value="##tariff_link##" maxlength="255"##if(subs_count)## readonly##endif##>
       </td>
     </tr>

     <tr>
       <td colspan=2><hr></td>
     </tr>

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
<!--
updatePeriodsOrder();
updatePackagesOrder();
##add_packages_rows##

-->
</script>