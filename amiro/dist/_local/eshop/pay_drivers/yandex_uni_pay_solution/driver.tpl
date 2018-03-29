%%include_language "_local/eshop/pay_drivers/yandex_uni_pay_solution/driver.lng"%%

<!--#set var="settings_form" value="
<script type="text/javascript">
AMI.$(document).ready(function(){
    var
        oForm = document.forms['pay_drivers_form'],
        elems = oForm.elements,
        method = elems['drv_service_payment_method'].value;

    switchServicePaymentMethod('' !== method ? method : 'natural');

    AMI.$('[name=drv_service_payment_method]').click(function(){
        switchServicePaymentMethod($(this).val());
    });

    var
        methods = elems['drv_payment_method'].value,
        methods = '' !== methods ? methods.split(',') : [];

    for(var i = 0, q = methods.length; i < q; i++){
        AMI.$(':checkbox[value="' + methods[i] + '"]').prop('checked', true);
    }

    if('' === method){
        elems['drv_service_payment_method'][0].checked = true;
    }

    if('' === elems['drv_url'].value){
        elems['drv_url'].value = editorBaseHref + 'eshop_final.php';
    }

    $(oForm).on('submit', function(evt){
        var
            elems = document.forms['pay_drivers_form'].elements,
            method = elems['drv_service_payment_method'].value,
            obligatoryFields, methods = [];

        evt.preventDefault();

        AMI.$(':checkbox[name=drv_payment_method_checkbox]').each(function(){
            if(AMI.$(this).prop('checked')){
                methods.push(AMI.$(this).val());
            }
        });
        elems['drv_payment_method'].value = methods.join(',');

        obligatoryFields =
            'juridical' !== method
                ? [
                    'drv_account',
                    'drv_url',
                    'drv_secret_key'
                ] : [
                    'drv_payment_method',
                    'drv_notification_email',
                    'drv_shop_id',
                    'drv_shop_scid'
                ];

        for(var i = 0, q = obligatoryFields.length; i < q; i++){
            var field = obligatoryFields[i];
            if('' === elems[field].value){
                if('hidden' !== elems[field].type){
                    elems[field].focus();
                }
                alert('%%missing_obligatory_field%%');
                return false;
            }
        }
        this.submit();
    });
});

function switchServicePaymentMethod(method){
    AMI.$('.drv_service_payment_method_' + method).show();
    method = ('juridical' === method ? 'natural' : 'juridical');
    AMI.$('.drv_service_payment_method_' + method).hide();
}
</script>
<input type="hidden" name="drv_payment_method" value="##drv_payment_method##" />
<tr>
    <td colspan="2"><hr /><td>
</tr>
<tr>
    <td colspan="2">%%drv_service_payment_method%%*:</td>
</tr>
<tr>
    <td colspan="2">
        <label>
            <input
                type="radio"
                name="drv_service_payment_method"
                value="natural"
                ##IF('natural' == drv_service_payment_method)##checked="checked"##ENDIF##
            />
            %%drv_service_payment_method_natural%%;
        </label>
    <td>
</tr>
<tr>
    <td colspan="2">
        <label>
            <input
                type="radio"
                name="drv_service_payment_method"
                value="juridical"
                ##IF('juridical' == drv_service_payment_method)##checked="checked"##ENDIF##
            />
            %%drv_service_payment_method_juridical%%.
        </label>
    <td>
</tr>
<tr>
    <td colspan="2"><hr /></td>
</tr>
<tr class="drv_service_payment_method_natural">
    <td>%%drv_account%%*:</td>
    <td><input type="text" class="field field20" name="drv_account" value="##drv_account##" /></td>
</tr>
<tr class="drv_service_payment_method_natural">
    <td>%%drv_url%%*:</td>
    <td><input type="text" class="field field20" name="drv_url" value="##drv_url##" /></td>
</tr>
<tr class="drv_service_payment_method_natural">
    <td>%%drv_secret_key%%*:</td>
    <td><input type="text" class="field field20" name="drv_secret_key" value="##drv_secret_key##" /></td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td colspan="2">%%drv_payment_methods%%*:</td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td colspan="2">
        <label>
            <input
                type="checkbox"
                name="drv_payment_method_checkbox"
                value="yandex_money"
            />
            %%drv_payment_method_yandex_money%%;
        </label>
    </td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td colspan="2">
        <label>
            <input
                type="checkbox"
                name="drv_payment_method_checkbox"
                value="cards"
            />
            %%drv_payment_method_cards%%;
        </label>
    </td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td colspan="2">
        <label>
            <input
                type="checkbox"
                name="drv_payment_method_checkbox"
                value="cash"
            />
            %%drv_payment_method_cash%%;
        </label>
    </td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td colspan="2">
        <label>
            <input
                type="checkbox"
                name="drv_payment_method_checkbox"
                value="webmoney"
            />
            %%drv_payment_method_webmoney%%;
        </label>
    </td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td colspan="2">
        <label>
            <input
                type="checkbox"
                name="drv_payment_method_checkbox"
                value="mobile"
            />
            %%drv_payment_method_mobile%%;
        </label>
    </td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td colspan="2">
        <label>
            <input
                type="checkbox"
                name="drv_payment_method_checkbox"
                value="sberbank"
            />
            %%drv_payment_method_sberbank%%;
        </label>
    </td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td colspan="2">
        <label>
            <input
                type="checkbox"
                name="drv_payment_method_checkbox"
                value="mpos"
            />
            %%drv_payment_method_mpos%%;
        </label>
    </td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td colspan="2">
        <label>
            <input
                type="checkbox"
                name="drv_payment_method_checkbox"
                value="alfaclick"
            />
            %%drv_payment_method_alfaclick%%;
        </label>
    </td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td colspan="2">
        <label>
            <input
                type="checkbox"
                name="drv_payment_method_checkbox"
                value="masterpass"
            />
            %%drv_payment_method_masterpass%%;
        </label>
    </td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td colspan="2">
        <label>
            <input
                type="checkbox"
                name="drv_payment_method_checkbox"
                value="promsvazbank"
            />
            %%drv_payment_method_promsvazbank%%.
        </label>
    </td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td>%%drv_notification_email%%*:</td>
    <td><input type="text" class="field field20" name="drv_notification_email" value="##drv_notification_email##" /></td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td>%%drv_shop_password%%*:</td>
    <td><input type="text" class="field field20" name="drv_shop_password" value="##drv_shop_password##" /></td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td colspan="2"><b>%%drv_shop_data%%</b>:</td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td>%%drv_shop_id%%*:</td>
    <td><input type="text" class="field field20" name="drv_shop_id" value="##drv_shop_id##" /></td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td>%%drv_shop_scid%%*:</td>
    <td><input type="text" class="field field20" name="drv_shop_scid" value="##drv_shop_scid##" /></td>
