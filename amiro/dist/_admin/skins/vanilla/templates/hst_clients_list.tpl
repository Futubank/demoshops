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
<nobr>##username##<br>
  <span style="font-size:9px;">
    ##if(is_active==1)##[<a href="#" OnClick="document.loginform.elements['id'].value='##id##';
                         document.loginform.submit();return false;"><b><span style="color:#990000;">%%login_to%%</span></b></a>]##endif##
    </nobr>
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
  <td>##reseller_name##&nbsp;</td>
  <td>##username##</td>
  <td>##if(is_reseller)####client_name####else##<a href="hst_subscriptions.php?flt_clientname=##encoded_client_name##" title="%%show_subscriptions%%">##client_name##</a>##endif##&nbsp;</td>
##if(ESHOP_ACCOUNT=="1")##
  <td align="right"><nobr>##balance##</nobr></td>
##endif##
  <td>##email##</td>
  <td align=right>##clients_count##</td>
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
                <td class="first_row_all" width="80">
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

Login as <strong>##loginname##</strong>, wait...

"-->
