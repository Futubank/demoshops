%%include_language "templates/lang/jobs.lng"%%

##check_url##

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'jobsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {
   var errmsg = "";

   ##audit_check_form##

   editor_updateHiddenField("jobduty");
   editor_updateHiddenField("jobrequirements1");
   editor_updateHiddenField("jobrequirements2");

   // if no categories exist - force to create a new category
   if ((typeof(form.cat_id) != "object")&&(typeof(form.catname) == "object")&&(form.catname.value=="")) {
       return focusedAlert(form.catname, '%%new_category_warn%%');
   }

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
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
    <form action="##script_link##" method="post" name="jobsform" onSubmit="return CheckForm(window.document.jobsform);">
    ##form_common_hidden_fields##
     <input type="hidden" name="publish" value="">
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
     <tr>
     ##_id_page_field##
     ##categories_field##
     <tr>
       <td width='120px'>%%name%%*:</td>
       <td>
         <input type="text" name="name" class="field field70" value="##name##" maxlength="100">
       </td>
     </tr>
     <tr>
     <td>%%fdate%%:</td>
     <td>
       <input type=text name=fdate class='field fieldDate field30' value="##fdate##" maxlength="30" />
       <a href="javascript: void(0);" onclick="return getCalendar(event, document.jobsform.fdate);">
       <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
     </td>
     </tr>
     <tr>
     <td>%%edate%%:</td>
     <td>
       <input type=text name=edate class='field fieldDate field30' value="##edate##" maxlength="30" />
       <a href="javascript: void(0);" onclick="return getCalendar(event, document.jobsform.edate);">
       <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
     </td>
     </tr>
     <tr>
     <td>%%job_status%%:</td>
     <td>
       <select name=status>
          <option value="opened" ##job_status_opened##>%%opened%%</option>
          <option value="closed" ##job_status_closed##>%%closed%%</option>
       </select>
     </td>
     </tr>

     <tr>
     <td>%%sex%%:</td>
     <td>
       <select name=sex>
          <option value="any" ##sex_any##>%%sex_any%%</option>
          <option value="male" ##sex_male##>%%sex_male%%</option>
          <option value="female" ##sex_female##>%%sex_female%%</option>
       </select>
     </td>
     </tr>

     <tr>
     <td>%%age_from%%:</td>
     <td>
      <input type="text" name="age_from" class="field field30" value="##age_from##">
     </td>
     </tr>
     <tr>
     <td>%%age_till%%:</td>
     <td>
      <input type="text" name="age_till" class="field field30" value="##age_till##">
     </td>
     </tr>

     <tr>
       <td>%%salary%%:</td>
       <td>
         <input type="text" name="salary" class="field field30" value="##salary##" maxlength="100">
       </td>
     </tr>

     <tr>
     <td width="80">%%experience%%:</td>
     <td>
       <select name=experience>
          <option value="no" ##exp_no##>%%exp_no%%</option>
          <option value="1" ##exp_1##>%%exp_1%%</option>
          <option value="2" ##exp_2##>%%exp_2%%</option>
          <option value="3" ##exp_3##>%%exp_3%%</option>
          <option value="4" ##exp_4##>%%exp_4%%</option>
          <option value="5" ##exp_5##>%%exp_5%%</option>
          <option value="more than 5" ##exp_more than 5##>%%exp_more%%</option>
       </select>
     </td>
     </tr>

     <tr>
     <td>%%schedule%%:</td>
     <td>
       <select name=schedule>
          <option value="any" ##schedule_any##>%%schedule_any%%</option>
          <option value="full-time" ##schedule_fulltime##>%%schedule_full-time%%</option>
          <option value="part-time" ##schedule_parttime##>%%schedule_part-time%%</option>
          <option value="outside" ##schedule_outside##>%%schedule_outside%%</option>
       </select>
     </td>
     </tr>
     ##ext_modules_custom_fields_top##
     </table>
    <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-jobduty">
              <textarea class="field" style="width:100%" rows="14" name="jobduty" id="jobduty">##duty##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('jobduty', cmD_STB, true);}
              </script>
            </div>

            <div class="tab-page" id="tab-page-jobrequirements1">
              <textarea class="field" style="width:100%" rows="14" name=jobrequirements1 id="jobrequirements1">##requirements1##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('jobrequirements1', cmD_STB , false);}
              </script>
            </div>

            <div class="tab-page" id="tab-page-jobrequirements2">
              <textarea class="field" style="width:100%" rows="14" name=jobrequirements2 id="jobrequirements2">##requirements2##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('jobrequirements2', cmD_STB , false);}
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
              'jobduty' : ['%%duty%%', 'active', '', false],
              'jobrequirements1' : ['%%requirements1%%', 'normal', '', false],
              'jobrequirements2' : ['%%requirements2%%', 'normal', '', false],
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