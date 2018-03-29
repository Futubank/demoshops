%%include_language "templates/lang/srv_host_mailmanage.lng"%%
%%include_language "templates/lang/_srv_host_mailmanage_msgs.lng"%%
%%include_template "templates/_icons.tpl"%%


<!--#set var="local_part_input" value="
<input type="text" name="local_part" class="field field16" value="" helpId= ""  />
"-->

<!--#set var="alias_type_selectbox" value="
<select name="alias_type">
<option value="none" ##alias_none##>%%alias_none%%
<option value="forward" ##alias_forward##>%%alias_forward%%
<option value="copy" ##alias_copy##>%%alias_copy%%
</select>
"-->


<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
"-->

<script type="text/javascript">

var editor_enable = '##editor_enable##';
var _cms_document_form = 'mailform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';

</script>

##if(show_form=="no")##
<!--
##endif##

<script type="text/javascript">

function isValidEmail(str) {

    var filter=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)([\s,;]([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)){0,5}$/i;
    if (filter.test(str))
        return true;
    return false;
}

function isValidLocalPart(str) {

    var filter=/^[a-z_0-9-]+(?:\.[[a-z_0-9-]+)*\.*$/i;
    if (filter.test(str))
        return true;
    return false;
}


function checkPasswords(p1,p2) {

    if(p1.value=='') {
        alert('%%enter_password%%');
        p1.focus();
        return false;
    }
    if(p2.value=='') {
        alert('%%enter_confirm_password%%');
        p2.focus();
        return false;
    }

    if(p1.value!=p2.value) {
        alert('%%passwords_dont_match%%');
        p1.focus();
        return false;
    }
    return true;
}


function isNumber(field,msg) {

    if(field.value=='')
	return true;                                                                                                                                                               
    var re = /^\d+$/;
    if(re.test(field.value))
        return true;
    alert(msg);
    field.focus();
    return false;
}

function CheckForm(form) {

    if(typeof(form.elements['local_part'])=='object') {
        var lp = form.local_part;
        if(lp.value=='' || !isValidLocalPart(lp.value)) {
            alert('%%enter_valid_email%%');
            lp.focus();
            return false;
        }

        if(!checkPasswords(form.passwd,form.confirm_passwd))
            return false;
	    
	if(!isNumber(form.disk_quota,'%%invalid_value%%'))
	    return false;
    }

    if(form.passwd.value!='' || form.confirm_passwd.value!='') {

        if(typeof(form.elements['old_passwd'])=='object') {
            if(form.old_passwd.value=='') {
                alert('%%enter_old_passwd%%');
                form.old_passwd.focus();
                return false;
            }
        }

        if(!checkPasswords(form.passwd,form.confirm_passwd))
            return false;

    }

    var i = form.alias_type.selectedIndex;
    var aliasType = form.alias_type.options[i].value;
    if(aliasType=='none') form.alias.value = '';
    if(aliasType!='none' &&
        (form.alias.value=='' || !isValidEmail(form.alias.value))
      ) {
        alert('%%enter_valid_email%%');
        form.alias.focus();
        return false;
    }
    return true;
}

</script>
##if(show_form=="no")##
-->
##endif##

  <form action=##script_link## method=post name="mailform" onSubmit="return CheckForm(mailform);">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
     ##filter_hidden_fields##

##if(show_form=="no")##
<!--
##endif##

##if(lang='ru')##
<div class="tooltip">Узнайте все преимущества <b>почты для вашего домена</b><br> с защитой от спама, вирусов у ведущих сервисов Яндекс и Google.<br>
Подробности в нашем <a href="http://www.amiro.ru/blog/review/webmail-cloud" title="Плюсы и минусы почтовых сервисов"> обзоре с инструкцией по подключению</a>.</div>
##endif##
   <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
   <tr>
     <td>
     %%email%%:
     </td>
       <td>
       ##local_part##@##domain##
     </td>
   </tr>
  ##if(action=="apply")##
     <td>
     %%creation_date%%:
     </td>
       <td>
       ##creation_date##
     </td>
   </tr>
  ##endif##
   <tr>
     <td>
  ##if(action=="apply")##
     %%new_passwd%%:
  ##else##
     %%passwd%%:
  ##endif##
     </td>
       <td>
        <input type="password" name="passwd" class="field" value="" helpId= "" />
    </td>
   </tr>
   <tr>
     <td>
     %%confirm_passwd%%:
     </td>
       <td>
        <input type="password" name="confirm_passwd" class="field" value="" helpId= "" />
    </td>
   </tr>
   <tr>
     <td>&nbsp;</td>
       <td>&nbsp;</td>
   </tr>
   <tr>
     <td>
     %%mail_alias_type%%:
     </td>
       <td>
       ##alias_type_item##
     </td>
   </tr>
   <tr>
     <td>
     %%email%%:
     </td>
       <td>
        <input type="text" name="alias" class="field" value="##alias##" helpId= "" />
    </td>
   </tr>
   <tr>
     <td>&nbsp;</td>
       <td>&nbsp;</td>
   </tr>
   <tr>
     <td>
     %%disk_quota%%:
     </td>
       <td>
        <input type="text" name="disk_quota" class="field" value="##disk_quota##" helpId= "" />&nbsp;Mb
    </td>
   </tr>
     <tr>
        <td colspan="2" align="right">
        <br>
        ##form_buttons##
        <br><br>
        </td>
     </tr>
   </table>
##if(show_form=="no")##
-->
##endif##
</form>
<!--
        <input type="submit" name="add" value="  %%add_btn%%  " class="but" ##add##>
        <input type="submit" name="apply" value="  %%apply_btn%%  " class="but" ##apply##>
        ##cancel##
-->
