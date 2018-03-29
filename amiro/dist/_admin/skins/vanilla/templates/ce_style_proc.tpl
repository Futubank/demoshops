%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/ce_style_proc.lng"%%

<!--#set var="content" value="
<form name=sform method=post>
<table width=100% cellspacing=10 cellpadding=0 border=0 height=100%>
<tr><td valign=top onkeyup="updateCSSField()" style="line-height:24px;">
    <div style="height:428px;overflow-y:auto;padding-right:10px;">
      <div id="header_className" class="smalltab-header-active" onclick="switchBlock('className')">
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rbr-c"></div>
        %%style_classes%%
      </div>
      <div id=block_className class="smalltab-block-active">
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div>
        <div>%%class_name%%: <input type="text" class="field" name="className" value='' title="%%title_class_name%%" style="width:260px"></div>
      </div>

      <div id="header_font" class="smalltab-header-active" onclick="switchBlock('font')">
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rbr-c"></div>
        %%font%%
      </div>
      <div id=block_font class="smalltab-block-active">
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div>

        <div>%%font_family%%: <select name="fontFamily"  onchange="updateCSSField()" title="%%title_font_family%%">
        <option value=''>%%font_undefined%%</option>
        <option value='arial'>Arial</option>
        <option value='tahoma'>Tahoma</option>
        <option value='verdana'>Verdana</option>
        <option value='helvetica'>Helvetica</option>
        <option value='times new roman'>Times New Roman</option>
        <option value='georgia'>Georgia</option>
        <option value='courier new'>Courier New</option>
        <option value='courier'>Courier</option>
        <option value='wing dings'>Wing Dings</option>
        </select>
        </div>
        <div>%%size%%: <input type="text" class="spin-control" name="fontSize" value='' title="%%title_font_size%%" style="width:48px;">&nbsp;&nbsp;&nbsp;
        %%color%%: <input type="text" class="field" name="color" value='' title="%%title_color%%" style="width:120px;"> <div class="selectColor" title="%%selectColor%%" id="idColor" onClick="onSelectBGColor('idColor', 'color');"></div></div>
        <div>%%symbols%%: <select name="textTransform"  onchange="updateCSSField()" title="%%symbols_title%%">
        <option value=''>%%symbols_undefined%%</option>
        <option value='capitalize'>%%symbols_cap%%</option>
        <option value='uppercase'>%%symbols_up%%</option>
        <option value='lowercase'>%%symbols_lo%%</option>
        </select>
        </div>
        <div>
        <nobr><label onclick="updateCSSField()" title="%%bold%%"><input type="checkbox" name=fontWeight value="1" title="%%bold%%"> <b>%%bold%%</b></label>&nbsp;&nbsp;&nbsp;</nobr>
        <nobr><label onclick="updateCSSField()" title="%%italic%%"><input type="checkbox" name=fontStyle value="1" title="%%italic%%"> <i>%%italic%%</i></label>&nbsp;&nbsp;&nbsp;</nobr>
        <nobr><label onclick="updateCSSField()" title="%%small_caps%%"><input type="checkbox" name=fontVariant value="1" title="%%small_caps%%"> <span style="font-variant:small-caps">%%small_caps%%</span></label>&nbsp;&nbsp;&nbsp;</nobr><br>
        <nobr><label onclick="updateCSSField()" title="%%underline%%"><input type="checkbox" name=textDecorationUnderline value="1" title="%%underline%%"> <span style="text-decoration:underline">%%underline%%</span></label>&nbsp;&nbsp;&nbsp;</nobr>
        <nobr><label onclick="updateCSSField()" title="%%overline%%"><input type="checkbox" name=textDecorationOverline value="1" title="%%overline%%"> <span style="text-decoration:overline">%%overline%%</span></label></nobr><br>
        <nobr><label onclick="updateCSSField()" title="%%line_through%%"><input type="checkbox" name=textDecorationLineThrough value="1" title="%%line_through%%"> <span style="text-decoration:line-through">%%line_through%%</span></label>&nbsp;&nbsp;&nbsp;</nobr>
        <nobr><label onclick="updateCSSField()" title="%%blink%%"><input type="checkbox" name=textDecorationBlink value="1" title="%%blink%%"> <span style="text-decoration:">%%blink%%</span></label></nobr>
        </div>
      </div>

      <div id="header_background" class="smalltab-header" onclick="switchBlock('background')">
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rbr-c"></div>
        %%background%%
      </div>
      <div id=block_background class="smalltab-block">
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div>
        <div>
          %%color%%: <input type="text" class="field" name="backgroundColor" value='' title="%%title_background_color%%" style="width:120px;"> <div class="selectColor" title="%%selectColor%%" id="idBackgroundColor" onClick="onSelectBGColor('idBackgroundColor', 'backgroundColor');"></div>
        </div>
        <div>
          %%picture%%: <input type="text" class="field" name="backgroundImage" value='' title="%%title_background_image%%" style="width:220px;" onchange="updateCSSField()">
          <span id="div_img_popup_picture" helpId="popup_picture"><a href="javascript:" onclick="window.top.openDialog('%%picture_dialog%%', 'ce_img_proc.php?fld=backgroundImage&lang=##lang_data##', 0, 0, 0, 0, window);return false;"><img id="pic_backgroundImage" title="" class=icon src="skins/vanilla/icons/icon-no_scrnshot.gif" helpId="btn_imgs_add" hspace=4 align=absmiddle></a></span>
        </div>
        <div>
          %%position_x%%: <input type="text" class="spin-control" name="backgroundPositionX" value='' title="%%title_background_position_x%%" style="width:48px;">&nbsp;&nbsp;&nbsp;
          %%position_y%%: <input type="text" class="spin-control" name="backgroundPositionY" value='' title="%%title_background_position_y%%" style="width:48px;">
        </div>
        <div>
          %%background_repeat%%: <select name="backgroundRepeat" onchange="updateCSSField()" title="%%title_background_repeat%%">
            <option value="">%%background_repeat_undefined%%</option>
            <option value="no-repeat">%%background_repeat_no%%</option>
            <option value="repeat">%%background_repeat_repeat%%</option>
            <option value="repeat-x">%%background_repeat_x%%</option>
            <option value="repeat-y">%%background_repeat_y%%</option>
          </select>
        </div>
      </div>

      <div id="header_position" class="smalltab-header" onclick="switchBlock('position')">
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rbr-c"></div>
        %%position_n_size%%
      </div>
      <div id=block_position class="smalltab-block">
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div>
        <table cellpadding=0 cellspacing=0 border=0>
        <tr><td>%%position%%:&nbsp; 
        </td><td colspan=3><select name="position" onchange="updateCSSField()" title="%%title_position%%">
          <option value=''>%%position_undefined%%</option>
          <option value='relative'>%%position_relative%%</option>
          <option value='absolute'>%%position_absolute%%</option>
          <option value='fixed'>%%position_fixed%%</option>
        </select>
        </td></tr>
        <tr><td>%%order%%:&nbsp; 
        </td><td colspan=3><input type="text" class="spin-control" name="zIndex" value='' title="%%title_z_index%%" style="width:48px;">
        </td></tr>

        <tr><td>%%left%%:&nbsp; 
        </td><td width=80><input type="text" class="spin-control" name="left" value='' title="%%title_position_left%%" style="width:48px;">
        </td><td>%%top%%: 
        </td><td><input type="text" class="spin-control" name="top" value='' title="%%title_position_top%%" style="width:48px;">
        </td></tr>
        <tr><td>%%right%%:&nbsp; 
        </td><td><input type="text" class="spin-control" name="right" value='' title="%%title_position_right%%" style="width:48px;">
        </td><td>%%bottom%%: 
        </td><td><input type="text" class="spin-control" name="bottom" value='' title="%%title_position_bottom%%" style="width:48px;">
        </td></tr>
        <tr><td>%%width%%:&nbsp; 
        </td><td><input type="text" class="spin-control" name="width" value='' title="%%title_size_width%%" style="width:48px;">
        </td><td>%%height%%:&nbsp; 
        </td><td><input type="text" class="spin-control" name="height" value='' title="%%title_size_height%%" style="width:48px;">
        </td></tr></table>
      </div>

      <div id="header_size" class="smalltab-header" onclick="switchBlock('size')">
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rbr-c"></div>
        %%padding_n_margin%%
      </div>
      <div id=block_size class="smalltab-block">
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div>
          <div style="width:230px;height:60px;border:2px #fff dotted;position:relative;padding:25px 65px 27px 65px;">
          <div style="position:absolute;top:-8px;left:2px;font-size:10px;width:30px;color:#666;">%%padding%%</div>
          <div style="position:absolute;top:-8px;right:2px;"><span class=text_button style="font-size:10px" onclick="resetMargins()">%%title_padding_reset%%</span></div>
          <div style="position:absolute;top:1px;right:150px"><input type="text" class="spin-control" name="marginTop" value='' style="width:48px;" maxLength=8 title="%%title_padding_top%%"></div>
          <div style="position:absolute;right:2px;top:45px"><input type="text" class="spin-control" name="marginRight" value='' style="width:48px;" maxLength=8 title="%%title_padding_right%%"></div>
          <div style="position:absolute;bottom:1px;right:150px"><input type="text" class="spin-control" name="marginBottom" value='' style="width:48px;" maxLength=8 title="%%title_padding_bottom%%"></div>
          <div style="position:absolute;left:2px;top:45px"><input type="text" class="spin-control" name="marginLeft" value='' style="width:48px;" maxLength=8 title="%%title_padding_left%%"></div>
          <div style="width:100%;height:100%;border:1px #e8e8e8 solid;position:relative; background-color:#e8e8e8;">
            <div style="position:absolute;top:-8px;left:2px;font-size:10px;width:30px;color:#666;">%%margin%%</div>
            <div style="position:absolute;top:-8px;right:2px;"><span class=text_button style="font-size:10px" onclick="resetPaddings()">%%title_margin_reset%%</span></div>
            <div style="position:absolute;top:1px;right:86px"><input type="text" class="spin-control" name="paddingTop" value='' style="width:48px;" maxLength=8 title="%%title_margin_top%%"></div>
            <div style="position:absolute;right:2px;top:19px"><input type="text" class="spin-control" name="paddingRight" value='' style=width:48px;" maxLength=8 title="%%title_margin_right%%"></div>
            <div style="position:absolute;bottom:1px;right:86px"><input type="text" class="spin-control" name="paddingBottom" value='' style="width:48px;" maxLength=8 title="%%title_margin_bottom%%"></div>
            <div style="position:absolute;left:2px;top:19px"><input type="text" class="spin-control" name="paddingLeft" value='' style="width:48px;" maxLength=8 title="%%title_margin_left%%"></div>
          </div>
        </div>
      </div>

      <div id="header_border" class="smalltab-header" onclick="switchBlock('border')">
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div><div class="l-lt-c"></div><div class="l-rbr-c"></div>
        %%borders%%
      </div>
      <div id=block_border class="smalltab-block">
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div>
          <table cellpadding=0 cellspacing=0 border=0><tr><td>%%left%%: 
          </td><td><input type="text" class="spin-control" name="borderLeftWidth" value='' title="%%title_border_left_width%%"  style="width:30px;">&nbsp;
          </td><td><input type="text" class="field" name="borderLeftColor" value='' title="%%title_border_left_color%%" style="width:120px;">&nbsp;<div class="selectColor" title="%%selectColor%%" id="idBorderLeftColor" onClick="onSelectBGColor('idBorderLeftColor', 'borderLeftColor');"></div>&nbsp;
          </td><td><select name="borderLeftStyle" onchange="updateCSSField()" title="%%title_border_left_style%%">
            <option value=''>%%undefined%%</option>
            <option value='solid'>%%solid%%</option>
            <option value='dotted'>%%dotted%%</option>
            <option value='dashed'>%%dashed%%</option>
          </select>
          </td></tr>
          <tr><td><div>%%top%%: 
          </td><td><input type="text" class="spin-control" name="borderTopWidth" value='' title="%%title_border_top_width%%" style="width:30px;">&nbsp;
          </td><td><input type="text" class="field" name="borderTopColor" value='' title="%%title_border_top_color%%" style="width:120px;">&nbsp;<div class="selectColor" title="%%selectColor%%" id="idBorderTopColor" onClick="onSelectBGColor('idBorderTopColor', 'borderTopColor');"></div>&nbsp;
          </td><td><select name="borderTopStyle" onchange="updateCSSField()" title="%%title_border_top_style%%">
            <option value=''>%%undefined%%</option>
            <option value='solid'>%%solid%%</option>
            <option value='dotted'>%%dotted%%</option>
            <option value='dashed'>%%dashed%%</option>
          </select>
          </td></tr>
          <tr><td>%%right%%: 
          </td><td><input type="text" class="spin-control" name="borderRightWidth" value='' title="%%title_border_right_width%%" style="width:30px;">&nbsp;
          </td><td><input type="text" class="field" name="borderRightColor" value='' title="%%title_border_right_color%%" style="width:120px;">&nbsp;<div class="selectColor" title="%%selectColor%%" id="idBorderRightColor" onClick="onSelectBGColor('idBorderRightColor', 'borderRightColor');"></div>&nbsp;
          </td><td><select name="borderRightStyle" onchange="updateCSSField()" title="%%title_border_right_style%%">
            <option value=''>%%undefined%%</option>
            <option value='solid'>%%solid%%</option>
            <option value='dotted'>%%dotted%%</option>
            <option value='dashed'>%%dashed%%</option>
          </select>
          </td></tr>
          <tr><td>%%bottom%%: 
          </td><td><input type="text" class="spin-control" name="borderBottomWidth" value='' title="%%title_border_bottom_width%%" style="width:30px;">&nbsp;
          </td><td><input type="text" class="field" name="borderBottomColor" value='' title="%%title_border_bottom_color%%" style="width:120px;">&nbsp;<div class="selectColor" title="%%selectColor%%" id="idBorderBottomColor" onClick="onSelectBGColor('idBorderBottomColor', 'borderBottomColor');"></div>&nbsp;
          </td><td><select name="borderBottomStyle" onchange="updateCSSField()" title="%%title_border_bottom_style%%">
            <option value=''>%%undefined%%</option>
            <option value='solid'>%%solid%%</option>
            <option value='dotted'>%%dotted%%</option>
            <option value='dashed'>%%dashed%%</option>
          </select>
        </td></tr></table>
      </div>
    </div>
