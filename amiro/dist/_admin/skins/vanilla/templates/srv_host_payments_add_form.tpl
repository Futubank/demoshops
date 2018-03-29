%%include_language "templates/lang/_currency.lng"%%
%%include_language "templates/lang/srv_host_payments.lng"%%
%%include_language "templates/lang/srv_host_payments_add.lng"%%
%%include_template "templates/_payments_docs.tpl"%%

<!--#set var="invoice_bank_jur_descr_ru;invoice_bank_jur_descr_en" value="##description## ##domain## "-->

<!--#set var="invoice_bank_fiz_descr_ru;invoice_bank_fiz_descr_en" value="##description## ##domain## %%by_invoice%% ##invoice_num##"-->

<!--#set var="invoice_webmoney_descr_ru;invoice_yandex_descr_ru;invoice_webmoney_descr_en;invoice_yandex_descr_en;invoice_paypal_descr_ru;invoice_paypal_descr_en" value="##description## ##domain##"-->

<!--#set var="package_row" value="
<tr><td width=100%><input type=radio name=id_sitemap value="##id##" id=pkg_##id##>&nbsp;<label for=pkg_##id##>##name##</label><br></td>
<td align=right nowrap>&nbsp;##pricing_amount_buy_str##</td>
<td align=right nowrap>&nbsp;##pricing_amount_rent_str##</td></tr>
"-->

<!--#set var="select_package" value="
<script>

function checkPackage(){
        bSelected1 = false;
        if (document.forms.payform.id_sitemap.checked){
                bSelected1 = true;
        }
        if (document.forms.payform.id_sitemap.length){
                for (i=0;i<document.forms.payform.id_sitemap.length;i++ ){
                        if (document.forms.payform.id_sitemap[i].checked){
                                bSelected1 = true;
                        }
                }
        }

        bSelected2 = false;
        if (document.forms.payform.buy_type.checked){
                bSelected2 = true;
        }
        if (document.forms.payform.buy_type.length){
                for (i=0;i<document.forms.payform.buy_type.length;i++ ){
                        if (document.forms.payform.buy_type[i].checked){
                                bSelected2 = true;
                        }
                }
        }

        if (bSelected1 && bSelected2){
                document.forms.payform.submit();
        }

}

function showPeriod(bShow){
        document.getElementById('rent_period_block').style.display=(bShow)?"block":"none";
}
</script>

<div class=tooltip style="width:500px;">%%buy_note%%</div>
<br>

<h2>%%select_package%%</h2><br>
<table class=frm>
<tr><td></td>
<td align=right><b>%%buy%%</b></td>
<td align=right><b>%%rent%%</b></td>
<tr>
 ##packages_list##
</table>
<br><h2>%%select_buy_type%%</h2><br>
<table class=frm>
<tr><td>
<input type=radio name=buy_type value="buy" id=bt_buy onclick=showPeriod(false)>&nbsp;<label for=bt_buy>%%buy%%</label>
</td></tr>
<tr><td>
<input type=radio name=buy_type value="rent" id=bt_rent onclick=showPeriod(true)>&nbsp;<label for=bt_rent>%%rent%%</label><br>
</td>
<tr>
 </table>
<br>
<div id=rent_period_block style="display:none">
<h2>%%select_period%%</h2><br>
&nbsp;&nbsp;<select name=rent_period>
<option value=1>1</option>
<option value=2>2</option>
<option value=3 selected>3</option>
<option value=4>4</option>
<option value=5>5</option>
<option value=6>6</option>
<option value=7>7</option>
<option value=8>8</option>
<option value=9>9</option>
<option value=10>10</option>
<option value=11>11</option>
<option value=12>12</option>
</select>
<br>
</div>
  <center><input type="button" name="apply" value="%%apply_btn%%" class="but-mid" onclick="return checkPackage()"></center>

"-->

<!--#set var="package_info" value="
<table class=frm>
<tr><td height=20>
        %%selected_package%% <b>##package##</b>
</td></tr>
<tr><td height=20>
%%selected_buy_type%% <b>##buy_type_name##</b>
</td></tr>
  ##if(buy_type=="rent")##
<tr><td height=20>
%%selected_period%% <b>##rent_period##</b>
</td></tr>
        ##endif##
<tr><td height=20>
%%amount%%: <b>##amount##</b>
</td></tr>
        ##if(bonus!="---")##
<tr><td height=20>
%%bonus%% <b>##bonus##</b>
</td></tr>
        ##endif##
</table>
<hr>
"-->

<!--#set var="amount_form" value="
   <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
        <col width="300">
        <col width="*">
   <tr>
         <td colspan=2>
         %%payer_note1%% <b>##client_name##</b><br><br>
         %%payer_note2%%
         <br><br>
         </td>
   </tr>
   <tr>
     <td nowrap>
                 %%min_amount%%:
     </td>
     <td>
            ##min_amount_str##
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td nowrap>
                 %%enter_amount%%:
     </td>
     <td>
            <input type="text" class="field field8" style="font-weight:bold;" maxlength=10 name="amount" value="##amount_num##" onkeyup="if (this.value.length>0 && parseInt(this.value)>0) document.forms.payform.apply.disabled=false; else document.forms.payform.apply.disabled=true;">
     </td>
   </tr>
   <tr>
        <td></td>
        <td>
         <br>
         <input type="submit" name="apply" value="%%apply_btn%%" class="but-mid">
