##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%
%%include_language "templates/lang/modules/_form.lng"%%

<!--#set var="form_buttons" value="<iframe name=ami_service_frame id=ami_service_frame style="display:none" src=""></iframe>"-->

<!--#set var="input_field(name=time)" value="
<tr>
    <td>##element_caption##:</td>
    <td id="curdate"></td>
</tr>
"-->

<!--#set var="input_field(name=server_time)" value="
<tr>
    <td>##element_caption##:</td>
    <td>##value##</td>
</tr>
<tr>
    <td colspan=2><br></td>
</tr>
"-->

<!--#set var="input_field(name=drop_user_cookie_data)" value="
<script type="text/javascript">
function dropUserCookieData(){
    AMI.Page.Status.clearMessages();
    AMI.Page.Status.hide();
    var ifrm = document.getElementById('ami_service_frame');
    ifrm.src = adminBaseURL + 'start.php?drop_user_cookie_data=1';
    ifrm.onload=function(){
        AMI.Page.Status.messages.push({text: '%%status_user_cookie_dropped%%', type: ''});
        AMI.Page.Status.display();
	var oComponent = AMI.Page.getComponent('ami_service_0');
	oComponent.loadForm(false);
    };
    return false;
}
</script>
<tr><td colspan="2"><br /></td></tr>
<tr>
    <td style="padding: 0 5px;">##element_caption## (##value##) </td>
    <td valign="middle">
        <button onclick="if(confirm('%%confirm_delete_cookies%%')){dropUserCookieData();}return false;">%%drop_user_cookie_data%%</button>
    </td>
</tr>
"-->

<!--#set var="input_field(name=delete_generated)" value="
<tr><td colspan="2"><br /></td></tr>
<tr>
    <td style="padding: 0 5px;">##element_caption## (##value##)</td>
    <td valign="middle">
        <button onclick="if(confirm('%%confirm_delete_generated%%')){doServiceAction('delete_generated');var oComponent = AMI.Page.getComponent('ami_service_0');oComponent.loadForm(false);}return false;">%%delete_generated%%</button>&nbsp;
    </td>
</tr>
##--<tr><td colspan="2"><br></td></tr>--##
"-->

<!--#set var="input_field(name=repair)" value="
<tr>
    <td style="padding: 0 5px;">
        %%module%%:
        <select id="taget_mod_id" name="taget_mod_id" disabled="disabled" title="%%wait_for_download%%">
            <option value="">---</option>
        </select><br />
        %%action%%:
        <select id="target_action" name="target_action" disabled="disabled" title="%%wait_for_download%%">
        </select>
    </td>
    <td valign="middle">
        <button id="do_action" disabled="disabled" onclick="return doRepairAction(this.form);" title="%%wait_for_download%%" class="button-disabled">%%do%%</button>&nbsp;
    </td>
</tr>
"-->

<!--#set var="input_field(name=delete_demo_content)" value="
<tr><td colspan="2"><br /></td></tr>
<tr><td colspan="2"><div class="tooltip" style="margin-left: 10px;">%%tooltip_delete_demo_content%%</div></td></tr>
<tr>
    <td colspan="2" align="center">
        <button class="but-long" onclick="if(confirm('%%confirm_delete_demo_content%%')){doServiceAction('delete_demo_content');var oComponent = AMI.Page.getComponent('ami_service_0');oComponent.loadForm(false);}return false;">##element_caption##</button>
    </td>
</tr>
<tr><td colspan="2"><br /></td></tr>
"-->

<!--#set var="input_field(name=delete_demo_content)" value="
<tr><td colspan="2"><br /></td></tr>
<tr><td colspan="2"><div class="tooltip" style="margin-left: 10px;">%%tooltip_delete_demo_content%%</div></td></tr>
<tr>
    <td colspan="2" align="center">
        <button class="but-long" onclick="if(confirm('%%confirm_delete_demo_content%%')){doServiceAction('delete_demo_content');var oComponent = AMI.Page.getComponent('ami_service_0');oComponent.loadForm(false);}return false;">##element_caption##</button>
    </td>
</tr>
<tr><td colspan="2"><br /></td></tr>
"-->

