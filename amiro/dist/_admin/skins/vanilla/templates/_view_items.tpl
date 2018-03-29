%%include_language "templates/lang/_view_items.lng"%%

<!--#set var="view_scripts" value="
<script type="text/javascript">
<!--

function initFilterOnChange() {
  var elements = "";
  oForm = document.forms[_cms_filter_form];
  var arrElements = oForm.elements;
  for(var i=0;i<arrElements.length ; i++){
    if (arrElements[i].tagName == "FIELDSET" || arrElements[i].tagName == "BUTTON"){
      continue;
    }
    if (getElementAttribute(arrElements[i], "unselectable") == "on"){
      continue;
    }
    if (arrElements[i].tagName == "INPUT" && arrElements[i].type=="hidden" && getElementAttribute(arrElements[i], "detectchanges") != "on"){
      continue;
    }
    if (arrElements[i].name && arrElements[i].name.substr(0, 9) != "_spec_opt"){
      elements += arrElements[i].tagName+"."+arrElements[i].id+"   "+arrElements[i].name+"";
      arrElements[i].title = "";
      clearRuntimeStyle(arrElements[i]);

      if (((arrElements[i].tagName == "INPUT" && arrElements[i].type == "text") || arrElements[i].tagName == "TEXTAREA") && getElementAttribute(arrElements[i], "prop") == "on"){
        showInputProperties(arrElements[i]);
        arrElements[i].onblur = function() {filterOnChange()};
        arrElements[i].onkeyup = function() {filterOnChange()};
        arrElements[i].onclick = function() {filterOnChange()};
      }

      if (arrElements[i].tagName == "INPUT" && arrElements[i].type == "checkbox"){
        arrElements[i].onclick = function() {filterOnChange()};
        arrElements[i].oldValue = arrElements[i].checked;
      }else{
        if (!arrElements[i].onchange)
          arrElements[i].onchange = function() {filterOnChange()};
        arrElements[i].onkeydown = function() {filterOnChange()};
        arrElements[i].oldValue = arrElements[i].value;
      }
    }
  }
}

function filterOnChange() {
  document.forms['saveViewForm'].elements['btn_save'].disabled = true;
}

function viewSaveClick() {
  top.document.forms[top._cms_document_form].elements['view_data'].value = document.forms['saveViewForm'].elements['view_data'].value
  top.setPopupIcon();
  closeDialogWindow();
  return false;
}

initFilterOnChange();

-->
</script>

"-->

<!--#set var="view_form" value="
  <form name="saveViewForm">
    <input class="but" type="button" name="btn_save" value=" %%btn_save%% " onClick="viewSaveClick();" ##save_disabled##>
    <input type="hidden" name="view_data" value="##view_data##">
    ##--<input type="hidden" name="view_data_changed" value="##view_data_changed##">--##
  </form>
"-->
