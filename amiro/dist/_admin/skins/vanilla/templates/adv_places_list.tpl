%%include_language "templates/lang/adv_places.lng"%%
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
  ##_group_operations_col##
  <td width="30" align=center>##public##</td>
  <td width="30">##id##</td>
  <td>##name##&nbsp;</td>
  <td class="td_small_text">##description##&nbsp;</td>
  <td width="100">##postfix##&nbsp;</td>
  <td width="100">##source_type##&nbsp;</td>
##_id_page_row_col##
  <td align=center>##action_edit####action_del####--actions--##</td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_public##
                </td>
                <td class="first_row_all" width="30">
                 %%place_id%%
                 ##sort_id##
                </td>
                <td class="first_row_all list_name_col">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all">
                 %%description%%
                 ##sort_description##
                </td>
                <td class="first_row_all" width="100">
                 %%postfix%%
                 ##sort_postfix##
                </td>
                <td class="first_row_all" width="100">
                 %%source_type%%
                 ##sort_source_type##
                </td>
##_id_page_header##
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
##_group_operations_footer##
</form>

<a name="anchor"></a>
"-->