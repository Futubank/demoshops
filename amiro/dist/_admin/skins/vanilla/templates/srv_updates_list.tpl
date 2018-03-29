%%include_language "templates/lang/srv_updates.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="view" value="
  <a href="javascript:" onClick="user_click('view','##view_id##');return false;"><img title="%%contents%%" class=icon src="skins/vanilla/icons/icon-view.gif"></a>
"-->

<!--#set var="update" value="
  <a href="javascript:" onClick="userDialog.open('%%up_popup_title%%', 350, 370, ['<b><center><font size=\'2\'>%%do_update%%</center></font></b><br>', '[*] %%do_backup%%', '%%backup_warning%%'], ['%%run_btn%%', '%%cancel_btn%%'], cbConfirmUpdate, {update_id : '##update_id##'}); return false;"><img title="%%icon_install_update%%" class=icon src="skins/vanilla/icons/icon-backup.gif"></a>
"-->

<!--#set var="update_force_backup" value="
  <a href="javascript:" onClick="userDialog.open('%%up_popup_title%%', 350, 170, ['<b><center><font size=\'2\'>%%do_update%%</center></font></b><br>'], ['%%run_btn%%', '%%cancel_btn%%'], cbConfirmUpdate_forceBackup, {update_id : '##update_id##'}); return false;"><img title="%%icon_install_update%%" class=icon src="skins/vanilla/icons/icon-backup.gif"></a>
"-->

<!--#set var="del" value="
  <a href="javascript:" onClick="if (confirm('%%del_update%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del_update%%" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="restore" value="
  <a href="javascript:" onClick="if (confirm('%%restore_version%%')){startOp('##restore_id##','restore');}return false;"><img title="%%icon_restore_version%%" class=icon src="skins/vanilla/icons/icon-restore.gif"></a>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td class="td_small_text" nowrap style="text-align:center;">##release_date##</td>
  ##--<td class="td_small_text" nowrap style="text-align:center;">##install_date##</td>--##
  <td class="td_small_text">##description##&nbsp;</td>
  <td class="td_small_text"><div class="columnLayout-height-fixed">##full_description##&nbsp;##if(link)##<br /><a href=##link## target="_blank">%%detailed_description%%</a>&nbsp;##endif##</div></td>
  <td align="right">##name##&nbsp;</td>
  <td nowrap style="text-align:center;">##file_status##&nbsp;</td>
  <td nowrap style="text-align:center;">##inst_status##&nbsp;</td>
  <td class="td_small_text" nowrap style="text-align:right;">##size##</td>
  <td width="" align=center nowrap><nobr>&nbsp;##action_view####action_update####action_restore####action_del##</nobr></td>
</tr>
"-->

<!--#set var="list_body" value="
	<script type="text/javascript">
	    function cbConfirmUpdate(result, param){
		if(result[1] == 0){
		    if(result[0][1] == 1){
			startOp(param.update_id, 'update');
		    } else {
			startOp(param.update_id, 'update_nobackup');
		    }
		}
	    }
	    function cbConfirmUpdate_forceBackup(result, param){
		if(result[1] == 0){
			startOp(param.update_id, 'update');
		}
	    }
	</script>
        
##button_add##
<style>
td div.columnLayout-height-fixed {
    display: block;
    max-height: 106px;
    overflow-y: auto;
    text-align: left;
}
</style>
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_all" width="8%" align="center">
                 %%release_date%%
                 ##sort_release_date##
                </td>
                ##--<td class="first_row_all" width="8%" align="center">
                 %%install_date%%
                </td>--##
                <td class="first_row_all" align="center" width="20%">
                 %%name%%
                </td>
                <td class="first_row_all" align="center">
                 %%description%%
                </td>
                <td class="first_row_all" width="6%" align="center">
                 %%upd_name%%
                </td>
                <td class="first_row_all" align="center">
                 %%file%%
                </td>
                <td class="first_row_all" align="center">
                 %%status%%
                </td>
                <td class="first_row_all" width="8%" align="center">
                 %%size%%
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
</form>

<a name="anchor"></a>
"-->
