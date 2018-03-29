##--system info: module_owner="" module="" system="1"--##

<!--#set var="ext_relations_field" value="
<tr>
    <td width="80">%%form_field_ext_relations%%:</td>
    <td align="left">
        <a href="javascript:void(0);" onClick="##if(id)##openExtDialog('%%relations_list%%', 'engine.php?mod_id=relations&mode=popup&itemId=##id##&moduleId=##_mod_id##', 1);##else##alert('%%warn_apply_item%%');##endif##return false;"><img title="%%relations_edit_list%%" class="icon" src="skins/vanilla/icons/icon-dicget-many.gif" helpId="btn_relations" align="absmiddle" /></a> <font style="font-size:9px">[%%relations_number%%:<input name="relations_number" type="text" value="##relations_number##" readonly class="counter">]</font>
    </td>
</tr>
"-->
