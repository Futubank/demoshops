%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/_common_msgs.lng"%%
%%include_language "templates/lang/jobs.lng"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="move" value="
  <a href="javascript:" onclick="javascript:openDialog('%%jobs_history_popup_title%%', 'jobs_resume.php?popup=1&ext_module=jobs_history&id_ext_module=##id##', '');return false;"><img title="%%icon_move%%" class=icon src="skins/vanilla/icons/icon-action-move_on.gif"></a>
"-->

<!--#set var="move_off" value="<img title="%%icon_move_off%%" class=icon src="skins/vanilla/icons/icon-action-move_off.gif">"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##

  <td width="30" align=center>##id##&nbsp;</td>
  <td>##department##&nbsp;</td>
  <td width="200">##title##&nbsp;</td>
  <td width="60" class="td_small_text">##fdate##&nbsp;</td>
  <td width="100">##jobname##&nbsp;</td>
  <td width="60">##phone##&nbsp;</td>
  <td width="60">##user_id##&nbsp;</td>
  <td width="100">##status##&nbsp;</td>
  <td align=center><nobr>##--actions--####action_move####action_edit####action_reply####action_view####action_print####action_del##</td>
</tr>
"-->

<!--#set var="list_body" value="

<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_left_td" align="center" valign="middle" width="30">
                 %%job_id%%
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%department%%
                 ##sort_department##
                </td>
                <td class="first_row_all list_name_col" width="120">
                 %%title%%
                 ##sort_title##
                </td>

                <td class="first_row_all" align="center" width="60">
                %%fdate%%&nbsp;
                ##sort_date##
                </td>
                <td class="first_row_all" align="center">
                %%job_name%%&nbsp;
                ##sort_jobname##
                </td>
                <td class="first_row_all" align="center" width="60">
                %%phone%%&nbsp;
                </td>
                <td class="first_row_all" align="center" width="40">
                %%user_id%%&nbsp;
                </td>
                <td class="first_row_all" align="center" width="100">
                %%job_status%%
                ##sort_job_status##
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
