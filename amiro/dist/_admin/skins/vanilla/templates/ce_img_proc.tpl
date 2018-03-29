%%include_language "templates/lang/ce_img_proc.lng"%%
%%include_language "templates/lang/main.lng"%%

<!--#set var="form_advanced" value="

##setglobalvar @curr_img=curr_img##
##setglobalvar @curr_preview_width=curr_preview_width##
##setglobalvar @curr_preview_height=curr_preview_height##

<script type="text/javascript">
var alignmentText = Array();
alignmentText['not_set'] = '%%align_not_set%%';
alignmentText['left'] = '%%align_left%%';
alignmentText['right'] = '%%align_right%%';
alignmentText['top'] = '%%align_top%%';
alignmentText['textTop'] = '%%align_texttop%%';
alignmentText['middle'] = '%%align_middle%%';
alignmentText['absMiddle'] = '%%align_absmiddle%%';
alignmentText['baseline'] = '%%align_baseline%%';
alignmentText['bottom'] = '%%align_bottom%%';
alignmentText['absBottom'] = '%%align_absbottom%%';

var sampleTimer;

function setAlignment(val){
  setMainImageField(document.forms['imageForm'].txtFileName);
  for (key in alignmentText){
    if (key == 'indexOf') {
      continue;
    }
    document.getElementById('img_'+key).style.borderColor="#ffffff";
  }
  document.forms['imageForm'].selAlignment.value=val;
  if (val==''){
    val = 'not_set';
  }
  document.getElementById('img_'+val).style.borderColor="#004080";
  document.getElementById('align_text').innerHTML = alignmentText[val];

  if(document.forms['imageForm'].txtFileName.value==''){
    return;
  }

  //updateImage();
  if (document.getElementById('preview_img').src != tImage.src){
    //document.getElementById('sample_text').style.display="inline";
    //window.clearTimeout(sampleTimer);
    //sampleTimer = window.setTimeout(function(){document.getElementById('sample_text').style.display="none";}, 10000);
  }
  //document.forms['imageForm'].txtFileName.select();
}

function showAlignment(val){
  var val_set=(val=='')?'not_set':val;

  for (key_set in alignmentText){
    if (key_set == 'indexOf') {
      continue;
    }
    var key=(key_set=='not_set')?'':key_set;
    if (key != document.forms['imageForm'].selAlignment.value){
      document.getElementById('img_'+key_set).style.borderColor="#ffffff";
    }
  }

  if (val != document.forms['imageForm'].selAlignment.value){
    document.getElementById('img_'+val_set).style.borderColor="#c0c0c0";
  }

  document.getElementById('align_text').innerHTML = alignmentText[val_set];

  if(document.forms['imageForm'].txtFileName.value==''){
    return;
  }



  window.clearTimeout(sampleTimer);
  sampleTimer = window.setTimeout(function(){
                                    document.getElementById('preview_img').align=val;
                                    document.getElementById('sample_text').style.display = "inline";
                                    document.getElementById('popup_img_container').style.display = 'none';
                                    document.getElementById('over_img_container').style.display = 'none';
                                    document.getElementById('img_container').style.maxWidth = '95%';
                                    document.getElementById('preview_img').style.maxWidth = '30%';
                                    document.getElementById('img_container').style.zIndex = '10000';

                                  }, 900);

   if(document.getElementById('sample_text').style.display == "inline"){
     document.getElementById('preview_img').align=val;
   }

}

function hideAlignment(){
  window.clearTimeout(sampleTimer);
  sampleTimer = window.setTimeout(function(){
                                    document.getElementById('preview_img').align='';
                                    //document.getElementById('img_container').style.width = '30%';
                                    //document.getElementById('preview_img').style.width = '100%';

                                    if(document.forms['imageForm'].txtPopupFileName.value!='') document.getElementById('popup_img_container').style.display = 'block';
                                    if(document.forms['imageForm'].txtImageOver.value!='')                                     document.getElementById('over_img_container').style.display = 'block';
                                    document.getElementById('img_container').style.zIndex = '';

                                    document.getElementById('sample_text').style.display = "none";
                                    updatePreviewImage();
                                  }, 900);
}

</script>
<form action="##self_url##" name=imageForm enctype="multipart/form-data" method="POST" onsubmit="return false;" style="margin:0">

<div id="header_img_url" class="smalltab-header-simple" style="cursor:default;">
  <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rbr-c"></div>
  %%img_url%%
</div>
<div id="block_img_url">
<table border="0" cellpadding="0" cellspacing="5" width=100%>
  <tr>
    <td style="width:150px; min-width:150px;" valign=top>
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnChoose(true)">%%choose%%</div><br> 
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnUpload(true)">%%upload%%</div><br> 
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnClean();">%%clean%%</div> 
    </td>
    <td style="width:120px; min-width:120px;">
      <div id="img_block_preview" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnChoose(true)" title="%%choose%%">
        <img src="##txtFileName_img_url##" id="txtFileName_preview">
      </div>
    </td>
    <td valign=top style="min-width:290px;">
      <table border="0" cellpadding="0" cellspacing="3" width=100%>
        <tr>
          <td nowrap>%%width%% X %%height%%:</td>
          <td nowrap align=right>
            <div id="image-size-parametrs"><INPUT ID=txtWidth name=txtWidth type=text class="spin-control" size=3 maxlength=4 value="##txtWidth##" tabIndex=40 > <span id="size-control-btn" class="size-control-btn-selected"></span> <INPUT ID=txtHeight name=txtHeight type=text  class="spin-control" size=3 maxlength=4 value="##txtHeight##" tabIndex=45></div>
            <div id="default-size-images" title="%%default_size_images%%"></div>
            <script type="text/javascript">   
                function getImageSize() {
                    imageWidthSize = AMI.$('#preview_img').width();
                    imageHeightSize = AMI.$('#preview_img').height();
                }
                
                function defaultSizeImages() {
                    if(AMI.$('#txtWidth').attr('value') != AMI.$('#preview_img').width() || AMI.$('#txtHeight').attr('value') != AMI.$('#preview_img').height()) {
                        $('#default-size-images').fadeIn();
                    } else {
                        $('#default-size-images').fadeOut();
                    }
                }
                
                $('#default-size-images').click(function() {
                    AMI.$('#txtWidth').attr('value', AMI.$('#preview_img').width());
                    AMI.$('#txtHeight').attr('value', AMI.$('#preview_img').height());
                    $('#default-size-images').fadeOut();
                });
                
                function keyPressHeight() {
                    if(AMI.$('#size-control-btn').attr('class') == 'size-control-btn-selected') {
                        getImageSize();
                        AMI.$('#txtWidth').attr('value', Math.round(imageWidthSize/(imageHeightSize/AMI.$('#txtHeight').attr('value'))));
                    }
                    defaultSizeImages();
                }
                
                function keyPressWidth() {
                    if(AMI.$('#size-control-btn').attr('class') == 'size-control-btn-selected') {
                        getImageSize();
                        AMI.$('#txtHeight').attr('value', Math.round(imageHeightSize/(imageWidthSize/AMI.$('#txtWidth').attr('value'))));
                    }
                    defaultSizeImages();
                }
                
                AMI.$('#size-control-btn').click(function() {
                    if(AMI.$('#size-control-btn').attr('class') == 'size-control-btn-selected') {
                        AMI.$('#size-control-btn').attr('class', 'size-control-btn');
                    } else if (AMI.$('#txtWidth').attr('value') == '' || AMI.$('#txtHeight').attr('value') == '') {
                        AMI.$('#size-control-btn').attr('class', 'size-control-btn-selected');
                    } else {
                        AMI.$('#size-control-btn').attr('class', 'size-control-btn-selected');
                            getImageSize();
                            AMI.$('#txtHeight').attr('value', Math.round(imageHeightSize/(imageWidthSize/AMI.$('#txtWidth').attr('value'))));
                    }
                });
                
                AMI.$('#txtHeight').keyup(function() {keyPressHeight()}).keydown(function() {keyPressHeight()});
                AMI.$('#txtWidth').keyup(function() {keyPressWidth()}).keydown(function() {keyPressWidth()});
            
                AMI.$('#txtHeight, #txtWidth').click(function() {
                    elemByScroll = document.getElementById($(this).attr('id'));
                    mousewheelevt = (/Firefox/i.test(navigator.userAgent))? "DOMMouseScroll" : "mousewheel";
                    if (window.addEventListener){
                        elemByScroll.addEventListener(mousewheelevt, scrollSizeByMouse, false);
                    } else {
                        elemByScroll.attachEvent("onmousewheel", scrollSizeByMouse);
                    }
                }); 

                function scrollSizeByMouse(e) {
                    if(AMI.$('#txtHeight').attr('class') == 'spin-control-active') {
                        keyPressHeight();
                    } else if (AMI.$('#txtWidth').attr('class') == 'spin-control-active') {
                        keyPressWidth();
                    }
                }
            </script>
          </td>
        </tr>
      </table>
      <table border="0" cellpadding="0" cellspacing="3" width=100% style="margin-top:-3px;">
        <tr>
          <td>%%hor_spacing%%:</td>
          <td align=right><INPUT ID=txtHorizontal name=txtHorizontal type=text class="spin-control" size=3 maxlength=3 tabIndex=25  value="##if(txtHorizontal == '')##5##else####txtHorizontal####endif##"></td>
        </tr>
        <tr>
          <td>%%ver_spacing%%:</td>
          <td align=right><INPUT ID=txtVertical name=txtVertical type=text class="spin-control" size=3 maxlength=3 tabIndex=30  value="##if(txtVertical == '')##5##else####txtVertical####endif##"></td>
        </tr>
        <tr>
          <td>%%border%%:</td>
          <td align=right><INPUT ID=txtBorder name=txtBorder type=text class="spin-control" size=3 maxlength=3 tabIndex=35  value="##txtBorder##"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr><td colspan=3 style="height:1px;"></td></tr>
  <tr>
    <td id=lbl_txtFileName>%%img_url_path%%:</td>
    <td style="padding-left:9px;" colspan=2 nowrap><INPUT ID=txtFileName name=txtFileName type=text class=field tabIndex=10 value="##txtFileName##" onfocus="this.select();" style="width:100%;" onchange="setMainImageField(document.forms['imageForm'].txtFileName);setImage();"></td>
  </tr>
  <tr id="image_alt_text">
    <td nowrap>%%alt_text%%:<sup title="%%alt_title%%">[?]</sup></td>
    <td style="padding-left:9px;" colspan=2><INPUT type=text class=field ID=txtAltText name=txtAltText tabIndex=15 style="width:100%;" value="##txtAltText##"></td>
  </tr>
  <tr id="image_title_text">
    <td nowrap>%%title_text%%:<sup title="%%title_title%%">[?]</sup></td>
    <td style="padding-left:9px;" colspan=2><INPUT type=text class=field ID=txtTitleText name=txtTitleText tabIndex=15 style="width:100%;" value="##txtTitleText##"></td>
  </tr>
  <tr>
    <td nowrap colspan=3 style="height:18px;">%%alignment%%: <span id=align_text style="color:#006699">%%align_not_set%%</span></td>
  </tr>
  <tr>
    <td colspan="3" align=center height=50 onmouseout='hideAlignment();'>
    <input type=hidden name=selAlignment value="##selAlignment##">
    <table id=img_align_set cellpadding=0 cellspacing=0 width=100% border=0  onmouseout="showAlignment(document.forms['imageForm'].selAlignment.value);">
    <tr><td onmouseover="showAlignment('');"><img id=img_not_set src="skins/vanilla/icons/img_align_not_set.gif" width=40 height=40 border=2 onclick="setAlignment('');"></td>
    <td onmouseover="showAlignment('left');"><img id=img_left src="skins/vanilla/icons/img_align_left.gif" width=40 height=40 border=2 onclick="setAlignment('left');"></td>
    <td onmouseover="showAlignment('right');"><img id=img_right  src="skins/vanilla/icons/img_align_right.gif" width=40 height=40 border=2 onclick="setAlignment('right');"></td>
    <td onmouseover="showAlignment('top');"><img id=img_top  src="skins/vanilla/icons/img_align_top.gif" width=40 height=40 border=2 onclick="setAlignment('top');"></td>
    <td onmouseover="showAlignment('textTop');"><img id=img_textTop  src="skins/vanilla/icons/img_align_texttop.gif" width=40 height=40 border=2 onclick="setAlignment('textTop');"></td>
    <td onmouseover="showAlignment('middle');"><img id=img_middle  src="skins/vanilla/icons/img_align_middle.gif" width=40 height=40 border=2 onclick="setAlignment('middle');"></td>
    <td onmouseover="showAlignment('absMiddle');"><img id=img_absMiddle  src="skins/vanilla/icons/img_align_absmiddle.gif" width=40 height=40 border=2 onclick="setAlignment('absMiddle');"></td>
    <td onmouseover="showAlignment('baseline');"><img id=img_baseline  src="skins/vanilla/icons/img_align_baseline.gif" width=40 height=40 border=2 onclick="setAlignment('baseline');"></td>
    <td onmouseover="showAlignment('bottom');"><img id=img_bottom  src="skins/vanilla/icons/img_align_bottom.gif" width=40 height=40 border=2 onclick="setAlignment('bottom');"></td>
    <td onmouseover="showAlignment('absBottom');"><img id=img_absBottom  src="skins/vanilla/icons/img_align_absbottom.gif" width=40 height=40 border=2 onclick="setAlignment('absBottom');"></td></tr>
    </table>
    </td>
  </tr>
</table>
</div>

<div id="header_popup_img_url" class="smalltab-header" onclick="switchBlock('popup_img_url')">
  <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rbr-c"></div>
  %%popup_img_url%%
</div>

<div id="block_popup_img_url">

<table border="0" cellpadding="0" cellspacing="5" width=100%>
  <tr>
    <td style="width:150px; min-width:150px;" valign=top>
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtPopupFileName);btnChoose(true)">%%choose%%</div><br> 
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtPopupFileName);btnUpload(true)">%%upload%%</div><br> 
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtPopupFileName);btnClean()">%%clean%%</div> 
    </td>
    <td style="width:120px">
      <div id="popup_img_block_preview" onclick="setMainImageField(document.forms['imageForm'].txtPopupFileName);btnChoose(true)" title="%%choose%%">
        <img src="##txtPopupFileName_img_url##" id="txtPopupFileName_preview">
      </div>
    </td>
    <td valign=top>
      <table border="0" cellpadding="0" cellspacing="3" width=100%>
        <tr id="popup_props2" style="display:none;">
          <td align=left>%%width%% X %%height%%:<sup title="%%popup_width_height_title%%">[?]</sup></td>
          <td align=right><INPUT ID=txtPopupWidth name=txtPopupWidth type=text class="spin-control" size=3 maxlength=4 value="##txtPopupHeight##" tabIndex=46 onfocus="document.getElementById('preview_img');select()"> X <INPUT ID=txtPopupHeight name=txtPopupHeight type=text class="spin-control" size=3 maxlength=4 value="##txtPopupWidth##" tabIndex=47></td>
        </tr>
      </table>
      <table border="0" cellpadding="0" cellspacing="3" width=100% style="margin-top:-3px;">
        <tr id="imageHeader">
          <td>%%header_text%%:<sup title="%%header_title%%">[?]</sup></td>
          <td><INPUT type=text class=field ID="txtHeaderText" name="txtHeaderText" tabIndex=15 style="width:100%" value="##txtHeaderText##"></td>
        </tr>
        <tr id="imageGroup">
          <td >%%group_text%%:<sup title="%%group_title%%">[?]</sup></td>
          <td><INPUT type=text class=field ID="txtGroupText" name="txtGroupText" tabIndex=15 style="width:100%" value="##txtGroupText##"></td>
        </tr>
        <tr id="imageLink1">
          <td >%%link_text%%:<sup title="%%link_note%%">[?]</sup></td>
          <td nowrap>
              <INPUT type=text class=field ID="txtLinkText" name="txtLinkText" tabIndex=15  style="width:100%" value="##txtLinkText##">
          </td>
        </tr>
        <tr id="imageLink2">
          <td nowrap>%%link_caption%%:<sup title="%%link_note%%">[?]</sup></td>
          <td nowrap>
              <INPUT type=text class=field ID="txtLinkCaptionText" name="txtLinkCaptionText" tabIndex=15 style="width:100%" value="##txtLinkCaptionText##">
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr><td colspan=3 style="height:1px;"></td></tr>
  <tr id="popup_props1">
    <td id=lbl_txtPopupFileName>%%img_url_path%%:</td>
    <td style="padding-left:9px;" colspan=2><INPUT ID=txtPopupFileName name=txtPopupFileName type=text class=field tabIndex=10 value="##txtPopupFileName##" onfocus="this.select();" style="width:100%;"></td>
  </tr>
  <tr id="imageDescription">
    <td>%%description_text%%:<sup title="%%description_title%%">[?]</sup></td>
    <td colspan=2 style="padding-left:9px;">
        <INPUT type=text class=field name="txtDescriptionTextInput" tabIndex=15  onfocus="expandDescriptionControl(false, true);" onkeyup="expandDescriptionControl(true, true);" onmouseup="expandDescriptionControl(true, true);" onchange="expandDescriptionControl(false, false);" style="width: 100%" value="##txtDescriptionTextInput##">
        <textarea class=field name="txtDescriptionTextTextarea" tabIndex=15  onfocus="expandDescriptionControl(false, true);" onkeyup="expandDescriptionControl(true, true);" onmouseup="expandDescriptionControl(true, true);" onchange="expandDescriptionControl(false, false);" style="width: 100%; height: 42px; display: none; margin-left:2px;" disabled="disabled">##txtDescriptionTextInput##</textarea>
    </td>
  </tr>
