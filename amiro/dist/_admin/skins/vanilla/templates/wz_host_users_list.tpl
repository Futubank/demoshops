%%include_language "templates/lang/wz_host_users.lng"%%
%%include_language "templates/lang/_wz_host_users_msgs.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty_sites%%</h3></td>
</tr>
</table>
"-->

<!--#set var="payments_docs_url" value="[<a href="javascript:void()" onclick="javascript:openExtDialog('%%payments_docs_title%%', '##payments_docs_href##&flt_mode=simple#anchor', 1, 1 );return false;">%%payments_docs%%</a>]"-->

<!--#set var="payments_url" value="[<a href="javascript:void()" onclick="javascript:openExtDialog('%%payments_title%%', '##payments_href##&flt_mode=simple#anchor', 1, 1 );return false;">%%payments%%</a>]"-->

<!--#set var="payments_history_url" value="[<a href="javascript:void()" onclick="javascript:openExtDialog('%%payments_history_title%%', '##payments_history_href##&flt_mode=simple#anchor', 1, 1 );return false;">%%payments_history%%</a>]"-->

<!--#set var="domain_url" value="
<a href="http://##domain##/" title="##domain##" target="_blank">##domain##</a>
"-->
<!--#set var="alias_url" value="
<br><a href="http://##alias##/" title="##alias##" target="_blank">##alias##</a>
"-->

<!--#set var="props_url" value="<a href="javascript:void()" onclick="javascript:openExtDialog('%%props_title%%', '##props_href##&action=edit&id=##id_props##&flt_mode=simple#anchor', 1, 1 );return false;">##client_name##</a>"-->

<!--#set var="row_limits" value="
<tr>
<td colspan="8">
	<b>%%total_sites%%:</b> ##sites##&nbsp;&nbsp;&nbsp;
	<b>%%second_level%%:</b> ##level2##&nbsp;&nbsp;&nbsp;
	<b>%%third_level%%:</b> ##level3##
</tr>
"-->


<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##-- <td width="30" align="center">##is_deleted##</td> --##
  <td width="75">##date_reg_fmt##<br><span style="font-weight:bold;">##node_name##</span></td>
  <td><nobr><b>##domain_url##</b><span style="font-size:9px;">##--[##id##]--####alias_url##<br>##if(LOGIN_OK==1)##[<a href="#" OnClick="document.loginform.elements['id'].value='##id##';
                         document.loginform.submit();return false;"><b><span style="color:#990000;">%%login_to%%</span></b></a>]##endif##
    <br>##payments_url##&nbsp;##payments_history_url##&nbsp;##payments_docs_url##</nobr></span>
  </td>
  <td width="115" nowrap style="font-size:9px;">
    <nobr><span style="font-weight:bold;">##username##</span> ##--[##id_member##]--##<br>[<a href="mailto:##email##">##email##</a>]

  </td>
  <td width="70">##licence_type##<br>##exp_daemon_ignore_on##</td>
  <td width="70">##status##</td>
  <td width="70">##admin_status##</td>
	<td style="font-size:9px;##IF(is_reseller=="1")##font-weight:bold;##ENDIF##">##props_url##&nbsp;</td>
	<td style="font-size:9px;">##reseller_name##&nbsp;</td>
  <td width="60">##last_login##<br>##logins_count##</td>
  <td width="90" align="right">##disk_space##<br>##disk_quota##&nbsp;%%megabyte%%</td>
  <td width="60">##licence_expire##</td>
  <td align=center nowrap>##actions##</td>
</tr>
##row_limits##
"-->
<!--#set var="list_body" value="
           
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_all" width="75">
                 %%date_registered%%
                 ##sort_date_registered##
                </td>
                <td class="first_row_all">
                 %%domain%%
                 ##sort_domain##
                </td>
                <td class="first_row_all" width="115">
                 %%username%%
                 ##sort_username##
                </td>
                <td class="first_row_all" width="70"  style='white-space:normal'>
                 %%type_exp%%
                 ##sort_licence_type##
                </td>
                <td class="first_row_all" width="70">
                 %%status_site%%
                 ##sort_status##
                </td>
                <td class="first_row_all" width="70">
                 %%admin_status%%
                 ##sort_admin_status##
                </td>
                <td class="first_row_all">
                 %%client%%
                </td>
                <td class="first_row_all">
                 %%reseller%%
                </td>
                <td class="first_row_all" width="60"  style='white-space:normal'>
                 %%last_login%% / %%logins_count%%
                 ##sort_last_login_date##
                </td>
                <td class="first_row_all" width="90"  style='white-space:normal'> 
                 %%used_space%%
                 ##sort_disk_space##
                </td>
                <td class="first_row_all" width="60">
                 %%licence_expire_dates%%
                 ##sort_licence_exp_date##
                </td>
                <td class="first_row_all" width="100" nowrap>
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>

<a name="anchor"></a>

<form method=post name="loginform">
<input type="hidden" name="id">
<input type="hidden" name="action" value="special">
<input type="hidden" name="script_link" value="##backurl##">
</form>
"-->

<!--#set var="login_form" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<body>
<form action="##admin_url##index.php" method=post name="loginform">
<input type=hidden name=hsid value="##hsid##">
<input type=hidden name=tstamp value="##tstamp##">
<input type=hidden name=loginname value="##loginname##">
<input type=hidden name=faction value=login>
<input type=hidden name=domain value="##domain##">
<input type="hidden" name="backurl" value="##backurl##">
</form>

<script type="text/javascript">
document.forms['loginform'].submit();
</script>

Login to <strong>##domain##</strong>, wait...
</body>
</html>
"-->
