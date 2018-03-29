<!--#set var="special_flag_splitter" value="<br>"-->
<!--#set var="special_flag_row" value="
<input type="checkbox" name="on_special[##num##]" ##on_special## value="##value##">##caption##
"-->
<!--#set var="special_flag_list" value="
##if(special_flag_list != "")##
<tr>
  <td colspan="2">##special_flag_list##</td>
</tr>
##endif##
"-->

<!--#set var="site_select_row" value="
            <option ##active## value="##id##">##name##</option>
"-->

<!--#set var="site_select_body" value="
         <select name="id_site" ##multi_sites_select_disabled##>
           <option value="0">%%all_sites%%</option>
           ##rows##
         </select>
"-->

<!--#set var="del_popup_form" value="
<form name="delForm" action="##script_link##" enctype="multipart/form-data" method="POST">
<table cellspacing="0" cellpadding="10" align="center" width=100%>
  <tr>
   <td align="center">
    <table cellspacing="0" cellpadding="0" align="center">
     <tr>
      <td><input type="radio" name="type" value="move" checked id="type_move" />&nbsp;<label for="type_move">%%del_move_other%%</label>
         <div align="right">
         <select name="id_parent">
         ##cat_select##
         </div>
         </span>
      </td>
     </tr>
     <tr>
      <td><input type="radio" name="type" value="del" id="type_del" />&nbsp;<label for="type_del">%%del_with_items%%</label></td>
     </tr>
    </table>
   </td>
  </tr>
  <tr>
    <td align="center">
        <input type="hidden" name="action" value="delete_confirm">
        <input type="button" name="add" value="  %%ok_btn%%  " class="but" onClick="return onBtnOk();">&nbsp;
        <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="closeDialogWindow();">
    </td>
   </tr>
</table>
"-->


<!--#set var="del_popup" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>%%site_title%% - %%eshop_delete_form%%</TITLE>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css">
<script type="text/javascript">
<!--

function onBtnOk() {

  for(var i=0;i<document.delForm.type.length;i++) {
    if(document.delForm.type[i].checked) {
      top.document.forms['eshop_form'].type.value = document.forms['delForm'].type[i].value;
      break;
    }
  }
  top.document.forms['eshop_form'].id_parent.value = document.forms['delForm'].id_parent.value;
  top.user_click('del_confirm','##id##');
  closeDialogWindow();
  return true;
}
-->
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
         <table><tr>
          ##flag_map##
         </tr></table>
         ##endif##
       </td>
     </tr>
"-->
<!--#set var="custom_field_flag" value="
     <td><nobr><input type=checkbox name=##custom_name## value="1" ##if(custom_value == "1")##checked##endif## id=label_##custom_name##> <label for=label_##custom_name##>##custom_title##</label></nobr></td>
"-->
<!--#set var="custom_field_flagsplit" value="
    </tr><tr>
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
           <input type=text name=##custom_name## class="field field15" value="##custom_value##" maxlength="255">
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

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'eshop_form';
var _cms_script_link = '##script_link##?';

##pictures_js_vars##

var pageIsLast='##page_is_last##';

function changeCategory(id) {
  var sform = document.forms[_cms_document_form];
  var link = _cms_script_link;

  sform.action.value = '';
  document.location = link + collect_link(sform) + "&cat_id=" + id;
  return false;
}

function CheckForm(form) {
   var errmsg = "";
   var numPrice;

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   if(!checkUrl(form.sublink.value)) {
       form.sublink.focus();
       return false;
   }

   if (form.price.value !="" && isNaN(form.price.value*1)) {
       errmsg+='%%price_warn%%';
       setTabFocus(form, "price");
       alert(errmsg);
       setTabFocus(form, "price");
       return false;
   }

   for(var i=0;i<numPrices;i++) {
        numPrice = pricesFields[i];
        if(typeof(form.elements["price_current"+numPrice]) != "undefined") {
            if(form.elements["price_current"+numPrice].value !="" && isNaN(form.elements["price_current"+numPrice].value*1)) {
               errmsg+='%%price_value_warn%%';
               setTabFocus(form, "price"+numPrice);
               alert(errmsg);
               setTabFocus(form, "price"+numPrice);
               return false;
            }
        }
   }

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

    if (typeof(form.id_discount) != 'undefined') {
        form.id_discount.disabled = (form.id_discount.value == form.id_discount_source.value);
    }
    if (typeof(form.id_shipping_type) != 'undefined') {
        form.id_shipping_type.disabled = (form.id_shipping_type.value == form.id_shipping_type_source.value);
    }

    if (!(typeof(form.id_tax_class) == 'undefined')) {
       form.id_tax_class.disabled = (form.id_tax_class.value == form.id_tax_class_source.value);
    }

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

   editor_updateHiddenField("announce");
##if(INSTRUCTIONS_ON=="1")##
   editor_updateHiddenField("instruction");
##endif##
   editor_updateHiddenField("description");

   return true;
}

