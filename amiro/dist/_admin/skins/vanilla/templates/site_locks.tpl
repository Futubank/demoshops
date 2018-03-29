
##-- 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
This template is parsed by simple perl parser
Do NOT use anything except sets and comments
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--##





<!--#set var="page" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Site Maintenance In Progress</title>
</head>
<body>
<script>
var url = location.href;
var i = url.indexOf('?');
if(i>0)
    url = url.substr(0,i);
</script>

<div>##content##</div>
</body>
</html>
"-->

<!--#set var="lock_demo_default" value="
    Доступ к сайту временно приостановлен,<br>
    идут работы по обслуживанию системы.<br>
    Зайдите попозже.
"-->


<!--#set var="lock_admin_backup" value="
    Доступ к панели администратора временно приостановлен,<br>
    выполняется резервное копирование.<br>
    Зайдите попозже.
    <a href='javascript:location.href=url'>Повтор</a>
"-->

<!--#set var="lock_front_backup" value="
    Доступ к сайту временно приостановлен,<br>
    идут работы по обслуживанию системы.<br>
    Зайдите попозже.
"-->

<!--#set var="lock_admin_restore" value="
    Доступ к сайту временно приостановлен,<br>
    идет восстановление резервной копии.<br>
    Зайдите попозже.
    <a href='javascript:location.href=url'>Повтор</a>
"-->

<!--#set var="lock_front_restore" value="
    Доступ к сайту временно приостановлен,<br>
    идут работы по обслуживанию системы.<br>
    Зайдите попозже.
"-->

<!--#set var="lock_admin_update" value="
    Доступ к сайту временно приостановлен,<br>
    идут работы по обновлению системы.<br>
    Зайдите попозже.
    <a href='javascript:location.href=url'>Повтор</a>
"-->

<!--#set var="lock_front_update" value="
    Доступ к сайту временно приостановлен,<br>
    идут работы по обновлению системы.<br>
    Зайдите попозже.
"-->

<!--#set var="lock_status_ok" value="
    <span style='color:blue;font-weight:bold'>Операция успешно завершена</span><br>
    <pre>
##op_info##
    </pre>
    <a href='javascript:location.href=url'>Продолжить</a>
"-->

<!--#set var="lock_status_err" value="
    <span style='color:red;font-weight:bold'>Произошла ошибка при выполнении операции</span><br>
    <pre>
##op_info##

##comment##
	</pre>
    <a href='javascript:location.href=url'>Вернуться</a>
"-->

<!--#set var="lock_rb_err" value="
    <span style='color:red;font-weight:bold'>Произошла ошибка при установке обновления<br>
    Откатить обновление не удалось</span><br>
    <pre>
##op_info##
    </pre>
"-->

<!--#set var="lock_inst_err" value="
    <span style='color:red;font-weight:bold'>Произошла ошибка при установке обновления</span><br>
    Установка отменена<br>
    <pre>
##op_info##
    </pre>
    <a href='javascript:location.href=url'>Продолжить</a>
"-->

<!--#set var="lock_inst_not_all" value="
    <span style='color:red;font-weight:bold'>Обновление установлено с ошибками</span><br>
    <pre>
##op_info##
    </pre>
    <a href='javascript:location.href=url'>Продолжить</a>
"-->

<!--#set var="lock_uninst_err" value="
    <span style='color:red;font-weight:bold'>Произошла ошибка при отмене обновления<br>
    <pre>
##op_info##
    </pre>
"-->

<!--#set var="lock_code_backup_progress" value="
    <span style='color:blue;font-weight:bold'>Выполняется резервное копирование кода
    перед обновлением системы</span><br>
    Текущее состояние:<br>
    <pre>
##op_info##
    </pre>
    <a href='javascript:location.href=url'>Обновить информацию</a>
"-->

<!--#set var="lock_symlinks_progress" value="
    <span style='color:blue;font-weight:bold'>Перестановка симлинков на копию кода</span><br>
    <a href='javascript:location.href=url'>Обновить информацию</a>
"-->

<!--#set var="lock_install_progress" value="
    <span style='color:blue;font-weight:bold'>Выполняется обновление системы.</span><br>
    Текущее состояние:<br>
    <pre>
##op_info##
__________________________________________

##status##
    </pre>
    <a href='javascript:location.href=url'>Обновить информацию</a>
"-->

<!--#set var="lock_rollback_progress" value="
    <span style='color:red;font-weight:bold'>Произошла ошибка при обновлении системы.</span><br>
    <span style='color:blue;font-weight:bold'>Выполняется откат обновления.</span><br>
    Текущее состояние:<br>
    <pre>
##op_info##
__________________________________________

##status##
    </pre>
    <a href='javascript:location.href=url'>Обновить информацию</a>
"-->

<!--#set var="lock_uninstall_progress" value="
    <span style='color:blue;font-weight:bold'>Выполняется откат обновления.</span><br>
    Текущее состояние:<br>
    <pre>
##op_info##
__________________________________________

##status##
    </pre>
    <a href='javascript:location.href=url'>Обновить информацию</a>
"-->



<!--#set var="lock_suspend" value="
    <br><br><br>
    <div align="center">
    <h2><font color="red">Запрошенный сайт не обслуживается.</font></h2>
    <h2><font color="red">Requested site is suspended</font></h2>
    </div>
"-->

