%%include_language "templates/lang/adv_banners.lng"%%
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
  <td>
    ##if(type == "1")##
        <a target=_blank>##name##</a>&nbsp;
    ##else##
        <a href="##file_base####file##" title="%%link_title%%" target=_blank>##name##&nbsp;&raquo;</a>&nbsp;
    ##endif##
  </td>
  <td width="80">
    ##if(status == "2")##
        %%status_approved%%
    ##elseif(status == "3")##
        %%status_declined%%
    ##else##
        %%status_waiting%%
    ##endif##
  </td>
  <td width="100">
    ##if(type == "1")##
        %%type_text%%
    ##elseif(type == "2")##
        %%type_img%%
    ##elseif(type == "3")##
        %%type_flash%%
    ##else##
        %%type_unknown%%
    ##endif##
  </td>
  <td width="200" class="td_small_text"><a href="##url##" target=_blank>##url##&nbsp;&raquo;</a>&nbsp;</td>
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
                <td class="first_row_all list_name_col">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all" width="80">
                 %%status%%
                 ##sort_status##
                </td>
                <td class="first_row_all" width="100">
                 %%type%%
                 ##sort_type##
                </td>
                <td class="first_row_all" width="200">
                 %%url%%
                 ##sort_url##
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