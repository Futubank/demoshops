<!--#set var="settings_form" value="
<script type="text/javascript">
function setDriverSettings(mode){
    var
        settings = {
            test: {
                drv_request_url: 'https://api-3t.sandbox.paypal.com/nvp',
                drv_payment_url: 'https://www.sandbox.paypal.com/cgi-bin/webscr'
            },
            real: {
                drv_request_url: 'https://api-3t.paypal.com/nvp',
                drv_payment_url: 'https://www.paypal.com/cgi-bin/webscr'
            }
        },
        diffConfirm = '',
        paramsCount = 0;

    for(var name in settings[mode]){
        var oField = $('[name=' + name + ']');

        if(
            ('' !== oField.val()) &&
            (settings[mode][name] !== oField.val())
        ){
            diffConfirm +=
                (0 === paramsCount ? '' : ', ') +
                oField.parent().prev().html().replace(/\*\:$/, '');
            paramsCount++;
        }
    }

    if('' !== diffConfirm){
        diffConfirm =
            '%%parameters_will_be_set%%: ' + diffConfirm + ', %%continue%%?';
        if(!confirm(diffConfirm)){
            return;
        }
    }

    for(name in settings[mode]){
        $('[name=' + name + ']').val(settings[mode][name]);
    }
}
</script>

<tr>
    <td colspan="2"><hr /></td>
</tr>
<tr>
    <td colspan="2" style="text-align: center; padding-bottom: 2px;">
        <span class="text_button" onclick="setDriverSettings('test');">%%test_settings%%</span>&nbsp;
        &nbsp;<span class="text_button" onclick="setDriverSettings('real');">%%real_settings%%</span>
    </td>
</tr>
<tr>
    <td>%%drv_request_url%%*:</td>
    <td><input type="text" name="drv_request_url" class="field" value="##drv_request_url##" size="40" /></td>
</tr>
<tr>
    <td>%%drv_payment_url%%*:</td>
    <td><input type="text" name="drv_payment_url" class="field" value="##drv_payment_url##" size="40" /></td>
</tr>
<tr>
    <td>%%drv_login%%*:</td>
    <td><input type="text" name="drv_login" class="field" value="##drv_login##" size="40" /></td>
</tr>
<tr>
    <td>%%drv_password%%*:</td>
    <td><input type="text" name="drv_password" class="field" value="##drv_password##" size="40" /></td>
</tr>
<tr>
    <td>%%drv_signature%%*:</td>
    <td><input type="text" name="drv_signature" class="field" value="##drv_signature##" size="40" /></td>
</tr>
<tr>
    <td>%%drv_country_code%%:</td>
    <td><input type="text" name="drv_country_code" class="field" value="##drv_country_code##" size="40" /></td>
</tr>
<tr>
    <td colspan="2"><div class="tooltip">%%drv_country_code_toolip%%</div></td>
</tr>
<tr>
    <td>%%drv_site_logo%%:</td>
    <td><input type="text" name="drv_site_logo" class="field" value="##drv_site_logo##" size="40" /></td>
</tr>
<tr>
    <td>%%drv_site_color%%:</td>
    <td><input type="text" name="drv_site_color" class="field" value="##drv_site_color##" size="6" /></td>
</tr>
"-->

<!--#set var="checkout_form" value="
<form name="111paymentform##billing_driver##" action="##process_url##" method="post">
##hiddens##
</form>
"-->

<!--#set var="pay_form" value="
<script type="text/javascript">
location.href = '##drv_payment_url##';
</script>
"-->
