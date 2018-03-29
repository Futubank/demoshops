%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/sys_users.lng"%%

<!--#set var="spec_login_on"     value="<img title="%%icon_spec_login_on%%" class=icon src="skins/vanilla/icons/icon-spec_ok.gif" helpId="btn_login_active">"-->
<!--#set var="spec_login_off"    value="&nbsp;"-->

<!--#set var="mask_leg"         value="<nobr>%%mask_leg_start%%: [-] - %%mask_leg_-%%, [A] - %%mask_A%%, [R] - %%mask_R%%, [W] - %%mask_W%%, [D] - %%mask_D%% &nbsp;&nbsp;</nobr>"-->
<!--#set var="spec_login_leg"   value="<nobr><img title="%%icon_spec_login_on%%" class=leg_icon align="absmiddle" src="skins/vanilla/icons/icon-spec_ok_leg.gif" helpId="btn_login_active"> - %%icon_spec_login_on%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td width="30" align=center>##active##</td>
  <td width="150">##username##</td>
  <td width="150">##lastname##&nbsp;##firstname##</td>
  <td>##email##&nbsp;</td>
  <td width="40" align="right">##groups##</td>
  <td width="40" align="center">##login##</td>
  <td nowrap>##actions##</td>
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
                 %%username%%
                 ##sort_username##
                </td>
                <td class="first_row_all" width="150">
                 %%lastname%%
                  ##sort_lastname##
                </td>
                <td class="first_row_all">
                 %%email%%
                  ##sort_email##
                </td>
                <td class="first_row_all" width="40">
                 %%user_groups%%
                </td>
                <td class="first_row_all" width="40">
                 %%login%%
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>

<a name="anchor"></a>
"-->