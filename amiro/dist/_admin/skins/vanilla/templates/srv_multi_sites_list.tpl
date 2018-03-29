%%include_language "templates/lang/srv_multi_sites.lng"%%
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
  <td width="20" align="right">##id##&nbsp;</td>
  <td width="100"><nobr>##name##&nbsp;<nobr></td>
  <td><nobr>##url##&nbsp;<nobr></td>
  <td align=center>##actions##</td>
</tr>
"-->

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_left_td" align="center" valign="middle" width="20">
                 %%id%%
                 ##sort_id##
                </td>
                <td class="first_row_all list_name_col" valign="middle">
                 %%name%%
                  ##sort_name##
                </td>
                <td class="first_row_all" valign="middle">
                 %%url%%
                  ##sort_url##
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##sites_list##
            </table>

<a name="anchor"></a>