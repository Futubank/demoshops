%%include_language "templates/lang/jobs.lng"%%
%%include_language "templates/lang/jobs_employer.lng"%%

<!--#set var="statuses_history" value="
  <table border=0 cellspacing=0 cellpadding=0>
  <tr>
    <td class="first_row_left_td">%%date%%</td>
    <td class="first_row_all">%%form_status%%</td>
    <td class="first_row_all">%%form_modified%%</td>
    <td class="first_row_all">%%form_comments%%</td>
  </tr>
  ##status_history_list##
  </table>
"-->

<!--#set var="status_row" value="
    <tr>
      <td class="##style##">##employer_modify_date##&nbsp;</td>
      <td class="##style##">##employer_status##&nbsp;</td>
      <td class="##style##">##employer_user##&nbsp;</td>
      <td class="##style##">##employer_comments##&nbsp;</td>
    </tr>
"-->

<!--#set var="custom_field" value="<tr><td><nobr>##custom_field_name##:&nbsp;</nobr></td><td>##custom_field_data##</td></tr>"-->

##check_url##

<script type="text/javascript">
<!--
var _cms_document_form = 'jobsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {
   var errmsg = "";

   return true;
}
-->
</script>

<!--#set var="history_status_value" value="
##employer_status## ##employer_comment## (<small>##employer_user## ##employer_modify_date##</small>)<br>
"-->

  <br>
    <form action="##script_link##" method="post" name="jobsform" onSubmit="return CheckForm(window.document.jobsform);">
    ##form_common_hidden_fields##
     <input type="hidden" name="public" value="##public##">
     <input type="hidden" name="publish" value="">
##filter_hidden_fields##
##--     <input type="hidden" name="cid" value="##cid##"> --##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     ##_id_page_field##
     ##categories_field##
     <tr>
       <td>%%employer_date%%:</td>
       <td>##fdate##</td>
     </tr>
     <tr>
       <td><b>%%jobs_employer%%:</b></td>
       <td>##jobname##</td>
     </tr>
     <tr>
       <td>%%employer_company%%:</td>
       <td>##name##</td>
     </tr>
     <tr>
       <td>%%employer_department%%:</td>
       <td>##department##</td>
     </tr>
     <tr>
       <td>%%employer_email%%:</td>
       <td>##email##</td>
     </tr>
     <tr>
       <td>%%employer_website%%:</td>
       <td>##if(website != "")##<b><a target="_blank" href="##website##">##website##&raquo;</a></b>##endif##</td>
     </tr>
     <tr>
       <td>%%employer_phone%%:</td>
       <td>##phone##</td>
     </tr>
     <tr>
       <td>%%employer_addon%%:</td>
       <td>##addon##</td>
     </tr>
     <tr>
     <td width="80">%%employer_status%%:</td>
     <td>
       <select name=status>
          <option value="not viewed" ##job_employer_form_not viewed##>%%not viewed%%</option>
          <option value="marked" ##job_employer_form_marked##>%%marked%%</option>
          <option value="ignored" ##job_employer_form_ignored##>%%ignored%%</option>
          <option value="replied" ##job_employer_form_replied##>%%replied%%</option>
          <option value="request" ##job_employer_form_request##>%%request%%</option>
       </select>
     </td>
     </tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     ##if (id_jobs != 0)##
     <tr>
       <td><b>%%employer_vacancy%%:</b></td>
       <td>##vacancy##</td>
     </tr>
     <tr>
       <td>%%sex%%:</td>
       <td>##sex##</td>
     </tr>
     <tr>
       <td>%%age_from%%:</td>
       <td>##age_from##</td>
     </tr>
     <tr>
       <td>%%age_till%%:</td>
       <td>##age_till##</td>
     </tr>
     <tr>
       <td>%%salary%%:</td>
       <td>##salary##</td>
     </tr>
     <tr>
       <td>%%experience%%:</td>
       <td>##experience##</td>
     </tr>
     <tr>
       <td>%%schedule%%:</td>
       <td>##schedule##</td>
     </tr>
     <tr>
       <td>%%duty%%:</td>
       <td>##duty##</td>
     </tr>
     <tr>
       <td>%%requirements1%%:</td>
       <td>##requirements1##</td>
     </tr>
     ##else##
     <tr>
       <td><b>%%employer_competitor%%:</b></td>
       <td>##competitor##</td>
     </tr>
     <tr>
       <td>%%employer_position%%:</td>
       <td>##position##</td>
     </tr>
     <tr>
       <td>%%employer_email%%:</td>
       <td>##competitor_email##</td>
     </tr>
     <tr>
       <td>%%employer_website%%:</td>
       <td>##if(competitor_website != "")##<b><a target="_blank" href="##competitor_website##">##competitor_website##&raquo;</a></b>##endif##</td>
     </tr>
     <tr>
       <td>%%employer_phone%%:</td>
       <td>##competitor_phone##</td>
     </tr>
     ##endif##
     <tr>
       <td>&nbsp;</td>
       <td>&nbsp;</td>
     </tr>
     <tr>
     <td width="80" valign="top">%%status_comments%%:</td>
     <td valign="top">
         <textarea name="comments" rows="10" cols="120">##comments##</textarea>
       </td>

     </td>
     </tr>
     <tr>
       <td valign="top">%%vacancy_history%%:</td>
       <td valign="top">
        ##statuses_history##
       </td>
     </tr>

     <tr>
        <td colspan="2" align="right">
        <br>
          ##form_buttons##
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
