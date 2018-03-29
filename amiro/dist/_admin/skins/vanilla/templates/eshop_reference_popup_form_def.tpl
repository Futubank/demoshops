<script type="text/javascript">


var cms_version = '3.3a.1.0727-000';
var editorBaseHref = '##root_path_www##';
var ceCSSFile = '_admin/##skin_path##_css/ce.css';
var ceDynamicCSSFile = '_admin/##skin_path##_css/dynamic.css';
var frontCSSFile = '_mod_files/_css/common.css';
var specCSSFile = '_admin/##skin_path##_css/spec.css';
var frontCustomCSSFile = '_mod_files/_css/default.css';
var adminCSSFile = '_admin/##skin_path##_css/style.css';
var _cms_selected_layout_block;
var editor_enable = '##editor_enable##';
var _cms_document_form = 'referenceForm';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
var interface_lang = '##lang##';

function checkReferenceForm(obj){
   var errmsg = "";

   //editor_updateHiddenField("description");

   if(obj.name.value=="") {
       return focusedAlert(obj.name, '%%name_warn%%');
   }

   ##if(REFERENCE_TYPE == "text")##
   editor_updateHiddenField("value");
   ##endif##

   ##if(REFERENCE_TYPE == "flagmap")##
   ##elseif(REFERENCE_TYPE == "float")##
       if(obj.value.value == "" || obj.value.value.search(/^-?[0-9.]+$/) != 0) {
           return focusedAlert(obj.value, '%%value_float_warn%%');
       }
   ##elseif(REFERENCE_TYPE == "int")##
       if(obj.value.value == "" || obj.value.value.search(/^-?[0-9]+$/) != 0) {
           return focusedAlert(obj.value, '%%value_int_warn%%');
       }
   ##else##
       if(obj.value.value == "") {
           return focusedAlert(obj.value, '%%value_warn%%');
       }
   ##endif##

    return true;
}
var isAutoFillRequired = ##is_autofill##;
function ocnf(name, first_change){
    if(name.indexOf("name") == 0 && isAutoFillRequired && document.referenceForm.value.value == '') {
        document.referenceForm.value.value=document.referenceForm.name.value;
    }
    return true;
}
</script>

<!--#set var="value_field_base" value="
<input type=text name=value class="field field40" value="##value##" maxlength="255">
"-->
<!--#set var="value_field_flagmap" value="
<input type=checkbox name=value_##num## value="1" maxlength="30" id=flag_##num## ##checked##> <label for=flag_##num##>##name##</label><br>
"-->
<!--#set var="value_field_date" value="
<input type=text name=value class='field fieldDate' value="##value##" maxlength="30" helpId= "form_date"/>
<a href="javascript: void(0);" onclick="return getCalendar(event, document.referenceform.value);">
<img class="clnd_img" src="skins/vanilla/images/spacer.gif" helpId= "clnd_date"/></a>
"-->
<!--#set var="value_field_related_items" value="
<input type=hidden name=value value="##value##">
<span id="div_value_add" style="display: ##custom_related_items_add##;"><a href="javascript:void(0);" onClick="openExtDialog('%%related_items_add_list%%', '##CURRENT_OWNER##_item.php?mode=select_related&custom_field_name=value', 1); return false;"><img title="%%related_items_add_icon%%" class=icon src="skins/vanilla/icons/icon-dicget-many.gif" helpId="btn_related_items_add" align=absmiddle></a></span>
<span id="div_value_edit" style="display: ##custom_related_items_edit##;"><a href="javascript:void(0);" onClick="openExtDialog('%%related_items_edit_icon%%', '##CURRENT_OWNER##_item.php?mode=select_related&custom_field_name=value&_grp_ids='+document.referenceform.value.value, 1); return false;"><img id="es_picture" title="%%related_items_edit_icon%%" class=icon src="skins/vanilla/icons/icon-dicget-many.gif" helpId="btn_related_items_edit" align=absmiddle></a></span>
<font style="font-size:9px">[%%number_related_items%%:<input name="value_number" type="text" value="##related_items_number##" readonly style="width: 20px;text-align: right; background-color: #F4F4F4;font-size:11px; BORDER: #FFFFFF 0px solid; ">]</font>
"-->
<!--#set var="value_field_related_cats" value="
<input type=hidden name=value value="##value##">
<span id="div_value_add" style="display: ##custom_related_cats_add##;"><a href="javascript:void(0);" onClick="openExtDialog('%%related_cats_add_list%%', '##CURRENT_OWNER##_cat.php?mode=select_related_cats&custom_field_name=value', 1); return false;"><img title="%%related_cats_add_icon%%" class=icon src="skins/vanilla/icons/icon-dicget-many.gif" helpId="btn_related_cats_add" align=absmiddle></a></span>
<span id="div_value_edit" style="display: ##custom_related_cats_edit##;"><a href="javascript:void(0);" onClick="openExtDialog('%%related_cats_edit_icon%%', '##CURRENT_OWNER##_cat.php?mode=select_related_cats&custom_field_name=value&_grp_ids='+document.referenceform.value.value, 1); return false;"><img id="es_picture" title="%%related_cats_edit_icon%%" class=icon src="skins/vanilla/icons/icon-dicget-many.gif" helpId="btn_related_cats_edit" align=absmiddle></a></span>
<font style="font-size:9px">[%%number_related_cats%%:<input name="value_number" type="text" value="##related_cats_number##" readonly style="width: 20px;text-align: right; background-color: #F4F4F4;font-size:11px; BORDER: #FFFFFF 0px solid; ">]</font>
"-->
<!--#set var="value_field_text" value="
<div style="border:1px solid #cbcdcc;border-radius:5px;">
<textarea name=value id=value class="field" wrap="soft" rows="3" style="width:100%">##value##</textarea>
</div>
<script type="text/javascript">
    AMI.$(document).ready(function(){
        editor_generate("value", cmD_STB, true);
    });
</script>
"-->

<form name="referenceForm" action="##script_link##" enctype="multipart/form-data" method="POST" onsubmit="return checkReferenceForm(this)">
<table border="0" width="100%" cellspacing="10" cellpadding="0">
##if(REFERENCE_TYPE != "related_items" && REFERENCE_TYPE != "related_cats" && REFERENCE_TYPE != "date")##
     <tr>
      <td>%%name%%*:
      </td>
      <td><input type=text name="name" class="field field40" value="##name##" onChange="ocnf('name', 0)">
      </td>
     </tr>
     <tr>
       <td>
        %%value%%*:
       </td>
       <td>
        ##value_field##
       </td>
     </tr>
     <tr>
      <td colspan="2"><label><input type="checkbox" name="add_to_list" value="1" ##add_disabled####checked##>&nbsp;%%add_to_list%%</label></td>
     </tr>
     <tr>
      <td colspan="2" align="right">
       ##form_buttons##
      </td>
     </tr>
##else##
     <tr>
      <td>
       %%unable_form%%
      </td>
     </tr>
##endif##
</table>
<input type="hidden" name="itemId" value="##item_id##">
<input type="hidden" name="refmulti" value="##refmulti##">
<input type="hidden" name="refref" value="##refref##">
<input type="hidden" name="reference_id" value="##reference_id##">
<input type="hidden" name="field_id" value="##field_id##">
<input type="hidden" name="references" value="##references##">
##form_common_hidden_fields##
##filter_hidden_fields##
</form>

