##--!ver=0200 rules="-SETVAR"--##
%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/hst_res_inst.lng"%%
%%include_language "templates/lang/hst_res_vhost_inst.lng"%%

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
  ##_group_operations_col##
  <td align="right"><nobr>##id_subscription##&nbsp;<nobr></td>
  <td><nobr>##domain##&nbsp;<nobr></td>
  <td><nobr>##username##&nbsp;<nobr></td>
  <td><nobr>##clientname##&nbsp;<nobr></td>
  <td><nobr>##tariff##&nbsp;<nobr></td>
  <td align=center><input type=hidden id='vhost_name_##id##' value='##domain####if(ONLY_NAME == 0)##. ##username##, ##firstname## ##lastname## (##tariff##)##endif##'>##action_select##</td>
</tr>
"-->

<!--#set var="list_body" value="
<script>

function selectItemFromPopup(form, id) {
    var oTmpField;
    var vhostName = '';
    if(destFieldIdId.length) {
        oTmpField = top.opener.document.getElementById(destFieldIdId);
        if(oTmpField) {
            if (oTmpField.value != id) {
                oTmpField.fireEvent('onChange');
            }
            oTmpField.value = id;
        }
    }

    if(document.getElementById('vhost_name_' + id)) {
        vhostName = document.getElementById('vhost_name_' + id).value;
    }
    if(destFieldIdName.length) {
        oTmpField = top.opener.document.getElementById(destFieldIdName);
        if(oTmpField) {
            oTmpField.value = vhostName;
        }
    }
    window.close();
}

</script>

##list_hint##

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_all" width="60">
                 %%subscription%%
                 ##sort_v.id_subscription##
                </td>
                <td class="first_row_all list_name_col">
                 %%name%%
                 ##sort_v.domain##
                </td>
                <td class="first_row_all">
                 %%login%%
                 ##sort_m.username##
                </td>
                <td class="first_row_all">
                 %%client_name%%
                 ##sort_m.lastname,m.firstname##
                </td>
                <td class="first_row_all">
                 %%tariff%%
                 ##sort_t.name##
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
##_group_operations_footer##
</form>

<div align="center">
  <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="javascript:top.close();">
</div>
<a name="anchor"></a>
"-->