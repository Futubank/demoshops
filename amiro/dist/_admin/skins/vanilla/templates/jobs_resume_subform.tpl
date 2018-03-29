%%include_language "templates/lang/jobs.lng"%%
%%include_language "templates/lang/jobs_resume.lng"%%
%%include_language "templates/lang/_files_items.lng"%%

##check_url##

<script type="text/javascript">
<!--

##if(JOBS_RESUME_POPUP == '1')##
closeDialogWindow();

reAnchor = /#anchor$/i;
oldHref = top.location.href;
newHref = oldHref.replace(reAnchor, "");

top.location = newHref;
##endif##

var editor_enable = '##editor_enable##';
var _cms_document_form = 'resumeform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {

   var errmsg = "";

   ##audit_check_form##

   editor_updateHiddenField("resume");
   editor_updateHiddenField("addon");

   // if no categories exist - force to create a new category
   if ((typeof(form.cat_id) != "object")&&(typeof(form.catname) == "object")&&(form.catname.value=="")) {
       return focusedAlert(form.catname, '%%new_category_warn%%');
   }

   if (form.title.value=="") {
       return focusedAlert(form.title, '%%title_warn%%');
   }

   if (form.fname.value=="") {
       return focusedAlert(form.fname, '%%firstname_warn%%');
   }

   if (form.lname.value=="") {
       return focusedAlert(form.lname, '%%lastname_warn%%');
   }

   if (form.email.value=="") {
       return focusedAlert(form.email, '%%email_warn%%');
   } else if(isEmail(form.email.value) == false) {
       return focusedAlert(form.email, '%%email_invalid%%');
   }

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

   _cms_document_form_changed = false;

   return true;

}
-->
</script>

<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="user_click('none',''); return false;">
"-->

  <br>
    <form action="##script_link##" enctype="multipart/form-data" method="post" name="resumeform" onSubmit="return CheckForm(window.document.resumeform);">
    ##form_common_hidden_fields##
    <input type="hidden" name="MAX_FILE_SIZE" value="##MAX_FILE_SIZE##">
    <input type="hidden" name="publish" value="">
    ##if(popup == '1')##
    <input type="hidden" name="popup" value="1">
    <input type="hidden" name="id_jobs_history" value="##id_jobs_history##">
    ##endif##
##filter_hidden_fields##
##--     <input type="hidden" name="cid" value="##cid##"> --##
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">
         <input type="checkbox" name="public" ##public## value="1">
         %%public%%
       </td>
     ##--<tr>--##
     ##_id_page_field##
     ##categories_field##
     <tr>
       <td>%%resume_title%%*:</td>
       <td>
         <input type="text" name="title" class="field field70" value="##title##" maxlength="100">
       </td>
     </tr>
     <tr>
       <td>%%resume_firstname%%*:</td>
       <td>
         <input type="text" name="fname" class="field field70" value="##fname##" maxlength="32">
       </td>
     </tr>
     <tr>
       <td>%%resume_lastname%%*:</td>
       <td>
         <input type="text" name="lname" class="field field70" value="##lname##" maxlength="32">
       </td>
     </tr>
     <tr>
       <td>%%resume_email%%*:</td>
       <td>
         <input type="text" name="email" class="field field70" value="##email##" maxlength="128">
       </td>
     </tr>
     <tr>
       <td>%%resume_website%%:</td>
       <td>
         <input type="text" name="website" class="field field70" value="##website##" maxlength="128">
       </td>
     </tr>
     <tr>
       <td>%%resume_phone%%:</td>
       <td>
         <input type="text" name="phone" class="field field70" value="##phone##" maxlength="16">
       </td>
     </tr>
     <tr>
     <td width="80">%%resume_fdate%%:</td>
     <td>
       <input type=text name=fdate class="field fieldDate field30" value="##fdate##"  maxlength="30" />
       <a href="javascript: void(0);" onclick="return getCalendar(event, document.resumeform.fdate);">
       <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
     </td>
     </tr>
     <tr>
     <td width="80">%%resume_status%%:</td>
     <td>
       <select name=status>
          <option value="not viewed" ##job_resume_status_not viewed##>%%not viewed%%</option>
          <option value="marked" ##job_resume_status_marked##>%%marked%%</option>
          <option value="ignored" ##job_resume_status_ignored##>%%ignored%%</option>
          <option value="replied" ##job_resume_status_replied##>%%replied%%</option>
          <option value="request" ##job_resume_status_request##>%%request%%</option>
          <option value="accepted" ##job_resume_status_accepted##>%%accepted%%</option>
       </select>
     </td>
     </tr>

    ##if(popup != '1')##
     <tr>
       <td>
         <nobr>%%ffilename%% (##maxfile## %%maximum%%):</nobr>
       </td>
       <td>
         <input type="file" name="resume_file" class="field field100" value="" >
       </td>
     </tr>
    ##else##
    <input type="hidden" name="id_file" value="##id_file##">
    ##endif##
    ##ext_modules_custom_fields_top##
    </table>
    <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-resume">
              <textarea class="field" style="width:100%" rows="14" name="resume" id="resume">##resume##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('resume', cmD_STB, true);}
              </script>
            </div>

            <div class="tab-page" id="tab-page-addon">
              <textarea class="field" style="width:100%" rows="14" name=addon id="addon">##addon##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('addon', cmD_STB , false);}
              </script>
            </div>

            ##if(ext_modules_custom_fields_tab)##
            <div class="tab-page" id="tab-page-custom-fields">
              %%include_template "templates/ext_modules_custom_fields.tpl"%%
            </div>
            ##endif##

            <div class="tab-page" id="tab-page-options">
              ##options_form##
              ##if(EXTENSION_RATING=="1")##
                %%include_template "templates/rating.tpl"%%
              ##endif##
            </div>

            ##if(EXT_AUDIT=="1")##
            <div class="tab-page" id="tab-page-audit">
              ##audit_form##
            </div>
            ##endif##

          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'resume' : ['%%resume%%', 'active', '', false],
              'addon' : ['%%addon%%', 'normal', '', false],
        ##if(ext_modules_custom_fields_tab)##
              'custom-fields' : ['%%tab_custom_fields%%', 'normal', '', false],
        ##endif##
              'options' : ['%%tab_options%%', 'normal', '', false],
        ##if(EXT_AUDIT=="1")##
              'audit' : ['%%tab_audit%%', 'normal', '', false],
        ##endif##
          '':''});
          
        </script>

       </td>
     </tr>
     </table>
    <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
	<col width="150">
	<col width="*">
    ##ext_modules_custom_fields_bottom##
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


##categories_js##