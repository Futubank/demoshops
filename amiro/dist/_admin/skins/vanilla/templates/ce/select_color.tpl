%%include_language "templates/ce/editor.lng"%%
%%include_language "templates/lang/main.lng"%%

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html><head>
##metas##
<title>%%title_select_color%%</title>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css" />
<link rel="stylesheet" href="##skin_path##_css/scroll_bars.css" type="text/css" />
<script type="text/javascript">
var editorBaseHref = '##root_path_www##';
</script>
##scripts##
<script type="text/javascript">

var colorBChanged = false;

function onUnload(){
  errFunc = onUnload;
  top.globalCookieData = globalCookieData;
}

function onWindowShown(){                                                       // run on page load
  errFunc = onWindowShown;

  var color  = window.oParameters.color;

  sColors = getCookie('color_lc');
  var iIndex = 1;
  if (sColors!= null){
    aColors = sColors.split(",", 20);
    for(var i=0;i<aColors.length;i++){
      if (aColors[i] != ""){
        document.getElementById('color_lc_'+iIndex).bgColor = aColors[i];
        document.getElementById('color_lc_'+iIndex).title = aColors[i];
        iIndex++;
      }
    }
  }

  if ( ValidateColor(color) == null || color == '') {
    color = 'FFFFFF';
	}

  if ( color != ""){
    color_tables_set(color);                                                          // set default color
    document.getElementById('color_old').style.backgroundColor = color;
  }
}


function Set(string) {                   // select color
  errFunc = Set;
  color = ValidateColor(string);
  if (color == null) { alert('%%invalid_color%%' + string); }        // invalid color
  else {                                                                // valid color

    if ( color != "")
      color = "#"+color;

    bFound = false;

    for(var i=1;i<=16;i++){
      if (document.getElementById('color_sc_'+i).bgColor.toUpperCase() == color)
        bFound = true;
    }

    iCount = 0;
    for(var i=1;i<=20;i++){
      if (document.getElementById('color_lc_'+i).title != "" && document.getElementById('color_lc_'+i).bgColor.toUpperCase() == color)
        bFound = true;
      if (document.getElementById('color_lc_'+i).title != "")
        iCount++;
    }

    iStart = 2;
    if (color == "" || iCount < 20)
      iStart = 1;

    var aColor = Array();
    if (!bFound){
      sColors="";
      for(var i=iStart;i<=20;i++)
        if (document.getElementById('color_lc_'+i).title != "")
          aColor[ i - iStart ] = document.getElementById('color_lc_'+i).bgColor.toUpperCase();
        aColor[aColor.length] = color;
        sColors = aColor.toString();
        setCookie('color_lc', sColors);
    }

	  window.returnValue = color;

    closeDialogWindow();                       // close dialog
  }
}

function _color_tables_set(evt, paramName){
  evt = amiCommon.getValidEvent(evt);
  var target = amiCommon.getEventTarget(evt);
  color_tables_set(target[paramName]);
}

function ValidateColor(string) {                // return valid color code
  errFunc = ValidateColor;
  string = string || '';
  string = string + "";
  string = string.toUpperCase();
  chars = '0123456789ABCDEF';
  out   = '';

  for(var i=0; i<string.length; i++) {             // remove invalid color chars
    schar = string.charAt(i);
    if (chars.indexOf(schar) != -1) { out += schar; }
  }

  if (out.length != 6 &&  out.length > 0) { return null; }            // check length
  return out;
}

function validate(num, evt){
  errFunc = validate;
  evt = amiCommon.getValidEvent(evt);
  var target = amiCommon.srcEventTarget(evt);
  iVal = parseInt(target.value);
    if ( iVal != 'NaN' && iVal >= 0 && iVal <= num)
    return true;
  alert('%%enter_number%% [0 - '+ num+']');
  target.focus();
  amiCommon.stopEvent(evt);
}