<!--#set var="input_field(name=options_data)" value="
<tr>
    <td colspan="2">&nbsp;<b><a href="engine.php?mod_id=options_data">##element_caption## &raquo;</a></b></td>
</tr>
##--<tr><td colspan="2"><br></td></tr>--##
"-->

<!--#set var="input_field(name=cache_size)" value="
<script type="text/javascript">
function changeCacheMaxSize(){
    var val = "|spl_system_config|cache_storage_size";
    openExtDialog(srvOptionsPopupTitle, 'srv_options.php?flt_mode=simple&flt_owner=system&flt_module=common_settings' + '&_mt=1382939789' + '&_rv=' + top.rights_version + '&_mtloc=' + top._mtloc + '&_cv=' + top.cms_version + '#' + val, 1, 1 );
    return true;
}
</script>
##--<tr><td colspan="2"><br></td></tr>--##
<tr>
    <td colspan="2">&nbsp;##element_caption##: ##value##
"-->

<!--#set var="input_field(name=cache_size_link)" value="
<b><a title="##element_caption##" href="#" onclick="changeCacheMaxSize();return false;">[##value## Mb&raquo;]</a></b></td>
</tr>
"-->

<!--#set var="input_field(name=cache_pages)" value="
##--<tr><td colspan="2"><br></td></tr>--##
<tr>
    <td colspan="2">&nbsp;##element_caption##: ##value##</td>
</tr>
"-->

<!--#set var="input_field(name=cache_size_info)" value="
##--<tr><td colspan="2"><br></td></tr>--##
<tr>
    <td colspan="2">&nbsp;##element_caption##: ##value##</td>
</tr>
"-->

<!--#set var="input_field(name=cache_l3_size)" value="
##--<tr><td colspan="2"><br><br></td></tr>--##
<tr>
    <td colspan="2">&nbsp;##element_caption##: ##value##</td>
</tr>
"-->

<!--#set var="input_field(name=cache_l3_pages)" value="
##--<tr><td colspan="2"><br></td></tr>--##
<tr>
    <td colspan="2">&nbsp;##element_caption##: ##value##</td>
</tr>
"-->

<!--#set var="input_field(name=cache_l3_size_info)" value="
##--<tr><td colspan="2"><br></td></tr>--##
<tr>
    <td colspan="2">&nbsp;##element_caption##: ##value##</td>
</tr>
"-->

<!--#set var="input_field(name=cache_truncate)" value="
##--<tr><td colspan="2"><br><br></td></tr>--##
<tr>
    <td colspan="2">&nbsp;<button onclick="if(confirm('%%cache_truncate%%')){doServiceAction('cache_truncate');var oComponent = AMI.Page.getComponent('ami_service_0');oComponent.loadForm(false);}return false;">##element_caption##</button></td>
</tr>
##--<tr><td colspan="2"><br></td></tr>--##
"-->

<!--#set var="javascript" value="
function getCurDate(){
    var oDate = new Date();
    var year = oDate.getFullYear();
    var month = oDate.getMonth() + 1;
    var day = oDate.getDate();
	var hour = oDate.getHours();
	var min = oDate.getMinutes();
	var sec = oDate.getSeconds();
	var timestr = oDate.toTimeString().split(' ');
	var timezone = timestr[1];

	month = month < 10 ? '0' + month : month;
	day   = day   < 10 ? '0' + day   : day;
	hour   = hour   < 10 ? '0' + hour   : hour;
	min   = min   < 10 ? '0' + min   : min;
	sec   = sec   < 10 ? '0' + sec   : sec;
	var curDate = '##date_format##';
	curDate = curDate.replace(/Y/, year);
	curDate = curDate.replace(/m/, month);
	curDate = curDate.replace(/d/, day);
	curDate = curDate.replace(/H/, hour);
	curDate = curDate.replace(/i/, min);
	curDate = curDate.replace(/s/, sec);
	curDate = curDate.replace(/e/, timezone);
	return curDate;
}

AMI.Message.addListener(
    'ON_COMPONENT_CONTENT_PLACED',
    function(oComponent){
        if(oComponent.componentType == 'form'){
			document.getElementById('curdate').innerHTML = getCurDate();
        }
        return true;
    },
    true
);
"-->
