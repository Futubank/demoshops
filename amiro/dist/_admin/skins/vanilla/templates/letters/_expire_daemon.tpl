
<!--#set var="footer_ru" value="
<pre>
============================================================
С уважением,
ВебСайт Мастер
По всем вопросам обращайтесь в службу поддержки:
телефон: (383) 210-60-48
факс: (383) 210-61-23
почта: ##support_email## 
============================================================
</pre>
"-->

<!--#set var="footer_en" value="
<pre>
============================================================
Contact WebSiteMaster at ##support_email## 
============================================================
</pre>
"-->

========= adm_suspended ===========

<!--#set var="adm_suspended_subject_en" value="##em_sort_tag## ##domain##: Admin panel has been suspended"-->
<!--#set var="adm_suspended_subject_ru" value="##em_sort_tag## ##domain##: Панель управления заблокирована "-->


<!--#set var="adm_suspended_body_en" value="
<pre>
Admin panel for http://##domain##/ has been suspended because license has expired.
The site http://##domain##/ will be suspended at ##suspend_date##.
The site will be deleted at ##delete_date##.
</pre>
"-->

<!--#set var="adm_suspended_body_ru" value="
<pre>

Панель администратора для сайта ##domain## заблокирована по окончании лицензии.
Сайт будет заблокирован ##suspend_date##.
Сайт будет удален ##delete_date##.
</pre>
"-->

========= soon ===========

<!--#set var="soon_subject_en" value="##em_sort_tag## ##domain##: License expires at ##expdate## "-->
<!--#set var="soon_subject_ru" value="##em_sort_tag## ##domain##: Лицензия заканчивается ##expdate## "-->


<!--#set var="soon_body_en" value="
<pre>
http://##domain##/ license expires at ##expdate##.
Admin panel for http://##domain##/ will be suspended at ##expdate##.
The site will be suspended at ##suspend_date##.
The site will be deleted at ##delete_date##.
</pre>
"-->

<!--#set var="soon_body_ru" value="
<pre>
Лицензия на сайт http://##domain##/ заканчивается ##expdate##.
Панель администратора для сайта ##domain## будет заблокирована ##expdate##.
Сайт будет заблокирован ##suspend_date##.
Сайт будет удален ##delete_date##.
</pre>
"-->

========= restored ============

<!--#set var="restored_subject_en" value="##em_sort_tag## ##domain##: License restored "-->
<!--#set var="restored_subject_ru" value="##em_sort_tag## ##domain##: Лицензия восстановлена "-->

<!--#set var="restored_body_en" value="
<pre>
http://##domain##/ license has been restored after your login at ##lastlogin##.
Please log into admin panel http://##domain##/_admin/ at least once per ##dt_login_last##
if you need this site.
</pre>
"-->

<!--#set var="restored_body_ru" value="
<pre>
Лицензия на сайт http://##domain##/ восстановлена после логина ##lastlogin##.
Пожалуйста, заходите в панель администратора http://##domain##/_admin/ не реже 
одного раза в ##dt_login_last##, если вам нужен этот сайт.
</pre>
"-->

=========== long ==============

<!--#set var="long_subject_en" value="##em_sort_tag## ##domain##: No logins for ##dt_login_last##"-->
<!--#set var="long_subject_ru" value="##em_sort_tag## ##domain##: Не было логина в течение ##dt_login_last##"-->

<!--#set var="long_body_en" value="
<pre>
You haven't logged into your site's admin panel for ##dt_login_last##. If you want to keep  
http://##domain##/ alive, please go to http://##domain##/_admin/ and log in using

Domain: ##domain##
Username: ##username##

and your password. License for your site will expire at ##expdate## if you don't log in
during next ##dt_expires_soon##.
</pre>
"-->

<!--#set var="long_body_ru" value="
<pre>
Вы не заходили в панель администрирования вашего сайта http://##domain##/ в течение ##dt_login_last##. 
Если этот сайт Вам еще нужен, зайдите в панель администратора http://##domain##/_admin/, используя

Домен: ##domain##
Пользователь: ##username##

и Ваш пароль. Лицензия на этот сайт окончится ##expdate##, если Вы не зайдете в панель администратора
до этого момента.
</pre>
"-->

=========== never ==============

<!--#set var="never_subject_en" value="##em_sort_tag## ##domain##: No logins for ##dt_login_never## after site creation"-->
<!--#set var="never_subject_ru" value="##em_sort_tag## ##domain##: Не было логина в течение ##dt_login_never## с момента создания сайта"-->


<!--#set var="never_body_en" value="
<pre>
The site http://##domain##/ has been created at ##regdate##, and there were no successful admin panel logins
up to this moment. If you want to keep http://##domain##/ alive, please go to http://##domain##/_admin/ and log in using

Domain: ##domain##
Username: ##username##

and your password. License for your site will expire at ##expdate## if you don't log in
during next ##dt_expires_soon##.
<pre>
"-->

<!--#set var="never_body_ru" value="
<pre>
Вы не заходили в панель администрирования вашего сайта http://##domain##/ в течение ##dt_login_never##
с момента его создания. 
Если этот сайт Вам еще нужен, зайдите в панель администратора http://##domain##/_admin/, используя

Домен: ##domain##
Пользователь: ##username##

и Ваш пароль. Лицензия на этот сайт окончится ##expdate##, если Вы не зайдете в панель администратора
до этого момента.
</pre>
"-->

=========== deleted ==============

<!--#set var="deleted_subject_en" value="##em_sort_tag## ##domain##: Site has been deleted"-->
<!--#set var="deleted_subject_ru" value="##em_sort_tag## ##domain##: Сайт удален"-->

<!--#set var="deleted_body_en" value="
<pre>
The site ##domain## has been deleted after license has expired (##expdate##).
</pre>
"-->

<!--#set var="deleted_body_ru" value="
<pre>
Сайт ##domain## удален по окончании лицензии (##expdate##).
</pre>
"-->


=========== site_suspended ==============

<!--#set var="site_suspended_subject_en" value="##em_sort_tag## ##domain##: Site has been suspended"-->
<!--#set var="site_suspended_subject_ru" value="##em_sort_tag## ##domain##: Сайт заблокирован"-->

<!--#set var="site_suspended_body_en" value="
<pre>
The site ##domain## has been suspended after license has expired (##expdate##).
</pre>
"-->

<!--#set var="site_suspended_body_ru" value="
<pre>
Сайт заблокирован по окончании лицензии (##expdate##).
</pre>
"-->