</table>
</div>

<div id="header_img_over" class="smalltab-header" onclick="switchBlock('img_over')">
  <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rbr-c"></div>
  %%image_over%%
</div>
<div id="block_img_over">
<table border="0" cellpadding="0" cellspacing="5" width=100%>
  <tr>
    <td style="width:150px; min-width:150px;" valign=top>
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtImageOver);btnChoose(true)">%%choose%%</div><br>
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtImageOver);btnUpload(true)">%%upload%%</div><br>
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtImageOver);btnClean()">%%clean%%</div> 
    </td>
    <td style="width:120px">
      <div id="img_over_block_preview" onclick="setMainImageField(document.forms['imageForm'].txtImageOver);btnChoose(true)" title="%%choose%%">
        <img src="##txtImageOver_img_url##" id="txtImageOver_preview">
      </div>
    </td>
    <td valign=top>&nbsp;
    </td>
  </tr>
  <tr><td colspan=3 style="height:1px;"></td></tr>
  <tr id="imageOverBlock">
    <td id=lbl_txtImageOver>%%img_url_path%%:</td>
    <td colspan=2  style="padding-left:9px;"><INPUT ID=txtImageOver name=txtImageOver ##--name="image_over"--## type=text class=field tabIndex=10 value="##txtImageOver##" onfocus="this.select();" style="width:100%;"></td>
  </tr>
</table>
</div>

<div style="text-align:right">
    <input class="but" ID=btnOK  type=submit tabIndex=50 value="%%ok_btn%%">
    &nbsp;
    <input class="but" ID=btnCancel type="button" tabIndex=55 onClick="closeDialogWindow()" value="%%cancel_btn%%">
</div>

</form>
"-->

<!--#set var="form_simple" value="
##setglobalvar @curr_img=curr_img##
##setglobalvar @curr_preview_width=curr_preview_width##
##setglobalvar @curr_preview_height=curr_preview_height##

<form action="##self_url##" name=imageForm enctype="multipart/form-data" method="POST" onsubmit="return false;">

<div id="header_img_url" class="smalltab-header-simple" style="cursor:default;">
  <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rbr-c"></div>
  %%img_url%%
</div>
<div id="block_img_url">
<table border="0" cellpadding="0" cellspacing="5" width=100%>
  <tr>
    <td style="width:150px;min-width:150px;" valign=top>
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnChoose(true)">%%choose%%</div><br> 
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnUpload(true)">%%upload%%</div><br> 
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnClean();">%%clean%%</div> 
    </td>
    <td style="width:120px">
      <div id="img_block_preview" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnChoose(true)" title="%%choose%%">
        <img src="##txtFileName_img_url##" id="txtFileName_preview">
      </div>
    </td>
    <td valign=top>&nbsp;
    </td>
  </tr>
  <tr><td colspan=3 style="height:1px;"></td></tr>
  <tr>
    <td id=lbl_txtFileName>%%img_url_path%%:</td>
    <td style="padding-left:9px;" colspan=2 nowrap><INPUT ID=txtFileName name=txtFileName type=text class=field tabIndex=10 value="##txtFileName##" onfocus="this.select();" style="width:100%;" onchange="setMainImageField(document.forms['imageForm'].txtFileName);setImage();"></td>
  </tr>
</table>
</div>


<div id="buttons_block" style="text-align:right">
<nobr>
<input class="but" ID=btnOK  type=submit tabIndex=51 value="%%ok_btn%%" style="margin-right: 10px;"></nobr>
&nbsp;
<input type="button" class="but" ID=btnCancel tabIndex=52 onClick="closeDialogWindow()" value="%%cancel_btn%%">
</div>


</form>
"-->

<!--#set var="form_bg" value="
##setglobalvar @curr_img=curr_img##
##setglobalvar @curr_preview_width=curr_preview_width##
##setglobalvar @curr_preview_height=curr_preview_height##
<style>
#img_container{
  width:95%;
  height:95%;
}
</style>
<form action="##self_url##" name=imageForm enctype="multipart/form-data" method="POST" onsubmit="return false;">

<div id="header_img_url" class="smalltab-header-simple" style="cursor:default;">
  <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rbr-c"></div>
  %%bg_img_url%%
</div>
<div id="block_img_url">
<table border="0" cellpadding="0" cellspacing="5" width=100%>
  <tr>
    <td style="width:150px;min-width:150px;" valign=top>
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnUpload(true)">%%upload%%</div><br> 
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnChoose(true)">%%choose%%</div><br> 
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnClean();">%%clean%%</div> 
    </td>
    <td style="width:120px">
      <div id="img_block_preview" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnChoose(true)" title="%%choose%%">
        <img src="##txtFileName_img_url##" id="txtFileName_preview">
      </div>
    </td>
    <td valign=top>
      <table border="0" cellpadding="0" cellspacing="3" width=100%>
        <tr>
          <td nowrap>
            <nobr><label><input type=checkbox name=bgrepeat_x ##bgrepeat_x## onclick="updateImage();" value="checked"> %%bg_repeat-x%%</label></nobr>
          </td>
        </tr>
        <tr>
          <td nowrap>
            <nobr><label><input type=checkbox name=bgrepeat_y ##bgrepeat_y## onclick="updateImage();" value="checked"> %%bg_repeat-y%%</label></nobr>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr><td colspan=3 style="height:1px;"></td></tr>
  <tr>
    <td id=lbl_txtFileName>%%img_url_path%%:</td>
    <td style="padding-left:9px;" colspan=2 nowrap><INPUT ID=txtFileName name=txtFileName type=text class=field tabIndex=10 value="##txtFileName##" onfocus="this.select();"  style="width:100%;" onchange="setMainImageField(document.forms['imageForm'].txtFileName);setImage();"></td>
  </tr>
</table>
</div>


<div id="buttons_block" style="text-align:right">
<nobr>
<input class="but" ID=btnOK  type=submit tabIndex=51 value="%%ok_btn%%" style="margin-right: 10px;">
&nbsp;
<input type="button" class="but" ID=btnCancel tabIndex=52 onClick="closeDialogWindow()" value="%%cancel_btn%%">
</nobr>
</div>

</form>
"-->


<!--#set var="resize_item" value="
<div style="float: left; width:120px; padding: 2px;"><nobr><label><input type=checkbox name=resize##dim## value=1 onclick="checkResizeOptions()">&nbsp;##dim_str##&nbsp;&nbsp;&nbsp;</label></nobr></div>
"-->

<!--#set var="resize_options" value="
  <tr>
    <td colspan=2 style="padding-left:26px;padding-top:10px">
        <span class="text_button" onclick="javascript:flipBlockData('resizeData')" helpId="resize-img">%%resize%%</span><img src="skins/vanilla/images/icon_switch_down.gif" width="14" height="8" border="0" style="margin-left: 6px" id="resizeDataImg">
        <div id="resizeData" style="display:none;padding: 5px 0px 0px 0px;">
        <div class=tooltip id='delete_orig_note'>%%upload_note%%</div>
          ##resize_form##
          ##IF (upload_allow_cusotm_size==1)##
          <div style="padding: 2px; width:120px;float:left;"><nobr><input class="field" type=text name=custom_width value="" style="width: 30px"  onkeydown="spinValue(event, 10000)" onkeyup="checkResizeOptions()"> x <input class="field" type=text name=custom_height value="" style="width: 30px" onkeydown="spinValue(event, 10000)" onkeyup="checkResizeOptions()"></nobr></div>
          ##ENDIF##
          <div style="clear:both;padding:2px;">
            <label><input type=checkbox name=keep_ratio value="1" checked>&nbsp;%%keep_ratio%%</label><br>
            <label><input type=checkbox name=delete_orig value="1" checked>&nbsp;%%delete_orig%%</label>
          </div>
        </div>
    </td>
  </tr>
"-->

<!--#set var="watermark_source_item;watermark_method_item" value="<option value="##value##">##name##</option>"-->
<!--#set var="watermark_block" value="
  <tr>
    <td colspan=2 style="padding-left:26px; padding-bottom: 3px">
        <span class="text_button" onclick="javascript:flipBlockData('watermarkData')" helpId="watermark">%%set_watermark%%</span><img src="skins/vanilla/images/icon_switch_down.gif" width="14" height="8" border="0" style="margin-left: 6px" id="watermarkDataImg">
        <div id="watermarkData" style="display:none">
        <div style="line-height: 4px">&nbsp;</div>
        <div style="float: left; width: 106px; padding-top:4px">%%watermark_source%%:</div> <select name="watermark_source" onChange="checkWatermarkSource(this)">##watermark_sources##</select><br>
        <div style="float: left; width: 106px; padding-top:4px">%%watermark_method%%:</div> <select id="watermark_method" name="watermark_method" disabled>##watermark_methods##</select><br>
        <div style="float: left; width: 106px; padding-top:4px">%%watermark_alpha%%:</div> <input id="watermark_alpha" class="field field3" disabled type=text name="watermark_alpha" value="65" onkeydown="spinValue(event, 127)" onkeyup="checkWatermarkAlpha(this)"> %<br>
        </div>
    </td>
  </tr>
"-->

<!--#set var="form_upload" value="
<div style="position:relative">
<form action="##self_url##" name=uploadForm enctype="multipart/form-data" method="POST" onsubmit="if(!extFileFields()){ return false } else {prepareFormFields(this); document.getElementById('upload_progress').style.display='block'};">

<input type="hidden" name="main_field" value="##main_image##">
<input type="hidden" name="mode" value="##mode##">
<input type="hidden" name="txtFileName" value="">
<input type="hidden" name="txtWidth" value="">
<input type="hidden" name="txtHeight" value="">
<input type="hidden" name="txtHorizontal" value="">
<input type="hidden" name="txtVertical" value="">
<input type="hidden" name="txtBorder" value="">
<input type="hidden" name="txtAltText" value="">
<input type="hidden" name="txtTitleText" value="">
<input type="hidden" name="txtPopupFileName" value="">
<input type="hidden" name="txtPopupWidth" value="">
<input type="hidden" name="txtPopupHeight" value="">
<input type="hidden" name="txtHeaderText" value="">
<input type="hidden" name="txtGroupText" value="">
<input type="hidden" name="txtLinkText" value="">
<input type="hidden" name="txtLinkCaptionText" value="">
<input type="hidden" name="txtDescriptionTextInput" value="">
<input type="hidden" name="txtDescriptionTextTextarea" value="">
<input type="hidden" name="txtImageOver" value="">
<input type="hidden" name="bgrepeat_x" value="">
<input type="hidden" name="bgrepeat_y" value="">
<input type="hidden" name="selAlignment" value="">



<table border="0" cellpadding="0" cellspacing="0" width=100% style="margin-top:20px;">
  <tr>
    <td colspan=2>%%upload_to_dir%%
    <select name="set_cat" style="font-weight:bold;">##dir_select##</select>
    </td>
  </tr>
  <tr>
    <td>&nbsp;
    </td>
  </tr>
  <tr>
    <td colspan=2 nowrap><b>1.</b>&nbsp;<input type="file" name="ffilename1" class="field" style="width:90%" value="" onchange="onSetFile(event, this.value);" onfocus="onSetFile(event, this.value);">
    </td>
  </tr>
  ##resize_options##
  ##watermark_block##
  <tr>
    <td colspan=2 style="padding-top:10px;"><label><input type=checkbox name=force_owerwrite value="1">&nbsp;%%force_owerwrite%%</label></td>
  </tr>
  <tr>
    <td colspan=2 align=right>
    <br><nobr>
    ##--<input class="but" ID=btnCancel  type=button tabIndex=100 value="%%cancel_btn%%" onclick="btnUpload(false)">
    &nbsp;--##
    <input class="but" ID=btnOK  type=submit tabIndex=100 value="%%upload_img%%">
    </nobr>
    </td>
  </tr>
</table>
</form>
<script type="text/javascript">
checkResizeOptions();
</script>
<div id="upload_progress">
            <div class="cssload-thecube">
                <div class="cssload-cube cssload-c1"></div>
                <div class="cssload-cube cssload-c2"></div>
                <div class="cssload-cube cssload-c4"></div>
                <div class="cssload-cube cssload-c3"></div>
            </div>
</div>
</div>
"-->


<!--#set var="js_img" value="

var tImage = new Image();
tImage.src = '##no_image##';

