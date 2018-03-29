%%include_template "templates/_payments_acts_docs.tpl"%%


<!--#set var="mail_body_ru" value="
В бухгалтерию ##client_name##

Данное письмо содержит электронную версию счета-фактуры на оказание
услуг доступа к системе управления сайтом ##domain## за прошедший период.

Оригиналы документов будут высланы вам по почте в начале квартала.

Просмотреть и распечатать все документы можно в 
панели управления сайтом в разделе Сервис - Платежи - Документы.

Просим своевремнно вносить изменения в реквизиты Вашей
компании в разделе Сервис - Платежи - Реквизиты.

--
С уважением,

коллектив ##contractor_name##.

"-->


<!--#set var="page_splitter" value="
<br style='mso-special-character:line-break; page-break-before:always'>
"-->

<!--#set var="filter_ru" value="
<div class=filter_block>
<form action=srv_host_payments_acts.php name=srv_host_payments_acts method=POST>
<input type=hidden name=form_action value="">
<a href="srv_host_payments_acts.php">сбросить фильтр</a>
<table class=filter_box>
<tr>
<td valign=top>
<table>
<tr><td>Курс:</td><td><input type=text name=currency_rate value="##currency_rate##"></td></tr>
<tr><td>СФ с номера:</td><td><input type=text name=start_num value="##start_num##"></td></tr>
##--<tr><td>АКТ с номера:</td><td><input type=text name=akt_start_num value="##akt_start_num##"></td></tr>--##
<tr><td>Дата документов:</td><td><input type=text name=doc_date value="##doc_date##"></td></tr>
<tr><td>Подготовлено документов:</td><td>##sf_number##</td></tr>
<tr><td>Сформировано счетов-фактур:</td><td>##sf_formed_number##</td></tr>
<tr><td>Сформировано актов:</td><td>##akt_formed_number##</td></tr>
</table></td>
<td valign=top width=50 nowrap>
</td>
<td valign=top>
<table>
<tr><td>С даты:</td><td><input type=text name=filter_from_date value="##filter_from_date##" class='fieldDate'></td></tr>
<tr><td>По дату:</td><td><input type=text name=filter_to_date value="##filter_to_date##" class='fieldDate'></td></tr>
<tr><td>Сайт:</td><td><input type=text name=filter_domain value="##filter_domain##"></td></tr>
<tr><td>Хостинг:</td><td><input type=checkbox name=filter_hosting value="1" ##filter_hosting##></td></tr>
<tr><td>Трафик:</td><td><input type=checkbox name=filter_trafic value="1" ##filter_trafic##></td></tr>
</table>
</td></tr>
</table>
<table border=0 cellspacing=0 cellpadding=3 class=filter_clients>
  <tr>
    <th>&nbsp;</th>
    <th>Сайт</th>
    <th>С даты</th>
    <th>Оплата за месяц</th>
    <th>Полных месяцев</th>
    <th>Сумма</th>
    <th>Задать сумму</th>
    <th>Номер документа</th>
    <th>Клиент</th>
    <th>Е-мэйл</th>
  </tr>
<tr><td colspan=10><b>Месяц:</b></td></tr>
##clients_month##
<tr><td colspan=10><b>Квартал:</b></td></tr>
##clients_quarter##
<tr><td colspan=10><b>Год:</b></td></tr>
##clients_year##
</table>
<br>
<input type=submit value="  Сформировать  ">
##if(sf_formed_number>0)##
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=submit value="  Провести  " onclick="this.form.form_action.value='check';">
##endif##
<br><br>
<b>Проведенные документы:</b><br>
<table border=0 cellspacing=0 cellpadding=3 class=filter_clients>
  <tr>
    <th>&nbsp;</th>
    <th>Сайт</th>
    <th>Дата</th>
    <th>Сумма</th>
    <th>Номер документа</th>
    <th>Клиент</th>
    <th>Е-мэйл</th>
  </tr>
##clients_formed##
</table>
<br>
<input type=submit value="  Распечатать документы " onclick="this.form.form_action.value='print';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=submit value="  Распечатать адреса " onclick="this.form.form_action.value='print_labels';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=submit value="  Отправить по Е-мэйл  " onclick="this.form.form_action.value='send';">

</form>
</div>
"-->

<!--#set var="mail_report_list_ru" value="
<div class=Section2>
<table cellpadding=0 cellspacing=0 width=100% class=mail_report>
<tr><td>
<center><b>Список заказных писем от ##contractor_name##</b></center><br><br>
</td></tr>
</table>
<table cellpadding=3 cellspacing=0 border=1 borderColor=#000000 width=100% class=mail_report>
<tr>
  <td><b>№<br>п/п</b>
  </td>
  <td><b>Наименование</b>
  </td>
  <td><b>Адрес</b>
  </td>
  <td><b>Номер</b>
  </td>
</tr>
##mail_report_items##
</table>
<br>
"-->

