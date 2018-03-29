%%include_language "templates/lang/wz_host_users.lng"%%
%%include_language "templates/lang/_wz_host_users_msgs.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="limits_reached" value="<!--limits_reached-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    ##metas##
    <link rel="stylesheet" href="##skin_path##_css/style.css?_cv=##cms_version##" type="text/css">
  </head>
  <body leftmargin="0" topmargin="0" bgcolor="#FFFFFF" >
  <br>
	<div align="center">
	<h2>%%sites_limit_reached%%</h2>
	<br>
	<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="closeDialogWindow();">
	</div>
  </body>
</html>
"-->

<!--#set var="copy_popup" value="<!--copy_popup-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    ##metas##
    <link rel="stylesheet" href="##skin_path##_css/style.css?_cv=##cms_version##" type="text/css">
    <script type="text/javascript">
        var editorBaseHref = '##root_path_www##';
        var domList = '##domains##';

        function prepareForm() {
            var sel = document.getElementById('domSelect');
            var doms = domList.split(':');
            for(var i=0; i<doms.length; i++) {
                if(doms[i]=='') continue;
                var option = new Option(doms[i],doms[i]);
                sel.options[i] = option;
            }
            domainLevel(2);
        }

        function validateSub(sub) {
            if(!sub.value.match(/^[a-zA-Z0-9\-]+$/)) {
                alert('%%illegal_domain_char%%');
                sub.focus();
                return false;
            }
            return true;
        }

        function notEmpty(f,msg) {
            if(f.value=='') {
                alert(msg);
                f.focus();
                return false;
            }
            return true;
        }

        function checkForm(id) {
            var form = document.forms['site_copy_form'];
            var domain;

            if(form.domLevel[0].checked) {
                // 2nd level
                if(!validateSub(form.domain)) return false;
                if(!validateSub(form.tld)) return false;
                domain = form.domain.value+'.'+form.tld.value;
            } else {
                if(!validateSub(form.subDomain)) return false;
                domain = form.subDomain.value+
                    form.domSelect.options[form.domSelect.selectedIndex].value;
            }
            //var msg = '%%empty_passwd_invalid%%';
            //if(!notEmpty(form.passwd1,msg) || !notEmpty(form.passwd2,msg)) return false;
            if(form.passwd1.value!=form.passwd2.value) {
                alert('%%passwd_dont_match%%');
                form.passwd2.select();
                form.passwd2.focus();
                return false;
            }
            var do_notify = form.do_notify.checked ? '1' : '';
            var do_delete = form.do_delete.checked ? '1' : '';
			      var addzone = form.addzone.checked && !form.addzone.disabled ? '1' : '';
            top.siteCopy(id,domain,form.passwd1.value,addzone,do_notify,do_delete);
            closeDialogWindow();
        }

        function domainLevel(n) {
            var form = document.forms['site_copy_form'];
            if(n==3) {
                form.domain.disabled = form.tld.disabled = true;
                form.domSelect.disabled = form.subDomain.disabled = false;
        				form.addzone.checked = false;
        				form.addzone.disabled = true;
            } else {
                form.domain.disabled = form.tld.disabled = false;
                form.domSelect.disabled = form.subDomain.disabled = true;
        				form.addzone.checked = true;
				        form.addzone.disabled = false;
            }
        }
    </script>
  </head>
  <body leftmargin="0" topmargin="0" bgcolor="#FFFFFF" onload="prepareForm()">
  <br>
  <center>
  ##form##
  </center>
  </body>
</html>
"-->



<!--#set var="copy_popup_items" value="<!--copy_popup_items-->
   <form name="site_copy_form">
   <table width="100%" cellspacing="5" cellpadding="0" border="0">
   <tr>
       <td colspan=2><h3>%%coping_site%% ##domain##</h3></td>
   </tr>
   <tr><td colspan=2><br></tr>
   <tr>
       <td><input type="radio" name="domLevel" value="2" checked onclick="domainLevel(this.value)" id=domLevel2></td>
       <td><label for=domLevel2><b>%%copy_to_domain_2%%:</b></label></td>
   </tr>
   <tr>
       <td align="left">
       </td>
       <td>
        <input type="text" class="field" name="domain"> <b>.</b> <input type="text"  maxlength="4" class="field field4" name="tld">
       </td>
   </tr>
   <tr>
     <td>&nbsp;</td>
	   <td><input type="checkbox" name="addzone" checked>%%add_dns_zone%%</td>
   </tr>
   <tr>
       <td><input type="radio" name="domLevel" value="3" onclick="domainLevel(this.value)" id=domLevel3></td>
       <td><label for=domLevel3><b>%%copy_to_domain_3%%:</b></label></td>
   </tr>
   <tr>
       <td align="left">
       </td>
       <td>
        <input type="text" class="field" name="subDomain">&nbsp;<select id="domSelect"></select>
       </td>
   </tr>
    <tr><td colspan="2"><br>
        <table border=0>
        <tr>
            <td nowrap>%%new_site_password%%:</td>
            <td align=right>&nbsp;&nbsp;<input type="password" class="field" name="passwd1"></td>
        </tr>
        <tr>
            <td nowrap>%%repeat_password%%:</td>
            <td align=right>&nbsp;&nbsp;<input type="password" class="field" name="passwd2"></td>
        </tr>
        <tr><td colspan=2><div class=tooltip>%%leave_blank_to_generate%%</div></td></tr>
        </table>
    </td></tr>
   <tr>
     <td valign=top><input type="checkbox" name="do_notify" id=do_notify value=1></td>
	   <td><label for=do_notify>%%notify_user%% <b>##email##</b></label></td>
   </tr>
   <tr>
     <td valign=top><input type="checkbox" name="do_delete" id=do_delete value=1></td>
	   <td><label for=do_delete>%%delete_site%% <b>##domain##</b></label></td>
   </tr>
   <tr>
   <td align="right" colspan="3"><br>
    <input type="button" name="apply" value="  %%apply_btn%%  " class="but" ##apply## OnClick="checkForm(##id##)">
    <input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="closeDialogWindow();">
   </td>
   </tr>
  </table>
   </form>
