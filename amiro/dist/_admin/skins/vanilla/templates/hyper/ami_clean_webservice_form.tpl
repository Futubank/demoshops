##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="input_field(name=id_user)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td>
        <div style="display:none;"><input name="##name##" id="id_user" value="##value##" ##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##></div>
        <input type="hidden" name="audit_current_owner" id="audit_current_owner" value="">
        <input type="hidden" name="audit_new_owner" id="audit_new_owner" value="" onchange="setTimeout(function(){AMI.$('#id_user').val(AMI.$('#audit_new_owner').val());},10);">
        <div id="audit_text_owner" style="display: inline;">
            <input name="audit_owner_name" id="audit_owner_name" type="text" readonly="" class="field" maxlength="30" helpid="audit_owner_name" value="%%user_not_set%%" title="" style="width:150px;background:transparent;border:0px;">
        </div>
        <a href="javascript:void(0);" onclick="openExtDialog('%%select_user%%', 'members_popup.php?owner_id='+encodeURIComponent(document.getElementById('audit_current_owner').value), 1); return false;"><img title="%%select_user_title%%" border="0" src="skins/vanilla/icons/icon_small_users.gif" helpid="audit_members_popup" align="absmiddle" class="icon"></a>
    </td>
</tr>
"-->