<!--#set var="mail_report_list_end_ru" value="
<table cellpadding=0 cellspacing=0 width=100% class=mail_report>
<tr><td>
<div align=right><b>Всего писем: ##mail_number##</b></div>
<blockquote>
Дата: &nbsp; _____ . ___________________ 20_____ г.&nbsp; 
<br><br>
Директор ##contractor_name##:&nbsp;__________________&nbsp;##contractor_fio##&nbsp;&nbsp;&nbsp;
</blockquote>
</td></tr>
</table>
</div>
"-->

<!--#set var="mail_report_row_ru" value="
      <tr>
        <td valign=center>
        <b>##mail_number##</b>
        </td>
        <td valign=top>
        ##client_name##
        </td>
        <td valign=top>
        ##client_post_address##
        <td nowrap>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </td>
      </tr>
"-->


<!--#set var="mail_labels_list" value="
<div class=Section2>
<table cellpadding=8 cellspacing=0 border=1 borderColor=#000000 width=100% class=mail_labels>
##mail_labels_items##
</table>
</div>
<br style='mso-special-character:line-break; page-break-before:always'>
"-->

<!--#set var="mail_label_row_ru" value="
      <tr>
        <td width=50% valign=top>
        <b>Откуда:</b><br>
        ##contractor_fiz_address##<br>
        <b>От кого:</b><br>
        ##contractor_name##
        </td>
        <td valign=top>
        <b>Куда:</b><br>
        ##client_fiz_address##<br>
        <b>Кому:</b><br>
        ##client_name##
        </td>
      </tr>
"-->


<!--#set var="clients_row" value="
      <tr class="client_##client_disabled##">
        <td><input type=checkbox name=chk_##id## value=1 ##client_check## ##client_disabled##></td>
        <td nowrap>
        <a href="http"//##domain##" target=_blank>##domain##</a>&nbsp;[##id##]<br>
        <a style="font-weight:normal" href="srv_host_payments_history.php?flt_search_domain=##domain##&flt_mode=simple" target=_blank>[платежи]</a>
        <a style="font-weight:normal" href="srv_host_payments_docs.php?flt_domain=##domain##&flt_mode=simple" target=_blank>[документы]</a>
        </td>
        <td nowrap>##period_dates##&nbsp;</td>
        <td align=right nowrap>##client_monthly_payment##&nbsp;</td>
        <td align=right nowrap>##periods_number##&nbsp;</td>
        <td align=right nowrap>##total_price_with_tax##&nbsp;</td>
        <td align=right nowrap><input type=text name=amount_##id## value="##total_manual_price_with_tax##" style="border:1px #c0c0c0 solid;text-align:right"class="field10">&nbsp;</td>
        <td nowrap>&nbsp;&nbsp;##doc_num##&nbsp;</td>
        <td>##client_name##&nbsp;</td>
        <td>##email##&nbsp;</td>
      </tr>
"-->

<!--#set var="clients_formed_row" value="
      <tr>
        <td><input type=checkbox name=send_##id## value=1 ##client_send##></td>
        <td nowrap>##domain##&nbsp;</td>
        <td nowrap>##date##&nbsp;</td>
        <td align=right nowrap>##amount##&nbsp;</td>
        <td nowrap>&nbsp;&nbsp;##doc_num##&nbsp;</td>
        <td>##client_name##&nbsp;</td>
        <td>##email##&nbsp;</td>
      </tr>
"-->




<!--#set var="body" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
##meta##
<title>##title##</title>
<style type="text/css">
  p, td, th { font-family: Tahoma;  font-size: 8pt;}

  @page Section1
	{size:595.3pt 420.95pt;
	margin:2.0cm 42.55pt 2.0cm 3.0cm;}

div.Section1
	{page:Section1;}

  @page Section2
	{size:595.3pt 841.9pt;
	margin:2.0cm 42.55pt 2.0cm 3.0cm;}

div.Section1
	{page:Section2;}

	@media print{
		.filter_block {
			display:none;
		}
	}

	@media screen{
		.filter_block {
			display:block;
		}
	}

TABLE.filter_clients {border-top: 1px #808080 solid;border-right: 1px #808080 solid;}
TABLE.filter_clients td, TABLE.filter_clients th {border-left: 1px #808080 solid;border-bottom: 1px #808080 solid;}
TABLE.filter_clients tr.client_{color:#006699;font-weight:bold;}
TABLE.filter_clients tr.client_disabled{color:#808080;}
TABLE.filter_clients td {font-size:12px;}
TABLE.filter_clients th {color:#000;}
TABLE.filter_box td {font-size:12px;}

TABLE.mail_labels td {font-size:12pt;}
TABLE.mail_report td {font-size:11pt;}
/*INPUT {border-width:expression(this.getAttribute("type")=="text"?"1px":"0px");border-style:solid;}*/

</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
##filter##
##status_messages##
##document_list##
##mail_labels_list##
##mail_report_list##
</body>
</html>
"-->
