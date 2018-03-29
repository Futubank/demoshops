<!--#set var="links_popup_form" value="
<form name="linksForm" action="##script_link##" method="POST">
<table cellspacing="0" cellpadding="10" align="center" width=100%>
  <tr>
   <td align="center">
    <table cellspacing="0" cellpadding="0" align="center">
     <tr>
      <td>
         <div align="right">
         <select name="id_category" size="25" style="min-width:250px;" multiple>
         ##cat_select##
         </select>
         <script type="text/javascript">initCatSelectbox()</script>
         </div>
      </td>
     </tr>
    </table>
   </td>
  </tr>
  <tr>
    <td align="center">
        <input type="button" name="add" value="  %%ok_btn%%  " class="but" onClick="doLinksChanges()">&nbsp;
        <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="closeDialogWindow()">
    </td>
   </tr>
</table>
"-->

<!--#set var="links_popup" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - %%eshop_create_links%%</TITLE>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css">
<script type="text/javascript">

function initCatSelectbox(){
    var oItemLinksList = top.document.forms.eshop_form.item_links;
    var itemCatId = top.document.forms.eshop_form.cat.value;
    var oItemListSelect = document.forms.linksForm.id_category;

    var aSelectedCats = oItemLinksList.value.split(',');
    var oSelectedCatsHash = new Object();
    for(var i = 0; i < aSelectedCats.length; i++){
        oSelectedCatsHash[aSelectedCats[i]] = true;
    }

    for(var i = 0; i < oItemListSelect.options.length; i++){
        if(oItemListSelect.options[i].value != '' && oItemListSelect.options[i].value != itemCatId){
            if(oSelectedCatsHash[oItemListSelect.options[i].value]){
                oItemListSelect.options[i].selected = true;
            }
        }
    }
}

function doLinksChanges() {
    var oItemLinksList = top.document.forms.eshop_form.item_links;
    var itemCatId = top.document.forms.eshop_form.cat.value;
    var oItemLinksNum = top.document.getElementById('idItemLinksNum');
    var oItemListSelect = document.forms.linksForm.id_category;

    var itemsCount = 0;
    var itemsList = '';
    for(var i = 0; i < oItemListSelect.options.length; i++){
        if(oItemListSelect.options[i].selected && oItemListSelect.options[i].value != ''){
            if(oItemListSelect.options[i].value == itemCatId){
                oItemListSelect.options[i].selected = false;
                alert('%%links_exclude_current_category%%');
            }else{
                itemsCount++;
                itemsList = itemsList + (itemsList != '' ? ',' : '') + oItemListSelect.options[i].value;
            }
        }
    }

    oItemLinksList.value = itemsList;
    oItemLinksNum.innerHTML = itemsCount;

    if(itemsCount > 0){
        top.document.getElementById('idItemLinksHas').style.display = 'inline';
        top.document.getElementById('idItemLinksNone').style.display = 'none';
    }

    closeDialogWindow();
    return false;
}
</script>

</HEAD>
<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">
<center>
<br>
##form##
</center>
</BODY>
</HTML>
"-->

<!--#set var="products_discounts" value="
<tr>
    <td colSpan="3"><br />
##if(global_discount)##
##global_discount##<br />
##endif##
##if(category_dependent_discount)##
##category_dependent_discount##
##endif##
    </td>
</tr>
"-->

<!--#set var="special_popup_form" value="
<form name="specialForm" action="##script_link##" enctype="multipart/form-data" method="POST">
<table cellspacing="0" cellpadding="10" align="center" width=100%>
  <tr>
   <td>
     <label><input type="checkbox" name="on_special[0]" ##on_special## value="1">&nbsp;%%on_special%%</label>
     ##special_flag_list##
   </td>
  </tr>
  <tr>
    <td align="center">
        <input type="button" name="add" value="  %%ok_btn%%  " class="but" onClick="return onBtnOk('special_confirm');">&nbsp;
        <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="closeDialogWindow();">
    </td>
   </tr>
</table>
<input id="_async_marker" type="hidden" />
</form>
<script>
function _getSpecialValue() {
  var frm = document.forms.specialForm;
  var numEl = frm.elements.length;
  var special = 0;
  for(var i=0; i<numEl; i++) {
    if(frm.elements[i].type == "checkbox") {
      if(frm.elements[i].checked) {
        special += parseInt(frm.elements[i].value);
      }
    }
  }
  return special;
}
</script>
"-->

<!--#set var="grp_special_popup_form" value="
<form name="specialForm" action="##script_link##" enctype="multipart/form-data" method="POST">
<table cellspacing="0" cellpadding="10" align="center" width=100%>
  <tr>
   <td>
     <table cellspacing="0" cellpadding="0" align="center" width=100%>
     <tr>
       <td>&nbsp;</td>
       <td><b>%%grp_set_special%%</b></td>
       <td><b>%%grp_reset_special%%</b></td>
     </tr>
     <tr>
       <td>%%on_special%%</td>
       <td align="center"><input type="checkbox" name="on_special[0]" value="1" onClick="resetCheckbox('on_special[0]', 'off_special[0]')"></td>
       <td align="center"><input type="checkbox" name="off_special[0]" value="1" onClick="resetCheckbox('off_special[0]', 'on_special[0]')"></td>
     </tr>
     ##special_flag_list##
     </table>
   </td>
  </tr>
  <tr>
    <td align="center">
        <input type="hidden" name="step" value="2">
        <input type="hidden" name="_grp_ids" value="##_grp_ids##">
        <input type="button" name="add" value="  %%ok_btn%%  " class="but" onClick="return onBtnOk('grp_special_advanced');">&nbsp;
        <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="closeDialogWindow();">
    </td>
   </tr>
</table>
<input id="_async_marker" type="hidden" />
</form>
<script>
function resetCheckbox(name1, name2) {
  if(document.forms.specialForm.elements[name1].checked) {
    document.forms.specialForm.elements[name2].checked = false;
  }
}

function _getSpecialValue() {
  var frm = document.forms.specialForm;
  var numEl = frm.elements.length;
  var onSpecial = 0;
  var offSpecial = 0;
  for(var i=0; i<numEl; i++) {
    if(frm.elements[i].type == "checkbox") {
      if(frm.elements[i].checked) {
        if((frm.elements[i].name).indexOf("on") == 0) {
          onSpecial += parseInt(frm.elements[i].value);
        } else {
          offSpecial += parseInt(frm.elements[i].value);
        }
      }
    }
  }
  return 'advanced_' + onSpecial + '_' + offSpecial;
}
</script>
"-->


<!--#set var="special_popup" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - %%eshop_special_form%%</TITLE>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css">
<script type="text/javascript">

function onBtnOk(action) {
  var special = _getSpecialValue();
  if(special != 'advanced_0_0') {
      top.document.forms['eshop_form'].special.value = special;
      top.user_click(action,'##id##');
      closeDialogWindow();
      return true;
   } else {
      alert('%%special_advanced_warn%%');
      return false;
   }
}
</script>

</HEAD>
<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">
<center>
<br>
##form##
</center>
</BODY>
</HTML>
"-->


<!--#set var="special_flag_splitter" value="&nbsp; "-->
<!--#set var="grp_special_flag_splitter" value=""-->

<!--#set var="special_flag_row" value="
<label><input type="checkbox" name="on_special[##num##]" id="on_special[##num##]" ##on_special## value="##value##">&nbsp;##caption##</label>
"-->
<!--#set var="grp_special_flag_row" value="
<tr>
  <td>##caption##</td>
  <td align="center"><input type="checkbox" name="on_special[##num##]" value="##value##" onClick="resetCheckbox('on_special[##num##]', 'off_special[##num##]')"></td>
  <td align="center"><input type="checkbox" name="off_special[##num##]" value="##value##" onClick="resetCheckbox('off_special[##num##]', 'on_special[##num##]')"></td>