function setTabFocus(form, fName) {
    baseTabs.showTab("prices");
    form.elements[fName].focus();
}

function OnObjectChanged_eshop_cat_form_def(name, first_change, evt){
    if(name.indexOf("price") == 0 && name.indexOf("price_cap") == -1) {
        elemNum = name.substr(5, 2);
        calcField(document.eshop_form, elemNum);
    }

    if(name.indexOf("currency") == 0) {
        elemNum = name.substr(8, 2);
        calcField(document.eshop_form, elemNum);
    }
    ##pictures_js_script##

    return true;
}
addFormChangedHandler(OnObjectChanged_eshop_cat_form_def);

function OnObjectKeyUp(oElement) {
  OnObjectChanged_eshop_cat_form_def(oElement.name, false);
  return true;
}

var oldParentCatSelectIndex;
var oldDatasetSelectIndex;

function datasetChanged() {
    cform = document.forms[_cms_document_form];

    if(typeof(cform) != 'object'){
        return false;
    }

    if(confirm('%%change_cat_warning%%')){

        var
            anchor = '#anchor', tail = '',
            parent_val = cform.parent.value,
            dataset_val = cform.dataset.value,
            isPartialAsync = (typeof(module60compatible) != 'undefined') && module60compatible;

        if(isPartialAsync){
            AMI.Page.addHashData(
                '##module##',
                {
                    cat_id:   parent_val,
                    dataset:  dataset_val
                }
            );
            anchor = document.location.hash;
        }

        if(cform.elements['action'].value != 'apply'){
            cform.elements['action'].value = '';
            document.location = _cms_script_link + collect_link(cform, false, anchor, '&parent=' + parent_val + '&dataset=' + dataset_val);
        }else{
            cform.elements['action'].value = 'edit';
            id = cform.elements['id'].value;
            document.location = _cms_script_link + collect_link(cform, false, anchor, '&id_parent=' + parent_val + '&dataset=' + dataset_val + '&id=' + id);
        }
    }else{
      cform.parent.selectedIndex = oldParentCatSelectIndex;
      cform.dataset.selectedIndex = oldDatasetSelectIndex;
    }
}