</td>
</tr>
</table>
"-->


<!--#set var="payer_not_defined" value="
%%payer_not_defined%%<br><br>
<center>
<input type=button class=but-long value="%%enter_props%%" onclick="javascript:window.location.href='##props_href##'">
</center>
"-->

<!--#set var="contractor_not_defined" value="
%%contractor_not_defined%%
"-->

<!--#set var="amount_static" value="
   <input type="hidden" name="amount" value="##amount_num##">
   <input type="hidden" name="buy_type" value="##buy_type##">
   <input type="hidden" name="rent_period" value="##rent_period##">
   <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
        <col width="300">
        <col width="*">
   <tr>
     <td nowrap>
       <strong>%%amount_to_pay%%:</strong>
     </td>
     <td width=100%>
            <strong>##amount##</strong>
     </td>
   </tr>
   <tr>
     <td nowrap>
       <strong>%%payer%%:</strong>
     </td>
     <td width=100%>
            <strong>##client_name##</strong>
     </td>
   </tr>
</table>
"-->


<!--#set var="pay_form_method" value="

<table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
 <tr>
  <td>

    ##if(admin_lang!='ru')##

        <br>
        %%choose_pay_method%%:
        ##if(client_type!='person' && contractor_bik!='')##
        <p>
        <input type=radio name=pay_method id=bank_jur value=bank_jur onclick="document.forms.payform.apply.disabled=false;"> <label for=bank_jur>%%bank_jur%%</label>
        </p>
        ##endif##
        ##if(client_type=='person' && contractor_bik!='')##
        <p>
        <input type=radio name=pay_method id=bank_fiz value=bank_fiz onclick="document.forms.payform.apply.disabled=false;"> <label for=bank_fiz>%%bank_fiz%%</label>
        </p>
        ##endif##
        ##if(contractor_wmr.contractor_wmz!='')##
        <p>
        <input type=radio name=pay_method id=webmoney value=webmoney onclick="document.forms.payform.apply.disabled=false;"> <label for=webmoney>%%webmoney%%</label>
        </p>
        ##endif##
        ##if(contractor_yandex!='')##
        <p>
        <input type=radio name=pay_method id=yandex value=yandex onclick="document.forms.payform.apply.disabled=false;"> <label for=yandex>%%yandex%%</label>
        </p>
        ##endif##

        <br><div class="tooltip">%%payments_note%%</div>


    ##else##

        <script>

        function getRadioValue(oRadio){
          for (var i=0; i < oRadio.length; i++)
            if (oRadio[i].checked) return oRadio[i].value;
          return '';
        }

        function getRadioLabelTitle(oRadio){
          for (var i=0; i < oRadio.length; i++)
            if (oRadio[i].checked) return (oRadio[i].parentNode.title || oRadio[i].parentNode.getAttribute('stitle'));
          return '';
        }

        function setRadioValue(oRadio, sValue){
          for (var i=0; i < oRadio.length; i++)
            if (oRadio[i].value == sValue) oRadio[i].checked = true;
        }

        function checkPayType(){

          var cform = document.forms['payform'];

          document.getElementById('block_rbk_bankCard').style.display=(getRadioValue(cform.pay_method)=='rbk_bankCard')?'block':'none';
          document.getElementById('block_bank_jur').style.display=(getRadioValue(cform.pay_method)=='bank_jur')?'block':'none';
          document.getElementById('block_bank_fiz').style.display=(getRadioValue(cform.pay_method)=='bank_fiz')?'block':'none';
          document.getElementById('block_rbk_euroset').style.display=(getRadioValue(cform.pay_method)=='rbk_euroset')?'block':'none';
          document.getElementById('block_qiwi').style.display=(getRadioValue(cform.pay_method)=='qiwi')?'block':'none';

          document.getElementById('block_webmoney').style.display=(getRadioValue(cform.pay_method)=='webmoney')?'block':'none';
          document.getElementById('block_yandex').style.display=(getRadioValue(cform.pay_method)=='yandex')?'block':'none';
          document.getElementById('block_rbk_inner').style.display=(getRadioValue(cform.pay_method)=='rbk_inner')?'block':'none';
          document.getElementById('block_rbk_prepaidcard').style.display=(getRadioValue(cform.pay_method)=='rbk_prepaidcard')?'block':'none';
          document.getElementById('block_paypal').style.display=(getRadioValue(cform.pay_method)=='paypal')?'block':'none';

          document.forms.payform.apply.disabled=false;
        }

        </script>

       <p>Выберите наиболее удобный для Вас способ оплаты*:</p>

        <div style="text-align:center;">
            <table align=center cellspacing=20>
                <tr>
                ##IF(contractor_paypal_used)##
                    <td align=center valign=top><label title="Оплата через PayPal"><img src="skins/vanilla/icons/ico2-visa.gif##--ico2-paypal.png--##" align=absmiddle>
                        <br /><input type="radio" name="pay_method" value="paypal" onchange="checkPayType();" /> Банковской картой<br />через PayPal</label></td>
                ##ENDIF##
##--
                    <td align=center valign=top><label title="Оплата банковской картой"><img src="skins/vanilla/icons/ico2-visa.gif" align=absmiddle>
                        <br><input type=radio name=pay_method value="rbk_bankCard" onchange="checkPayType();"> Банковская карта</label></td>
