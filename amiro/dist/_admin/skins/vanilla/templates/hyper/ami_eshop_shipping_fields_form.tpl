##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="hint_field" value="
<tr><td colspan=3><div class="tooltip">##element_caption##</div></td></tr>
"-->

<!--#set var="hint_field(name=buttons_hint)" value="
<tr><td colspan=2>&nbsp;</td></tr>
<tr><td colspan=3><div class="tooltip">##element_caption##</div></td></tr>
"-->

<!--#set var="javascript" value="
function openModulesTemplates(mod_id, template_id, popup_title){
    openDialog(popup_title, 'engine.php?mod_id=' + mod_id + '&mode=popup&form_only=1&modname=eshop.eshop_order&id=' + template_id, '');
}
"-->

<!--#set var="popup_button_field" value="
<tr  style="display: none;"><td colspan=2>&nbsp;</td></tr>
<tr>
    <td width="50%">##element_caption##:&nbsp;</td>
    <td>
    <a class="text_link_button" href="#" onClick="if(##disabled##){alert('%%form_field_buttons_hint%%');}else{openModulesTemplates('##popup_module##', '##template_id##', '##popup_title##');} return false;">%%btn_title%%&raquo;</a>&nbsp;&nbsp;##if(disabled!='1')##<font class="meta_import_block" onmouseover="AMI.find('#popup-tooltip-##btn_type##').style.display = 'block'" onmouseout="AMI.find('#popup-tooltip-##btn_type##').style.display = 'none'">?</font>
    <span style="display: none;" class="popup-tooltip" id="popup-tooltip-##btn_type##">%%popup_tooltip_##btn_type##%% ##template_info##</span>##endif##</td>
</tr>
"-->
