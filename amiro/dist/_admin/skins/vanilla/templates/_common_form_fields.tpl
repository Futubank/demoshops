%%include_language "templates/lang/_buttons.lng"%%
%%include_language "templates/lang/_common_form_fields.lng"%%

<!--#set var="form_common_hidden_fields" value="
<script type="text/javascript">
patchFrontLinkHRef('##id##'.length ? parseInt('##id##') : false);
</script>

<input type="hidden" name="id" value="##id##">
<input type="hidden" name="action" value="##action##">
<input type="hidden" name="action_original" value="##action##">
<input type="hidden" name="_form_data" value="1">
"-->

<!--#set var="form_buttons_position" value="
<div id="form-buttons">##form_cancel_btn## ##form_add_btn## ##form_apply_btn## ##form_save_btn##</div>
"-->

<!--#set var="form_add_btn" value="
<input type="submit" name="add" value="%%add_btn%%" class="but" ##add## onClick="this.form.action.value='add'">
"-->

<!--#set var="form_apply_btn" value="
<input type="submit" name="apply" value="%%ok_btn%%" class="but" ##apply## onClick="this.form.action.value='apply'">
"-->

<!--#set var="form_save_btn" value="
<input type="submit" name="save" value="%%apply_btn%%" class="but" ##save## onClick="this.form.action.value='save'">
"-->

<!--#set var="form_cancel_btn" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
"-->

<!--#set var="form_add_btn_disabled;form_apply_btn_disabled;form_save_btn_disabled;form_cancel_btn_disabled" value=""-->


<!--#set var="picture_only" value="
     <input type=hidden name=##name## class=field value="##value##" detectchanges="on">
     <span id="div_img_##name##">##edit_picture##</span>
"-->

<!--#set var="pictures_js_vars" value="
var pic_icon_add_##name## = '##add_value##';
var pic_icon_edit_##name## = '##edit_value##';
"-->

<!--#set var="pictures_js_script" value="
if (name=="##name##"){
  var imgelm = document.getElementById('div_img_##name##');
  var imgelmr = document.getElementById('div_img_##name##_rewrite');
  if(imgelm != null)
    imgelm.innerHTML=pic_icon_edit_##name##;
  if(imgelmr != null)
    imgelmr.style.display='inline';

  if (document.getElementById('ext_##name##_img')){
    if(document.forms[_cms_document_form].##name##.value == ''){
      document.getElementById('ext_##name##_img').src = ext_images_noimage;
    }else{
      document.getElementById('ext_##name##_img').src = '##root_path_www##' + document.forms[_cms_document_form].##name##.value;
    }
    try{
        showGeneratedImages();
    }catch(e){};
  }
}
"-->

<!--#set var="_id_page_row" value="<option value="##id##" ##selected##>##name##</option>
"-->

<!--#set var="_id_page_field" value="
##if(USE_ID_PAGE=="1")##
<tr>
    <td>%%page%%: </td>
    <td>
        <select name="id_page" helpId="id_page" id="idIdPage" onChange="onIdPageChanged(this)">##_id_page_rows##</select>
        <div class="tooltip" style="margin: 5px 0px 5px 0px; display: none" id="commonFieldTooltip">%%common_page_noindex%%</div>
        <script type="text/javascript">
            function onIdPageChanged(oIdPage){
                if(oIdPage.value == 0){
                    document.getElementById('commonFieldTooltip').style.display = 'block';
                }else{
                    document.getElementById('commonFieldTooltip').style.display = 'none';
                }
            }
            onIdPageChanged(document.getElementById('idIdPage'));
        </script>
    </td>
</tr>
##EXT_MODULES_CUSTOM_FIELDS_ADDON##
##endif##
"-->

<!--#set var="use_adv_place" value="
<tr>
    <td>%%adv_place%%:</td>
    <td>
        <select name=adv_place>
        <option value=0>%%no_adv_place%%</option>
        ##adv_places##
        </select>
    </td>
</tr>
"-->

<!--#set var="adv_place_item" value="
<option value="##id##"##IF(selected)## selected##endif##>##name##</option>
"-->

<!--#set var="use_adv_campaign_type" value="
<tr>
    <td>%%adv_campaign_type%%:</td>
    <td>
        <select name=adv_campaign_type>
        <option value=0>%%no_adv_campaign_types%%</option>
        ##adv_campaign_types##
        </select>
    </td>
</tr>
"-->

<!--#set var="adv_campaign_type_item" value="
<option value="##id##"##IF(selected)## selected##endif##>##name##</option>
"-->
