##--system info: module_owner="services" module="private_messages" system="1"--##
%%include_language "templates/lang/modules/_form.lng"%%
%%include_template "templates/modules/_form.tpl"%%

##-- form { --##

<!--#set var="hidden_field" value="
    <input name="##name##" value="##value##" type="hidden"##attributes## />
    ##if(name == 'id_recipient')##
    <tr>
        <td>##element_caption##:</td>
        <td>##if(msg_is_admin)##%%username_admin%%##else####if(username)##<b>##username##</b>##endif####endif##</td>
    </tr>
    ##endif##
"-->

<!--#set var="section_form" value="
<script type="text/javascript">
AMI.Message.removeListener('ON_AMI_LIST_SHOW_ADD_BUTTON');
</script>

##if(msg_id)##
<script type="text/javascript">
    var oRow = AMI.find("TR[data-ami-row-id=##msg_id##]");
    if(oRow != null){
        AMI.removeClass(oRow[0], "not_read");
    }

    window.markMessageAsUnread = function(messageId){
        var moduleId = 'private_messages';
        var oList = AMI.Page.aModules[moduleId].getComponentsByType('list')[0];
        oList.skipEditor = 1;
        AMI.Page.doModuleAction(moduleId, oList, 'list_unread', {id:messageId, ami_full:1, calc_found_rows:1});
    }

##scripts##

var
    _cms_document_form = 'ami_form_##_component_id##',
    _cms_document_form_changed = false;

</script>

<div id="div_properties_form" class="main-form">
	<table class="main-form__table properties_form_table" ccc="1" border="0" cellpadding="0" cellspacing="0" ##if(width != '')##width="##width##"##endif## ##if(height != '')##height="##height##"##endif## style="margin-left:auto;margin-right:auto;">
		<tr class="properties_form_title">
			<td align=left id="add_left_top_img"></td>
			<td nowrap id="add_center_top_img">
				<span id="form_title" class="form-header">##header##</span>
			</td>
			<td nowrap id="add_right_info_top_img">
				<div id=stModified style="display:none;" class=form-header> [ %%modified%% ]</div>
			</td>
			<td id="add_right_top_img"></td>
		</tr>
		<tr>
			<td id="add_left_center_img"></td>
			<td colspan=2 class="table_sticker" valign="top">
<br>
<form data-ami-component-id="##_component_id##" id="ami_form_##_component_id##" class="form" action="##action##" method="post" enctype="multipart/form-data" name="##_mod_id##form" onsubmit="AMI.Page.doModuleAction('##_mod_id##', '##_component_id##', 'form_save', this); return false;">
<input type="hidden" name="action" value="" />
<input type="hidden" name="ami_full" value="" />
<table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
<col width="150">
<col width="*">
<tr>
    <td width="90">%%caption_date%%:</td>
    <td>##msg_datetime##</td>
</tr>
<tr>
    <td>%%caption_sender%%:</td>
    <td>##if(msg_is_admin)##%%username_admin%%##else####msg_sender####endif##</td>
</tr>
<tr>
    <td>%%caption_recipient%%:</td>
    <td>##msg_recipient##</td>
</tr>
<tr>
    <td>%%caption_header%%:</td>
    <td style="font-weight:bold;">##msg_header##</td>
</tr>
<tr id="padding_edit_messages"><td></td></td>

<script type="text/javascript">
##if(is_broadcast)##
##else##
AMI.Message.addListener(
    'ON_SCRIPT_LOAD',
    function(componentId){
        if(componentId == '##_component_id##'){
            document.getElementById('amiroTEdDivEditor').innerHTML = '';
            var txtEd = new amiroTEdit('txtEd', new amiDictionary({}));
            txtEd.allowedImages = ['internal_links', 'external_links', 'upload'];
            txtEd.createEditor(600, 250, 'previewMessage', '##msg_body##', true, 'amiroTEdDivPreview', 'amiroTEdDivEditor');
            txtEd.setMode('preview');
            txtEd.editorObj.style.display = 'none';
            document.getElementById('amiroTEdPureDiv').style.display = 'none';
            document.getElementById('amiroTEdDivEditor').style.display = 'none';
        }
        return true;
    }
);
</script>
##endif##

<script type="text/javascript" data-ami-component-id="##_component_id##" src="##bbEditorURL##"></script>

<tr>
    <td colspan="2" id="edit_block_messages">
	##if(is_broadcast)##
        <div id="amiroTEdDivPreview" style="width:100%;height:100%;overflow:auto;margin:3px;">##msg_body_raw##</div>
	##else##
        <div id="amiroTEdDivPreview" style="width:100%;height:100%;overflow:auto;margin:3px;display:none"></div>
        <div id="amiroTEdDivEditor"></div>
	##endif##
    </td>
</tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
<col width="150">
<col width="*">
<tr>
<td colspan="2" align="right">
<br>
<div id="form-buttons">
##if(inbox)##<input type="button" class="but-long" value="%%form_pm_unread%%" onclick="markMessageAsUnread(##msg_id##);">##endif##
<input type="button" class="but" value="%%form_pm_delete%%" onclick="AMI.Page.doModuleAction('##_mod_id##', AMI.Page.aModules['##_mod_id##'].getComponentsByType('list')[0], 'list_delete', {id:'##msg_id##', ami_full:1});">
</div>
<br><br>
</td>
</tr>
<tr>
<td colspan="2">
 <!-- <sub>%%required_fields%%</sub> -->
</td>
</tr>
</table>
</form>
			</td>
			<td id="add_right_center_img"></td>
		</tr>
		<tr>
			<td id="add_left_bot_img"></td>
			<td id="add_center_bot_img" colspan=2></td>
			<td id="add_right_bot_img"></td>
		</tr>
	</table>
</div>
##endif##
"-->

##-- } form --##