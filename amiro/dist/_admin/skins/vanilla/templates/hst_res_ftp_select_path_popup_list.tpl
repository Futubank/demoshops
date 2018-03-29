##--!ver=0200 rules="-SETVAR"--##
%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/hst_res_ftp_inst.lng"%%

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
  <td class=row1 align=center><h3>%%no_folders%%</h3></td>
</tr>
</table>
<br><br>
<div align="center">
  <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="javascript:top.close();">
</div>
"-->

<!--#set var="row" value="
<tr class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##')">
  <td><nobr><tnput type="hidden" id="hd_##id##" value="##homedir##">##homedir##&nbsp;</nobr></td>
  <td align=center>##action_select##&nbsp;</td>
</tr>
"-->

<!--#set var="list_body" value="
<script>

function selectItemFromPopup(form, id) {
    var fieldName = "hd_" + id;
    var oField = document.getElementById(fieldName);
    var oTmpField;
    if(destFieldId.length) {
        oTmpField = top.opener.document.getElementById(destFieldId);
        if(oTmpField && oField) {
            oTmpField.value = oField.value;
        }
    }
    window.close();
}

</script>


##list_hint##

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
    <table width="100%" border="0" cellspacing="0" cellpadding="4">
      <tr>
        <td class="first_row_all">
            ##sort_homedir##
            %%homedir%%
        </td>
        <td class="first_row_all" width=100 align="center">
            %%actions%%
        </td>
      </tr>
      ##list##
    </table>

<br><br>
<div align="center">
  <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="javascript:top.close();">
</div>
<a name="anchor"></a>
"-->
