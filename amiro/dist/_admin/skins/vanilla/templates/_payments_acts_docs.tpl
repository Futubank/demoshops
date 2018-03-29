<!--#set var="doc_invoice_fiz_ru" value="
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
Изменять поле &#34;Вид платежа&#34;, вносить в него дополнения или изменения категорически воспрещается. Если в это поле внесены изменения или дополнения любого вида, платеж не будет принят!
</div>
<table width=100%><tr><td style="font-family:wingdings 2;font-size:24px;" width=30>%</td><td><hr style="height:1px;border:1px #333333 dashed"></td></tr></table>
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
<tr><td><i>##service_description##</i></td><td style="width: 50px">&nbsp;##invoice_date##</td><td style="width: 100px" class="center">##amount##</td></tr>
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
<tr><td><i>##service_description##</i></td><td style="width: 50px">&nbsp;##invoice_date##</td><td style="width: 100px" class="center">##amount##</td></tr>
<tr><td rowspan="2" colspan="3"><br />Плательщик:</td></tr>
</tbody></table>
</td></tr>
</tbody></table></div>
</div>
"-->



<!--#set var="doc_invoice_jur_row_ru" value="
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


<!--#set var="doc_invoice_jur_body_ru" value="
<div class=Section1>
<table border="0" cellpadding="0" cellspacing="5" width=100%>
  <tr>
    <td colspan="2" align=left>
    <strong>##contractor_name##</strong><br />
    Адрес: ##contractor_address##<br />
    ИНН/КПП: ##contractor_inn##/##contractor_inn##<br />
    БИК: ##contractor_bik##<br />
    Банк: ##contractor_bank##<br />
    Счет: ##contractor_rs##<br />
    Корр.счет: ##contractor_ks##<br />
    </td>
  </tr><tr>
    <td colspan="2"><p align="center"style="font-size:12pt;font-family:Times"><strong>Счет №&nbsp;##invoice_num## от ##invoice_date##</strong></p></td>
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

      ##invoice_rows##

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
    <p>Всего на сумму: ##total_price_with_tax## Руб. (##total_price_with_tax_words##)</p>
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

	</td>
  </tr>
</table>
</div>
"-->


<!--#set var="doc_sf_row_ru" value="
      <tr>
        <td>##service_description##</td>
        <td align="center">1</td>
        <td align="center">1</td>
        <td align="right" nowrap>##price##&nbsp;</td>
        <td align="right" nowrap>##price##&nbsp;</td>
        <td align="right">0.00&nbsp;</td>
        <td align="right" nowrap>##tax##%&nbsp;</td>
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
    Адрес: <strong>##contractor_jur_address##</strong><br />
    ИНН/КПП продавца: <strong>##contractor_inn## / ##contractor_kpp##</strong><br />
    Грузоотправитель и его адрес: <strong>##contractor_name## ##contractor_fiz_address##</strong><br />
    Грузополучатель и его адрес: <strong>##client_name## ##client_fiz_address##</strong><br />
    К платежно-расчетному документу _____________________________________________________</strong><br />
    Покупатель: <strong>##client_name## ##client_passport##</strong><br />
    Адрес: <strong>##client_jur_address##</strong><br />
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
    </center><br>##--<p>Всего: ##total_price_with_tax## Руб. (##total_price_with_tax_words##)</p>--##
    <table border="0" cellpadding="0" cellspacing="0" width=100%>
	  <tr>
        <td align=right>Руководитель организации<br>(предприятия)</td>
        <td>&nbsp; __________________&nbsp; </td>
        <td>##contractor_fio##&nbsp;&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;&nbsp;</td>
        <td align=right>Гл.&nbsp;бухгалтер</td>
        <td>&nbsp; __________________&nbsp; </td>
        <td nowrap>##contractor_fio##</td>
      </tr>
	  <tr>
        <td align="right">&nbsp;</td>
        <td>(подпись)</td>
        <td>(ф.и.о.)</td>
		<td>&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td>(подпись)</td>
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
	</td>
  </tr>
</table>
</div>
"-->

<!--#set var="doc_akt_row_ru" value="
      <tr>
        <td align=right>##service_num##.</td>
        <td>##service_description##</td>
        <td align="center">1</td>
        <td align="center">1</td>
        <td align="right" nowrap>##price##&nbsp;</td>
        <td align="right" nowrap>##price##&nbsp;</td>
        <td align="right" nowrap>##tax##%&nbsp;</td>
        <td align="right" nowrap>##tax_value##&nbsp;</td>
        <td align="right" nowrap>##price_with_tax##&nbsp;</td>
      </tr>
"-->

<!--#set var="doc_akt_body_ru" value="
<div class=Section1>
<table border="0" cellpadding="0" cellspacing="5" width=100%>
  <tr>
    <td colspan="2" align=left><strong>
    <strong>##contractor_name##</strong><br />
    Адрес: <strong>##contractor_fiz_address##</strong><br />
    </strong></td>
  </tr><tr>
    <td colspan="2"><p align="center"style="font-size:12pt;font-family:Times"><strong>Акт №&nbsp;##akt_num## от ##doc_date##</strong></p>
  </tr><tr>
    <td valign="top" width="80%">
    Заказчик: <strong>##client_name##</strong><br />
    ##--Основание: <strong>Договор № ##client_dog_no##</strong><br>--##
    <td align=right valign=top><font color="gray">##self_copy##</font></td>
  </tr>
  <tr>
    <div align="center"><center>
    <table border="1" cellpadding="3" cellspacing="0" width="100%" bordercolorlight="#000000" bordercolordark="#000000">
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

      ##akt_rows##

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
    </center>
    </div><p>Всего оказано услуг на сумму: ##total_price_with_tax## Руб. (##total_price_with_tax_words##)</p>
    </div><p>Вышеперечисленные услуги выполнены полностью и в срок. Заказчик по обьему, качеству и срокам оказания услуг претензий не имеет.</p>
    <table border="0" cellpadding="0" cellspacing="0" width=100%>
	  <tr>
        <td align=right>Исполнитель:</td>
        <td>&nbsp; __________________&nbsp; </td>
        <td>##contractor_fio##&nbsp;&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td align=right>Заказчик:</td>
        <td>&nbsp; __________________&nbsp; </td>
        <td>##client_fio##</td>
      </tr>
	  <tr>
        <td align="right">&nbsp;</td>
        <td>(подпись)</td>
        <td>(ф.и.о.)</td>
		<td>&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td>(подпись)</td>
        <td>(ф.и.о.)</td>
      </tr>
	  <tr>
        <td></td>
        <td align=center>МП</td>
        <td></td>
		<td>&nbsp;</td>
        <td></td>
        <td align=center>МП</td>
        <td></td>
      </tr>
    </table>
	</td>
  </tr>
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

<!--#set var="invoice_mail_subj_ru" value="[BILLING:##domain##] Сформирован счет: ##invoice_num## от ##invoice_date##. "-->

<!--#set var="invoice_mail_body_ru" value="
Уважаемый(ая) "##client_name##", по вашему запросу<br>
сформирован счет # ##invoice_num## от ##invoice_date## на сумму ##amount## <br>
<br>
<i>##service_description##</i><br>
<br>
Способ оплаты: ##pay_method_name##<br>
<br>
##if (invoice!='')##
Электронная версия счета приложена к данному письму.<br>
<br>
##--Чтобы сохранить правильный внешний вид документа при печати, <br>
откройте приложенный файл и произведите печать.--##<br>
##else##
Информация для оплаты:<br>
<br>
##payment_info##
##endif##
<br>
<br>
--<br>
##contractor_name##<br>
##contractor_email##<br>
"-->
