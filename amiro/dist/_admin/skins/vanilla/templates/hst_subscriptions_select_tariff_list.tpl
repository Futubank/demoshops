##--!ver=0200 rules="-SETVAR"--##
%%include_template "templates/_icons.tpl"%%
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
  <td><nobr>##name##&nbsp;</nobr></td>
  <td><nobr>##periods##&nbsp;</nobr></td>
  <td><nobr>##comments##&nbsp;</nobr></td>
  <td align="center"><nobr>##if(can_select)####action_select####endif##&nbsp;</nobr></td>
</tr>
"-->

<!--#set var="list_body" value="
<script type="text/javascript">
<!--

function selectItemFromPopup(form, id) {
    var oTmpField;
    var oPeriodSelect = document.getElementById('period_select_' + id);
    var oAddedPkgs = top.opener.document.getElementById("added_packages");

    oTmpField = top.opener.document.getElementById('id_new_tariff');
    if(oTmpField) {
        if (oTmpField.value != id) {
            oTmpField.fireEvent('onChange');
        }
        oTmpField.value = id;
    }

    oTmpField = top.opener.document.getElementById('id_new_tariff_period');
    if(oTmpField && oPeriodSelect) {
        if (oTmpField.value != oPeriodSelect.value) {
            oTmpField.fireEvent('onChange');
        }
        oTmpField.value = oPeriodSelect.value;
    }

    // clear list of added packages
    if(oAddedPkgs) {
        oAddedPkgs.value = '';
    }

    // do recalculate with new triff
    top.opener.document.forms[top.opener._cms_document_form].elements["action"].value = 'recalc';
    top.opener.document.forms[top.opener._cms_document_form].elements["action_original"].value = 'edit';
    top.opener.document.forms[top.opener._cms_document_form].submit();

    window.close();
}

-->
</script>

##list_hint##

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
<form action="javascript:ApplyItems();" enctype="multipart/form-data" name="subscriptionPopupForm">
<table id="pkg_table" width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td class="first_row_all list_name_col" width="200">
     ##sort_t.name##
     %%name%%
    </td>
    <td class="first_row_all" width="80">
     %%period%%, %%mon%%
    </td>
    <td class="first_row_all" width="*">
     ##sort_t.comments##
     %%comments%%
    </td>
    <td class="first_row_all" width="60">
     %%actions%%
    </td>
  </tr>
  ##list##
</table>
</form>

##button_add##
<div align="right" width="100%">##pager##</div>
<br><br>
<div align="center">
  <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="javascript:top.close();">
</div>
<a name="anchor"></a>

"-->
