%%include_language "templates/lang/jobs.lng"%%
%%include_language "templates/lang/jobs_history.lng"%%

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
      <td class="##style##">##resume_modify_date##&nbsp;</td>
      <td class="##style##">##resume_status##&nbsp;</td>
      <td class="##style##">##resume_user##&nbsp;</td>
      <td class="##style##">##resume_comments##&nbsp;</td>
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
##resume_status## ##resume_comment## (<small>##resume_user## ##resume_modify_date##</small>)<br>
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
       <td>%%department%%:</td>
       <td>##department##</td>
     </tr>
     <tr>
       <td>%%vacancy_title%%:</td>
       <td>##title##</td>
     </tr>
     <tr>
       <td>%%fdate%%:</td>
       <td>##fdate##</td>
     </tr>
     <tr>
       <td>%%vacancy_name%%:</td>
       <td>##fname## ##lname##</td>
     </tr>
     <tr>
       <td>%%email%%:</td>
       <td>##email##</td>
     </tr>
     <tr>
       <td>%%phone%%:</td>
       <td>##phone##</td>
     </tr>
     <tr>
       <td>%%resume%%:</td>
       <td>##resume##</td>
     </tr>
     <tr>
       <td>%%resume_addon%%:</td>
       <td>##addon##</td>
     </tr>
     ##custom_fields##
     <tr>
     <td width="80">%%history_status%%:</td>
     <td>
       <select name=status>
          <option value="not viewed" ##job_history_form_not viewed##>%%not viewed%%</option>
          <option value="marked" ##job_history_form_marked##>%%marked%%</option>
          <option value="ignored" ##job_history_form_ignored##>%%ignored%%</option>
          <option value="replied" ##job_history_form_replied##>%%replied%%</option>
          <option value="request" ##job_history_form_request##>%%request%%</option>
          <option value="moved" ##job_history_form_moved##>%%moved%%</option>
          <option value="accepted" ##job_history_form_accepted##>%%accepted%%</option>
       </select>
     </td>
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
