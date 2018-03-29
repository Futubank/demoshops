##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/srv_updates.lng"%%
%%include_language "templates/lang/_srv_updates_msgs.lng"%%
%%include_template "templates/_progress.tpl"%%



<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'updform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "";

/*
function CheckForm(form) {

    form.elements['action'].value = 'run';
    form.elements['type'].value = 'getlist';
    return true;
}
*/

function startOp(id,op,form) {

    if (op == 'checknewup') {
	alert('%%get_full_updates_list_help%%');
    }
	if(typeof(form)!='object')
		form = document.opForm;
    var bakUrl = location.href;
    form.id.value = id;
    form.action.value = op;
    openExtDialog('%%progress_title%%', form, 0, 0, 400, 300, -1, -1, 0, 1, function(){location.href = bakUrl}, null, onCloseConfirm);
}

-->
</script>


<!--#set var="ver_info" value="
##if(rows)##
    <table border="0" id="upd-list" width="100%" cellpadding="0" cellspacing="0">
    <tr>
        <td class="first_row_all" colspan="2">%%prod_name%%</td>
        <td class="first_row_all">%%required_version%%</td>
        <td class="first_row_all">%%current_version%%</td>
        <td class="first_row_all">%%updated_version%%</td>
    </tr>
    ##rows##
    </table>
    <br>
##endif##
"-->

<!--#set var="ver_info_row" value="
    <tr>
        <td class="row2" rowspan="4" valign="center">##prod_name##</td>
        <td class="row2">%%code%%</td>
        <td align="right" class="row2">##code_req##</td>
        <td align="right" class="row2">##code_current##</td>
        <td align="right" class="row2">##code_updated##</td>
    </tr>
    <tr>
        <td class="row2">%%db%%</td>
        <td align="right" class="row2">##db_req##</td>
        <td align="right" class="row2">##db_current##</td>
        <td align="right" class="row2">##db_updated##</td>
    </tr>
    <tr>
        <td class="row2">MySQL</td>
        <td align="right" class="row2">##mysql_req##</td>
        <td align="right" class="row2">##mysql_current##</td>
        <td align="right" class="row2"></td>
    </tr>
    <tr>
        <td class="row2">PHP</td>
        <td align="right" class="row2">##php_req##</td>
        <td align="right" class="row2">##php_current##</td>
        <td align="right" class="row2"></td>
    </tr>
"-->

<!--#set var="ver_invalid" value="
    <span style="color:red">##version##</span>
"-->

  <br>
    <form id="updform" action=##script_link## method=post name="updform">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type="hidden" name="type">
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
##if(ACTION=='view')##
     <tr>
         <td colspan="2"><b>##description##</b><br><br>%%release_date_row%%: ##release_date##</td>
     </tr>
     <tr>
         <td colspan="2">
            <div class="upd-status-install">
                ##if(install_date == '-')##
                <span style="color: red; font-size: 13px;"><b>%%inst_none%%</b></div>
                ##else##
                <span style="color: green; font-size: 13px;"><b>%%inst_ok%% ##install_date##</b></div>
                ##endif##
            </div>
         </td>
     </tr>
     <tr>
         <td colspan="2">
            <div class="upd-full-description">##full_description##</div>
         </td>
     </tr>
     <tr>
        <td>##if(link)##<br><a class="upd-detailed_description" href=##link## target="_blank">%%detailed_description%%</a>##endif##<br><br></td>
     </tr>
     <tr>
         <td>##ver_info##</td>
     </tr>
     <tr>
         <td colspan="2" align="center">
         <input type="button" class="but" value="%%close_btn%%" onclick="document.location.href='srv_updates.php';"></td>
     </tr>
##else##
     <tr><td valign='top' align='left' style="text-align: left;">
        <script>
            function get_updates() {
                getUpdates = document.getElementById('status-block');
                if(getUpdates.style.display == 'none') {
                   AMI.$(getUpdates).fadeIn(300);
                } else {
                    AMI.$(getUpdates).fadeIn().fadeOut().fadeIn().fadeOut().fadeIn();
                }
            }
        </script>
		##if(updates_valid_till)##
		<div class=tooltip style="width:300px##if(updates_low != '')##;background-color:#FFAAAA##endif##">%%updates_available_till%% ##updates_valid_till##</div><br>
		##endif##
		<b>%%update_list%%</b><br><br>
		<label><input type="radio" name="uplistOpt" value="forceDL" checked>&nbsp;%%download_updates_list%%</label><br>
		<label><input type="radio" name="uplistOpt" value="useLocal" ##local_uplist_disabled##>&nbsp;%%use_local_updates_list%%</label><br><br>
##--
		<b>%%update_files%%</b><br>
		<input type="radio" name="upfilesOpt" value="forceDL">&nbsp;%%download_update_files%%<br>
		<input type="radio" name="upfilesOpt" value="useLocal" checked>&nbsp;%%use_local_update_files%%<br><br>
--##
		<center>
		<input type="button" value="%%get_updates_list%%" class="but-long" onclick="startOp('','checknew',document.updform)">
		##if(free_version == '1')##
		<br>
		<input type="button" value="%%get_full_updates_list%%" class="but-long" onclick="startOp('','checknewup',document.updform)">
		##endif##
		</center>
	 </td></tr>
##endif##
     </table>
    </form>

    <form name="opForm" action="##script_link##" method="POST">
    <input type="hidden" name="action">
    <input type="hidden" name="id">
    </form>
