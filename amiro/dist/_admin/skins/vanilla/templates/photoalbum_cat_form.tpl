%%include_language "templates/lang/photoalbum.lng"%%
%%include_language "templates/lang/_categories.lng"%%

##check_url##

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'art_form';
var _cms_script_link = '##script_link##?';
var pageIsLast='##page_is_last##';
##pictures_js_vars##

function OnObjectChanged_photoalbum_cat_form(name, first_change, evt){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_photoalbum_cat_form);

function CheckForm(form) {
   var errmsg = "";

   ##audit_check_form##

   editor_updateHiddenField("announce");
   editor_updateHiddenField("body");

   if (form.name.value=="") {
       errmsg+='%%name_warn%%';
       form.name.focus();
       alert(errmsg);
       return false;
   }

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

   return true;
}
-->
</script>


  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="art_form" onSubmit="return CheckForm(window.document.art_form);">
     <input type="hidden" name="public" value="##public##">
     <input type="hidden" name="publish" value="">
     ##form_common_hidden_fields##
##filter_hidden_fields##
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="100">
     <col width="*">

     <tr>
       <td colspan="2">
         <input type="checkbox" name="public" ##public## value="1">
         %%public%%
       </td>
     </tr>
     ##_id_page_field##
     <tr>
       <td>
%%name%%*:
       </td>
       <td>
         <input type=text name=name class="field field50" value="##name##" maxlength="255">
       </td>
     </tr>
     ##ext_images##
     ##ext_modules_custom_fields_top##
     </table>
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="100">
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
     <col width="100">
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

