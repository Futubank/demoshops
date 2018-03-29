%%include_language "templates/lang/forum.lng"%%

<!--#set var="cancel" value="<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="user_click('none',''); return false;">"-->

<!--#set var="form_preview_btn" value="<input type="submit" class="but-244" value="%%bb_preview%%" name="preview" onClick="baseTabs.showTab('message');return txtEd.previewButtonOnClick(this)" />"-->

<script type="text/javascript">
var
    editor_enable = "##editor_enable##",
    _cms_document_form = 'forumform',
    _cms_script_link = '##script_link##?';

##if(FORM_MODE == 'ADD' && id_thread)##
function LocalBodyOnLoad()
{
    setTimeout('myLocalBodyOnLoad()', 300);
}

function myLocalBodyOnLoad()
{
    txtEd.editorObj.focus();
    txtEd.editorObj.select();
    if (txtEd.editorObj.value.length > 0 && document.selection && document.selection.createRange()) {
        var r = document.selection.createRange();
        r.collapse(false);
        r.select();
    }
}
##endif##

function CheckForm(form)
{
    if (form.date.value == '') {
        alert('%%date_warn%%');
        form.date.focus();
        return false;
    }
    if (form.topic.value == '') {
        alert('%%topic_warn%%');
        form.topic.focus();
        return false;
    }
    if (form.author.value == '') {
        alert('%%author_warn%%');
        form.author.focus();
        return false;
    }
    if (txtEd.contentLength() < 2) {
        baseTabs.showTab('message');
        alert("%%warn_message_length%%");
        if (txtEd.currentMode == 'preview') {
            form.preview.onclick();
        }
        form.message.focus();
        return false;
    }

    // if no categories exist - force to create a new category
    if ((typeof(form.cat_id) != 'object') && (typeof(form.catname) == 'object') && (form.catname.value == '')) {
        alert('%%new_category_warn%%');
        form.catname.focus();
        return false;
    }
##if(FORM_MODE == 'EDIT')##
    if (form.cat_id != undefined && (form.cat_id.value != form.source_id_cat.value || form.catname.value != '') && !confirm('%%warn_on_category_change%%')) {
        return false;
    }
##endif##

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

    if (form.locked && !form.locked.checked) {
        form.locked.checked = true;
        form.locked.value = 0;
    }

    return true;
}

</script>

  <br>
    <form action="##script_link##" method="post" name="forumform" onSubmit="return CheckForm(this)">
     ##form_common_hidden_fields##
     <input type="hidden" name="publish" value="" />
     <input type="hidden" name="id_thread" value="##id_thread##" />
     <input type="hidden" name="id_member" value="##id_member##" />
     <input type="hidden" name="author" value="##author##" />
     <input type="hidden" name="lock" value="" />
     <input type="hidden" name="source_id_cat" value="##id_cat##" />
     ##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" width="100%" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">
         <input type="checkbox" name="public" id="public" ##public## value="1">
         <label for="public">%%public%%</label>
       </td>
     </tr>
     ##if((!id && !id_thread) || (id == id_thread))##
     <tr>
       <td colspan="2">
         <input type="checkbox" name="locked" id="locked" value="1"##locked## />
         <label for="locked">%%locked%%</label>
       </td>
     </tr>
     ##endif##
     <tr>
       <td>%%date_time%%*:</td>
       <td>
         <input type="text" name="date" class="field fieldDateTime" value="##fdate##"  disabled>
       </td>
     </tr>
     ##if(id_thread == id)##
     ##_id_page_field##
     ##categories_field##
     ##else##
     <input type="hidden" name="id_cat" value="##id_cat##" />
     <input type="hidden" name="skip_cats" value="1" />
     ##if(use_categories)##
     <tr>
       <td>%%category%%:</td>
       <td>##category_name##</td>
     </tr>
     ##endif##
     ##endif##
     <tr>
       <td>%%topic%%*:</td>
       <td>
         <input type="text" name="topic" class="field field45" value="##topic##" maxlength="255" />
       </td>
     </tr>
     <tr>
       <td>%%author%%:</td>
       <td>##if(id_member)##<a href="##members_link##?id=##id_member##&action=edit#anchor" target="_blank">##author##</a>##else####author####endif##</td>
     </tr>
     <tr><td>IP:</td><td>##ip##</td>
     </tr>
     </table>
    <table cellspacing="5" cellpadding="0" border="0" width="100%" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-message">
              <script type="text/javascript">
