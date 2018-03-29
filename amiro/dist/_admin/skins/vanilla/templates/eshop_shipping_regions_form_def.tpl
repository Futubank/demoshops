<script type="text/javascript">
var _cms_document_form = 'shippingRegionsForm';
var _cms_form_changed_alert = "%%form_changed%%";
var _cms_script_link = '##script_link##?';
var _cms_document_form_changed = false;

function checkForm(form)
{
    errFunc = checkForm;

return true;////

    if (form.name.value.length < 1) {
        alert('%%warn_missing_name%%');
        form.name.focus();
        return false;
    }

    return true;
}

</script>


<a name="pureForm"></a>
<br>
<form action="##script_link##" method="post" enctype="multipart/form-data" name="shippingRegionsForm" onSubmit="return checkForm(this);">
##form_common_hidden_fields##
##filter_hidden_fields##
<table cellSpacing="5" cellPadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
<tr>
    <td>%%name%%*:</td>
    <td><input type="text" name="name" class="field field64" value="##name##"  maxlength="64" /></td>
</tr>
<tr>
    <td colSpan="2" align="right">
        <br />
        ##form_buttons##
        <br/><br/>
    </td>
</tr>
<tr>
    <td colSpan="2"><sub>%%required_fields%%</sub></td>
</tr>
</table>
</form>
