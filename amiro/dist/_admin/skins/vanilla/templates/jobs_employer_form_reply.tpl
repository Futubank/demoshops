%%include_language "templates/lang/jobs.lng"%%
%%include_language "templates/lang/jobs_employer.lng"%%

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
     ##categories_field##
     <tr>
       <td>%%fdate%%:</td>
       <td>
         ##fdate##
       </td>
     </tr>
     <tr>
       <td>%%jobs_employer%%:</td>
       <td>
         ##fname## ##lname##
       </td>
     </tr>
     <tr>
       <td>%%employer_company%%:</td>
       <td>
         ##name##
       </td>
     </tr>
     <tr>
       <td>&nbsp;</td>
       <td>&nbsp;</td>
     </tr>
     <tr>
       <td width="80" valign="top">%%resume_topic%%:</td>
       <td valign="top">
         <input type="text" name="topic"  value="##message_topic##"class="field50">
       </td>
     </tr>
     <tr>
       <td width="80" valign="top">%%jobs_employer_add%%:</td>
       <td valign="top">
         <textarea name="answer" rows="15" cols="120" maxlength="2000">%%competitor_info%%:
%%competitor_name%%: ##competitor##
%%employer_position%%: ##position##
%%competitor_email%%: ##competitor_email##
%%competitor_website%%: ##competitor_website##
%%competitor_phone%%: ##competitor_phone##

##message_sign##</textarea>
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
