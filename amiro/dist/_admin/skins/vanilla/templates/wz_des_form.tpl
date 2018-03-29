%%include_language "templates/lang/wz_designs.lng"%%

<script type="text/javascript">
<!--

var editor_enable = '##editor_enable##';
var _cms_document_form = 'wzdesform';
var _cms_script_link = '##script_link##?';

function CheckForm(form) {
   var errmsg = "";

##if(NO_WZ_DES_CATS!="1")##
   var cat_selected = false;
   for(var i=0; i<form.elements.length; i++) {
        if (form.elements[i].type == "checkbox" && form.elements[i].name == "category[]") {
            if (form.elements[i].checked) {
                cat_selected = true;
            }
        }
   }

   //if (form.category.value==0 && form.catname.value=="") {
   if (!cat_selected && form.catname.value=="") {
       errmsg+='%%category_warn%%';
       //form.category.focus();
       alert(errmsg);
       return false;
   }
##endif##
   if (form.header.value=="") {
       return focusedAlert(form.header, '%%header_warn%%');
   }
   if (form.folder_path.value=="") {
       return focusedAlert(form.folder_path, '%%folder_path%%');
   }

   return true;
}

function OnObjectChanged_wz_des_form(name, first_change, evt){
  oForm = document.forms[_cms_document_form];
  if (name == 'folder_path'){
    oForm.elements["header"].value = oForm.elements["folder_path"].value;
  }
  return true;
}
addFormChangedHandler(OnObjectChanged_wz_des_form);

-->
</script>

<!--#set var="category_row" value="
      ##--<option value=##id## ##selected##>##name##</option>--##
      <input type="checkbox" name="category[]" ##checked## value="##id##">&nbsp;##name##<br/>
"-->

<!--#set var="directory_row_new" value="
      <option value="##name##" ##selected## >##name##</option>
"-->

<!--#set var="directory_row" value="
      <option value="##name##" ##selected## >##name##</option>
"-->

<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="user_click('none',''); return false;">
"-->

  <br>
   <form action="##script_link##" method="post" enctype="multipart/form-data" name="wzdesform" onSubmit="return CheckForm(this);">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
     <input type="hidden" name="public" value="##public##">
     <input type="hidden" name="publish" value="">
##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">
         <input type="checkbox" name="public" ##public## value="1">
         %%public%%
       </td>
     </tr>
     <tr>
       <td width="80">%%date%%:</td>
       <td>
         <input type=text name=date class='field fieldDate' value="##date##" maxlength="30" />
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.wzdesform.date);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
       </td>
     </tr>
     <tr>
       <td>%%folder_path%%*:</td>
       <td>
         <select name="folder_path">
           <option value="">%%select_directory%%</option>
           <optgroup label="%%new_des%%" style="text-decoration:none;">
             ##directories_list_new##
           </optgroup>
           <optgroup label="%%imported_des%%">
             ##directories_list##
           </optgroup>
         </select>
       </td>
     </tr>
##--
     <tr>
       <td>%%folder_path%%*:</td>
       <td>
         <input type=text name=folder_path class="field field50" value="##folder_path##" >
       </td>
     </tr>
--##
     <tr>
       <td>%%header%%*:</td>
       <td>
         <input type=text name=header class="field field40" value="##header##" maxlength="255">
       </td>
     </tr>
     <tr>
       <td>%%author%%:</td>
       <td>
         <input type=text name=author class="field field20" value="##author##" maxlength="255">
       </td>
     </tr>
  ##if(NO_WZ_DES_CATS!="1")##
     <tr>
       <td>
        %%category%%:
       </td>
       <td>
         ##--<select name="category">--##
           ##--<option value=0>%%select_category%%</option>--##
           ##categories_list##
         ##--</select>--##
       </td>
     </tr>
     <tr>
       <td>
        %%create_subcategory%%:
       </td>
       <td>
         <input type=text name=catname class="field field40" maxlength="30"/>
       </td>
     </tr>
  ##endif##
  </table>
    <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">


        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-body">
              <textarea class="field" style="width:100%" rows="14" name=body id="body">##body##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('body', cmD_STB , false);}
              </script>
            </div>
          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'body' : ['%%body%%', 'normal', '', false],
          '':''});
          
        </script>

       </td>
     </tr>
     </table>
    <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     ##picture_upload##
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
