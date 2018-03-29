%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/ce_paste_proc.lng"%%

<!--#set var="content_plain" value="
    <script>currentType = 'plain'</script>
    <form name=sform method=post>
    <table width=100% cellspacing=10 cellpadding=0 border=0>
    <tr><td valign=top>
        <br>
        %%notification_text%%:
    </td></tr>
    <tr><td valign=top>
        <textarea class=ta style="font-size:11px; width:740px; height:360px;" name="cbvalue"></textarea>
    </td></tr>
    <tr><td valign=top>
        <input class="but" type="button" name="ok" value="%%apply_btn%%" onclick="btnOKClick()">
        <input class="but" type="button" name="cancel" value="%%cancel_btn%%" onclick="btnCANCELClick()">
    </td></tr>
    </table>

    </form>
"-->

<!--#set var="content_html" value="
    <script>currentType = 'html'</script>
    <form name=sform method=post>
    <table width=100% cellspacing=10 cellpadding=0 border=0>
    <tr><td valign=top>
        <br>
        %%notification_text%%:
    </td></tr>
    <tr><td valign=top>
        <iframe id="clipboardFrame" name="clipboardFrame" src="about:blank" style="width:740px; height:360px;" frameborder="no"></iframe>
    </td></tr>
    <tr><td valign=top>
        <input class="but-long" type="button" name="ok" value="%%clean_apply_btn%%" onclick="btnOKClick()">
        ##--<input class="but" type="button" name="proc" value="%%process_btn%%" onclick="btnProcessClick()">--##
        <input class="but" type="button" name="cancel" value="%%cancel_btn%%" onclick="btnCANCELClick()">
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

function onWindowShown(){
    if(currentType == 'plain'){
        document.sform.cbvalue.focus();
    }else{
        document.getElementById('clipboardFrame').contentWindow.document.designMode = "on";
        document.getElementById('clipboardFrame').contentWindow.focus();
    }
}

function btnCANCELClick(){
    closeDialogWindow();
}

function btnOKClick() {
  if(currentType == 'plain'){
    window.returnValue = document.sform.cbvalue.value.replace(/\n/g, '\n<br>');
  }else{
    window.returnValue = cleanCode(false);
  }
  closeDialogWindow();
}

function btnProcessClick(){
    cleanCode(true);
}

function cleanCode(isPasteBack){
    var documentBody = document.getElementById('clipboardFrame').contentWindow.document.body;
    var sHTML = documentBody.innerHTML;
    
    if(top.checkHTML(sHTML) > 0){
        sHTML = sHTML.replace(/\r\n/gi, 'SPECLINEBREAK');
        sHTML = sHTML.replace(/\r/gi, 'SPECLINEBREAK');
        sHTML = sHTML.replace(/\n/gi, 'SPECLINEBREAK');
        sHTML = sHTML.replace(/<meta.*?>/gi, '');
        sHTML = sHTML.replace(/<link.*?>/gi, '');
        sHTML = sHTML.replace(/<!--.*?-->/gi, '');
        sHTML = top.cleanHTML(sHTML, ('##formatted##' != '1' ? '' : 'MSOffice'));
        sHTML = sHTML.replace(/SPECLINEBREAK/gi, '\r\n');
    }
    
    if(isPasteBack){
        documentBody.innerHTML = sHTML;
    }else{
        return sHTML;
    }
}
</SCRIPT>
</HEAD>

<BODY id=bdy style="margin:0px;" bgcolor="#FFFFFF">

##content##

</body>
</html>