var numPrices = ##num_prices##
##prices_vars##
var pricesFields = Array(##prices_fields##);
var curRates = {'cur__00':1##currency_vars##};
var fieldNum;
var editFieldNum;
var errorsOn = true;
var onlyCheck;
var eshopCurrIndex=0;
var numDecimalDigit = ##num_decimal_digit##;
window.onerror = errorHandler;

function errorHandler(msg, url, lno) {
    res = false;
    if(!errorsOn) {
        document.eshop_form.elements["price_current"+fieldNum].value = "%%wrong_expression%%";
        if(!onlyCheck) {
            eval("price"+fieldNum+"=\'a\';");
        }
        errorsOn = true;
        res = true;
//alert("time");
        if(eshopCurrIndex > 0) {
            eshopCurrIndex++;
            window.setTimeout("calcField(document.eshop_form, editFieldNum);", 100);
        }
    }
    //event.returnValue = res;
    return res;
}

function calcField(form, num) {
    var numPrice;
    if(num) {
        if(eshopCurrIndex==0) {
            eshopCurrIndex=1;
            editFieldNum=num;
            _calcField(form, num);
        }
    }

    // when we have only one "additional price"
    // the ephopCurrIndex == 2 set at the preview call of _calcField
    // since that all logic in loop dose not works (cuz loop did not started),
    // so we have to add this "if"
    if(2 == eshopCurrIndex && 1 == numPrices){
        eshopCurrIndex = 0;
    }else{
        for(var i=eshopCurrIndex; i<=numPrices; i++){
            eshopCurrIndex = i;
            if(eshopCurrIndex == numPrices){
                eshopCurrIndex = 0;
            }
            numPrice = pricesFields[i-1];
            if(numPrice !=num ){
                _calcField(form, numPrice);
            }
        }
    }
    onlyCheck = false;
}

var calculatedPrices = new Array();
function _calcField(form, num) {
    res = true;
    if(typeof(form.elements["price_caption"+num]) != "undefined") {
        fieldNum = num;
        expr = form.elements["price"+num].value;
        tmp = form.elements["price"].value;
        price = tmp.replace(/^\+| /g, "").replace(/,/, ".");

        expr2=expr.replace(/^\+| /g, "").replace(/,/, ".");
        expr2Str = '' + parseFloat(expr2);
        form.elements["db_currency"+num].disabled = (expr2.length != 0 && expr2.length != expr2Str.length);

        if(!isNaN(price*1)) {
            price=parseFloat(price);
            if(isNaN(expr2*1)) {
                for(var i = 1; i < calculatedPrices.length; i++){
                    if(calculatedPrices[i]){
                        eval('price'+i+'='+calculatedPrices[i]);
                    }
                }
                errorsOn = false;
                if(typeof(form.elements["currency"+num]) == "object") {
                  expr2 = "("+expr2+")*curRates['cur_"+form.elements["currency"+num].value+"']";
                }
                tmp = eval(expr2);
                if(!isNaN(tmp) && isFinite(tmp)) {
                    form.elements["price_current"+num].value = extRound(tmp, numDecimalDigit);
                    calculatedPrices[num] = form.elements["price_current"+num].value;
                } else {
                    form.elements["price_current"+num].value = "%%wrong_expression%%";
                    calculatedPrices[num] = NaN;
                    res = false;
                }
                if(!onlyCheck) {
                    eval("price"+num+"=NaN;");
                }
            } else {
                if(expr2.length > 0 && !isNaN(expr2*1)) {
                    eval("price"+num+"=parseFloat('"+expr2+"');");
                    if(typeof(form.elements["currency"+num]) == "object") {
                      eval("expr2= ("+expr2+")*curRates['cur_"+form.elements["currency"+num].value+"'];");
                    }
                    form.elements["price_current"+num].value = extRound(expr2, numDecimalDigit);
                    calculatedPrices[num] = form.elements["price_current"+num].value;
                } else {
                    if(expr2.length > 0) {
                        form.elements["price_current"+num].value = "%%wrong_expression%%";
                        res = false;
    //                    if(!onlyCheck) {
                            eval("price"+num+"=\'a\';");
    //                    }
                        calculatedPrices[num] = NaN;
                    } else {
                        form.elements["price_current"+num].value = "";
                        eval("price"+num+"=0.0;");
                        calculatedPrices[num] = 0;
                    }
                }
            }
        }
    }
//    alert(expr);
    return res;
}

function parentCatChanged(onLoading){
    var catDS = new Array();
    ##cat_datasets##
    if(document.eshop_form.parent){
        for(i = 0; i < catDS.length; i++){
            if(catDS[i][0] == document.eshop_form.parent.value){
                if(document.eshop_form.dataset){
                    var oldDataset = document.eshop_form.dataset.selectedIndex;

                    document.eshop_form.dataset.value=catDS[i][1];

                    if(onLoading == 1){
                        oldParentCatSelectIndex = document.eshop_form.parent.selectedIndex;
                        oldDatasetSelectIndex = document.eshop_form.dataset.selectedIndex;
                    }else{
                        if(oldDataset != document.eshop_form.dataset.selectedIndex){
                            datasetChanged();
                        }else{
                            oldParentCatSelectIndex = document.eshop_form.parent.selectedIndex;
                        }
                    }
                }
                break;
            }
        }
    }
}

function openDiscountsPopup(form)
{
    var tail = form.id_discount.value > 0 ? '&id=' + form.id_discount.value + '&action=edit' : '';
    openDialog('%%discount_popup_title%%', '##discounts_link##?popup=1&flt_condition=category&flt_apply=1' + tail);
}

function openShippingTypesPopup(form)
{
    var tail = form.id_shipping_type.value > 0 ? '&id=' + form.id_shipping_type.value + '&action=edit' : '';
    openDialog('%%shipping_type_popup_title%%', '##shipping_types_link##?popup=1' + tail);
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
-->
</script>

<!--#set var="dataset_js" value="catDS[##id##] = new Array('##cat_id##', '##dataset_id##');
"-->

<!--#set var="price_caption" value="
<tr>
 <td>
 %%price_caption%% ##price_number##:
 </td>
 <td>
<input type=text name=price_caption##price_number## class="field field50" value="##price_caption##" maxlength="255">
 </td>
 </tr>
"-->

<!--#set var="price_value_field" value="
<tr>
 <td>
 %%price_value%% ##price_number## [price##price_number##]:
 </td>
 <td>
<input type=text name=price##price_number## class="field field30" value="##price_value##" >
##--<input type=checkbox name=price_checkbox##price_number## value="1" ##price_checkbox_checked##>--##
<b>=</b><input type=text name=price_current##price_number## class="field field12" value="##price_current##" readonly tabindex="-1">
</td>
 <td>
##db_currency_select##
 </td>
 <td>
##currency_select##
 </td>
 </tr>
"-->

<!--#set var="price_value_field_list" value="
<tr>
  <td colspan="2">
    <table cellspacing="0" cellpadding="0" border="0">
      <tr>
        <td colspan=2>&nbsp;</td>
        <td colspan=2 align="center">%%currency%%</td>
      </tr>
      <tr>
        <td colspan=2>&nbsp;</td>
        <td align="center">%%currency_db%%</td>
        <td align="center">%%currency_site%%</td>
      </tr>
      ##price_field##
    </table>
  </td>
</tr>
<tr>
  <td colSpan="2">
    <div class="tooltip">%%prices_help%%</div>
  </td>
</tr>
"-->

<!--#set var="update_checkboxes" value="
<tr>
    <td></td>
 <td style="font-size:10px"><br>
<input type=checkbox name=update_all value="1">%%update_all%%
 </td>
 </tr>
<tr>
    <td></td>
 <td style="font-size:10px">
<input type=checkbox name=update_force value="1">%%update_force%%
 </td>
 </tr>
"-->

<!--#set var="parent_selectbox" value="
     <tr>
       <td>
%%parentname%%*:
</td>
       <td>
         <select name="parent" id="parent_id_category" onChange="parentCatChanged(0)">
         ##parent##
         </select>
       </td>
     </tr>
"-->

<!--#set var="parent_noselectbox" value="
     <tr>
       <td>
%%parentname%%*:
</td>
       <td>%%root_catname%%<input type="hidden" name="parent" value="##parent##">
       </td>
     </tr>
"-->

<!--#set var="price_list_checkbox" value="
<tr>
  <td colspan="2">
    <input type=checkbox name=is_price_list ##price_list_checked## value="1">
    %%price_list%%
  </td>
</tr>
"-->

<!--#set var="multi_sites_select" value="
<tr>
  <td>
    %%multi_sites_select%%:
  </td>
  <td>
    ##multi_sites_select##
  </td>
</tr>
"-->

<!--#set var="currency_select" value="
<select name="currency##price_number##" style="width: 100px;">##currency_select_row##</select>
"-->

<!--#set var="db_currency_select" value="
<select name="db_currency##price_number##" style="width: 100px;">
<option value="" ##selected##>%%db_currency_no%%
##currency_select_row##
</select>
"-->

<!--#set var="currency_select_row" value="
<option value="##value##" ##selected##>##name##
"-->

<!--#set var="dataset_option" value="
<option value="##value##" ##selected##>##name##</option>
"-->

<!--#set var="discounts_module_addon" value="
<tr>
    <td vAlign="top">%%discount%%:</td>
    <td colSpan="3">
        <table border="0" class="noSpace">
        <tr><td>##discount_ctrl##</td></tr>
        <tr><td><input type="button" class="but-long" onClick="javascript:openDiscountsPopup(this.form)" value="%%button_edit_fields%%" /></td></tr>
        <tr><td colSpan="2" align="right"><input type="checkbox" id="discount_apply_to_subcategories" name="discount_apply_to_subcategories" onChange="this.form.id_discount_source.value='';" />&nbsp;<label for="discount_apply_to_subcategories">%%apply_to_subcategories%%</label></td></tr>
        </table>
    </td>
</tr>
<tr>
    <td colspan="2" height="100%"></td>
</tr>
"-->

<!--#set var="shipping_module_addon" value="
<tr>
    <td vAlign="top">%%shipping_type%%:</td>
    <td colSpan="3">
        <table border="0" class="noSpace">
        <tr><td>##shipping_type_ctrl##</td></tr>
        <tr><td><input type="button" class="but-long" onClick="javascript:openShippingTypesPopup(this.form)" value="%%button_edit_fields%%" /></td></tr>
        <tr><td colSpan="2" align="right"><input type="checkbox" id="shipping_type_apply_to_subcategories" name="shipping_type_apply_to_subcategories" onChange="this.form.id_shipping_type_source.value='';" />&nbsp;<label for="shipping_type_apply_to_subcategories">%%apply_to_subcategories%%</label></td></tr>
        <tr><td colSpan="2" align="right"><input type="checkbox" id="shipping_type_apply_to_products" name="shipping_type_apply_to_products" onChange="this.form.id_shipping_type_source.value='';" />&nbsp;<label for="shipping_type_apply_to_products">%%apply_to_products%%</label></td></tr>
        </table>
    </td>
</tr>
<tr>
    <td colspan="2" height="100%"></td>
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
<a href="javascript:void(0);" onClick="javascript:document.forms[_cms_document_form].##ctrl_field_name_select##.disabled = true;openDialog('%%shipping_type_popup_title%%', '##shipping_types_link##?popup=1&item_id='+document.eshop_form.##ctrl_field_name##.value);return false;"><img id="img_shipping_type" title="%%button_select%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" align="absmiddle" class=icon /></a>
"-->

<!--#set var="list_ctrl_discount_list" value="
<select name="##ctrl_field_name_select##" onChange="javascript:this.form.##ctrl_field_name##.value = this.value;FormChanged(event);">
<option value="0">%%discount_not_selected%%</option>
##list##
</select>
<a href="javascript:void(0);" onClick="javascript:document.forms[_cms_document_form].##ctrl_field_name_select##.disabled = true;openDialog('%%discount_popup_title%%', '##discounts_link##?popup=1?popup=1&category_id=##id##');return false;"><img id="img_discount" title="%%button_select%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" align="absmiddle" class=icon /></a>
"-->

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="eshop_form" onSubmit="return CheckForm(window.document.eshop_form);">
     ##form_common_hidden_fields##
     <input type="hidden" name="publish" value="">
     <input type="hidden" name="type" value="">
     <input type="hidden" name="del_common_pics" value="">
     <input type="hidden" name="id_parent" value="">
     <input type="hidden" name="from_backend" value=""/>
##filter_hidden_fields##
##custom_fields_hiddens##
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width="100%">
     <col width="180">
     <col width="*">
      <tr>
        <td colspan="2">
          <input type=checkbox name=public ##public## value="1">
          %%public%%
        </td>
      </tr>
     ##if(ESHOP_ALLOW_FRACTION != "")##
      <tr>
        <td colspan="2">
          <label><input type=checkbox name=allow_fraction ##allow_fraction## value="1"> %%allow_fraction%%</label>
        </td>
      </tr>
      ##endif##

      ##price_list_checkbox##
##special_flag_list##

##parent_selectbox##
##multi_sites_select##
     <tr>
       <td>
%%name%%*:
</td>
       <td>
         <input type=text name=name class="field field50" value="##name##" maxlength="255">
       </td>
     </tr>
     <tr>
       <td>
%%dataset%%:
</td>
       <td>
         <select name=dataset class=field onChange="datasetChanged()">
            ##dataset_options##
         </select>
       </td>
     </tr>
     ##if(FORM_MODE == "EDIT")##
     <tr>
       <td colspan=2>
        <input type=checkbox name=dataset_child value=1> %%dataset_child%%
       </td>
     </tr>
     ##endif##
##if(INSTRUCTIONS_ON=="1")##
      <tr>
        <td colspan="2">
          <input type=checkbox name=instruct ##instruct## value="1">
          %%instruct%%
        </td>
      </tr>
##endif##

##adv_place_fields##
##adv_campaign_types_fields##

     ##ext_images##

     ##custom_fields_top##

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
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width="100%">
     <col width="180">
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

            <div class="tab-page" id="tab-page-description">
              <textarea class="field" style="width:100%" rows="14" name=description id="description">##description##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('description', cmD_STB , false);}
              </script>
            </div>

            ##if(INSTRUCTIONS_ON=="1")##
            <div class="tab-page" id="tab-page-instruction">
              <textarea class="field" style="width:100%" rows="14" name=instruction id="instruction">##instruction##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('instruction', cmD_STB , false);}
              </script>
            </div>
            ##endif##

            <div class="tab-page" id="tab-page-prices">
             <table cellspacing="5" cellpadding="0" border="0" width="100%">
               <tr>
                 <td height=10 colSpan="2"></td>
               </tr>
               ##price_caption##
               <tr>
                 <td>
                %%base_price%% [price]:
                 </td>
                 <td>
                   <input type=text name=price class="field field20" value="##price##" >
                   ##base_currency##
                 </td>
               </tr>
              ##price_field_list##

               ##update_checkboxes##
               ##discounts_module_addon##
               ##shipping_module_addon##
               ##taxes_module_addon##
             </table>
            </div>

            ##if(EXT_ESHOP_CUSTOM_FIELDS == "1" && hasCustomFieldsTabs)##
            <div class="tab-page" id="tab-page-custom-fields">
               <table cellspacing="5" cellpadding="0" border="0" width="100%">
                 <tr>
                   <td colspan=2 height=10></td>
                 </tr>
                 ##special_flag_list_3##
                 <tr>
                   <td colspan=2><b>%%dataset_name%%: ##dataset_name##</b></td>
                 </tr>
                 ##custom_fields##
                 <tr>
                   <td colspan=2 height=100%>&nbsp;</td>
                 </tr>
               </table>
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
##other_prices_disabled##
        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'announce' : ['%%announce%%', 'active', '', false],
              'description' : ['%%description%%', 'normal', '', false],
        ##if(INSTRUCTIONS_ON=="1")##
              'instruction' : ['%%instruction%%', 'normal', '', false],
        ##endif##
              'prices' : ['%%tab_prices%%', ##if(other_prices_disabled=='')##'normal'##else##'disabled'##endif##, '', false],
        ##if(EXT_ESHOP_CUSTOM_FIELDS == "1" && hasCustomFieldsTabs)##
              'custom-fields' : ['%%tab_custom_fields%%', 'normal', '', false],
        ##endif##
              'options' : ['%%tab_options%%', 'normal', '', false],
        ##if(EXT_AUDIT=="1")##
              'audit' : ['%%tab_audit%%', 'normal', '', false],
        ##endif##
          '':''});

        </script>
     </tr>
     ##if(!empty(custom_fields_bottom))##
     <tr>
       <td colspan=2><br></td>
     </tr>
     ##endif##
     ##custom_fields_bottom##
     </table>
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width="100%">
     <col width="180">
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
     <input id="_async_marker" type="hidden" />
    </form>
<script>
oldParentCatSelectIndex = document.forms[_cms_document_form].elements["parent"].selectedIndex;
oldDatasetSelectIndex = document.forms[_cms_document_form].elements["dataset"].selectedIndex;

calcField(document.eshop_form, pricesFields[0]);
calcField(document.eshop_form, pricesFields[0]);
##if(FORM_MODE != "EDIT" && RELOAD_MODE != '1')##
parentCatChanged(1);
##endif##
</script>
