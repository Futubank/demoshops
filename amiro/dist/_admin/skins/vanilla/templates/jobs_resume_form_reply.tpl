%%include_language "templates/lang/jobs.lng"%%
%%include_language "templates/lang/jobs_resume.lng"%%

##check_url##

<script type="text/javascript">
<!--
var _cms_document_form = 'jobsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {
   return true;
}
-->
</script>

<!--#set var="btn_cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="user_click('none',''); return false;">
"-->

  <br>
    <form action="##script_link##" method="post" name="jobsform" onSubmit="return CheckForm(window.document.jobsform);">
    ##form_common_hidden_fields##
     <input type="hidden" name="public" value="##public##">
     <input type="hidden" name="publish" value="">
##filter_hidden_fields##
##--     <input type="hidden" name="cid" value="##cid##"> --##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
     ##_id_page_field##
     <tr>
       <td>%%fdate%%:</td>
       <td>
         ##fdate##
       </td>
     </tr>
     <tr>
       <td>%%resume_name%%:</td>
       <td>
         ##fname## ##lname##
       </td>
     </tr>
     <tr>
       <td>%%resume_position%%:</td>
       <td>
         ##title##
       </td>
     </tr>
     <tr>
       <td>%%category%%:</td>
       <td>
         ##department##
       </td>
     </tr>
     <tr>
       <td>%%resume_email%%:</td>
       <td>
         ##email##
       </td>
     </tr>
     <tr>
       <td>%%resume_website%%:</td>
       <td>##if(website != "")##<b><a target="_blank" href="##website##">##website##&raquo;</a></b>##endif##</td>
     </tr>
     <tr>
       <td>%%phone%%:</td>
       <td>
         ##phone##
       </td>
     </tr>
     <tr>
       <td>&nbsp;</td>
       <td>&nbsp;</td>
     </tr>
     <tr>
       <td width="120" valign="top">%%resume_topic%%:</td>
       <td valign="top">
         <input type="text" name="topic"  value="##message_topic##"class="field50">
       </td>
     </tr>
     <tr>
       <td width="120" valign="top">%%jobs_resume_add%%:</td>
       <td valign="top">
         <textarea name="answer" rows="15" cols="120" maxlength="2000">##message_sign##</textarea>
       </td>
     </tr>
     <tr>
        <td colspan="2" align="right">
        <br>
          <input type="submit" name="send" value="Отправить" class="but"  onClick="this.form.action.value='answer'">

          <input type="submit" name="cancel" value="Отменить" class="but"  onClick="this.form.action.value='cancel'">
        <br><br>
        </td>
     </tr>
     <tr>
        <td colspan="2">
          <sub>%%required_fields%%</sub>
        </td>
     </tr>
     </table>
    </form>
