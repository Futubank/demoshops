<!--#set var="header_ru" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>##subject##</title>
</head>
<body>
"-->

<!--#set var="header_en" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>##subject##</title>
</head>
<body>
"-->


<!--#set var="footer_ru" value="
<br>
============================================================<br>
</body>
</html>
"-->

<!--#set var="footer_en" value="
<br>
============================================================<br>
</body>
</html>
"-->

--------------- remind ------------------------

<!--#set var="remind_subject_en" value="Paid for ##domain## until ##date##"-->
<!--#set var="remind_subject_ru" value="##domain##: дата исчерпания средств ##date##"-->


<!--#set var="remind_body_ru" value="
<br>
Домен: ##domain##<br><br>
##date## остаток на вашем счету достигнет минимально разрешенного значения, ##amount_min##.<br>
Состояние счета на ##curdate##: ##amount##<br>
##--Последний платеж: ##last_payment##<br>--##
<br>
Доступ в панель администратора будет заблокирован ##date## .

<br>
"-->

<!--#set var="remind_body_en" value="
Domain: ##domain##<br>
Amount by ##curdate##: ##amount##<br>
Min. amount: ##amount_min##
##--Last payment: ##last_payment##<br>--##
<br>
Admin panel will be blocked at ##date##
<br>
"-->

--------------- date_amount_zero --------------

<!--#set var="daz_subject_en" value="##domain##: fund reached minimum at ##curdate##"-->
<!--#set var="daz_subject_ru" value="##domain##: средства исчерпаны ##curdate##"-->


<!--#set var="daz_body_ru" value="
<br>
Домен: ##domain##<br>
Остаток достиг минимума ##curdate##<br>
Состояние счета на ##curdate##: ##amount##<br>
Минимальный остаток: ##amount_min##<br>
##--Последний платеж: ##last_payment##<br>--##
<br>
Панель администратора заблокирована.<br>
Сайт будет заблокирован ##date##.

<br>
"-->

<!--#set var="daz_body_en" value="
Domain: ##domain##<br>
Fund reached minimum at ##curdate##<br>
Amount by ##curdate##: ##amount##<br>
Min. amount: ##amount_min##
##--Last payment: ##last_payment##<br>--##
<br>
Admin panel is blocked now.<br>
Website will be blocked at ##date##
<br>
"-->

--------------- suspend --------------

<!--#set var="suspend_subject_en" value="##domain##: site suspended at ##curdate##"-->
<!--#set var="suspend_subject_ru" value="##domain##: сайт заблокирован ##curdate##"-->


<!--#set var="suspend_body_ru" value="
<br>
Домен: ##domain##<br>
Состояние счета на ##curdate##: ##amount##<br>
Минимальный остаток: ##amount_min##<br>
##--Последний платеж: ##last_payment##<br>--##
<br>
Сайт будет удален ##date##.

<br>
"-->

<!--#set var="suspend_body_en" value="
Domain: ##domain##<br>
Amount by ##curdate##: ##amount##<br>
Min. amount: ##amount_min##
##--Last payment: ##last_payment##<br>--##
<br>
Website will be deleted at ##date##
<br>
"-->

--------------- delete --------------

<!--#set var="delete_subject_en" value="##domain##: site deleted at ##curdate##"-->
<!--#set var="delete_subject_ru" value="##domain##: сайт удален ##curdate##"-->


<!--#set var="delete_body_ru" value="
<br>
Домен: ##domain##<br>
Состояние счета на ##curdate##: ##amount##<br>
Минимальный остаток: ##amount_min##<br>
##--Последний платеж: ##last_payment##<br>--##
<br>
Сайт удален.

<br>
"-->

<!--#set var="delete_body_en" value="
Domain: ##domain##<br>
Amount by ##curdate##: ##amount##<br>
Min. amount: ##amount_min##
##--Last payment: ##last_payment##<br>--##
<br>
Website has been deleted
<br>
"-->

