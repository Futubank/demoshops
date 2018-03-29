##--!ver=0200 rules="-SETVAR"--##
%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/hst_resellers.lng"%%

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

<!--#set var="icons_edit_reset_delconfirm"     value="
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img alt="%%icon_edit%%" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
<a href="javascript:" onClick="if (confirm('%%reset_pass_warn%%')){user_click('reset','##reset_id##');}return false;"><img alt="%%icon_reset%%" class=icon src="skins/vanilla/icons/icon-reset_pass.gif"></a>
<a href="javascript:" OnClick="javascript:openDialog('%%delete_popup%%', '##script_link##?action=del&id=##del_id##', 450, 230);return false;"><img alt="%%icon_del%%" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
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
  <td align="center">##active##</td>
  <td>##username##</td>
  <td>##reseller_name##</td>
##if(ESHOP_ACCOUNT=="1")##
  <td align="right"><nobr>##balance##</nobr></td>
##endif##
  <td>##email##</td>
  <td align="right">##clients_count##</td>
  <td align="center" nowrap>##actions##</td>
</tr>
"-->

<!--#set var="list_body" value="
##list_hint##
           
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_active##
                </td>
                <td class="first_row_all" valign="middle" width="150">
                 %%username%%
                 ##sort_username##
                </td>
                <td class="first_row_all" width="150">
                 %%reseller_name%%
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
                <td class="first_row_all" width="100">
                 %%clients_count%%
                  ##sort_clients_count##
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
             </table>
            ##_group_operations_footer##
            </form>

        <a name="anchor"></a>
"-->
