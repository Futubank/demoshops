##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/srv_tags.lng"%%
%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/_buttons.lng"%%
%%include_language "templates/lang/_common_items.lng"%%
%%include_language "templates/lang/_common_msgs.lng"%%
%%include_language "templates/lang/_menu_all.lng"%%
%%include_template "templates/_icons.tpl"%%

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
<td width="80%">##tag##&nbsp;</td>
<td width="10%" align="center">##count##&nbsp;</td>
<td width="100">##action_edit####action_del##&nbsp;</td>
</tr>
"-->

<!--#set var="list_body" value="

<script>
<!--
var _cms_document_form = 'group_operations_form';
var _cms_script_link = '##script_link##?';
//-->
</script>


##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
##_positions_data##
<form name="group_operations_form">
	<table width="100%" border="0" cellspacing="0" cellpadding="4">
		<tr>
			##_group_operations_header##
			<td class="first_row_all list_name_col" align="center" valign="middle">
				%%tag%%
				##sort_tag##
			</td>
			<td class="first_row_all" align="center">
				%%count%%
				##sort_count##
			</td>
			<td class="first_row_all" width=100>
				%%actions%%
			</td>
		</tr>
		##list##
	</table>
	##_group_operations_footer##
<div><br><input type="button" name="reindex" value="  %%recount_btn%%  " class="but-mid" OnClick="javascript:openExtDialog('%%recount%%', '##script_link##?action=repair', 0, 0, 550, 330, -1, -1, 0, 1); document.location.reload();"></div></form>


<a name="anchor"></a>
"-->