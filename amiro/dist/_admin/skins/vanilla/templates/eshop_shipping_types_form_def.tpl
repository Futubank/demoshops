<!--#set var="option_row_prev" value="
<option value="##id##"##selected##>##name##</option>
"-->

<!--#set var="option_row" value="
<tr><td vAlign="top"><input id="l_shipping_methods_##id##" type="checkbox" name="shipping_methods[]" value="##id##"##selected##></td><td><label for="l_shipping_methods_##id##">##name##</label></td></tr>
"-->

<script type="text/javascript">
var _cms_document_form = 'form';
var _cms_script_link = '##script_link##?';

function CheckForm(form)
{
    errFunc = CheckForm;

    if (form.name.value.length < 1) {
        alert('%%warn_missing_name%%');
        form.name.focus();
        return false;
    }

    var shippingMethods = document.getElementsByName('shipping_methods[]');
    for (var i = 0 ; i < shippingMethods.length ; i++) {
        if (shippingMethods[i].checked) {
            return true;
        }
    }
    alert('%%warn_missing_shipping_methods%%');
    return false;
}

</script>

<br>
<form action="##script_link##" method="post" enctype="multipart/form-data" name="form" onSubmit="return CheckForm(this);">
##form_common_hidden_fields##
##filter_hidden_fields##
<table cellSpacing="5" cellPadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
<tr>
    <td>%%name%%*:</td>
    <td><input type="text" name="name" class="field field50" value="##name##"  maxlength="255" /></td>
 </tr>
<tr>
    <td valign="top">%%shipping_methods%%*:</td>
    <td>
        <div style="border:1px solid #c6c3c6;overflow-y:auto;padding:0px;margin:0px;width:273px;height:200px;">
        <table>
        ##shipping_methods##
        </table>
        </div>
    </td>
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

##if(_APPLIED_ID)##
<script>
var destForm = top.document.forms['eshop_form'];
if (destForm.id_shipping_type.value == ##_APPLIED_ID##) {
    fireEvent2(destForm.id_shipping_type, 'change', top.document);
}
</script>
##endif##
