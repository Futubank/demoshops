%%include_language "templates/lang/wz_host_users.lng"%%
%%include_language "templates/lang/_wz_host_users_msgs.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="status_selectbox" value="
<select name="status">
<option value="active" ##stat_active##>%%status_active%%
<option value="suspend" ##stat_suspend##>%%status_suspend%%
</select>
"-->

<!--#set var="admin_status_selectbox" value="
<select name="admin_status">
<option value="active" ##stat_active##>%%status_active%%
<option value="suspend" ##stat_suspend##>%%status_suspend%%
</select>
"-->

<!--#set var="type_selectbox" value="
<select name="site_type">
<option value="free" ##type_free##>%%type_free%%
<option value="trial" ##type_trial##>%%type_trial%%
<option value="paid" ##type_paid##>%%type_paid%%
</select>
"-->

<!--#set var="expire_selectbox" value="
<select name="expire">
<option value="0" ##expire_0##>%%yes%%
<option value="1" ##expire_1##>%%no%%
</select>
"-->

<!--#set var="history" value="
  %%status_history%%:<br><br>
	<div style="height:200px;overflow-y:scroll;">
  <table border=0 cellspacing=0 cellpadding=0>
  <tr>
    <td class="first_row_left_td">%%date%%</td>
    <td class="first_row_all">%%status%%</td>
    <td class="first_row_all">%%admin_status%%</td>
    <td class="first_row_all">%%changed_by%%</td>
    <td class="first_row_all">IP</td> 
    <td class="first_row_all">%%comments%%</td>
  </tr>
  ##status_list##
  </table>
	</div>
"-->

<!--#set var="status_history_row" value="
    <tr class="##style##">
      <td>##date##&nbsp;</td>
      <td>##status##&nbsp;</td>
      <td>##admin_status##&nbsp;</td>
      <td>##changed_by##&nbsp;</td>
      <td>##ip##&nbsp;</td> 
      <td width=160>##comment##&nbsp;</td>
    </tr>
"-->

<!--#set var="reseller_item" value="<option value=##id_reseller## ##selected##>##name##</option>"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'usersform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';

