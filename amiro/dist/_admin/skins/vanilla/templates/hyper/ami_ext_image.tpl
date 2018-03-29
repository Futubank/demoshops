##--system info: module_owner="" module="" system="1"--##

<!--#set var="no_picture" value="
    <img src="skins/vanilla/icons/icon-no_image.gif" width=13 height=11 border=0 title="%%no_picture%%">
"-->

<!--#set var="picture_col" value="
    <div class="list-image"><img src="##img_url##" border=0></div>
"-->

<!--#set var="images_add" value="<a href="javascript:" onclick="javascript:openDialog('%%add_images%%', '##url##');return false;"><img id="##id##" title="%%add_images%%" helpId="add_images" class=icon src="skins/vanilla/icons/icon-no_scrnshot.gif" style='vertical-align:middle;'></a>"-->

<!--#set var="images_edit" value="<a href="javascript:" onclick="javascript:openDialog('%%edit_images%%', '##url##');return false;"><img id="##id##" title="%%edit_images%%" helpId="edit_images" class=icon src="skins/vanilla/icons/icon-scrnshot.gif" style='vertical-align:middle;'></a>"-->

<!--#set var="section_ext_image_fields" value="
<tr>
 <td style="padding-top:10px;" valign=top>%%images%%:</td>
 <td style="padding-top:10px;padding-bottom:10px;">##section_html##</td>
</tr>
"-->

<!--#set var="pictures_js_vars" value="
var pic_icon_add_##name## = '##add_value##';
var pic_icon_edit_##name## = '##edit_value##';
"-->

<!--#set var="pictures_js_script" value="
if (name=="##name##"){
  if (document.getElementById('##name##_img')){
    if(document.forms[_cms_document_form].##name##.value == ''){
      document.getElementById('##name##_img').src = ext_images_noimage;
    }else{
      document.getElementById('##name##_img').src = '##root_path_www##' + document.forms[_cms_document_form].##name##.value;
    }
    try{
        showGeneratedImages();
    }catch(e){};
  }
}
"-->

<!--#set var="pictures_js" value="
<script type="text/javascript">

##pictures_js_vars##
var ext_images_noimage = 'images/no-image-##admin_lang##.png';

function OnObjectChanged_news_form(name, first_change, evt){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_news_form);

function showGeneratedImages(){

##if(!empty(edit_ext_img_popup) && generate_ext_img_popup == '1')##
  if (document.forms[_cms_document_form]['ext_img_popup'].value == ''){
    if(document.forms[_cms_document_form]['##prior_source_picture##'] && document.forms[_cms_document_form]['##prior_source_picture##'].value != ''){
      document.getElementById('ext_img_popup_label').style.display = 'block';
      document.getElementById('ext_img_popup_img').src = document.getElementById('##prior_source_picture##_img').src;
    }else{
      document.getElementById('ext_img_popup_img').src = ext_images_noimage;
      document.getElementById('ext_img_popup_label').style.display = 'none';
    }
  }else{
    document.getElementById('ext_img_popup_label').style.display = 'none';
  }
##endif##
##if(!empty(edit_ext_img_small) && generate_ext_img_small == '1')##
  if (document.forms[_cms_document_form]['ext_img_small'].value == ''){
    if(document.forms[_cms_document_form]['##prior_source_picture##'] && document.forms[_cms_document_form]['##prior_source_picture##'].value != ''){
      document.getElementById('ext_img_small_label').style.display = 'block';
      document.getElementById('ext_img_small_img').src = document.getElementById('##prior_source_picture##_img').src;
    }else{
      document.getElementById('ext_img_small_img').src = ext_images_noimage;
      document.getElementById('ext_img_small_label').style.display = 'none';
    }
  }else{
    document.getElementById('ext_img_small_label').style.display = 'none';
  }
##endif##
##if(!empty(edit_ext_img) && generate_ext_img == '1')##
  if (document.forms[_cms_document_form]['ext_img'].value == ''){
    if(document.forms[_cms_document_form]['##prior_source_picture##'] && document.forms[_cms_document_form]['##prior_source_picture##'].value != ''){
      document.getElementById('ext_img_label').style.display = 'block';
      document.getElementById('ext_img_img').src = document.getElementById('##prior_source_picture##_img').src;
    }else{
      document.getElementById('ext_img_img').src = ext_images_noimage;
      document.getElementById('ext_img_label').style.display = 'none';
    }
  }else{
    document.getElementById('ext_img_label').style.display = 'none';
  }
##endif##
}

showGeneratedImages();

</script>
"-->

<!--#set var="ext_img_field" value="
 <div class="##name##_block">
   <div class="##name##_preview" onclick="javascript:openDialog('%%##name##%%', '##url##')" title="%%click_to_change%%">
    <img id="##name##_img" src="##if(!empty(value))####root_path_www####value####endif##">
    <div id="##name##_label">%%generated%%</div>
    <div class="ext_img_name">%%##name##%%</div>
 </div>

   <input type=hidden name="##name##" class=field value="##value##" detectchanges="on">
 </div>
"-->
