<!--#set var="status_subject_en" value="Status of your website ##webname## has been changed."-->
<!--#set var="status_subject_ru" value="Статус вашего вебсайта ##webname## изменен."-->

<!--#set var="header_ru" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>##subject##</title>
</head>
<body>
##--
============================================================<br>
<a href="##company_url##?ref=wz_mail">##company_name##</a><br>
============================================================<br>
--##
"-->

<!--#set var="header_en" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>##subject##</title>
</head>
<body>
##--
============================================================<br>
<a href="##company_url##?ref=wz_mail">##company_name##</a><br>
============================================================<br>
--##
"-->


<!--#set var="footer_ru" value="
<br>
============================================================<br>
<font size="-1">
С уважением,<br>
<a href="##company_url##?ref=wz_mail">##company_name##</a><br>
По всем вопросам обращайтесь в службу поддержки:<br>
телефон: (3832) 106-048<br>
факс:  (3832) 106-123<br>
почта: <a href="mailto:##company_email##">##company_email##</a>
</font>
<br>
============================================================<br>
</body>
</html>
"-->

<!--#set var="footer_en" value="
<br>
============================================================<br>
<font size="-1">
Sincerely,<br>
<a href="##company_url##?ref=wz_mail">##company_name##</a><br>
If you have any questions, please, contact our support service:<br>
phone: +1-360-251-8396 <br>
fax:  +1-800-660-8034<br>
email: <a href="mailto:##company_email##">##company_email##</a>
</font>
<br>
============================================================<br>
</body>
</html>
"-->

<!--#set var="mail_body_ru" value="
Добрый день##recipient_name##.
<br>
Статус вашего вебсайта <strong>##webname##</strong> изменен.
<br>
Текущий статус:
<br>
<ul>
<li>Сайт: ##site_status##</li>
<li>Интерфейс администратора: ##admin_status##</li>
<li>Доступ по FTP разрешен: ##ftp_status##</li>
</ul>
<br>
##add_text##
<br>
"-->

<!--#set var="mail_body_en" value="
Hello##recipient_name##.
<br>
Status of your site <strong>##webname##</strong> has been changed.
<br>
Current status:
<br>
<ul>
<li>Site: ##site_status##</li>
<li>Administration panel: ##admin_status##</li>
<li>FTP access enabled: ##ftp_status##</li>
</ul>
<br>
##add_text##
"-->

<!--#set var="admin_mail_body_ru" value="
"-->

<!--#set var="admin_mail_body_en" value="
"-->
