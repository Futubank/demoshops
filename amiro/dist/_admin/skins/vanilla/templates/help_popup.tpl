##--!ver=0200 rules="-SETVAR|-IF"--##
%%include_language "templates/lang/main.lng"%%

<div id="help_window" style="display:none;position:absolute;">
<table cellspacing=0 cellpadding=0 border=0 width=100% height=100%>
<tr><td rowspan=2 colspan=2>
<iframe marginheight=0 marginwidth=0 width=100% height=100% name=help_body id=help_body src=""
frameborder=0 scrolling=no></iframe>
</td>
<td height=7 width=5 nowrap></td></tr>
<tr><td bgcolor=#333333 width=5 nowrap style="filter: alpha(opacity=70);"></td></tr>
<tr><td height=7 width=5 nowrap style="filter: alpha(opacity=70);"></td><td height=7 width=100% bgcolor=#333333 style="filter: alpha(opacity=70);"></td><td height=7 width=5 bgcolor=#333333 nowrap style="filter: alpha(opacity=70);"></td></tr></table>
</div>
<div id=help_window_body>
<head>
<style>
TABLE#help_table {font-family:sans-serif, Arial; border: 1px #0a246a solid; }
TD#help_header {background: #0a246a; padding:2px filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=1,StartColorStr='#0a246a',EndColorStr='#117AC6')}
TD#help_title {font-size:12px;color:#ffffff;font-weight:bold;padding-left:4px;}
TD#help_body {font-size:11px;border-top:2px #c0c0c0 solid;padding-left:4px;}
TD#help_status {background: lightyellow; font-size:10px; color:#006699; border-top: 1px #0a246a solid; }
BUTTON.btn_icon   { border: 1px #FFFFFF outset; width: 15px; height: 15px; BORDER-STYLE: normal; BACKGROUND-COLOR: #D0D0D0; margin-right:1px;  }
FORM {margin:0px}
</style>
</head>
<body >
<table id=help_table cellspacing=0 cellpadding=0 border=0 align=left width=100% height=100%" >
  <tr>
    <td id=help_header height=16>
      <table cellspacing=0 cellpadding=0 border=0 width=100% >
        <tr>
        <td id=help_title nowrap>%%help%%</td>
        <td align=right valign=middle><button class="btn_icon"
        onClick="top.helpWindowPositionChange();" unselectable=on><img
        src="skins/vanilla/images/popup_btn_position.gif" width=11 height=11 border=0></button>
        <button class="btn_icon"
        onClick="top.helpWindowClose();" unselectable=on><img
        src="skins/vanilla/images/popup_btn_close.gif" width=11 height=11 border=0></button></td></tr></table></td>
  </tr>
  <tr>
    <td id=help_text valign=top height=100%>
      <iframe width=100% height=100% marginheight=0 marginwidth=0 name=frame_help id=frame_help src="" frameborder=0 scrolling=auto ></iframe>
    </td>
  </tr>
  <tr>
    <td id=help_status height=10 valign=top><form>
    <input type=checkbox value="on" name="autohelp_check" onclick="top.autoHelpShow = this.checked; top.setCookie('autoHelpShow', (this.checked?'1':'0'))">&nbsp;<b>%%auto_help%%</b></form></td>
  </tr>
</table>
</body>
</div>