function spinValue(num, evt){
  errFunc = spinValue;
  evt = amiCommon.getValidEvent(evt);
  var target = amiCommon.srcEventTarget(evt);
  iVal = parseInt(target.value);
  if (event.keyCode == 38 && iVal < num){
    target.value = iVal + 1;
    target.select();
  }
  if (event.keyCode == 40 && iVal > 0){
    target.value = iVal - 1;
    target.select();
  }

  if (event.keyCode == 33)
    if(iVal < num - 10){
      target.value = iVal + 10 ;
      target.select();
      amiCommon.stopEvent(evt);
    }else{
      target.value = num;
      target.select();
      amiCommon.stopEvent(evt);
    }
  if (event.keyCode == 34)
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
</script>
<style>
.spin-control{
    margin-bottom: 1px;
}
</style>
</head>
<body bgcolor="#ffffff" style="margin: 20px 0px; overflow:hidden" onUnload="onUnload()">
<div id=popup_content>
<form method=get name=color_picker onSubmit="Set(document.getElementsByName('color_html')[0].value); return false;" style="margin:0px">
<table align=center cellspacing=0 border=0 cellpadding=0>
<tr>
<td width=75 valign=top align=left>
<table cellspacing=1 cellpadding=0 width=65 bgcolor="#000000" style="cursor:pointer;" onclick="_color_tables_set(event, 'bgColor');" >
  <tr><td id=color_sc_1 height=31 width=31 nowrap bgColor="#000000" title="%%black%%"></td>
  <td id=color_sc_2 height=31 width=31 nowrap bgColor="#800000" title="%%maroon%%"></td></tr>
  <tr><td id=color_sc_3 height=31 width=31 nowrap bgColor="#008000" title="%%green%%"></td>
  <td id=color_sc_4 height=31 width=31 nowrap bgColor="#808000" title="%%olive%%"></td></tr>
  <tr><td id=color_sc_5 height=31 width=31 nowrap bgColor="#000080" title="%%navy%%"></td>
  <td id=color_sc_6 height=31 width=31 nowrap bgColor="#800080" title="%%purple%%"></td></tr>
  <tr><td id=color_sc_7 height=31 width=31 nowrap bgColor="#008080" title="%%teal%%"></td>
  <td id=color_sc_8 height=31 width=31 nowrap bgColor="#808080" title="%%gray%%"></td></tr>
  <tr><td id=color_sc_9 height=31 width=31 nowrap bgColor="#C0C0C0" title="%%silver%%"></td>
  <td id=color_sc_10 height=31 width=31 nowrap bgColor="#FF0000" title="%%red%%"></td></tr>
  <tr><td id=color_sc_11 height=31 width=31 nowrap bgColor="#00FF00" title="%%lime%%"></td>
  <td id=color_sc_12 height=31 width=31 nowrap bgColor="#FFFF00" title="%%yellow%%"></td></tr>
  <tr><td id=color_sc_13 height=31 width=31 nowrap bgColor="#0000FF" title="%%blue%%"></td>
  <td id=color_sc_14 height=31 width=31 nowrap bgColor="#FF00FF" title="%%fuchsia%%"></td></tr>
  <tr><td id=color_sc_15 height=31 width=31 nowrap bgColor="#00FFFF" title="%%aqva%%"></td>
  <td id=color_sc_16 height=31 width=31 nowrap bgColor="#FFFFFF" title="%%white%%"></td></tr>
</table>
</td>
<td width=255 height=255 nowrap valign=top>
  <table cellspacing="0" cellpadding="0" border=0 width=255 height=255>
  <tr><td width=255 height=255 nowrap style="border:1px #000 solid;background-color:#000">
  <div id="color_hs_table" style="background:url(skins/vanilla/images/hs_table.jpg);width:255px;height:255px" onmousedown="color_hs_set(event); return false;" onmousemove="if (event.button == 1) {color_hs_set(event); return false;}" ></div></td></tr>
</table>

<br>
<div style="margin-top:10px;margin-bottom:2px;">
  %%last_used%%
</div>
<table id="color_last_used" cellspacing=1 cellpadding=0 width=255 height=12 bgcolor="#000000" style="cursor:pointer;" onclick="_color_tables_set(event, 'title');">
  <tr>
  <td width=5% nowrap id=color_lc_1 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_2 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_3 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_4 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_5 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_6 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_7 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_8 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_9 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_10 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_11 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_12 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_13 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_14 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_15 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_16 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_17 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_18 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_19 bgColor="#FFFFFF"></td>
  <td width=5% nowrap id=color_lc_20 bgColor="#FFFFFF"></td>
  </tr>
</table>
</td>
<td width=20 nowrap>
</td>
<td width=20 height=255 valign=top>
  <table cellspacing="0" cellpadding="0" border=0 width=20 height=255 onclick="color_b_set(event); return false;" style="cursor:pointer;">
  <tr>
    <td nowrap valign=top id="color_b_table" width=20 height=255 onmousemove="if (event.button == 1) { color_b_set(event);return false;}" style="background: url(skins/vanilla/images/color_b_table.png)"></td>
  </tr>
  </table>
</td>
<td width=20 nowrap>
</td>
<td width=95 valign=top align=right>
<table width=100% cellspacing=0 cellpadding=0>
<tr><td width=100% valign=top align=center>
<div id=color_wc_block style="visibility:hidden;cursor=pointer;" onclick="correctColor();" align=center  title="%%webcolor_warn%%">
<img src="skins/vanilla/images/web_colors_btn.gif" width=15 height=16><br>
<div id=color_web_corrected style="width:15px;height:10px;border:1px #000 solid;"></div>
</div>
</td>
<td valign=top>
<div id=color_selected style="width:60px;height:30px;border:1px #000 solid;border-bottom:0px;"></div>
<div id=color_old style="width:60px;height:30px;border:1px #000 solid;border-top:0px;"></div>
</td></tr>
</table>
<br>
H <input class="spin-control" size="3" name=color_hsb_h value="" onchange="if (validate(360, event)) color_hsb_set();"><br>
S <input class="spin-control" size="3" name=color_hsb_s value="" onchange="if (validate(100, event)) color_hsb_set()"><br>
B <input class="spin-control" size="3" name=color_hsb_b value="" onchange="if (validate(100, event)) color_hsb_set()"><br>
<br>
R <input class="spin-control" size="3" name=color_rgb_r value="" onchange="if (validate(255, event)) color_rgb_set()"><br>
G <input class="spin-control" size="3" name=color_rgb_g value="" onchange="if (validate(255, event)) color_rgb_set()"><br>
B <input class="spin-control" size="3" name=color_rgb_b value="" onchange="if (validate(255, event)) color_rgb_set()"><br>
<br>
<nobr>HTML <input class="field" size="9" name=color_html value="" onchange="if ( !ValidateColor(this.value)) { alert('%%invalid_color%%'+this.value);this.focus();return false;} else _color_tables_set(event, this.value);"  onfocus="this.select();"></nobr><br><br>
<input class="but-95" type=submit value="%%set_color%%" style="margin-bottom:3px;"><br>
<input class="but-95" type=button value="%%no_color%%" onclick="Set('')" style="margin-bottom:3px;"><br>
<input class="but-95" type=button value="%%close%%" onclick="closeDialogWindow();"><br>
</form>
</td>
</table>
<div id=color_hs_pointer style="position:absolute;display:none;" onmousemove="fireEvent2(document.getElementById('color_hs_table'), 'mousemove');return false;"><img src=skins/vanilla/images/picker.gif width=13 height=13></div>
<div id=color_b_pointer style="position:absolute;display:none;cursor:pointer;" onmousemove="fireEvent2(document.getElementById('color_b_table'), 'mousemove');return false;"><img src=skins/vanilla/images/b_picker.gif width=30 height=8></div>
</td>
</form>
</div>
<script type="text/javascript">
    amiSpin.addFields([
            document.color_picker.color_hsb_h
        ],
        360, 0, 1, '', color_hsb_set
    );
    amiSpin.addFields([
            document.color_picker.color_hsb_s,
            document.color_picker.color_hsb_b
        ], 
        100, 0, 1, '', color_hsb_set
    );
    amiSpin.addFields([
            document.color_picker.color_rgb_r,
            document.color_picker.color_rgb_g,
            document.color_picker.color_rgb_b
        ], 
        255, 0, 1, '', color_rgb_set
    );
</script>
</body></html>