##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/modules_templates_langs.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="leg_tpl_modified" value="<nobr><img title="%%disk_template_modified%%" src="skins/vanilla/icons/leg_darkred.gif" align="absmiddle" helpId="legend"> - %%disk_template_modified%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
<br>
##if(_ENABLE_BUTTONS)##
<br>
<input type="button" value="%%action_export%%" onClick="tplsAction('export')" class="but-long" id="buttonExport" title="##if(TPLS_READ_FROM_DISK)##%%export_not_allowed%%##endif##">
<input type="button" value="%%action_import%%" onClick="tplsAction('import')" class="but-long">
##if(TPLS_READ_FROM_DISK)##
<script>document.getElementById('buttonExport').disabled='true'</script>
##endif##
<br>
##endif##
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  ##_positions_col##
  <td class="td_small_text">##path##</td>
  <td>##name##</td>
  <td class=td_small_text>##module##</td>
  <td class="td_small_text">##if(isModified)##<font color="#ff0000" title="%%disk_template_modified%%" style="font-weight: bold">##mdate##</font>##else####mdate####endif##</td>
  ##_id_page_row_col##
  <td align=center>##action_edit####action_del##</td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
##_positions_data##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="first_row_left_td">
                 %%path%%
                 ##sort_path##
                </td>
                <td class="first_row_all list_name_col">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all">
                 %%module%%
                 ##sort_module##
                </td>
                <td class="first_row_all">
                 %%mdate%%
                 ##sort_modified##
                </td>
##_id_page_header##
                <td class="first_row_all" align="center">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
##_group_operations_footer##
</form>

##if(_ENABLE_BUTTONS)##
<br>
<input type="button" value="%%action_export%%" onClick="tplsAction('export')" class="but-long" id="buttonExport" title="##if(TPLS_READ_FROM_DISK)##%%export_not_allowed%%##endif##">
<input type="button" value="%%action_import%%" onClick="tplsAction('import')" class="but-long">
##if(TPLS_READ_FROM_DISK)##
<script>document.getElementById('buttonExport').disabled='true'</script>
##endif##
<br>
##endif##

<a name="anchor"></a>
"-->