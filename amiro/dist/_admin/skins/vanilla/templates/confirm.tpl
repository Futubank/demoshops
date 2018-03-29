%%include_language "templates/lang/confirm.lng"%%

<!--#set var="form" value="
<table cellspacing="5" cellpadding="0" border="0" class="frm">
  <tr>
    <td valign="top" align="center" >
      ##text##
    </td>
  </tr>
  <tr>
    <td valign="top" align="center" >
      <input type="button" class="but" value="  %%yes%%  " OnClick="##callback##;closeDialogWindow();">
      <input type="button" class="but" value="  %%no%%  " OnClick="closeDialogWindow();">
    </td>
  </tr>
</table>

"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%%</TITLE>
<base href="##admin_root##">
<link rel="stylesheet" href="##admin_root####skin_path##_css/style.css" type="text/css">
<link rel="stylesheet" href="##admin_root####skin_path##_css/scroll_bars.css" type="text/css">
<script src="jsapi.php" type="text/javascript"></script>
<script type="text/javascript" src="##admin_root####skin_path##_js/ami.jquery.js"></script>
<script src="##skin_path##_js/ami.admin.js" type="text/javascript"></script>
<script type="text/javascript">
<!--
var editorBaseHref = '##root_path_www##';

function _CloseOnEsc(evt) {
  evt = evt ? evt : window.event;
  if (evt.keyCode == 27){
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

<br>
<table width="100%">
<tr><td align=center valign=middle width="100%" height="100%">
##form##
</td></tr>
</table>

</BODY>
</HTML>
