%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/sys_users.lng"%%

<!--#set var="leg_move" value="<nobr><img title="%%icon_move%%" class=leg_icon src="skins/vanilla/icons/icon-popup_add_leg.gif" border="0" align="absmiddle" helpId="legend"> - %%icon_move%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="leg_remove" value="<nobr><img title="%%icon_remove%%" class=leg_icon src="skins/vanilla/icons/icon-popup_del_leg.gif" border="0" align="absmiddle" helpId="legend"> - %%icon_remove%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td align=center>##active##</td>
  <td>##username##</td>
  <td>&nbsp;##lastname##</td>
  <td>&nbsp;##firstname##</td>
  <td>##email##</td>
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
                <td class="first_row_left_td" align="center" valign="middle" width="30">
                 ##sort_active##
                </td>
                <td class="first_row_all" valign="middle" width="150">
                 ##sort_username##
                 %%username%%
                </td>
                <td class="first_row_all" width="150">
                 ##sort_lastname##
                 %%orig_lastname%%
                </td>
                <td class="first_row_all" width="150">
                 ##sort_firstname##
                 %%orig_firstname%%
                </td>
                <td class="first_row_all">
                 ##sort_email##
                 %%email%%
                </td>
                <td class="first_row_all" align="center" width="90">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>

##button_add##
<div align="right" width="100%">##pager##</div>
<a name="anchor"></a>
"-->