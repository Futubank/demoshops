%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/jobs.lng"%%

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
  ##_positions_col##
  <td width="30" align=center>##public##</td>
  <td width="60" class="td_small_text">##fdate##&nbsp;</td>
  <td width="90" class="td_small_text">##edate##&nbsp;</td>
  <td width="60" class="td_small_text">##status##&nbsp;</td>
  <td width="200">##name##&nbsp;</td>
  ##category_col##
  <td width="60" align=center>##salary##&nbsp;</td>
  ##_id_page_row_col##
  ##if(EXTENSION_AUDIT=="1")##
    <td align="center">
      <b>##audit_status##</b><br>
      ##audit_role##<br>
      ##audit_username##
    </td>
##endif##
  <td align=center>##--actions--####action_edit####action_del##</td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
##_positions_data##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                ##_positions_header##
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_public##
                </td>
                <td class="first_row_all" align="center" width="60">
                %%fdate%%
                ##sort_date##
                </td>
                <td class="first_row_all" align="center" width="90">
                %%edate%%
                ##sort_date_expire##
                </td>
                <td class="first_row_all" align="center" width="60">
                %%job_status%%
                ##sort_job_status##
                </td>
                <td class="first_row_all list_name_col" width="200">
                 %%name%%
                 ##sort_name##
                </td>
                ##category_list_header##
                <td class="first_row_all" align="right" width="60">
                 %%salary%%
                 ##sort_salary##
                </td>
                ##_id_page_header##
##if(EXTENSION_AUDIT=="1")##
                <td class="first_row_all" width="100">
                %%audit_status%%
                </td>
##endif##
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
