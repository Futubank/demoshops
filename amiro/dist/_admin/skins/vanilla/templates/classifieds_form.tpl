%%include_language "templates/lang/classifieds.lng"%%

<!--#set var="custom_field_row" value="
<tr>
    <td>##caption##:</td>
    <td><input type="text" name="##name##" class="field field50" value="##value##"  maxlength="255" /></td>
</tr>
"-->

##check_url##

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'artform';
var _cms_script_link = '##script_link##?';
##pictures_js_vars##

function OnObjectChanged_classifieds_form(name, first_change, evt)
{
    ##pictures_js_script##
    if (name == 'delete_attachment') {
        var form = document.getElementById(_cms_document_form);
        form.attachment.disabled = form.delete_attachment.checked;
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_classifieds_form);

function CheckForm(form)
{
    editor_updateHiddenField('announce');
    editor_updateHiddenField('body');

    if(typeof(checkCategoryData) == 'function') {
        if (!checkCategoryData(form)) {
            return false;
        }
    }
    if (form.date_start.value == '') {
        alert('%%warn_missing_date_start%%');
        form.date_start.focus();
        return false;
    }
    if (form.date_end.value == '') {
        alert('%%warn_missing_date_end%%');
        form.date_end.focus();
        return false;
    }
    if (form.header.value == '') {
        alert('%%header_warn%%');
        form.header.focus();
        return false;
    }
    if (form.author.value == '') {
        alert('%%author_warn%%');
        form.author.focus();
        return false;
    }
    if (!isEmail(form.email.value)) {
        alert('%%warn_invalid_email%%');
        form.email.focus();
        return false;
    }
    if (form.announce.value == '') {
        alert('%%announce_warn%%');
        editor_setfocus('announce');
        return false;
    }
    // if no categories exist - force to create a new category
    if ((typeof(form.cat_id) != 'object') && (typeof(form.catname) == 'object') && (form.catname.value == '')) {
        alert('%%new_category_warn%%');
        form.catname.focus();
        return false;
    }
    if (!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }
    if(typeof(categoryOnSubmitForm) == 'function') {
        categoryOnSubmitForm(form);
    }

    _cms_document_form_changed = false;

    return true;
}
-->
</script>

<br />
<form action="##script_link##" method="post" enctype="multipart/form-data" name="artform" onSubmit="return CheckForm(document.artform);">
##form_common_hidden_fields##
<input type="hidden" name="publish" value="" />
<input type="hidden" name="id_member" value="##id_member##" />
##--<input type="hidden" name="author" value="##author##" />--##
##filter_hidden_fields##
<table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">

<col width="150">
<col width="*">

<tr><td colspan="2"><input type="checkbox" id="public" name="public"##public## value="1" /> <label for="public">%%public%%</label></td></tr>
##_id_page_field##
##categories_field##
<tr>
    <td>%%date_start%%*:</td>
    <td>
        <input type="text" name="date_start" class="field fieldDate" value="##fdate_start##" maxlength="30" />
        <a href="javascript: void(0);" onclick="return getCalendar(event, document.artform.date_start, 'MIN');">
        <img class="clnd_img" src="skins/vanilla/images/spacer.gif"></a>
    </td>
</tr>
<tr>
    <td>%%date_end%%*:</td>
    <td>
        <input type="text" name="date_end" class="field fieldDate" value="##fdate_end##" maxlength="30" />
        <a href="javascript: void(0);" onclick="return getCalendar(event, document.artform.date_end, 'MAX');">
        <img class="clnd_img" src="skins/vanilla/images/spacer.gif"></a>
    </td>
</tr>
<tr>
    <td>%%header%%*:</td>
    <td><input type="text" name="header" class="field field50" value="##header##"  maxlength="255" /></td>
</tr>
<tr><td>IP:</td><td>##ip##</td>
<tr>
    <td>%%author%%*:</td>
    <td><input type="text" name="author" class="field field50" value="##author##"  maxlength="255" /></td>
</tr>
<tr>
    <td>%%email%%*:</td>
    <td><input type="text" name="email" class="field field50" value="##email##"  maxlength="255" /></td>
</tr>
##custom_fields##
<tr>
    <td><nobr>%%attachment%% (%%up_to%% ##max_attachment_size##):</nobr></td>
    <td>
        <input type="file" name="attachment" class="field field100" value=""  />
        ##if(id_file)##&nbsp;&nbsp;<input type="checkbox" id="delete_attachment" name="delete_attachment" /> <label for="delete_attachment">%%delete_attachment%%</label>##endif##
    </td>
</tr>
##adv_place_fields##
##ext_images##
##ext_modules_custom_fields_top##
</table>
<table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
<col width="150">
<col width="*">
<tr><td colspan="2">

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

          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'announce' : ['%%announce%%', 'active', '', false],
              'body' : ['%%details%%', 'normal', '', false],
        ##if(ext_modules_custom_fields_tab)##
              'custom-fields' : ['%%tab_custom_fields%%', 'normal', '', false],
        ##endif##
              'options' : ['%%tab_options%%', 'normal', '', false],
          '':''});
          
        </script>


</td></tr>
</table>
<table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
<col width="150">
<col width="*">
##ext_modules_custom_fields_bottom##
<tr><td colspan="2" align="right"><br />##form_buttons##<br /><br /></td></tr>
<tr>
<td colspan="2">
<sub>%%required_fields%%</sub>
</td>
</tr>
</table>

</form>
##categories_js##