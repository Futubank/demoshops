##--system info: module_owner="modules" module="ext_images" system="1"--##
%%include_language "templates/lang/ext_images.lng"%%

<!--#set var="main_body" value="
      <tr>
       <td style="padding-top:10px;" valign=top>%%images%%:</td>
       <td style="padding-top:10px;padding-bottom:10px;">

##if(!empty(edit_popup_picture))##
         <div class="ext_popup_picture_block">
           <div class="ext_popup_picture_preview" onclick="javascript:openDialog('%%popup_picture%%', '##url_popup_picture##')" title="%%click_to_change%%">
             <img id="ext_popup_picture_img" src="##if(empty(popup_picture))####if(empty(GENERATED_POPUP_PICTURE_URL))##images/no-image-##admin_lang##.png##else####GENERATED_POPUP_PICTURE_URL####endif####else####root_path_www####popup_picture####endif##">
             <div id="ext_popup_picture_label">%%generated%%</div>
             <div class="ext_picture_name">%%popup_picture%%</div>
           </div>

           <input type=hidden name=popup_picture class=field value="##popup_picture##" detectchanges="on">

           ##--if(!empty(GENERATED_POPUP_PICTURE_URL))##<div class="ext_picture_name text_button" style="font-size: 11px" onClick="show_picture('##GENERATED_POPUP_PICTURE_URL##', '', '##GENERATED_POPUP_PICTURE_W##', '##GENERATED_POPUP_PICTURE_H##', 1); return false;">%%picture_generated%%</div>##endif--##
         </div>
##endif##


##if(!empty(edit_picture))##
         <div class="ext_picture_block">
           <div class="ext_picture_preview" onclick="javascript:openDialog('%%picture%%', '##url_picture##')" title="%%click_to_change%%">
             <img id="ext_picture_img" src="##if(empty(picture))####if(empty(GENERATED_PICTURE_URL))##images/no-image-##admin_lang##.png##else####GENERATED_PICTURE_URL####endif####else####root_path_www####picture####endif##">
             <div id="ext_picture_label">%%generated%%</div>
             <div class="ext_picture_name">%%picture%%</div>
           </div>

           <input type=hidden name=picture class=field value="##picture##" detectchanges="on">

           ##--if(!empty(GENERATED_PICTURE_URL))##<div class="ext_picture_name text_button" style="font-size: 11px" onClick="show_picture('##GENERATED_PICTURE_URL##', '', '##GENERATED_PICTURE_W##', '##GENERATED_PICTURE_H##', 1); return false;">%%picture_generated%%</div>##endif--##
         </div>
##endif##

##if(!empty(edit_small_picture))##
         <div class="ext_small_picture_block">
           <div class="ext_small_picture_preview" onclick="javascript:openDialog('%%small_picture%%', '##url_small_picture##')" title="%%click_to_change%%">
            <img id="ext_small_picture_img" src="##if(empty(small_picture))####if(empty(GENERATED_SMALL_PICTURE_URL))##images/no-image-##admin_lang##.png##else####GENERATED_SMALL_PICTURE_URL####endif####else####root_path_www####small_picture####endif##">
            <div id="ext_small_picture_label">%%generated%%</div>
            <div class="ext_picture_name">%%small_picture%%</div>
         </div>

           <input type=hidden name=small_picture class=field value="##small_picture##" detectchanges="on">

           ##--if(!empty(GENERATED_SMALL_PICTURE_URL))##<div class="ext_picture_name text_button" style="font-size: 11px" onClick="show_picture('##GENERATED_SMALL_PICTURE_URL##', '', '##GENERATED_SMALL_PICTURE_W##', '##GENERATED_SMALL_PICTURE_H##', 1);">%%picture_generated%%</div>##endif--##
         </div>
##endif##

<script type="text/javascript">

var ext_images_noimage = 'images/no-image-##admin_lang##.png';

