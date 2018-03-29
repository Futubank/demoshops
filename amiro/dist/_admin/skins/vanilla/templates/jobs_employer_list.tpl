%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/_common_msgs.lng"%%
%%include_language "templates/lang/jobs_employer.lng"%%

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
  <td width="60" class="td_small_text">##fdate##&nbsp;</td>
  <td width="150">##name##&nbsp;</td>
  <td width="150" >##jobname##&nbsp;</td>
  <td width="130">##competitor##&nbsp;</td>
  <td width="80">##position##&nbsp;</td>
  <td width="100" class="td_small_text" align=right>##status##&nbsp;</td>
  <td align=center><nobr>##--actions--####action_edit####action_reply####action_view####action_print####action_del##</td>
</tr>
"-->

<!--#set var="list_body" value="
           
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_all" align="center" width="60">
                %%employer_date%%&nbsp;
                ##sort_date##
                </td>
                <td class="first_row_all" align="center" width="150">
                 %%employer_company%%
                 ##sort_name##
                </td>
                <td class="first_row_all" width="150">
                 %%employer_name%%
                 ##sort_jobname##
                </td>
                <td class="first_row_all" align="center" width="130">
                %%employer_competitor%%&nbsp;
                </td>
                <td class="first_row_all" align="center" width="80">
                %%employer_position%%&nbsp;
                </td>
                <td class="first_row_all" align="center" width="100">
                %%employer_status%%
                ##sort_status##
                </td>
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
