##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/blog.lng"%%

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'blogform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
##pictures_js_vars##

function OnObjectChanged_blog_form(name, first_change, evt){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_blog_form);

function CheckForm(form) {
   var errmsg = "";

   ##audit_check_form##

   editor_updateHiddenField("announce");
   editor_updateHiddenField("body");

   if (form.header.value=="") {
       return focusedAlert(form.header, '%%header_warn%%');
   }

   if (form.announce.value=="") {
       return focusedAlert(null, '%%announce_warn%%', 'announce');
   }

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

   return true;
}
//-->
</script>


  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="blogform" onSubmit="return CheckForm(window.document.blogform);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type="hidden" name="publish" value="">
     <input type="hidden" name="arch" value="">
     <input type="hidden" name="ltime" value="##ltime##">
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">
         <input type="checkbox" name="public" id="public" ##public## value="1" helpId= "form_public" />
         <label for="public">%%public%%</label>
       </td>
       <td align=right></td>
     </tr>
  ##if(BLOG_MANUAL_ARCHIVE=="1")##
     <tr>
       <td colspan="2">
         <input type="checkbox" name="archive" id="archive" ##archive## value="1" helpId= "form_archive">
         <label for="archive">%%archive%%</label>
       </td>
     </tr>
  ##endif##
     ##_id_page_field##
     <tr>
       <td width="80">%%date%%*:</td>
       <td>
         <input type="text" name="date" class="field fieldDate" value="##fdate##" maxlength="30" helpId= "form_date" />
         <a href="javascript:void(0)" onclick="return getCalendar(event, document.blogform.date)"><img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId="clnd_date" /></a>
         <input type="text" name="time" class="field field10" value="##ftime##"  maxlength="10" helpId="form_time" />
       </td>
     </tr>
     <tr>
       <td>%%header%%*:</td>
       <td><input type="text" name="header" class="field field50" value="##header##"  maxlength="255" /></td>
     </tr>

     ##adv_place_fields##
     ##ext_images##
     ##ext_modules_custom_fields_top##

##if(EXT_TAGS=="1")##
    %%include_template "templates/tags.tpl"%%
##endif##
    </table>
    <table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">
        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-announce">
              <textarea class="field" style="width:100%" rows="14" name="announce" id="announce">##announce##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('announce', cmD_STB, true);}
              </script>
            </div>

            <div class="tab-page" id="tab-page-body">
              <textarea class="field" style="width:100%" rows="14" name=body id="body">##body##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('body', cmD_STB , false);}
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
              'announce' : ['%%announce%%', 'active', '', false],
              'body' : ['%%body%%', 'normal', '', false],
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
    <table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
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