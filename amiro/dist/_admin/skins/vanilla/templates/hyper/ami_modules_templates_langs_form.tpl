##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/hyper/ami_modules_templates_templates_form.tpl"%%

<!--#set var="input_field(name=header)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td><input type="text" name="##name##" class="field field50##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## /><b>.lng</b></td>
</tr>
"-->