</tr>
"-->

<!--#set var="grp_special_flag_list" value="
##special_flag_list##
"-->

<!--#set var="special_flag_list;special_flag_list_1" value="##special_flag_list##"-->

<!--#set var="special_flag_list_2;special_flag_list_4" value="
       <tr>
         <td colspan=2>
            ##special_flag_list##
         </td>
       </tr>
"-->

<!--#set var="special_flag_list_3" value="
       <tr>
         <td colspan=2>
            ##special_flag_list##
         </td>
       </tr>
"-->

<!--#set var="ref_value_list;ref_reference_list" value="
<select name="##custom_name##_select">
  <option value="">---</option>
  ##list##
</select>
"-->

<!--#set var="ref_set_list" value="
<select name="##custom_name##_select" size=5 multiple>
  ##list##
</select>
"-->

<!--#set var="ref_value_row" value="
  <option value="##value_1##" ##selected##>##name##</option>
"-->

<!--#set var="ref_reference_row;ref_set_row" value="
  <option value="##id##" ##selected##>##name##</option>
"-->

<!--#set var="ref_value_js;ref_reference_js" value="
  if(name=="##custom_name##_select") {
    document.eshop_form.##custom_name##.value = document.eshop_form.##custom_name##_select.value;
  }
"-->

<!--#set var="ref_set_js" value="
  if(name=="##custom_name##_select") {
    document.eshop_form.##custom_name##.value = ";";
    for(i = document.eshop_form.##custom_name##_select.length - 1; i >= 0; i--){
      if(document.eshop_form.##custom_name##_select[i].selected)
        document.eshop_form.##custom_name##.value += document.eshop_form.##custom_name##_select[i].value + ";";
    }
  }
"-->


<!--#set var="custom_field_flagmap" value="
     <tr vAlign=top>
       <td>
         ##custom_title##:
       </td>
       <td>
         ##if(reference_id > 0 && value_type == "ref_value")##
         <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255">
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_reference")##
         <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255">
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&refref=1&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1, 0); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_set")##
         <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255">
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=1&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 720, 600, 1, 0); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##else##
          ##flag_map##<br clear="all">
         ##endif##
       </td>
     </tr>
"-->
<!--#set var="custom_field_flag" value="
     <div style="float: left; margin-right: 30px"><nobr><input type=checkbox name=##custom_name## value="1" ##if(custom_value == "1")##checked##endif## id=label_##custom_name##> <label for=label_##custom_name##>##custom_title##</label></nobr></div>
"-->
<!--#set var="custom_field_flagsplit" value="
    <br clear="all">
"-->

<!--#set var="custom_field_related_items" value="
     <tr>
       <td>
         ##custom_title##:
       </td>
       <td>
         ##if(reference_id > 0 && value_type == "ref_value")##
         <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255">
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_reference")##
         <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255">
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&refref=1&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_set")##
         <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255">
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=1&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##else##
         <span id="div_##custom_field_name##_add" style="display: ##custom_related_items_add##;"><a href="javascript:void(0);" onClick="openExtDialog('%%related_items_add_list%%', '##CURRENT_OWNER##_item.php?mode=select_related&custom_field_name=##custom_field_name##', 1); return false;"><img title="%%related_items_add_icon%%" class=icon src="skins/vanilla/icons/icon-dicget-many.gif" helpId="btn_related_items_add" align=absmiddle></a></span>
         <span id="div_##custom_field_name##_edit" style="display: ##custom_related_items_edit##;"><a href="javascript:void(0);" onClick="openExtDialog('%%related_items_edit_icon%%', '##CURRENT_OWNER##_item.php?mode=select_related&custom_field_name=##custom_field_name##&_grp_ids='+document.eshop_form.##custom_field_name##.value, 1); return false;"><img id="es_picture" title="%%related_items_edit_icon%%" class=icon src="skins/vanilla/icons/icon-dicget-many.gif" helpId="btn_related_items_edit" align=absmiddle></a></span>
         <font style="font-size:9px">[%%number_related_items%%:<input name="custom_field_##id##_number" type="text" value="##related_items_number##" readonly style="width: 20px;text-align: right; background-color: #F4F4F4;font-size:11px; BORDER: #FFFFFF 0px solid; ">]</font>
         ##endif##
       </td>
     </tr>
"-->

<!--#set var="custom_field_related_cats" value="
     <tr>
       <td>
         ##custom_title##:
       </td>
       <td>
         ##if(reference_id > 0 && value_type == "ref_value")##
         <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255">
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_reference")##
         <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255">
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&refref=1&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_set")##
         <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255">
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=1&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##else##
         <span id="div_##custom_field_name##_add" style="display: ##custom_related_cats_add##;"><a href="javascript:void(0);" onClick="openExtDialog('%%related_cats_add_list%%', '##CURRENT_OWNER##_cat.php?mode=select_related_cats&custom_field_name=##custom_field_name##', 1); return false;"><img title="%%related_cats_add_icon%%" class=icon src="skins/vanilla/icons/icon-dicget-many.gif" helpId="btn_related_cats_add" align=absmiddle></a></span>
         <span id="div_##custom_field_name##_edit" style="display: ##custom_related_cats_edit##;"><a href="javascript:void(0);" onClick="openExtDialog('%%related_cats_edit_icon%%', '##CURRENT_OWNER##_cat.php?mode=select_related_cats&custom_field_name=##custom_field_name##&_grp_ids='+document.eshop_form.##custom_field_name##.value, 1); return false;"><img id="es_picture" title="%%related_cats_edit_icon%%" class=icon src="skins/vanilla/icons/icon-dicget-many.gif" helpId="btn_related_cats_edit" align=absmiddle></a></span>
         <font style="font-size:9px">[%%number_related_cats%%:<input name="custom_field_##id##_number" type="text" value="##related_cats_number##" readonly style="width: 20px;text-align: right; background-color: #F4F4F4;font-size:11px; BORDER: #FFFFFF 0px solid; ">]</font>
         ##endif##
       </td>
     </tr>
"-->

<!--#set var="custom_field_int" value="
     <tr>
       <td>
         ##custom_title##:
       </td>
       <td>
         ##if(ref_select!="")##
           <input type=hidden name=##custom_name## value="##custom_value##">
           ##ref_select##
         ##elseif(reference_id > 0 && value_type != "scalar")##
           <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255" readonly>
         ##else##
           <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255">
         ##endif##
         ##if(reference_id > 0 && value_type == "ref_value")##
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_reference")##
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&refref=1&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_set")##
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=1&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##endif##
        </td>
     </tr>
"-->

<!--#set var="custom_field_float" value="
     <tr>
       <td>
         ##custom_title##:
       </td>
       <td>
         ##if(ref_select!="")##
           <input type=hidden name=##custom_name## value="##custom_value##">
           ##ref_select##
         ##elseif(reference_id > 0 && value_type != "scalar")##
           <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255" readonly>
         ##else##
           <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255">
         ##endif##
         ##if(reference_id > 0 && value_type == "ref_value")##
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_reference")##
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&refref=1&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_set")##
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=1&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##endif##
        </td>
     </tr>
"-->

<!--#set var="custom_field_date" value="
     <tr>
       <td>
         ##custom_title##:
       </td>
       <td>
         <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255">
         ##if(reference_id > 0 && value_type == "ref_value")##
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.eshop_form.##custom_name##);"><img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId= "clnd_date"/></a>
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_reference")##
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&refref=1&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_set")##
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=1&reference_id=##reference_id##&references='+encodeURIComponent(document.eshop_form.##custom_name##.value), 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##else##
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.eshop_form.##custom_name##);"><img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId= "clnd_date"/></a>
         ##endif##
        </td>
     </tr>
"-->