function showGeneratedImages(){

##generate_image##
##if(!empty(edit_popup_picture) && generate_popup_image == '')##
  if (document.forms[_cms_document_form]['popup_picture'].value == ''){
    if(document.forms[_cms_document_form]['##prior_source_picture##'] && document.forms[_cms_document_form]['##prior_source_picture##'].value != ''){
      document.getElementById('ext_popup_picture_label').style.display = 'block';
      document.getElementById('ext_popup_picture_img').src = document.getElementById('ext_##prior_source_picture##_img').src;
    }else{
      document.getElementById('ext_popup_picture_img').src = ext_images_noimage;
      document.getElementById('ext_popup_picture_label').style.display = 'none';
    }
  }else{
    document.getElementById('ext_popup_picture_label').style.display = 'none';
  }
##endif##
##if(!empty(edit_small_picture) && generate_small_image == '')##
  if (document.forms[_cms_document_form]['small_picture'].value == ''){
    if(document.forms[_cms_document_form]['##prior_source_picture##'] && document.forms[_cms_document_form]['##prior_source_picture##'].value != ''){
      document.getElementById('ext_small_picture_label').style.display = 'block';
      document.getElementById('ext_small_picture_img').src = document.getElementById('ext_##prior_source_picture##_img').src;
    }else{
      document.getElementById('ext_small_picture_img').src = ext_images_noimage;
      document.getElementById('ext_small_picture_label').style.display = 'none';
    }
  }else{
    document.getElementById('ext_small_picture_label').style.display = 'none';
  }
##endif##
##if(!empty(edit_picture) && generate_image == '')##
  if (document.forms[_cms_document_form]['picture'].value == ''){
    if(document.forms[_cms_document_form]['##prior_source_picture##'] && document.forms[_cms_document_form]['##prior_source_picture##'].value != ''){
      document.getElementById('ext_picture_img').src = document.getElementById('ext_##prior_source_picture##_img').src;
      document.getElementById('ext_picture_label').style.display = 'block';
    }else{
      document.getElementById('ext_picture_img').src = ext_images_noimage;
      document.getElementById('ext_picture_label').style.display = 'none';
    }
  }else{
    document.getElementById('ext_picture_label').style.display = 'none';
  }
##endif##
}

showGeneratedImages()

</script>

         </td>
      </tr>
"-->



<!--#set var="main_body_OLD" value="

##if(!empty(edit_picture))##
     <tr>
       <td nowrap colspan="2">
         <input type=hidden name=picture class=field value="##picture##" detectchanges="on">
         <span id="div_img_picture" helpId="picture" onmouseover="showPicture(event, document.forms[_cms_document_form].picture.value, true);" onmouseout="showPicture(event, document.forms[_cms_document_form].picture.value, false);">##edit_picture##</span>
%%picture%%
         ##if(!empty(GENERATED_PICTURE_URL))##<span class="text_button" style="font-size: 13px" onClick="show_picture('##GENERATED_PICTURE_URL##', '', '##GENERATED_PICTURE_W##', '##GENERATED_PICTURE_H##', 1); return false;">%%picture_generated%%</span>##endif##
         </td>
     </tr>
##endif##

##if(!empty(edit_popup_picture))##
    <tr>
       <td nowrap colspan="2">
         <input type=hidden name=popup_picture class=field value="##popup_picture##" detectchanges="on">
         <span id="div_img_popup_picture" helpId="popup_picture" onmouseover="showPicture(event, document.forms[_cms_document_form].popup_picture.value, true);" onmouseout="showPicture(event, document.forms[_cms_document_form].popup_picture.value, false);">##edit_popup_picture##</span>
%%popup_picture%%
         ##if(!empty(GENERATED_POPUP_PICTURE_URL))##<span class="text_button" style="font-size: 13px" onClick="show_picture('##GENERATED_POPUP_PICTURE_URL##', '', '##GENERATED_POPUP_PICTURE_W##', '##GENERATED_POPUP_PICTURE_H##', 1); return false;">%%picture_generated%%</span>##endif##
         </td>
     </tr>
##endif##

##if(!empty(edit_small_picture))##
     <tr>
       <td colspan="2">
         <input type=hidden name=small_picture class=field value="##small_picture##" detectchanges="on">
         <span id="div_img_small_picture" helpId="small_picture" onmouseover="showPicture(event, document.forms[_cms_document_form].small_picture.value, true);" onmouseout="showPicture(event, document.forms[_cms_document_form].small_picture.value, false);">##edit_small_picture##</span>
%%small_picture%%
         ##if(!empty(GENERATED_SMALL_PICTURE_URL))##<span class="text_button" style="font-size: 13px" onClick="show_picture('##GENERATED_SMALL_PICTURE_URL##', '', '##GENERATED_SMALL_PICTURE_W##', '##GENERATED_SMALL_PICTURE_H##', 1);">%%picture_generated%%</span>##endif##
         </td>
     </tr>
##endif##

"-->