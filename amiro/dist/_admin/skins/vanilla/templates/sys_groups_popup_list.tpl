%%include_language "templates/lang/sys_groups.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="leg_move" value="<nobr><img title="%%icon_move%%" class=leg_icon src="skins/vanilla/icons/icon-popup_add_leg.gif" border="0" align="absmiddle" helpId="legend"> - %%icon_move%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="leg_remove" value="<nobr><img title="%%icon_remove%%" class=leg_icon src="skins/vanilla/icons/icon-popup_del_leg.gif" border="0" align="absmiddle" helpId="legend"> - %%icon_remove%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="spec_default_on"   value="<img title="%%icon_spec_default_on%%" class=icon src="skins/vanilla/icons/icon-spec_ok.gif" helpId="btn_default_active">"-->
<!--#set var="spec_default_off"  value="&nbsp;"-->
<!--#set var="spec_guest_on"     value="<img title="%%icon_spec_guest_on%%" class=icon src="skins/vanilla/icons/icon-spec_ok.gif" helpId="btn_guest_active">"-->
<!--#set var="spec_guest_off"    value="&nbsp;"-->
<!--#set var="spec_login_on"     value="<img title="%%icon_spec_login_on%%" class=icon src="skins/vanilla/icons/icon-spec_ok.gif" helpId="btn_login_active">"-->
<!--#set var="spec_login_off"    value="&nbsp;"-->

<!--#set var="spec_default_leg" value="<nobr><img title="%%icon_spec_default_on%%" class=leg_icon align="absmiddle" src="skins/vanilla/icons/icon-spec_ok_leg.gif" helpId="btn_default_active"> - %%icon_spec_default_on%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="spec_guest_leg"   value="<nobr><img title="%%icon_spec_guest_on%%" class=leg_icon align="absmiddle" src="skins/vanilla/icons/icon-spec_ok_leg.gif" helpId="btn_guest_active"> - %%icon_spec_guest_on%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="spec_login_leg"   value="<nobr><img title="%%icon_spec_login_on%%" class=leg_icon align="absmiddle" src="skins/vanilla/icons/icon-spec_ok_leg.gif" helpId="btn_login_active"> - %%icon_spec_login_on%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="mask_leg"         value="<nobr>%%mask_leg_start%%: [-] - %%mask_leg_-%%, [A] - %%mask_A%%, [R] - %%mask_R%%, [W] - %%mask_W%%, [D] - %%mask_D%% &nbsp;&nbsp;</nobr>"-->

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
##--  <td align=center>##is_default##</td>--##
  <td align=center>##guest##</td>
  <td>##name##</td>
  <td align=right>##modules##</td>
  <td align=center>##login##</td>
  <td nowrap>
  <a href="javascript:user_click('move','##id##');"><img title="%%icon_move%%" class=icon src="skins/vanilla/icons/icon-popup_add.gif"></a>
  ##actions##
  </td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
##--                <td class="first_row_left_td" align="center" valign="middle" width="60">
                 ##sort_is_default##
                 <nobr>%%is_default%%</nobr>
                </td>--##
                <td class="first_row_all" align="center" valign="middle" width="60">
                 ##sort_guest##
                 %%guest%%
                </td>
                <td class="first_row_all list_name_col" valign="middle">
                 ##sort_name##
                 %%name%%
                </td>
                <td class="first_row_all" valign="middle" width="30">
                 %%modules_header%%
                </td>
                <td class="first_row_all" align="center" valign="middle" width="40">
                 ##sort_login##
                 %%login%%
                </td>
                <td class="first_row_all" align="center" width="80">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
         ##filter_hidden_fields##

##button_add##
<div align="right" width="100%">##pager##</div>

<a name="anchor"></a>
"-->