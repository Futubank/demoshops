%%include_language "templates/lang/pay_drivers.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="is_installed_on"     value="<img title="%%icon_installed_on%%" class=icon src="skins/vanilla/icons/icon-installed.gif" border="0">"-->
<!--#set var="is_installed_off"    value="<img title="%%icon_installed_off%%" class=icon src="skins/vanilla/icons/icon-notinstalled.gif" border="0">"-->
<!--#set var="action_info" value="
##IF(show_driver_info)##
<a href="#" onclick="return showDescription('##name_js##', '##header_js##');" class="list-icon icon-info"><div class="amiModuleLink"></div></a>
##ELSE##
<img class="iconEmpty" src="skins/vanilla/images/spacer.gif" />
##ENDIF##
"-->

##--
<!--#set var="info" value=" <a href="#" valign="top" onclick="return showDescription('##name_js##', '##header_js##');"><img src="skins/vanilla/icons/icon-info.gif" height="16" width="16" valign="top" alt="" border="0" /></a>"-->
<!--#set var="info" value=" <sup onclick="showDescription('##name_js##', '##header_js##');" style="cursor: pointer; font-weight: bold; color: #000; font-size: 12px;">i</sup>"-->
--##
<!--#set var="info" value="<a href="#" onclick="return showDescription('##name_js##', '##header_js##');" class="simple-icon icon-info" style="align: absmiddle;"><div class="amiModuleLink"></div></a>"-->

<!--#set var="icons_edit"     value="
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
"-->
<!--#set var="icons_edit_install"     value="
<a href="javascript:" onclick="javascript:user_click('edit','##edit_id##');return false;"><img title="%%icon_edit%%" class=icon src="skins/vanilla/icons/icon-edit.gif"></a>
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
  <td width="30" align="center">##is_installed##</td>
  <td>##name##</td>
  <td width="*" class="td_small_text">##header####info##&nbsp;</td>
  <td width="80">##action_info####action_edit####action_install####action_uninstall##</td>
</tr>
"-->

<!--#set var="list_body" value="
##button_add##
<script type="text/javascript">
var driverDescriptions = {};
##driverDescriptionsJS##

function showDescription(name, header){
    new AMI.UI.Popup(
        driverDescriptions[name],
        {
            header:      '%%description_popup_header%% "' + header + "'",
            modal:       true,
            hasCloseBtn: true,
            movable:     true,
            autoshow:    true,
            animated:    true,
            onShow:      function(popupWin){AMI.UI.center(popupWin.object);},
            height:      1,
            autoHeight:  true
        }
    );

    return false;
}

</script>
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_all" align="center" valign="middle" width="30">
                 &nbsp;
                 ##sort_is_installed##
                </td>
                <td class="first_row_all">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all list_name_col" width="*">
                 %%header%%
                </td>
                <td class="first_row_all" align="center" width="80">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
</form>

##if(display_tooltip)##
<div class="tooltip"##-- style="margin-top: 5px; margin-right: 0px; margin-bottom: 5px; margin-left: 0px;"--##>%%install_drivers_from_market%%</div>
##endif##

<a name="anchor"></a>
"-->