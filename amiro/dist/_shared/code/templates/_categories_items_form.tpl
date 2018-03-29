%%include_language "_shared/code/templates/lang/_categories_items.lng"%%

<!--#set var="categories_js" value="
<SCRIPT language="javascript1.2">
<!--
##--
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
}--##

function checkCategoryData(form) {
  var res = true;
  ##--
  if(form.catname.value == '') {
    res = false;
    if(typeof(form.cat_id) == 'object') {
      if(form.cat_id.value > 0) {
        res = true;
      }
    }    
  }--##
  if(!res) {
    alert('%%categories_warn%%');
    form.catname.focus();
  }                                                           
  return res;
}

function categoryOnSubmitForm(form) {
##--
  if(typeof(form.id_page) == 'object') {
    if(form.id_page.disabled) {
      form.id_page.value = getElementAttribute(form.cat_id.options[form.cat_id.selectedIndex], 'id_page', false);
      form.id_page.disabled = false;
    }
  }--##
}

//-->
</SCRIPT>
"-->

<!--#set var="id_page_row" value="
<option value=##id## ##selected##>##name##</option>
"-->

<!--#set var="category_row" value="
<option value=##id## id_page="##id_page##" ##selected##>##name##</option>
"-->

<!--#set var="categories_selectbox" value="
         <select name="cat_id">         
           ##categories_rows##
         </select>                                            
"-->

<!--#set var="categories_empty_selectbox" value="
%%no_categories%%                              
"-->

<!--#set var="categories_field" value="                
     <tr>
       <td>
        %%category%%:
       </td>
       <td>
           ##categories_rows##                            
       </td>
     </tr>
##--
     <tr>
       <td>
        %%create_subcategory%%:
       </td>
       <td>
         <input type=text name=catname class=field size=40 maxlength="30" onkeyPress=" syncWithSelect(this.form.cat_id, this);">
       </td>
     </tr>
     <tr>
       <td>&nbsp;</td>
       <td>%%select_page%%: ##id_page_selectbox##
       </td>
     </tr>
--##
"-->                                                    

<!--#set var="category_list_header" value="
<td class="first_row_all" width="*">
 ##category_name##
 %%category%%
</td>
"-->

<!--#set var="id_page_selectbox" value="
<select name="id_page">
   ##id_pages_rows##
</select>
"-->