var imageFields = new Array('txtFileName' ##if(imagetape==1)##, 'txtPopupFileName'##endif##);

function Init() {
  ##if(main_field && (imagetape == 1))##
    setMainImageField(document.getElementById('##main_field##'));
  ##endif##
  if (!mainImageField){
    setMainImageField(document.getElementById(imageFields[0]));
  }
  var elmImage = window.parentWindow.document.getElementById("##obj_name##");
  if("##fld_name##" != "" && "##fld_name##" != "null"){
      var elmFieldArr = window.parentWindow.document.getElementsByName("##fld_name##");
      if(elmFieldArr.length > 0){
        var elmField = elmFieldArr[0];
      }else{
        var elmField = window.parentWindow.document.forms[window.parentWindow._cms_document_form].elements['##fld_name##'];
      }
  }else{
    if (document.getElementById("buttons_block")){
      document.getElementById("buttons_block").style.display = 'none';
    }
  }

  var editorBaseHref = top.editorBaseHref;

  ##if(imagetape==1)##
    var hash = elmField.getAttribute('data-ami-hash');
    if(hash != null){
        var aParts = hash.split('|');
        document.forms['imageForm'].txtAltText.value                = aParts[1] || '';
        document.forms['imageForm'].txtTitleText.value              = aParts[2] || '';
        document.forms['imageForm'].txtHeaderText.value             = aParts[3] || '';
        document.forms['imageForm'].txtLinkText.value               = aParts[4] || '';
        document.forms['imageForm'].txtLinkCaptionText.value        = aParts[5] || '';
        document.forms['imageForm'].txtPopupFileName.value          = aParts[6] || '';
        document.forms['imageForm'].txtDescriptionTextInput.value   = aParts[7] || '';

        if(document.forms['imageForm'].txtPopupFileName.value != ''){
            document.getElementById('txtPopupFileName_preview').src = editorBaseHref + document.forms['imageForm'].txtPopupFileName.value;
            document.getElementById('preview_popup_img').src = document.getElementById('txtPopupFileName_preview').src;
            switchBlock('popup_img_url');
        }
    }
  ##endif##

  document.forms['imageForm'].btnOK.onclick = btnOKClick;
  //document.forms['imageForm'].btnNO.onclick = btnNOClick;

  mainImageField.fImageLoaded = false;
  //if (document.getElementById('preview_img').src != tImage.src){
  if (document.forms['imageForm'].txtFileName.value != ''){

    oDate = new Date();
    sDate = "?"+oDate.getYear()+oDate.getMonth()+oDate.getDay()+oDate.getHours()+oDate.getMinutes()+oDate.getSeconds();
    //document.getElementById('preview_img').src = document.getElementById('preview_img').src + sDate;
    //window.document.images[mainImageField.id+"_preview"].src = document.getElementById('preview_img').src;
    document.getElementById('txtFileName_preview').src = editorBaseHref + document.forms['imageForm'].txtFileName.value + sDate;
    document.getElementById('preview_img').src = document.getElementById('txtFileName_preview').src;
  }else{
    if (elmField && elmField.value != "") {
      mainImageField.value = elmField.value.replace(editorBaseHref, "");  // fix placeholder src values that editor converted to abs paths
      document.getElementById('preview_img').src = editorBaseHref + mainImageField.value;
      window.document.images[mainImageField.id+"_preview"].src = editorBaseHref + mainImageField.value;
    }
  }

  //document.getElementById('preview_img').removeAttribute("width");
  //document.getElementById('preview_img').removeAttribute("height");

  updateImage();

  if(!document.forms['imageForm'].txtFileName.value){
     setMainImageField(document.forms['imageForm'].txtFileName);
     btnChoose(true);
  }
}

function _isValidNumber(txtBox) {
  var val = parseInt(txtBox);
  if (isNaN(val) || val < 0 || val > 999) { return false; }
  return true;
}

function btnClean(){
  mainImageField.value = "";
  setImage(tImage.src);
}

function btnNOClick(){
  document.forms['imageForm'].reset();
  mainImageField.value = "";
  setImage(tImage.src,0,0);
}

function btnOKClick() {

  var elmImage = window.parentWindow.document.getElementById("##obj_name##");

    ##if(imagetape==1)##
        if(!document.forms['imageForm'].txtFileName.value){
            alert('%%error_no_main_image%%');
            return;
        }
    ##endif##

  if("##fld_name##" != ""){
      var elmFieldArr = window.parentWindow.document.getElementsByName("##fld_name##");
      if(elmFieldArr.length > 0){
        var elmField = elmFieldArr[0];
      }else{
        var elmField = window.parentWindow.document.forms[window.parentWindow._cms_document_form].elements['##fld_name##'];
      }
  }

  if (elmImage){
    elmImage.src = top.editorBaseHref + mainImageField.value;
  }
  if (elmField){

    var fieldValue = mainImageField.value;

    ##if(imagetape==1)##
        fieldValue = document.getElementById('txtFileName').value;

        var txtAltText                 = document.getElementById('txtAltText');
        var txtTitleText               = document.getElementById('txtTitleText');
        var txtHeaderText              = document.getElementById('txtHeaderText');
        var txtLinkText                = document.getElementById('txtLinkText');
        var txtLinkCaptionText         = document.getElementById('txtLinkCaptionText');
        var txtPopupFileName           = document.getElementById('txtPopupFileName');
        var txtDescriptionTextInput    = document.getElementById('txtDescriptionTextInput');
        if (txtDescriptionTextInput.style.display == 'none') {
            txtDescriptionTextInput    = document.getElementById('txtDescriptionTextTextarea');
        }

        fieldValue += ( '|' + txtAltText.value );
        fieldValue += ( '|' + txtTitleText.value );
        fieldValue += ( '|' + txtHeaderText.value );
        fieldValue += ( '|' + txtLinkText.value );
        fieldValue += ( '|' + txtLinkCaptionText.value );
        fieldValue += ( '|' + txtPopupFileName.value );
        fieldValue += ( '|' + txtDescriptionTextInput.value );
    ##endif##

    elmField.value = fieldValue;

    fireEvent2(elmField, 'change', window.parentWindow.document);
  }
  closeDialogWindow();
}
"-->


<!--#set var="js_bgobj" value="
var editorObject = null;

var editorBaseHref

var tImage = new Image();
tImage.src = '##no_image##';

var imageFields = new Array('txtFileName');

function Init() {

  if(!mainImageField){
      setMainImageField(document.getElementById(imageFields[0]));
  }
  document.forms['imageForm'].btnOK.onclick = btnOKClick;
  //document.forms['imageForm'].btnNO.onclick = btnNOClick;

  var formWindow = top.currentParentWindow ? top.currentParentWindow : top;
  var textareaObject = formWindow.document.getElementById('##obj_name##');
  if(textareaObject && textareaObject.editorAttached){
      editorObject = textareaObject.editorObject;
  }
  editorBaseHref = formWindow.editorBaseHref;


  //if(document.getElementById('preview_img').src != tImage.src){
  if (document.forms['imageForm'].txtFileName.value != ''){
      oDate = new Date();
      sDate = "?"+oDate.getYear()+oDate.getMonth()+oDate.getDay()+oDate.getHours()+oDate.getMinutes()+oDate.getSeconds();
      //document.getElementById('preview_img').src = document.getElementById('preview_img').src + sDate;
      document.getElementById('txtFileName_preview').src = editorBaseHref + document.forms['imageForm'].txtFileName.value + sDate;
      document.getElementById('preview_img').src = document.getElementById('txtFileName_preview').src;

  }else{
      var imgURL;

      var selectedNode = editorObject.sessionData.selectedNode;
      if(selectedNode == null){
          var selectedNode = editorObject.sessionData.getEditorFirstSelectedItem;
      }
      if(selectedNode == null){
          closeDialogWindow();
          return;
      }

      do{
          var selectedNodeTag = '';
          if(selectedNode.tagName){
              selectedNodeTag = selectedNode.tagName.toLowerCase();
          }
          if(selectedNodeTag == 'body' || selectedNodeTag == 'table' || selectedNodeTag == 'tr' || selectedNodeTag == 'th' || selectedNodeTag == 'td' || selectedNodeTag == 'div'){
              break;
          }
      }while(selectedNode = selectedNode.parentNode);

      if (selectedNode && selectedNode.style.backgroundImage){
          var bgSrc = selectedNode.style.backgroundImage.replace(/^url\((.*?)\)$/g, '$1');
          bgSrc = bgSrc.replace(/"/g,'');
          if(bgSrc.substr(0, formWindow.editorBaseHref.length) == formWindow.editorBaseHref){
              bgSrc = bgSrc.substr(formWindow.editorBaseHref.length);
          }

          document.getElementById('img_container').style.backgroundImage = 'url('+formWindow.editorBaseHref+bgSrc+')';
          document.getElementById('img_container').style.backgroundRepeat = selectedNode.style.backgroundRepeat;
          window.document.images["preview_img"].src = "images/empty.gif";
          window.document.images[mainImageField.id + "_preview"].src = formWindow.editorBaseHref+bgSrc;


          mainImageField.value = bgSrc;
          if (selectedNode.style.backgroundRepeat=="" || selectedNode.style.backgroundRepeat=="repeat"){
              document.forms['imageForm'].bgrepeat_x.checked=true;
              document.forms['imageForm'].bgrepeat_y.checked=true;
          }else if(selectedNode.style.backgroundRepeat=="repeat-x"){
              document.forms['imageForm'].bgrepeat_x.checked=true;
              document.forms['imageForm'].bgrepeat_y.checked=false;
          }else if(selectedNode.style.backgroundRepeat=="repeat-y"){
              document.forms['imageForm'].bgrepeat_x.checked=false;
              document.forms['imageForm'].bgrepeat_y.checked=true;
          }else if(selectedNode.style.backgroundRepeat=="no-repeat"){
              document.forms['imageForm'].bgrepeat_x.checked=false;
              document.forms['imageForm'].bgrepeat_y.checked=false;
          }
      }
  }
  updateImage();

  if(!document.forms['imageForm'].txtFileName.value){
     setMainImageField(document.forms['imageForm'].txtFileName);
     btnChoose(true);
  }
}

function _isValidNumber(txtBox) {
  var val = parseInt(txtBox);
  if (isNaN(val) || val < 0 || val > 999) { return false; }
  return true;
}


function btnNOClick(){
  document.forms['imageForm'].reset();
  mainImageField.value = "";
  setImage(tImage.src,0,0);
}

function btnClean(){
  document.forms['imageForm'].bgrepeat_x.checked = false;
  document.forms['imageForm'].bgrepeat_y.checked = false;
  mainImageField.value = "";
  setImage(tImage.src);
}


function btnOKClick(evt) {
  var elmImage;
  var intAlignment;

  if (mainImageField.value == "http://") {
    alert("%%specify_url%%");
    return;
  }

  var objname = "##obj_name##";
  var formWindow = top.currentParentWindow ? top.currentParentWindow : top;
  formWindow.makeUndoStep(objname, '%%un_bgimage%%');

  var imgURL;

    var selectedNode = editorObject.sessionData.selectedNode;
    if(selectedNode == null){
        var selectedNode = editorObject.sessionData.getEditorFirstSelectedItem;
    }

    do{
        var selectedNodeTag = '';
        if(selectedNode.tagName){
            selectedNodeTag = selectedNode.tagName.toLowerCase();
        }
        if(selectedNodeTag == 'body' || selectedNodeTag == 'table' || selectedNodeTag == 'tr' || selectedNodeTag == 'th' || selectedNodeTag == 'td' || selectedNodeTag == 'div'){
            break;
        }
    }while(selectedNode = selectedNode.parentNode);

  if (selectedNode){
    if (mainImageField.value == ""){
      selectedNode.style.backgroundImage = "";
      selectedNode.style.backgroundRepeat = "";
    }else{
      selectedNode.style.backgroundImage = 'url(' + mainImageField.value + ')';
        if (document.forms['imageForm'].bgrepeat_x.checked && document.forms['imageForm'].bgrepeat_y.checked){
          selectedNode.style.backgroundRepeat="repeat";
        }else if(document.forms['imageForm'].bgrepeat_x.checked == false && document.forms['imageForm'].bgrepeat_y.checked == false){
          selectedNode.style.backgroundRepeat="no-repeat";
        }else if(document.forms['imageForm'].bgrepeat_x.checked == false && document.forms['imageForm'].bgrepeat_y.checked == true){
          selectedNode.style.backgroundRepeat="repeat-y";
        }else if(document.forms['imageForm'].bgrepeat_x.checked == true && document.forms['imageForm'].bgrepeat_y.checked == false){
          selectedNode.style.backgroundRepeat="repeat-x";
        }
    }

    editorObject.formChanged(evt);
    editorObject.updateToolBar();
  }

  formWindow.editor_updateHiddenField (objname);
  closeDialogWindow();
}

"-->



<!--#set var="js_obj" value="
var editorObject = null;
var editorBaseHref;
var enablePopupProps = true;

var tImage = new Image();
tImage.src = '##no_image##';

var imageFields = new Array('txtFileName', 'txtPopupFileName', 'txtImageOver');

img_ext[img_ext.length]='swf';

function Init() {

  //showPopupProps(true);

  if (!mainImageField){
      mainImageField = document.getElementById(imageFields[0]);
  }

  document.forms['imageForm'].btnOK.onclick = btnOKClick;
  setAlignment(document.forms['imageForm'].selAlignment.value);

  var formWindow = top.currentParentWindow ? top.currentParentWindow : top;
  var textareaObject = formWindow.document.getElementById('##obj_name##');
  if(textareaObject && textareaObject.editorAttached){
      editorObject = textareaObject.editorObject;
  }

  var type = document.getElementById('preview_img').tagName.toLowerCase();
  var objname = "##obj_name##";
  formWindow.makeUndoStep(objname, '%%un_image%%');
  editorBaseHref = formWindow.editorBaseHref;

    ##--if (document.getElementById('preview_img').src != tImage.src){--##
    if (document.forms['imageForm'].txtFileName.value != ''){

        var ext = document.getElementById('preview_img').src.substr(document.getElementById('preview_img').src.length-3, document.getElementById('preview_img').src.length-1).toLowerCase();
        if (ext == 'swf'){
          var previewIMG = generateFlashHTML(document.getElementById('preview_img').src, 'high', '', '', 'preview_img', 'picture', document.forms['imageForm'].txtBorder.value, document.forms['imageForm'].selAlignment.value, document.forms['imageForm'].txtVertical.value, document.forms['imageForm'].txtHorizontal.value, document.forms['imageForm'].txtAltText.value  );
          document.getElementById("img_container").innerHTML = previewIMG;

          var previewIMG = generateFlashHTML(document.getElementById('preview_img').src, 'high', '', '', 'txtFileName_preview', 'picture', '0', '', '', '', '');
          document.getElementById("img_block_preview").innerHTML = previewIMG;

        }else{
          oDate = new Date();
          sDate = "?"+oDate.getYear()+oDate.getMonth()+oDate.getDay()+oDate.getHours()+oDate.getMinutes()+oDate.getSeconds();

          if(document.forms['imageForm'].txtFileName.value != ''){
            document.getElementById('txtFileName_preview').src = editorBaseHref + document.forms['imageForm'].txtFileName.value + sDate;
            document.getElementById('preview_img').src = document.getElementById('txtFileName_preview').src;
          }

          if(document.forms['imageForm'].txtPopupFileName.value != ''){
            document.getElementById('txtPopupFileName_preview').src = editorBaseHref + document.forms['imageForm'].txtPopupFileName.value + sDate;
            document.getElementById('preview_popup_img').src = document.getElementById('txtPopupFileName_preview').src;
          }

          if(document.forms['imageForm'].txtImageOver.value != ''){
            document.getElementById('txtImageOver_preview').src = editorBaseHref + document.forms['imageForm'].txtImageOver.value + sDate;
            document.getElementById('preview_over_img').src = document.getElementById('txtImageOver_preview').src;
          }
        }
    } else {
        var elmSelectedImage = editorObject.sessionData.selectedNode;
        if(typeof(elmSelectedImage) != 'undefined' && elmSelectedImage != null && typeof(elmSelectedImage.tagName) != 'undefined' && (elmSelectedImage.tagName.toLowerCase() == 'object' || elmSelectedImage.tagName.toLowerCase() == 'img' && (!elmSelectedImage.className || elmSelectedImage.className.substr(0, 15) != 'editorSpecBlock'))){
            //!!!if (elmSelectedImage.tagName.toLowerCase() == "img") {
            if (elmSelectedImage.src.substr(elmSelectedImage.src.length-3, elmSelectedImage.src.length-1).toLowerCase() != "swf") {
              if (elmSelectedImage.src) {
                mainImageField.value = elmSelectedImage.src.replace(editorBaseHref, "");  // fix placeholder src values that editor converted to abs paths
                var aSpaces = getElementSpaces(elmSelectedImage);
                document.forms['imageForm'].txtHorizontal.value        = aSpaces[0];
                document.forms['imageForm'].txtVertical.value          = aSpaces[1];
                document.forms['imageForm'].txtBorder.value            = elmSelectedImage.border;
                document.forms['imageForm'].txtAltText.value           = elmSelectedImage.alt;
                document.forms['imageForm'].txtTitleText.value         = elmSelectedImage.title;
                document.forms['imageForm'].txtHeaderText.value        = elmSelectedImage.getAttribute('data-ami-mbhdr') || '';
                document.forms['imageForm'].txtDescriptionTextInput.value   = elmSelectedImage.getAttribute('data-ami-mbdescr') || '';
                document.forms['imageForm'].txtGroupText.value         = elmSelectedImage.getAttribute('data-ami-mbgrp') || '';
                document.forms['imageForm'].txtLinkText.value          = elmSelectedImage.getAttribute('data-ami-mburl') || '';
                document.forms['imageForm'].txtLinkCaptionText.value   = elmSelectedImage.getAttribute('data-ami-mburlcapt') || '';


                document.getElementById(mainImageField.id + '_preview').src = elmSelectedImage.src;

                document.getElementById('preview_img').src            = elmSelectedImage.src;
                //document.getElementById('preview_img').height         = elmSelectedImage.height;
                //document.getElementById('preview_img').width          = elmSelectedImage.width;

                //document.getElementById('preview_img').style.height         = elmSelectedImage.style.height;
                //document.getElementById('preview_img').style.width          = elmSelectedImage.style.width;

                document.forms['imageForm'].txtHeight.value = (parseInt(elmSelectedImage.style.height)>0)?parseInt(elmSelectedImage.style.height):elmSelectedImage.height;
                document.forms['imageForm'].txtWidth.value  = (parseInt(elmSelectedImage.style.width)>0)?parseInt(elmSelectedImage.style.width):elmSelectedImage.width;

                var popupImage = elmSelectedImage.getAttribute('data-ami-mbpopup');
                if(popupImage != null && popupImage != ''){

                    document.forms['imageForm'].txtPopupFileName.value = popupImage;
                    if(popupImage.substr(popupImage.length-3, popupImage.length-1).toLowerCase() != "swf"){
                      document.getElementById('txtPopupFileName_preview').src = editorBaseHref + popupImage;
                      document.getElementById('preview_popup_img').src = editorBaseHref + popupImage;
                    }else{
                      var previewIMG = generateFlashHTML(editorBaseHref + popupImage, 'high', document.forms['imageForm'].txtPopupWidth.value, document.forms['imageForm'].txtPopupHeight.value, 'preview_popup_img', 'picture', '0', '', '', '', '');
                      document.getElementById("popup_img_container").innerHTML = previewIMG;

                      var previewIMG = generateFlashHTML(editorBaseHref + popupImage, 'high', document.forms['imageForm'].txtPopupWidth.value, document.forms['imageForm'].txtPopupHeight.value, 'txtPopupFileName_preview', 'picture', '0', '', '', '', '');
                      document.getElementById("popup_img_block_preview").innerHTML = previewIMG;

                      document.forms['imageForm'].txtPopupWidth.value = elmSelectedImage.getAttribute('data-ami-mbpopup-width') || '';
                      document.forms['imageForm'].txtPopupHeight.value = elmSelectedImage.getAttribute('data-ami-mbpopup-height') || '';
                    }

                }else{
                    document.getElementById('txtPopupFileName_preview').src = tImage.src;
                    enablePopupProps = false;
                }



                ##-- Next block is old scheme currently supported, should be removed in the future --##
                // Find parent link
                if(!enablePopupProps){
                    enablePopupProps = true;
                    var aText = 'none';
                    var pObj = elmSelectedImage.parentNode;
                    while(pObj){
                      if(pObj.tagName && pObj.tagName.toLowerCase() == "a"){
                          aText = fromHTMLToText(pObj.innerHTML);
                          aText.replace(/[ \r\n\t]/g, '');
                          break;
                      }
                      pObj = pObj.parentNode;
                    }
                    if(aText.length == 0){
			            if (pObj.href.substring(0, 23)=="javascript:show_picture"){
				            var sPopupImgParams = pObj.href.substring(24,pObj.href.length-2);
				            sPopupImgParams = sPopupImgParams.replace(/'/g,"");
				            var aPopupImgParams = sPopupImgParams.split(",");
				            document.forms['imageForm'].txtPopupFileName.value = aPopupImgParams[1];
				            document.forms['imageForm'].txtPopupWidth.value  = aPopupImgParams[3];
				            document.forms['imageForm'].txtPopupHeight.value = aPopupImgParams[4];
			            }else{
				            enablePopupProps = false;
			            }
                    }
                }

                var overImage = elmSelectedImage.getAttribute('data-ami-mbover') || '';

                if(overImage != '') {
                    document.forms['imageForm'].txtImageOver.value = overImage;
                    document.getElementById('txtImageOver_preview').src = editorBaseHref + elmSelectedImage.getAttribute('data-ami-mbover');
                    document.getElementById('preview_over_img').src = editorBaseHref + elmSelectedImage.getAttribute('data-ami-mbover');
                }else{
                    document.getElementById('txtImageOver_preview').src = tImage.src;
                }

                setAlignment(elmSelectedImage.align);
                //showPopupProps(true);
              }
            }else{
                movie_src = editorBaseHref+elmSelectedImage.getAttribute('movie');
                mainImageField.value           = movie_src.replace(editorBaseHref, "");  // fix placeholder src values that editor converted to abs paths
                var aSpaces = getElementSpaces(elmSelectedImage);
                document.forms['imageForm'].txtVertical.value           = aSpaces[1];
                document.forms['imageForm'].txtHorizontal.value         = aSpaces[0];
                document.forms['imageForm'].txtBorder.value             = elmSelectedImage.border;
                document.forms['imageForm'].txtAltText.value            = elmSelectedImage.alt;
                document.forms['imageForm'].txtTitleText.value          = elmSelectedImage.title;
                document.forms['imageForm'].txtHeaderText.value         = elmSelectedImage.getAttribute('data-ami-mbhdr') || '';
                document.forms['imageForm'].txtDescriptionTextInput.value    = elmSelectedImage.getAttribute('data-ami-mbdescr') || '';
                document.forms['imageForm'].txtGroupText.value          = elmSelectedImage.getAttribute('data-ami-mbgrp') || '';
                document.forms['imageForm'].txtLinkText.value           = elmSelectedImage.getAttribute('data-ami-mburl') || '';
                document.forms['imageForm'].txtLinkCaptionText.value    = elmSelectedImage.getAttribute('data-ami-mburlcapt') || '';

                setAlignment(elmSelectedImage.align);
                document.forms['imageForm'].txtHeight.value = (parseInt(elmSelectedImage.style.height)>0)?parseInt(elmSelectedImage.style.height):elmSelectedImage.height;
                document.forms['imageForm'].txtWidth.value  = (parseInt(elmSelectedImage.style.width)>0)?parseInt(elmSelectedImage.style.width):elmSelectedImage.width;

                var newWidth = document.forms['imageForm'].txtWidth.value;
                var newHeight = document.forms['imageForm'].txtHeight.value;
                var previewIMG = generateFlashHTML(movie_src, 'high', newWidth, newHeight, 'preview_img', 'picture', elmSelectedImage.border, elmSelectedImage.align, aSpaces[1], aSpaces[0], elmSelectedImage.alt   );
                document.getElementById('img_container').innerHTML = previewIMG;
            }
        }else{
            document.forms['imageForm'].txtGroupText.value = getDefaultGroupName();
        }
    }

  if (document.forms['imageForm'].txtImageOver.value != ''){
    switchBlock('img_over', true);
  }

  if (document.forms['imageForm'].txtPopupFileName.value != ''){
      switchBlock('popup_img_url', true);
  }

  if(document.forms['imageForm'].txtHeight.value == "0")
    document.forms['imageForm'].txtHeight.value = "";
  if (document.forms['imageForm'].txtWidth.value == "0")
    document.forms['imageForm'].txtWidth.value = "";


  popupImageSrc = document.forms['imageForm'].txtPopupFileName.value;

  if (popupImageSrc.substr(popupImageSrc.length-3, popupImageSrc.length-1).toLowerCase() == "swf"){
   makeElementVisible(document.getElementById("popup_props2"), 'block');
  }else{
   makeElementVisible(document.getElementById("popup_props2"), 'none');
  }


  top.amiSpin.addFields([
      document.forms['imageForm'].txtWidth,
      document.forms['imageForm'].txtHeight,
      document.forms['imageForm'].txtHorizontal,
      document.forms['imageForm'].txtVertical,
      document.forms['imageForm'].txtBorder,
      document.forms['imageForm'].txtPopupWidth,
      document.forms['imageForm'].txtPopupHeight
      ],
      10000, 0, 1, '', updateImage
  );

  //btnChoose((document.forms['pagersform'].browse_open.value=='1') ? true : false);
  if((document.forms['pagersform'].main_field.value != '') && typeof(document.getElementById(document.forms['pagersform'].main_field.value)=='object')){
      mainImageField = document.getElementById(document.forms['pagersform'].main_field.value);
  }

  updateImage();

  if(!document.forms['imageForm'].txtFileName.value){
     setMainImageField(document.forms['imageForm'].txtFileName);
     btnChoose(true);
  }
}

function _isValidNumber(txtBox) {
  var val = parseInt(txtBox);
  if (isNaN(val) || val < 0 || val > 999) { return false; }
  return true;
}

function btnClean(){
  //document.forms['imageForm'].reset();
  if (mainImageField.id == 'txtFileName'){
    document.forms['imageForm'].txtWidth.value='';
    document.forms['imageForm'].txtHeight.value='';
    document.forms['imageForm'].txtHorizontal.value='';
    document.forms['imageForm'].txtVertical.value='';
    document.forms['imageForm'].txtBorder.value='';
    document.forms['imageForm'].txtAltText.value='';
    document.forms['imageForm'].txtTitleText.value='';
    setAlignment('');
    document.getElementById('sample_text').style.display="none";

  }else if (mainImageField.id == 'txtPopupFileName'){
    document.forms['imageForm'].txtPopupWidth.value='';
    document.forms['imageForm'].txtPopupHeight.value='';
    document.forms['imageForm'].txtHeaderText.value='';
    document.forms['imageForm'].txtGroupText.value='';
    document.forms['imageForm'].txtLinkText.value='';
    document.forms['imageForm'].txtLinkCaptionText.value='';
    document.forms['imageForm'].txtDescriptionTextInput.value='';
    document.forms['imageForm'].txtDescriptionTextTextarea.value='';
  }else if (mainImageField.id == 'txtOverImage'){

  }

  mainImageField.value = "";
  setImage(tImage.src);
}

function btnOKClick(evt) {
    var elmImage;
    var intAlignment;
##--
    if(!document.forms['imageForm'].txtFileName.value || document.forms['imageForm'].txtFileName.value == "http://") {
        alert("%%specify_url%%");
        return;
    }
    if(document.forms['imageForm'].txtHorizontal.value && !_isValidNumber(document.forms['imageForm'].txtHorizontal.value)){
        alert("%%specify_hs%%");
        return;
    }
    if(document.forms['imageForm'].txtBorder.value && !_isValidNumber(document.forms['imageForm'].txtBorder.value)){
        alert("%%specify_thick%%");
        return;
    }
    if(document.forms['imageForm'].txtVertical.value && !_isValidNumber(document.forms['imageForm'].txtVertical.value)){
        alert("%%specify_vs%%");
        return;
    }
--##

    var formWindow = top.currentParentWindow ? top.currentParentWindow : top;
    var objImg = document.getElementById('preview_img');
    var type = objImg == null ? document.getElementById('preview_img').tagName.toLowerCase() : objImg.tagName.toLowerCase();
    var objname = "##obj_name##";
    formWindow.makeUndoStep(objname, '%%un_image%%');

    var doUpdateImage = false;
    var selectedNode = editorObject.sessionData.selectedNode;
    if(typeof(selectedNode) != 'undefined' && selectedNode != null && typeof(selectedNode.tagName) != 'undefined'){
        if(selectedNode.tagName.toLowerCase() == 'object' || selectedNode.tagName.toLowerCase() == 'img' && (!selectedNode.className || selectedNode.className.substr(0, 15) != 'editorSpecBlock')){
            var doUpdateImage = true;
        }
    }

    editorObject.setEditorSelection(editorObject.sessionData.rng);

    if(doUpdateImage){
        elmImage = selectedNode;
        if (elmImage.src.replace(editorBaseHref, "") != document.forms['imageForm'].txtFileName.value){
            elmImage.removeAttribute("src");
        }
    }else{
        editorObject.insertContent('<img id="htmlEditorInsertImage">');
        elmImage = editorObject.editorDocument.getElementById('htmlEditorInsertImage');
        elmImage.removeAttribute("id");
    }

    //alert(type);

    if(type == 'img'){
        if (document.forms['imageForm'].txtFileName.value.length > 2040){
            document.forms['imageForm'].txtFileName.value = document.forms['imageForm'].txtFileName.value.substring(0,2040);
        }

        elmImage.src = document.forms['imageForm'].txtFileName.value;
        elmImage.alt = document.forms['imageForm'].txtAltText.value;
        elmImage.title = document.forms['imageForm'].txtTitleText.value;

        setImageAttribute(elmImage, 'data-ami-mbhdr', document.forms['imageForm'].txtHeaderText.value);
        setImageAttribute(elmImage, 'data-ami-mbdescr', document.forms['imageForm'].txtDescriptionTextInput.style.display != 'none' ? document.forms['imageForm'].txtDescriptionTextInput.value : document.forms['imageForm'].txtDescriptionTextTextarea.value);
        setImageAttribute(elmImage, 'data-ami-mbgrp', document.forms['imageForm'].txtGroupText.value);
        setImageAttribute(elmImage, 'data-ami-mburl', document.forms['imageForm'].txtLinkText.value);
        setImageAttribute(elmImage, 'data-ami-mburlcapt', document.forms['imageForm'].txtLinkCaptionText.value);

        if(parseInt(document.forms['imageForm'].txtWidth.value) > 0){
          elmImage.style.width = document.forms['imageForm'].txtWidth.value + 'px';
          elmImage.width = document.forms['imageForm'].txtWidth.value;//document.getElementById('preview_img').width;
        }

        if(parseInt(document.forms['imageForm'].txtHeight.value) > 0){
          elmImage.style.height = document.forms['imageForm'].txtHeight.value + 'px';
          elmImage.height = document.forms['imageForm'].txtHeight.value;//document.getElementById('preview_img').height;
        }

        elmImage.removeAttribute("vspace");
        elmImage.removeAttribute("hspace");
        if (document.forms['imageForm'].txtHorizontal.value > ""){
            elmImage.style.marginRight = elmImage.style.marginLeft = document.forms['imageForm'].txtHorizontal.value + 'px';
        }else{
            removeStyleProperty(elmImage, 'marginLeft');
            removeStyleProperty(elmImage, 'marginRight');
        }
        if (document.forms['imageForm'].txtVertical.value > ""){
            elmImage.style.marginBottom = elmImage.style.marginTop = document.forms['imageForm'].txtVertical.value + 'px';
        }else{
            removeStyleProperty(elmImage, 'marginTop');
            removeStyleProperty(elmImage, 'marginBottom');
        }
        if (document.forms['imageForm'].txtBorder.value > ""){
            elmImage.border = document.forms['imageForm'].txtBorder.value;
        }else{
            elmImage.removeAttribute("border");
        }

        elmImage.align = document.forms['imageForm'].selAlignment.value;

        if (document.forms['imageForm'].txtPopupFileName.value.length > 0){
          elmImage.setAttribute('data-ami-mbpopup', document.forms['imageForm'].txtPopupFileName.value);
          /* // Required for swf popup only
          setImageAttribute(elmImage, 'data-ami-mbpopup-width', document.forms['imageForm'].txtPopupWidth.value);
          setImageAttribute(elmImage, 'data-ami-mbpopup-height', document.forms['imageForm'].txtPopupHeight.value);
          */
        }else{
          elmImage.removeAttribute('data-ami-mbpopup');
          elmImage.removeAttribute('data-ami-mbpopup-width');
          elmImage.removeAttribute('data-ami-mbpopup-height');
        }

        setImageAttribute(elmImage, 'data-ami-mbover', document.forms['imageForm'].txtImageOver.value);
    }else{
        editorObject.setEditorSelection(editorObject.sessionData.rng);
        editorObject.insertFLASHContent(generateFlashHTML(mainImageField.value, "high",document.forms['imageForm'].txtWidth.value,document.forms['imageForm'].txtHeight.value, '', '',document.forms['imageForm'].txtBorder.value, document.forms['imageForm'].selAlignment.value, document.forms['imageForm'].txtVertical.value, document.forms['imageForm'].txtHorizontal.value, document.forms['imageForm'].txtAltText.value));
        elmImage.parentNode.removeChild(elmImage);
    }

  editorObject.formChanged(evt);
  editorObject.updateToolBar();

  formWindow.editor_updateHiddenField (objname);
  closeDialogWindow();
}

"-->



<!--#set var="img_header" value=""-->

<!--#set var="txt_header" value="
<td class="first_row_left_td list_name_col">%%name%%</td>
<td class="first_row_all" align=right>%%resolution%%</td>
<td class="first_row_all" align=right>%%fsize%%</td>
<td class="first_row_all" align=right>%%action%%</td>
</tr><tr>
"-->

<!--#set var="filter" value="
<script type="text/javascript">
function filterSubmit(){

  var oForm = document.forms['imagesListForm'];
  prepareFormFields(oForm);
  oForm.action.value = 'search';
  oForm.browse_open.value = document.forms['pagersform'].browse_open.value;
  oForm.mode.value = document.forms['pagersform'].mode.value;
  oForm.set_cat.value = document.forms['pagersform'].set_cat.value;
  oForm.flt_name.value = document.getElementById('flt_name1').value;
  oForm.submit();

}
</script>
%%search%%: <input type="text" name="flt_name1" id="flt_name1" class="field field20"  value="##flt_name##" onkeydown="if (event.keyCode==13){filterSubmit(); amiCommon.stopEvent(amiCommon.getValidEvent(event));} ">&nbsp;<span style="cursor:pointer" onclick="javascript:filterSubmit();">&#8629</span>
"-->


<!--#set var="preload_item" value="
var img_##num## = new Image; img_##num##.src = '##img_src##';
"-->


<!--#set var="icons_splitter" value="
##--</tr><tr>--##
"-->


<!--#set var="icons_item" value="
##--<td class="ce_images" bgcolor="#FFFFFF" valign="bottom" align="center" width=50%>--##
<div class="icon_item">
<div class="icon_item_img_block" id="##set_img_src##" onclick="if(onSetImage(this.id, ##width##, ##height##)){##if(imagetape==1)##if(mainImageField.value==''){switchBlock('popup_img_url');}##endif## mainImageField.value=##onclick##;}"><img src="##IF(img_type!='')##images/mtype-##img_type##.png##else####img_src####endif##" width="##src_width##" height="##src_height##" border="0"></div>
<input type=checkbox name=files[] value="##img_name##" ##checked##>
<div title="##img_name##" class="icon_name"><nobr>##img_name_short##</nobr></div>
##width## %%size_splitter%% ##height##<br>
##size## ##size_post##<br>
</div>
##--</td>--##
"-->

<!--#set var="list_splitter" value="
"-->

<!--#set var="list_item" value="
<tr bgcolor="##bgcolor##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)">
<td>
<input type=checkbox name=files[] value="##img_name##" ##checked## id="chk_img_##set_img_src##">
</td>
<td align="left" id="##set_img_src##" style="font-size:13px;cursor:pointer;" onclick="if(onSetImage(this.id, ##width##, ##height##)){##if(imagetape==1)##if(mainImageField.value==''){switchBlock('popup_img_url');}##endif## mainImageField.value=##onclick##;}" title="##img_name## ##width## %%size_splitter%% ##height## ( ##size## ##size_post## )"
##--onmouseover="top.AMI.UI.ToolTip(event, '<img src=\'##set_img_src##\'>', ##width##, ##height##);"--##>##img_name_short##</td>
<td align="right" nowrap>
&nbsp;##width## %%size_splitter%% ##height##&nbsp;
</td>
<td align="right" nowrap>
&nbsp;##size## ##size_post##&nbsp;
</td>
</tr>
"-->


<!--#set var="images_list" value="
    ##setglobalvar @browse_mode=browse_mode##
    <script type="text/javascript">
    function checkImageList(source){
        var div = document.getElementById('itemsBlock');
        var chboxes = div.getElementsByTagName('input');
        var cblen = chboxes.length;

        for(var i = 0; i < cblen; i++){
            if(chboxes[i].type === 'checkbox'){
                chboxes[i].checked = source.checked;
            }
        }
    }
    </script>
    <div style="padding:10px 3px 5px 3px;width:100%;">
      <div style="float:left;"><input type=checkbox name='select_all' value="1" onClick="checkImageList(this);"></div>
      <div style="float:rigth;text-align:right;">##pager##</div>
    </div>
    <div id="itemsBlock" style="overflow:auto;">
      <table border="0" width="100%" cellspacing="0" cellpadding="2">
        ##images##
      </table>
    </div>
"-->

<!--#set var="images_list_empty" value="
    ##setglobalvar @browse_mode=browse_mode##
    <div id="itemsBlock" style="overflow:auto;padding:3px;">
    <h3>%%list_empty%%</h3>
    </div>
"-->


<!--#set var="browse_mode" value="<a href="javascript:onMode('##mode##');"><img src="skins/vanilla/icons/mode_##mode##.gif" width=21 height=20 border=0 title=##mode_descr## style="border:1px #ffffff solid" align=absmiddle></a>"-->
<!--#set var="browse_mode_active" value="<img src="skins/vanilla/icons/mode_##mode##.gif" width=21 height=20 border=0 title=##mode_descr## style="border:1px #004080 solid" align=absmiddle>"-->
<!--#set var="browse_mode_splitter" value="&nbsp;&nbsp;&nbsp;"-->


<!--#set var="dir_item" value="
##setglobalvar @dir_select = dir_select."<option value='" . path . "'>" . name ."</option>"##

<tr bgcolor="##bgcolor##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)">
<td onclick="javascript:changeDir('##path##');" style="cursor:pointer;"><img src="skins/vanilla/icons/folder_small.gif" width=21 height=15 align=absmiddle border=0></td>
<td nowrap style="font-size:13px;cursor:pointer;" onclick="javascript:changeDir('##path##');">##name##&nbsp;</td>
<td class="td_small_text" width=100% onclick="javascript:changeDir('##path##');" style="cursor:pointer;">##descr##</td>
<td><a href="#" onclick="javascript:deleteDir('##path##','##name##'); return false;" title="%%folder_delete%%"><img src="skins/vanilla/icons/folder_delete.gif" width=21 height=15 align=absmiddle border=0></a></td>
<td nowrap>&nbsp;<a href="#" onclick="javascript:moveToDir('##path##','##name##'); return false;" title="%%move_images%%"><img src="skins/vanilla/icons/images_move.gif" width=21 height=15 align=absmiddle border=0></a>&nbsp;</td>
</tr>"-->

<!--#set var="dir_item_sel" value="
##setglobalvar @dir_select = dir_select."<option value='" . path . "' selected style='font-weight:bold'>" . name ."</option>"##
<tr id=open_folder style="background-color:#FFEAC4" bgcolor="##bgcolor##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)">
<td><img src="skins/vanilla/icons/folder_open_small.gif" width=21 height=15 align=absmiddle border=0></td>
<td nowrap style="font-size:13px;"><b>##name##</b>&nbsp;</td>
<td class="td_small_text" width=100%>##descr##</td>
<td><a href="#" onclick="javascript:deleteDir('##path##','##name##'); return false;" title="%%folder_delete%%"><img src="skins/vanilla/icons/folder_delete.gif" width=21 height=15 align=absmiddle border=0></a></td>
<td>##--<img src="skins/vanilla/icons/images_move_na.gif" width=21 height=15 align=absmiddle border=0>--##</td>
</tr>"-->

<!--#set var="self_url" value="ce_img_proc.php?##obj_type##=##obj_name##&mode=##mode##&cat=##cat##&fld=##fld_name##&obj_mode=##obj_mode##&offset=##pager_offset##&limit=##pager_limit##&lang=##admin_lang##&module=##module##&imagetape=##imagetape##"-->

<!--#set var="server_images" value="
    <form action="##self_url##" name=imagesListForm method="POST" onsubmit="return false;" style="margin:0">
    <input type="hidden" name="flt_name" value="##flt_name##">

    <input type="hidden" name="browse_open" value="##browse_open##">
    <input type="hidden" name="main_field" value="##main_image##">
    <input type="hidden" name="mode" value="##mode##">

    <input type="hidden" name="delete_cat" value="">
    <input type="hidden" name="create_cat" value="">
    <input type="hidden" name="action" value="">
    <input type="hidden" name="set_cat" value="##cat##">

    <input type="hidden" name="txtFileName" value="">
    <input type="hidden" name="txtWidth" value="">
    <input type="hidden" name="txtHeight" value="">
    <input type="hidden" name="txtHorizontal" value="">
    <input type="hidden" name="txtVertical" value="">
    <input type="hidden" name="txtBorder" value="">
    <input type="hidden" name="txtAltText" value="">
    <input type="hidden" name="txtTitleText" value="">
    <input type="hidden" name="txtPopupFileName" value="">
    <input type="hidden" name="txtPopupWidth" value="">
    <input type="hidden" name="txtPopupHeight" value="">
    <input type="hidden" name="txtHeaderText" value="">
    <input type="hidden" name="txtGroupText" value="">
    <input type="hidden" name="txtLinkText" value="">
    <input type="hidden" name="txtLinkCaptionText" value="">
    <input type="hidden" name="txtDescriptionTextInput" value="">
    <input type="hidden" name="txtDescriptionTextTextarea" value="">
    <input type="hidden" name="txtImageOver" value="">
    <input type="hidden" name="bgrepeat_x" value="">
    <input type="hidden" name="bgrepeat_y" value="">
    <input type="hidden" name="selAlignment" value="">


    <table width=100% cellspacing=0 cellpadding=0 border=0>
    <tr>
      <td align=left vAlign="top" width=35% style="padding-right:10px;border-right:1px #BDB4A2 solid;">
        <div style="padding-top: 10px; padding-bottom:10px;border-bottom:1px #BDB4A2 solid;line-height:24px;height:24px;">
        ##--<img src="skins/vanilla/icons/new_folder.gif" width=21 height=15 align=absmiddle border=0>&nbsp;--##
        %%new_folder%%: <input type=text class=field name=new_cat value="" onkeydown="if (event.keyCode==13) {createDir();return false;} ">&nbsp;<span style="cursor:pointer" onclick="javascript:createDir();">&#8629</span>
        </div>
        <table cellspacing=0 cellpadding=0 border=0 width=100%>
        <tr><td valign=top >
          <div style="overflow:auto;" id=folder_block>
            <table cellspacing=0 cellpadding=3 border=0 width=100%>
              ##dir_items##
            </table>
          </div>
        </td></tr>
        </table>
      </td>
      <td align=left vAlign="top" style="padding-right:5px;padding-left:10px;">
        <div style="padding-top: 10px; padding-bottom: 10px;line-height:24px;padding-left:5px;border-bottom:1px #BDB4A2 solid;">

        ##filter##
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        ##browse_mode##
        &nbsp;
        <a href="javascript:void(0)" onclick="onRefresh();return false;"><img src="skins/vanilla/icons/icon_refresh.gif" width=21 height=20 border=0 title="%%refresh%%" style="border:1px #ffffff solid" align=absmiddle></a>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:onDelete()"><img src="skins/vanilla/icons/images_delete.gif" width=21 height=20 border=0 title="%%delete%%" style="border:1px #ffffff solid" align=absmiddle></a>
        <div class="text_button img" style="margin-left: 50px;" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnUpload(true)">%%upload%%</div>
        </div>
        ##images_list##
      </td>
    </tr>
    </table>
    </form>

    <script type="text/javascript">UpdateImageField();</script>
"-->

<!--#set var="form_imagetape" value="

##setglobalvar @imagetape=1##

##setglobalvar @curr_img=curr_img##
##setglobalvar @curr_preview_width=curr_preview_width##
##setglobalvar @curr_preview_height=curr_preview_height##

<form action="##self_url##" name=imageForm enctype="multipart/form-data" method="POST" onsubmit="return false;" style="margin:0">

<div id="header_img_url" class="smalltab-header-simple" style="cursor:default;">
  <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rbr-c"></div>
  %%img_url%%
</div>
<div id="block_img_url" style="min-width:700px;">
<table border="0" cellpadding="0" cellspacing="5" width=100%>
  <tr>
    <td style="width:150px; min-width:150px;" valign=top>
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnChoose(true)">%%choose%%</div><br>
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnUpload(true)">%%upload%%</div><br>
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnClean();">%%clean%%</div>
    </td>
    <td style="width:120px; min-width:120px;">
      <div id="img_block_preview" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnChoose(true)" title="%%choose%%">
        <img src="##txtFileName_img_url##" id="txtFileName_preview">
      </div>
    </td>
    <td valign=top>
      <table border="0" cellpadding="0" cellspacing="3" width=100% style="margin-top:-3px;">
      <tr>
        <td id=lbl_txtFileName>%%img_url_path%%:</td>
        <td nowrap><INPUT ID=txtFileName name=txtFileName type=text class=field tabIndex=10 value="##txtFileName##" onfocus="this.select();" style="width:100%;" onchange="setMainImageField(document.forms['imageForm'].txtFileName);setImage();"></td>
      </tr>
      <tr id="image_alt_text">
        <td nowrap>%%alt_text%%:<sup title="%%alt_title%%">[?]</sup></td>
        <td><INPUT type=text class=field ID=txtAltText name=txtAltText tabIndex=15 style="width:100%;" value="##txtAltText##"></td>
      </tr>
      <tr id="image_title_text">
        <td nowrap>%%title_text%%:<sup title="%%title_title%%">[?]</sup></td>
        <td><INPUT type=text class=field ID=txtTitleText name=txtTitleText tabIndex=15 style="width:100%;" value="##txtTitleText##"></td>
      </tr>
      </table>
    </td>
  </tr>  
</table>
</div>

<div id="header_popup_img_url" class="smalltab-header" onclick="switchBlock('popup_img_url')">
  <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rbr-c"></div>
  %%popup_img_url%%
</div>

<div id="block_popup_img_url">

<table border="0" cellpadding="0" cellspacing="5" width=100%>
  <tr>
    <td style="width:150px; min-width:150px;" valign=top>
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtPopupFileName);btnChoose(true)">%%choose%%</div><br>
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtPopupFileName);btnUpload(true)">%%upload%%</div><br>
      <div class="text_button img" onclick="setMainImageField(document.forms['imageForm'].txtPopupFileName);btnClean()">%%clean%%</div>
    </td>
    <td style="width:120px" valign="top">
      <div id="popup_img_block_preview" onclick="setMainImageField(document.forms['imageForm'].txtPopupFileName);btnChoose(true)" title="%%choose%%">
        <img src="##txtPopupFileName_img_url##" id="txtPopupFileName_preview">
      </div>
    </td>
    <td valign=top>
      <table border="0" cellpadding="0" cellspacing="3" width=100% style="margin-top:-3px;">
        <tr id="popup_props1">
          <td id=lbl_txtPopupFileName>%%img_url_path%%:</td>
          <td><INPUT ID=txtPopupFileName name=txtPopupFileName type=text class=field tabIndex=10 value="##txtPopupFileName##" onfocus="this.select();" style="width:100%;"></td>
        </tr>
        <tr id="imageHeader">
          <td>%%header_text%%:<sup title="%%header_title%%">[?]</sup></td>
          <td><INPUT type=text class=field ID="txtHeaderText" name="txtHeaderText" tabIndex=15 style="width:100%" value="##txtHeaderText##"></td>
        </tr>
        <tr id="imageLink1">
          <td >%%link_text%%:<sup title="%%link_note%%">[?]</sup></td>
          <td nowrap>
              <INPUT type=text class=field ID="txtLinkText" name="txtLinkText" tabIndex=15  style="width:100%" value="##txtLinkText##">
          </td>
        </tr>
        <tr id="imageLink2">
          <td nowrap>%%link_caption%%:<sup title="%%link_note%%">[?]</sup></td>
          <td nowrap>
              <INPUT type=text class=field ID="txtLinkCaptionText" name="txtLinkCaptionText" tabIndex=15 style="width:100%" value="##txtLinkCaptionText##">
          </td>
        </tr>
        <tr id="imageDescription">
            <td>%%description_text%%:<sup title="%%description_title%%">[?]</sup></td>
            <td colspan=2>
                <INPUT type=text class=field id="txtDescriptionTextInput" name="txtDescriptionTextInput" tabIndex=15  onfocus="expandDescriptionControl(false, true);" onkeyup="expandDescriptionControl(true, true);" onmouseup="expandDescriptionControl(true, true);" onchange="expandDescriptionControl(false, false);" style="width: 100%" value="##txtDescriptionTextInput##">
                <textarea class=field id="txtDescriptionTextTextarea" name="txtDescriptionTextTextarea" tabIndex=15  onfocus="expandDescriptionControl(false, true);" onkeyup="expandDescriptionControl(true, true);" onmouseup="expandDescriptionControl(true, true);" onchange="expandDescriptionControl(false, false);" style="width: 100%; height: 42px; display: none; margin-left:2px;" disabled="disabled">##txtDescriptionTextInput##</textarea>
            </td>
        </tr>
      </table>
    </td>
  </tr> 
</table>
</div>

<div style="text-align:right">
    <input class="but" ID=btnOK  type=submit tabIndex=50 value="%%ok_btn%%">
    &nbsp;
    <input class="but" ID=btnCancel type="button" tabIndex=55 onClick="closeDialogWindow()" value="%%cancel_btn%%">
</div>

</form>
"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - %%title%%</TITLE>
##styles##
<style>
.main-form TABLE[ccc="1"] {width:100%}

SUP {cursor:default;color:#183264;}

#img_align_set IMG{
  border:2px #fff solid;
}


#main_block{
  position: relative;
  height:100%;
}

