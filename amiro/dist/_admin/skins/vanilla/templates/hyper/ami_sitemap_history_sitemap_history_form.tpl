##--system info: module_owner="" module="" system="1"--##
##-- %%include_template "templates/modules/_form.tpl"%% --##

<!--#set var="section_form" value="
##IF(section_html)##
<script type="text/javascript">
##scripts##

var
    _cms_document_form = 'ami_form_##_component_id##',
    _cms_document_form_changed = false;

</script>

<div id="div_properties_form" class="main-form">
	<table ccc="1" border="0" cellpadding="0" cellspacing="0" ##if(width != '')##width="##width##"##endif## ##if(height != '')##height="##height##"##endif## style="margin-left:auto;margin-right:auto;">
		<tr>
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
<table cellspacing="5" cellpadding="0" border="0" class="frm" width="100%">
<col width="150">
<col width="*">
##section_html##
</table>

<table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
<col width="150">
<col width="*">
<tr>
<td colspan="2" align="right">
<br>
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
##else##
##endif##
"-->

<!--#set var="input_field(form_mode=show)" value="
##IF(name == 'sitemap_file')##
##IF(value)##
<tr>
    <td>##element_caption##:&nbsp;</td>

    <td><b><a href='##file_url##' target="_blank">##value##&raquo;</a></b></td>
</tr>
##else##
##endif##
##elseif(name == 'useragent')##
##IF(value)##
<tr>
    <td>##element_caption##:&nbsp;</td>
    <td>##value##</td>
</tr>
##else##
##endif##
##elseif(name == 'login')##
##IF(value)##
<tr>
    <td>##element_caption##:&nbsp;</td>
    <td>##value##</td>
</tr>
##else##
##endif##
##else##
<tr>
    <td>##element_caption##:&nbsp;</td>
    <td>##IF(name == 'action' || name == 'status')##%%##value##%%##else####value####endif##</td>
</tr>
##endif##
"-->