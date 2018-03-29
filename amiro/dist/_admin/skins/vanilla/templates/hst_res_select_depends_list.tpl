##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_res.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="hint" value="
##if(!IS_USER)##
<div id="list_hint_link" style="text-align: right; font-size: 7pt; width: 100%;">
<a href="modules_templates_langs.php?id=##id##&action=edit&flt_tpl_name=##name##" target="hint_wnd">##if(list_hint != '')##%%hint_edit%%##else##%%hint_add%%##endif##</a>
</div>
##endif##
##if(list_hint != '')##
<div id="list_hint" style="font-size: 7pt; background-color: #FFFFE1; border: 1px #666666 solid; padding: 5px; width: 100%;">##list_hint##</div>
##endif##
"-->

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##')">
  <td align="center"><nobr><input type=checkbox name='grp_select_##id##' id='grp_select_##id##' onChange="javascript:onCheckboxChange(##id##);"><nobr></td>
  <td><nobr>##name##&nbsp;<nobr></td>
  <td><nobr>##type##&nbsp;<nobr></td>
  <td align="right"><nobr>##pkg_res##&nbsp;<nobr></td>
</tr>
"-->
</tr>
"-->

<!--#set var="list_body" value="

<script type="text/javascript">
<!--
function OnObjectChanged_res_depend_list_form(name, first_change){
    var id=0;
    if(name.length > 11) {
        if(name.substring(0, 11) == "grp_select_ ") {
            id = name.substring(11);
            onCheckboxChange(id);
        }
    }
  return true;
}
addFormChangedHandler(OnObjectChanged_res_depend_list_form);

function onCheckboxChange(id) {
    var oCheckbox = document.getElementById('grp_select_' + id);
    var oResBank = window.hst_res_depend_form.added_res_dep;
    var aSrcResources = Array();
    var aDestResources = Array();

    if(oCheckbox && oResBank) {
        if(oCheckbox.checked) {
            // add id to bank
            if(oResBank.value.length) {
                oResBank.value += ";";
            }
            oResBank.value += id;
        } else {
            // deleting id from bank
            aSrcResources = oResBank.value.split(';');
            for(var i = 0; i < aSrcResources.length; i++) {
                if(aSrcResources[i]*1 != id*1) {
                    aDestResources[aDestResources.length] = aSrcResources[i];
                }
            }
            // store new packages list to form
            if(aDestResources.length) {
                oResBank.value = aDestResources.join(';');
            } else {
                oResBank.value = '';
            }
        }
        // make encoded variant
        window.hst_res_depend_form.enc_added_res_dep.value = encodeURIComponent(oResBank.value);
    }
}

function SetResourcesBankToParent() {
    var destName = window.hst_res_depend_form.dest_field_id.value;
    var oDest = top.opener.document.getElementById(destName);
    if(oDest) {
        oDest.value = window.hst_res_depend_form.added_res_dep.value;
    }
    top.close();
}

function SetCheckboxesByResBank() {
    var oCheckbox;
    var oResBank = window.hst_res_depend_form.added_res_dep;
    var aDepResources = Array();

    if(oResBank) {
        if(oResBank.value.length) {
            aDepResources = oResBank.value.split(';');
            for(var i = 0; i < aDepResources.length; i++) {
                oCheckbox = document.getElementById('grp_select_' + aDepResources[i]);
                if(oCheckbox) {
                    oCheckbox.checked = true;
                }
            }
        }
    }
}

-->
</script>

##list_hint##

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
<form action="javascript:SetResourcesBankToParent();" enctype="multipart/form-data" name="res_depend_list_form">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td class="first_row_all" width="40">
        %%select%%
    </td>
    <td class="first_row_all list_name_col">
        %%name%%
    </td>
    <td class="first_row_all">
        %%type%%
    </td>
    <td class="first_row_all" width="120">
        %%pkg_res%%
    </td>
  </tr>
  ##list##
</table>
</form>

##button_add##
<div align="right" width="100%">##pager##</div>
<br><br>
<div align="center">
  <input type="button" name="add" value="  %%select%%  " class="but" OnClick="javascript:SetResourcesBankToParent();">&nbsp;&nbsp;&nbsp;
  <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="javascript:top.close();">
</div>
<a name="anchor"></a>

"-->
