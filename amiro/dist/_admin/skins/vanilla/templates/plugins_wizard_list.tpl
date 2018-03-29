%%include_language "templates/lang/plugins_wizard.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="is_installed_on"     value="<img title="%%icon_installed_on%%" class=icon src="skins/vanilla/icons/icon-installed.gif" border="0">"-->
<!--#set var="is_installed_off"    value="<img title="%%icon_installed_off%%" class=icon src="skins/vanilla/icons/icon-notinstalled.gif" border="0">"-->

<!--#set var="is_copied_on"     value="<img title="%%icon_is_copied_on%%" class=icon src="skins/vanilla/icons/icon-is_copied_on.gif">"-->
<!--#set var="is_copied_off"    value="&nbsp;"-->
<!--#set var="leg_is_copied_on" value="<nobr><img title="%%icon_is_copied_on%%" src="skins/vanilla/icons/icon-is_copied_on_leg.gif" border="0" align="absmiddle" helpId="legend"> - %%icon_is_copied_on%%</nobr>&nbsp;&nbsp;"-->


<!--#set var="icons_edit"     value="
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
"-->
<!--#set var="icons_edit_install"     value="
<a href="javascript:" onclick="javascript:user_click('install','##edit_id##');return false;"><img title="%%icon_edit%%" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
"-->
<!--#set var="install"     value="
<a href="javascript:" onclick="javascript:user_click('install','##install_id##');return false;"><img title="%%icon_install%%" class=icon src="skins/vanilla/icons/icon-install.gif"></a>
"-->
<!--#set var="uninstall"     value="
<a href="javascript:" onclick="javascript:if (confirm('%%uninstall_warn%%')){user_click('uninstall','##uninstall_id##');}return false;"><img title="%%icon_uninstall%%" class=icon src="skins/vanilla/icons/icon-uninstall.gif"></a>
"-->

<!--#set var="leg_installed" value="<nobr><img title="%%leg_installed%%" src="skins/vanilla/icons/icon-installed_leg.gif" border="0" align="absmiddle" helpId="legend"> - %%leg_installed%%</nobr>&nbsp;&nbsp;"-->
<!--#set var="leg_notinstalled" value="<nobr><img title="%%leg_notinstalled%%" src="skins/vanilla/icons/icon-notinstalled_leg.gif" border="0" align="absmiddle" helpId="backup"> - %%leg_notinstalled%%</nobr>&nbsp;&nbsp;"-->
<!--#set var="leg_install" value="<nobr><img title="%%leg_install%%" src="skins/vanilla/icons/icon-install_leg.gif" border="0" align="absmiddle" helpId="legend"> - %%leg_install%%</nobr>&nbsp;&nbsp;"-->
<!--#set var="leg_uninstall" value="<nobr><img title="%%leg_install%%" src="skins/vanilla/icons/icon-uninstall_leg.gif" border="0" align="absmiddle" helpId="backup"> - %%leg_uninstall%%</nobr>&nbsp;&nbsp;"-->


<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)">
  <td width="30" align=center>##is_installed##</td>
  <td width="140">##plugin_id##</td>
  <td width="60" align="right">##version##</td>
  <td width="200" class="td_small_text">##header##&nbsp;</td>
  <td>##installed_as##&nbsp;</td>
  <td width="80" align="center">##is_copied##</td>
  <td align=center>##action_edit####action_install####action_uninstall##</td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_all" align="center" valign="middle" width="30">
                 &nbsp;
                 ##sort_is_installed##
                </td>
                <td class="first_row_all" width="140">
                 %%plugin_id%%
                 ##sort_plugin_id##
                </td>
                <td class="first_row_all" width="60">
                 %%version%%
                </td>
                <td class="first_row_all list_name_col" width="200">
                 %%header%%
                </td>
                <td class="first_row_all">
                 %%installed_as%%
                 ##sort_installed_as##
                </td>
                <td class="first_row_all" width="60">
                 %%is_copied%%
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
</form>

<a name="anchor"></a>
<div id="deprecated_functionality" class="status-block">
<div class="status-msgs">
<div class="status-red">
%%obsolete_functionality%%
</div>
</div>
</div>
<script type="text/javascript">
AMI.$('#filter-box').before(AMI.$('#deprecated_functionality').detach());
</script>
"-->