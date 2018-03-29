##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_subscriptions.lng"%%

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
<tr id="group_row_##id##" class="##style##" ##--onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)"--##>
  <td><nobr>##pkg_name##&nbsp;<nobr></td>
  <td align="right"><nobr>##setup_fee##&nbsp;<nobr></td>
  <td align="right"><nobr>##price##&nbsp;<nobr></td>
  <td align="center"><nobr>
    <input class="##if(style == 'row1')##rdo_btn1##else##rdo_btn2##endif## field12" name="cnt_##id##" id="cnt_##id##" value="##cnt##"  readonly>&nbsp;<nobr>
  </td>
  <td align="center"><nobr>
##if(public == "1")##
##if(included == "0")##
    <input class="field field12" name="buy_##id##" id="buy_##id##" value="##buy_count##" onChange="javascript:onBuyChange(##id##)" >&nbsp;<nobr>
##else##
  %%included%%
##endif##
##endif##
  </td>
  <td align="center"><nobr>
    <input class="##if(style == 'row1')##rdo_btn1##else##rdo_btn2##endif## field12" name="total_##id##" id="total_##id##" value=""  readonly>&nbsp;<nobr>
  </td>
</tr>
"-->

<!--#set var="list_body" value="
<style type="text/css">
.rdo_btn1 {
    border: 0px;
    background-color: #ffffff;
}
.rdo_btn2 {
    border: 0px;
    background-color : #F5F5F5;
}
</style>
<script type="text/javascript">
<!--

function onBuyChange(id) {
    UpdateTotalCount(id);
    UpdateFltPackagesBank(id);
    ButtonAddActivation();
}

function UpdateTotalCount() {
	var id = "";
    var oPkgCnt;
    var oPkgBuy;
    var oPkgTotal;
    if(UpdateTotalCount.arguments.length == 1) {
        // update one total count
        id = UpdateTotalCount.arguments[0];
        oPkgCnt = document.getElementById("cnt_" + id);
        oPkgBuy = document.getElementById("buy_" + id);
        oPkgTotal = document.getElementById("total_" + id);
        if(oPkgCnt && oPkgBuy && oPkgTotal) {
            oPkgTotal.value = oPkgCnt.value/1 + oPkgBuy.value/1;
        }
    } else {
        // update all total counts
        var oTable = document.getElementById('pkg_table');
        if(oTable) {
            for(i = 1; i < oTable.rows.length; i++) {
                id = oTable.rows[i].id.slice(10)/1;
                UpdateTotalCount(id);
            }
        }
    }
}

function isPackagesBankChanged() {
    //alert('Setting packages bank to parent');
    var oDest = top.opener.document.getElementById('added_packages');
    if(oDest) {
        if(oDest.value != document.forms[_cms_document_form].elements["flt_packages_bank"].value) {
            return 1;
        }
    } else {
        alert('Error link with parent window!');
    }
    return 0;
}

function ButtonAddActivation(){
    var btn = document.getElementById('add_btn');
    if(btn){
        if(isPackagesBankChanged()) {
            // enable button
            //alert('enable button');
            btn.disabled = 0;
        } else {
            // disable button
            //alert('disable button');
            btn.disabled = 1;
        }
    }
}

function SetPackagesBankToParent() {
    //alert('Setting packages bank to parent');
    var oDest = top.opener.document.getElementById('added_packages');
    var oTariffSelect = top.opener.document.getElementById('tariff');
    if(oDest) {
        oDest.value = document.forms[_cms_document_form].elements["flt_packages_bank"].value;
        //alert(oDest.value);
        //return false;
        top.opener.document.forms[top.opener._cms_document_form].elements["action"].value = 'recalc';
        top.opener.document.forms[top.opener._cms_document_form].elements["action_original"].value = 'edit';
        top.opener.document.forms[top.opener._cms_document_form].submit();
    }
    top.close();
}

function FillRowsFromPackagesBank() {
    var oFltPkgBank = document.hst_subscriptions_popup_form.flt_packages_bank;
    var aPackages = Array();
    var aTmpPkg = Array();
    var oTmpInput;

    if(oFltPkgBank.value.length) {
        aPackages = oFltPkgBank.value.split(';');
        for(var i = 0; i < aPackages.length; i++) {
            aTmpPkg = aPackages[i].split('=');
            oTmpInput = document.getElementById('buy_' + aTmpPkg[0]);
            if(oTmpInput) {
                oTmpInput.value = aTmpPkg[1];
            }
        }
    }
}

function UpdateFltPackagesBank(id_pkg) {
    var oFltPkgBank = document.hst_subscriptions_popup_form.flt_packages_bank;
    var oBuyCountField = document.getElementById('buy_' + id_pkg);
    var aSrcPackages = Array();
    var aDestPackages = Array();
    var aTmpPkg = Array();

    if(oFltPkgBank.value.length) {
        aSrcPackages = oFltPkgBank.value.split(';');
        // kick old value of this packages count
        for(var i = 0; i < aSrcPackages.length; i++) {
            aTmpPkg = aSrcPackages[i].split('=');
            if(aTmpPkg[0] != id_pkg) {
                aDestPackages[aDestPackages.length] = aSrcPackages[i];
            }
        }
    }
    // add new value of this packages count if it is not empty
    if(oBuyCountField.value.length) {
        aDestPackages[aDestPackages.length] = '' + id_pkg + '=' + oBuyCountField.value;
    }
    // store new packages list to form
    if(aDestPackages.length) {
        oFltPkgBank.value = aDestPackages.join(';');
    } else {
        oFltPkgBank.value = '';
    }
    // make encoded variant
    document.hst_subscriptions_popup_form.enc_flt_packages_bank.value = encodeURIComponent(oFltPkgBank.value);
}

-->
</script>

##list_hint##

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
<form action="javascript:ApplyItems();" enctype="multipart/form-data" name="subscriptionPopupForm">
<table id="pkg_table" width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td class="first_row_all" width="*">
     ##sort_p.name##
     %%pkg_name%%
    </td>
    <td class="first_row_all" width="100">
     ##sort_p.setup_fee##
     %%setup_fee%%##if(currency_postfix)##, ##currency_postfix####endif##
    </td>
    <td class="first_row_all" width="100">
     ##sort_tp.price##
     %%price%%##if(currency_postfix)##, ##currency_postfix##/##endif##%%mon%%
    </td>
    <td class="first_row_all" width="120">
     %%buyed_count%%
    </td>
    <td class="first_row_all" width="100">
     %%buy_count%%
    </td>
    <td class="first_row_all" width="100">
     %%total_packages%%
    </td>
  </tr>
  ##list##
</table>
</form>

##button_add##
<div align="right" width="100%">##pager##</div>
<br><br>
<div align="center">
  <input type="button" name="add" id="add_btn" value="  %%do_add_packages%%  " class="but" OnClick="javascript:SetPackagesBankToParent();" disabled>&nbsp;&nbsp;&nbsp;
  <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="javascript:top.close();">
</div>
<a name="anchor"></a>

"-->
