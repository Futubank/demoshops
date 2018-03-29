##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_res_cms_inst.lng"%%
%%include_template "templates/hst_res_inst_form.tpl"%%

<script type="text/javascript">
    function siteCopy(id,domain,addzone,do_notify,do_delete) {
        document.resform.action_params.value = domain+'|'+addzone+'|'+do_notify+'|'+do_delete;
        user_click('copy',id);
    }
</script>

<!--#set var="copy_params_row" value="##input##"-->

<!--#set var="copy_popup" value="<!--copy_popup-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    ##metas##
    <link rel="stylesheet" href="_css/style.css?_cv=##cms_version##" type="text/css">
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
            var form = document.forms['hst_res_cms_copy'];
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
            var do_notify = form.do_notify.checked ? '1' : '';
            var do_delete = form.do_delete.checked ? '1' : '';
			      var addzone = form.addzone.checked && !form.addzone.disabled ? '1' : '';
            top.opener.siteCopy(id,domain,addzone,do_notify,do_delete);
            top.close();
        }

        function domainLevel(n) {
            var form = document.forms['hst_res_cms_copy'];
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

<!--#set var="copy_form" value="
  ##form_hint##
    <form action=##script_link## method=post enctype="multipart/form-data" name="hst_res_cms_copy">
    <table width="100%" cellspacing="5" cellpadding="0" border="0">
    <tr>
       <td colspan=2><h3>%%copy_cms%%: ##domain##</h3></td>
    </tr>
    <tr><td colspan=2><br></tr>
    <tr>
       <td><input type="radio" name="domLevel" value="2" checked onclick="domainLevel(this.value)" id=domLevel2></td>
       <td><label for=domLevel2><b>%%copy_to_level2_domain%%:</b></label></td>
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
       <td><input type="checkbox" name="addzone" checked>%%add_dns_zone_if_not_exist%%</td>
    </tr>
    <tr>
       <td><input type="radio" name="domLevel" value="3" onclick="domainLevel(this.value)" id=domLevel3></td>
       <td><label for=domLevel3><b>%%copy_to_level3_domain%%:</b></label></td>
    </tr>
    <tr>
       <td align="left">
       </td>
       <td>
        <input type="text" class="field" name="subDomain">&nbsp;<select id="domSelect"></select>
       </td>
    </tr>
    <tr>
     <td valign=top><input type="checkbox" name="do_notify" id=do_notify value=1></td>
       <td><label for=do_notify>%%send_new_access_to_ovner_on_email%% <b>##email##</b></label></td>
    </tr>
    <tr>
     <td valign=top><input type="checkbox" name="do_delete" id=do_delete value=1></td>
       <td><label for=do_delete>%%delete_copied_site%% <b>##domain##</b></label></td>
    </tr>
    <tr>
    <td align="right" colspan="3"><br>
    <input type="button" name="apply" value="%%apply%%" class="but"  OnClick="checkForm(##id##)">
    <input type="reset" name="cancel" value="%%cancel%%" class="but" OnClick="javascript:top.close();">
    </td>
    </tr>
    </table>

    </form>
"-->