#shadow_block{
  display:none;
  position:fixed;
  left:0px;
  top:0px;
  width:100%;
  height:100%;
  height:100%;
  background:#000;
  -moz-pacity:0.3;
  -webkit-pacity:0.3;
  opacity:0.3;
  filter: alpha(opacity=30);
}

#upload_block{
  display: none;
  position: fixed;
  width: 400px;
  top:10%;
  left:30%;
  background: #fff;
  border: 2px #d0d0d0 solid;
  -moz-box-shadow: 0px 0px 15px 3px #000;
  -webkit-box-shadow: 0px 0px 15px 3px #000;
  box-shadow: 0px 0px 15px 3px #000;
  padding: 10px;
  z-index:1001;
}

#server_block{
  display: none;
  position: fixed;
  top: 25px;
  left: 5%;
  width: 90%;
  background: #fff;
  border: 1px solid #FFE0A7;
  padding: 10px;
  z-index:1000;
}

.popup_block_close{
  position:absolute;
  right:5px;
  top:3px;
  cursor:default;
  -moz-pacity:0.8;
  -webkit-pacity:0.8;
  opacity:0.8;
  filter: alpha(opacity=80);
}

.popup_block_close:hover{
  -moz-pacity:1;
  -webkit-pacity:1;
  opacity:1;
  filter: alpha(opacity=100);
}


