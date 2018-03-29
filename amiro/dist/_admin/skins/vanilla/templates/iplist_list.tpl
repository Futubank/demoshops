%%include_language "templates/lang/iplist.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td width="100">##start##</td>
  <td width="100">##end##</td>
  <td><nobr>##name##&nbsp;<nobr></td>
  <td width="70" align=center>##area##&nbsp;</td>
  <td align=center>##actions##</td>
</tr>
"-->

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_left_td" valign="middle" width="100">
                 %%ip_start%%
                 ##sort_start##
                </td>
                <td class="first_row_all" width="100">
                 %%ip_end%%
                  ##sort_end##
                </td>
                <td class="first_row_all list_name_col">
                 %%name%%
                  ##sort_name##
                </td>
                <td class="first_row_all" width="70">
                 %%visible_area%%
                  ##sort_visible_area##
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##iplist_list##
            </table>

<a name="anchor"></a>