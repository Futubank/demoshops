%%include_language "templates/lang/templates.lng"%%

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'templatesform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {
   var errmsg = "";

   editor_updateHiddenField("body");

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   if (form.body.value=="") {
       return focusedAlert(null, '%%body_warn%%', 'body');
   }

   return true;
}

-->
</script>


<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
"-->

  <br>
    <form action="##script_link##" method=post enctype="multipart/form-data" name="templatesform" onSubmit="return CheckForm(window.document.templatesform);">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
     <input type="hidden" name="publish" value="">
##filter_hidden_fields##
     <table width="100%" cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">

     <tr>
       <td width="80">
%%date%%:
</td>
       <td>
         <input type=text name=date class='field fieldDate' value="##date##" maxlength="30"/>
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.templatesform.date);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
       </td>
     </tr>
     <tr>
       <td>
%%name%%*:
</td>
       <td>
         <input type=text name=name class="field field50" value="##name##" maxlength="255">
       </td>
     </tr>
     </table>
    <table width="100%" cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div id="tab-page-body" class="tab-page">
            <textarea class="field" style="width:100%" rows="14" name=body id="body">##body##</textarea>
            <script type="text/javascript">
             if(editor_enable) // generates div with div_'name' and places editor in it.
               editor_generate('body', cmD_STB , true); // field, width, height
            </script>
            </div>
          </div>
        </div>
        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'body' : ['%%body%%', 'active', '', false],
          '':''});
          
        </script>         
       </td>
     </tr>
     </table>
    <table width="100%" cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
        <td colspan="2" align="right">
        <br>
        <input type="submit" name="add" value="  %%add_btn%%  " class="but" ##add##>
        <input type="submit" name="apply" value="  %%apply_btn%%  " class="but" ##apply##>
        ##cancel##
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