#block_img_url, #block_popup_img_url, #block_img_over{
  padding:10px;
  background:#f0f0f0;
  -moz-border-radius: 0px 10px 10px 10px;
  -webkit-border-radius: 0px 10px 10px 10px;
  border-radius: 0px 10px 10px 10px;
  margin: 0px 0px 10px 0px;
}

#block_popup_img_url, #block_img_over{
  overflow: hidden;
  padding: 0;
  display: none;
}

#block_popup_img_url table,  #block_img_over table {
    padding: 10px;
}

#img_block_preview, #popup_img_block_preview, #img_over_block_preview{
  margin: 0px 10px 0px 10px;
  width:100px;
  height:100px;
  overflow:hidden;
  -moz-box-shadow: 0px 0px 5px 1px #666;
  -webkit-box-shadow: 0px 0px 5px 1px #666;
  box-shadow: 0px 0px 5px 1px #666;
  background:#fff;
  cursor: pointer;
  background: url(images/bg-opacity.png);
}

#img_block_preview:hover, #popup_img_block_preview:hover, #img_over_block_preview:hover{
  -moz-box-shadow: 0px 0px 5px 2px #66f;
  -webkit-box-shadow: 0px 0px 5px 2px #66f;
  box-shadow: 0px 0px 5px 2px #66f;
}