<!--#set var="custom_field_char" value="
     <tr>
       <td>
         ##custom_title##:
       </td>
       <td>
         ##if(ref_select!="")##
           <input type=hidden name=##custom_name## value="##custom_value##">
           ##ref_select##
         ##elseif(reference_id > 0 && value_type != "scalar")##
           <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255" readonly>
         ##else##
           <input type=text name=##custom_name## class="field field50" value="##custom_value##" maxlength="255">
         ##endif##
         ##if(reference_id > 0 && value_type == "ref_value")##
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&reference_id=##reference_id##&references='+document.eshop_form.##custom_name##.value, 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_reference")##
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&refref=1&reference_id=##reference_id##&references='+document.eshop_form.##custom_name##.value, 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##elseif(reference_id > 0 && value_type == "ref_set")##
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=1&reference_id=##reference_id##&references='+document.eshop_form.##custom_name##.value, 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##endif##
       </td>
     </tr>
"-->

<!--#set var="custom_field_text" value="
     <tr>
       <td>
         ##custom_title##:
       </td>
       <td>
         ##if(ref_select!="")##
           <input type=hidden name=##custom_name## value="##custom_value##">
           ##ref_select##
         ##elseif(reference_id > 0 && value_type != "scalar")##
           <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255" readonly>
         ##else##
            <table>
            <tr>
                <td>
                    <textarea name=##custom_name## id=##custom_name## class="field" wrap="soft" cols="5" rows="3">##custom_value##</textarea>
                    <div id="##custom_name##_div" style="display: none;">
                        <div style="border:1px solid #cbcdcc;border-radius:5px;">
                            <textarea autocomplete="off" name="##custom_name##_ce" id="##custom_name##_ce" class="field" wrap="soft" style="width:100%" rows="14">##custom_value##</textarea>
                        </div>
                        <div style="text-align: center;">
                            <input class="but" type="submit" value="%%apply_btn%%" onclick="saveCEPopupContent('##custom_name##');" />&nbsp;&nbsp;
                            <input class="but" type="button" value="%%cancel_btn%%" onclick="closeCEPopup('##custom_name##');" />
                        </div>
                        <br /><br />
                    </div>
                </td>
                <td>
                    <a href="javascript:void(0);" onclick="openCEPopup('##custom_name##', '##custom_title##');">
                    <img title="%%edit_btn%%" border="0" src="skins/vanilla/icons/icon-edit.gif" align=absmiddle class=icon></a>
                </td>
            </tr>
            </table>
         ##endif##
         ##if(reference_id > 0 && value_type == "ref_reference")##
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=0&refref=1&reference_id=##reference_id##&references='+document.eshop_form.##custom_name##.value, 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##endif##
       </td>
     </tr>
"-->

<!--#set var="custom_field_set" value="
     <tr>
       <td>
         ##custom_title##:
       </td>
       <td>
         <input type=text name=##custom_name## class="field field50" value="##custom_value##" maxlength="255">
         ##if(reference_id > 0)##
         <a href="javascript:void(0);" onClick="openExtDialog('%%eshop_references_add%%', '##CURRENT_OWNER##_reference_popup.php?itemId=##id##&field_id=##custom_name##&refmulti=1&reference_id=##reference_id##&references='+document.eshop_form.##custom_name##.value, 1); return false;">
         <img title="%%eshop_references_add%%" border="0" src="skins/vanilla/icons/icon-dicget-many.gif" helpId="btn_reference_add" align=absmiddle class=icon>
         </a>
         ##endif##
       </td>
     </tr>
"-->

<!--#set var="custom_field_picture" value="
     <tr>
       <td nowrap>
         ##custom_title##:
       </td>
       <td>
         <input type=hidden name=##custom_name## class=field value="##custom_value##" detectchanges="on">
         <span id="div_img_##custom_name##">##edit_picture##</span>
       </td>
     </tr>
"-->

<!--#set var="custom_field" value="
     <tr>
       <td>
##custom_title##:
      </td>
       <td>
         <input type=text name=##custom_name## class="field field50" value="##custom_value##" maxlength="255">
       </td>
     </tr>
"-->

<!--#set var="item_type_row" value="
         <OPTION value="##value##" ##selected##>##name##</OPTION>
"-->

<!--#set var="item_type_list" value="
     <tr>
       <td>
%%item_type%%*:
      </td>
       <td>
         <SELECT name=item_type>
           ##item_type_rows##
         </SELECT>
       </td>
     </tr>
"-->

<!--#set var="item_type_single" value="<input type="hidden" name="item_type" value="##item_type##" />
"-->

<!--#set var="charge_type" value="
         <SELECT name=##name##>
           <OPTION value='abs' ##abs##>##currency##</OPTION>
           <OPTION value='percent' ##percent##>%</OPTION>
         </SELECT>
"-->

<!--#set var="eshop_digitals_fields" value="
       <tr>
        <td>
        <div name="eshop_digitals_fields" style="display:##eshop_digitals_display##;">
         %%file_name%%:
        </div>
        </td>
        <td>
        <div name="eshop_digitals_fields" style="display:##eshop_digitals_display##;">
         <span id="div_eshop_digitals_icon_add" style="display: ##eshop_digitals_icon_add##;"><a href="javascript:void(0);" onClick="{if('##id##')openExtDialog('%%eshop_digitals_add_list%%', '##CURRENT_OWNER##_files.php?itemId=##id##&file_ids='+document.eshop_form.file_ids.value, 1);else alert('%%warn_apply_item%%');}return false"><img title="%%eshop_digitals_add_list%%" class=icon src="skins/vanilla/icons/icon-no_file.gif" helpId="btn_files_add" align=absmiddle></a></span>
         <span id="div_eshop_digitals_icon_edit" style="display: ##eshop_digitals_icon_edit##;"><a href="javascript:void(0);" onClick="openExtDialog('%%eshop_digitals_edit_list%%', '##CURRENT_OWNER##_files.php?itemId=##id##&file_ids='+document.eshop_form.file_ids.value, 1); return false;"><img id="es_picture" title="%%eshop_digitals_edit_list%%" class=icon src="skins/vanilla/icons/icon-file.gif" helpId="btn_files_add" align=absmiddle></a></span> <font style="font-size:9px">[%%number_files%%:<input name="num_files" type="text" value="##num_files##" readonly style="width: 20px;text-align: right; background-color: #FFFFFF;font-size:11px; BORDER: #FFFFFF 0px solid; ">]</font>
        </div>
        </td>
      </tr>
"-->

<!--#set var="eshop_goods_fields" value="
"-->

