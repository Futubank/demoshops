##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="input_field(att=tax_field)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td><input type="text" name="##name##" class="field##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## /></td>
</tr>
"-->

<!--#set var="input_field(name=tax_rate)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td><input type="text" name="##name##" class="field##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
"-->

<!--#set var="select_field(name=tax_type)" value="
    <select name="##name##"##attributes##>##select##</select></td>
</tr>
"-->

<!--#set var="section_tax_rate_fields" value="##section_html##"-->

<!--#set var="input_field(form_mode=show)" value="
<tr>
    <td colspan=2>%%tax_classes_us_desc%%</td>
</tr>
"-->
