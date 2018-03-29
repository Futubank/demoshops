<!--#set var="settings_form" value="
    <tr>
        <td>%%url%%:</td>
        <td><input type="text" name="url" class="field" value="##url##" size="40"></td>
    </tr>
    <tr>
        <td>%%pass_phrase%%:</td>
        <td><input type="text" name="pass_phrase" class="field" value="##pass_phrase##" size="40"></td>
    </tr>
    <tr>
        <td>%%merchant_id%%:</td>
        <td><input type="text" name="merchant_id" class="field" value="##merchant_id##" size="40"></td>
    </tr>
    <tr>
        <td>%%merchant_idz%%:</td>
        <td><input type="text" name="merchant_idz" class="field" value="##merchant_idz##" size="40"></td>
    </tr>
    <tr>
        <td>%%merchant_idr%%:</td>
        <td><input type="text" name="merchant_idr" class="field" value="##merchant_idr##" size="40"></td>
    </tr>
    <tr>
        <td>%%merchant_ide%%:</td>
        <td><input type="text" name="merchant_ide" class="field" value="##merchant_ide##" size="40"></td>
    </tr>
"-->

<!--#set var="checkout_form" value="
    <form name="paymentformwm" action="##process_url##" method="POST">
    <input type="hidden" name="paywhere" value="1">
    <input type="hidden" name="merchant_id" value="##merchant_id##">
    <input type="hidden" name="amount" value="##amount##">
    <input type="hidden" name="description" value="##description##">
    <input type="hidden" name="order" value="##order##">
    ##hiddens##
    ##if(_button_html=="1")##
    ##button##
    ##else##
    <input type="submit" name="sbmt" class="btn" value="      ##button_name##      " ##disabled##>
    ##endif##
    </form>
"-->

<!--#set var="pay_form" value="
    ##setvar @n_return = preg_replace('/http:\/\/([^\/]*).*item_number=([0-9]*)/i', 'http://$1/pages.php?action=process&status=ok&item_number=$2', return)##
    ##setvar @n_cancel = preg_replace('/http:\/\/([^\/]*).*item_number=([0-9]*)/i', 'http://$1/pages.php?action=process&status=fail&item_number=$2', cancel)##
    <form name="paymentform" action="##url##" method="POST">
    <input type="hidden" name="LMI_PAYMENT_AMOUNT" value="##amount##">
    <input type="hidden" name="LMI_PAYMENT_DESC" value="##description##">
    <input type="hidden" name="LMI_PAYMENT_DESC_BASE64" value="##description_base64##">
    <input type="hidden" name="LMI_PAYMENT_NO" value="##order##">
    <input type="hidden" name="LMI_PAYEE_PURSE" value="##merchant_id##">
    <input type="hidden" name="LMI_SIM_MODE" value="##test_mode##">
##--
    <input type="hidden" name="LMI_SUCCESS_URL" value="##return##">
    <input type="hidden" name="LMI_FAIL_URL" value="##cancel##">
--##
    <input type="hidden" name="LMI_SUCCESS_URL" value="##n_return##">
    <input type="hidden" name="LMI_FAIL_URL" value="##n_cancel##">
    <input type="hidden" name="LMI_RESULT_URL" value="##callback##">
    <input type="hidden" name="item_number" value="##order##">
    ##hiddens##
    </form>
    <script type="text/javascript">
            document.forms.paymentform.submit();
    </script>
"-->