var arrTabs = Array('status', 'packages'##--, 'client'--##);

function isNumber(field,msg) {

    var re = /^\d+$/;
    if(re.test(field.value))
        return true;
    alert(msg);
    field.focus();
    return false;
}

function CheckForm(form) {

    if(!isNumber(form.disk_quota,'%%invalid_value%%'))
        return false;
    if(!isNumber(form.email_quota,'%%invalid_value%%'))
        return false;
    if(!isNumber(form.max_mboxes,'%%invalid_value%%'))
        return false;

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

/*
function siteCopy(id,domain,password,addzone) {
alert(id+' '+domain+' '+password+' '+addzone);
    document.usersform.type.value = domain+'|'+password+'|'+addzone;
//    user_click('copy',id);
}
*/

function OnObjectChanged_wz_host_users_form(name, first_change, evt){
    if(name == "site_type"){
			if (document.usersform.site_type.value=='trial'){
				document.usersform.expire.value = 0;
			}else{
				document.usersform.expire.value = 1;
			}
			name="expire";
    }
    if(name == "expire"){
			if (document.usersform.expire.value == 0){
				document.usersform.date.value = document.usersform.date.oldValue;
			}else{
				document.usersform.date.value = '00.00.0000';
			}
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_wz_host_users_form);

-->
</script>

  <form action=##script_link## method=post enctype="multipart/form-data" name="usersform" onSubmit="return CheckForm(window.document.usersform);">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="type">
     <input type="hidden" name="reason">
     <input type="hidden" name="action" value="##action##">
     ##filter_hidden_fields##
   <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
   <tr>
     <td colspan=2><br></td>
   </tr>
   <tr>
     <td>
     %%reseller%%:
     </td>
       <td>
       ##IF (id_reseller_lock=="1")##
       <b>##reseller_name##</b>
       <input type=hidden nameid_reseller value=##id_reseller##>
       ##ELSE##
       <select name=id_reseller>
       ##reselers_items##
       </select>
       ##ENDIF##
     </td>
   </tr>
   <tr>
     <td>
     %%domain%%:
     </td>
       <td>
     <b>##domain##</b>
     </td>
   </tr>
   <tr>
     <td>
     %%date_registered%%:
     </td>
     <td>
     ##date_registered##
     </td>
   </tr>
   <tr>
     <td>
     %%username%%:
     </td>
       <td>
     ##username##
     </td>
   </tr>
   <tr>
     <td>
     %%email%%:
     </td>
       <td>
			 <input type="text" name="member_email" class="field field30" value="##email##" >
     </td>
   </tr>
   <tr>
       <td>
     %%last_login%% (%%logins_count%%):
     </td>
       <td>
     ##last_login## (##logins_count##)
     </td>
   </tr>
   <tr>
     <td>
     %%db_size%%:
     </td>
       <td>
      ##db_size##
     </td>
   </tr>
   <tr>
     <td>
     %%disk_space%%:
     </td>
       <td>
      ##disk_space##
     </td>
   </tr>
   <tr>
     <td colspan=2><br></td>
   </tr>
   <tr>
     <td>
     %%type%%:
     </td>
       <td>
       ##type_item##
     </td>
   </tr>
   <tr>
     <td>
     %%expires%%:
     </td>
       <td>
       ##expire_item##
     </td>
   </tr>
   <tr>
     <td>
     %%licence_expire%%:
     </td>
       <td>
      <input type="date" name="date" class="field fieldDate field10" value="##licence_exp##" >
			<a href="javascript: void(0);" onclick="return getCalendar(event, document.usersform.date);"><img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId= "licence_exp_date"></a></td>
   </tr>
   <tr>
     <td colspan=2><br></td>
   </tr>
   </table>
   <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-status">
              <table cellspacing="0" cellpadding="3" border="0">
               <tr><td><br></td></tr>
               <tr>
                 <td>
                 %%status_site%%:
                 </td>
                   <td>
                   ##status_item##
                 </td>
               </tr>
               <tr>
                 <td>
                 %%admin_status%%:
                 </td>
                   <td>
                   ##admin_status_item##
                 </td>
               </tr>
               <tr>
                 <td>
                 %%ftp_enabled%%:
                 </td>
                   <td>
                   <input type="checkbox" name="ftp_enabled" value=1 ##ftp_enabled##>
                 </td>
               </tr>
               <tr>
                 <td>
                 %%notify_user%%:
                 </td>
                 <td>
                    <select name="notify_user">
                    <option value="default" selected>%%default%%
                    <option value="yes">%%yes%%
                    <option value="no">%%no%%
                    </select>
                 </td>
               </tr>
               <tr>
                 <td colspan="2">
                 %%add_text%% (##add_text_lang##):
                 </td>
               </tr>
               <tr>
                 <td colspan="2">
                 <textarea name="text" class="field" cols=60 rows=5></textarea>
                 </td>
               </tr>
               <tr>
                  <td colspan="2" >
                  <br>
                   ##status_history##
                  </td>
               </tr>
               <tr><td><br></td></tr>
              </table>
            </div>

            <div class="tab-page" id="tab-page-packages">
              <table cellspacing="0" cellpadding="3" border="0">
               <tr><td><br></td></tr>
               <tr>
                 <td>
                 %%is_demo_site%%:
                 </td>
                   <td>
                   <input type="checkbox" name="is_demo" value="1" ##demo_checked##>
                 </td>
               </tr>
               <tr>
                 <td>
                 %%disk_quota%%:
                 </td>
                   <td>
                   <input type="text" name="disk_quota" class="field field10" value="##disk_quota##" >&nbsp;Mb
                 </td>
               </tr>
               <tr>
                 <td>
                 %%max_traffic%%:
                 </td>
                   <td>
                   <input type="text" name="traf_quota" class="field field10" value="##traf_quota##" >&nbsp;Mb
                 </td>
               </tr>
               <tr>
                 <td>
                 %%mail_domain_active%%:
                 </td>
                   <td>
                   <input type="checkbox" name="maildom_active" value="1" ##maildom_active_checked##>
                 </td>
               </tr>
               <tr>
                 <td>
                 %%email_quota%%:
                 </td>
                   <td>
                   <input type="text" name="email_quota" class="field field6" value="##email_quota##" >&nbsp;Mb
                 </td>
               </tr>
               <tr>
                 <td>
                 %%max_mboxes%%:
                 </td>
                   <td>
                   <input type="text" name="max_mboxes" class="field field3" value="##max_mboxes##" >
                 </td>
               </tr>
               <tr>
                 <td>
                 %%email_rate_limit%%:
                 </td>
                   <td>
                   <input type="text" name="email_send_rate_limit" class="field field6" value="##email_send_rate_limit##" >
                 </td>
               </tr>
               <tr>
                 <td>
                 %%add_footer%%:
                 </td>
                   <td>
                   <input type="checkbox" name="add_footer" value=1 ##add_footer##>
                 </td>
               </tr>
               <tr>
                 <td>
                 %%backup_on_delete%%:
                 </td>
                   <td>
                   <input type="checkbox" name="backup_enabled" value=1 ##backup_enabled##>
                 </td>
               </tr>
               <tr>
                 <td colspan="2">
                 %%comments%%:
                 </td>
               </tr>
               <tr>
                 <td colspan="2">
                 <textarea name="comments" class="field" cols=60 rows=5>##comments##</textarea>
                 </td>
               </tr>
               <tr><td><br></td></tr>
              </table>
            </div>
##--
            <div class="tab-page" id="tab-page-client">
              ##ext_info##
            </div>
--##
          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'status' : ['%%tab_status%%', 'active', '', false],
              'packages' : ['%%tab_packages%%', 'normal', '', false],
##--              'client' : ['%%tab_client%%', 'normal', '', false],--##

          '':''});
          
        </script>


       </td>
     </tr>
   </table>
   <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
		 <tr>
        <td colspan="2" align="right">
        <br>
        <input type="submit" name="apply" value="  %%apply_btn%%  " class="but" ##apply##>
        <input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
        <br><br>
        </td>
     </tr>
   </table>
    </form>
