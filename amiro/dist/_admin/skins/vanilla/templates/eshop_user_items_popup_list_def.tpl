<!--#set var="icon" value="
<img src="##path####icon##" border=0 title="##alt##">
"-->

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td align=center>##public##</td>
  <td>##name##</td>
  <td align=right width="80">##prefix####price####postfix##</td>
  <td align=right width="80">##if(commission_type != "percent")####prefix####endif####commission####if(commission_type == "percent")##%##else####postfix####endif##</td>
  <td align=center width="60"><a href="##viewicon##" target="_blank">##ftype##</a></td>
  <td align=right width="60">##filesize##</td>
</tr>
"-->

<!--#set var="list_body" value="
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_left_td" align="center" valign="middle" width="60">
                 ##sort_public##
                 <nobr>%%status%%</nobr>
                </td>
                <td class="first_row_all list_name_col" valign="middle">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all" align="center" valign="middle" width="80">
                 %%price%%
                </td>
                <td class="first_row_all" align="center" valign="middle" width="80">
                 %%commission%%
                </td>
                <td class="first_row_all" align="center" valign="middle" width="60">
                 %%type%%
                </td>
                <td class="first_row_all" align="center" valign="middle" width="60">
                 %%volume%%
                </td>
              </tr>
              ##list##
            </table>
         ##filter_hidden_fields##


<a name="anchor"></a>
"-->