--##
                    <td align=center valign=top><label title="Оплата безналичным банковским переводом"><img src="skins/vanilla/icons/ico2-bank.gif" align=absmiddle>
                        <br>
                        ##if(client_type!='person' && contractor_bik!='')##
                        <input type=radio name=pay_method value="bank_jur" onchange="checkPayType();"> Через банк</label>
                        ##endif##

                        ##if(client_type=='person' && contractor_bik!='')##
                        <input type=radio name=pay_method value="bank_fiz" onchange="checkPayType();"> Через банк</label>
                        ##endif##

                        </td>
                    <td align=center valign=top><label title="Оплата в салоне связи Евросеть"><img src="skins/vanilla/icons/ico2-euroset.gif" align=absmiddle>
                        <br><input type=radio name=pay_method value="rbk_euroset" onchange="checkPayType();"> Евросеть</label></td>
                    <td align=center valign=top><label title="Оплата через терминалы или с кошелька QIWI"><img src="skins/vanilla/icons/ico2-qiwi.gif" align=absmiddle >
                        <br><input type=radio name=pay_method value="qiwi" onchange="checkPayType();"> QIWI</label></td>
                </tr>
                <tr>
                    <td align=center valign=top><label title="Оплата с кошелька Яндекс.Деньги"><img src="skins/vanilla/icons/ico2-ym.gif" align=absmiddle>
                        <br><input type=radio name=pay_method value="yandex" onchange="checkPayType();"> Яндекс.Деньги</label></td>
                    <td align=center valign=top><label title="Оплата с кошелька WebMoney"><img src="skins/vanilla/icons/ico2-wm.gif" align=absmiddle>
                        <br><input type=radio name=pay_method value="webmoney" onchange="checkPayType();"> WebMoney</label></td>
                    ##IF(contractor_rbk_used)##
                    <td align=center valign=top><label title="Оплата с кошелька RBK Money"><img src="skins/vanilla/icons/ico2-rbk-inner.gif" align=absmiddle>
                        <br><input type=radio name=pay_method value="rbk_inner" onchange="checkPayType();"> RBK Кошелек</label></td>
                    <td align=center valign=top><label title="Предоплаченная карта RBK Money"><img src="skins/vanilla/icons/ico2-rbk-prepaidcard.gif" align=absmiddle>
                        <br><input type=radio name=pay_method value="rbk_prepaidcard" onchange="checkPayType();"> Карта RBK</label></td>
                    ##ENDIF##
                </tr>
            </table>

        </div>
        <style>
        .tbl_brief{
          padding: 10px 0px;
        }

        </style>

        <div id=block_rbk_bankCard style="display: none;">
          <h2>Оплата банковской картой:</h2>
          <div class=tbl_brief>
          На следующем шаге будет сформирован счет и кнопка для перехода к форме оплаты банковской картой.
          <br>Сервис оплаты предоставляется платежной системой <a href="http://rbkmoney.ru" target=_blank>RBK Money</a>

          </div>
        </div>

        <div id=block_bank_jur style="display: none;">
          <h2>Оплата через банк:</h2>
          <div class=tbl_brief>
            На следующем шаге будет сформирован счет для оплаты.<br>
          </div>
        </div>

        <div id=block_bank_fiz style="display: none;">
          <h2>Оплата через банк:</h2>
          <div class=tbl_brief>
            На следующем шаге будет сформирована квитанция для оплаты с личного счета или через банк без открытия счета (Сбербанк).<br>
          </div>
        </div>

        <div id=block_rbk_euroset style="display: none;">
          <h2>Оплата в салоне Евросеть:</h2>
          <div class=tbl_brief>
          На следующем шаге будет сформирован счет и кнопка оплаты.
          </div>
        </div>

        <div id=block_qiwi style="display: none;">
          <h2>Оплата через терминалы или с кошелька QIWI:</h2>
          <div class=tbl_brief>
          На следующем шаге будет сформирован счет и кнопка оплаты.
          </div>
        </div>

        <div id=block_yandex style="display: none;">
          <h2>Оплата с кошелька Яндекс.Деньги:</h2>
          <div class=tbl_brief>
            <p>На следующем шаге будет сформирован счет и кнопка оплаты.</p>
          </div>
        </div>


        <div id=block_webmoney style="display: none;">
          <h2>Оплата с кошелька WebMoney:</h2>
          <div class=tbl_brief>
            <p>На следующем шаге будет сформирован счет и кнопка оплаты.</p>
          </div>
        </div>


        <div id=block_rbk_inner style="display: none;">
          <h2>Оплата с кошелька RBK Money:</h2>
          <div class=tbl_brief>
          На следующем шаге будет сформирован счет и кнопка для выполнения внутреннего перевода кошелька RBK Money.
          </div>
        </div>

        <div id=block_rbk_prepaidcard style="display: none;">
          <h2>Оплата предоплаченой картой RBK Money:</h2>
          <div class=tbl_brief>
          На следующем шаге будет сформирован счет и кнопка для оплаты c помощью скрэтч-карты RBK Money.
          </div>
        </div>

        <div id="block_paypal" style="display: none;">
            <h2>Оплата банковской картой (PayPal):</h2>
            <div class="tbl_brief">
                <p>
                На следующем шаге будет сформирован счет и кнопка оплаты.<br />
                Сервис оплаты предоставляется платежной системой Paypal.
                </p>
            </div>
        </div>

     ##endif##


     </td>
   </tr>
