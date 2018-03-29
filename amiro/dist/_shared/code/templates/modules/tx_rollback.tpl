%%include_language "_shared/code/templates/lang/tx_rollback.lng"%%

<!--#set var="auth_form" value="
<script type="text/javascript">
function validateTxRollbackAuthForm(oForm){
    var value = oForm.elements['ami_mp'].value.replace(/^\s+/mg, '').replace(/\s+$/mg, '');

    if(value == ''){
        alert('%%missing_master_password%%!');
        oForm.elements['ami_mp'].focus();
        return false;
    }

    return true;
}
</script>

<form method="post" onsubmit="return validateTxRollbackAuthForm(this);">
    %%enter_master_password%%: <input type="text" name="ami_mp" />
    <input type="submit" value="&raquo;" />
</form>
"-->

<!--#set var="invalid_password" value="
<div style="color: #f00;">%%invalid_master_password%%!</div>
"-->

<!--#set var="no_rollback_data" value="
%%no_rollback_data%%!
"-->

<!--#set var="rollback" value="
<form method="post">
<input type="hidden" name="tx_rollback_id" value="2" />
<input type="hidden" name="do" value="rollback" />
<table cellpadding="2" cellspacing="2" border="1">
<thead>
<tr>
    <th>%%class%%</th>
    <th>%%name%%</th>
    <th>%%started%%</th>
    <th>%%finished%%</th>
    <th>%%cms_version%%</th>
</tr>
</thead>
<tbody>
##rows##
<tr>
    <td colspan="5" style="text-align: center;">
##IF(canRollback)##
        <input type="submit" value="%%rollback%% &raquo;" />&nbsp; &nbsp; &nbsp;
##ENDIF##
##--        <input type="submit" value="%%wipe_rollback_data%% &raquo;" onclick="var res = confirm('%%confirm_wipe_rollback_data%%'); if(res){this.form.elements['do'].value = 'wipe_rollback_data'; } return res;" />&nbsp; &nbsp; &nbsp; --##
        <input type="submit" value="%%wipe_all_backup_data%% &raquo;" onclick="this.form.elements['do'].value = 'wipe_all_backup_data'; return true;" />&nbsp; &nbsp; &nbsp;
    </td>
</td>
</tbody>
</table>
</form>
"-->

<!--#set var="row" value="
<tr>
    <td>##class##</td>
    <td>##name##</td>
    <td><nobr>##started##</nobr></td>
    <td><nobr>##finished##</nobr></td>
    <td>##cmsVersion##</td>
</tr>
"-->

<!--#set var="invalid_cms_version" value="
<span style="color: #f00;">##cmsVersion##</span> (%%current%%: ##currentCMSVersion##)
"-->

<!--#set var="rollback_success" value="
%%rollback_success%%.
"-->

<!--#set var="wipe_all_backup_data" value="
<form method="post">
<input type="hidden" name="tx_rollback_id" value="2" />
<input type="hidden" name="do" value="wipe_all_backup_data" />
<input type="hidden" name="wipe" value="" />
<input type="submit" value="%%wipe_all_backup_data%% &raquo;" onclick="var res = confirm('%%confirm_wipe_all_backup_data%%'); if(res){this.form.elements['wipe'].value = 1; } return res;" />
<table cellpadding="2" cellspacing="2" border="1">
<tbody>
<tr>
    <td style="text-align: center; font-weight: bold;">DB TABLES</td>
</tr>
##db_rows##
<tr>
    <td style="text-align: center; font-weight: bold;">FS</td>
</tr>
##fs_rows##
<tr>
    <td style="text-align: center; font-weight: bold;">TPL</td>
</tr>
##tpl_rows##
</tbody>
</table>
"-->

<!--#set var="data_row" value="
<tr><td>##path##</td></tr>
"-->

<!--#set var="wipe_all_backup_data_result" value="
%%tables_deleted%%: ##tables_deleted##<br />
%%files_deleted%%: ##files_deleted##<br />
%%tpls_deleted%%: ##tpls_deleted##<br />
"-->
