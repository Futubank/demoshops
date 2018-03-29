%%include_language "templates/lang/ce_templates.lng"%%
%%include_language "templates/lang/main.lng"%%

<!--#set var="select" value="
  <form name="tform">
    <b>%%select_template%%: </b>
    <select name="template_id" OnChange="tform.ok.disabled=true; changeTemplateForm('##obj_name##', document.tform.template_id.value);">
      ##select_list##
    </select>
    <input class="but" type="button" name="ok" value="%%apply_btn%%" onclick="btnOKClick(event)">
    <input class="but" type="button" name="cancel" value="%%cancel_btn%%" onclick="btnCANCELClick()">
    &nbsp;
  </form>
"-->


<!--#set var="select_row" value="
      <option value=##id## ##selected##>##name##</option>
"-->

<!--#set var="select_custom_row" value="
      ##--<option value=0 ##selected##>%%without_template%%</option>--##
"-->


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - %%title%%</TITLE>
<base href="##www_root##">
<link rel="stylesheet" href="##www_root####front_css_path##common.css" type="text/css">
<link rel="stylesheet" href="##www_root####front_css_path##default.css" type="text/css">
<link rel="stylesheet" href="##admin_root####skin_path##_css/style.css" type="text/css">
<link rel="stylesheet" href="##admin_root####skin_path##_css/scroll_bars.css" type="text/css">

<SCRIPT>
var editorBaseHref = '##root_path_www##';

var globalDoc
var grngMaster;
var editorBaseHref
var htmlSelectionControl = "Control";
var htmlText             = "Text;"
var selectionType;

function changeTemplateForm(objName, tplId){
    document.changetemplate.obj.value = objName;
    document.changetemplate.id.value = tplId;
    document.changetemplate.submit();
}

function Init(){
  /*
  editorBaseHref = top.editorBaseHref;
  globalDoc = top.document.all["_##obj_name##_editor"].contentWindow.document;
  var objname     = "##obj_name##";

  grngMaster = top.globalGrngMaster['##obj_name##'];
  selectionType = top.globalSelectionType['##obj_name##'];

  if (selectionType == htmlSelectionControl)
    var selectedHTML = grngMaster.item(0).outerHTML;
  else
    var selectedHTML = grngMaster.htmlText;
 
  var sTag = "#"+"#template_content#"+"#";
  var sBody = String(document.all["oTemplate"].innerHTML);
  
  // event handlers
  window.onunload = function() {globalDoc.getScrollTop() = top.globalScrollTop['##obj_name##']; globalDoc.body.getScrollLeft() = top.globalScrollLeft['##obj_name##'];};

  if (sBody.search(sTag) != -1)
    document.all["oTemplate"].innerHTML = sBody.replace(sTag, selectedHTML);
  else
    document.all["oTemplate"].innerHTML = sBody + selectedHTML;
  */
}

function btnCANCELClick() {
  closeDialogWindow();
}

function btnOKClick(evt) {
  var textareaName = "##obj_name##";
  top.makeUndoStep(textareaName, '%%un_ins_template%%');
  
  var textareaObject = top.document.getElementsByName(textareaName)[0];
  if(textareaObject != null && textareaObject.editorAttached && textareaObject.editorObject.currentMode == 'editor'){
    var editorObject = textareaObject.editorObject;
    
    editorObject.setEditorSelection(editorObject.sessionData.rng);
    editorObject.insertContent(document.getElementById("oTemplate").innerHTML);
    
    editorObject.formChanged(evt);
    editorObject.updateToolBar();
  }

  top.editor_updateHiddenField (textareaName);
  closeDialogWindow();
}
</SCRIPT>
</HEAD>

<BODY onload="Init();" id=bdy leftmargin="10" topmargin="10" bgcolor="#FFFFFF">
<br>
<div align="right">
##select##
</div>
<br>
<div id=oTemplate align=center style="padding-left:10px">
##template##
</div>
<form name="changetemplate" action="" method="GET"><input type="hidden" name="obj"><input type="hidden" name="id"></form>
</BODY>
</HTML>
