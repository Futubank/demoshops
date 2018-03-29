%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/jobs_resume.lng"%%

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
  <td width="60" class="td_small_text">##fdate##&nbsp;</td>
  <td width="150">##jobname##&nbsp;</td>
  <td width="200">##title##&nbsp;</td>
  ##category_col##
  ##_id_page_row_col##
  ##if(EXTENSION_AUDIT=="1")##
    <td align="center">
      <b>##audit_status##</b><br>
      ##audit_role##<br>
      ##audit_username##
    </td>
##endif##
  <td width="60">##phone##&nbsp;</td>
  <td width="100" class="td_small_text">##status##&nbsp;</td>
  <td align=center><nobr>##--actions--####action_edit####action_reply####action_view####action_print####action_del##</td>
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
                <td class="first_row_all" align="center" width="60">
                %%resume_fdate%%
                ##sort_date##
                </td>
                <td class="first_row_all" align="center" width="150">
                %%resume_name%%&nbsp;
                ##sort_jobname##
                </td>
                <td class="first_row_all list_name_col" width="200">
                 %%resume_title%%
                 ##sort_title##
                </td>
                ##category_list_header##
                <td class="first_row_all" align="center" width="60">
                %%phone%%&nbsp;
                </td>
                <td class="first_row_all" align="center" width="100">
                %%job_status%%
                ##sort_job_status##
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
