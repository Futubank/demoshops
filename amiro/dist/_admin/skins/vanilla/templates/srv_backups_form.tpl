##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/srv_backups.lng"%%
%%include_template "templates/_progress.tpl"%%


<!--#set var="bk_item" value="
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox"
    name="bk_item" value="##itemcode##" ##disabled##>&nbsp;##itemname##&nbsp;##newsize##<br>
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'bkform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "";


function dloadFile(url) {
    dont_show_request_progress = 2;
    location.href = url;
}

function CheckForm(form) {

    var el = form.elements;
    var set = false;
    for(var i=0; i<el.length; i++)
        if(el[i].type=='checkbox' && el[i].name=='bk_item' && el[i].checked) {
            set = true;
            form.item_id.value += el[i].value+'|';
        }

    if(!set)
        alert('%%items_not_set%%');
    return set;
}

function startBackup(form) {
    if(!CheckForm(form))
        return false;

    var bakUrl = location.href;
    openExtDialog('%%progress_title%%', form, 0, 0, 400, 250, -1, -1, 0, 1, function(){location.href = bakUrl}, null, onCloseConfirm);
}

function startRestore(id) {
    var form = document.restForm;
    form.id.value = id;
    openExtDialog('%%progress_title%%', form, 0, 0, 400, 250, -1, -1, 0, 1, null, null, onCloseConfirm);
}

function startDistrib(id) {
    var form = document.distribForm;
    var bakUrl = location.href;
    openExtDialog('%%progress_title%%', form, 0, 0, 400, 250, -1, -1, 0, 1, function(){location.href = bakUrl}, null, onCloseConfirm);
}

function runImport() {

    var form = document.importForm;

    if(form.archname.value=='') {
        alert('%%enter_arch_file_name%%');
        form.archname.focus();
        return false;
    }
    form.submit();
}


function archFormShow(id) {
    var ids = ['af_archive','af_distrib','af_import'];
    for(var i=0; i<3; i++) {
        var div = document.getElementById(ids[i]);
        if(div!=null)
            div.style.display = ids[i]==id ? 'inline' : 'none';
    }
    return false;
}
-->
</script>


  <br>

    <form name="aTypeForm">
        <input type="radio" id="c_af_archive" name="atype" onclick="archFormShow('af_archive')" checked><label for="c_af_archive">%%new_archive%%</label><br><br>
##if(ALLOW_ARCH_IMPORT==1)##
        <input type="radio" id="c_af_import" name="atype" onclick="archFormShow('af_import')"><label for="c_af_import">%%import_archive%%</label><br><br>
##endif##
##if(ALLOW_CREATE_DISTRIB==1)##
        <input type="radio" id="c_af_distrib" name="atype" onclick="archFormShow('af_distrib')"><label for="c_af_distrib">%%create_distrib%%</label><br>
##endif##
    </form>

    <br><br><br>

    </form>
    <form name="restForm" action="##script_link##" method="POST">
    <input type="hidden" name="action" value="restore">
    <input type="hidden" name="id">
    </form>

    <div id="af_archive" style="display:inline">
    <form name="bkform" action="##script_link##" method="POST">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type='hidden' name='item_id' value=''>

     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td valign="top" style="white-space: nowrap;"><b>%%new_archive%%</b></td><td></td>
     </tr>
	 <tr><td colspan="2">
	<div class=tooltip style="width:300px">%%disk_space_warn%%</div>
	</td></tr>
	##if(quota !== 0)##
	 <tr><td colspan="2">
	<div class=tooltip style="width:300px##if(quota_low != '')##;background-color:#FF8080##endif##">%%disk_space_available%% ##quota## Mb
	##if(quota_low != '')##
	<br><br>%%disk_space_low%%
	##endif##
	</div>
	</td></tr>
	##endif##
     <tr>
       <td valign=top nowrap>%%what_to_backup%%:</td>
       <td>##bk_items##</td>
     </tr>
     <tr>
       <td colspan=2>%%description%%:<br><br>
            <textarea name="description" cols="60" rows="8" class="field"></textarea>
       </td>
     </tr>
	 <tr><td colspan="2"><br><br>
	<div class=tooltip style="width:300px">%%front_lock_hint%%</div>
	</td></tr>
	 <tr><td colspan="2">
	<input type="checkbox" name="skip_front_lock" value="1">&nbsp;&nbsp;%%disable_front_lock%%
	</td></tr>
     <tr>
        <td colspan="2" align="right">
        <br>
        <input type="button" class="but-mid" value="%%srv_backups_add%%"
            onclick="startBackup(bkform);return false;">
        <br><br>
        </td>
     </tr>
     </table>
     </form>
     </div>

##if(ALLOW_ARCH_IMPORT==1)##
    <div id="af_import" style="display:none">
     <form name="importForm" action="##script_link##" method="POST">
        <input type="hidden" name="action" value="import_arch">
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td valign=top colspan="2"><b>%%import_archive%%</b></td>
     </tr>
	 <tr><td colspan="2">
	<div class=tooltip style="width:300px">%%import_hint%% ##arch_upload_dir##</div>
	</td></tr>
     <tr>
       <td colspan="2" valign="top"><br></td>
     </tr>
     <tr>
       <td valign="top"><nobr>%%filename%%:</nobr></td>
       <td align="right"><input type="text" class="field field40" name="archname" ></td>
     </tr>
     <tr>
       <td colspan="2" align="right">
       <input type="button" class="but-mid" value="%%do_import%%" onclick="runImport()"></td>
     </tr>
    </table>
    </form>
    </div>
##endif##

##if(ALLOW_CREATE_DISTRIB==1)##
    <div id="af_distrib" style="display:none">
     <form name="distribForm" action="##script_link##" method="POST">
        <input type="hidden" name="action" value="create_distr">
     <table cellspacing="0" cellpadding="0" border="0" class="frm form_distrib_create" width="100%">
	<col width="150">
	<col width="*">
     <tr>
       <td valign="top"><b>%%create_distrib%%</b></td>
     </tr>
	 <tr><td>
	<div class=tooltip style="width:300px">%%distrib_hint%%</div>
	<input type="checkbox" name="skip_existing_backups" value="1" checked>&nbsp;&nbsp;%%skip_existing_backups%%
	</td></tr>
	##if(quota !== 0)##
	 <tr><td>
	<div class=tooltip style="width:300px##if(quota_low_d != '')##;background-color:#FF8080##endif##">%%disk_space_available%% ##quota## Mb
	<br>%%disk_space_req%% ##distr_size## Mb
	##if(quota_low_d != '')##
	<br><br>%%disk_space_low%%
	##endif##
	</div>
	</td></tr>
	##endif##
     <tr>
       <td valign="top"><br></td>
     </tr>
     <tr>
       <td>%%description%%:<br><br>
            <textarea name="description" cols="60" rows="8" class="field"></textarea>
       </td>
     </tr>
	 <tr><td><br><br>
	<div class=tooltip style="width:300px">%%front_lock_hint%%</div>
	</td></tr>
	 <tr><td>
	<input type="checkbox" name="skip_front_lock" value="1">&nbsp;&nbsp;%%disable_front_lock%%
	</td></tr>
     <tr>
       <td align="right">
       <input type="button" class="but-mid" value="%%create%%" onclick="startDistrib()"></td>
     </tr>
    </table>
    </form>
    </div>
##endif##