</table>
<br>

<table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
   <tr>
                 <td align=left>
                 <input type="submit" name="back" value=" %%back_btn%% " class="but-mid" onclick="document.forms.payform.amount.value=''">
           </td>
                 <td align=right>
                 <input type="submit" name="apply" value="%%apply_btn%%" class="but-mid" ##apply## default>
           </td>
         </tr>
</table>
</center>

"-->


<!--#set var="pay_form_bank_jur" value="
<table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
        <col width="150">
        <col width="*">
   <tr>
     <td colspan=2>
                 %%got_invoice%%: <strong># ##invoice_num## %%from%% ##invoice_date##</strong><br><br><i>##service_description##</i>
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td colspan=2>
                 %%pay_method%%: <strong>%%bank_jur%%</strong>
     </td>
   </tr>
   ##--
   <tr>
     <td colspan=2>
                 %%amount%%: <strong>##amount_RUR## %%RUR%%</strong>
     </td>
   </tr>
   <tr>
     <td colspan=2>
                 %%commission%%: <strong>##contractor_bank_commission##%</strong>
     </td>
   </tr>
   --##
   <tr>
     <td colspan=2>
      ##setvar @amount_commission = intval(amount_RUR * floatval(contractor_bank_commission / 100 ))##
      ##setvar @amount_commission = ( amount_commission < 29 ) ? 29 : (( amount_commission > 190 ) ? 190 : amount_commission)##
      ##setvar @amount_RUR_k = ( amount_RUR + amount_commission )##
      %%to_pay%%: <strong>##amount_RUR_k## %%RUR%%</strong> ##if( contractor_bank_commission != '' )##%%with_commission%%##endif##
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td colspan=2 align=center>
                 <input type="button" name="print" value=" %%print_invoice%% " class="but-long" onclick="window.open('##print_url##?action=print&id=##id##')">
     </td>
   </tr>
</table>
"-->

<!--#set var="pay_form_bank_fiz" value="
<table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
        <col width="150">
        <col width="*">
   <tr>
     <td colspan=2>
                 %%got_invoice%%: <strong># ##invoice_num## %%from%% ##invoice_date##</strong><br><br><i>##service_description##</i>
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td colspan=2>
                 %%pay_method%%: <strong>%%bank_fiz%%</strong>
     </td>
   </tr>
   ##--
   <tr>
     <td colspan=2>
                 %%amount%%: <strong>##amount_RUR## %%RUR%%</strong>
     </td>
   </tr>
   <tr>
     <td colspan=2>
                 %%commission%%: <strong>##contractor_bank_commission##%</strong>
     </td>
   </tr>
   --##
   <tr>
     <td colspan=2>
      ##setvar @amount_commission = intval(amount_RUR * floatval(contractor_bank_commission / 100 ))##
      ##setvar @amount_commission = ( amount_commission < 29 ) ? 29 : (( amount_commission > 190 ) ? 190 : amount_commission)##
      ##setvar @amount_RUR_k = ( amount_RUR + amount_commission )##
      %%to_pay%%: <strong>##amount_RUR_k## %%RUR%%</strong> ##if( contractor_bank_commission != '' )##%%with_commission%%##endif##
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td colspan=2 align=center>
                 <input type="button" name="print" value=" %%print_invoice%% " class="but-long" onclick="window.open('##print_url##?action=print&id=##id##')">
     </td>
   </tr>
</table>
"-->
<!--#set var="pay_form_webmoney_info" value="
                 ##if (contractor_wmr!='')##
                 <p>
                 <b>##amount_RUR_k## WMR %%wm_to%% ##contractor_wmr##</b>
                 </p>
                 ##endif##
                 ##if (contractor_wmz!='')##
                 <p>
                 <b>##amount_USD_k## WMZ %%wm_to%% ##contractor_wmz## </b>
                 </p>
                 ##endif##
                 ##if (contractor_wme!='')##
                 <p>
                 <b>##amount_EUR_k## WME %%wm_to%% ##contractor_wme## </b>
                 </p>
                 ##endif##
                <br><b>%%payment_note%%</b><br><br><i>##service_description## %%pay_invoice%% ##invoice_num## %%from%% ##invoice_date##</i>
"-->


