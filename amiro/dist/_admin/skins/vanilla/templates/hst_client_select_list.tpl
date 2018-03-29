##--!ver=0200 rules="-SETVAR"--##
%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/hst_clients.lng"%%

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

<!--#set var="username_login" value="
<nobr>##username##</nobr>
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
  <td>##reseller_name##&nbsp;</td>
  <td>##username##</td>
  <td>##client_name##&nbsp;</td>
##if(ESHOP_ACCOUNT=="1")##
  <td align="right"><nobr>##balance##</nobr></td>
##endif##
  <td>##email##</td>
  <td align="center" nowrap><input type=hidden id='clnt_name_##id##' value='%%number_symb%%##id##, ##username_simple##, ##client_name##'>##action_select##</td>
</tr>
"-->

<!--#set var="list_body" value="
<script type="text/javascript">
<!--
function selectItemFromPopup(form, id) {
    var oTmpField;
    var retName = 'none';
    if(destFieldIdId.length) {
        oTmpField = top.opener.document.getElementById(destFieldIdId);
        if(oTmpField) {
            if (oTmpField.value != id) {
                oTmpField.fireEvent('onChange');
            }
            oTmpField.value = id;
        }
    }

    if(document.getElementById('clnt_name_' + id)) {
        retName = document.getElementById('clnt_name_' + id).value;
    }
    if(destFieldIdName.length) {
        oTmpField = top.opener.document.getElementById(destFieldIdName);
        if(oTmpField) {
            oTmpField.value = retName;
        }
    }
    window.close();
}

-->
</script>

##list_hint##
           
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_all" valign="middle" width="150">
                 %%reseller%%
                 ##sort_reseller_name##
                </td>
                <td class="first_row_all" valign="middle" width="150">
                 %%username%%
                 ##sort_username##
                </td>
                <td class="first_row_all" width="150">
                 %%client_name%%
                  ##sort_lastname,firstname##
                </td>
##if(ESHOP_ACCOUNT=="1")##
                <td class="first_row_all" width="80">
                 %%balance%%
                  ##sort_balance##
                </td>
##endif##
                <td class="first_row_all">
                 %%email%%
                  ##sort_email##
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
             </table>
            </form>
        <a name="anchor"></a>
"-->
