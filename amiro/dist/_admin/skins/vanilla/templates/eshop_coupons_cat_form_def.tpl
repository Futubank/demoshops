##check_url##

<script type="text/javascript">
var
    editor_enable = '##editor_enable##',
    _cms_document_form = 'formCouponsCat',
    _cms_script_link = '##script_link##?',
    pageIsLast='##page_is_last##';

function CheckForm(form) {
   editor_updateHiddenField('description');

   if (form.name.value == '') {
       alert('%%name_warn%%');
       form.name.focus();
       return false;
   }
   _cms_document_form_changed = false;
   return true;
}
</script>

<br>
<form action=##script_link## method=post enctype="multipart/form-data" name="formCouponsCat" onSubmit="return CheckForm(window.document.formCouponsCat)">
<input type="hidden" name="public" value="##public##" />
<input type="hidden" name="publish" value="" />
##form_common_hidden_fields##
##filter_hidden_fields##
<table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
<tr>
    <td colspan="2">
        <input type="checkbox" name="public" id="public" ##public## value="1" />
        <label for="public">%%public%%</label>
    </td>
</tr>
<tr>
    <td colspan="2">
        <input type="checkbox" name="bind_member" id="bind_member"##bind_member## value="1" />
        <label for="bind_member">%%bind_member%%</label>
    </td>
</tr>
<tr>
    <td>%%name%%*:</td>
    <td><input type="text" name="name" class="field field50" value="##name##"  maxlength="255" /></td>
</tr>
##if(USE_ID_EXTERNAL=="1")##
<tr>
    <td valign=top>%%id_external%%:</td>
    <td><input type="hidden" name="id_external_manual" value="1" /><input type="text" name="id_external" class="field field56" value="##id_external##"  maxlength="255" /></td>
</tr>
##endif##
</table>
<table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
<tr>
    <td colSpan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-description">
              <textarea class="field" style="width:100%" rows="14" name="description" id="description">##description##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('description', cmD_STB, true);}
              </script>
            </div>
          </div>
        </div>
        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'description' : ['%%description%%', 'active', '', false],
          '':''});
          
        </script>
    </td>
</tr>
</table>
<table cellspacing="5" cellpadding="0" border="0" class="frm">
<col width="150">
<col width="*">
<tr><td colSpan="2" align="right"><br />##form_buttons##<br /><br /></td></tr>
<tr><td colSpan="2"><sub>%%required_fields%%</sub></td>
</tr>
</table>
</form>
