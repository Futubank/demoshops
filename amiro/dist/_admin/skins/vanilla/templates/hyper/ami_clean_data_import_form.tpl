##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%
%%include_language "templates/lang/modules/_form.lng"%%

<!--#set var="hint_field(caption=no_destination_modules)" value="
<tr><td colspan=3><div class="tooltip">%%no_destination_modules%%</div></td></tr>
"-->


<!--#set var="select_field(name=driver_name)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td><select name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## onChange="showDriverFields();" id="driver_name">##select##</select>##hint##</td>
</tr>
"-->

<!--#set var="checkbox_field(name=allow_duplicate)" value="
<tr>
    <td colspan="2">
        <label>
            <input type="checkbox" id="cb_##name##" name="##name##" value="1"##checked## class="##filter_class## ##classes##" helpId="form_##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
            ##element_caption####IF(validator_filled)##*##ENDIF##
        </label>
    </td>
</tr>
"-->