</td><td valign=top width=242>
    <div style="position:relative;width:236px;padding:6px 4px 4px 4px;background-color: #dde7f8;color:#666;font-weight:bold;">
        ##--<div class="l-rt-c"></div><div class="l-lt-c"></div>--##
        %%css_editor_title%%
    </div>
    <div style="width:236px;height:360px;border:1px #dde7f8 solid;padding:3px;">
      <textarea class=ta style="font-family:tahoma;font-size:12px;width:236px;height:360px;border:0px;line-height:16px;" wrap=off name="css_text" onkeyup="updateCSSText()" title="%%title_css_text%%"></textarea>
    </div>
    <div style="padding-top:10px">
        <input class="but" type="button" name="ok" value="%%apply_btn%%" onclick="btnOKClick()">
        <input class="but" type="button" name="cancel" value="%%cancel_btn%%" onclick="btnCANCELClick()">
    </div>
</td></tr>
</table>
</form>

"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% %%title%%</TITLE>
<link rel="stylesheet" href="##admin_root####skin_path##_css/style.css" type="text/css">
<link rel="stylesheet" href="##admin_root####skin_path##_css/scroll_bars.css" type="text/css">
<SCRIPT>
var editorBaseHref = '##root_path_www##';
var sOldCSSText;

function updateCSSValues(){

    var oForm = document.sform;
    var oElement = window.oParameters.oElement;

    oForm.paddingTop.value = oElement.style.paddingTop;
    oForm.paddingRight.value = oElement.style.paddingRight;
    oForm.paddingBottom.value = oElement.style.paddingBottom;
    oForm.paddingLeft.value = oElement.style.paddingLeft;

    oForm.marginTop.value = oElement.style.marginTop;
    oForm.marginRight.value = oElement.style.marginRight;
    oForm.marginBottom.value = oElement.style.marginBottom;
    oForm.marginLeft.value = oElement.style.marginLeft;

    oForm['width'].value = oElement.style.width;
    oForm['height'].value = oElement.style.height;

    oForm['left'].value = oElement.style.left;
    oForm['top'].value = oElement.style.top;
    oForm['right'].value = oElement.style.right;
    oForm['bottom'].value = oElement.style.bottom;

    oForm['backgroundColor'].value = oElement.style.backgroundColor;
    document.getElementById('idBackgroundColor').style.backgroundColor = oForm['backgroundColor'].value;
    oForm['backgroundRepeat'].value = oElement.style.backgroundRepeat;
    oForm['backgroundPositionX'].value = oElement.style.backgroundPosition.substr(0, oElement.style.backgroundPosition.indexOf(' '));
    oForm['backgroundPositionY'].value = oElement.style.backgroundPosition.substr(oElement.style.backgroundPosition.indexOf(' ')+1);
    oForm['backgroundImage'].value = oElement.style.backgroundImage.replace(/url\(|\)/g, '').replace(/^["']/, '').replace(/['"]$/, '');

    oForm['zIndex'].value = oElement.style.zIndex;
    oForm['position'].value = oElement.style.position;
    
    oForm['borderLeftWidth'].value = oElement.style.borderLeftWidth;
    oForm['borderLeftColor'].value = oElement.style.borderLeftColor;
    document.getElementById('idBorderLeftColor').style.backgroundColor = oForm['borderLeftColor'].value;
    oForm['borderLeftStyle'].value = oElement.style.borderLeftStyle;
    oForm['borderTopWidth'].value = oElement.style.borderTopWidth;
    oForm['borderTopColor'].value = oElement.style.borderTopColor;
    document.getElementById('idBorderTopColor').style.backgroundColor = oForm['borderTopColor'].value;
    oForm['borderTopStyle'].value = oElement.style.borderTopStyle;
    oForm['borderRightWidth'].value = oElement.style.borderRightWidth;
    oForm['borderRightColor'].value = oElement.style.borderRightColor;
    document.getElementById('idBorderRightColor').style.backgroundColor = oForm['borderRightColor'].value;
    oForm['borderRightStyle'].value = oElement.style.borderRightStyle;
    oForm['borderBottomWidth'].value = oElement.style.borderBottomWidth;
    oForm['borderBottomColor'].value = oElement.style.borderBottomColor;
    document.getElementById('idBorderBottomColor').style.backgroundColor = oForm['borderBottomColor'].value;
    oForm['borderBottomStyle'].value = oElement.style.borderBottomStyle;

    oForm['color'].value = oElement.style.color;
    document.getElementById('idColor').style.backgroundColor = oForm['color'].value;
    oForm['fontSize'].value = oElement.style.fontSize;
    oForm['fontFamily'].value = oElement.style.fontFamily;
    oForm['textTransform'].value = oElement.style.textTransform;

    oForm['fontWeight'].checked = (oElement.style.fontWeight == 'bold');
    oForm['fontStyle'].checked = (oElement.style.fontStyle == 'italic');
    oForm['fontVariant'].checked = (oElement.style.fontStyle == 'small-caps');

    oForm['textDecorationLineThrough'].checked = (oElement.style.textDecoration.indexOf('line-through') > -1);
    oForm['textDecorationOverline'].checked = (oElement.style.textDecoration.indexOf('overline') > -1);
    oForm['textDecorationUnderline'].checked = (oElement.style.textDecoration.indexOf('underline') > -1);
    oForm['textDecorationBlink'].checked = (oElement.style.textDecoration.indexOf('blink') > -1);

}

