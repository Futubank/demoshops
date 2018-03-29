%%include_language "templates/lang/_categories_items.lng"%%

<!--#set var="categories_js" value="
<script type="text/javascript">
var skipCategoryOnBlur = [];
if(typeof(document.forms[_cms_document_form].id_page) == 'object') {
  document.forms[_cms_document_form].id_page.disabled=true;
}

function OnObjectKeyUp(oElement) {
  if(oElement.name == 'catname') {
    if(typeof(oElement.form.cat_id) == 'object') {
      oElement.form.cat_id.disabled=(oElement.value!='');
    }
    if(typeof(oElement.form.id_page) == 'object') {
      oElement.form.id_page.disabled=(oElement.value=='');
    }
  }
  return true;
}

function checkCategoryData(form) {
  var res = true;
  if(form.catname.value == '') {
    res = false;
    if(typeof(form.cat_id) == 'object') {
      if(form.cat_id.value > 0) {
        res = true;
      }
    }
  }
  if(!res) {
    alert('%%categories_warn%%');
    form.catname.focus();
  }
  return res;
}

function categoryOnSubmitForm(form) {
  if(typeof(form.id_page) == 'object') {
    if(form.id_page.disabled) {
      form.id_page.value = getElementAttribute(form.cat_id.options[form.cat_id.selectedIndex], 'id_page', false);
      form.id_page.disabled = false;
    }
  }

}

function categoryOnBlur(form)
{
    var catname = form.catname.value;
    if (catname.length && typeof(form.cat_id) == 'object' && skipCategoryOnBlur.indexOf(catname) < 0 && catname == fromHTMLToText(form.cat_id.options[form.cat_id.selectedIndex].innerHTML)) {
        if (confirm('%%warn_same_category_name%%')) {
            skipCategoryOnBlur.push(catname);
        } else {
            form.catname.value = '';
            form.cat_id.disabled = false;
        }
    }
    if (typeof(document.getElementById('select_page')) == 'object' && document.getElementById('select_page') != null) {
        if (catname.length < 1) {
            var o = document.getElementById('select_page');
            makeElementVisible(o, 'hidden');
        } else {
            var o = document.getElementById('select_page');
            makeElementVisible(o, 'block');
        }
    }
}

</script>
"-->

<!--#set var="id_page_row" value="
<option value=##id## ##selected##>##name##</option>
"-->

<!--#set var="category_row" value="<option value=##id## id_page="##id_page##" ##selected##>##name##</option>
"-->

<!--#set var="categories_selectbox" value="##EXT_MODULES_CUSTOM_FIELDS_ADDON##
<select name="cat_id" onChange="if(typeof(oExtModulesCustomFields) == 'object'){oExtModulesCustomFields.cbOnFormChange('cat_id');}skipCategoryOnBlur=[];if(AMI.find('#div_add_subcategory')){AMI.find('#div_add_subcategory').style.display='none';AMI.find('#img_add_subcategory').style.display='inline';}">##categories_rows##</select>
"-->

<!--#set var="categories_empty_selectbox" value="
%%no_categories%%
"-->

<!--#set var="categories_field" value="
     <tr>
       <td valign="top">
        %%category%%:
       </td>
       <td>
           ##categories_rows## <a href="javascript:void(0)" onClick="AMI.find('#img_add_subcategory').style.display='none';AMI.find('#div_add_subcategory').style.display='block'; return false;"><img id="img_add_subcategory" class=icon src="skins/vanilla/icons/icon-add.gif" title="%%create_subcategory%%" align="absmiddle" /></a><br />
           <table cellspacing="5" cellpadding="0" border="0" class="frm" id="div_add_subcategory" style="display:none">
	<col width="150">
	<col width="*">
            <tr>
              <td style="font-size: 10px">%%create_subcategory%%<sup>##new_category_required##</sup>:</td>
              <td><input type="text" name="catname" class="field field40"  maxlength="255" onkeyPress="syncWithSelect(event, this.form.cat_id, this);" onBlur="categoryOnBlur(this.form);" /> <a href="javascript:void(0)" onClick="var form = document.forms[_cms_document_form]; form.catname.value='';categoryOnBlur(form);form.cat_id.disabled=false;if(AMI.find('#div_add_subcategory')){AMI.find('#div_add_subcategory').style.display='none';AMI.find('#img_add_subcategory').style.display='inline';} return false;"><img id="img_hide" src="skins/vanilla/icons/icon-notinstalled.gif" title="%%hide%%" align="absmiddle" style="cursor:pointer" class=icon></a><script>if(typeof(document.forms[_cms_document_form].cat_id)=='undefined'){document.getElementById('img_hide').style.display='none';}</script></td>
##if(id_page_selectbox)##
            <tr id="select_page" style="display:none">
              <td align="right" style="font-size: 10px">%%select_page%%:</td>
              <td>##id_page_selectbox##</td>
            </tr>
##endif##
          </table>
       </td>
     </tr>
##--
     <tr>
       <td>
        %%create_subcategory%%<sup>##new_category_required##</sup>:
       </td>
       <td>
         <input type="text" name="catname" class="field field40"  maxlength="255" onkeyPress="syncWithSelect(event, this.form.cat_id, this);" onBlur="categoryOnBlur(this.form)" />
       </td>
     </tr>
     <tr id="select_page" style="display:none">
       <td>&nbsp;</td>
       <td>%%select_page%%: ##id_page_selectbox##</td>
     </tr>
--##
"-->

<!--#set var="category_list_header" value="
<td class="first_row_all">
 ##category_name##
 %%category%%
</td>
"-->

<!--#set var="id_page_selectbox" value="
<select name="id_page">
   ##id_pages_rows##
</select>
"-->