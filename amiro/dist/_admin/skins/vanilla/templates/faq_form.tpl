%%include_language "templates/lang/faq.lng"%%

<script type="text/javascript">
<!--
var editor_enable = "##editor_enable##";

var _cms_document_form = 'faqform';
var _cms_script_link = '##script_link##?';

function OnObjectChanged_faq_form(name, first_change, evt){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_faq_form);

function CheckForm(form) {
   var errmsg = "";

   editor_updateHiddenField("question");
   editor_updateHiddenField("answer");

   if (form.date.value=="") {
       return focusedAlert(form.date, '%%date_warn%%');
   }

   if (form.author.value=="") {
       return focusedAlert(form.author, '%%author_warn%%');
   }

   if (form.question.value=="") {
       return focusedAlert(null, '%%question_warn%%', 'question');
   }


   if (form.answer.value=="" && form.send.checked) {
       return focusedAlert(null, '%%send_empty_answer_warn%%', 'answer');
   }

   // if no categories exist - force to create a new category
   if ((typeof(form.cat_id) != "object")&&(typeof(form.catname) == "object")&&(form.catname.value=="")) {
       return focusedAlert(form.catname, '%%new_category_warn%%');
   }

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

   return true;

}

-->
</script>

<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="user_click('none',''); return false;">
"-->


  <br>
    <form action="##script_link##" method="post" name="faqform" onSubmit="return CheckForm(window.document.faqform);">
     ##form_common_hidden_fields##
     <input type="hidden" name="email"  value="##email##">
     <input type="hidden" name="cols"   value="##cols##">
     ##filter_hidden_fields##
     <input type="hidden" name="public" value="##public##">
     <input type="hidden" name="publish" value="">

     <table cellspacing="5" cellpadding="0" border="0" width="100%" class="frm">
     <col width="80">
     <col width="*">

     <tr>
       <td colspan="2">
         <input type="checkbox" name="public" id="public" ##public## value="1">
         <label for="public">%%public%%</label>
       </td>
     </tr>

     <tr>
       <td>%%date%%*:</td>
       <td>
         <input type=text name=date class='field fieldDate' value="##fdate##" maxlength="30" />
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.faqform.date);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
       </td>
     </tr>
     ##_id_page_field##
     ##categories_field##
     <tr>
       <td>%%author%%*:</td>
       <td>
         <input type="text" name="author" class="field field45" value="##author##" maxlength="100">
       </td>
     </tr>
     <tr>
       <td>%%email%%:</td>
       <td>
         <input type="text" name="email" class="field field45" value="##email##" maxlength="100">
       </td>
     </tr>
     ##info##
     <tr>
       <td colspan="2">
         <input type="checkbox" name="send" id="send" ##send## value="1">
         <label for="send">%%send%%</label>
       </td>
     </tr>
     ##ext_modules_custom_fields_top##
     </table>
     <table cellspacing="5" cellpadding="0" border="0" width="100%" class="frm">
     <col width="80">
     <col width="*">
     <tr>
       <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-question">
              <textarea class="field" style="width:100%" rows="14" name="question" id="question">##question##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('question', cmD_STB, true);}
              </script>
            </div>

            <div class="tab-page" id="tab-page-answer">
              <textarea class="field" style="width:100%" rows="14" name="answer" id="answer">##answer##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('answer', cmD_STB , false);}
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
              'question' : ['%%question%%', 'active', '', false],
              'answer' : ['%%answer%%', 'normal', '', false],
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
     <table cellspacing="5" cellpadding="0" border="0" width="100%" class="frm">
     <col width="80">
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