function updateCSSField(){

    var oForm = document.sform;
    var oElement = window.oParameters.oElement;

    oElement.className = oForm.className.value;

    oElement.style.paddingTop = oForm.paddingTop.value;
    oElement.style.paddingRight = oForm.paddingRight.value;
    oElement.style.paddingBottom = oForm.paddingBottom.value;
    oElement.style.paddingLeft = oForm.paddingLeft.value;

    oElement.style.marginTop = oForm.marginTop.value;
    oElement.style.marginRight = oForm.marginRight.value;
    oElement.style.marginBottom = oForm.marginBottom.value;
    oElement.style.marginLeft = oForm.marginLeft.value;

    oElement.style.width = oForm['width'].value;
    oElement.style.height = oForm['height'].value;

    oElement.style.left = oForm['left'].value;
    oElement.style.top = oForm['top'].value;
    oElement.style.right = oForm['right'].value;
    oElement.style.bottom = oForm['bottom'].value;

    oElement.style.backgroundColor = oForm['backgroundColor'].value;
    oElement.style.backgroundRepeat = oForm['backgroundRepeat'].value;
    oElement.style.backgroundPosition = oForm['backgroundPositionX'].value + oForm['backgroundPositionY'].value;

    oElement.style.zIndex = oForm['zIndex'].value;
    oElement.style.position = oForm['position'].value;
    
    oElement.style.borderLeftWidth = oForm['borderLeftWidth'].value;
    oElement.style.borderLeftColor = oForm['borderLeftColor'].value;
    oElement.style.borderLeftStyle = oForm['borderLeftStyle'].value;
    oElement.style.borderTopWidth = oForm['borderTopWidth'].value;
    oElement.style.borderTopColor = oForm['borderTopColor'].value;
    oElement.style.borderTopStyle = oForm['borderTopStyle'].value;
    oElement.style.borderRightWidth = oForm['borderRightWidth'].value;
    oElement.style.borderRightColor = oForm['borderRightColor'].value;
    oElement.style.borderRightStyle = oForm['borderRightStyle'].value;
    oElement.style.borderBottomWidth = oForm['borderBottomWidth'].value;
    oElement.style.borderBottomColor = oForm['borderBottomColor'].value;
    oElement.style.borderBottomStyle = oForm['borderBottomStyle'].value;

    if(oForm['backgroundImage'].value != ''){
      oElement.style.backgroundImage = 'url('+oForm['backgroundImage'].value+')';
    }else{
      oElement.style.backgroundImage = '';
    }


    oElement.style.fontSize = oForm['fontSize'].value;
    oElement.style.color = oForm['color'].value;
    oElement.style.fontFamily = oForm['fontFamily'].value;
    oElement.style.textTransform = oForm['textTransform'].value;
    oElement.style.fontWeight = (oForm['fontWeight'].checked) ? 'bold' : '';
    oElement.style.fontStyle = (oForm['fontStyle'].checked) ? 'italic' : '';
    oElement.style.fontVariant = (oForm['fontVariant'].checked) ? 'small-caps' : '';

    oElement.style.textDecoration = (oForm['textDecorationLineThrough'].checked) ? oElement.style.textDecoration.concat(' line-through') : oElement.style.textDecoration.replace(/line-through/gi,'');
    oElement.style.textDecoration = (oForm['textDecorationOverline'].checked) ? oElement.style.textDecoration.concat(' overline') : oElement.style.textDecoration.replace(/overline/gi, '');
    oElement.style.textDecoration = (oForm['textDecorationUnderline'].checked) ? oElement.style.textDecoration.concat(' underline') : oElement.style.textDecoration.replace(/underline/gi, '');
    oElement.style.textDecoration = (oForm['textDecorationBlink'].checked) ? oElement.style.textDecoration.concat(' blink') : oElement.style.textDecoration.replace(/blink/gi, '');

    
    oForm.css_text.value = formatCSS(oElement.style.cssText);
}

