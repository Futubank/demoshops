%%include_language "templates/lang/templates.lng"%%
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
  <td width="60">##date##&nbsp;</td>
  <td width=""><nobr>##name##&nbsp;<nobr></td>
  <td width="40" align=center>##actions##</td>
</tr>
"-->

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="first_row_left_td" width="100">
                 %%date%%
                 ##sort_date##
                </td>
                <td class="first_row_all list_name_col">
                 %%name%%
                  ##sort_name##
                </td>
                <td class="first_row_all" align="center" nowrap width=100>
                 %%actions%%
                </td>
              </tr>
              ##templates_list##
            </table>



<a name="anchor"></a>
