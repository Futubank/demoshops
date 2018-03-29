##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="form_buttons" value=""-->

<!--#set var="export_csv_field" value="
<script type="text/javascript">
AMI.Message.addListener(
    'ON_COMPONENT_CONTENT_RECEIVED',
    function(oComponent, oData){
        if(oComponent.componentType == 'form' && typeof(oData.data) == 'string'){
            oData.content = oData.data;
            // delete oData.data;
        }
        return true;
    }
);
</script>
<tr>
    <td>I.&nbsp;</td>
    <td width=85%>##element_caption##:&nbsp;<a class="text_link_button" href="#" onClick="window.open('subs_list.php?action=export&lang_data=##value##'); return false;">%%export_to_csv%%&raquo;</a></td>
    <td width=15%></td>
</tr>
"-->

<!--#set var="export_unisender_field" value="
    ##--
<tr>
    <td colspan=3><br>&nbsp;</td>
</tr>
--##
<tr>
    <td>II.&nbsp;</td>
    <td colspan=2>##element_caption##</td>
</tr>
##--
<tr>
    <td colspan=3>&nbsp;</td>
</tr>
--##
<tr>
    <td>&nbsp;</td>
    <td colspan=2><b>%%export_to_unisender_settings%%:</b></td>
</tr>
"-->

<!--#set var="input_field(name=unisender_api_key)" value="
<tr>
    <td>&nbsp;</td>
    <td>##element_caption##*:&nbsp;<input type="text" name="##name##" class="field field50##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## /></td>
    <td></td>
</tr>
"-->

<!--#set var="checkbox_field" value="
<tr>
    <td colspan=3>&nbsp;</td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td>
        <label>
            <input type="checkbox" id="cb_##name##" name="##name##" value="1"##checked## class="##filter_class##" helpId="form_##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
            ##element_caption####IF(validator_filled)##*##ENDIF##
        </label>
    </td>
    <td></td>
</tr>
"-->

<!--#set var="unisender_list_open_field" value="
<tr>
    <td colspan=3>&nbsp;</td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td>%%unisender_lists%%</td>
    <td></td>
</tr>
<tr>
    <td colspan=3>&nbsp;</td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td><table>
"-->

<!--#set var="select_field" value="
<tr>
    <td>##caption##:</td>
    <td><select name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##select##</select></td>
</tr>
"-->

<!--#set var="select_field(name=subs_topics)" value="
<tr>
    <td colspan=3>&nbsp;</td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td>##element_caption##:</td>
    <td></td>
</tr>
<tr>
    <td colspan=3>&nbsp;</td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td><table><tr><td><select multiple="multiple" size=7 id="##name##" name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##select##</select></td>
"-->

<!--#set var="select_field(name=unisender_export_list)" value="
    <td style="vertical-align:middle">--&gt; <select id="##name##" name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##select##</select></td></tr></table></td>
    <td></td>
</tr>
"-->

<!--#set var="unisender_list_close_field" value="
</table></td>
<td></td>
</tr>
"-->

<!--#set var="unisender_save_settings_field" value="<tr><td></td><td align=right><input type="submit" value="%%save_btn%%" class="but" onclick="this.form.elements['ami_full'].value = 1;this.form.action.value='add'"##attributes## /></td><td></td></tr>
"-->

<!--#set var="unisender_export_field" value="
<script type="text/javascript">
function checkExportParams(){
    if(!document.getElementById('subs_topics').value){
        document.getElementById('subs_topics').focus();
        alert('%%export_subs_topics_empty%%');
        return false;
    }
    if(!document.getElementById('unisender_export_list').value){
        document.getElementById('unisender_export_list').focus();
        alert('%%export_unisender_list_empty%%');
        return false;
    }
    return true;
}
</script>
<tr><td></td><td align=right><input type="submit" value="%%export_btn%%" class="but" onclick="if(!checkExportParams()){return false;}this.form.elements['ami_full'].value = 1;this.form.action.value='export'"##attributes## /></td><td></td></tr>
"-->

<!--#set var="message_field" value="
<tr>
    <td>&nbsp;</td>
    <td><br>&nbsp;<b>##element_caption## ##value##</b></td>
    <td></td>
</tr>
"-->

<!--#set var="export_to_unisender_field" value="
<tr>
    <td colspan=3>&nbsp;</td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td colspan=2><b>%%export_to_unisender%%:</b></td>
</tr>
"-->