var txtEd = new amiroTEdit('txtEd', new amiDictionary({
    'bold': '%%bb_bold%%',
    'strike': '%%bb_strike%%',
    'insert_olist': '%%bb_insert_olist%%',
    'header': '%%bb_header%%',
    'italic': '%%bb_italic%%',
    'underline': '%%bb_underline%%',
    'quote': '%%bb_quote%%',
    'align_left': '%%bb_align_left%%',
    'align_center': '%%bb_align_center%%',
    'align_right': '%%bb_align_right%%',
    'justify': '%%bb_justify%%',
    'insert_list': '%%bb_insert_list%%',
    'insert_link': '%%bb_insert_link%%',
    'delete_link': '%%bb_delete_link%%',
    'insert_image': '%%bb_insert_image%%',
    'font': '%%bb_font%%',
    'size': '%%bb_size%%',
    'color': '%%bb_color%%',
    'more': '%%bb_more%%',
    'insert_code': '%%bb_insert_code%%',
    'indent': '%%bb_indent%%',
    'outdent': '%%bb_outdent%%',
    'preview': '%%bb_preview%%',
    'hide_preview': '%%bb_hide_preview%%',
    'update_preview': '%%bb_update_preview%%',
    'warn_message_length': '%%bb_warn_message_length%%',
    'warn_invalid_image_url': '%%bb_warn_invalid_image_url%%',
    'warn_image_url_internal_links_forbidden': '%%bb_warn_image_url_internal_links_forbidden%%',
    'warn_image_url_external_links_forbidden': '%%bb_warn_image_url_external_links_forbidden%%',
    'prompt_enter_list_element': '%%bb_prompt_enter_list_element%%',
    'prompt_enter_next_list_element': '%%bb_prompt_enter_next_list_element%%',
    'prompt_enter_url': '%%bb_prompt_enter_url%%',
    'prompt_enter_image_url': '%%bb_prompt_enter_image_url%%',
    'warn_urls_reg_only': '%%bb_warn_urls_reg_only%%'
}));
                  txtEd.allowedImages = ['internal_links', 'external_links', 'upload'];
                  txtEd.createEditor(600, 250, 'message', '##message##', true);
                  txtEd.setUseNoindex(##noindex_external_links##);
              </script>
            </div>

            <div class="tab-page" id="tab-page-options">
              ##options_form##
              ##if(EXTENSION_RATING=="1")##
                %%include_template "templates/rating.tpl"%%
              ##endif##
            </div>


          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'message' : ['%%message%%', 'active', '', false],
              'options' : ['%%tab_options%%', 'normal', '', false],
          '':''});

        </script>




       </td>
     </tr>
     </table>
    <table cellspacing="5" cellpadding="0" border="0" width="100%" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2" align="right">
         <br>
         ##form_preview_btn## ##form_buttons##
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
##if(FORM_MODE == 'EDIT')##
<script type="text/javascript">
txtEd.setMode('preview');
var form = document.forms[_cms_document_form];
txtEd.editorObj.style.display = 'none';
document.getElementById('amiroTEdPureDiv').style.display = 'none';
document.getElementById('amiroTEdDivEditor').style.display = 'none';
form.preview.value = '%%bb_edit_button%%';
var previewEvent = form.preview.onclick;

form.preview.onclick = function () {
    document.getElementById('amiroTEdPureDiv').style.display = 'block';
    document.getElementById('amiroTEdDivEditor').style.display = 'block';
    txtEd.editorObj.style.display = 'block';
    this.onclick = previewEvent;
    txtEd.previewButtonOnClick(this);
    return false;
}
</script>
##endif##
