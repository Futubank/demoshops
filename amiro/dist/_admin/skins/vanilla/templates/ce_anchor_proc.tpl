%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/ce_anchor_proc.lng"%%

<!--#set var="content" value="
<table width=100% cellspacing=10 cellpadding=0 border=0>
<tr><td valign=top>
<form name=sform method=post onsubmit="amiCommon.stopEvent(amiCommon.getValidEvent(event)); btnOKClick();">
    <br>
    %%name%%:&nbsp;&nbsp;
    <input type=text class=field style="width:290px;" name="anchor_name" value="">
    <br><br>
    <input class="but" type="button" name="ok" value="%%apply_btn%%" onclick="btnOKClick()">
    <input class="but" type="button" name="cancel" value="%%cancel_btn%%" onclick="btnCANCELClick()">
    <br>
</td></tr>
</table>

</form>

"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - %%title%%</TITLE>
<link rel="stylesheet" href="##admin_root####skin_path##_css/style.css" type="text/css">
<link rel="stylesheet" href="##admin_root####skin_path##_css/scroll_bars.css" type="text/css">
<SCRIPT>
var editorBaseHref = '##root_path_www##';

function Init(){

 
  // event handlers


  sform.anchor_name.value = window.dialogArguments.name;
  window.returnValue = null;

  sform.anchor_name.focus();

}


function btnCANCELClick() {
  closeDialogWindow();
  grngMaster.select();
}

function btnOKClick() {
  window.returnValue = sform.anchor_name.value;
	closeDialogWindow();
  grngMaster.select();
}
</SCRIPT>
</HEAD>

<BODY onload="Init();" id=bdy style="margin:0px;" bgcolor="#FFFFFF">

##content##

</body>
</html>