function resetMargins(){
    window.oParameters.oElement.style.margin = '';
    updateCSSValues();
    updateCSSField();
}


function resetPaddings(){
    window.oParameters.oElement.style.padding = '';
    updateCSSValues();
    updateCSSField();
}

function updateCSSText(){
    window.oParameters.oElement.style.cssText = document.sform.css_text.value;
    updateCSSValues();
}

function btnOKClick() {
   window.returnValue = document.sform.css_text.value;
   closeDialogWindow();
}

function btnCANCELClick() {
   closeDialogWindow();
}

function formatCSS(sText){
  sText = sText.toLowerCase();
  sText = sText.replace(/;/g, ';\n');
  sText = sText.replace(/\n /g, '\n');
  return sText;
}

function switchBlock(sName){
  var oBlock = document.getElementById('block_' + sName);
  var oHeader = document.getElementById('header_' + sName);
  if(oBlock.className == 'smalltab-block'){
    oBlock.className = 'smalltab-block-active';
    oHeader.className = 'smalltab-header-active';
  }else{
    oBlock.className = 'smalltab-block';
    oHeader.className = 'smalltab-header';
  }
}

function onWindowShown(){

    window.top.amiSpin.addFields([
        document.sform.paddingTop,
        document.sform.paddingRight,
        document.sform.paddingBottom,
        document.sform.paddingBottom,
        document.sform.paddingLeft,
        document.sform.marginTop,
        document.sform.marginRight,
        document.sform.marginBottom,
        document.sform.marginLeft,
        document.sform.left,
        document.sform.top,
        document.sform.right,
        document.sform.bottom
        ], 
        10000, -10000, 1, 'px', updateCSSField
    );

    window.top.amiSpin.addFields([
        document.sform.width,
        document.sform.height,
        document.sform.borderLeftWidth,
        document.sform.borderRightWidth,
        document.sform.borderBottomWidth,
        document.sform.borderTopWidth,
        document.sform.fontSize
        ], 
        10000, 0, 1, 'px', updateCSSField
    );

    window.top.amiSpin.addFields([
        document.sform.backgroundPositionX,
        document.sform.backgroundPositionY
        ], 
        10000, -10000, 1, '%', updateCSSField
    );

    window.top.amiSpin.addFields([
        document.sform.zIndex
        ], 
        10000, 0, 1, '', updateCSSField
    );

    document.sform.className.value = window.oParameters.oElement.className;
    
    updateCSSValues();

    sOldCSSText = window.oParameters.oElement.style.cssText.toLowerCase();
    document.sform.css_text.value = formatCSS(sOldCSSText);
}

