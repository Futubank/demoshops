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
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##')">
  ##_group_operations_col##
  <td align="right"><nobr>##id##<nobr></td>
  <td><nobr>##date_start##&nbsp;<nobr></td>
  <td><nobr>##date_end##&nbsp;<nobr></td>
##if(IS_USER!="1")##
  <td><nobr>##clientname##&nbsp;<nobr></td>
##endif##
  <td><nobr>##tariff##&nbsp;<nobr></td>
  <td align="right"><nobr>##period##&nbsp;<nobr></td>
  <td><nobr>##os_user##&nbsp;<nobr></td>
  <td align=center><input type=hidden id='sub_name_##id##' value='%%number%%##id##. ##username##, ##firstname## ##lastname## (##tariff##)'>##action_select##</td>
</tr>
"-->

<!--#set var="list_body" value="
<script>

function selectItemFromPopup(form, id) {
    var oTmpField;
    var subsName = 'noname';
    if(destFieldIdId.length) {
        oTmpField = top.opener.document.getElementById(destFieldIdId);
        if(oTmpField) {
            if (oTmpField.value != id) {
                oTmpField.fireEvent('onChange');
            }
            oTmpField.value = id;
        }
    }
    
    if(document.getElementById('sub_name_' + id)) {
        subsName = document.getElementById('sub_name_' + id).value;
    }
    if(destFieldIdName.length) {
        oTmpField = top.opener.document.getElementById(destFieldIdName);
        if(oTmpField) {
            oTmpField.value = subsName;
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
                <td class="first_row_all" width="40">
                 %%number%%
                 ##sort_id##
                </td>
                <td class="first_row_all">
                 %%date_start%%
                 ##sort_date_start##
                </td>
                <td class="first_row_all">
                 %%date_end%%
                 ##sort_date_end##
                </td>
##if(IS_USER!="1")##
                <td class="first_row_all">
                 %%clientname%%
                 ##sort_m.lastname,m.firstname##
                </td>
##endif##
                <td class="first_row_all">
                 ##sort_t.name##
                 %%tariff%%
                </td>
                <td class="first_row_all">
                 %%period_mon%%
                </td>
                <td class="first_row_all">
                 %%os_user%%
                </td>
                <td class="first_row_all" align="center">
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