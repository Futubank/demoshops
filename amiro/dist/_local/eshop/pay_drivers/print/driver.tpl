<!--#set var="settings_form" value="
    <input type="hidden" name="url" value="###_null_###submitter_link###_null_###">
    <input type="hidden" name="all_data" value="1">
    <input type="hidden" name="hidden_name" value="action">
    <input type="hidden" name="print_value" value="print">
    <input type="hidden" name="process_value" value="process">
    <tr>
        <td>%%payservice_tpl%%:</td>
        <td><input type="text" name="payservice_tpl" class="field" value="##payservice_tpl##" size="40"></td>
    </tr>
"-->

<!--#set var="checkout_form" value="
    <form name="paymentformprint" action="##process_url##" method="post">
    <input type="hidden" name="order" value="##order##">
    ##hiddens##
    ##if(_button_html=="1")##
    ##button##
    ##else##
    <input type="submit" name="sbmt" class="btn" value="      ##button_name##      " ##disabled##>
    ##endif##
    </form>
    ##if(_BILL_AUTO_REDIRECT=="1")##
    <script type="text/javascript">
            document.forms.paymentformprint.submit();
    </script>
    ##endif##
"-->

<!--#set var="pay_form" value="
    <form name="paymentform" action="##url##" method="post">
    <input type="hidden" name="item_number" value="##order##">
    <input type="hidden" name="status" value="ok">
    <input type="hidden" name="##hidden_name##" value="##process_value##">
    ##hiddens##
    <input type="submit" name="sbmt" class="btn" value="      ##print_button_name##      " onclick="return openPrintVersion();">
    <input type="submit" name="sbmt" class="btn" value="      ##button_name##      " onclick="return onNextClick();">
    </form>

    <script type="text/javascript">
      function openPrintVersion() {

        document.forms.paymentform.elements["##hidden_name##"].value = "##print_value##";
        document.forms.paymentform.target = '_blank';
        document.forms.paymentform.submit();
        return true;
      }

      function onNextClick() {
        document.forms.paymentform.target = '_self';
        document.forms.paymentform.elements["##hidden_name##"].value = "##process_value##";
        return true;
      }
    </script>
"-->
