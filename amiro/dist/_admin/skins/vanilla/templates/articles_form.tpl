%%include_language "templates/lang/articles.lng"%%

##check_url##

<script type="text/javascript">
<!--

var editor_enable = '##editor_enable##';
var _cms_document_form = 'artform';
var _cms_script_link = '##script_link##?';
##pictures_js_vars##

function OnObjectChanged_articles_form(name, first_change, evt){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_articles_form);

function CheckForm(form) {
   var errmsg = "";

   ##audit_check_form##

   editor_updateHiddenField("announce");
   editor_updateHiddenField("body");

   if(typeof(checkCategoryData) == 'function') {
     if(!checkCategoryData(form)) {
       return false;
     }
   }

   if (form.header.value=="") {
       return focusedAlert(form.header, '%%header_warn%%');
   }
   if (form.announce.value=="") {
       return focusedAlert(null, '%%announce_warn%%', 'announce');
   }

   // if no categories exist - force to create a new category
   if ((typeof(form.cat_id) != "object")&&(typeof(form.catname) == "object")&&(form.catname.value=="")) {
       return focusedAlert(form.catname, '%%new_category_warn%%');
   }

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

   if(typeof(categoryOnSubmitForm) == 'function') {
      categoryOnSubmitForm(form);
   }
   return true;
}
-->
</script>

  <br>
   <form action="##script_link##" method="post" enctype="multipart/form-data" name="artform" onSubmit="return CheckForm(document.artform);">
     ##form_common_hidden_fields##
     <input type="hidden" name="publish" value="">
     <input type="hidden" name="arch" value="">
##filter_hidden_fields##
##--     <input type="hidden" name="cid" value="##cid##"> --##
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">
         <input type="checkbox" name="public" id="public" ##public## value="1" helpId= "form_public" />
         <label for="public">%%public%%</label>
       </td>
     </tr>
  ##if(ARTICLES_MANUAL_ARCHIVE=="1")##
     <tr>
       <td colspan="2">
         <input type="checkbox" name="archive" id="archive" ##archive## value="1" helpId= "form_archive">
         <label for="archive">%%archive%%</label>
       </td>
  ##endif##
     </tr><tr><td colspan=2><br></td></tr>

     ##_id_page_field##
     ##categories_field##
     <tr>
       <td width="80">%%date%%:</td>
       <td>
         <input type=text name=date class="field fieldDate" value="##fdate##" maxlength="30" />
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.artform.date);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
       </td>
     </tr>
     <tr>
       <td>%%author%%:</td>
       <td>
         <input type=text name=author class="field field50" value="##author##" maxlength="255">
       </td>
     </tr>
     <tr>
       <td>%%source%%:</td>
       <td>
         <input type=text name=source class="field field50" value="##source##" maxlength="255">
       </td>
     </tr>
     <tr>
       <td>%%header%%*:</td>
       <td>
         <input type=text name=header class="field field50" value="##header##" maxlength="255">
       </td>
     </tr>

     ##adv_place_fields##
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