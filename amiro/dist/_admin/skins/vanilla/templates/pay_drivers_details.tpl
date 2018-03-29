%%include_template "templates/_common_form_fields.tpl"%%
%%include_language "templates/lang/pay_drivers.lng"%%

<!--#set var="header_row" value="
<tr><td>##language##</td><td><input type=text class=field name="header_##lang##" value="##value##"></td></tr>
"-->

<!--#set var="currency_row" value="<option value="##name##" ##selected##>##name##"-->

<script type="text/javascript">
    var editor_enable = '##editor_enable##';
    var _cms_document_form = 'pay_drivers_form';
    var _cms_document_form_changed = false;
    var _cms_script_link = '##script_link##?';
    var _cms_form_changed_alert = "%%form_changed%%";

    function CheckForm(form) {
        return true;
    }
</script>


<br>
<form action=##script_link## method=post enctype="multipart/form-data" name="pay_drivers_form" onSubmit="return CheckForm(this);">
    ##form_common_hidden_fields##
    ##filter_hidden_fields##
    <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
        <tr>
            <td>%%header%%:</td>
            <td>##header##</td>
        </tr>
        <tr>
            <td>%%driver_id%%:</td>
            <td>##name##</td>
        </tr>
        ##IF(author)##
        <tr>
            <td>%%driver_author%%:</td>
            <td>##author##</td>
        </tr>
        ##ENDIF##
        <tr><td colspan="2"><hr /></td></tr>
        <tr>
            <td>%%fee_percent%%:</td>
            <td><input type="text" name="fee_percent" class="field field20" value="##fee_percent##"></td>
        </tr>
        <tr>
            <td>%%fee_const%%:</td>
            <td><input type="text" name="fee_const" class="field field20" value="##fee_const##"></td>
        </tr>
        <tr>
            <td>%%fee_curr%%:</td>
            <td>
                <select name="fee_curr">
                    ##fee_currencies##
                </select>
                ##--<input type="text" name="fee_curr" class="field field20" value="##fee_curr##">--##
            </td>
        </tr>
        ##driver_form##
        ##IF(driver_description)##
        <tr>
            <td colspan="2"><hr /></td>
        </tr>
        <tr>
            <td colspan="2">##driver_description##</td>
        </tr>
        ##ENDIF##
        <tr>
            <td colspan="2" align="right">
                <br>
                <input type="submit" name="check" value="%%apply_btn%%" class="but" onClick="this.form.action.value = 'save';">
                <input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none', '');">
            </td>
        </tr>
    </table>
</form>
