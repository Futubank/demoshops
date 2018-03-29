%%include_language "templates/lang/_payments_docs.lng"%%

<!--#set var="invoice_mail_subj_ru" value="[BILLING:##domain##] Сформирован счет: ##invoice_num## от ##invoice_date##. "-->
<!--#set var="act_mail_subj_ru" value="[BILLING:##domain##] Выставлен акт/счет-фактура: ##act_num## от ##act_date##. "-->


<!--#set var="doc_bill_person_ru" value="
<style type="text/css">
div.main		{font-family: Tahoma, Arial; font-weight: normal; font-size: 8pt; color: #000000; width: 600px; text-align: justify}
div.main td		{font-family: Arial, Helvetica, sans-serif; font-size: 8pt;}
div.main a:visited   	{color: #000000;}
div.main a:link   		{color: #000000;}
div.main a:hover   	{color: #FF0000;}
div.main img		{border: 0px; width: 115px; height: 49px;  float: right;}
div.main .center		{text-align: center;}
div.main .sub 		{font-size: 7pt; font-family: Arial, Tahoma;}
div.main .table0		{width: 600px; border-collapse: collapse;}
div.main .table0 td		{border: 1px solid #000000; padding: 1px;}
div.main .table1		{width: 100%; border-collapse: collapse;}
div.main .table1 td		{border: 1px solid #000000; padding: 3px;}
div.main .table2		{padding: 0px; border: 0px none; border-collapse: collapse; border-spacing: 0px; width: 100%;}
div.main .table2 td		{border: 0px none; padding: 0px;}
</style>
<div class="center">
<div class="main">
<div style="width: 600px; text-align: justify; font-size: 8pt; font-family: Arial, Tahoma, Helvetica; border: 1px solid #A00000; padding: 3px; height:50">
<div style="color: #A00000; font-weight: bold; text-align: center; font-size: 10pt; font-family: Arial, Verdana, Helvetica; height:16">ВНИМАНИЕ!</div>
Данная квитанция действительна в течение 10 дней.<br>
Изменять поле &#34;Вид платежа&#34;, вносить в него дополнения или изменения категорически воспрещается. Если в это поле внесены изменения или дополнения любого вида, платеж не будет принят!
</div>
<table width=100%><tr><td style="font-family:wingdings 2;font-size:24px;" width=30>&#9988;</td><td><hr style="height:1px;border:1px #333333 dashed"></td></tr></table>
<table class="table0"><tbody>
<tr><td style="width: 200px">&nbsp;&nbsp;<b>ИЗВЕЩЕНИЕ</b><br><br><br><br><br><br><br><br><br><br><br><br><br>&nbsp;&nbsp;Кассир<br></td>
<td style="width: 410px">
<table class="table1"><tbody><tr><td colspan="3">
<table class="table2"><tbody><tr>
<td style="vertical-align: bottom">Получатель платежа: ##contractor_name##</td>
<td rowspan="3">&nbsp;</td></tr>
<tr><td>ИНН/КПП получателя: ##contractor_inn## / ##contractor_kpp##</td></tr>
</tbody></table>
</td></tr>
<tr><td colspan="3">Р/с: ##contractor_rs## в ##contractor_bank##
К/с:##contractor_ks## БИК: ##contractor_bik##</td>
</tr><tr><td colspan="3">##client_name##,&nbsp;##client_passport##
<div class="sub center">(фамилия, и. о., адрес плательщика)</div></td></tr>
<tr><td class="center">Вид платежа</td><td class="center">Дата</td><td class="center">Сумма</td></tr>
<tr><td><i>##service_description##</i></td><td style="width: 50px">&nbsp;##doc_date##</td><td style="width: 100px" class="center">##total_price_with_tax_str##</td></tr>
<tr><td rowspan="2" colspan="3"><br>Плательщик:</td></tr>
</tbody></table>
</td></tr>
<tr><td style="width: 200px">&nbsp;&nbsp;<b>КВИТАНЦИЯ</b><br><br><br><br><br><br><br><br><br><br><br><br><br>&nbsp;&nbsp;Кассир<br></td>
<td style="width: 410px">
<table class="table1"><tbody><tr><td colspan="3">
<table class="table2"><tbody><tr>
<td style="vertical-align: bottom">Получатель платежа: ##contractor_name##</td>
<td rowspan="3">&nbsp;</td></tr>
<tr><td>ИНН/КПП получателя: ##contractor_inn## / ##contractor_kpp##</td></tr>
</tbody></table>
</td>
</tr><tr>
<td colspan="3">Р/с: ##contractor_rs## в ##contractor_bank##
К/с: ##contractor_ks## БИК: ##contractor_bik## </td>
</tr><tr><td colspan="3">##client_name##,&nbsp;##client_passport##
<div class="sub center">(фамилия, и. о., адрес плательщика)</div></td></tr>
<tr><td class="center">Вид платежа</td><td class="center">Дата</td><td class="center">Сумма</td></tr>
<tr><td><i>##service_description##</i></td><td style="width: 50px">&nbsp;##doc_date##</td><td style="width: 100px" class="center">##total_price_with_tax_str##</td></tr>
<tr><td rowspan="2" colspan="3"><br />Плательщик:</td></tr>
</tbody></table>
</td></tr>
</tbody></table></div>
</div>
"-->


<!--#set var="doc_bill_fake_row_ru" value="
      <tr>
        <td align=right>##service_num##.</td>
        <td>##service_description##</td>
        <td align="right" nowrap>##price_with_tax##&nbsp;</td>
      </tr>
"-->

<!--#set var="doc_bill_fake_body_ru" value="
<div class=Section1>
<table border="0" cellpadding="0" cellspacing="5" width=100%>
  <tr>
    <td colspan="2" align=left>
    <strong>##contractor_alt_name##</strong><br />
		##IF(payment_type==4)##
   Кошелек WebMoney: <b>##contractor_wmr##</b><br />
		##ENDIF##
		##IF(payment_type==5)##
    Счет Яндекс.Деньги: <b>##contractor_yandex##</b><br />
		##ENDIF##
    </td>
  </tr><tr>
    <td colspan="2"><p align="center"style="font-size:12pt;font-family:Times"><strong>Счет №&nbsp;##doc_num## от ##doc_date##</strong></p></td>
  </tr><tr>
    <td valign="top" width="80%">
    Заказчик: <strong>##client_name##</strong><br /></td>
    <td align=right valign=top></td>
  </tr>
  <tr>
    <td colspan=2><center>
    <table border="1" cellpadding="3" cellspacing="0" width="100%" bordercolorlight="#000000" bordercolordark="#000000">
      <tr>
        <th>№</th>
        <th>Наименование работы (услуги)</th>
        <th>Сумма</th>
      </tr>

      ##doc_rows##

      <tr>
        <td>&nbsp;</td>
        <td>Всего:</td>
        <td align="right">##total_price_with_tax##&nbsp;</td>
      </tr>
    </table>
    </center>
    <p>Всего на сумму: ##total_price_with_tax_str## (##total_price_with_tax_words##) ##IF(total_tax_value==0)##НДС НЕ ОБЛАГАЕТСЯ##ENDIF##</p>
    <p>Счет действителен в течение 10 дней.</p>
	</td>
  </tr>
</table>
</div>
<div class=Section2>
<table border="0" cellpadding="0" cellspacing="5" width=100% height=100%>
  <tr><td valign=bottom align=right>
    <div style="text-align:left;width:290pt;height:100pt;padding:20pt 5pt 10pt 10pt;font-size:16px;">Куда: ##client_post_address##<br /><br />Кому: ##client_name##</div>
  </td></tr>
  </table>
</div>
"-->


<!--#set var="doc_bill_company_row_ru;doc_bill_ip_row_ru;" value="
      <tr>
        <td align=right>##service_num##.</td>
        <td>##service_description##</td>
        ##--<td align="center">шт.</td>
        <td align="center">1</td>
        <td align="right" nowrap>##price##&nbsp;</td>--##
        <td align="right" nowrap>##price##&nbsp;</td>
        <td align="right" nowrap>##tax##&nbsp;</td>
        <td align="right" nowrap>##tax_value##&nbsp;</td>
        <td align="right" nowrap>##price_with_tax##&nbsp;</td>
      </tr>
"-->


<!--#set var="doc_bill_company_body_ru;doc_bill_ip_body_ru" value="
<div class=Section1>
<table border="0" cellpadding="0" cellspacing="5" width=100%>
  <tr>
    <td colspan="2" align=left>
    <strong>##contractor_name##</strong><br />
    Адрес: ##contractor_address##<br />
    ИНН/КПП: ##contractor_inn##/##contractor_kpp##<br />
    БИК: ##contractor_bik##<br />
    Банк: ##contractor_bank##<br />
    Счет: ##contractor_rs##<br />
    Корр.счет: ##contractor_ks##<br />
    </td>
  </tr><tr>
    <td colspan="2"><p align="center"style="font-size:12pt;font-family:Times"><strong>Счет №&nbsp;##doc_num## от ##doc_date##</strong></p></td>
  </tr><tr>
    <td valign="top" width="80%">
    Заказчик: <strong>##client_name##</strong><br /></td>
    <td align=right valign=top></td>
  </tr>
  <tr>
    <td colspan=2><center>
    <table border="1" cellpadding="3" cellspacing="0" width="100%" bordercolorlight="#000000" bordercolordark="#000000">
      <tr>
        <th>№</th>
        <th>Наименование работы (услуги)</th>
        ##--<th>Ед.изм.</th>
        <th>Кол-во</th>
        <th>Цена</th>--##
        <th>Сумма</th>
        <th>Нало-<br />говая<br />ставка</th>
        <th>Сумма<br />налога</th>
        <th>Всего с<br />налогом</th>
      </tr>

      ##doc_rows##

      <tr>
        <td>&nbsp;</td>
        <td>Всего:</td>
        ##--<td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>--##
        <td align="right">##total_price##&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">##total_tax##&nbsp;</td>
        <td align="right">##total_price_with_tax##&nbsp;</td>
      </tr>
    </table>
    </center>
    <p>Всего на сумму: ##total_price_with_tax_str## (##total_price_with_tax_words##) ##IF(total_tax_value==0)##НДС НЕ ОБЛАГАЕТСЯ##ENDIF##</p>
    <table border="0" cellpadding="0" cellspacing="0" width=100%>
	  <tr>
        <td align=right height=20>Руководитель:</td>
        <td rowspan=3 valign=top>
				##if (set_sign==1&&contractor_sign1!="")##
				<img src="http://##builder_domain##/##contractor_sign1##">
				##else##
				&nbsp; __________________&nbsp; 
				##endif##
				</td>
        <td>##contractor_fio##&nbsp;&nbsp;&nbsp;</td>
				<td rowspan=3>
				##if (set_sign==1&&contractor_stamp!="")##
				<img src="http://##builder_domain##/##contractor_stamp##">
				##else##
				&nbsp;&nbsp;&nbsp;МП&nbsp;&nbsp;&nbsp;
				##endif##
				</td>
        <td align=right>Бухгалтер:</td>
        <td rowspan=3 valign=top>
				##if (set_sign==1&&contractor_sign2!="")##
				<img src="http://##builder_domain##/##contractor_sign2##">
				##else##
				&nbsp; __________________&nbsp; 
				##endif##
				</td>
        <td>##contractor_fio##</td>
      </tr>
	  <tr>
        <td align="right">&nbsp;</td>
        ##--<td>(подпись)</td>--##
        <td valign=top>(ф.и.о.)</td>
        <td align="right">&nbsp;</td>
        ##--<td>(подпись)</td>--##
        <td valign=top>(ф.и.о.)</td>
      </tr>
	  <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
    <p>Счет действителен в течение 10 дней.</p>
	</td>
  </tr>
</table>
</div>

<div class=Section2>
<table border="0" cellpadding="0" cellspacing="5" width=100% height=100%>
  <tr><td valign=bottom align=right>
    <div style="text-align:left;width:290pt;height:100pt;padding:20pt 5pt 10pt 10pt;font-size:16px;">Куда: ##client_post_address##<br /><br />Кому: ##client_name##</div>
  </td></tr>
  </table>
</div>


"-->


<!--#set var="doc_sf_row_ru" value="
      <tr>
        <td class=small>##service_description##</td>
        <td align="center">1</td>
        <td align="center">1</td>
        <td align="right" nowrap>##price##&nbsp;</td>
        <td align="right" nowrap>##price##&nbsp;</td>
        <td align="right">0.00&nbsp;</td>
        <td align="right" nowrap>##tax##&nbsp;</td>
        <td align="right" nowrap>##tax_value##&nbsp;</td>
        <td align="right" nowrap>##price_with_tax##&nbsp;</td>
        <td align="center">-</td>
        <td>&nbsp;</td>
      </tr>
"-->

<!--#set var="doc_sf_body_ru" value="
<div class=Section1>
<table border="0" cellpadding="0" cellspacing="5" width=100%>
  <tr>
    <td colspan=2 valign="top" >
    <p align="center" style="font-size:12pt;font-family:Times"><strong>Счет-фактура №&nbsp;##doc_num## от ##doc_date##</strong></p>
    
    Продавец: <strong>##contractor_name##</strong><br />
    Адрес: <strong>##contractor_jur_address####contractor_address##</strong><br />
    ИНН/КПП продавца: <strong>##contractor_inn## / ##contractor_kpp##</strong><br />
    Грузоотправитель и его адрес: <strong>##contractor_name## ##contractor_fiz_address##</strong><br />
    Грузополучатель и его адрес: <strong>##client_name## ##client_fiz_address##</strong><br />
    К платежно-расчетному документу: <strong>##payment_docs##</strong> </strong><br />
    Покупатель: <strong>##client_name## ##client_passport##</strong><br />
    Адрес: <strong>##client_jur_address####client_address##</strong><br />
    ИНН/КПП покупателя: <strong>##client_inn## / ##client_kpp##</strong><br />
    ##--<td align=right valign=top><font color="gray">##self_copy##</font></td>--##
  </tr>
  <tr>
    <td colspan="2">
    <center>
    <table border="1" cellpadding="3" cellspacing="0" width="100%" bordercolorlight="#000000" bordercolordark="#000000">
      <tr>
        <td>Наименование товара (описание выполненных работ, оказанных услуг), имущественного права</td>
        <td>Единица измерения</td>
        <td>Коли-чество</td>
        <td>Цена(тариф) за единицу измерения</td>
        <td>Стоимость товаров (работ, услуг), имущественных прав, всего без налога </td>
        <td>В том числе акциз</td>
        <td>Налоговая ставка</td>
        <td>Сумма налога</td>
        <td>Стоимость товаров (работ, услуг), имущественных прав, всего с учетом налог</td>
        <td>Страна происхождения</td>
        <td>Номер таможенной декларации</td>
      </tr>
      <tr>
        <td align="center">1</td>
        <td align="center">2</td>
        <td align="center">3</td>
        <td align="center">4</td>
        <td align="center">5</td>
        <td align="center">6</td>
        <td align="center">7</td>
        <td align="center">8</td>
        <td align="center">9</td>
        <td align="center">10</td>
        <td align="center">11</td>
      </tr>

      ##doc_rows##

      <tr>
        <td colspan=7>Всего к оплате:</td>
##--
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">##total_price##&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
--##
        <td align="right">##total_tax##&nbsp;</td>
        <td align="right">##total_price_with_tax##&nbsp;</td>
##--
        <td>&nbsp;</td>
        <td>&nbsp;</td>
--##
      </tr>
    </table>
    </center><br>##--<p>Всего: ##total_price_with_tax_str## (##total_price_with_tax_words##)</p>--##
    <table border="0" cellpadding="0" cellspacing="0" width=100%>
	  <tr>
        <td align=right>Руководитель организации<br>(предприятия)</td>
        <td rowspan=2 valign=top>
				##if (set_sign==1&&contractor_sign1!="")##
				<img src="http://##builder_domain##/##contractor_sign1##">
				##else##
				&nbsp; __________________&nbsp; 
				##endif##
				</td>
        <td>##contractor_fio##&nbsp;&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;&nbsp;</td>
        <td align=right>Гл.&nbsp;бухгалтер</td>
        <td rowspan=2 valign=top>
				##if (set_sign==1&&contractor_sign2!="")##
				<img src="http://##builder_domain##/##contractor_sign2##">
				##else##
				&nbsp; __________________&nbsp; 
				##endif##
				</td>
        <td nowrap>##contractor_fio##</td>
      </tr>
	  <tr>
        <td align="right">&nbsp;</td>
        <td>(ф.и.о.)</td>
		<td>&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td>(ф.и.о.)</td>
      </tr>
      <tr><td colspan=5><br></td></tr>
      <tr>
        <td align=right nowrap>Индивидуальный предприниматель</td>
        <td>&nbsp; __________________&nbsp; </td>
        <td>##--contractor_fio--##&nbsp;&nbsp;&nbsp;</td>
        <td></td>
        <td colspan=3  rowspan=2 align=left>Реквизиты свидетельства о государственной регистрации<br> 
        индивидуального предпринимателя 
        ____________________________________________________</td>
      </tr>
	  <tr>
        <td align="right">&nbsp;</td>
        <td>(подпись)</td>
        <td>(ф.и.о.)</td>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
      </tr>
    </table>
    <p style="font-size:7pt">Примечание.<br>Первый экземпляр покупателю, второй экземпляр - продавцу.</p>
    <p style="font-size:7pt">ОПЛАТЕ НЕ ПОДЛЕЖИТ!</p>
	</td>
  </tr>
</table>
</div>
"-->

<!--#set var="doc_act_row_ru" value="
      <tr>
        <td align=right>##service_num##.</td>
        <td class=small>##service_description##</td>
        <td align="center">шт.</td>
        <td align="center">1</td>
        <td align="right" nowrap>##price##&nbsp;</td>
        <td align="right" nowrap>##price##&nbsp;</td>
        <td align="right" nowrap>##tax##&nbsp;</td>
        <td align="right" nowrap>##tax_value##&nbsp;</td>
        <td align="right" nowrap>##price_with_tax##&nbsp;</td>
      </tr>
"-->

<!--#set var="doc_act_body_ru" value="
<div class=Section1>
<table border="0" cellpadding="0" cellspacing="5" width=100% >
  <tr>
    <td colspan="2" align=left><strong>
    <strong>##contractor_name##</strong><br />
    ##if(contractor_inn!="")##
    <strong>ИНН ##contractor_inn##</strong><br />
    ##endif##

    Адрес: <strong>##contractor_fiz_address##</strong><br />
    </strong></td>
  </tr><tr>
    <td colspan="2"><p align="center"style="font-size:12pt;font-family:Times"><strong>Акт на оказание услуг №&nbsp;##doc_num## от ##doc_date##</strong></p>
  </tr><tr>
    <td valign="top" width="80%">
    Заказчик: <strong>##client_name##</strong><br />
    ##IF(client_contract!="")##     Основание: <strong>Договор № ##client_contract##</strong><br> ##ENDIF##
    ##IF(client_inn!="")##         ИНН: <strong>##client_inn##</strong><br /> ##ENDIF##
    ##IF(client_address!="")##      Адрес: <strong>##client_address##</strong><br /> ##ENDIF##
    ##IF(client_post_address!="")## Почтовый адрес: <strong>##client_post_address##</strong><br />##ENDIF##

    <td align=right valign=top><font color="gray">##self_copy##</font></td>
  </tr>
  <tr>
  <td align="left" colspan=2>
    <table border="1" cellpadding="3" cellspacing="0" width="100%" bordercolorlight="#000000" bordercolordark="#000000" align="center">
      <tr>
        <th>№</th>
        <th>Наименование работы (услуги)</th>
        <th>Ед.изм.</th>
        <th>Кол-во</th>
        <th>Цена</th>
        <th>Сумма</th>
        <th>Нало-<br />говая<br />ставка</th>
        <th>Сумма<br />налога</th>
        <th>Всего с<br />налогом</th>
      </tr>

      ##doc_rows##

      <tr>
        <td>&nbsp;</td>
        <td>Всего:</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">##total_price##&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">##total_tax##&nbsp;</td>
        <td align="right">##total_price_with_tax##&nbsp;</td>
      </tr>
    </table>
    <p>Всего оказано услуг на сумму: ##total_price_with_tax_str## (##total_price_with_tax_words##)</p>
    <p>Вышеперечисленные услуги выполнены полностью и в срок. Заказчик по обьему, качеству и срокам оказания услуг претензий не имеет.</p>
    <table border="0" cellpadding="0" cellspacing="0" width=100%>
	  <tr>
        <td align=right>Исполнитель:</td>
        <td rowspan=2>
				##if(set_sign==1&&contractor_sign1!="")##
				<img src="http://##builder_domain##/##contractor_sign1##">
				##else##
				&nbsp; __________________&nbsp; 
				##endif##
				</td>
        <td>##contractor_fio##&nbsp;&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td align=right>Заказчик:</td>
        <td>&nbsp; __________________&nbsp; </td>
        <td>##client_fio##</td>
      </tr>
	  <tr>
        <td align="right">&nbsp;</td>
        <td>(ф.и.о.)</td>
		<td>&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td>(подпись)</td>
        <td>(ф.и.о.)</td>
      </tr>
	  <tr>
        <td></td>
        <td align=center>
				##if(set_sign==1&&contractor_stamp!="")##
				<img src="http://##builder_domain##/##contractor_stamp##">
				##else##
				&nbsp;&nbsp;&nbsp;МП&nbsp;&nbsp;&nbsp;
				##endif##
				</td>
        <td></td>
		<td>&nbsp;</td>
        <td></td>
        <td align=center>МП</td>
        <td></td>
      </tr>
    </table>
    <p style="font-size:7pt">ОПЛАТЕ НЕ ПОДЛЕЖИТ!</p>
	</td>
  </tr>
</table>
</div>

<div class=Section2>
<table border="0" cellpadding="0" cellspacing="5" width=100% height=100%>
  <tr><td valign=bottom align=right>
    <div style="text-align:left;width:290pt;height:100pt;padding:20pt 5pt 10pt 10pt;font-size:16px;">Куда: ##client_post_address##<br /><br />Кому: ##client_name##</div>
  </td></tr>
  </table>
</div>
"-->

<!--#set var="html_body_block_ru" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
##content##
</body>
</html>
"-->


<!--#set var="act_mail_body_ru" value="
Уважаемый(ая) ##client_name##, <br>
системой расчетов за прошедший период выставлен акт\счет-фактура ##act_num## от ##act_date## на сумму ##amount## <br>
<br>
<br>
Электронная версия документа приложена к данному письму.<br>
<br>
Чтобы сохранить правильный внешний вид документа при печати, <br>
откройте приложенный файл при подключеном Интернете и произведите печать.<br>
<br>
<br>
ДОКУМЕНТ НЕ ОПЛАЧИВАЕТСЯ!
<br>
<br>
--<br>
##contractor_name##<br>
##contractor_email##<br>
"-->


<!--#set var="invoice_mail_body_ru" value="
Уважаемый(ая) ##client_name##, <br>
по запросу в панели управления сайтом сформирован счет на оплату ##invoice_num## от ##invoice_date## на сумму ##amount## <br>
<br>
<br>
Электронная версия документа приложена к данному письму.<br>
<br>
Чтобы сохранить правильный внешний вид документа при печати, <br>
откройте приложенный файл при подключеном Интернете и произведите печать.<br>
<br>
<br>
--<br>
##contractor_name##<br>
##contractor_email##<br>
"-->

<!--#set var="page_splitter" value="
<br style='mso-special-character:line-break; page-break-before:always'>
"-->

<!--#set var="body" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
##meta##
<title>##title##</title>
<style type="text/css">
  p, td, th { font-family: Tahoma;  font-size: 8pt;}


/*
  @page Section1
	{size:595.3pt 420.95pt;
	margin:2.0cm 42.55pt 2.0cm 3.0cm;}

div.Section1
	{page:Section1;}

  @page Section2
	{size:595.3pt 841.9pt;
	margin:2.0cm 42.55pt 2.0cm 3.0cm;}

	@media print{
		.messages_block {
			display:none;
		}
	}

	@media screen{
		.messages_block {
			display:block;
		}

div.Section1
	  {page:Section2;
    }
*/

div.Section1, div.Section2{
    width:595.3pt ; height: 435.95pt;
	}
</style>
<SCRIPT LANGUAGE="JavaScript">
<!--
function printPage() {
//    if(confirm("%%print_warn%%")) {
        window.print();
//    }
}
//-->
</SCRIPT>
</head>
<body bgcolor="#FFFFFF" text="#000000" onload="printPage()">
<div id="messages_block">##status_messages##</div>
##document_list##
</body>
</html>
"-->
