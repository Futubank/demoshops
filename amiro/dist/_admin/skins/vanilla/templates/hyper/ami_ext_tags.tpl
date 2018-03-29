##--system info: module_owner="" module="" system="1"--##

<!--#set var="ext_tags_field" value="
<tr>
    <td width="80">%%form_field_ext_tags%%:</td>
    <td align="left">
        <input type="text" name="tags" class="field field50" id="srv_tags" value="##ext_tags##"  autocomplete="off">          
        <a href="javascript:void(0);" onClick="openDialog('%%select_tags%%', 'srv_tags.php?popup=1&form='+_cms_document_form+'&tags='+document.getElementById('srv_tags').value);return false;"><img id="img_tags" title="%%select%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" align="absmiddle" class=icon /></a>
        <script type="text/javascript">
            var suggestSrvTags = new amiSuggestions('srv_tags', 'tags', ',');
        </script>
    </td>
</tr>
"-->