</tr>
<tr class="drv_service_payment_method_juridical">
    <td>%%drv_shop_shoparticleid%%:</td>
    <td><input type="text" class="field field20" name="drv_shop_shoparticleid" value="##drv_shop_shoparticleid##" /></td>
</tr>
<tr>
    <td colspan="2"><hr /></td>
</tr>
<tr>
    <td colspan="2">
        <label>
            <input type="checkbox" name="drv_test_mode"##IF(drv_test_mode)## checked="checked"##ENDIF## /> %%drv_test_mode%%
        </label>
    </td>
</tr>
<tr>
    <td>%%drv_test_result%%:</td>
    <td><input type="text" class="field field20" name="drv_test_result" value="##drv_test_result##" /></td>
</tr>

"-->

<!--#set var="checkout_form" value="
<form name="paymentform##billing_driver##" action="##process_url##" method="post">
##hiddens##
<input type="hidden" name="cms_name" value="amirocms" />
</form>
"-->

<!--#set var="pay_form" value="
##IF(misconfigured)##
<b style="color: red;">%%misconfigured%%</b>
##ELSE##
%%select_payment_type%%:
<form name="paymentform" action="##url##" method="post">
##IF('natural' == drv_service_payment_method)##
<input type="hidden" name="quickpay-form" value="shop" />
<input type="hidden" name="receiver" value="##receiver##" />
<input type="hidden" name="formcomment" value="##formcomment##" />
<input type="hidden" name="short-dest" value="##short_dest##" />
<input type="hidden" name="targets" value="##targets##" />
<input type="hidden" name="sum" value="##amount##" />
<input type="hidden" name="label" value="##label##" />
<input type="hidden" name="comment" value="##comment##" />
<label><input type="radio" name="paymentType" value="PC" />%%payment_type_yandex_money%%</label><br />
<label><input type="radio" name="paymentType" value="AC" />%%payment_type_cards%%</label><br />
##ELSE##
<input type="hidden" name="shopId" value="##drv_shop_id##" />
<input type="hidden" name="scid" value="##drv_shop_scid##" />
##IF('' != drv_shop_shoparticleid)##<input type="hidden" name="shopArticleId" value="##drv_shop_shoparticleid##" />##ENDIF##
<input type="hidden" name="sum" value="##amount##" />
<input type="hidden" name="customerNumber" value="##customer##" />
<input type="hidden" name="shopSuccessURL" value="##return##" />
<input type="hidden" name="shopFailURL" value="##cancel##" />
<input type="hidden" name="orderNumber" value="##order_id##" />
##IF(drv_payment_method_yandex_money)##<label><input type="radio" name="paymentType" value="PC" />%%payment_type_yandex_money%%</label><br />##ENDIF##
##IF(drv_payment_method_cards)##<label><input type="radio" name="paymentType" value="AC" />%%payment_type_cards%%</label><br />##ENDIF##
##IF(drv_payment_method_cash)##<label><input type="radio" name="paymentType" value="GP" />%%payment_type_cash%%</label><br />##ENDIF##
##IF(drv_payment_method_webmoney)##<label><input type="radio" name="paymentType" value="WM" />%%payment_type_webmoney%%</label><br />##ENDIF##
##IF(drv_payment_method_mobile)##<label><input type="radio" name="paymentType" value="MC" />%%payment_type_mobile%%</label><br />##ENDIF##
##IF(drv_payment_method_sberbank)##<label><input type="radio" name="paymentType" value="SB" />%%payment_type_sberbank%%</label><br />##ENDIF##
##IF(drv_payment_method_mpos)##<label><input type="radio" name="paymentType" value="MP" />%%payment_type_mpos%%</label><br />##ENDIF##
##IF(drv_payment_method_alfaclick)##<label><input type="radio" name="paymentType" value="AB" />%%payment_type_alfaclick%%</label><br />##ENDIF##
##IF(drv_payment_method_masterpass)##<label><input type="radio" name="paymentType" value="MA" />%%payment_type_masterpass%%</label><br />##ENDIF##
##IF(drv_payment_method_promsvazbank)##<label><input type="radio" name="paymentType" value="PB" />%%payment_type_promsvazbank%%</label><br />##ENDIF##
##ENDIF##
<input type="hidden" name="cms_name" value="amirocms" />
<input type="submit" class="btn" value="%%pay%%" />
</form>
<script type="text/javascript">
AMI.$(document).ready(function(){
    AMI.$(AMI.$('[name=paymentType]')[0]).prop('checked', true);
});
</script>
##ENDIF##
"-->