#img_block_preview IMG, #img_block_preview OBJECT, #img_block_preview EMBED,
#popup_img_block_preview IMG, #popup_img_block_preview OBJECT, #popup_img_block_preview EMBED,
#img_over_block_preview IMG{
  max-width:100px;
  max-height:100px;
  margin:0px;
  padding:0px;
}

#preview_popup_img_mark{
  position:absolute;
  left:-23px;
  bottom:-23px;
  width:27px!important;
  height:27px;
}

#preview_over_img_mark{
  position:absolute;
  left:-50px;
  top:40%;
  width:27px!important;
  height:27px;
}

#preview_block{
  position:relative;
  overflow:auto;
  height:100%;
  min-height:500px;
  border:1px #C7C7C7 solid;
  color:#666666;
  margin: 0px 0px 10px 0px;
  padding: 10px;
  -moz-border-radius: 10px 0px 0px 10px;
  -webkit-border-radius: 10px 0px 0px 10px;
  border-radius: 10px 0px 0px 10px;
}

#img_container, #popup_img_container, #over_img_container{
  cursor: pointer;
}

#img_container{
  max-width:30%;
  background:#fff;
  position:relative;
/*
  position:absolute;
  top:250px;
  left:10px;
*/
  padding:5px;
  border: 3px #ddd solid;
  margin-right:10px;
}

#img_container:hover{
  border: 3px #aaf solid;
}


#img_container IMG{
}

#img_container OBJECT, #img_container EMBED{
  margin:0px;
  width:100%;
  padding:0px;
}

#popup_img_container OBJECT, #popup_img_container EMBED{
  margin:0px;
  width:100%;
  padding:0px;
}

#popup_img_container{
  width:45%;
  max-height:50%;
  background:#fff;
  position:relative;
  left:36%;
  margin:20px 0px 20px 0px;
  /*
  top:10px;
  left:28%;
  */
  padding:5px;
  display:none;
  -moz-box-shadow: 0px 0px 10px 1px #666;
  -webkit-box-shadow: 0px 0px 10px 1px #666;
  box-shadow: 0px 0px 10px 1px #666;

}

#popup_img_container:hover{
  -moz-box-shadow: 0px 0px 10px 2px #66f;
  -webkit-box-shadow: 0px 0px 10px 2px #66f;
  box-shadow: 0px 0px 10px 2px #66f;
}

#popup_img_container IMG{
  width:100%;
}

#over_img_container{
  width:35%;
  background:#fff;
  position: absolute;
  top:20px;
  left:46%;
  padding:5px;
  display:none;
  -moz-box-shadow: 0px 0px 3px 1px #666;
  -webkit-box-shadow: 0px 0px 3px 1px #666;
  box-shadow: 0px 0px 3px 1px #666;
}

#over_img_container:hover{
  -moz-box-shadow: 0px 0px 3px 2px #66f;
  -webkit-box-shadow: 0px 0px 3px 2px #66f;
  box-shadow: 0px 0px 3px 2px #66f;
}


#over_img_container IMG{
  width:100%;
}


#upload_progress{
  height:100%;
  width:100%;
  position:absolute;
  -moz-pacity:0.8;
  -webkit-pacity:0.8;
  opacity:0.8;
  filter: alpha(opacity=80);
  top:0;
  left:0;
  background:#fff;
  text-align:center;
  display:none;
}

#upload_progress IMG{
  position:relative;
  -moz-opacity:1;
  -webkit-opacity:1;
  opacity:1;
  filter: alpha(opacity=100);
}

.img{
  font-size:12px;
  margin-bottom:9px;
  text-transform:lowercase;
  display:inline-block;
}

.icon_item{
  width: 100px;
  height:160px;
  float:left;
  text-align:center;
  padding:10px;
  /*overflow:hidden;*/
}

.icon_name{
  width:100px;
  overflow:hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}

.icon_item_img_block{
  width:100px;
  height:100px;
  -moz-box-shadow: 0px 0px 5px 1px #666;
  -webkit-box-shadow: 0px 0px 5px 1px #666;
  box-shadow: 0px 0px 5px 1px #666;
  background:#fff;
  margin: 0px 0px 5px 0px;
  cursor:pointer;
  background: url(images/bg-opacity.png);

}

.icon_item_img_block:hover{
  -moz-box-shadow: 0px 0px 5px 2px #66f;
  -webkit-box-shadow: 0px 0px 5px 2px #66f;
  box-shadow: 0px 0px 5px 2px #66f;
}

.smalltab-header, .smalltab-header-active, .smalltab-header-simple {
width:250px;
}

.status-block {
  -moz-border-radius: 10px;
  -webkit-border-radius: 10px;
  border-radius: 10px;
  margin:10px;
}

#size-control-btn {
    display: inline-block;
    width: 16px;
    height: 14px;
    position: relative;
    top: 2px;
}

#default-size-images {
    display: none;
    background: url(skins/vanilla/icons/imgsize.png) no-repeat;
    width: 14px;
    height: 14px;
    top: 3px;
    position: relative;
    right: 4px;
    float: right;
}

#image-size-parametrs {
    float: right;
}

#size-control-btn:hover, #default-size-images:hover {
    opacity: 0.6;
}

#size-control-btn:active, #default-size-images:active {
    opacity: 1;
}

.size-control-btn-selected {
    background: url(skins/vanilla/icons/chain.png) no-repeat;
}

.size-control-btn {
    background: url(skins/vanilla/icons/chain.png) no-repeat -16px 0;
}

</style>
<script type="text/javascript">
var editorBaseHref = '##root_path_www##';
</script>
##scripts##
<script type="text/javascript">

var maxFilesToUpload = 10;

var mainImageField;

##images_preload##

function setMainImageField(mainField){
  if (mainImageField && (mainImageField.id == mainField.id)){
		return;
  }
  mainImageField = mainField;
  for (i=0;i<imageFields.length;i++){
    clearRuntimeStyle(document.getElementById(imageFields[i]));
    clearRuntimeStyle(document.getElementById('lbl_' + imageFields[i]));
  }
  //setRuntimeStyle(mainImageField, 'border', '1px solid #b90000');
  //setRuntimeStyle(document.getElementById('lbl_'+mainImageField.id), 'fontWeight', 'bold');
  if (document.getElementById('sample_text')){
    document.getElementById('sample_text').style.display="none";
  }
  if (mainField.value.length > 0){
    //setImage();
  }
}

function checkResizeOptions(){
  var oForm = document.uploadForm;
  var bChecked = false;
  for (var i=0; i<oForm.elements.length; i++){
    if (oForm.elements[i].name.substr(0,6)=="resize"){
      bChecked = bChecked | oForm.elements[i].checked;
    }
  }
  var bEnteredW = false;
  var bEnteredW = false;
  if (oForm.elements["custom_height"]){
    bEnteredW = (oForm.elements["custom_width"].value.length>0);
    bEnteredH = (oForm.elements["custom_height"].value.length>0);
  }
  oForm.elements["delete_orig"].disabled = !(bChecked | bEnteredW | bEnteredH);
  oForm.elements["keep_ratio"].disabled = !(bChecked | (bEnteredW & bEnteredH));
}

function flipBlockData(blockName){
    var obj = document.getElementById(blockName);
    var obj2 = document.getElementById(blockName+'Img');
    if(obj != null){
        var currentBlockVisibility = obj.style.display;
        if(currentBlockVisibility == 'block'){
            obj.style.display = 'none';
            if(obj2 != null){
                obj2.src='skins/vanilla/images/icon_switch_down.gif';
            }
        }else{
            obj.style.display = 'block';
            if(obj2 != null){
                obj2.src='skins/vanilla/images/icon_switch_up.gif';
            }
        }
    }
}

function checkWatermarkSource(obj){
    if(obj.value != ''){
        document.getElementById('watermark_method').disabled = false;
        document.getElementById('watermark_alpha').disabled = false;
    }else{
        document.getElementById('watermark_method').disabled = true;
        document.getElementById('watermark_alpha').disabled = true;
    }
}
function checkWatermarkAlpha(obj){
    var objValue = obj.value;
    if(objValue != ''){
        var isCorrected = false;
        objValue1 = parseInt(objValue);
        if(objValue1 != objValue){
            isCorrected = true;
        }
        objValue = objValue1;
        if(isNaN(objValue)){
            objValue = 65;
            isCorrected = true;
        }else if(objValue < 0){
            objValue = 0;
            isCorrected = true;
        }else if(objValue > 100){
            objValue = 100;
            isCorrected = true;
        }

        if(isCorrected){
            obj.value = objValue;
        }
    }
}

function extFileFields(){
  var oForm = document.uploadForm;
  var fNumber = 1;
  var bIsEmpty = false;
  var fFiles = 0;
  var fSize=0;
  for (i=0;i<oForm.elements.length;i++){
    if(oForm.elements[i].type == 'file'){
      if (oForm.elements[i].value==''){
        bIsEmpty = true;
      }else{
      }
      oField = oForm.elements[i];
      fNumber++
    }
  }
  if (!bIsEmpty && (fNumber <= maxFilesToUpload)){

    var oNewDiv = document.createElement('div');
    oNewDiv.innerHTML = '<b>' + fNumber + '.</b>&nbsp;';

    var oNewField = document.createElement('input');
    oNewField.type = 'file';
    oNewField.name = 'ffilename' + fNumber;
    oNewField.className = 'field';
    oNewField.style.width = '90%';
    oNewField.onchange = function(currentEvent){onSetFile(currentEvent, this.value);};
    oNewField.onfocus = function(currentEvent){onSetFile(currentEvent, this.value); this.style.border='1px solid #ff0000';};
    oNewField.onblur = function(currentEvent){this.style.border='1px inset #990000';};
    oNewDiv.appendChild(oNewField);

    oField.parentNode.appendChild(oNewDiv);
  }

  return (fNumber!=2);
}

function spinValue(evt, num){
  evt = amiCommon.getValidEvent(evt);
  var target = amiCommon.getEventTarget(evt);
  iVal = (isNaN(parseInt(target.value)))?0:parseInt(target.value);
  if (evt.keyCode == 38 && iVal < num){
    target.value = iVal + 1;
    target.select();
  }
  if (evt.keyCode == 40 && iVal > 0){
    target.value = iVal - 1;
    target.select();
  }

  if (evt.keyCode == 33)
    if(iVal < num - 10){
      target.value = iVal + 10 ;
      target.select();
      amiCommon.stopEvent(evt);
    }else{
      target.value = num;
      target.select();
      amiCommon.stopEvent(evt);
    }
  if (evt.keyCode == 34)
    if (iVal > 0 + 10){
      target.value = iVal - 10;
      target.select();
      amiCommon.stopEvent(evt);
    }else{
      target.value = 0;
      target.select();
      amiCommon.stopEvent(evt);
    }

}

