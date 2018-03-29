<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'referenceform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

##pictures_js_vars##

// functions for CE popup handling (text custom fields support)

function openCEPopup(name, title){
    cleanCEPopup(name);

    var popup = new AMI.UI.Popup(AMI.find('#' + name + '_div'),
        {
            id: name + '_popup',
            width: 600,
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
	    '<textarea autocomplete="off" name="' + name + '_ce" id="' + name + '_ce" class="field" wrap="soft" style="width:100%" rows="14"></textarea>' +
		'<div style="text-align: center;">' +
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

function CheckForm(form) {
   var errmsg = "";

   editor_updateHiddenField("description");

   ##if(REFERENCE_DATA_TYPE == "related_items")##
       if(form.value.value == "") {
           return focusedAlert(form.value, '%%value_related_items_warn%%');
       }
   ##elseif(REFERENCE_DATA_TYPE == "related_cats")##
       if(form.value.value == "") {
           return focusedAlert(form.value, '%%value_related_cats_warn%%');
       }
   ##elseif(REFERENCE_DATA_TYPE == "flagmap")##
   ##elseif(REFERENCE_DATA_TYPE == "date")##
       if(form.value.value == "") {
           return focusedAlert(form.value, '%%value_date_warn%%');
       }
   ##elseif(REFERENCE_DATA_TYPE == "float")##
       if(form.value.value == "" || form.value.value.search(/^-?[0-9.]+$/) != 0) {
           return focusedAlert(form.value, '%%value_float_warn%%');
       }
   ##elseif(REFERENCE_DATA_TYPE == "int")##
       if(form.value.value == "" || form.value.value.search(/^-?[0-9]+$/) != 0) {
           return focusedAlert(form.value, '%%value_int_warn%%');
       }
   ##else##
       if(form.value.value == "") {
           return focusedAlert(form.value, '%%value_warn%%');
       }
   ##endif##

   if(form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

   return true;
}

var isAutoFillRequired = ##is_autofill##;
function OnObjectChanged_eshop_reference_subform_def(name, first_change, evt){
    ##pictures_js_script##
    if(name.indexOf("value") == 0 && isAutoFillRequired && document.referenceform.name.value == '') {
        document.referenceform.name.value=document.referenceform.value.value;
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_eshop_reference_subform_def);
-->
</script>


<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
"-->

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
<textarea name=value id=value class="field" wrap="soft" cols="5" rows="3">##value##</textarea>

<div id="value_div" style="display: none;">
<textarea autocomplete="off" name="value_ce" id="value_ce" class="field" wrap="soft" style="width:100%" rows="14">##value##</textarea>
<div style="text-align: center;">
<input class="but" type="submit" value="%%apply_btn%%" onclick="saveCEPopupContent('value');" />&nbsp;&nbsp;
<input class="but" type="button" value="%%cancel_btn%%" onclick="closeCEPopup('value');" />
</div><br /><br />
</div>

<a href="javascript:void(0);" onclick="openCEPopup('value', '');">
<img title="%%edit_btn%%" border="0" src="skins/vanilla/icons/icon-edit.gif" align=absmiddle class=icon></a>
"-->

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="referenceform" onSubmit="return CheckForm(window.document.referenceform);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width="100%" ##IF(FULL_FORM != "1")##style="display:none"##endif##>
     <tr>
       <td width=30% vAlign=top>
        %%value%%*:
       </td>
       <td width=*>
        ##value_field##
       </td>
     </tr>
     <tr>
       <td width=200>
        <nobr>%%name_form%%*:</nobr>
       </td>
       <td>
         <input type=text name=name class="field field40" value="##name##" maxlength="255">
       </td>
     </tr>
     <tr id="refer_2_div"><td></td><td><div class="tooltip">%%note%%</div></td></tr>
     ##item_picture##
     ##ext_images##
     <tr>
       <td width=200>
        %%sku_code%%:
       </td>
       <td>
         <input type=text name=sku_code class="field field40" value="##sku_code##" maxlength="255">
       </td>
     </tr>
     <tr vAlign="top">
       <td colspan="2">
        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-description">
              <textarea class="field" style="width:100%" rows="14" name="description" id="description">##description##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('description', cmD_STB, true);}
              </script>
            </div>
            <div class="tab-page" id="tab-page-options">
              ##options_form##
            </div>
          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'description' : ['%%description%%', 'active', '', false],
              'options' : ['%%tab_options%%', 'normal', '', false],
          '':''});
          
        </script>

       </td>
     </tr>
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
     ##IF(FULL_FORM == "2")##%%flagmap_is_empty%%##elseif(FULL_FORM != "1")##<h3>%%select_reference%%</h3>##endif##
    </form>