<!--#set var="pay_form_webmoney" value="
<table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
        <col width="150">
        <col width="*">
   <tr>
     <td colspan=2>
                 %%got_invoice%%: <strong># ##invoice_num## %%from%% ##invoice_date##</strong><br><br><i>##service_description##</i>
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td colspan=2>
                 %%pay_method%%: <strong>%%webmoney%%</strong>
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   ##--if (contractor_wmr!='' && contractor_wmz!='')##
   <tr>
         <td colspan=2>%%wmk_note%%</td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   ##endif--##
   <tr>
     <td colspan=2 align=center>
                 ##if (contractor_wmr!='')##
                 <p>
    <form method="POST" action="https://merchant.webmoney.ru/lmi/payment.asp" name=wmr_form  target="_blank">
                  ##setvar @amount_RUR_k = intval( ( amount_RUR * ( 1 + ( floatval(contractor_wm_commission ) / 100 ) ) ) )##

      <input type="hidden" name="LMI_PAYMENT_AMOUNT" value="##amount_RUR_k##">
      <input type="hidden" name="LMI_PAYMENT_DESC" value="##service_description## %%pay_invoice%% ##invoice_num## %%from%% ##invoice_date##">
      <input type="hidden" name="LMI_PAYMENT_DESC_BASE64" value="">
      ##--<input type="hidden" name="LMI_PAYMENT_NO" value="##invoice_num##">--##
      <input type="hidden" name="LMI_PAYEE_PURSE" value="##contractor_wmr##">
          <input type="hidden" name="userField_1" value="##invoice_num##">
      <input type="hidden" name="LMI_SIM_MODE" value="0">
      <input type="submit" class=but-long style="font-size:10px" value="%%pay_wmr%%">
    </form>
     ##--<button class=but-long onclick="window.location='wmk:payto?Purse=##contractor_wmr##&Amount=##amount_RUR##&Desc=##service_description##&BringToFront=Y&ExecEvenKeeperIsOffline=Y'">%%pay_wmr%%</button>--##
                 </p>
                 ##endif##
                 ##if (contractor_wmz!='')##
                 <p>
    <form method="POST" action="https://merchant.webmoney.ru/lmi/payment.asp" name=wmz_form  target="_blank">
                  ##setvar @amount_USD_k = intval( ( amount_RUR * ( 1 + ( floatval(contractor_wm_commission ) / 100 ) ) ) )##

      <input type="hidden" name="LMI_PAYMENT_AMOUNT" value="##amount_USD_k##">
      <input type="hidden" name="LMI_PAYMENT_DESC" value="##service_description## %%pay_invoice%% ##invoice_num## %%from%% ##invoice_date##">
      <input type="hidden" name="LMI_PAYMENT_DESC_BASE64" value="">
      <input type="hidden" name="LMI_PAYMENT_NO" value="">
      <input type="hidden" name="LMI_PAYEE_PURSE" value="##contractor_wmz##">
      <input type="hidden" name="LMI_SIM_MODE" value="0">
      <input type="submit" class=but-long style="font-size:10px" value="%%pay_wmz%%">
    </form>
##--		 <button class=but-long onclick="window.location='wmk:payto?Purse=##contractor_wmz##&Amount=##amount_USD##&Desc=##service_description##&BringToFront=Y&ExecEvenKeeperIsOffline=Y'">%%pay_wmz%%</button>--##
                 </p>
                 ##endif##
         ##if (contractor_wme!='')##
                 <p>
    <form method="POST" action="https://merchant.webmoney.ru/lmi/payment.asp" name=wme_form  target="_blank">
                  ##setvar @amount_EUR_k = intval( ( amount_RUR * ( 1 + ( floatval(contractor_wm_commission ) / 100 ) ) ) )##

      <input type="hidden" name="LMI_PAYMENT_AMOUNT" value="##amount_EUR_k##">
      <input type="hidden" name="LMI_PAYMENT_DESC" value="##service_description## %%pay_invoice%% ##invoice_num## %%from%% ##invoice_date##">
      <input type="hidden" name="LMI_PAYMENT_DESC_BASE64" value="">
      <input type="hidden" name="LMI_PAYMENT_NO" value="##invoice_num##">
      <input type="hidden" name="LMI_PAYEE_PURSE" value="##contractor_wme##">
      <input type="hidden" name="LMI_SIM_MODE" value="0">
      <input type="submit" class=but-long style="font-size:10px" value="%%pay_wme%%">
    </form>
##--		 <button class=but-long onclick="window.location='wmk:payto?Purse=##contractor_wme##&Amount=##amount_EUR##&Desc=##service_description##&BringToFront=Y&ExecEvenKeeperIsOffline=Y'">%%pay_wme%%</button>--##
                 </p>
                 ##endif##
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   ##if (contractor_wmr!='' || contractor_wmz!='' || contractor_wme!='')##
   <tr>
         <td colspan=2>%%wm_note%%</td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   ##endif##
   <tr>
     <td colspan=2>
                 ##payment_info##
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   ##--
   <tr>
     <td colspan=2 align=center>
                 <input type="button" name="print" value=" %%print_invoice%% " class="but-long" onclick="window.open('##print_url##?action=print&id=##id##')">
     </td>
   </tr>
   --##
</table>

<script>