var img_ext = new Array(##img_ext_array##);

function CheckImgExtension(ext) {
  var err=true;
  for(i=0;i<img_ext.length;i++) {
    if(img_ext[i]==ext) {
      err=false;
      break;
    }
  }
  return !err;
}

function generateImageHTML(image_src, id){
    var res = '<IMG';
    res +=    ' src="'+image_src+'"'
           +  ' id="'+id+'">';
    return res;
}

function generateFlashHTML(image_src, quality, width, height, id, className, border, align, vspace, hspace, alt ){
    var style = '';

/*
    if(vspace != ''){
        style += 'margin-top: ' + vspace + 'px;margin-bottom: ' + vspace + 'px;';
    }
    if(hspace != ''){
        style += 'margin-left: ' + hspace + 'px;margin-right: ' + hspace + 'px;';
    }
*/
    var res = '<OBJECT';

    if ( className != "")
      res += ' '
           +  'class=' + className;
    res += ' '
           +  'classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" '
           +   'codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0"\n';
    if (width != '' ) res +=  ' WIDTH="'+width+'"';
    if (height != '' ) res +=  ' HEIGHT="'+height+'"';
    if ( id > "")
      res += ' '
           +   'id="'+id+'"';
    res += ' '
           +   'ALIGN="'+align+'" border="'+border+'" title="'+alt+'"' + (style != '' ? ' style="' + style + '"' : '') + '>\n'
           +   '<PARAM NAME=movie VALUE="'+image_src+'">\n'
           +   '<PARAM NAME=quality VALUE='+quality+'>\n'
           +   '<EMBED src="'+image_src+'" quality='+quality;

    if (width != '' ) res +=  ' WIDTH="'+width+'"';
    if (height != '' ) res +=  ' HEIGHT="'+height+'"';

    res +=     'ID="'+id+'" ALIGN="'+align+'" border="'+border+'" title="'+alt+'"\n'
           +   'TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer"></EMBED>\n'
           +  '</OBJECT>';
  return res;
}

function onRefresh(){
  //var self_url = top.addParameterToUrl('##self_url##', 'browse_open', document.forms['pagersform'].browse_open.value);
  //self_url = top.addParameterToUrl(self_url, 'main_field', mainImageField.id);
  //window.location = top.addParameterToUrl(self_url, 'action', 'refresh');
  var imagesListForm = document.forms['imagesListForm'];
  prepareFormFields(imagesListForm);
  imagesListForm.browse_open.value = document.forms['pagersform'].browse_open.value;
  imagesListForm.set_cat.value = document.forms['pagersform'].set_cat.value;
  imagesListForm.main_field.value = mainImageField.id;
  imagesListForm.action.value = 'refresh';
  imagesListForm.submit();

}

function onMode(mode){
  //var self_url = top.addParameterToUrl('##self_url##', 'browse_open', document.forms['pagersform'].browse_open.value);
  //self_url = top.addParameterToUrl(self_url, 'main_field', mainImageField.id);
  //window.location = top.addParameterToUrl(self_url, 'mode', mode);
  var imagesListForm = document.forms['imagesListForm'];
  prepareFormFields(imagesListForm);
  imagesListForm.browse_open.value = document.forms['pagersform'].browse_open.value;
  imagesListForm.set_cat.value = document.forms['pagersform'].set_cat.value;
  imagesListForm.main_field.value = mainImageField.id;
  imagesListForm.mode.value = mode;
  imagesListForm.submit();
}

function onDelete(imgName){
  var bSet = false;
  var imagesListForm = document.forms["imagesListForm"] ? document.forms["imagesListForm"] : null;
  if (imagesListForm && imagesListForm.elements["files[]"]){
		var iCount = (imagesListForm.elements["files[]"].length==undefined)?1:imagesListForm.elements["files[]"].length;
		if (imagesListForm.elements["files[]"].length!=undefined){
			for (i=0;i<iCount;i++){
				if (imagesListForm.elements["files[]"][i].checked){
					bSet = true;
				}
			}
		}else{
		  bSet = imagesListForm.elements["files[]"].checked;
		}
  }
  if(bSet){
    if(confirm('%%delete_confirm%%')){
      prepareFormFields(imagesListForm);
      imagesListForm.set_cat.parentNode.removeChild(imagesListForm.set_cat);
      imagesListForm.browse_open.value = document.forms['pagersform'].browse_open.value;
      imagesListForm.main_field.value = mainImageField.id;
      imagesListForm.action.value = 'delete';
      imagesListForm.submit();
    }
  }/*else if (confirm('%%delete_all_confirm%%') && confirm('%%delete_all_confirm2%%')){
    imagesListForm.set_cat.parentNode.removeChild(imagesListForm.set_cat);
    imagesListForm.elements["action"].value = "delete_all";
    imagesListForm.submit();
  }*/
  else{
    alert('%%delete_none%%');
  }
}

function clearFile(field){
    var oNewField = document.createElement('input');
    oNewField.type = 'file';
    oNewField.name = field.name;
    //Bankir
    //oNewField.size = "85";
    oNewField.className = 'field';
    oNewField.style.width = '100%';
    oNewField.onchange = function(currentEvent){onSetFile(currentEvent, this.value);};
    oNewField.onfocus = function(currentEvent){onSetFile(currentEvent, this.value); this.style.border='1px solid #ff0000';};
    oNewField.onfocus = function(currentEvent){this.style.border='1px inset #990000';};

    field.parentNode.replaceChild(oNewField, field);
}

function onSetImage(image_src, width, height){
  if(setImage(image_src, width, height)){
    btnChoose(false);
    return true;
  }else{
    return false;
  }
}

function switchElementVisibility(obj){
  if(obj.style.display == 'none' || obj.style.display == ''){
    makeElementVisible(obj, 'block');
  }else{
    makeElementVisible(obj, 'none');
  }
}

function showPopupProps(show){
    if(enablePopupProps){
        makeElementVisible(document.getElementById("popup_props1"), 'block');
        makeElementVisible(document.getElementById("popup_props2"), 'block');
//        makeElementVisible(document.getElementById("popup_props3"), 'block');
        makeElementVisible(document.getElementById("imageHeader"), 'block');
        makeElementVisible(document.getElementById("imageDescription"), 'block');
        makeElementVisible(document.getElementById("imageGroup"), 'block');
        makeElementVisible(document.getElementById("imageLink1"), 'block');
        makeElementVisible(document.getElementById("imageLink2"), 'block');

        makeElementVisible(document.getElementById("imageOverBlock"), 'block');
    }

}

function setImage(image_src, width, height){

  if (typeof(image_src) == 'undefined'){
    if (mainImageField.value == ''){
      image_src=tImage.src;
      width='';
      height='';
    }else{
      image_src = ( ( mainImageField.value.substr(0, 7) == 'http://' || mainImageField.value.substr(0, 8) == 'https://' ) ? '' : editorBaseHref ) + mainImageField.value;
    }
  }


  var ext = image_src.substr(image_src.length-3, image_src.length-1).toLowerCase();


  if (document.forms['imageForm'].txtWidth){
    if (mainImageField.id=="txtFileName"){
      var newWidth = (typeof(width) == 'undefined') ? document.forms['imageForm'].txtWidth.value : width;
      var newHeight = (typeof(height) == 'undefined') ? document.forms['imageForm'].txtHeight.value : height;

      if (document.forms['imageForm'].txtBorder && document.forms['imageForm'].txtBorder.value==""){
        document.forms['imageForm'].txtBorder.value = "0";
      }

      if ((ext=="swf")){
        makeElementVisible(document.getElementById("popup_img_container"), 'none');
        makeElementVisible(document.getElementById("header_popup_img_url"), 'none');
        switchBlock('popup_img_url', false);
        makeElementVisible(document.getElementById("over_img_container"), 'none');
        makeElementVisible(document.getElementById("header_img_over"), 'none');
        switchBlock('img_over', false);
      }else{
        makeElementVisible(document.getElementById("header_popup_img_url"), 'block');
        makeElementVisible(document.getElementById("header_img_over"), 'block');
      }

    }else if(mainImageField.id == 'txtPopupFileName'){
      var newWidth = (typeof(width) == 'undefined') ? document.forms['imageForm'].txtPopupWidth.value : width;
      var newHeight = (typeof(height) == 'undefined') ? document.forms['imageForm'].txtPopupHeight.value : height;
    }else{
      newWidth = 'auto';
      newHeight = 'auto';
    }
  }

  if (document.forms['imageForm'].txtPopupFileName){
    popupImageSrc = document.forms['imageForm'].txtPopupFileName.value;
    if (popupImageSrc.substr(popupImageSrc.length-3, popupImageSrc.length-1).toLowerCase() == "swf"){
     makeElementVisible(document.getElementById("popup_props2"), 'block');
    }else{
     makeElementVisible(document.getElementById("popup_props2"), 'none');
    }
  }

  if (ext == "swf"){
    if (mainImageField.id=="txtFileName"){
      var previewIMG = generateFlashHTML(image_src, 'high', newWidth, newHeight, 'preview_img', 'picture',0, '', 0, 0, "" );
      document.getElementById('img_container').innerHTML = previewIMG + '<span id="sample_text" style="display:none">%%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%.</span>';
      var previewIMG = generateFlashHTML(image_src, 'high', newWidth, newHeight, 'txtFileName_preview', 'picture',0, '', 0, 0, "" );
      document.getElementById('img_block_preview').innerHTML = previewIMG;

      if (document.forms['imageForm'].txtWidth) document.forms['imageForm'].txtWidth.value = newWidth;
      if (document.forms['imageForm'].txtHeight) document.forms['imageForm'].txtHeight.value = newHeight;
    }else if(mainImageField.id == 'txtPopupFileName'){
      var previewIMG = generateFlashHTML(image_src, 'high', '', '', 'preview_popup_img', 'picture',0, '', 0, 0, "" );
      document.getElementById('popup_img_container').innerHTML = '<div style="height:20px;">%%popup_img_url%%</div>'+previewIMG;
      var previewIMG = generateFlashHTML(image_src, 'high', newWidth, newHeight, 'txtPopupFileName_preview', 'picture',0, '', 0, 0, "" );
      document.getElementById('popup_img_block_preview').innerHTML = previewIMG;
      
      if (document.forms['imageForm'].txtPopupWidth) document.forms['imageForm'].txtPopupWidth.value = newWidth;
      if (document.forms['imageForm'].txtPopupHeight) document.forms['imageForm'].txtPopupHeight.value = newHeight;
    } else if(mainImageField.id == 'txtImageOver'){
      alert('%%over_no_flash%%');
      return false;
    }

  }else{
    if (mainImageField.id=="txtFileName"){
      var previewIMG = generateImageHTML(image_src, 'preview_img');
      document.getElementById('img_container').innerHTML = previewIMG + '<span id="sample_text" style="display:none">%%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%.</span>';
      var previewIMG = generateImageHTML(image_src, 'txtFileName_preview');
      document.getElementById('img_block_preview').innerHTML = previewIMG;
    }else if(mainImageField.id == 'txtPopupFileName'){
      var previewIMG = generateImageHTML(image_src, 'preview_popup_img');
      document.getElementById('popup_img_container').innerHTML = '<div style="height:20px;">%%popup_img_url%%</div>'+previewIMG;
      var previewIMG = generateImageHTML(image_src, 'txtPopupFileName_preview');
      document.getElementById('popup_img_block_preview').innerHTML = previewIMG;
    } else if(mainImageField.id == 'txtImageOver'){
      document.getElementById('preview_over_img').src = image_src;
      document.getElementById('txtImageOver_preview').src = image_src;
    }

    if (document.forms['imageForm'].bgrepeat_x && document.forms['imageForm'].bgrepeat_y){
      document.getElementById('img_container').style.backgroundImage = 'url('+image_src+')';
      document.getElementById('img_container').style.height = '300px;';
      document.getElementById('preview_img').src = "images/empty.gif";
      //alert(mainImageField.id);
      //document.getElementById(mainImageField.id + '_preview').src = image_src;
    }else{
      document.getElementById('img_container').style.height = '';
    }

/*
    var currImg = document.getElementById('preview_img');

    if(currImg == null){
      currImg = document.getElementsByName('preview_img')[0];
    }
    var previewIMG = document.createElement('img');
    previewIMG.id = 'preview_img';
    previewIMG.name = 'preview_img';
    previewIMG.src = image_src;

    previewIMG.style.border = "0px";
*/
    if (document.forms['imageForm'].txtWidth){
      //previewIMG.style.width = newWidth == 'auto' ? 'auto' : newWidth + "px";
      //previewIMG.style.height = newHeight == 'auto' ? 'auto' : newHeight + "px";
    }
    //document.getElementById('img_container').replaceChild(previewIMG, currImg);
    //document.getElementById('img_block_preview').replaceChild(previewIMG, currImg);

    //window.document.images["preview_img"].style.background = "url('"+image_src+"') no-repeat";

//      window.document.images["preview_img"].src = image_src;



    if (document.forms['imageForm'].txtWidth){
      //window.document.images["preview_img"].style.width = newWidth == 'auto' ? 'auto' : newWidth + 'px';
      //window.document.images["preview_img"].style.heigth = newHeight == 'auto' ? 'auto' : newHeight + 'px';

      if (mainImageField.id=="txtFileName"){
        if (document.forms['imageForm'].txtWidth) document.forms['imageForm'].txtWidth.value = newWidth == 'auto' ? '' : newWidth;
        if (document.forms['imageForm'].txtHeight) document.forms['imageForm'].txtHeight.value = newHeight == 'auto' ? '' : newHeight;
      }else if(mainImageField.id == 'txtPopupFileName'){
        if (document.forms['imageForm'].txtPopupWidth) document.forms['imageForm'].txtPopupWidth.value = newWidth == 'auto' ? '' : newWidth;
        if (document.forms['imageForm'].txtPopupHeight) document.forms['imageForm'].txtPopupHeight.value = newHeight == 'auto' ? '' : newHeight;

      }
    }
  }
  updateImage();
  document.forms['imageForm'].btnOK.disabled = false;
  return true;
}

function updateImage(){
  document.getElementById('preview_img').removeAttribute('border');
  document.getElementById('preview_img').removeAttribute('hspace');
  document.getElementById('preview_img').removeAttribute('vspace');
  removeStyleProperty(document.getElementById('preview_img'), 'marginLeft');
  removeStyleProperty(document.getElementById('preview_img'), 'marginRight');
  removeStyleProperty(document.getElementById('preview_img'), 'marginTop');
  removeStyleProperty(document.getElementById('preview_img'), 'marginBottom');

  if (mainImageField.id=="txtFileName"){
    if (document.forms['imageForm'].txtWidth && !isNaN(parseInt(document.forms['imageForm'].txtWidth.value))){
      //document.getElementById('preview_img').style.width = document.forms['imageForm'].txtWidth.value + 'px';
    }
    if (document.forms['imageForm'].txtHeight && !isNaN(parseInt(document.forms['imageForm'].txtHeight.value))){
      //document.getElementById('preview_img').style.height = document.forms['imageForm'].txtHeight.value + 'px';
    }
    if (document.forms['imageForm'].txtBorder && !isNaN(parseInt(document.forms['imageForm'].txtBorder.value))){
      document.getElementById('preview_img').border = document.forms['imageForm'].txtBorder.value;
    }
    if (document.forms['imageForm'].txtHorizontal && !isNaN(parseInt(document.forms['imageForm'].txtHorizontal.value))){
      document.getElementById('preview_img').style.marginLeft = document.getElementById('preview_img').style.marginRight = document.forms['imageForm'].txtHorizontal.value + 'px';
    }
    if (document.forms['imageForm'].txtVertical && !isNaN(parseInt(document.forms['imageForm'].txtVertical.value))){
      document.getElementById('preview_img').style.marginTop = document.getElementById('preview_img').style.marginBottom = document.forms['imageForm'].txtVertical.value + 'px';
    }
    if (document.forms['imageForm'].selAlignment){
      document.getElementById('preview_img').align = document.forms['imageForm'].selAlignment.value;
    }
    if (document.forms['imageForm'].bgrepeat_x && document.forms['imageForm'].bgrepeat_y){
      if (document.forms['imageForm'].bgrepeat_x.checked && document.forms['imageForm'].bgrepeat_y.checked){
        document.getElementById('img_container').style.backgroundRepeat = "repeat";
      }else if (document.forms['imageForm'].bgrepeat_x.checked){
        document.getElementById('img_container').style.backgroundRepeat = "repeat-x";
      }else if (document.forms['imageForm'].bgrepeat_y.checked){
        document.getElementById('img_container').style.backgroundRepeat = "repeat-y";
      }else{
        document.getElementById('img_container').style.backgroundRepeat = "no-repeat";
      }
    }
  }else{
    if (document.forms['imageForm'].txtPopupHeight && !isNaN(parseInt(document.forms['imageForm'].txtPopupHeight.value))){
      //document.getElementById('preview_img').height = document.forms['imageForm'].txtPopupHeight.value;
    }
    if (document.forms['imageForm'].txtPopupWidth && !isNaN(parseInt(document.forms['imageForm'].txtPopupWidth.value))){
      //document.getElementById('preview_img').width = document.forms['imageForm'].txtPopupWidth.value;
    }
  }

  if (document.forms['imageForm'].txtPopupFileName && (document.forms['imageForm'].txtPopupFileName.value != '')){
    document.getElementById('popup_img_container').style.display = 'block';
  }else{
    document.getElementById('popup_img_container').style.display = 'none';
  }

  if (document.forms['imageForm'].txtImageOver && (document.forms['imageForm'].txtImageOver.value != '')){
    document.getElementById('over_img_container').style.display = 'block';
  }else{
    document.getElementById('over_img_container').style.display = 'none';
  }

  updatePreviewImage();
}

function updatePreviewImage(){
  if(document.getElementById('popup_img_container').style.display == 'none' && document.getElementById('over_img_container').style.display == 'none'){
    //document.getElementById('img_container').style.width = "95%";
    document.getElementById('preview_img').style.maxWidth = '100%';
    document.getElementById('img_container').style.maxWidth = "95%";
  }else{
    document.getElementById('img_container').style.maxWidth = "30%";
    //document.getElementById('img_container').style.width = "30%";
    document.getElementById('preview_img').style.maxWidth = '100%';
  }
}

function moveToDir(dir, name){
  var bSet = false;
  var imagesListForm = document.forms["imagesListForm"];
  if (imagesListForm && imagesListForm.elements["files[]"]){
    if (imagesListForm.elements["files[]"].length>0){
      for (i=0;i<imagesListForm.elements["files[]"].length;i++){
        if (imagesListForm.elements["files[]"][i].checked){
          bSet = true;
        }
      }
    }else{
      if (imagesListForm.elements["files[]"].checked){
        bSet = true;
      }
    }
  }
  if(bSet){
    if (confirm(String("%%move_confirm%%").replace("_dir_",name))){
      prepareFormFields(imagesListForm);
      imagesListForm.elements["action"].value = "move";
      imagesListForm.set_cat.value = dir;
      imagesListForm.browse_open.value = document.forms['pagersform'].browse_open.value;

      imagesListForm.submit();
    }
  }/*else{
     if(confirm(String("%%move_all_confirm%%").replace("_dir_",name))){
      imagesListForm.elements["action"].value = "move_all";
      imagesListForm.set_cat.value = dir;
      imagesListForm.submit();
    }
  }*/
  else{
    alert('%%move_none%%');
  }
}

function deleteDir(dir, name){
  if (confirm(String("%%delete_folder_confirm%%").replace("_dir_",name))){
    //var self_url = top.addParameterToUrl('##self_url##', 'browse_open', document.forms['pagersform'].browse_open.value);
    //self_url = top.addParameterToUrl(self_url, 'main_field', mainImageField.id);
	  //window.location = top.addParameterToUrl(self_url, 'delete_cat', dir);

    var imagesListForm = document.forms['imagesListForm'];
    prepareFormFields(imagesListForm);
    imagesListForm.browse_open.value = document.forms['pagersform'].browse_open.value;
    imagesListForm.main_field.value = mainImageField.id;
    imagesListForm.delete_cat.value = dir;
    imagesListForm.submit();

	}
}

function createDir(){
	var imagesListForm = document.forms['imagesListForm'];
    var dir = imagesListForm.new_cat.value.replace(/[ ]/g, "_");
    var prevLength = dir.length;
    if(prevLength > 0){
        dir = dir.replace(/[^A-Za-z0-9\-_]/g, "");
        if(prevLength != dir.length){
            alert("%%create_folder_rules%%");
        }else{
            if(confirm(String("%%create_folder_confirm%%").replace("_dir_", dir))){
              //var self_url = top.addParameterToUrl('##self_url##', 'browse_open', document.forms['pagersform'].browse_open.value);
              //self_url = top.addParameterToUrl(self_url, 'main_field', mainImageField.id);
              //window.location = top.addParameterToUrl(self_url, 'create_cat', dir);
              
              prepareFormFields(imagesListForm);
              imagesListForm.browse_open.value = document.forms['pagersform'].browse_open.value;
              imagesListForm.main_field.value = mainImageField.id;
              imagesListForm.create_cat.value = dir;
              imagesListForm.submit();



            }
        }
    }
}

function changeDir(dir){
  //var self_url = top.addParameterToUrl('##self_url##', 'browse_open', document.forms['pagersform'].browse_open.value);
  //self_url = top.addParameterToUrl(self_url, 'main_field', mainImageField.id);
  //window.location = top.addParameterToUrl(self_url, 'set_cat', dir);

  var imagesListForm = document.forms['imagesListForm'];
  prepareFormFields(imagesListForm);
  imagesListForm.browse_open.value = document.forms['pagersform'].browse_open.value;
  imagesListForm.main_field.value = mainImageField.id;
  //alert(dir);
  imagesListForm.set_cat.value = dir;
  imagesListForm.submit();

}

function onSetFile(evt, path){
    evt = amiCommon.getValidEvent(evt);
    var targetElement = amiCommon.getEventTarget(evt);
    if (path != ''){
        var ext = path.substr(path.length-3, path.length-1).toLowerCase();
        var oForm = document.uploadForm;
        for (i=0;i<oForm.elements.length;i++){
          if ((oForm.elements[i]!=targetElement)&&(oForm.elements[i].type=='file') && (oForm.elements[i].value==path)){
          clearFile(targetElement);
          alert('%%file_already_set%%');
          return;
        }
    }

    if (CheckImgExtension(ext) || ext == 'swf'){
        extFileFields();
        document.forms['imageForm'].btnOK.disabled=true;
    }else{
        clearFile(targetElement);
        alert('%%is_not_image%%');
    }
  }
}


##js_functions##


function UpdateImageField(){
    var itemsBlock = document.getElementById('itemsBlock');
    var foldersBlock = document.getElementById('folder_block');

    if(!top.AMI.Browser.isSensor && !top.AMI.Browser.isLowResolution && itemsBlock != null && window.clientAreaHeight){
        var clientHeight = window.clientAreaHeight;
        var itemsBlockHeight = itemsBlock.offsetHeight;
        var itemsBlockOffset = amiCommon.getElementPosition(itemsBlock);
        itemsBlock.style.height = Math.max(200, clientHeight - itemsBlockOffset[1] - 44) + 'px';
        foldersBlock.style.height = parseInt(itemsBlock.style.height) + 35 + 'px';
    }else if(top.AMI.Browser.isSensor || top.AMI.Browser.isLowResolution){
        var oServerBlock = document.getElementById('server_block');
        if(oServerBlock.offsetHeight > 0){
            document.body.style.height = Math.max(top.AMI.Browser.getDocumentHeight(window), 70 + oServerBlock.offsetHeight) + 'px';
        }
        oServerBlock.style.marginBottom = '10px';
        document.getElementById('server_block').style.position = 'absolute';
    }
}

function removeStyleProperty(oElement, styleName){
    if(oElement.style.removeAttribute){
        oElement.style.removeAttribute(styleName, false);
    }else{
        oElement.style.removeProperty(styleName);
    }
}

function getElementSpaces(oElement){
    var aSpaces = [0, 0];

    var styleLeft = parseInt(oElement.style.marginLeft);
    if(isNaN(styleLeft)){
        styleLeft = 0;
    }
    aSpaces[0] = Math.max(0, styleLeft, oElement.hspace);

    var styleTop = parseInt(oElement.style.marginTop);
    if(isNaN(styleTop)){
        styleTop = 0;
    }
    aSpaces[1] = Math.max(0, styleTop, oElement.vspace);

    return aSpaces;
}

function setImageAttribute(oElement, attributeName, attributeValue){
    if(attributeValue != ''){
        oElement.setAttribute(attributeName, attributeValue);
    }else{
        oElement.removeAttribute(attributeName);
    }
}

function getDefaultGroupName(){
    var groupName = '';
    var oForm = window.parentWindow.document.forms[window.parentWindow._cms_document_form];
    if(typeof(oForm) == 'object'){
        if(typeof(oForm.elements.header) != 'undefined'){
            groupName = oForm.elements.header.value;
        }else if(typeof(oForm.elements.name) != 'undefined'){
            groupName = oForm.elements.name.value;
        }
    }
    return groupName;
}

function expandDescriptionControl(bSavePosition, bSetFocus, forcedType){
    forcedType = forcedType || '';
    var oForm = document.forms.imageForm;
    if(typeof(oForm) == 'object'){
        var oInput = oForm.txtDescriptionTextInput;
        var oTextarea = oForm.txtDescriptionTextTextarea;
        if(oInput.style.display != 'none' && (oInput.value.length > 44 || forcedType == 'textarea')){
            oTextarea.removeAttribute('disabled');
            oTextarea.style.display = 'inline';
            oTextarea.value = oInput.value;
            if(bSavePosition){
                var position = window.parentWindow.AMI.Browser.getCaretPosition(oInput);
                window.parentWindow.AMI.Browser.setCaretPosition(oTextarea, position);
            }
            if(bSetFocus){
                oTextarea.focus();
            }
            oInput.setAttribute('disabled', 'disabled');
            oInput.style.display = 'none';
        }else if(oTextarea.style.display != 'none' && (oTextarea.value.length <= 44 || forcedType == 'input')){
            oInput.removeAttribute('disabled');
            oInput.style.display = 'inline';
            oInput.value = oTextarea.value;
            if(bSavePosition){
                var aPosition = window.parentWindow.AMI.Browser.getCaretPosition(oTextarea);
                window.parentWindow.top.AMI.Browser.setCaretPosition(oInput, aPosition);
            }
            if(bSetFocus){
                oInput.focus();
            }
            oTextarea.setAttribute('disabled', 'disabled');
            oTextarea.style.display = 'none';
        }
    }
}

function btnChoose(bShow){
  if(bShow){
    document.getElementById('shadow_block').style.display='block';
    document.getElementById('server_block').style.visibility = 'hidden';
    document.getElementById('server_block').style.display='block';
    UpdateImageField();
    document.getElementById('server_block').style.visibility = 'visible';
    document.forms['pagersform'].browse_open.value='1';
  }else{
    document.getElementById('shadow_block').style.display='none';
    document.getElementById('server_block').style.display='none';
    document.forms['pagersform'].browse_open.value='0';
  }
}

function btnUpload(bShow){
  if(bShow){
    document.forms['uploadForm'].main_field.value =  mainImageField.id;
    document.getElementById('shadow_block').style.display='block';
    document.getElementById('upload_block').style.display='block';
  }else{
    if(document.getElementById('server_block').style.display != 'block'){
        document.getElementById('shadow_block').style.display='none';
    }
    document.getElementById('upload_block').style.display='none';
  }
}

function switchBlock(sName, bShow){
  var oBlock = AMI.$('#block_' + sName);
  var oHeader = AMI.$('#header_' + sName);

  if(typeof(bShow)=='undefined'){
    if(oHeader.attr('class') == 'smalltab-header'){
      oHeader.attr('class', 'smalltab-header smalltab-header-active');
      oBlock.slideDown();
    }else{
      setTimeout(function() {oHeader.attr('class', 'smalltab-header')}, 450);
      oBlock.slideUp();
    }
  }else{
    if(bShow){
      oHeader.delay(500).attr('class', 'smalltab-header smalltab-header-active');
      oBlock.slideDown();
    }else{
      setTimeout(function() {oHeader.attr('class', 'smalltab-header')}, 450);
      oBlock.slideUp();
    }
  }
}

function prepareFormFields(oForm){

  var oImagesForm = document.forms['imageForm'];
  if(oImagesForm.txtFileName) oForm.txtFileName.value = oImagesForm.txtFileName.value;
  if(oImagesForm.txtWidth) oForm.txtWidth.value = oImagesForm.txtWidth.value;
  if(oImagesForm.txtHeight) oForm.txtHeight.value = oImagesForm.txtHeight.value;
  if(oImagesForm.txtHorizontal) oForm.txtHorizontal.value = oImagesForm.txtHorizontal.value;
  if(oImagesForm.txtVertical) oForm.txtVertical.value = oImagesForm.txtVertical.value;
  if(oImagesForm.txtBorder) oForm.txtBorder.value = oImagesForm.txtBorder.value;
  if(oImagesForm.txtAltText) oForm.txtAltText.value = oImagesForm.txtAltText.value;
  if(oImagesForm.txtTitleText) oForm.txtTitleText.value = oImagesForm.txtTitleText.value;
  if(oImagesForm.txtPopupFileName) oForm.txtPopupFileName.value = oImagesForm.txtPopupFileName.value;
  if(oImagesForm.txtPopupWidth) oForm.txtPopupWidth.value = oImagesForm.txtPopupWidth.value;
  if(oImagesForm.txtPopupHeight) oForm.txtPopupHeight.value = oImagesForm.txtPopupHeight.value;
  if(oImagesForm.txtHeaderText) oForm.txtHeaderText.value = oImagesForm.txtHeaderText.value;
  if(oImagesForm.txtGroupText) oForm.txtGroupText.value = oImagesForm.txtGroupText.value;
  if(oImagesForm.txtLinkText) oForm.txtLinkText.value = oImagesForm.txtLinkText.value;
  if(oImagesForm.txtLinkCaptionText) oForm.txtLinkCaptionText.value = oImagesForm.txtLinkCaptionText.value;
  if(oImagesForm.txtDescriptionTextInput) oForm.txtDescriptionTextInput.value =  (oImagesForm.txtDescriptionTextInput.style.display != 'none') ? oImagesForm.txtDescriptionTextInput.value : oImagesForm.txtDescriptionTextTextarea.value;
  //oForm.txtDescriptionTextTextarea.value = oImagesForm.txtDescriptionTextTextarea.value;
  if(oImagesForm.txtImageOver) oForm.txtImageOver.value = oImagesForm.txtImageOver.value;
  if(oImagesForm.bgrepeat_x) oForm.bgrepeat_x.value = oImagesForm.bgrepeat_x.value;
  if(oImagesForm.bgrepeat_y) oForm.bgrepeat_y.value = oImagesForm.bgrepeat_y.value;
  if(oImagesForm.selAlignment) oForm.selAlignment.value = oImagesForm.selAlignment.value;

}


function go_page(start){
 errFunc = go_page;
  var sform = document.forms[_cms_document_form];
  var link = _cms_script_link;

  sform.action.value = 'rsrtme';
  sform.offset.value = start;
  if(typeof(sform.enc_offset) == 'object') {
    sform.enc_offset.value = start;
  }

  prepareFormFields(sform);
  sform.submit();
  //document.location = link + collect_link(sform);

  return false;
}

function go_pagesize(size){
 errFunc = go_pagesize;
  var sform = document.forms[_cms_document_form];
  var link = _cms_script_link;

  sform.action.value = 'rsrtme';
  sform.limit.value = size;
  if(typeof(sform.enc_limit) == 'object') {
    sform.enc_limit.value = size;
  }
  prepareFormFields(sform);
  sform.submit();
  //document.location = link + collect_link(sform);
  //alert(link + collect_link(sform));

  return false;
}


</script>
</HEAD>

<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">
<div id="main_block">
<div id="status-block" class="status-block"##if (status=='')## style="display:none" ##endif##>
    <div id="status-msgs" class="status-msgs">##status##</div>
</div>
  <table cellspacing="10" cellspacing="0" width=100% id="popup_content" border=0 height="100%">
    <tr>
      <td valign=top width=50%>
        ##form##
      </td>
      <td valign=top width=50%>
        <div id="preview_block">
          
          <div style="position:relative;">
          <div id="popup_img_container" onclick="setMainImageField(document.forms['imageForm'].txtPopupFileName);btnChoose(true)" title="%%choose%%">
            <div style="height:20px;">%%popup_img_url%%</div>
            <img id="preview_popup_img" src="##txtPopupFileName_img_url##" border="0" >
            ##--<img id="preview_popup_img_mark" src="skins/vanilla/images/mouse-click.png" border="0" width=27 height=27>--##
          </div>
          </div>


          <div style="text-align:left;position:relative;height:100%;">
            <div id="over_img_container" onclick="setMainImageField(document.forms['imageForm'].txtImageOver);btnChoose(true)" title="%%choose%%">
              <div style="height:20px;">%%image_over%%</div>
              <img id="preview_over_img" src="##txtImageOver_img_url##" border="0">
              ##--<img id="preview_over_img_mark" src="skins/vanilla/images/mouse-over.png" border="0" width=27 height=27>--##
            </div>
            
            <div id="img_container" onclick="setMainImageField(document.forms['imageForm'].txtFileName);btnChoose(true)" title="%%choose%%">
              ##--<div style="height:20px;">%%img_url%%</div>--##
              <img id="preview_img" src="##txtFileName_img_url##" border="0"><span id="sample_text" style="display:none">%%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%. %%sample_text%%.</span>
            </div>
          </div>


        </div>
      </td>
    </tr>
  </table>
</div>
<div id="shadow_block" ##if(browse_open=='1')##style="display:block"##endif## onclick="btnUpload(false);btnChoose(false);">
</div>
<div id="upload_block">
    ##upload_form##
<div class="popupWindowClose" onclick="btnUpload(false)"></div>
</div>
<div id="server_block" ##if(browse_open=='1')##style="display:block"##endif##>
    ##server_images##
<div class="popupWindowClose" onclick="btnChoose(false);"></div>
</div>
<script type="text/javascript">
<!--
var _cms_document_form = 'pagersform';
var _cms_script_link = '##script_link##?';
-->
</script>

  <form action="##script_link##" method=POST name="pagersform">
  <input type="hidden" name="imagetape" value="##imagetape##">
  <input type="hidden" name="offset" value="">
  <input type="hidden" name="limit" value="##pager_limit##">
  <input type="hidden" name="action" value="">
  <input type="hidden" name="flt_name" value="##flt_name##">
  <input type="hidden" name="cat" value="##pager_cat##">
  <input type="hidden" name="set_cat" value="##pager_set_cat##">
  <input type="hidden" name="bgobj" value="##pager_bgodj##">
  <input type="hidden" name="obj" value="##pager_odj##">
  <input type="hidden" name="fld" value="##pager_fld##">
  <input type="hidden" name="img" value="##pager_img##">
  <input type="hidden" name="mode" value="##pager_mode##">
  <input type="hidden" name="old_cat" value="##pager_cat##">
  <input type="hidden" name="module" value="##module##">
  <input type="hidden" name="browse_open" value="##browse_open##">
  <input type="hidden" name="main_field" value="##main_field##">

  <input type="hidden" name="txtFileName" value="">
  <input type="hidden" name="txtWidth" value="">
  <input type="hidden" name="txtHeight" value="">
  <input type="hidden" name="txtHorizontal" value="">
  <input type="hidden" name="txtVertical" value="">
  <input type="hidden" name="txtBorder" value="">
  <input type="hidden" name="txtAltText" value="">
  <input type="hidden" name="txtTitleText" value="">
  <input type="hidden" name="txtPopupFileName" value="">
  <input type="hidden" name="txtPopupWidth" value="">
  <input type="hidden" name="txtPopupHeight" value="">
  <input type="hidden" name="txtHeaderText" value="">
  <input type="hidden" name="txtGroupText" value="">
  <input type="hidden" name="txtLinkText" value="">
  <input type="hidden" name="txtLinkCaptionText" value="">
  <input type="hidden" name="txtDescriptionTextInput" value="">
  <input type="hidden" name="txtDescriptionTextTextarea" value="">
  <input type="hidden" name="txtImageOver" value="">
  <input type="hidden" name="bgrepeat_x" value="">
  <input type="hidden" name="bgrepeat_y" value="">
  <input type="hidden" name="selAlignment" value="">

  </form>

<script type="text/javascript">
    function onWindowShown(){
        Init();
        UpdateImageField();
    }
</script>


</BODY>
</HTML>