function styleColorToRGB(color){
    color = color.toString();
    var hex_string = '';
    if(color.indexOf('#') == 0){
        hex_string = color.substr(1);
    }else if(aParts = color.match(/rgb\((\d+),\s*(\d+),\s*(\d+)\s*\)/i)){
        for(var i = 1; i <= 3; i++){
            var val = parseInt(aParts[i]).toString(16);
            if(val.length == 1){
                val = '0' + val;
            }
            hex_string += val;
        }
    }else if(aParts = color.match(/^\d+$/i)){
        for(var hexpair = 0; hexpair < 3; hexpair++){
            var colbyte = color & 0xFF;
            color >>= 8;
            var nybble2 = colbyte & 0x0F;
            var nybble1 = (colbyte >> 4) & 0x0F;
            hex_string += nybble1.toString(16);
            hex_string += nybble2.toString(16);
        }
    }
    if(hex_string == ''){
        hex_string = '000000';
    }
    return hex_string.toLowerCase();
}

function onSelectBGColor(sColorMarkerId, sFieldName){
    oPopupParams = {markerId : sColorMarkerId, fieldName : sFieldName, color : '', v: 1};
    var oMarker = document.getElementById(sColorMarkerId);
    if(oMarker != null){
        var currentColor = oMarker.style.backgroundColor;
        oPopupParams.color = currentColor == '' ? '' : styleColorToRGB(currentColor);
    }
    
    var cbFunc = function(result, params){
        if(result != null){
            var oMarker = document.getElementById(params.markerId);
            var oField = document.getElementsByName(params.fieldName);
            if(oField.length > 0){
                oField = oField[0];
            }else{
                oField = null;
            }
            if(oMarker != null){
                oMarker.style.backgroundColor = result;
            }
            if(oField != null){
                oField.value = result;
            }
            updateCSSField();
        }
    }
    window.top.openExtDialog('%%color_properties%%', 'select_color.php', 0, 0, 555, 420, 0, 0, false, false, cbFunc, oPopupParams);
}
</SCRIPT>
</HEAD>

<BODY id=bdy style="margin:0px;">

##content##

</body>
</html>
