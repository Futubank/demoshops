<!--#set var="settings_form" value="
<input type="hidden" name="url" value="###_null_###submitter_link###_null_###">
"-->

<!--#set var="checkout_form" value="
    <form name="paymentformstub" action="##process_url##" method="post">
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
    <form name="paymentform" action="##url##" method="post">
    <input type="hidden" name="item_number" value="##order##">
    <input type="hidden" name="status" value="ok">
    ##hiddens##
    </form>
    <script type="text/javascript">
            document.paymentform.submit();
    </script>
"-->
