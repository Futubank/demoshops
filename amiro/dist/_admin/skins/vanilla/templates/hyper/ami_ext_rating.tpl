##--system info: module_owner="" module="" system="1"--##

<!--#set var="ext_rate_count_column" value="<center>##ext_rate_count##</center>"-->
<!--#set var="ext_rate_rate_column" value="<center>##ext_rate_rate##</center>"-->

<!--#set var="section_ext_rating_values" value="
<tr>
    <td colspan="2">
    <table class="tab_screen" width="100%" style="margin-top:16px;">
    ##section_html##
    </table>

    <script type="text/javascript">
AMI.Message.addListener(
    'ON_FORM_FIELD_VALIDATE',
    function(oParameters){
        if(oParameters.oField.disabled){
            return true;
        }
        theVal = parseFloat(oParameters.oField.value);
        if (theVal < 1.00000 || theVal > 5.00000 || !theVal) {
            oParameters.message = "%%rating_warn%%";
            oParameters.error = true;
            return false;
        }
        return true;
    }
);
        function disableExtRatingFields(obj){
            if(obj.checked){
                AMI.find('#ext_rate_rate').disabled = false;
                AMI.find('#ext_rate_count').disabled = false;
            }else{
                AMI.find('#ext_rate_rate').disabled = true;
                AMI.find('#ext_rate_count').disabled = true;
            }
        }

        function checkInteger(theID){

           errFunc = checkInteger;

           theVal = document.getElementById(theID).value;

            for (i = 0; i < theVal.length; i++)
            {
                var c = theVal.charAt(i);
                if (((c < "0") || (c > "9"))) {
             alert('%%integer_warn%%');
             document.getElementById(theID).focus();
             return false;
            }
            }

            return true;
        }

        disableExtRatingFields(AMI.find('#rate_rewrite'));
    </script>

    </td>
</tr>
"-->

<!--#set var="checkbox_field(name=rewrite_ratings)" value="
<tr>
    <td width="40" align="right">
        <input type="checkbox" id="rate_rewrite" onclick="disableExtRatingFields(this);" value="1"##checked## class="##filter_class##" helpId="form_##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
    </td>
    <td>
        <label for="rate_rewrite">
            %%form_field_##caption##%%##IF(validator_filled)##*##ENDIF##
        </label>
    </td>
"-->

<!--#set var="input_field(name=ext_rate_rate)" value="
    <td align="right">%%form_field_##caption##%%##IF(validator_filled)##*##ENDIF##:</td>
    <td><input type="text" id="ext_rate_rate" name="##name##" class="field field6##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## /></td>
</tr>
"-->

<!--#set var="input_field(name=ext_rate_count)" value="
    <td align="right">%%form_field_##caption##%%##IF(validator_filled)##*##ENDIF##:</td>
    <td><input type="text" id="ext_rate_count" name="##name##" onBlur="checkInteger(this.id);" class="field field6##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## /></td>
"-->

<!--#set var="checkbox_field(name=allow_ratings)" value="
<tr><td colspan="6">&nbsp;</td></tr>
<tr>
    <td width="40" align="right">
        <input type="checkbox" id="cb_##name##" name="##name##" onclick="disableExtRatingFields(this);" value="1"##checked## class="##filter_class##" helpId="form_##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
    </td>
    <td>
        <label for="cb_##name##">
            %%form_field_##caption##%%##IF(validator_filled)##*##ENDIF##
        </label>
    </td>
"-->

<!--#set var="checkbox_field(name=display_ratings)" value="
    <td align="right">
        <input type="checkbox" id="cb_##name##" name="##name##" onclick="disableExtRatingFields(this);" value="1"##checked## class="##filter_class##" helpId="form_##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
    </td>
    <td>
        <label for="cb_##name##">
            %%form_field_##caption##%%##IF(validator_filled)##*##ENDIF##
        </label>
    </td>
    <td colspan="2"></td>
</tr>
"-->

<!--#set var="checkbox_field(name=sort_by_ratings)" value="
<tr>
    <td width="40" align="right">
        <input type="checkbox" id="cb_##name##" name="##name##" onclick="disableExtRatingFields(this);" value="1"##checked## class="##filter_class##" helpId="form_##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
    </td>
    <td>
        <label for="cb_##name##">
            %%form_field_##caption##%%##IF(validator_filled)##*##ENDIF##
        </label>
    </td>
"-->

<!--#set var="checkbox_field(name=display_votes)" value="
    <td align="right">
        <input type="checkbox" id="cb_##name##" name="##name##" onclick="disableExtRatingFields(this);" value="1"##checked## class="##filter_class##" helpId="form_##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
    </td>
    <td>
        <label for="cb_##name##">
            %%form_field_##caption##%%##IF(validator_filled)##*##ENDIF##
        </label>
    </td>
    <td colspan="2"></td>
</tr>
"-->