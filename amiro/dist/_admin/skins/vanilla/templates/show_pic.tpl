%%include_language "templates/lang/show_pic.lng"%%
<!--#set var="flash" value="
             <OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
              codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
              WIDTH="##width##" HEIGHT="##height##" id="01" ALIGN="" title="##alt##">
              <PARAM NAME=movie VALUE="##src##">
              <PARAM NAME=quality VALUE=high>
              <PARAM NAME=wmode VALUE=transparent>
              <PARAM NAME=bgcolor VALUE=#FFFFFF>
              <EMBED src="##src##" quality=high bgcolor=#FFFFFF  WIDTH="##width##" HEIGHT="##height##" NAME="01" ALIGN=""
              TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer"></EMBED>
             </OBJECT>
"-->

<!--#set var="image" value="<img src="##src##" title="##alt##">"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##meta##
<TITLE>##title##</TITLE>
##base##
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css">
<script src="jsapi.php" type="text/javascript"></script>
<script type="text/javascript" src="##skin_path##_js/ami.jquery.js"></script>
<script src="##skin_path##_js/ami.admin.js" type="text/javascript"></script>
<script type="text/javascript">
<!--
var editorBaseHref = '##root_path_www##';

function _CloseOnEsc(evt){
  evt = evt ? evt : window.event;
  if(evt.keyCode == 27){
    closeDialogWindow();
    return;
  }
}

function Init(){
  document.body.onkeypress = _CloseOnEsc;
}

-->
</script>


<BODY onload="Init();" id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">

<div align="center">
<br>
<input type="button" class=but value="  %%close_btn%%  " OnClick="closeDialogWindow()">

<br>
<br>
##object##
<br>
<br>

<input type="button" class=but value="  %%close_btn%%  " OnClick="closeDialogWindow()">
</div>

</form>
</BODY>
</HTML>
