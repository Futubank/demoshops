%%include_language "templates/lang/stickers.lng"%%

<script type="text/javascript">
<!--
var editor_enable = "##editor_enable##";
var _cms_document_form = 'stickersform';
var _cms_script_link = '##script_link##?';

##pictures_js_vars##

function OnObjectChanged_stickers_form(name, first_change, evt){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_stickers_form);

function CheckForm(form) {
   var errmsg = "";

   if (form.date.value=="") {
       return focusedAlert(form.date, '%%date_warn%%');
   }

   if (form.header.value=="") {
       return focusedAlert(form.header, '%%header_warn%%');
   }

   // if no categories exist - force to create a new category
   if ((typeof(form.cat_id) != "object")&&(typeof(form.catname) == "object")&&(form.catname.value=="")) {
       return focusedAlert(form.catname, '%%new_category_warn%%');
   }

   editor_updateHiddenField("announce");

	if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

   return true;
}
-->
</script>

  <br>
  <form action="##script_link##" method="post" name="stickersform" onSubmit="return CheckForm(window.document.stickersform);">

     ##form_common_hidden_fields##
     ##filter_hidden_fields##

     <input type="hidden" name="public" value="##public##">
     <input type="hidden" name="publish" value="">

     <table cellspacing="0" cellpadding="0" border="0" width="100%" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">
         <input type="checkbox" name="public" id="public" ##public## value="1">
         <label for="public">%%public%%</label>
       </td>
     </tr>

	 <tr>
       <td>%%header%%*:</td>
       <td>
         <input type="text" name="header" class="field field45" value="##header##" maxlength="100">
       </td>
     </tr>

     <tr>
       <td>%%date%%*:</td>
       <td>
         <input type=text name=date class='field fieldDate' value="##fdate##" maxlength="30" />
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.stickersform.date);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
       </td>
     </tr>
     ##_id_page_field##
     ##categories_field##
     ##ext_images##
    </table>
    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="frm">
	<col width="150">
	<col width="*">
	<tr>
       <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div id="tab-page-announce" class="tab-page">
            <textarea class="field" style="width:100%" rows="14" name=announce id="announce">##announce##</textarea>
            <script type="text/javascript">
             if(editor_enable) 
               editor_generate('announce', cmD_STB , true);
            </script>
            </div>
            <div id="tab-page-options" class="tab-page">
              ##options_form##
            </div>
          </div>
        </div>
        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'announce' : ['%%announce%%', 'active', '', false],
              'options' : ['%%options%%', 'normal', '', false],
          '':''});
          
        </script>   

  		</td>
	</tr>
    </table>
    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="frm">
	<col width="150">
	<col width="*">
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

