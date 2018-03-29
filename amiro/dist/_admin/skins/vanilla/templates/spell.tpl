%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/spell.lng"%%

<!--#set var="disabled"      value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
##meta##
<title>%%spell_title%%</title>
</head>
<body>
<b>%%paid_feature_disabled%%</b>
</body>
</html>
"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
##meta##
<meta http-equiv="expires" content="-1">
<meta http-equiv="pragma" content="no-cache">
<meta name="robots" content="noindex,nofollow">
<title>%%spell_title%%</title>
<STYLE>
body, td, p, a, input, textarea, select {font-family:Tahoma, sans; font-size:11px;}
</STYLE>
<script>
var spmsg_sentence_changed = '%%sentence_changed%%';
var spmsg_bad_html = '%%bad_html%%';
var spmsg_status = '%%msg_status%%';
var sp_wnd_status_process = '%%sp_wnd_status_process%%';
var gramm_err = '%%gramm_err%%';
var spell_err = '%%spell_err%%';
var unSpell = '%%un_spell%%';

</script>
<script src="##skin_path##_js/spell_checking.js?_cv=##cms_version##" type="text/javascript"></script>
</head>

<body onload="Init();" style="background-color:lightgrey;padding:2px;" >
  <form name=spell_form action="" onsubmit="setOperationTimeout('spellSkip(false)', 100);return false;" style="margin:0px">
   <table width=100% cellspacing=0 cellspacing=0 height=100%>
    <tr>
       <td valign=top>
         <div id="sp_description" style="font-weight:bold;">&nbsp;</div>
         <input name=sp_word type=txt value="" style="width:340px;color:#900000;font-weight:bold;display:none" onkeyup="if (window.event.keyCode != 27) spellWordChanged()">
         <div id=sp_sentence style="width:340px;height:92px;padding:2px;overflow-y:scroll;overflow-x:auto;border:2px #fff inset;background:#ffffff;word-break:break-all;" onkeydown="if (window.event.keyCode != 27) spellWordChanged()"  contenteditable=true></div><br>
       </td>
       <td valign=top align=center width=100%>
         <br>
         <table cellspacing=0 cellpadding=0 border=0>
         <tr><td>
           <input name="btnCancelChanges" type="button" value="%%btn_cancel_changes%%" onclick="spellCancelChanges()" style="width:100px;margin-bottom:4px;display:none;">
         </td></tr>
         <tr><td>
           <input name="btnSkip" type="submit" value="%%btn_skip%%" style="width:100px;margin-bottom:4px;">
         </td></tr>
         </table>
         <input name="btnSkipAll" type="button" value="%%btn_skip_all%%" onclick="setOperationTimeout('spellSkip(true)', 100);" style="width:100px;margin-bottom:4px;"><br><br>
         ##--<input type="button" value="%%btn_add%%" onclick="spellAdd()" style="width:100px;margin-bottom:4px;">--##
    </td></tr>
    <tr><td valign=top>
       <div style="font-weight:bold;">%%variants%%:</div>
       <select name=sp_suggests size=8 style="width:340px" ondblclick="if (!this.form.btnChange.disabled) {setOperationTimeout('spellChange(false)', 100);}"></select><br>
       %%language%%: <span id=sp_language></span>
    </td><td valign=top align=center>
       <br><input name="btnChange" type="button" value="%%btn_replace%%" onclick="setOperationTimeout('spellChange(false)',100);" style="width:100px;margin-bottom:4px;"><br>
       <input name="btnChangeAll" type="button" value="%%btn_replace_all%%" onclick="setOperationTimeout('spellChange(true)', 100);" style="width:100px;margin-bottom:4px;"><br><br><br><br><br><br><br>
       <input type="button" value="%%btn_close%%" onclick="window.returnValue = false; closeDialogWindow();" style="width:100px;">
       </td>
    </tr>
    <tr><td colspan=2 height=14><table cellspacing=0 cellpadding=2 border=0 width=100%>
    <tr><td style="border:1px #fff inset;" width=120>
       <div id="sp_wnd_status" style="font-weight:bold;">%%sp_wnd_status_process%%</div>
    </td><td style="border:1px #fff inset;font-weight:bold;" >
    <div style="background-color:#006699;width:0%;color:#ffffff;text-align:center;" id="sp_wnd_progress"></div>
    </td></tr></table></td>
    </tr>
  </table>
  </form>
</body>