%%include_language "templates/lang/srv_host_payments_history.lng"%%
%%include_language "templates/lang/_srv_host_payments_history_msgs.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="invoice_item" value="
<option value='##id##'>##client_name## &bull; ##doc_num## %%from%% ##invoice_date## &bull; ##amount_str## (##domain##)</option>
"-->

<!--#set var="invoice_data_item" value="
        aInvoiceData[##id##] = Array();
  aInvoiceData[##id##][0] = '##domain##';
        aInvoiceData[##id##][1] = '##amount##';
        aInvoiceData[##id##][2] = '##payment_type##';
        aInvoiceData[##id##][3] = '##id_contractor##';
"-->

<!--#set var="properties_item" value="
<option value="##id##" ##selected##>##name##</option>
"-->

<!--#set var="view_fields" value="
##IF(invoice_num!="")##
   <tr>
     <td>
     %%by_invoice%%:
     </td>
       <td>
       ##invoice_num## %%from%% ##invoice_date##
     </td>
   </tr>
##ENDIF##
##IF(contractor_name!="")##
   <tr>
     <td>
     %%contractor%%:
     </td>
       <td>
       ##contractor_name##
     </td>
   </tr>
##ENDIF##
   <tr>
     <td>
     %%domain%%:
     </td>
       <td>
       ##domain##
     </td>
   </tr>
   <tr>
     <td>
     %%date%%:
     </td>
       <td>
       ##date##
     </td>
   </tr>
   <tr>
     <td>
     %%amount%%:
     </td>
       <td>
       ##amount##
     </td>
   </tr>
   <tr>
     <td>
     %%rate%%:
     </td>
       <td>
       ##rate##
     </td>
   </tr>
   <tr>
     <td>
     %%payment_type%%:
     </td>
       <td>
                         ##subtype_name##
     </td>
   </tr>
   <tr>
     <td>
     %%payment_num%%:
     </td>
       <td>
       ##payment_num##
     </td>
   </tr>
   <tr>
     <td>
     %%note%%:
     </td>
       <td>
         ##note##
     </td>
   </tr>
##IF (USER=='admin')##
   <tr>
     <td>
     %%hidden_note%%:
     </td>
       <td>
         ##hidden_note##
     </td>
   </tr>
##ENDIF##
"-->



<!--#set var="add_fields" value="
   <tr>
     <td>
     %%payment_code%%:
     </td>
       <td>
       <input type="text" name="payment_code" class="field" value="##payment_code##" oninput="insetPaymentData(this.value)" onfocus="this.select()" size=64>
     </td>
   </tr>
   <tr>
     <td>
     %%by_invoice%%:
     </td>
       <td>
       <select name="id_bill" onchange='setInvoice(this.value)'>
                         <option value='0'>%%no%%</option>
                         ##invoice_items##
                         </select>
     </td>
   </tr>
   <tr>
     <td>
     %%contractor%%:
     </td>
       <td>
                        <select name=id_contractor>
                        ##properties_items##
                        </select>
     </td>
   </tr>
   <tr>
     <td>
     %%domain%%*:
     </td>
       <td>
       <input type="text" name="domain" class="field field28" value="##domain##" >
     </td>
   </tr>
   <tr>
     <td>
     %%date%%*:
     </td>
       <td>
        <input type="text" name="date" class="field fieldDate" value="##date##">
     </td>
   </tr>
   <tr>
     <td>
     %%amount%%*:
     </td>
       <td>
       <input type="text" name="amount" class="field fieldDate field10" value="##amount##" >
     </td>
   </tr>
   <tr>
     <td>
     %%rate%%(*):
     </td>
       <td>
       <input type="text" name="rate" class="field field10" value="##rate##" >
     </td>
   </tr>
   <tr>
     <td>
     %%payment_type%%:
     </td>
       <td>

<script type="text/javascript">

subtypes = new Array(2);
subvalues = new Array(2);
subtypes['invoice'] = new Array('%%type_unknown%%','%%type_bank%%','%%type_card%%',
    '%%type_webmoney%%','%%type_yandex%%','%%type_qiwi%%','%%type_paypal%%','%%type_euroset%%','%%type_terminals%%','%%type_inner%%','%%type_prepaidcard%%','%%type_bonus%%');
subvalues['invoice'] = new Array(0, 1, 3, 4, 5, 10, 11, 6, 7, 8, 9, 99);
subtypes['charge'] = new Array('%%type_unknown%%','%%type_hosting%%','%%type_traffic%%');
subvalues['charge'] = new Array(0,101,102);

    function subTypes() {
        var ptype = document.forms.payform.payment_type.options[document.forms.payform.payment_type.selectedIndex].value;
        var len = document.forms.payform.payment_subtype.options.length-1;
        var i;
        for(i=len; i>=0; i--)
            document.forms.payform.payment_subtype.options[i] = null;
        for(i=0; i<subtypes[ptype].length; i++) {
            var opt = new Option(subtypes[ptype][i],subvalues[ptype][i],false,false);
            document.forms.payform.payment_subtype.options[i] = opt;
        }
    }

    function LocalBodyOnLoad() {
        subTypes();
        var i;
        for(i=0; i<document.forms.payform.payment_subtype.options.length; i++)
            if(document.forms.payform.payment_subtype.options[i].value=='##subtype##')
                document.forms.payform.payment_subtype.selectedIndex = i;
    }

</script>

<select name="payment_type" onchange="subTypes()">
<option value="invoice" ##invoice##>%%invoice%%</option>
<option value="charge" ##charge##>%%charge%%</option>
</select>

<select name="payment_subtype">
</select>
     </td>
   </tr>
   <tr>
     <td>
     %%payment_num%%:
     </td>
       <td>
       <input type="text" name="payment_num" class="field" value="##payment_num##">
     </td>
   </tr>
   <tr>
     <td>
     %%note%%:
     </td>
       <td>
         <textarea name="note" class="field" cols=40 rows=5>##note##</textarea>
     </td>
   </tr>
   <tr>
     <td>
     %%hidden_note%%:
     </td>
       <td>
         <textarea name="hidden_note" class="field" cols=40 rows=5>##hidden_note##</textarea>
     </td>
   </tr>
"-->




<!--#set var="edit_fields" value="
   <tr>
     <td>
     %%payment_code%%:
     </td>
       <td>
       <input type="text" name="payment_code" class="field" value="##payment_code##" oninput="insetPaymentData(this.value)" onfocus="this.select()" size=64>
     </td>
   </tr>
##IF(invoice_num!="")##
   <tr>
     <td>
     %%by_invoice%%:
     </td>
       <td>
       ##invoice_num## %%from%% ##invoice_date##
       <input type="hidden" name="id_bill" value="##id_bill##">
     </td>
   </tr>
##ENDIF##
##IF(contractor_name!="")##
   <tr>
     <td>
     %%contractor%%:
     </td>
       <td>
       ##contractor_name##
       <input type="hidden" name="id_contractor" value="##contractor_id##">
     </td>
   </tr>
##ENDIF##
   <tr>
     <td>
     %%domain%%*:
     </td>
       <td>
       ##domain##
     </td>
   </tr>
   <tr>
     <td>
     %%date%%*:
     </td>
       <td>
        <input type="text" name="date" class="field" value="##date##">
     </td>
   </tr>
   <tr>
     <td>
     %%amount%%*:
     </td>
       <td>
       <input type="text" name="amount" class="field field10" value="##amount##" >
     </td>
   </tr>
   <tr>
     <td>
     %%rate%%:
     </td>
       <td>
       ##rate##
       <input type="hidden" name="rate" value="##rate##">
     </td>
   </tr>
   <tr>
     <td>
     %%payment_type%%:
     </td>
       <td>
       <input type="hidden" name="payment_subtype" value="##subtype##">
                         ##subtype_name##
     </td>
   </tr>
   <tr>
     <td>
     %%payment_num%%:
     </td>
       <td>
       <input type="text" name="payment_num" class="field" value="##payment_num##">
     </td>
   </tr>
   <tr>
     <td>
     %%note%%:
     </td>
       <td>
         <textarea name="note" class="field" cols=40 rows=5>##note##</textarea>
     </td>
   </tr>
   <tr>
     <td>
     %%hidden_note%%:
     </td>
       <td>
         <textarea name="hidden_note" class="field" cols=40 rows=5>##hidden_note##</textarea>
     </td>
   </tr>
"-->


<script type="text/javascript">
<!--
    var editor_enable = '##editor_enable##';
    var _cms_document_form = 'payform';
    var _cms_document_form_changed = false;
    var _cms_script_link = '##script_link##?';

    var Base64 = {
        // private property
        _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
        // public method for encoding
        encode: function (input) {
            var output = "";
            var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
            var i = 0;

            input = Base64._utf8_encode(input);

            while (i < input.length) {

                chr1 = input.charCodeAt(i++);
                chr2 = input.charCodeAt(i++);
                chr3 = input.charCodeAt(i++);

                enc1 = chr1 >> 2;
                enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
                enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
                enc4 = chr3 & 63;

                if (isNaN(chr2)) {
                    enc3 = enc4 = 64;
                } else if (isNaN(chr3)) {
                    enc4 = 64;
                }

                output = output +
                        this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
                        this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);

            }

            return output;
        },
        // public method for decoding
        decode: function (input) {
            var output = "";
            var chr1, chr2, chr3;
            var enc1, enc2, enc3, enc4;
            var i = 0;

            input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

            while (i < input.length) {

                enc1 = this._keyStr.indexOf(input.charAt(i++));
                enc2 = this._keyStr.indexOf(input.charAt(i++));
                enc3 = this._keyStr.indexOf(input.charAt(i++));
                enc4 = this._keyStr.indexOf(input.charAt(i++));

                chr1 = (enc1 << 2) | (enc2 >> 4);
                chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
                chr3 = ((enc3 & 3) << 6) | enc4;

                output = output + String.fromCharCode(chr1);

                if (enc3 != 64) {
                    output = output + String.fromCharCode(chr2);
                }
                if (enc4 != 64) {
                    output = output + String.fromCharCode(chr3);
                }

            }

            output = Base64._utf8_decode(output);

            return output;

        },
        // private method for UTF-8 encoding
        _utf8_encode: function (string) {
            string = string.replace(/\r\n/g, "\n");
            var utftext = "";

            for (var n = 0; n < string.length; n++) {

                var c = string.charCodeAt(n);

                if (c < 128) {
                    utftext += String.fromCharCode(c);
                }
                else if ((c > 127) && (c < 2048)) {
                    utftext += String.fromCharCode((c >> 6) | 192);
                    utftext += String.fromCharCode((c & 63) | 128);
                }
                else {
                    utftext += String.fromCharCode((c >> 12) | 224);
                    utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                    utftext += String.fromCharCode((c & 63) | 128);
                }

            }

            return utftext;
        },
        // private method for UTF-8 decoding
        _utf8_decode: function (utftext) {
            var string = "";
            var i = 0;
            var c = c1 = c2 = 0;

            while (i < utftext.length) {

                c = utftext.charCodeAt(i);

                if (c < 128) {
                    string += String.fromCharCode(c);
                    i++;
                }
                else if ((c > 191) && (c < 224)) {
                    c2 = utftext.charCodeAt(i + 1);
                    string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                    i += 2;
                }
                else {
                    c2 = utftext.charCodeAt(i + 1);
                    c3 = utftext.charCodeAt(i + 2);
                    string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                    i += 3;
                }

            }

            return string;
        }

    }


    function insetPaymentData(data) {
        if (data.length > 0) {
            var oPayment;
            var oForm = document.forms[_cms_document_form];
            eval('var oPayment = ' + Base64.decode(data));

            if (!oPayment['id']) {
                return;
            }

            oForm['id_bill'].selectedIndex = 0;
            oForm['domain'].value = '';
            oForm['amount'].value = '';
            oForm['payment_subtype'].selectedIbdex = 0;
            oForm['hidden_note'].value = '';

            if (oPayment['doc_num']) {
                for (i = 0; i < oForm['id_bill'].options.length; i++) {
                    if (oForm['id_bill'].options[i].innerHTML.search(oPayment['doc_num']) > 0) {
                        oForm['id_bill'].selectedIndex = i;
                        invoceId = oForm['id_bill'].options[i].value;
                        if (oPayment['lic_domain'] > '' && aInvoiceData[invoceId][0] > '' && (aInvoiceData[invoceId][0] != oPayment['lic_domain'])) {
                            alert('%%error_payment_code_domain%%');
                            return false;
                        }
                        if (oForm['amount'].value > '' && (aInvoiceData[invoceId][1] != oPayment['amount'])) {
                            alert('%%error_payment_code_amount%%');
                        }
                        setInvoice(oForm['id_bill'].options[i].value);
                    }
                }
            }

            if (oPayment['lic_domain'] != '') {
                oForm['domain'].value = oPayment['lic_domain'];
            }
            oForm['amount'].value = oPayment['amount'];
            oForm['payment_subtype'].value = oPayment['type'];
            oForm['hidden_note'].value = oPayment['note'];

        }
    }

    function _validate(re, field, msg) {
        if (re.test(field.value))
            return true;
        alert(msg);
        field.focus();
        return false;
    }

    function isValidDomain(field, msg) {

        var re = /^[0-9a-zA-Z\-]+(\.[0-9a-zA-Z\-]+)+$/;
        return _validate(re, field, msg);
    }


    function isValidFloat(field, msg) {

        var re = /^\d+(\.\d*)?$/;
        return _validate(re, field, msg);
    }

    function isValidDate(field, msg) {

        var re = /^\d{1,2}\.\d{1,2}\.\d{4} \d{1,2}:\d{1,2}:\d{1,2}$/;
        if (re.test(field.value))
            return true;
        re = /^\d{1,2}\/\d{1,2}\/\d{4} \d{1,2}:\d{1,2}:\d{1,2}$/;
        if (re.test(field.value))
            return true;

        alert(msg);
        field.focus();
        return false;
    }

    function CheckForm(form) {

        if (typeof (form.domain) == 'object' && !isValidDomain(form.domain, '%%invalid_domain%%'))
            return false;

        if (typeof (form.date) == 'object' && !isValidDate(form.date, '%%invalid_date%%'))
            return false;

        if (!isValidFloat(form.amount, '%%amount_warn%%'))
            return false;

        if (form.payment_subtype.value != 2 && form.payment_num.value.length == 0) {
            form.payment_num.focus();
            alert('%%doc_num_warn%%');
            return false;
        }

        return true;
    }


    var aInvoiceData = Array();
    aInvoiceData[0] = Array();
    aInvoiceData[0][0] = '##domain##';
    aInvoiceData[0][1] = '';
    aInvoiceData[0][2] = '0';
    aInvoiceData[0][3] = '##default_id_contractor##';
    ##invoice_data_items##

            function setInvoice(id) {
                document.forms[_cms_document_form].elements['domain'].value = aInvoiceData[id][0];
                document.forms[_cms_document_form].elements['amount'].value = aInvoiceData[id][1];
                document.forms[_cms_document_form].elements['payment_subtype'].value = aInvoiceData[id][2];
                document.forms[_cms_document_form].elements['id_contractor'].value = aInvoiceData[id][3];
            }

    --></script>

<form action=##script_link## method=post enctype="multipart/form-data" name="payform" onSubmit="return CheckForm(window.document.forms.payform);">
    <input type="hidden" name="id" value="##id##">
    <input type="hidden" name="type">
    <input type="hidden" name="action" value="##action##">
    <input type="hidden" name="ga_id" value="">
    ##--<input type="hidden" name="payment_type" value="">--##
    <input type="hidden" name="client_type" value="">
    ##filter_hidden_fields##

    <table cellspacing="5" cellpadding="0" border="0" class="frm">
        <col width="150">
        <col width="*">



        ##fields##

        ##if(action=="apply" || action=="add")##
        <tr>
            <td colspan="2" align="right">
                <br>
                ##form_buttons##
            </td>
        </tr>
        ##endif##
    </table>
</form>
