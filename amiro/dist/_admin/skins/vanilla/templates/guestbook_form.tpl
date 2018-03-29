%%include_language "templates/lang/guestbook.lng"%%
%%include_language "templates/lang/_guestbook_msgs.lng"%%

<!--#set var="form_preview_btn" value="<input type="submit" class="but-244" value="%%bb_preview%%" id="preview" name="preview" onClick="return txtEd.previewButtonOnClick(this)"/>"-->

<!--#set var="cancel" value="<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="user_click('none',''); return false;">"-->

<!--#set var="answer_for" value="
<tr><td colspan="2">
    <input type="checkbox" name="realAnswer" id="realAnswer" checked="checked"##IF(is_async)## disabled="disabled"##ENDIF## />
    ##IF(!is_async)##<label for="realAnswer">##ENDIF##%%add_message_as_answer_for%%: <b>##author##&nbsp;%%small_from%%&nbsp;<span id="afDate">##fdate##</span><script>replaceDateTitle('afDate')</script>##IF(!is_async)##</label>##ENDIF##
</td></tr>
"-->

<script type="text/javascript">
var editor_enable = "##editor_enable##",
    _cms_document_form = 'forumform',
    _cms_script_link = '##script_link##?';

##if(FORM_MODE == 'ADD')##
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
##if(answer_for)##
function OnObjectChanged_guestbook_form(name, first_change, evt)
{
    if (name == 'realAnswer') {
        var oForm = document.forms[_cms_document_form];
        oForm.id_parent.value = oForm.realAnswer.checked ? ##_parent_id## : 0;
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_guestbook_form);
##endif##

function CheckForm(form)
{
    if (form.subject.value == '') {
        alert('%%warn_subject%%');
        form.subject.focus();
        return false;
    }
    if (txtEd.contentLength() < 2) {
        alert("%%warn_message_length%%");
##--        form.preview.disabled = false;
        baseTabs.showTab('message');--##
        form.message.focus();
        return false;
    }
    if(typeof(form.elements['realAnswer']) != 'undefined' && form.elements['realAnswer'].checked){
        ##IF(is_async)##
        form.elements['realAnswer'].disabled = false;
        form.elements['id_parent'].value = AMI.DiscussionFilter.oForm.elements['flt_id_parent'].value;
        ##ENDIF##
        form.elements['flt_id_parent'].value = form.elements['id_parent'].value;
        form.elements['enc_flt_id_parent'].value = form.elements['id_parent'].value;
    }

    return true;
}

</script>

<br />
<form action="##script_link##" method="post" name="forumform" onSubmit="return CheckForm(this)">
##form_common_hidden_fields##
<input type="hidden" name="publish" value="" />
<input type="hidden" name="id_member" value="##id_member##" />
<input type="hidden" name="author" value="##author##" />
<input type="hidden" name="id_parent" value="##id_parent##" />
##filter_hidden_fields##
<table cellspacing="5" cellpadding="0" border="0" width="100%" class="frm">
	<col width="150">
	<col width="*">
<tr><td colspan="2"><input type="checkbox" name="public" id="public" ##public## value="1"> <label for="public">%%public%%</label></td></tr>
<tr><td>%%date%%*:</td><td><input type="text" name="date" class="field fieldDateTime" value="##fdate##"  disabled></td></tr>
<tr><td>%%subject%%*:</td><td><input type="text" name="subject" class="field field40" value="##subject##"  /></td></tr>
<tr>
    <td>%%author%%:</td>
    <td>##if(id_member)##<a href="##members_link##?id=##id_member##&action=edit#anchor" target="_blank">##author##</a>##else####author####endif##</td>
</tr>
<tr><td>IP:</td><td>##ip##</td></tr>
##if(can_send)##<tr><td colSpan="2"><input type="checkbox" id="send" name="send" value="1"##send## /> <label for="send"##disabled##>%%send%%</label></td></tr>##endif##
##answer_for##
</table>
<table cellspacing="5" cellpadding="0" border="0" width="100%" class="frm">
	<col width="150">
	<col width="*">
<tr><td colspan="2">


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
        ##--    <div class="tab-page" id="tab-page-answer">
            <br><textarea name="answer" class="gray_field" style="margin-left:3px;margin-right:2px;width:715px;background:#ffffff;padding:3px;font-size:11px;border:2px #e0e0e0 inset" rows="20">##answer##</textarea>
            </div>

        --##

          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'message' : ['%%message%%', 'active', '', false],
##--          'answer' : ['%%answer%%', 'normal', '', false] --##
          '':''});

        </script>

</td>
</tr>
</table>
<table cellspacing="5" cellpadding="0" border="0" width="100%" class="frm">
<col width="150">
<col width="*">
<tr><td colspan="2" align="right"><br>##form_preview_btn## ##form_buttons##<br><br></td></tr>
<tr><td colspan="2"><sub>%%required_fields%%</sub></td></tr>
</table>
</form>
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
