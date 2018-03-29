##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/_buttons.lng"%%
%%include_language "templates/lang/favorites.lng"%%

<!--#set var="splitter" value=""-->

<!--#set var="favorites_header" value="
"-->

<!--#set var="favorites_empty" value="
<tr>
<td>&nbsp;&nbsp;</td><td width=100%>&nbsp;&nbsp;%%empty%%</td>
</tr>"-->

<!--#set var="favorites_row" value="
<tr onmouseover="this.bgColor='#DDF8E4';" onmouseout="this.bgColor='';"  onclick="this.all.item('names[]').checked=!this.all.item('names[]').checked;">
<td>
##if(is_active==1)##
<span style="color:#990000;padding-right:3px">&bull;</span>
##else##
&nbsp;&nbsp;
##endif##
</td>
<td width=100% style="padding:3px;">
<a href="##url##" target=_top  onclick="event.cancelBubble=true;">##name##</a></td>
<td valign=top><input type=checkbox name="names[]" value="##module_name##" onclick="event.cancelBubble=true;"></td>
</tr>"-->

<!--#set var="last_visited_row" value="<tr onmouseover="this.bgColor='#DDF8E4';" onmouseout="this.bgColor='';">
<td>&nbsp;&nbsp;</td>
<td style="padding:3px;" width=100%><div style="font-size:8px;">##date_time##</div><a href="##url##" target=_top >##name##</a></td>
</tr>"-->

<!--#set var="buttons" value="<tr>
<td align=left><a href="#" style="font-size:9px;color:#990000" onclick="addCurrentModuleToFavorites();return false;">[%%add_btn%%]<br></a></td>
<td align=right>##IF(show_del_btn)##<a href="#" style="font-size:9px;color:#990000" onclick="action_del();return false;">[%%delete_btn%%]<br></a>##ENDIF##</td>
</tr>"-->

<!--#set var="status" value="
<script>
##--if(top.document.getElementById('favorites_block').style.display=='none'){--##
	alert('##msg##');
##--}--##
</script>
"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
##styles##
##scripts##
<script type="text/javascript">
var editorBaseHref = '##root_path_www##';
var popupMove = false;
var popupCorrectX;
var popupCorrectY;
var popupStartX;
var popupStartY;
var popupBlock;

function _CloseOnEsc(evt){
  evt = amiCommon.getValidEvent(evt);
  if (evt.keyCode == 27) {
    parent.document.getElementById('favorites_block').style.display='none';
    return;
  }
}

function action_del(){
  bSet = false;
  var favorites = document.forms['favorites'];
  if (favorites.elements["names[]"].length){
    for(i=0;i<favorites.elements["names[]"].length;i++){
      if (favorites.elements["names[]"][i].checked){
        bSet = true;
      }
    }
  }else{
    if (favorites.elements["names[]"].checked){
      bSet = true;
    }
  }
  if (!bSet){
    alert('%%choose_elements%%');
    return false;
  }
  favorites.submit();
}

function Init(){
  popupBlock = parent.document.getElementById('favorites_block');
  document.body.onkeypress = _CloseOnEsc;
}

function addCurrentModuleToFavorites(){
    document.location.href = 'favorites.php?lang=' + parent.interface_lang + '&action=add&module_name=' + parent.module_name;
}

</script>
</HEAD>
<BODY id=bdy onload="Init()" onmousemove="return false;" style="overflow:hidden; margin:0px;width:362px;height:515px;background-color:#f8f8f8;">
<form name="favorites" action="favorites.php" method=GET>
<input type="hidden" name="action" value="delete">
<input type="hidden" name="module_name" value="##module_name##">
<input type="hidden" name="lang" value="##admin_lang##">
<table width=100% cellpadding=0 cellspacing=0 border=0 style="cursor:default;">
<tr style="background: #ABD7F4 url(skins/vanilla/images/popup-title-bg.gif) repeat-x;">
<td style="height:30px;color:#666;font-size:12px;font-weight:bold;padding-left:10px;" width=100%>%%favorites%%</td>
<td align=center valign=middle style="padding-right:3px;font-size:0px;"><img src="skins/vanilla/icons/icon_popup_close_btn.gif" 
 onclick="parent.document.getElementById('favorites_block').style.display='none';return false;" title="%%close_btn%%">
</td></tr>
</table>
<div style="height:430px;overflow:auto;cursor:default;margin:5px;">
<table cellpadding=0 cellspacing=0 width=100%>
##favorites_items##
</table>
<br>
<table cellpadding=0 cellspacing=0 width=100%>
##buttons##
</table>
<br>
</form>
<table cellspacing=0 cellpadding=0 width=100%>
<tr bgcolor="#FFE1A9"><td colspan=2 height=18 style="padding-left:5px;"><h3 style="font-size:10px;">%%last_visited%%</h3></td></tr>
##last_visited_items##
</table>
##--<hr style="color:#dedede">--##
</div>
##status_msg##
</BODY>
</HTML>