<!--#set var="captions_array" value="
var es_price_captions = new Array(##price_captions##);
"-->


<script type="text/javascript">
var editor_enable = '##editor_enable##';
var _cms_document_form = 'eshop_form';
var _cms_script_link = '##script_link##?';
##pictures_js_vars##

var es_excelsheet_on = ##excelsheet_on##;

##captions_array##

var pageIsLast='##page_is_last##';

var oldSelectIndex;
var oldItemTypeIndex;
var startCol = 5;
var currentType='##default_item_type##';
var numDecimalDigit = ##num_decimal_digit##;
var pricesOn = new Array(##prices_on##);
var colNum = pricesOn.length;

var extraColumns = Array();//Array ('D', 'E', 'F', 'G', 'H', 'I');

var _startLetter = String('A').charCodeAt(0);
var _firstShift =  startCol - 2;
var _endLetter = String('Z').charCodeAt(0);// + startCol - 1;
var _numLetter = 0;


var _prefix = "";
for(var i=0; i<=colNum; i++) {
  currLetter = _startLetter + i + _firstShift;
  extraColumns[i] = _prefix + String.fromCharCode(currLetter);
  if(currLetter == _endLetter) {
    _firstShift = -i - 1;
    _prefix = String.fromCharCode(_startLetter + _numLetter);
    _numLetter++;
  }
}

function getPriceIndex(num) {
  var res = -1;
  for(var i=0;i<pricesOn.length;i++) {
    if(parseInt(pricesOn[i]) == num) {
      res = i;
      break;
    }
  }
  return res;
}

function openShippingTypesPopup(form)
{
    var tail = form.id_shipping_type.value > 0 ? '&id=' + form.id_shipping_type.value + '&action=edit' : '';
    openDialog('%%shipping_type%%', '##shipping_types_link##?popup=1' + tail);
}

function CheckForm(form) {
   var errmsg = "";

   ##audit_check_form##

   editor_updateHiddenField("announce");
   editor_updateHiddenField("special_announce");
   editor_updateHiddenField("description");

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   ##if(ONE_PIC_AT_LEAST_REQUIRED)##
   if ((form.popup_picture && form.popup_picture.value == "" || !form.popup_picture) && (form.picture && form.picture.value == "" || !form.picture)) {
       errmsg+='%%pictures_warn%%';
       alert(errmsg);
       return false;
   }
   ##endif##

   if (typeof(form.price) != 'undefined' && form.price.value!="" && !checkMoneyValue(form.price.value, true)) {
       return focusedAlert(form.price, '%%price_warn%%');
   }

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

   if(form.tax_type){
       if(form.tax_type[0].selected) {
           if (!checkMoneyValue(form.tax.value, false)) {
               errmsg+='%%tax_warn%%';
               setTabFocus(form, "tax");
               alert(errmsg);
               return false;
           }
       }
   }

   if(form.shipping_type){
       if(form.shipping_type[0].selected) {
           if (!checkMoneyValue(form.shipping.value, false)) {
               errmsg+='%%shipping_warn%%';
               setTabFocus(form, "shipping");
               alert(errmsg);
               return false;
           }
       }
   }

   if(form.discount_type){
       if(form.discount_type[0].selected) {
           if (!checkMoneyValue(form.discount.value, false)) {
               errmsg+='%%discount_warn%%';
               setTabFocus(form, "discount");
               alert(errmsg);
               return false;
           }
       }
   }

    for(var i=0;i<colNum;i++) {
        numPrice = pricesOn[i];
        if(typeof(form.elements["price"+numPrice]) != "undefined") {
            if(form.elements["price"+numPrice].value!="" && !checkMoneyValue(form.elements["price"+numPrice].value, false)) {
                errmsg+='%%price_value_warn%%';
                setTabFocus(form, "price"+numPrice);
                alert(errmsg);
                return false;
            }
        }
    }

    if (!(typeof(form.id_shipping_type) == 'undefined')) {
       form.id_shipping_type.disabled = (form.id_shipping_type.value == form.id_shipping_type_source.value);
    }

    if (!(typeof(form.id_tax_class) == 'undefined')) {
       form.id_tax_class.disabled = (form.id_tax_class.value == form.id_tax_class_source.value);
    }

    if(typeof(preSubmit) == "function") {
        preSubmit();
    }

    return true;
}

function setTabFocus(form, fName) {
    window.baseTabs.showTab("prices");
    form.elements[fName].focus();
}

##script_alerts##

function OnObjectChanged_eshop_item_form_def(name, first_change, evt){

cform = document.forms[_cms_document_form];

if(name=="item_type") {
    cRes = true;
    if(eval(currentType+'_change_warn') != "") {
      cRes = confirm(eval(currentType+'_change_warn'));
    }
    if(cRes) {
      oldItemTypeIndex=cform.item_type.selectedIndex;

      if(currentType == 'eshop_goods'){
        makeElementVisible(document.getElementById('specTr1'), 'none');
        makeElementVisible(document.getElementById('specTr2'), 'none');
        makeElementVisible(document.getElementById('specTr3'), 'none');
      }
      var elms = getObjectsByName('div', currentType+"_fields");
      if(elms.length > 0) {
          for(var i=0; i< elms.length; i++) {
            makeElementVisible(elms[i], 'none');
            elms[i].disabled = true;
          }
      }

      currentType = document.forms[_cms_document_form].elements["item_type"].value;

      if(currentType == 'eshop_goods'){
        makeElementVisible(document.getElementById('specTr1'), 'block');
        makeElementVisible(document.getElementById('specTr2'), 'block');
        makeElementVisible(document.getElementById('specTr3'), 'block');
      }
      var elms = getObjectsByName('div', currentType+"_fields");
      if(elms.length > 0) {
          for(var i=0; i< elms.length; i++) {
            makeElementVisible(elms[i], 'block');
            elms[i].disabled = false;
          }
      }

    } else {
      cform.item_type.selectedIndex=oldItemTypeIndex;
    }
  }

  if(name=="cat") {
    changeCategory(document.forms[_cms_document_form].elements["cat"].value);
  }
  if(name.indexOf("price_checkbox") == 0) {
    num = name.substr(14, 2);
    switchPriceMode(num);
  }

  if(name == "variable_price" || name == "item_type"){
    onChangeVariablePrice();
  }


  ##pictures_js_script##

  ##references_select_js##

  //alert(name);

  return true;

}

if(typeof(window.formChangeHandlerAdded) == 'undefined'){
    addFormChangedHandler(OnObjectChanged_eshop_item_form_def);
    window.formChangeHandlerAdded = true;
}

function onChangeVariablePrice(){
    cform = document.forms[_cms_document_form];
    if (!cform.variable_price) {
        return;
    }
    if(cform.variable_price.checked && cform.price && cform.item_type.value=='eshop_account')
        cform.price.disabled = true;
    else if(cform.price)
        cform.price.disabled = false;

    if(cform.item_type && cform.item_type.value == 'eshop_account')
        makeElementVisible(document.getElementById('tr_variable_price'), 'block');
    else
        makeElementVisible(document.getElementById('tr_variable_price'), 'none');
}

function OnObjectKeyUp(oElement) {
    elemName = oElement.name;
    if(elemName.indexOf("price") == 0 && elemName.indexOf("price_checkbox") == -1 && elemName.indexOf("price_expr") == -1) {
        if(elemName == "price") {
          onChangePrice();
        } else {
          elemNum = elemName.substr(5, 2);
          onChangeField(elemNum);
        }
    }

    name = elemName;
    ##references_select_js##
}

function changeCategory(value){
    cform = document.forms[_cms_document_form];

    if(typeof(cform) != 'object'){
        return false;
    }

    var
        anchor = '#anchor', tail = '',
        isPartialAsync = (typeof(module60compatible) != 'undefined') && module60compatible;

    if(confirm('%%change_cat_warning%%')){

        if(isPartialAsync){
            AMI.Page.addHashData(
                '##module##',
                {
                    category: value,
                    cat_id:   value
                }
            );
            AMI.Cookie.set('filter_field_category_' + interface_lang, value);
            AMI.Cookie.save(true);
            anchor = document.location.hash;
        }

        if(typeof(cform.elements['cid']) == 'undefined'){
            tail = '&cid=' + value;
        }else{
            cform.elements['cid'].value = value;
        }
        if(typeof(cform.elements['category']) != 'undefined'){
            cform.elements['category'].value = value;
        }
        if(typeof(cform.elements['cat_id']) != 'undefined'){
            cform.elements['cat_id'].value = value;
        }

        _cms_document_form_changed_discrad_confirmation = true;
        if(cform.elements['action'].value != 'apply'){
            cform.elements['action'].value = '';
            document.location = _cms_script_link + collect_link(cform) + tail + anchor;
        } else {
            cform.elements['action'].value = 'edit';
            id=cform.elements['id'].value;
            document.location = _cms_script_link + collect_link(cform) + tail + '&id=' + id + anchor;
        }

    }else{
        cform.cat.selectedIndex = oldSelectIndex;
    }
    return false;
 }

function onChangePrice() {
    cform = document.eshop_form;
    if(typeof(calcFields) == 'function') {
        expr = cform.elements["price"].value;
        value=expr.replace(/^\+| /g, "").replace(/,/, ".");
        if(value != "" && !isNaN(value*1)) {
            price = parseFloat(value);
            cform.elements["price"].style.border="black 1px solid";
        } else {
            price = 0;
            if(value != "") {
                cform.elements["price"].style.border="red 1px solid";
            } else {
                cform.elements["price"].style.border="black 1px solid";
            }
        }
        calcFields(0);
    }
    return true;
}

function DisableRefSelect(name){
    if('object' == typeof(document.eshop_form.elements[name])){
        document.eshop_form.elements[name].disabled = true;
        document.eshop_form.elements[name].title = '%%disabled_ref_select%%';
    }
}

function refreshMultiselect(oSelect){
    AMI.$(oSelect).multiselect('refresh');
}

// functions for CE popup handling (text custom fields support)

function openCEPopup(name, title){
    cleanCEPopup(name);

    var popup = new AMI.UI.Popup(AMI.find('#' + name + '_div'),
        {
            id: name + '_popup',
            width: 800,
            /*height: 600,*/
            autoshow: true,
            modal: true,
            hasCloseBtn: false,
            header: title,
            zIndex: 100000,
            onShow: function(){
                document.getElementById(name + '_ce').value = document.getElementById(name).value;
                if(editor_generate != 'undefined'){
                    editor_generate(name + '_ce', cmD_STB, false);
                }
            }
        });
}

function closeCEPopup(name){
    closePopup();
    cleanCEPopup(name);
}

function cleanCEPopup(name){
    var divContent =
        '<div style="border:1px solid #cbcdcc;border-radius:5px;">' +
	    '<textarea autocomplete="off" name="' + name + '_ce" id="' + name + '_ce" class="field" wrap="soft" style="width:100%" rows="14"></textarea>' +
        '</div>' +
		'<div style="text-align: center;margin-top:10px;">' +
		'<input class="but" type="submit" value="%%apply_btn%%" onclick="saveCEPopupContent(\'' + name + '\');" />&nbsp;&nbsp;' +
		'<input class="but" type="button" value="%%cancel_btn%%" onclick="closeCEPopup(name);" />' +
		'</div><br /><br />';
    if(document.getElementById(name + '_div')){
        document.getElementById(name + '_div').innerHTML = divContent;
    }
}

function saveCEPopupContent(name){
    var ceName = name + '_ce';
    //editor_updateHiddenField(ceName);

    var textareaObject = AMI.find('#' + ceName);
    var editorObject = textareaObject.editorObject;
    if(editorObject.contentChanged){
        if(editorObject.highlighter){
            editorObject.highlighter.save();
            editorObject.highlighter.highlight(false);
        }
        if(editorObject.currentMode == 'editor'){
            editorObject.transportTextFromEditorToTextarea(true);
        }
        if(editorObject.currentMode == 'bb'){
            editorObject.transportTextFromBBToTextarea();
        }
    }else{
        textareaObject.value = editorObject.originalHTML;
    }

    document.getElementById(name).value = document.getElementById(ceName).value;
    closePopup();
    cleanCEPopup(name);
}

</script>


<!--#set var="prices_script" value="
<script type="text/javascript">
var pricesExprs = new Array(##expressions##);
var pricesExprsEx = new Array(##expressions_ex##);
var pricesBackup = new Array(##num_prices##);
var price=##price_value0##;
##price_vars##
##--currency_vars--##

##IF(currency_values != "")##
var curRates = {##currency_values##};
##endif##

function preSubmit() {
    cform = document.eshop_form;
    for(var i=0;i<colNum;i++) {
        numPrice = pricesOn[i];
        if(typeof(cform.elements["price_checkbox"+numPrice]) != "undefined") {
            if(cform.elements["price_checkbox"+numPrice].checked) {
                cform.elements["price"+numPrice].disabled = false;
                //if(cform.elements["price"+numPrice].value != "") {
                //  eval('cform.elements["price' + numPrice + '"].value = price' + numPrice + ';');
                //}
            }
        }
    }
}

function checkField(num) {
    cform = document.forms["eshop_form"];
    expr=cform.elements["price"+num].value;
    value=expr.replace(/^\+| /g, "").replace(/,/, ".");
    if(value!="" && !isNaN(value*1)) {
        expr = "price"+num+"="+value+";";
        if(!cform.elements["price_checkbox"+num].checked && typeof(cform.elements["currency"+num]) != "undefined") {
          expr = "price"+num+"="+value+"/curRates['cur_"+cform.elements["currency"+num].value+"'];";
        }
        eval(expr);
        cform.elements["price"+num].style.border="black 1px solid";
    } else {
        eval("price"+num+"=0;");
        if(value!="") {
            cform.elements["price"+num].style.border="red 1px solid";
        } else {
            cform.elements["price"+num].style.border="black 1px solid";
        }
    }
}

function onChangeField(num) {
    checkField(num);
    calcFields(num);
    return true;
}

function calcFields(num) {
    cform = document.eshop_form;
    for(var i=0;i<##num_prices##;i++) {
        numPrice = pricesOn[i];
        if(numPrice != num) {
            if(typeof(cform.elements["price_checkbox"+numPrice]) != "undefined") {
                if(cform.elements["price_checkbox"+numPrice].checked) {
                    if(typeof(cform.elements["currency"+numPrice]) != "undefined") {
                      expr = '('+pricesExprs[i]+')*curRates[\'cur_'+cform.elements["currency"+numPrice].value+'\']';
                    } else {
                      expr = pricesExprs[i];
                    }
                    eval("cform.elements['price'+"+numPrice+"].value = extRound("+expr+", "+numDecimalDigit+");");
                }
            }
        }
    }
}

function switchPriceMode(num) {
    cform = document.eshop_form;
    priceIndex = getPriceIndex(num);
    if(cform.elements["price_checkbox"+num].checked) {
        cform.elements["price"+num].disabled = true;
        cform.elements["price_expr"+num].value = pricesExprs[priceIndex];
        pricesBackup[priceIndex] = cform.elements["price"+num].value;
        calcFields(0);
    } else {
        cform.elements["price"+num].disabled = false;
        cform.elements["price_expr"+num].value = "";
        tmp = cform.elements["price"+num].value;
        if(pricesBackup[priceIndex] != "") {
            cform.elements["price"+num].value = pricesBackup[priceIndex];
        }
        pricesBackup[priceIndex] = tmp;
    }
    checkField(num);
    return true;
}

function InitFormCustom() {
    for(var i=0;i<colNum;i++) {
        pricesBackup[i] = "";
    }
    return true;
}
calcFields(0);
</script>
"-->

##--
<!--#set var="other_price_caption" value="
<td width="110" align="center"><small>##price_caption##</small></td>
"-->

<!--#set var="other_price_expression" value="
<td align="right">
  <input type=text name="price_expr##num_price##" value="##price_expr##" class="field field15" maxlength="30"  disabled>
</td>
"-->
--##

<!--#set var="variable_price" value="
<tr id="tr_variable_price" style="display:none">
    <td>&nbsp;</td>
    <td><input type=checkbox name=variable_price value="1" ##variable_price## id="id_variable_price" style="margin-left:-3px"><label for="id_variable_price"> %%variable_price%%</label></td>
</tr>
</div>
<script>
    onChangeVariablePrice();
</script>
"-->

<!--#set var="currency_name" value=" ##name##"-->

<!--#set var="currency_hidden" value="<input type="hidden" name="currency##num_price##" value="##currency##">"-->

<!--#set var="other_price_item" value="
<tr>
 <td style="padding-left:18px">##price_caption##</td>
 <td>
  <input type=text name="price##num_price##" value="##price_value##" class="field field15" maxlength="30" style1="width: 90px"  ##text_disabled##>
 </td>
 <td>
  <input type="checkbox" name="price_checkbox##num_price##" ##checkbox_value## value="1" ##checkbox_disabled##>
 </td>
 <td>
  <input type=text name="price_expr##num_price##" value="##price_expr##" class="field field15" maxlength="30"  disabled>##currency_name##
  ##currency_hidden##
 </td>
</tr>
"-->

<!--#set var="other_prices" value="
<tr>
 <td colspan="4"><b>%%other_prices%%:</b></td>
</tr>
<tr>
  <td nowrap style="padding-left:18px;"><b>%%caption%%</b></td>
  <td nowrap><b>%%fixed_price%%</b></td>
  <td nowrap colspan=2><b>%%use_formula%%</b></td>
</tr>
 ##price_items##
"-->

<!--#set var="shipping_module_addon" value="
<tr>
    <td vAlign="top">%%shipping_type%%:</td>
    <td colSpan="3">
        <table border="0" class="noSpace">
        <tr><td>##shipping_type_ctrl##</td></tr>
        <tr><td><input type="button" class="but-long" onClick="javascript:openShippingTypesPopup(this.form)" value="%%button_edit_fields%%" /></td></tr>
        </table>
    </td>
</tr>
"-->

<!--#set var="list_ctrl_hidden_field" value="
<input type="hidden" name="##ctrl_field_name##_source" value="##ctrl_field_value##" disabled />
<input type="hidden" name="##ctrl_field_name##" id="##ctrl_field_name##" value="##ctrl_field_value##" onChange="FormChanged(event);" disabled />
"-->

<!--#set var="list_ctrl_row_single" value="
<input type="text" name="##ctrl_field_name_single##" value="##ctrl_field_value_single##" class="field field30"  disabled />
"-->

<!--#set var="list_ctrl_row" value="
<option value="##id##"##selected##>##name##</option>
"-->

<!--#set var="list_ctrl_shipping_type_list" value="
<select name="##ctrl_field_name_select##" onChange="javascript:this.form.##ctrl_field_name##.value = this.value;FormChanged(event);">
<option value="0">%%shipping_type_not_selected%%</option>
##list##
</select>
<a href="javascript:void(0);" onClick="javascript:DisableRefSelect('##ctrl_field_name_select##');openDialog('%%shipping_type_popup_title%%', '##shipping_types_link##?popup=1&item_id='+document.eshop_form.##ctrl_field_name##.value);return false;"><img id="img_shipping_type" title="%%button_select%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" align="absmiddle" class=icon /></a>
"-->

 <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="eshop_form" onSubmit="return CheckForm(window.document.eshop_form);">
     ##form_common_hidden_fields##
     <input type="hidden" name="del_common_pics" value="0">
     <input type="hidden" name="cid" value="##cid##">
##--     <input type="hidden" name="public" value="##public##">--##
     <input type="hidden" name="special" value="">
     <input type="hidden" name="publish" value="">
     <input type="hidden" name="file_ids" value="">
     <input type="hidden" name="from_backend" value="" />
##filter_hidden_fields##
##custom_fields_hiddens##
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">

##if(!is_item_link)##

     <tr>
       <td colspan="2">
         <input type="checkbox" name="public" id="chk_public" ##public## value="1">
         <label for="chk_public">%%public%%</label>
       </td>
     </tr>
     ##if(ESHOP_ALLOW_FRACTION != "")##
     <tr>
       <td colspan="2">
         <label><input type=checkbox name=allow_fraction ##allow_fraction## value="1"> %%allow_fraction%%</label>
       </td>
     </tr>
     ##endif##
     <tr>
       <td>%%eshop_special_form%%:</td>
       <td>
         <input type="checkbox" name="on_special[0]" id="on_special[0]" ##on_special## value="1">&nbsp;<label for="on_special[0]">%%on_special%%</label>&nbsp;&nbsp;&nbsp;##special_flag_list_1##
       </td>
     </tr>

     <tr>
       <td>
%%category%%*:
      </td>
       <td>
         <input type="hidden" id="__id_cat" value="##cat_id##">
         <select name="cat" id="formCategoryId">
         ##parent##
         </select>
         ##if(ITEM_LINKS_ALLOWED)##
         <input type="hidden" name="item_links" value="##item_links_list##">&nbsp;&nbsp;&nbsp;
         <a href="javascript:void(0)" onClick="openDialog('%%select_links_categories%%', 'eshop_item.php?action=links_popup&id=##id##', 600, 800); return false;"><span id="idItemLinksHas" style="display:##if(item_links_list != '')##inline##else##none##endif##">%%item_links_has%% <span id="idItemLinksNum">##item_links_num##</span> %%item_links_has_end%%</span><span id="idItemLinksNone" style="display:##if(item_links_list == '')##inline##else##none##endif##">%%item_links_noone%%</span></a>
         ##endif##
       </td>
     </tr>
##item_type_list##
##--eshop_goods_fields--##
##eshop_digitals_fields##
    <tr>
       <td>
%%create_subcategory%%:
      </td>
       <td>
         <input type=text name=catname class="field field40" maxlength="255" >
       </td>
     </tr>
     <tr>
       <td width="80">
%%date%%:
</td>
       <td>
         <input type=text name=date class='field fieldDate' value="##fdate##" maxlength="30" helpId= "form_date" />
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.eshop_form.date);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId= "clnd_date"/></a>
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

     ##adv_place_fields##

     ##if(showPriceLoc == 1)##
     <tr>
       <td>
%%price%%:
</td>
       <td>
         <input type=text name=price class="field field20" value="##price##" >
       </td>
     </tr>
     ##variable_price##
     ##endif##
     ##if(showOtherPricesLoc == 1)##
     <tr>
       <td colspan=2>
            <table border=0 cellspacing=0 cellpadding=5>
            ##other_prices##
            </table>
        </td>
     </tr>
     ##endif##

     <tr>
       <td>
%%sku%%:
</td>
       <td>
         <input type=text name=sku class="field field45" value="##sku##" maxlength="64">
       </td>
     </tr>

     ##if(showTaxesLoc == 1)##
     <tr id="specTr1" name="eshop_goods_fields" ##eshop_goods_disabled##>
       <td>
        %%shipping%%:
       </td>
       <td colspan=3>
         <input type=text name=shipping class="field field20" value="##shipping##" >
         &nbsp;
         ##shipping_type##
       </td>
     </tr>

     <script type="text/javascript">
       makeElementVisible(document.getElementById('specTr1'), '##eshop_goods_display##');
     </script>


##products_discounts##
     <tr>
       <td>
        %%discount%%:
       </td>
       <td colspan=3>
         <input type=text name=discount class="field field20" value="##discount##" >
         &nbsp;
         ##discount_type##
       </td>
     </tr>
##taxes_module_addon##
##shipping_module_addon##
     ##endif##

     ##if(pictures_top && ext_images)##
     ##ext_images##
     ##endif##

     ##if(showNWRS == 1)##
     <tr>
       <td>
%%max_quantity%%:
</td>
       <td valign="top">
         <div name="eshop_goods_fields" style="display: ##eshop_goods_display##;" ##eshop_goods_disabled##><input type=text name=eshop_goods_quantity class="field field30" value="##eshop_goods_quantity##" ></div>
         <div name="eshop_digitals_fields" style="display: ##eshop_digitals_display##;" ##eshop_digitals_disabled##><input type=text name=eshop_digitals_quantity class="field field30" value="##eshop_digitals_quantity##" ></div>
         <div name="eshop_account_fields" style="display: ##eshop_account_display##;" ##eshop_account_disabled##><input type=text name=eshop_account_quantity class="field field30" value="##eshop_account_quantity##" ></div>
       </td>
     </tr>
     <tr>
       <td>
         %%weight%%:
       </td>
       <td>
         <input type=text name=weight class="field field30" value="##weight##" >
       </td>
     </tr>
     <tr>
       <td>
         %%size%%:
       </td>
       <td>
         <input type=text name=size class="field field30" value="##size##" maxlength="100">
       </td>
     </tr>
     ##endif##

     ##if(hasPropertyFields && showNWRS == 1)##
     <tr>
       <td>
         %%property_fields_title%%:
       </td>
       <td>
         [%%rest_total%%:<input name="rest" type="text" value="##rest##" readonly style="width: 30px;text-align: right; background-color: #F4F4F4;BORDER: #FFFFFF 0px solid; ">]
         <input type=button value="%%edit_btn%%" class=but onClick="openExtDialog('%%eshop_property_edit%%', '##CURRENT_OWNER##_item_props.php?itemId=##prop_id##&catId=##cat_id##', 1); return false;">
       </td>
     </tr>
     ##elseif(showNWRS == 1)##
     <tr>
       <td>
         %%rest%%:
       </td>
       <td>
         <input type=text name=rest class="field field30" value="##rest##" >
       </td>
     </tr>
     ##endif##

     ##if(!empty(custom_fields_top))##
     ##endif##
     ##custom_fields_top##
     ##special_flag_list_2##
##if(EXT_RELATIONS)##
%%include_language "templates/lang/ext_relations.lng"%%
<tr>
    <td>%%relations%%:</td>
    <td>
        <a href="javascript:void(0);" onClick="##if(id)##openExtDialog('%%relations_list%%', 'relations.php?popup=1&objectId=##id##&objectModule=##module##', 1);##else##alert('%%warn_apply_item%%');##endif##return false;"><img title="%%relations_edit_list%%" class="icon" src="skins/vanilla/icons/icon-dicget-many.gif" helpId="btn_relations" align="absmiddle" /></a> <font style="font-size:9px">[%%relations_number%%:<input name="relations_number" type="text" value="##relations_number##" readonly class="counter">]</font>
    </td>
</tr>
##endif##
    </table>
    <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">


        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-announce">
              <textarea class="field" style="width:100%" rows="14" name="announce" id="announce">##announce##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('announce', cmD_STB, true);}
              </script>
            </div>

            <div class="tab-page" id="tab-page-special_announce">
              <textarea class="field" style="width:100%" rows="14" name=special_announce id="special_announce">##special_announce##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('special_announce', cmD_STB , false);}
              </script>
            </div>

            <div class="tab-page" id="tab-page-description">
              <textarea class="field" style="width:100%" rows="14" name="description" id="description">##description##</textarea>
              <script type="text/javascript">
              if(editor_enable){ editor_generate('description', cmD_STB, false); }
              </script>
            </div>


         ##IF(!hasPriceTabs)##<!--##endif##
            <div class="tab-page" id="tab-page-prices">
           <table cellspacing="0" cellpadding="0" border="0" width="100%" height="298">
             ##if(showPriceLoc == 3)##
             <tr>
               <td>
        %%price%%:
        </td>
               <td colspan=3>
                 <input type=text name=price class="field field20" value="##price##" >
               </td>
             </tr>
             ##variable_price##
             ##endif##
             ##if(showOtherPricesLoc == 3)##
             ##other_prices##
             ##endif##
             ##if(showTaxesLoc == 3)##
             <tr id="specTr2" name="eshop_goods_fields" ##eshop_goods_disabled##>
               <td>
                %%shipping%%:
               </td>
               <td colspan=3>
                 <input type=text name=shipping class="field field20" value="##shipping##" >
                 &nbsp;
                 ##shipping_type##
               </td>
             </tr>
##products_discounts##
             <tr>
               <td>
                %%discount%%:
               </td>
               <td colspan=3>
                 <input type=text name=discount class="field field20" value="##discount##" >
                 &nbsp;
                 ##discount_type##
               </td>
             </tr>
##taxes_module_addon##
##shipping_module_addon##
             ##endif##
           </table>
           <script type="text/javascript">
               makeElementVisible(document.getElementById('specTr2'), '##eshop_goods_display##');
           </script>
         </div>
         ##IF(!hasPriceTabs)##-->##endif##
             ##IF(hasPicturesTabs)##
            <div class="tab-page" id="tab-page-pictures">
              <table>
                 ##ext_images##
              </table>
             </div>
            ##endif##

            ##IF(EXT_ESHOP_CUSTOM_FIELDS == "1" && hasCustomFieldsTabs)##
            <div class="tab-page" id="tab-page-custom-fields">
               <table cellspacing="5" cellpadding="0" border="0">
                 ##special_flag_list_3##
                 <tr>
                   <td colspan=2><b>%%dataset_name%%: ##dataset_name##</b></td>
                 </tr>
                 ##custom_fields##
               </table>
            </div>
            ##endif##

            <div class="tab-page" id="tab-page-options">
               ##options_form##

               ##if(EXTENSION_RATING=="1")##

                  %%include_language "templates/lang/rating.lng"%%


                  <script type="text/javascript">

                  makeElementVisible(document.getElementById('specTr1'), '##eshop_goods_display##');
                  makeElementVisible(document.getElementById('specTr2'), '##eshop_goods_display##');
                  makeElementVisible(document.getElementById('specTr3'), '##eshop_goods_display##');

                  function OnObjectChanged_rating(name, first_change) {
                      if (name == "allow_ratings") {
                          document.getElementById('display_ratings').checked = document.getElementById(name).checked;
                          document.getElementById('display_ratings').disabled = !document.getElementById(name).checked;
                          document.getElementById('sort_by_ratings').checked = document.getElementById(name).checked;
                          document.getElementById('sort_by_ratings').disabled = !document.getElementById(name).checked;
                          document.getElementById('display_votes').checked = document.getElementById(name).checked;
                          document.getElementById('display_votes').disabled = !document.getElementById(name).checked;
                      }
                      return true;
                  }
                  addFormChangedHandler(OnObjectChanged_rating);

                  function changeFieldsStatus(newStatus){

                     errFunc = changeFieldsStatus;

                     document.getElementById('votes_count').disabled = newStatus;
                     document.getElementById('votes_rate').disabled = newStatus;

                     document.getElementById('rewrite_ratings').value = !newStatus;

                  }


                  function checkInteger(theID){

                     errFunc = checkInteger;

                     theVal = document.getElementById(theID).value;

                      for (i = 0; i < theVal.length; i++)
                      {
                          var c = theVal.charAt(i);
                          if (((c < "0") || (c > "9"))) {
                       alert('%%integer_warn%%');
                       document.getElementById(theID).focus();
                       return false;
                      }
                      }

                      return true;
                  }


                  // checks for the number between 1.0000 and 5.0000

                  function checkRating(theID){

                     errFunc = checkRating;

                     theVal = parseFloat(document.getElementById(theID).value);

                          if ( theVal < 1.00000 || theVal > 5.00000 || !theVal  ) {
                       alert('%%rating_warn%%');
                       document.getElementById(theID).focus();
                       return false;
                      }
                      document.getElementById(theID).value = theVal;
                      return true;
                  }


                  </script>

                  <table width=100% height="">

                      <tr>
                          <td colspan=6 height=10>&nbsp;</td>
                      </tr>

                  <tr>
                      <td width=40 align="right">
                        <input type="checkbox" id="rewrite" onClick="changeFieldsStatus(!this.checked);">
                        <input type="hidden" name="rewrite_ratings" id="rewrite_ratings" value="false">
                          </td>

                          <td>
                           <label for="rewrite"><nobr>%%rewrite_ratings%%</nobr></label>
                          </td>

                          <td align="right">
                            %%votes_count%%:
                      </td>
                          <td>
                       <input type="text" name="votes_count" id="votes_count" class="field field6"
                       value="##votes_count##" disabled onBlur="checkInteger(this.id);">
                          </td>

                          <td align="right">
                           %%votes_rate%%:
                      </td>
                          <td>
                       <input type="text" name="votes_rate" id="votes_rate" class="field field6"
                       value="##votes_rate##" disabled  onBlur="checkRating(this.id);">
                          </td>

                      </tr>

                      <tr>
                          <td colspan=6 height=10>&nbsp;</td>
                      </tr>

                      <tr>

                      <td width=40 align="right">
                        <input type="checkbox" name="allow_ratings" id="allow_ratings" ##allow_ratings##>
                          </td>
                      <td>
                           <label for="allow_ratings">%%allow_ratings%%</label>
                      </td>

                      <td align="right">
                        <input type="checkbox" name="display_ratings" id="display_ratings" ##display_ratings##>
                          </td>
                      <td>
                           <label for="display_ratings">%%display_ratings%%</label>
                      </td>
                          <td colspan=2> </td>
                     </tr>

                     <tr>

                      <td width=40 align="right">
                        <input type="checkbox" name="sort_by_ratings" id="sort_by_ratings" ##sort_by_ratings##>
                          </td>
                      <td>
                           <label for="sort_by_ratings">%%sort_by_ratings%%</label>
                      </td>

                      <td align="right">
                        <input type="checkbox" name="display_votes" id="display_votes" ##display_votes##>
                          </td>
                      <td>
                           <label for="display_votes">%%display_votes%%</label>
                      </td>
                          <td colspan=2> </td>
                     </tr>

                      <tr>
                          <td colspan=6 height=10>&nbsp;</td>
                      </tr>

                  </table>
               ##endif##

            </div>

            ##if(EXT_AUDIT=="1")##
            <div class="tab-page" id="tab-page-audit">
              ##audit_form##
            </div>
            ##endif##

          </div>
        </div>

        <script type="text/javascript">
          window.baseTabs = new cTabs('tab-control', {
              'announce' : ['%%announce%%', 'active', '', false],
              'special_announce' : ['%%special_announce%%', 'normal', '', false],
              'description' : ['%%description%%', 'normal', '', false],
        ##IF(hasPriceTabs)##
              'prices' : ['%%tab_prices%%', 'normal', '', false],
        ##endif##
        ##IF(hasPicturesTabs)##
              'pictures' : ['%%tab_pictures%%', 'normal', '', false],
        ##endif##
        ##IF(EXT_ESHOP_CUSTOM_FIELDS == "1" && hasCustomFieldsTabs)##
              'custom-fields' : ['%%tab_custom_fields%%', 'normal', '', false],
        ##endif##
              'options' : ['%%tab_options%%', 'normal', '', false],
        ##if(EXT_AUDIT=="1")##
              'audit' : ['%%tab_audit%%', 'normal', '', false],
        ##endif##
          '':''});

        </script>


        </td>
     </tr>
     </table>
    <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
      ##special_flag_list_4##
     ##if(showPriceLoc == 2)##
     <tr>
       <td colspan=2><br></td>
     </tr>
     <tr>
       <td>
%%price%%:
</td>
       <td>
         <input type=text name=price class="field field20" value="##price##" >
       </td>
     </tr>
     ##variable_price##
     ##endif##
     ##if(showPriceLoc != 2 && showOtherPricesLoc == 2)##
     <tr>
       <td colspan=2><br></td>
     </tr>
     ##endif##
     ##if(showOtherPricesLoc == 2)##
     <tr>
        <td colspan=2>
            <table border=0 cellspacing=0 cellpadding=5>
            ##other_prices##
            </table>
        </td>
     </tr>
     ##endif##

     ##if(showTaxesLoc == 2)##
     <tr id="specTr3" name="eshop_goods_fields" style="display: ##eshop_goods_display##;" ##eshop_goods_disabled##>
       <td>
        %%shipping%%:
       </td>
       <td colspan=3>
         <input type=text name=shipping class="field field20" value="##shipping##" >
         &nbsp;
         ##shipping_type##
       </td>
     </tr>
     <script type="text/javascript">
       makeElementVisible(document.getElementById('specTr3'), '##eshop_goods_display##');
     </script>
##products_discounts##
     <tr>
       <td>
        %%discount%%:
       </td>
       <td colspan=3>
         <input type=text name=discount class="field field20" value="##discount##" >
         &nbsp;
         ##discount_type##
       </td>
     </tr>
##taxes_module_addon##
##shipping_module_addon##
     ##endif##

     ##if(pictures_bottom)##
     <tr>
       <td colspan=2><br></td>
     </tr>
     ##ext_images##
     ##endif##

     ##if(showNWRS == 2)##
     <tr>
       <td colspan=2><br></td>
     </tr>

     <tr>
       <td>
%%max_quantity%%:
</td>
       <td valign="top">
         <div name="eshop_goods_fields" style="display: ##eshop_goods_display##;" ##eshop_goods_disabled##><input type=text name=eshop_goods_quantity class="field field30" value="##eshop_goods_quantity##" ></div>
         <div name="eshop_digitals_fields" style="display: ##eshop_digitals_display##;" ##eshop_digitals_disabled##><input type=text name=eshop_digitals_quantity class="field field30" value="##eshop_digitals_quantity##" ></div>
         <div name="eshop_account_fields" style="display: ##eshop_account_display##;" ##eshop_account_disabled##><input type=text name=eshop_account_quantity class="field field30" value="##eshop_account_quantity##" ></div>
       </td>
     </tr>
     <tr>
       <td>
         %%weight%%:
       </td>
       <td>
         <input type=text name=weight class="field field30" value="##weight##" >
       </td>
     </tr>
     <tr>
       <td>
         %%size%%:
       </td>
       <td>
         <input type=text name=size class="field field30" value="##size##" maxlength="100">
       </td>
     </tr>
     ##endif##

     ##if(hasPropertyFields && showNWRS == 2)##
     <tr>
       <td>
         %%property_fields_title%%:
       </td>
       <td>
         [%%rest_total%%:<input name="rest" type="text" value="##rest##" readonly style="width: 30px;text-align: right; background-color: #F4F4F4;BORDER: #FFFFFF 0px solid; ">]
         <input type=button value="%%edit_btn%%" class=but onClick="openExtDialog('%%eshop_property_edit%%', '##CURRENT_OWNER##_item_props.php?itemId=##prop_id##&catId=##cat_id##', 1); return false;">
       </td>
     </tr>
     ##elseif(showNWRS == 2)##
     <tr>
       <td>
         %%rest%%:
       </td>
       <td>
         <input type=text name=rest class="field field30" value="##rest##" >
       </td>
     </tr>
     ##endif##

     ##custom_fields_bottom##

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
     <input id="_async_marker" type="hidden" />
    </form>
##other_prices_script##
<script>
oldSelectIndex = document.forms[_cms_document_form].elements["cat"].selectedIndex;
if(typeof(document.forms[_cms_document_form].elements["item_type"]) != "undefined") {
  oldItemTypeIndex = document.forms[_cms_document_form].elements["item_type"].selectedIndex;
}
</script>

##else##

     <tr>
       <td colspan="2">
        %%item_is_link_of%% <nobr><a href="javascript:void(0);" onClick="user_click('edit','##id_source##');return false;" title="%%edit_item_source%%">##item_link_path####source_name##</a></nobr><br>&nbsp;
       </td>
     </tr>
     <tr>
       <td>
        %%sublink%%:
       </td>
       <td>
         <input type=text name=sublink class="field field56" value="##sublink##" maxlength="128">
         <input type=hidden name=original_sublink collect_link_ignore=1 value="##sublink##">
       </td>
     </tr>

     <tr>
        <td colspan="2" align="right">
        <br>
          ##form_buttons##
        <br><br>
        </td>
     </tr>
     </table>
     <input id="_async_marker" type="hidden" />
     </form>

     <script type="text/javascript">
        document.forms.eshop_form.onsubmit = function(){return true;}
     </script>
##endif##