var Base64 = {

        _keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

        encode : function (input) {
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

        _utf8_encode : function (string) {
                string = string.replace(/\r\n/g,"\n");
                var utftext = "";

                for (var n = 0; n < string.length; n++) {

                        var c = string.charCodeAt(n);

                        if (c < 128) {
                                utftext += String.fromCharCode(c);
                        }
                        else if((c > 127) && (c < 2048)) {
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

}
##if (contractor_wmr!='')##
document.forms['wmr_form'].LMI_PAYMENT_DESC_BASE64.value = Base64.encode((document.forms['wmr_form'].LMI_PAYMENT_DESC.value));
##endif##
##if (contractor_wmz!='')##
document.forms['wmz_form'].LMI_PAYMENT_DESC_BASE64.value = Base64.encode((document.forms['wmz_form'].LMI_PAYMENT_DESC.value));
##endif##
##if (contractor_wme!='')##
document.forms['wme_form'].LMI_PAYMENT_DESC_BASE64.value = Base64.encode((document.forms['wme_form'].LMI_PAYMENT_DESC.value));
##endif##

</script>
"-->

<!--#set var="pay_form_yandex_info" value="
                 ##amount_num## %%yandex_to%% ##contractor_yandex##
     <br><br><b>%%payment_note%%</b><br><br><i>##service_description## %%pay_invoice%% ##invoice_num## %%from%% ##invoice_date##</i></td>
"-->

<!--#set var="pay_form_qiwi" value="
<table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
        <col width="150">
        <col width="*">
   <tr>
     <td colspan=2>
                 %%got_invoice%%: <strong># ##invoice_num## %%from%% ##invoice_date##</strong><br><br><i>##service_description##</i>
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td colspan=2>
                 %%pay_method%%: <strong>%%qiwi%%</strong>
     </td>
   </tr>
   ##--
   <tr>
     <td colspan=2>
                 %%amount%%: <strong>##amount_RUR## %%RUR%%</strong>
     </td>
   </tr>
   <tr>
     <td colspan=2>
                 %%commission%%: <strong>##contractor_qiwi_commission##%</strong>
     </td>
   </tr>
   --##
   <tr>
     <td colspan=2>
      ##setvar @amount_commission = intval(amount_RUR * floatval(contractor_qiwi_commission / 100 ))##
      ##setvar @amount_commission = ( amount_commission < 29 ) ? 29 : (( amount_commission > 190 ) ? 190 : amount_commission)##
      ##setvar @amount_RUR_k = ( amount_RUR + amount_commission )##
      %%to_pay%%: <strong>##amount_RUR_k## %%RUR%%</strong> ##if( contractor_qiwi_commission != '' )##%%with_commission%%##endif##
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td colspan=2 align=center>
                ##--<form method="POST" action="http://w.qiwi.ru/setInetBill_utf.do" name=qiwi_form  target="_blank" onsubmit="submitQiwiForm()">  --##
    <form method="GET" action="https://w.qiwi.com/order/external/create.action" name="qiwi_form" target="_blank" onsubmit="submitQiwiForm()">
                        <input type="hidden" name="currency" value="RUB">
                        <input type="hidden" name="from" value="##contractor_qiwi##">
                        <input type="hidden" name="txn_id" value="##invoice_num##">
                        <input type="hidden" name="comm" value="##description## ##domain## по счету ##invoice_num## от ##invoice_date## [qiwi]">
                        <input type="hidden" name="summ" value="##amount_RUR_k##">
                        Номер мобильного телефона:
                        <br><br>
                        <span style="font-size:20px">+</span><input type="text" class=field name="phone" value="" style="font-size:20px"><br><br>
                        <input type="hidden" name="to" value=""><br><br>
                        <input type="submit" name="submit" value="%%pay_qiwi%%" class="but-long">
                </form>
                <div style="display:none" id=client_phone>##client_phone##</div>
                <script>
                        qiwi_form.phone.value = AMI.$('#client_phone').html().split(/\n/i)[0];
                        function submitQiwiForm(){
                                qiwi_form.to.value = qiwi_form.phone.value.replace(/^8|\+[0-9]|[^0-9]/g, '');
                        }
                </script>
    </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   ##--
   <tr>
     <td colspan=2 align=center>
                 <input type="button" name="print" value=" %%print_invoice%% " class="but-long" onclick="window.open('##print_url##?action=print&id=##id##')">
     </td>
   </tr>
   --##
</table>
"-->



<!--#set var="pay_form_yandex" value="
<table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
        <col width="150">
        <col width="*">
   <tr>
     <td colspan=2>
                 %%got_invoice%%: <strong># ##invoice_num## %%from%% ##invoice_date##</strong><br><br><i>##service_description##</i>
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td colspan=2>
                 %%pay_method%%: <strong>%%yandex%%</strong>
     </td>
   </tr>
   ##--
   <tr>
     <td colspan=2>
                 %%amount%%: <strong>##amount_RUR## %%RUR%%</strong>
     </td>
   </tr>
   <tr>
     <td colspan=2>
                 %%commission%%: <strong>##contractor_yandex_commission##%</strong>
     </td>
   </tr>
   --##
   <tr>
     <td colspan=2>
      ##setvar @amount_commission = intval(amount_RUR * floatval( contractor_yandex_commission / 100 ))##
      ##setvar @amount_commission = amount_commission < 29 ? 29 : (amount_commission > 190 ? 190 : amount_commission)##
      ##setvar @amount_RUR_k = ( amount_RUR + amount_commission )##

      %%to_pay%%: <strong>##amount_RUR_k## %%RUR%%</strong> ##if( contractor_yandex_commission != '' )##%%with_commission%%##endif##
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td colspan=2 align=center>
##--
                <form method="POST" ACTION="http://money.yandex.ru/select-wallet.xml" target="_blank" name=yandex_form>
                <input type=hidden name="wbp_Version" value="2"> <input type="hidden" name="wbp_MessageType" value="DirectPaymentIntoAccountRequest">
                <input type="hidden" name="wbp_ShopAddress" value="##contractor_email##">
                <input type="hidden" name="wbp_accountid" value="##contractor_yandex##">
                <input type="hidden" name="wbp_currencyamount" value="643;##amount_RUR##">
                <input type="hidden" name="TargetCurrency" value="643">
                <input type="hidden" name="Currency" value="643">
                <input type="hidden" name="wbp_shortdescription" value="##service_description##">
                <input type="hidden" name="wbp_template_1" value="%%pay_invoice%% ##invoice_num## %%from%% ##invoice_date##">
                <input type="hidden" name="wbp_template_2" value="">
                <input type="hidden" name="wbp_template_3" value="">
                <input type="hidden" name="wbp_template_4" value="">
                <input type="hidden" name="wbp_template_5" value="">
                <input type="hidden" name="wbp_ShopErrorInfo" value="%%payout_error%%: ##contractor_email##." >
                <input type="submit" name="submit"  value="%%pay_yandex%%" class="but-long">
                </form>
--##


                <form name="yandex_form" method="POST" action="https://money.yandex.ru/direct-payment.xml" target="_blank">
                <input type="hidden" value="767" name="scid"> ##--768--##
                <input type="hidden" name="rnd" value="652653966">
                <input type="hidden" value="Перевод на e-mail/счет" name="shn">
                <input type="hidden" value="643" name="targetcurrency">
                <input type="hidden" value="ym2xmlsuccess" name="SuccessTemplate">
                <input type="hidden" value="ym2xmlerror" name="ErrorTemplate">
                <input type="hidden" value="7" name="ShowCaseID">
                <input type="hidden" value="true" name="isViaWeb">

                <input type="hidden" value="true" id="isDirectPaymentFormSubmit" name="isDirectPaymentFormSubmit">
                <input type="hidden" name="is-payback" id="is-payback">
                <input type="hidden" name="js" id="js" value="0">
                <input type="hidden" value="0.5%" name="showcase_comm">
                <input type="hidden" name="p2payment" id="p2payment" value="1">
                <input type="hidden" value="Перевод от пользователя Яндекс.Денег" id="short-dest" name="short-dest">
                <input id="paymentid" type="hidden" name="paymentid">
                <input id="suspendedPaymentsAllowed" type="hidden" value="false" name="suspendedPaymentsAllowed">
                <input type="hidden" name="quickpay-form" id="quickpay-form">
                <input id="p2pmain" type="hidden" name="p2pmain">
                <input name="secureparam5" type="hidden" value="5">

                <input type="hidden" value="##contractor_yandex##" name="receiver">
                <input type="hidden" value="##amount_RUR_k##" name="sum">
                <input type="hidden" value="##domain## ##invoice_num## %%from%% ##invoice_date##" name="label">
                <input type="hidden" value="##service_description##" name="destination" >
                <input type="hidden" value="%%pay_invoice%% ##invoice_num## %%from%% ##invoice_date## [autoform]" name="FormComment">
                <input type="submit" name="submit"  value="%%pay_yandex%%" class="but-long">
                </form>


    </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td colspan=2>
                 %%yandex_note%%<br><br> ##payment_info##
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   ##--
   <tr>
     <td colspan=2 align=center>
                 <input type="button" name="print" value=" %%print_invoice%% " class="but-long" onclick="window.open('##print_url##?action=print&id=##id##')">
     </td>
   </tr>
   --##
</table>
"-->

<!--#set var="pay_form_paypal" value="
<table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
        <col width="150">
        <col width="*">
   <tr>
     <td colspan=2>
        %%got_invoice%%: <strong># ##invoice_num## %%from%% ##invoice_date##</strong><br><br><i>##service_description##</i>
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td colspan=2>
        %%pay_method%%: <strong>%%paypal%%</strong>
     </td>
   </tr>
   ##--
   <tr>
     <td colspan=2>
        %%amount%%: <strong>##amount_RUR## %%RUR%%</strong>
     </td>
   </tr>
   <tr>
     <td colspan=2>
        %%commission%%: <strong>##contractor_paypal_commission##%</strong>
     </td>
   </tr>
   --##
   <tr>
     <td colspan=2>
      ##--setvar @amount_commission = intval(amount_RUR * floatval( contractor_paypal_commission / 100 ))##
      ##setvar @amount_commission = amount_commission < 29 ? 29 : (amount_commission > 190 ? 190 : amount_commission)##
      ##setvar @amount_RUR_k = ( amount_RUR + amount_commission )--##

      %%to_pay%%: <strong>##amount_RUR## %%RUR%%</strong> ##--if( contractor_paypal_commission != '' )##%%with_commission%%##endif--##
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td colspan=2 align=center>
        <form action="https://www.paypal.com/cgi-bin/webscr" name="paypal_form" id="paypal_form" method="POST" target="_blank">
        <input type="hidden" name="cmd" value="_xclick" />
        <input type="hidden" name="charset" value="utf-8" />
        <input type="hidden" name="currency_code" value="##--USD--##RUB" />
        <input type="hidden" name="business" value="##contractor_paypal_account##" />
        <input type="hidden" name="image_url" value="http://www.amiro.ru/_img/amiro-logo-150x50.png" />
        <input type="hidden" name="item_name" value="AmiroCMS: ##description## ##domain## по счету ##invoice_num## от ##invoice_date##" />
        <input type="hidden" name="cn" value="Ваши заметки к оплате" />
        <input type="hidden" name="amount" value="##amount_RUR##" />
        <input type="hidden" name="first_name" value="##client_firstname##" />
        <input type="hidden" name="last_name" value="##client_lastname##" />
        <input type="hidden" name="email" value="##client_email##" />
##--        <input type="hidden" name="custom" value="##amount_RUR##" /> --##
        <input type="submit" value=" %%pay%% " class="but-long" />
        </form>
    </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
##--
   <tr>
     <td colspan=2>
        %%paypal_note%%<br><br> ##payment_info##
   </tr>
--##
   <tr>
         <td colspan=2><br></td>
   </tr>
   ##--
   <tr>
     <td colspan=2 align=center>
        <input type="button" name="print" value=" %%print_invoice%% " class="but-long" onclick="window.open('##print_url##?action=print&id=##id##')">
     </td>
   </tr>
   --##
</table>
##--
<script type="text/javascript">
document.getElementById('paypal_form').elements['amount'].value =
    Math.round(##amount_RUR## * 100 / ##IF(Yahoo_USD_RUB_rate)##(##Yahoo_USD_RUB_rate## - 0.5)##ELSE####contractor_paypal_usd_rate####ENDIF##) / 100;
</script>
--##
"-->

<!--#set var="pay_form_paypal_info" value="
##amount_num## %%paypal_to%% ##contractor_paypal##
<br><br><b>%%payment_note%%</b><br><br><i>##service_description## %%pay_invoice%% ##invoice_num## %%from%% ##invoice_date##</i></td>
"-->

<!--#set var="pay_form_rbk_bankCard; pay_form_rbk_euroset; pay_form_rbk_inner; pay_form_rbk_prepaidcard" value="
##setvar @pay_method = substr(pay_method, 4)##
<table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
        <col width="150">
        <col width="*">
   <tr>
     <td colspan=2>
                 %%got_invoice%%: <strong># ##invoice_num## %%from%% ##invoice_date##</strong><br><br><i>##service_description##</i>
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>
   <tr>
     <td colspan=2>
                 %%pay_method%%: <strong>%%##pay_method##%%</strong>
     </td>
   </tr>
   ##--
   <tr>
     <td colspan=2>
                 %%amount%%: <strong>##amount_RUR## %%RUR%%</strong>
     </td>
   </tr>
   <tr>
     <td colspan=2>
                 %%commission%%: <strong>##contractor_rbk_commission##%</strong>
     </td>
   </tr>
   --##
   <tr>
     <td colspan=2>
      ##setvar @amount_commission = intval( amount_RUR * floatval( contractor_rbk_commission / 100) )##
      ##setvar @amount_commission = ( amount_commission < 29 ) ? 29 : (( amount_commission > 190 ) ? 190 : amount_commission)##
      ##setvar @amount_RUR_k = ( intval(amount_RUR) + intval(amount_commission) )##

      %%to_pay%%: <strong>##amount_RUR_k## %%RUR%%</strong> ##if( contractor_rbk_commission != '' )##%%with_commission%%##endif##
     </td>
   </tr>
   <tr>
         <td colspan=2><br></td>
   </tr>



   <tr>
     <td colspan=2 align=center>
    <form action="https://rbkmoney.ru/acceptpurchase.aspx" name="rbk_form" method="POST" target=_blank>
    <input type="hidden" name="orderId" value="##--invoice_num--##">
    <input type="hidden" name="eshopId" value="##contractor_rbk##">
    <input type="hidden" name="preference" value="##pay_method##">
    <input type="hidden" name="serviceName" value="##description## ##domain## по счету ##invoice_num## от ##invoice_date## [rbk_##pay_method##]">
    <input type="hidden" name="user_email" value="##client_email##">
    <input type="hidden" name="recipientAmount" value="##amount_RUR_k##">
    <input type="hidden" name="userField_1" value="##invoice_num##">
    <input type="hidden" name="recipientCurrency" value="RUR">
    <input type="hidden" name="successUrl" value="">
    <input type="hidden" name="failUrl" value="">
<!--##amount_commission##-->
<input type="submit" value=" %%pay%% " class="but-long"">
</form>
<script>
    rbk_form.user_email.value = rbk_form.user_email.value.split(/\s/i)[0];
</script>

</td>
</tr>
</table>
"-->


<script type="text/javascript">
<!--
    var editor_enable = '##editor_enable##';
    var _cms_document_form = 'admform';
    var _cms_document_form_changed = false;
    var _cms_script_link = '##script_link##?';
    // -->
</script>
##if(hide_balance!='1')##
<br>
<table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
    <col width="150">
    <col width="*">
    <tr>
        <td>
            <b>%%balance%%:</b>
        </td>
        <td align=right>
            <b>##balance##</b>
        </td>
    </tr>
    <tr>
        <td>
            %%min_balance%%:
        </td>
        <td align=right>
            ##amount_min##
        </td>
    </tr>
    <tr>
        <td>
            %%amount_month%%:
        </td>
        <td align=right>
            ##amount_month##
        </td>
    </tr>
    <tr>
        <td>
            %%date_amount_zero%%:
        </td>
        <td align=right>
            ##date_amount_zero##
        </td>
    </tr>
</table>
<hr>
##endif##
##package_info##
<br>
<form action=##script_link## method=post enctype="multipart/form-data" name="payform">
    <input type="hidden" name="id" value="1">
    <input type="hidden" name="action" value="##action##">
    <input type="hidden" name="buy_type" value="##buy_type##">
    ##form##
</form>
##payment_form##

