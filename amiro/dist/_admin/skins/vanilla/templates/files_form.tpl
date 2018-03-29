%%include_language "templates/lang/files.lng"%%

<script type="text/javascript">
<!--

var editor_enable = '##editor_enable##';
var _cms_document_form = 'ftpform';
var _cms_document_form_changed = false;
var _cms_form_changed_alert = "%%form_changed%%";
var _cms_script_link = '##script_link##?';

##pictures_js_vars##


function CheckForm(form) {
   var errmsg = "";

   ##audit_check_form##

   if(typeof(checkCategoryData) == 'function') {
     if(!checkCategoryData(form)) {
       return false;
     }
   }

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%fname_warn%%');
   }

   ##if(FORM_MODE != "EDIT")##
   if (form.action.value!='apply' && form.ffilename.value=="") {
       return focusedAlert(form.ffilename, '%%ffilename_warn%%');
   }
   ##endif##
   editor_updateHiddenField("announce");
   editor_updateHiddenField("description");

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

   if(typeof(categoryOnSubmitForm) == 'function') {
      categoryOnSubmitForm(form);
   }

   return true;
}

function OnObjectChanged_files_form(name, first_change, evt){
  if( name=="ffilename") {
    setcheckbox(ftpform.ftype, getfiletype(ftpform.ffilename.value), ftpform.ftype.options.length - 1);
  }
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_files_form);

-->
</script>

<!--#set var="options" value="
<option value="##id##" ##ext##>##type##</option>
"-->

<!--#set var="ftype" value="
    <select name="ftype">
      <!--<option value="0">Other</option>-->
      ##options##
    </select>
"-->

<!--#set var="num_downloaded" value="
 <tr>
   <td>
     <nobr>%%num_downloaded%%:</nobr>
   </td>
   <td>
     ##num_downloaded##
   </td>
 </tr>
"-->

  <br>
    <form action="##script_link##" method="post" enctype="multipart/form-data" name="ftpform" onSubmit="return CheckForm(window.document.ftpform);">
     ##form_common_hidden_fields##
     <input type="hidden" name="publish" value="">
##filter_hidden_fields##
     <input type="hidden" name="MAX_FILE_SIZE" value="##MAX_FILE_SIZE##">

     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="190">
     <col width="*">
     <tr>
       <td colspan="2">
         <input type="checkbox" name="public" ##public## value="1">
         %%public%%
       </td>
     </tr>
     ##_id_page_field##
     ##categories_field##
     <tr>
       <td>
         <nobr>%%fname%%*:</nobr>
       </td>
       <td>
         <input type="text" name="name" class="field field50" value="##name##"  maxlength="128">
       </td>
     </tr>
     <tr>
       <td>
         <nobr>%%ftype%%:</nobr>
       </td>
       <td>
         ##ftype_selectbox##
       </td>
     </tr>
     <tr>
       <td>
         <nobr>%%ffilename%% (##maxfile## %%maximum%%)*:</nobr>
       </td>
       <td>
         <input type="file" name="ffilename" class="field field100" value="" >
       </td>
     </tr>
     <tr>
       <td>
         <nobr>%%fcdate%%:</nobr>
       </td>
       <td>
         <input type="text" name="fcdate" class="field fieldDate field23" value="##fcdate##" maxlength="19"/>
##--         <a href="javascript: void(0);" onclick="return getCalendar(event, document.ftpform.fcdate);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
--##
       </td>
     </tr>
     <tr>
       <td>
         <nobr>%%fmdate%%:</nobr>
       </td>
       <td>
         <input type="text" name="fmdate" class="field fieldDate field23" value="##fmdate##" maxlength="19"/>
##--
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.ftpform.fmdate);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
--##
       </td>
     </tr>
     ##num_downloaded##
##--     <tr>
       <td colspan="2">
         %%description%%:<br>
         <textarea class="field" style="width:100%" rows="5" name="fdescription">##fdescription##</textarea>
       </td>
     </tr>--##
     ##ext_images##
     ##ext_modules_custom_fields_top##
##if(EXT_TAGS=="1")##
    %%include_template "templates/tags.tpl"%%
##endif##
##if(EXT_RELATIONS)##
    %%include_template "templates/ext_relations.tpl"%%
##endif##
     </table>
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="190">
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

            <div class="tab-page" id="tab-page-description">
              <textarea class="field" style="width:100%" rows="14" name=description id="description">##description##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('description', cmD_STB , false);}
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
              'description' : ['%%description%%', 'normal', '', false],
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
     <col width="190">
     <col width="*">
     ##ext_modules_custom_fields_bottom##
     <tr>
        <td colspan="2" align="right">
        <br>
          ##form_buttons##
        <br><br>
     </tr>
     <tr>
        <td colspan="2">
          <sub>%%required_fields%%</sub>
        </td>
     </tr>
     </table>

    </form>
##categories_js##
