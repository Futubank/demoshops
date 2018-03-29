%%include_language "_local/eshop/pay_drivers/comepay/driver.lng"%%

<!--#set var="settings_form" value="
    <tr>
        <td>%%comepay_mode%%:</td>
        <td>
            <select name="comepay_mode">
                <option value="test">%%comepay_mode_test%%</option>
                <option value="prod">%%comepay_mode_prod%%</option>
            </select>
            <script>
                AMI.$('[name=comepay_mode]').val('##comepay_mode##');
            </script>
        </td>
    </tr>
    <tr>
        <td>%%comepay_id%%:</td>
        <td><input type="text" name="comepay_id" class="field" value="##comepay_id##" size="16"></td>
    </tr>
    <tr>
        <td>%%comepay_purse_number%%:</td>
        <td><input type="text" name="comepay_purse_number" class="field" value="##comepay_purse_number##" size="16"></td>
    </tr>
    <tr>
        <td>%%comepay_pwd%%:</td>
        <td><input type="password" name="comepay_pwd" class="field" value="##comepay_pwd##" size="16"></td>
    </tr>
    <tr>
        <td>%%comepay_pwd_not%%:</td>
        <td><input type="password" name="comepay_pwd_not" class="field" value="##comepay_pwd_not##" size="16"></td>
    </tr>
    <tr>
        <td>%%shop_name%%:</td>
        <td><input type="text" name="shop_name" class="field" value="##shop_name##" size="40"></td>
    </tr>
"-->

<!--#set var="checkout_form" value="
<form name="paymentform##billing_driver##" action="##process_url##" method="post">
##hiddens##
<input type="hidden" name="cms_name" value="amirocms" />
</form>
"-->

<!--#set var="pay_form" value="
%%enter_phone_number%%<br>+7 <input type="text" id="comepay_phone" /><br><input type="button" id="comepay-pmt-btn"  class="btn" value="%%driver_button_caption%%" onclick="comepayCheckMobile();">
<script>
    function comepayCheckMobile(){
        var mob = AMI.$('#comepay_phone').val();
        mob = mob.replace(/[^0-9]/g, '');
        AMI.$('#comepay_phone').val(mob);
        if(mob.toString().length != 10){
            alert('%%error_incorrect_phone%%', 'error');
        }else{
            var lang = AMI_SessionData['locale'];
            var aData = {
                service     : 'ami_webservice',
                version     : '1.1',
                appToken    : 'app_token_public',
                order_id    : '##order##',
                phone       : mob,
                action      : 'comepay.bill',
                fullEnv     : 1,
                ami_locale  : lang
            };

	    var comepaybtn = $('#comepay-pmt-btn');
            comepaybtn.hide();

            alert('%%waiting_for_comepay%%','info');
            AMI.$.getJSON(frontBaseHref + 'ami_service.php', aData, function(data){
                var aData = data.data;
                if(aData.errorCode == 'OK'){
                    if(aData.result == 0 || aData.result == 215){
                        location.href="##url##"+
                        "?transaction=##transaction##&"+
                        "shop=##shop##&"+
                        "successUrl=##successUrl##&"+
                        "failUrl=##failUrl##";

                        return;
                    }
                    if(aData.result == 5){
                        alert('%%error_wrong_parameters%%', 'error');
                    } else if(aData.result == 13) {
                        alert('%%error_server_busy%%', 'error');
                    } else if(aData.result == 150) {
                        alert('%%error_auth_error%%', 'error');
                    } else if(aData.result == 210) {
                        alert('%%error_not_found%%', 'error');
                    }else if(aData.result == 241) {
                        alert('%%error_min_sum%%', 'error');
                    }else if(aData.result == 242) {
                        alert('%%error_max_sum%%', 'error');
                    }else if(aData.result == 299) {
                        alert('%%error_shop_noreg%%', 'error');
                    }else{
                        alert('%%error_server_error%%', 'error');
                    }
                }else{
                    alert('%%error_server_error%%', 'error');
                }
		comepaybtn.show();
            });
        }
    }
</script>
<form name="paymentform##billing_driver##" action="##process_url##" onsubmit="return false;" method="post">
##hiddens##
</form>
"-->
