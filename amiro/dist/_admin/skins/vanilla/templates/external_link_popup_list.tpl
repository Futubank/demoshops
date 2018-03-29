##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/external_link_popup.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)">
  ##_group_operations_col##
  <td width="100">##id_external##&nbsp;</td>
  <td>##name##</td>
  <td align=center nowrap>##action_del##</td>
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
                <td class="first_row_left_td" align="center" valign="middle" width="30">
                 %%id_external%%
                 ##sort_id_external##
                </td>
                <td class="first_row_all list_name_col">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
##_group_operations_footer##
</form>
<div align="left">
  <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="closeDialogWindow();">
</div>

<a name="anchor"></a>
"-->