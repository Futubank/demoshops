<!--#set var="name_to_apply_price" value="names.push('##name##');
"-->


<script>
var _cms_document_form = 'shippingRegionsForm';
var _cms_form_changed_alert = "%%form_changed%%";
var _cms_script_link = '##script_link##?';
var _cms_document_form_changed = false;

function checkForm(form)
{
    errFunc = checkForm;

    if (form.name.value.length < 1) {
        alert('%%warn_missing_name%%');
        form.name.focus();
        return false;
    }
    if (form.price.value.length < 1) {
        alert('%%warn_missing_price%%');
        form.name.focus();
        return false;
    }

    var oOptions = top.document.getElementById('regions').options;
    var ids = new Array ();
    if (oOptions.length > 0) {
        for (var i = 0 ; i < oOptions.length ; i++) {
            ids.push(oOptions[i].value);
        }
        document.forms[_cms_document_form].elements['ids_from_list'].value = ids.join(',');
    }

    return true;
}

</script>


<a name="pureForm"></a>
<br>
<form action="##script_link##" method="post" enctype="multipart/form-data" name="shippingRegionsForm" onSubmit="return checkForm(this);">
##form_common_hidden_fields##
##filter_hidden_fields##
<input type="hidden" name="grpPrice" value="" />
<input type="hidden" name="listIndex" value="##listIndex##" />
<table cellSpacing="5" cellPadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
<tr>
    <td>%%name%%*:</td>
    <td><input type="text" name="name" class="field field64" value="##name##"  maxlength="64" /></td>
</tr>
<tr>
    <td>%%price%%*:</td>
    <td><input type="text" name="price" class="field field64" value="##price##"  maxlength="255" /></td>
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

<script>
##if(FORM_MODE=="EDIT")##
if (document.forms[_cms_document_form].name.value.length > 0) {
    var oOptions = top.document.getElementById('regions').options;
    for (var i = 0 ; i < oOptions.length ; i++) {
        if (oOptions[i].value == ##editId##) {
            var prices = top.document.getElementById('prices').value.split('|');
            document.forms[_cms_document_form].price.value = prices[i];
            break;
        }
    }
}
##endif##
</script>
