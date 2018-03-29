##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_res_dns_inst.lng"%%
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

<!--#set var="active_on"     value="<a href="javascript:" onclick="javascript:activate('##id_res_inst##','off');return false;"><img alt="%%icon_active_on%%" class=icon src="skins/vanilla/icons/icon-ok.gif" helpId="btn_active"></a>"-->
<!--#set var="active_off"    value="<a href="javascript:" onclick="javascript:activate('##id_res_inst##','on');return false;"><img alt="%%icon_active_off%%" class=icon src="skins/vanilla/icons/icon-close.gif" helpId="btn_active"></a>"-->

<!--#set var="icon_active_on"     value="<img alt="%%icon_active_on%%" class=icon src="skins/vanilla/icons/icon-ok.gif" helpId="btn_active">"-->
<!--#set var="icon_active_off"    value="<img alt="%%icon_active_off%%" class=icon src="skins/vanilla/icons/icon-close.gif" helpId="btn_active">"-->

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
  ##--<td align="center">##active##&nbsp;</td>--##
  <td align="right">##reseller_name##&nbsp;</td>
  <td>##client_name##&nbsp;</td>
  <td>&nbsp;##id_subscription##</td>
  <td>&nbsp;<nobr>##domain##<nobr></td>
  <td align="right">&nbsp;<nobr>##records_count##<nobr></td>
  <td align=center>##action_edit####action_del##</td>
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
                ##--<td class="first_row_all" width="30">
                 ##sort_active##
                </td>--##
                <td class="first_row_all" width="100">
                 %%reseller%%
                </td>
                <td class="first_row_all" width="100">
                 %%client%%
                </td>
                <td class="first_row_all" width="60">
                 %%subscription%%
                 ##sort_v.id_subscription##
                </td>
                <td class="first_row_all">
                 %%domain%%
                 ##sort_v.domain##
                </td>
                <td class="first_row_all" width="140">
                 %%records_count%%
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