"-->

<!--#set var="del_popup" value="<!--del_popup-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    ##metas##
    <link rel="stylesheet" href="##skin_path##_css/style.css?_cv=##cms_version##" type="text/css">
    <script type="text/javascript">
    <!--
        var editorBaseHref = '##root_path_www##';

        function getFormData() {
            tmp = "";
            if(document.users_del_form.type.checked) {
                tmp = "|"+document.users_del_form.type.value;
            }
            if(document.users_del_form.type1.checked) {
                tmp += "|"+document.users_del_form.type1.value;
            }
            if(document.users_del_form.type2.checked) {
                tmp += "|"+document.users_del_form.type2.value;
            }
            if(document.users_del_form.deldns.checked)
                tmp += "|delzone";
            return tmp;
        }
    //-->
    </script>
  </head>
  <body leftmargin="0" topmargin="0" bgcolor="#FFFFFF">
  <br>
  <center>
  ##form##
  </center>
  </body>
</html>
"-->


<!--#set var="del_popup_items" value="
   <table width="100%" cellspacing="5" cellpadding="0" border="0">
   <form action=##script_link## method=post enctype="multipart/form-data" name="users_del_form">
   <tr>
       <td colspan=2><h3>%%deleting_site%% ##domain##</h3></td>
   </tr>
   <tr><td colspan=2><br></tr>
   <tr>
   <td colspan=2><b>%%username%%:</b> ##username##
   </td>
   </tr>
   <tr>
   <td valign=top>
    <input type="checkbox" name="type" id=type value="backup" ##do_backup##>
    </td><td><label for=type>%%backup_site%%</label><br>
   </td>
   </tr>
   <tr>
   <td valign=top>
    <input type="checkbox" name="deldns" id=deldns ##del_dns_disabled##>
    </td><td><label for=deldns>%%del_dns_zone%%</label><br>
   </td>
   </tr>
   <tr>
   <td valign=top>
    <input type="checkbox" name="type1" id=type1 value="member" checked>
    </td><td><label for=type1>%%keep_member%%</label><br>
   </td>
   </tr>
   <tr>
   <td valign=top><input type="checkbox" name="type2" id=type2 value="notify" ##do_notify##>
   </td><td><label for=type2>%%notify_member%% <b>##email##</b></label><br>
   </td>
   </tr>
   <tr>
   <td colspan="2">
	  <b>%%reason%%:</b><br>
    <textarea name=reason rows=3 width=100% class=field></textarea>
   </td>
   </tr>
   <tr>
   <td align="right" colspan="2"><br>
    <input type="button" name="apply" value="  %%delete_btn%%  " class="but" ##apply## OnClick="top.delUser(##id##, getFormData(), document.users_del_form.reason.value); closeDialogWindow();">
    <input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="closeDialogWindow();">
   </td>
   </tr>
   </form>
  </table>
"-->


<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'usersform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';

function CheckForm(form) {
   return true;
}

function delUser(userId, type, reason) {
    document.usersform.id.value=userId;
    document.usersform.type.value=type;
    document.usersform.reason.value=reason;
    document.usersform.action.value='del';
    document.usersform.submit();
    //user_click('del', userId);
}


function siteCopy(id,domain,password,addzone,do_notify,do_delete) {
    document.usersform.type.value = domain+'|'+addzone+'|'+do_notify+'|'+do_delete+'|'+password;
    user_click('copy',id);
}

-->
</script>

  <form action=##script_link## method=post enctype="multipart/form-data" name="usersform" onSubmit="return CheckForm(window.document.usersform);">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="type">
     <input type="hidden" name="reason">
     <input type="hidden" name="action" value="##action##">
     ##filter_hidden_fields##
    </form>
