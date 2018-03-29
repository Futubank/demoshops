%%include_language "templates/lang/ext_relations.lng"%%

<tr>
    <td>%%relations%%:</td>
    <td>
        <a href="javascript:void(0);" onClick="##if(id)##openExtDialog('%%relations_list%%', 'relations.php?popup=1&objectId=##id##&objectModule=##module##', 1);##else##alert('%%warn_apply_item%%');##endif##return false;"><img title="%%relations_edit_list%%" class="icon" src="skins/vanilla/icons/icon-dicget-many.gif" helpId="btn_relations" align="absmiddle" /></a> <font style="font-size:9px">[%%relations_number%%:<input name="relations_number" type="text" value="##relations_number##" readonly class="counter">]</font>
    </td>
</tr>