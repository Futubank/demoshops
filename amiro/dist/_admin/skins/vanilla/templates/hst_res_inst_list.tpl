##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_res_inst.lng"%%
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

<!--#set var="archive"    value="<a href="javascript:" onclick="javascript:archive('##arch_id##','on');return false;"><img alt="%%archive%%" class=icon src="skins/vanilla/icons/icon-not_archived.gif" helpId="btn_archive"></a>"-->

<!--#set var="active_on"     value="
##if(!IS_USER)##
<a href="javascript:" onclick="javascript:activate('##act_id##','blocked');return false;"><img alt="%%icon_active_on%%" class=icon src="skins/vanilla/icons/icon-ok.gif" helpId="btn_active"></a>
##else##
<img alt="%%icon_active_on%%" class=icon src="skins/vanilla/icons/icon-ok.gif" helpId="btn_active">
##endif##"-->

<!--#set var="active_off"    value="
##if(!IS_USER)##
<a href="javascript:" onclick="javascript:activate('##act_id##','active');return false;"><img alt="%%icon_active_off%%" class=icon src="skins/vanilla/icons/icon-close.gif" helpId="btn_active"></a>
##else##
<img alt="%%icon_active_off%%" class=icon src="skins/vanilla/icons/icon-close.gif" helpId="btn_active">
##endif##"-->


<!--#set var="domain_value" value="
<nobr><b>##domain_url##</b><br>
  <span style="font-size:9px;">
    ##if(LOGIN_OK==1)##[<a href="#" OnClick="document.loginform.elements['id'].value='##id##';
                         document.loginform.submit();return false;"><b><span style="color:#990000;">%%login_to%%</span></b></a>]##endif##
    </nobr>
"-->

<!--#set var="domain_url" value="
<a href="http://##domain##/" title="##domain##" target="_blank">##domain##</a>
"-->

<!--#set var="row_limits" value="
<tr>
<td colspan="8">
	<b>%%total_sites%%:</b> ##sites##&nbsp;&nbsp;&nbsp;
	<b>%%second_level%%:</b> ##level2##&nbsp;&nbsp;&nbsp;
	<b>%%third_level%%:</b> ##level3##
</tr>
"-->

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="col_header" value="
                <td class="first_row_all"##if(col_width)## width="##col_width##"##endif##>
                 ##sort_col##
                 ##header##
                </td>
"-->

<!--#set var="col" value="
  <td align="##align##"><nobr>##value##&nbsp;<nobr></td>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##')">
  ##_group_operations_col##
  <td align="center">##active_state##&nbsp;</td>
##if(EXTENSION_AUDIT=="1")##
  <td align="center">
    <b>##audit_status##</b><br>
    ##audit_role##<br>
    ##audit_username##
  </td>
##endif##
  <td>##reseller_name##&nbsp;</td>
  <td>##client_name##&nbsp;</td>
  <td align="right">##id_subscription##&nbsp;</td>
  ##cols##
  <td width="##ACTIONS_WIDTH##" align=center><div style='white-space: nowrap;'>##action_archive####action_edit####action_purge####action_copy####action_del##</div></td>
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
                <td class="first_row_all" width="30">
                 ##sort_active_state####sort_r.active_state##
                </td>
##if(EXTENSION_AUDIT=="1")##
                <td class="first_row_all" width="100">
                %%audit_status%%
                </td>
##endif##
                <td class="first_row_all" width="100">
                 %%reseller%%
                </td>
                <td class="first_row_all" width="100">
                 %%client%%
                </td>
                <td class="first_row_all" width="60">
                 %%subscription%%
                 ##sort_id_subscription##
                </td>
                ##col_headers##
                <td class="first_row_all" align="center" width="##ACTIONS_WIDTH##">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
##_group_operations_footer##
</form>

<a name="anchor"></a>
<form method=post name="loginform">
<input type="hidden" name="id">
<input type="hidden" name="action" value="special">
<input type="hidden" name="script_link" value="##backurl##">
</form>
"-->

<!--#set var="login_form" value="
<form action="##admin_url##index.php" method=post name="loginform">
<input type=hidden name=hsid value="##hsid##">
<input type=hidden name=tstamp value="##tstamp##">
<input type=hidden name=loginname value="##loginname##">
<input type=hidden name=faction value=login>
<input type=hidden name=domain value="##domain##">
<input type="hidden" name="backurl" value="##backurl##">
</form>

<script type="text/javascript">
document.loginform.submit();
</script>

Login to <strong>##domain##</strong>, wait...

"-->
