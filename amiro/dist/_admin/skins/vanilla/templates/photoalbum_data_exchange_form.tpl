##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/photoalbum.lng"%%
%%include_language "templates/lang/photoalbum_data_exchange.lng"%%
%%include_template "templates/_data_exchange_form.tpl"%%

<!--#set var="_id_page_field" value="
   <select id="id_page_sel" name=id_page>
     ##_id_page_rows##
   </select>
"-->

<!--#set var="categories_field" value="
     <tr id="categories_list">
       <td>&nbsp;</td>
       <td>
        %%category%%:
       </td>
       <td colspan="1">
           <div id="category_id" style="display: inline;">##categories_rows##</div>
       </td>
     </tr>
     <tr id="categories_list">
       <td>&nbsp;</td>
       <td>
        %%create_subcategory%%:
       </td>
       <td colspan="1">
         <div id="category_name" style="display: inline;"><input type=text name=catname class="field field40" maxlength="30" onkeyPress=" syncWithSelect(event, this.form.cat_id, this);"></div>
       </td>
     </tr>
##if(USE_ID_PAGE=="1")##
     <tr id="categories_list">
       <td colspan="2">&nbsp;</td>
       <td>%%select_page%%: <div id="categories_list_sel" style="display: inline;">##_id_page_field##</div>
       </td>
     </tr>
##endif##
"-->

<!--#set var="import_module_form" value="
<tr>
  <td colspan=3><br><b>%%photoalbum_additional_params%%</b><br><br>
  </td>
</tr>
##IF(CATEGORIES_ON == "1")##
<tr>
  <td colspan=3>
  <input type=radio name=cattype value=2 id=cattype_2 checked onClick="switchCategoriesList(false);"> <label for=cattype_2>%%photoalbum_cats_use%%</label>
  </td>
</tr>
  ##categories_field##
<tr>
  <td colspan=3>
  ##--
  %%dest_category%%: <select name="cat_id">
  ##categories_list##
  </select><br>
  <br>--##

  <input type=radio name=cattype value=1 id=cattype_1 onClick="switchCategoriesList(true);"> <label for=cattype_1>%%photoalbum_cats_create%%</label>
  </td>
</tr>
##ENDIF##

##if(USE_ID_PAGE=="1")##
 <tr id="categories_page">
   <td>&nbsp;</td>
   <td colspan="2">%%page%%: <div id="categories_pages_sel" style="display: inline;">##_id_page_field##</div>
   </td>
 </tr>
##endif##
<tr>
  <td colspan=3>
  <input type="checkbox" name="force_rewrite" value="1" id=force_rewrite checked><label for=force_rewrite>%%force_rewrite%%</label><br>
  <br>
  <div class="tooltip">
  %%photoalbum_note%%
  </div>
  </td>
</tr>

##IF(CATEGORIES_ON == "1")##
<SCRIPT LANGUAGE="JavaScript">
<!--
function switchCategoriesList(disabled) {

  var _style;
  _style = Array();
  if(disabled) {
    _style['disable'] = true;
    disableSelectBox('categories_list_sel', 'id_page_sel', true);
    disableSelectBox('category_id', 'cat_id', true);
    disableSelectBox('category_name', 'catname', true);
    setStylesForElements('categories_list', _style, 'setDisableStyle');
    _style['disable'] = false;
    setStylesForElements('categories_page', _style, 'setDisableStyle');
    disableSelectBox('categories_pages_sel', 'id_page_sel', false);

  } else {
    _style['disable'] = true;
    disableSelectBox('categories_pages_sel', 'id_page_sel', true);
    setStylesForElements('categories_page', _style, 'setDisableStyle');
    _style['disable'] = false;
    setStylesForElements('categories_list', _style, 'setDisableStyle');
    disableSelectBox('categories_list_sel', 'id_page_sel', false);
    disableSelectBox('category_id', 'cat_id', false);
    disableSelectBox('category_name', 'catname', false);

  }
}

function disableSelectBox(selName, selElem, disable) {
  var divSel;
  divSel  = document.getElementById(selName).all(selElem);
  divSel.disabled = disable;
}

function show_props(obj, objName) {
  var result = ""
  for (var i in obj) {
//alert(typeof(obj[i]));

//    if(typeof(obj[i]) == 'object') {
//      result += show_props(obj[i], objName + obj[i].name);
//    } else {
      result += objName + "." + i + " = " + obj[i] + "<br>"
//    }
  }
  return result
}

switchCategoriesList(false);
//-->
</SCRIPT>
##categories_js##
##ENDIF##
"-->