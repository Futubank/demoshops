%%include_language "templates/lang/layouts.lng"%%

<script type="text/javascript">


<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'layoutsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
var lay_over = '#dee7ff';
var prevCSS = "##css_file##";
var newCSSName = '##new_css_name##';
var timerGen;

var arrStylesBody = Array();

##styles_body_list##

function showMessage(message, modal){
    if (modal){
        alert(message);
    }else{
        if (typeof(message)=="string" && message.length > 0){
            document.getElementById('warn_block').innerHTML = message;
            document.getElementById('warn_block').style.display = 'block';
        }
    }
}

function hideMessage(){
    document.getElementById('warn_block').innerHTML = '';
    document.getElementById('warn_block').style.display = 'none';
}

function genLayoutAuto(){
  oForm = document.forms[_cms_document_form];
  if (oForm.elements["lay_auto_update"].checked){
    checkLayoutText(false);
    genLayout();
  }
}

function genLayout(){
  errFunc = genLayout;

  var oForm = document.forms[_cms_document_form];
  var layoutHTML = oForm.elements['body'].value;
  oLayout = document.getElementById("box_layout");
  
  if(oLayout){
    layoutHTML = layoutHTML.replace('#'+'#init#'+'#','');
    layoutHTML = layoutHTML.replace('#'+'#end#'+'#','');
    layoutHTML = layoutHTML.replace('#'+'#status_messages#'+'#','');
    layoutHTML = layoutHTML.replace('#'+'#lay_body_body#'+'#', oForm.elements['lay_body_type'].value);
    for (var i=1; i<=##template_blocks_number##; i++ ){
      if (oForm.elements['lay_f'+i+'_type']){
        layoutHTML = layoutHTML.replace('#'+'#lay_f'+i+'_body#'+'#', oForm.elements['lay_f'+i+'_type'].value);
      }
    }
    layoutHTML = layoutHTML.replace(/#\#.*?#\#/g, '');
    
    /* Remove all forms */
    var divLayout = document.createElement('div');
    divLayout.innerHTML = layoutHTML;
    var layoutForms = divLayout.getElementsByTagName('form');
    for(i = 0; i < layoutForms.length; i++){
        layoutForms[i].parentNode.removeChild(layoutForms[i]);
    }

    oLayout.innerHTML = divLayout.innerHTML;
    prepareLayoutHTML(oLayout);
    
    oLayout.onclick = OnLayoutClick;
    oLayout.onmouseover = OnLayoutMouseOver;
    oLayout.onmouseout = OnLayoutMouseOut;
  }
}

function OnLayoutClick(currentEvent){
  currentEvent = amiCommon.getValidEvent(currentEvent);
  target = amiCommon.getEventTarget(currentEvent);
  var oForm = document.forms[_cms_document_form];
  if (target && isClickableTag(target.tagName)){
    if(!target.id && isClickableTag(target.parentNode.tagName) && target.parentNode.id){
        target = target.parentNode;
    }
    var objTextarea = null;
    var findPhrase = '';
    if (document.getElementById('tab-page-body').style.display!='none'){
      objTextarea = oForm.elements['body'];
      findPhrase = '#'+'#'+target.id+'_body#'+'#';
    }else if (document.getElementById('tab-page-css').style.display!='none'){
      objTextarea = oForm.elements['body'];
      findPhrase = '#'+target.id;
    }
    if(objTextarea != null && findPhrase != ''){
        textareaFindAndSelect(objTextarea, findPhrase, true);
    }
  }
}

function OnLayoutMouseOver(currentEvent){
  currentEvent = amiCommon.getValidEvent(currentEvent);
  target = amiCommon.getEventTarget(currentEvent);
  if (target && (target.id != 'box_layout') && isClickableTag(target.tagName)){
    target.style.backgroundColor = lay_over;
  }
}

function OnLayoutMouseOut(currentEvent){
  currentEvent = amiCommon.getValidEvent(currentEvent);
  target = amiCommon.getEventTarget(currentEvent);
  if (target && ( target.id != 'box_layout') && isClickableTag(target.tagName)){
    target.style.backgroundColor = "";
  }
}

function checkLayoutText(modal){
  var oForm = document.forms[_cms_document_form];

  if (oForm.elements['body'].value.search('#'+'#init#'+'#') < 0){
    showMessage('%%tag_isnot_set1%% [#'+'#init#'+'#] %%tag_isnot_set2%%%%tag_init_isnot_set2%%', modal);
    return false;
  }
  if (oForm.elements['body'].value.search('#'+'#end#'+'#') < 0){
    showMessage('%%tag_isnot_set1%% [#'+'#end#'+'#] %%tag_isnot_set2%%%%tag_end_isnot_set2%%', modal );
    return false;
  }

  if (modal && oForm.elements['body'].value.search('#'+'#stat_agent#'+'#') < 0){
    if (!confirm('%%tag_isnot_set1%% [<div id=stat>#'+'#stat_agent#'+'#</div>] %%tag_isnot_set2%%%%tag_stat_isnot_set2%%.\n\n%%continue_confirm%%' )){
      return false;
    }
  }

  if (modal && oForm.elements['body'].value.search('#'+'#status_messages#'+'#') < 0){
    if(!confirm('%%tag_isnot_set1%% [#'+'#status_messages#'+'#] %%tag_isnot_set2%%.\n\n%%continue_confirm%%' )){
      return false;
    }
  }

  if (oForm.elements['body'].value.search('#'+'#lay_body_body#'+'#') > 0){
    var re = new RegExp('id=("|\')?lay_body("|\')?');
    if (oForm.body.value.search(re) > 0){
      //document.getElementById('input_lay_body').style.display='block';
      //oForm.elements['lay_body_type'].enabled=true;
    }else{
      showMessage('%%td_id_isnot_set1%% [#'+'#lay_body_body#'+'#] %%td_id_isnot_set2%% "id=lay_body"', modal );
      return false;
    }
  }else{
    showMessage('%%tag_isnot_set1%% [#'+'#lay_body_body#'+'#] %%tag_isnot_set2%%', modal );
    return false;
  }


  for (var i=1; i<=##template_blocks_number##; i++ ){
    if (oForm.elements['body'].value.search('#'+'#lay_f'+i+'_body#'+'#') > 0){
      var re = new RegExp('id=("|\')?lay_f'+i+'("|\')?');
      if (oForm.body.value.search(re) > 0){
        if (document.getElementById('input_lay_f'+i)){
          document.getElementById('input_lay_f'+i).style.display=tableRowShowStyle;

          oForm.elements['lay_f'+i+'_type'].disabled=false;
                    if (oForm.elements['lay_f'+i+'_type'].value==''){
                        oForm.elements['lay_f'+i+'_type'].value = '%%block_name%% - ' + i;
                    }
        }
      }else{
        showMessage('%%td_id_isnot_set1%% [#'+'#lay_f'+i+'_body#'+'#] %%td_id_isnot_set2%% "id=lay_f'+i+'"', modal);
        return false;
      }
    }else{
      if (document.getElementById('input_lay_f'+i)){
        document.getElementById('input_lay_f'+i).style.display='none';
        oForm.elements['lay_f'+i+'_type'].disabled=true;
      }
    }
  }

  hideMessage();
    return true;

}


function CheckForm(form, action) {
   var errmsg = "";

   if (form.ta_current.value == "body") {
       var res = oTextEditor.save();
       if(res === false){
           form.ta_position.value = getCaretPos('bodytxt');
       }else{
           form.ta_position.value = res;
       }
   } else if (form.ta_current.value == "css") {
       var res = oTplCssEditor.save();
       if(res === false){
           form.ta_position.value = getCaretPos('css_file_body');
       }else{
           form.ta_position.value = res;
       }
   } else if (form.ta_current.value == "css-custom") {
       var res = oGlbCssEditor.save();
       if(res === false){
           form.ta_position.value = getCaretPos('custom_css_file_body');
       }else{
           form.ta_position.value = res;
       }
   } else if (form.ta_current.value == "html_head_tail") {
       form.ta_position.value = getCaretPos('html_head_tail');
   }

   if (form.ffilename.value=="") {

     if ( !checkLayoutText(true))
       return false;

     if (form.name.value=="") {
         return focusedAlert(form.name, '%%name_warn%%');
     }
     if (!form.lay_body_type.disabled && form.lay_body_type.value=="") {
         return focusedAlert(form.lay_body_type, '%%lay_body_type_warn%%');
     }

     if ((form.css_file_create.value=="") && (form.css_file.value=="")) {
         errmsg+='%%css_file_warn%%';
         baseTabs.showTab('css');
         alert(errmsg);
         form.css_file.focus();
         return false;
     }


    if(form.css_file_create.value!=""){
      if(!form.css_file_create.value.match(/^[a-zA-Z0-9-_.]/) || (form.css_file_create.value.substr(form.css_file_create.value.length-4) != '.css')) {
        baseTabs.showTab('css');
        alert("%%css_file_name_warn%%");
        form.css_file_create.focus();
        return false;
      }
      for (var i=0;i<form.css_file.options.length;i++){
        if ((i > 0) && form.css_file_create.value == form.css_file.options[i].value){
         errmsg+='%%css_already_exists%%';
         baseTabs.showTab('css');
         alert(errmsg);
         form.css_file_create.focus();
         return false;
        }
      }

     baseTabs.showTab('options');
     ##lay_f_type_scripts##
     baseTabs.showTab('body');
    }
  }

    // trim html_head_tail code, check html syntax partially
    var re = /^\s+(.*)\s+$/g;
    form.html_head_tail.value = form.html_head_tail.value.replace(re, '$1');
    if (form.html_head_tail.value != '') {
        re = /\<[^\>]+\>/g;
        var code = form.html_head_tail.value.replace(re, '');
        if ((code.indexOf('<') > -1 || code.indexOf('>') > -1) && !confirm('%%unmatched_lt_gt%%')) {
            baseTabs.showTab('html_head_tail');
            form.html_head_tail.focus();
            return false;
        }
    }

  form.is_default.disabled = false;
  return true;
}

function DeleteLayout(id, new_id) {

  form = document.layoutsform;

  form.force_id.value = id;
  form.new_id.value = new_id;
  user_click('del', id);
}

function OnObjectKeyUp(object, evt){
  oForm = document.forms[_cms_document_form];
  if (!evt.repeat) {
    var bUpdate = false;
    for (var i=1; i<=##template_blocks_number##; i++ ){
      if (object.name=='lay_f'+i+'_type'){
        bUpdate = true;
      }
    }
    if (object.name=="body" || object.name=='lay_body_type'){
      bUpdate = true;
    }
    if (bUpdate){
      genLayoutAuto();
    }
  }
}



function OnObjectChanged_layouts_form(name, first_change, evt){
  oForm = document.forms[_cms_document_form];
  if (name=="css_file"){
    var bChange = true;
    if (!confirm('%%change_css_file_alert%%')){
      bChange = false;
    }
    if (bChange){
      AMI.find('#css_file_create_row').style.display = oForm.elements["css_file"].selectedIndex ? 'none' : 'table-row';
      if(document.layoutsform.ta_css_highlight_flag.checked){
          oTplCssEditor.save();
          oTplCssEditor.highlight(false, false);
      }
      oForm.elements["css_file_body"].value = arrStylesBody[oForm.elements["css_file"].value];
      if(document.layoutsform.ta_css_highlight_flag.checked){
          oTplCssEditor.highlight(true, false);
      }
      prevCSS = oForm.elements["css_file"].value;
      if (oForm.elements["css_file"].value == ""){
        if (oForm.elements["css_file_create"].value==""){
          oForm.elements["css_file_create"].value = newCSSName;
        }
      }else{
        oForm.elements["css_file_create"].value = "";
      }
    }else{
      oForm.elements["css_file"].value = prevCSS;
      return false;
    }
  }
  return true;
}
addFormChangedHandler(OnObjectChanged_layouts_form);

function onNewNameEnter(){
  oForm = document.forms[_cms_document_form];
  if (oForm.elements["css_file"].selectedIndex != 0){
    oForm.elements["css_file"].selectedIndex = 0;
  }
}

var bTplCssFixed = false;
var bGlbCssFixed = false;

var bTplHl = false;
var bGlbHl = false;

function onTabSelectedCustom(tab_id, bState) {
   // save latest textarea scroll position
   if(bState){
       var layout_id = document.layoutsform.id.value;
       var cur_tab = getCookie("layout_current_tab_" + layout_id);

       var fnEd = function(ed){
           return function(){
               ed.highlight(false, true);
               ed.highlight(true, true);
           }
       }

       if (tab_id == "css") {
           if(!bTplCssFixed && (typeof(oTplCssEditor) != 'undefined') && document.layoutsform.ta_css_highlight_flag.checked){
               setTimeout(fnEd(oTplCssEditor), 200);
               bTplCssFixed = true;
           }
       } else if (tab_id == "css-custom") {
           if(!bGlbCssFixed && (typeof(oGlbCssEditor) != 'undefined') && document.layoutsform.ta_glb_highlight_flag.checked){
               setTimeout(fnEd(oGlbCssEditor), 200);
               bGlbCssFixed = true;
           }
       }

       if (cur_tab == "css") {
         //setCookie("layout_css_pos_" + layout_id, getCaretPos('css_file_body'), '', 0, 1);
       } else if (cur_tab == "css-custom") {
         //setCookie("layout_css_global_pos_" + layout_id, getCaretPos('common_css_file_body'), '', 0, 1);
       } else if (cur_tab == "html_head_tail") {
         //setCookie("layout_html_head_tail_pos_" + layout_id, getCaretPos('html_head_tail'), '', 0, 1);
       } else {
         //setCookie("layout_body_pos_" + layout_id, getCaretPos('bodytxt'), '', 0, 1);
       }

       // switch to new tab
       //baseTabs.showTab(tab_id);

       // save latest visible textarea
       setCookie("layout_current_tab_" + layout_id, tab_id, '', 0, 1);
       document.layoutsform.ta_current.value = tab_id;

       // restore scroll position
       restoreTabPos(tab_id);
   }
   return true;
}

function restoreTabPos(tab_id) {
  var scroll_pos;
  var layout_id = document.layoutsform.id.value;

  scroll_pos = getTabPosition(tab_id);

  if (scroll_pos) {
    if (tab_id == "css") {
        //setCaretPos("css_file_body", scroll_pos);
    } else if (tab_id == "css-custom") {
        //setCaretPos("common_css_file_body", scroll_pos);
    } else if (tab_id == "html_head_tail") {
        //setCaretPos("html_head_tail", scroll_pos);
    } else {
        //setCaretPos("bodytxt", scroll_pos);
    }
  }
}

function getTabPosition(tab_id) {
    var scroll_pos;
    var layout_id = document.layoutsform.id.value;

    if (tab_id == "css") {
        scroll_pos = getCookie("layout_css_pos_" + layout_id);
    } else if (tab_id == "css_global") {
        scroll_pos = getCookie("layout_css_global_pos_" + layout_id);
    } else if (tab_id == "html_head_tail") {
        scroll_pos = getCookie("layout_html_head_tail_pos_" + layout_id);
    } else {
        scroll_pos = getCookie("layout_body_pos_" + layout_id);
    }

    return scroll_pos;
}

function LocalBodyOnLoad() {
   var layout_id = document.layoutsform.id.value;

   // get latest visible tab
   var last_tab = getCookie("layout_current_tab_" + layout_id);
   if (!last_tab) {
        last_tab = getCookie("layout_current_tab_");
        if (!last_tab) {
            last_tab = document.layoutsform.ta_current.value;
        }
   }
   if (!last_tab) {
        last_tab = 'body';
        document.layoutsform.ta_current.value = "body";
   }
   setCookie("layout_current_tab_" + layout_id, last_tab, '', 0, 1);

   if (last_tab != 'body') {
        baseTabs.showTab(last_tab);
   }

   var last_pos = document.layoutsform.ta_position.value;
   if (last_tab == "css") {
        setCaretPos("css_file_body", last_pos);
   } else if (last_tab == "css-custom") {
        setCaretPos("custom_css_file_body", last_pos);
   } else if (last_tab == "html_head_tail") {
        setCaretPos("html_head_tail", last_pos);
   } else {
        setCaretPos("bodytxt", last_pos);
   }

   var bHighlight = false;

   bHighlight = (document.layoutsform.ta_highlight.value == "yes");
   if(bHighlight){
       document.layoutsform.ta_highlight_flag.checked = true;
       oTextEditor.highlight(true);
   }else{
       document.layoutsform.ta_highlight_flag.checked = false;
       AMI.find('#_hl_search_bar').style.display = 'none';
   }

   bHighlight = (document.layoutsform.ta_css_highlight.value == "yes");
   if(bHighlight){
       document.layoutsform.ta_css_highlight_flag.checked = true;
       oTplCssEditor.highlight(true);
   }else{
       document.layoutsform.ta_css_highlight_flag.checked = false;
       AMI.find('#_hl_css_search_bar').style.display = 'none';
   }

   bHighlight = (document.layoutsform.ta_glb_highlight.value == "yes");
   if(bHighlight){
       document.layoutsform.ta_glb_highlight_flag.checked = true;
       oGlbCssEditor.highlight(true);
   }else{
       document.layoutsform.ta_glb_highlight_flag.checked = false;
       AMI.find('#_hl_glb_search_bar').style.display = 'none';
   }
}

function _hlCtrlFWarning(){
    var el = document.getElementById('_hl_search');
    // todo
    el.focus();
    alert('%%hl_ctrlf_warning%%');
    el.focus();
}

function hl_searchEnterKeyPress(e, el, mode){
    var textEditor = oTextEditor;
    if(mode == 'css'){
        textEditor = oTplCssEditor;
    }
    if(mode == 'glb'){
        textEditor = oGlbCssEditor;
    }
    var evt=(e)?e:(window.event)?window.event:null;
    if(evt){
        var key=(evt.charCode)?evt.charCode:
            ((evt.keyCode)?evt.keyCode:((evt.which)?evt.which:0));
        if(key=="13"){
            textEditor.search(el.value);
            el.focus();
            return false;
        }
    }
    return true;
}

function hl_replaceEnterKeyPress(e, elSearch, elReplace, mode){
    var textEditor = oTextEditor;
    if(mode == 'css'){
        textEditor = oTplCssEditor;
    }
    if(mode == 'glb'){
        textEditor = oGlbCssEditor;
    }
    var evt=(e)?e:(window.event)?window.event:null;
    if(evt){
        var key=(evt.charCode)?evt.charCode:
            ((evt.keyCode)?evt.keyCode:((evt.which)?evt.which:0));
        if(key=="13"){
            textEditor.replace(elSearch.value, elReplace.value, '%%hl_confirm_replace%%');
            elReplace.focus();
            return false;
        }
    }
    return true;
}

function hl_onoff(cbEl, mode){
    var textEditor = oTextEditor;
    var searchBar = AMI.find('#_hl_search_bar');
    var ctab = document.layoutsform.ta_current.value;
    var hlValEl = document.layoutsform.ta_highlight;
    if(mode == 'css'){
        textEditor = oTplCssEditor;
        hlValEl = document.layoutsform.ta_css_highlight;
        searchBar = AMI.find('#_hl_css_search_bar');
    }
    if(mode == 'glb'){
        textEditor = oGlbCssEditor;
        hlValEl = document.layoutsform.ta_glb_highlight;
        searchBar = AMI.find('#_hl_glb_search_bar');
     }
    textEditor.highlight(cbEl.checked);
    hlValEl.value = cbEl.checked ? 'yes' : 'no';
    searchBar.style.display = cbEl.checked ? 'block' : 'none';
 }

function exportLayouts() {
    openDialog('%%btn_export%%', 'layouts.php?action=export_form', 600, 400);
}

function importLayouts() {
    openDialog('%%btn_import%%', 'layouts.php?action=import_form', 600, 600);
}

function openMarket(url) { // frame?
    document.location = url;
}

//-->
</script>

<!--#set var="styles_body_item" value="arrStylesBody['##path##'] = '##body##';
"-->

<!--#set var="css_item" value="<option value="##path##" ##selected## >##name##</option>
"-->

<!--#set var="del_warning" value="
<script type="text/javascript">
<!--
if(confirm("%%del_warn1%% ##cnt## %%del_warn2%%")) {
  document.layoutsform.force_id.value = ##id##;
  user_click('del', ##id##);
}
-->
</script>
"-->

<!--#set var="del_callback" value="window.parentWindow.DeleteLayout(##id##, document.newlayform.new_layout.value)"-->

<!--#set var="layout_row" value="<option value=##id## ##selected##>##name##</option>"-->
<!--#set var="del_warning_text" value="
  %%del_warn1%% ##cnt## %%del_warn2%%<br>
  <form name="newlayform" method="post">
  <select name="new_layout">
  ##layouts##
  </select><br>
  </form>
  %%del_warn3%%
"-->
<!--#set var="del_warning_text_no_pages" value="
<div align="center">%%del_warn_no_pages%%</div>
<form name="newlayform" method="post">
<input name="new_layout" type=hidden value=0>
</form>
"-->

<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
"-->

<!--#set var="lay_f_type_field" value="
     <tr id=input_lay_f##lay_f_num## ##if (lay_f_value=="")## style="display:none" ##endif##>
       <td>
%%lay_fN_type%% ##lay_f_num##*:
</td>
       <td>
         <input type=text name=lay_f##lay_f_num##_type class="field field70" value="##lay_f_value##" maxlength="32" onkeyUp="if (!event.repeat) {genLayoutAuto(); }">
       </td>
     </tr>
"-->

<!--#set var="lay_f_type_script" value="
     if (!form.lay_f##lay_f_num##_type.disabled && form.lay_f##lay_f_num##_type.value=="") {
         form.lay_f##lay_f_num##_type.focus();
         return focusedAlert(form.lay_f##lay_f_num##_type, '##lay_f_type_warn##');
         return false;
     }
"-->

<!--#set var="lay_migration_buttons" value="
    <div style="margin-left:-5%; margin-top: -40px;">
        <button class="but" id="buttonExport" onclick="exportLayouts();">%%btn_export%%</button>
        <button class="but" id="buttonImport" onclick="importLayouts();">%%btn_import%%</button>
        ##if(!empty(market_link))##<button class="but" id="buttonMarket" onclick="openMarket('##market_link##');">%%btn_market%%</button>##endif##
    </div>
    <br/>
"-->

<!--#set var="popup_common_js" value="
    function onSendForm(form) {
        var shadowDiv = document.createElement('DIV');
        shadowDiv.id = 'processingRequestShadow';
        shadowDiv.className = 'processingRequestShadow';
        shadowDiv.style.width = '100%';
        shadowDiv.style.height = '100%';
        document.body.appendChild(shadowDiv);
        var processingDiv = document.getElementById('request_processing');
        if(processingDiv != null) {
            processingDiv.style.display = 'block';
            processingDiv.style.top = Math.floor((window.innerHeight - processingDiv.offsetHeight) / 2) + 'px';
            processingDiv.style.left = Math.floor((window.innerWidth - processingDiv.offsetWidth) / 2) + 'px';
        }
        return true;
    }

    function onWindowShown() {
        var container = top.document.getElementById('popupWindow_' + window.popupInstanceId);
        var frame = top.document.getElementById('popupWindowFrame_' + window.popupInstanceId);
        if(container != null && frame != null) {
        }
    }
"-->

<!--#set var="export_form" value="
    <script type="text/javascript">
        function validateForm(form) {
            onSendForm(form);
            return true;
        }
        ##common_js##
    </script>
    <form action="layouts.php?action=export" class="design-import-export-popup" method="POST" onsubmit="validateForm(this)">
    <table style="width: 100%;">
        <tr><td>%%export_name%%:</td><td align="right"><input type="text" class="field field70" maxlength="20" name="export_name"/></td></tr>
        <tr><td>%%export_author%%:</td><td align="right"><input type="text" class="field field70" maxlength="20" name="export_author"/></td></tr>
        <tr><td>%%export_includes%%:</td><td></td></tr>
        <tr><td></td><td><label><input type="checkbox" name="export_images" checked/>%%export_images%%</label></td></tr>
        <tr><td></td><td><label><input type="checkbox" name="export_templates" checked/>%%export_templates%%</label></td></tr>
        <tr><td></td><td><label><input type="checkbox" name="export_options" checked/>%%export_options%%</label></td></tr>
        <tr><td colspan="2"><input class="but-244" type="submit" value="%%export%%"/></td></tr>
    </table>
    </form>
    <div id="request_processing" class="processingRequest" style="z-index:1000000; position:fixed; display:none">
        <div style="">
            <div class="cssload-thecube">
                <div class="cssload-cube cssload-c1"></div>
                <div class="cssload-cube cssload-c2"></div>
                <div class="cssload-cube cssload-c4"></div>
                <div class="cssload-cube cssload-c3"></div>
            </div>
        </div>
     </div>
"-->

<!--#set var="export_done" value="
    <script type="text/javascript">
        ##common_js##
    </script>
    <div style="text-align:center;font-size: 13px;">%%export_done%% <br> <br>
        <a class="but-244" href="##download_link##" target="_blank"/>%%export_download%%</a>
    </div>
"-->

<!--#set var="export_fail" value="
    <script type="text/javascript">
        ##common_js##
    </script>
    <div style="text-align:center;font-size: 13px;">%%export_fail%%</div>
"-->

<!--#set var="import_form" value="
    <script type="text/javascript">
        function validateForm(form) {
            onSendForm(form);
            return true;
        }
        ##common_js##
    </script>
    <form action="layouts.php?action=import_params" class="design-import-export-popup" method="POST" onsubmit="validateForm(this)">
    <table style="width: 100%">
        ##if(!empty(design_rows))##
        <tr><td><b>%%import_files%%:</b></td><td></td></tr>
        <tr><td colspan="2">
            <table class="design_rows">
                ##design_rows##
            </table>
        </td></tr>
        ##else##
            <tr><td colspan="2">
                ##design_name## (##design##)
                <input type="hidden" name="import_design" value="##design##"/>
            </td></tr>
         ##endif##
        <tr><td><b>%%import_includes%%:</b></td><td></td></tr>
        <tr><td colspan="2"><label><input type="checkbox" name="import_images" checked/>%%import_images%%</label></td></tr>
        <tr><td colspan="2"><label><input type="checkbox" name="import_templates" checked/>%%import_templates%%</label></td></tr>
        <tr><td colspan="2"><label><input type="checkbox" name="import_options" checked/>%%import_options%%</label></td></tr>
		
		<tr><td colspan="2">&nbsp;</td></tr>
		
		<tr><td style="text-align: left;" colspan="2"><label><input type="checkbox" name="import_delete_layouts"/>%%import_delete_layouts%%</label></td></tr>
        <tr><td colspan="2"><input class="but-244" type="submit" value="%%import%%"/></td></tr>
    </table>
    </form>
    <div id="request_processing" class="processingRequest" style="z-index:1000000; position:fixed; display:none">
        <div style="">
            <div class="cssload-thecube">
                <div class="cssload-cube cssload-c1"></div>
                <div class="cssload-cube cssload-c2"></div>
                <div class="cssload-cube cssload-c4"></div>
                <div class="cssload-cube cssload-c3"></div>
            </div>
        </div>
     </div>
"-->

<!--#set var="import_form_empty" value="
    <script type="text/javascript">
        ##common_js##
    </script>
    <div style="font-size: 13px;">
        %%import_empty%%
    </div>
"-->

<!--#set var="import_form_design_row" value="
    <tr><td colspan="2"><label>
        <input type="radio" name="import_design" value="##filename##" ##checked##/>
            ##filename## [##version##] (%%design_name%%: ##name##, %%design_author%%: ##author##)
    </label></td></tr>
"-->

<!--#set var="import_params" value="
    <script type="text/javascript">
        function validateForm(form) {
            onSendForm(form);
            return true;
        }
        ##common_js##
    </script>
    <form class="design-import-export-popup" action="layouts.php?action=import" method="POST" onsubmit="validateForm(this)">
    <table style="width: 100%;">
        <tr><th>%%import_source_layouts_column%%:</th><th>%%import_destination_layouts_column%%:</th></tr>
        ##layout_rows##

        <tr><td colspan="2">&nbsp;</td></tr>
        <tr><td colspan="2">
            ##hiddens##
            <input class="but but-244" type="submit" value="%%import%%"/>
        </td></tr>
    </table>
    </form>
    <div id="request_processing" class="processingRequest" style="z-index:1000000; position:fixed; display:none">
        <div style="">
            <div class="cssload-thecube">
                <div class="cssload-cube cssload-c1"></div>
                <div class="cssload-cube cssload-c2"></div>
                <div class="cssload-cube cssload-c4"></div>
                <div class="cssload-cube cssload-c3"></div>
            </div>
        </div>
     </div>
"-->

<!--#set var="import_params_external_row" value="
    <tr><td>##name##:</td>
    <td><select name="import_layout[##id##]">
        ##if(allow_empty)##<option value="">---</option>##endif##
        ##rows##
    </select></td></tr>
"-->

<!--#set var="import_params_external_option_row" value="
    <option value="##path##" ##selected##>##name##</option>
"-->

<!--#set var="import_params_external_hidden_row" value="
    <input type="hidden" name="##name##" value="##value##"/>
"-->

<!--#set var="import_params_empty" value="
    <script type="text/javascript">
        ##common_js##
    </script>
    <div style="text-align:center">%%import_fail%%</div>
"-->

<!--#set var="import_done" value="
    <script type="text/javascript">
        ##common_js##
    </script>
    <script type="text/javascript">
        setTimeout(function() {if(top != null && top.location.search.indexOf('mod_id=ami_market') < 0) { top.location.reload(); }}, 1000);
    </script>
    <div style="text-align:center">%%import_done%%</div>
"-->

<!--#set var="import_fail" value="
    <script type="text/javascript">
        ##common_js##
    </script>
    <div style="text-align:center">%%import_fail%%</div>
"-->


    <form action=##script_link## method=post enctype="multipart/form-data" name="layoutsform" onSubmit="return CheckForm(window.document.layoutsform, '##action##');">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="force_id" value="">
     <input type="hidden" name="new_id" value="">
     <input type="hidden" name="action" value="##action##">
     <input type="hidden" name="ta_position" value="##ta_position##">
     <input type="hidden" name="ta_highlight" value="##ta_highlight##">
     <input type="hidden" name="ta_css_highlight" value="##ta_css_highlight##">
     <input type="hidden" name="ta_glb_highlight" value="##ta_glb_highlight##">
     <input type="hidden" name="ta_current" value="##ta_current##">
     ##filter_hidden_fields##
     <input type="hidden" name="MAX_FILE_SIZE" value="##MAX_FILE_SIZE##">
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
     <tr>
       <td valign=top>
         <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
    <col width="150">
    <col width="*">
           <tr><td colspan=2>
             <nobr><input type="checkbox" id="is_default" name="is_default" ##is_default## value="1"> <label for="is_default">%%is_default%%</label></nobr>
           </td></tr>
             <tr><td>
             %%name%%*:
             </td><td>
             <input type=text name=name class="field field70" value="##name##" maxlength="128">
             </td></tr>
             <tr id=input_lay_body>
               <td>
        %%lay_body_type%%*:
        </td>
               <td>
                 <input type=text name=lay_body_type class="field  field70" value="##lay_body_value##" maxlength="32" onkeyUp="if (!event.repeat) {genLayoutAuto(); }">
               </td>
             </tr>

             ##lay_f_type_items##
             <tr>
               <td colspan=2 height=100%>
               </td>
             </tr>
##--
             <tr><td colspan=2>
             <br>
             </td></tr>
--##
             <tr><td>
             %%ffilename%%:
             </td><td>
             <input ##--file_disabled--## type="file" name="ffilename" class="field field100" value="" >
             </td></tr>
         </table>
       </td>
       <td valign=top>
          <div class="layout-block">
          <div class="l-lt-c"></div><div class="l-rt-c"></div>
             <table border="0" cellspacing="0" cellpadding="0" width=220>
               <tr>
                 <td id=box_layout helpId="form_layout">
                 &nbsp;
                 </td>
                </td>
              </tr>
            </table>
            <input onclick="genLayoutAuto()" type=checkbox name=lay_auto_update id=lay_auto_update value="on" detectchanges="off"><label for=lay_auto_update><font style="font-size:9px">%%lay_auto_update%%</font></label>
          <div class="l-lb-c"></div><div class="l-rb-c"></div>
          </div>
        </td>
     </tr>
    </table>
    <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
    <col width="150">
    <col width="*">
     <tr>
       <td colspan="2">
          <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
            <div class="tabs-container">
              <div id="tab-page-body" class="tab-page" style="padding-top:8px;">
              <div id=warn_block style="display:none;border:1px #000 solid; background-color:#ffffe0;margin-left:3px;margin-right:2px;padding:3px;font-size:10px;"></div>
             <label style="display: block; float: right; padding-bottom:6px; padding-right: 20px; padding-top: 2px;"><input type="checkbox" name="ta_highlight_flag" value="1" onChange="hl_onoff(this, 'tpl');"> <span class="check_full_edit">%%highlight_code%%</label>
             <div id="_hl_search_bar" style="float:right; padding-right:16px;">
                 %%hl_search_for%%: <input type="text" id="_hl_search" class="field field10" onkeypress="return hl_searchEnterKeyPress(event, AMI.find('#_hl_search'), 'tpl');"/>
                 <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_search_continue.gif" onclick="oTextEditor.search(AMI.find('#_hl_search').value);" title="%%hl_search%%">
                 &nbsp;&nbsp;&nbsp;
                 %%hl_replace_with%%: <input type="text" id="_hl_replace"  class="field field10" onkeypress="return hl_replaceEnterKeyPress(event, AMI.find('#_hl_search'), AMI.find('#_hl_replace'), 'tpl');"/>
                 <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_replace.gif" onclick="oTextEditor.replace(AMI.find('#_hl_search').value, AMI.find('#_hl_replace').value, '%%hl_confirm_replace%%');" title="%%hl_replace%%">
                 <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_replace_all.gif" onclick="oTextEditor.replaceAll(AMI.find('#_hl_search').value, AMI.find('#_hl_replace').value, '%%hl_confirm_replace_all%%');" title="%%hl_replace_all%%">
             </div>
             <div class="edit_form_block_popup">
              <textarea wrap="OFF" class="field" style="width: 100%; height: 400px; font-family: Courier New; font-size: 13px;" rows="18" name="body" id="bodytxt" maxlength="65535" onblur="genLayout(); return checkLayoutText(false);">##body##</textarea>
             </div>
              </div>

              <div id="tab-page-css" class="tab-page" style="background: white;">
              <table cellspacing="5" cellpadding="0" border="0" style="margin-bottom: 4px; padding:10px; width: 100%; background: #fff; border-bottom: 1px solid #C7C7C7;">
              <tr>
                <td width="200">
                    %%css_file%%:
                </td>
                <td>
                 <select name=css_file>
                 ##css_items##
                 </select>
               </td>
              </tr>
              <tr id="css_file_create_row">
               <td>
                %%css_file_create%%:
               </td>
               <td>
                 <input type=text name=css_file_create class="field field150" value="##css_file_create##" maxlength="128" onkeypress="onNewNameEnter()">
               </td>
              </tr>
              </table>
                 <label style="display: block; float: right; padding-bottom:6px; padding-right: 20px; padding-top: 2px;"><input type="checkbox" name="ta_css_highlight_flag" value="1" onChange="hl_onoff(this, 'css');"> <span class="check_full_edit">%%highlight_code%%</label>
                 <div id="_hl_css_search_bar" style="float:right; padding-right:16px;">
                     %%hl_search_for%%: <input type="text" id="_hl_css_search" class="field field10" onkeypress="return hl_searchEnterKeyPress(event, AMI.find('#_hl_css_search'), 'css');"/>
                     <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_search_continue.gif" onclick="oTplCssEditor.search(AMI.find('#_hl_css_search').value);" title="%%hl_search%%">
                     &nbsp;&nbsp;&nbsp;
                     %%hl_replace_with%%: <input type="text" id="_hl_css_replace"  class="field field10" onkeypress="return hl_replaceEnterKeyPress(event, AMI.find('#_hl_css_search'), AMI.find('#_hl_css_replace'), 'css');"/>
                     <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_replace.gif" onclick="oTplCssEditor.replace(AMI.find('#_hl_css_search').value, AMI.find('#_hl_css_replace').value, '%%hl_confirm_replace%%');" title="%%hl_replace%%">
                     <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_replace_all.gif" onclick="oTplCssEditor.replaceAll(AMI.find('#_hl_css_search').value, AMI.find('#_hl_css_replace').value, '%%hl_confirm_replace_all%%');" title="%%hl_replace_all%%">
                 </div>
                  <div class="edit_form_block_popup">
                    <textarea wrap="OFF" class="field" style="width: 100%; height: 400px; font-family: Courier New; font-size: 13px; padding-top:0px;" rows="18" name="css_file_body" id="css_file_body">##css_file_body##</textarea>
                  </div>
              </div>

                <div id="tab-page-css-custom" class="tab-page" style="background: white; padding-top:4px;">
                 <label style="display: block; float: right; padding-bottom:6px; padding-right: 20px; padding-top: 2px;"><input type="checkbox" name="ta_glb_highlight_flag" value="1" onChange="hl_onoff(this, 'glb');"> <span class="check_full_edit">%%highlight_code%%</label>
                 <div id="_hl_glb_search_bar" style="float:right; padding-right:16px;">
                     %%hl_search_for%%: <input type="text" id="_hl_glb_search" class="field field10" onkeypress="return hl_searchEnterKeyPress(event, AMI.find('#_hl_glb_search'), 'glb');"/>
                     <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_search_continue.gif" onclick="oGlbCssEditor.search(AMI.find('#_hl_glb_search').value);" title="%%hl_search%%">
                     &nbsp;&nbsp;&nbsp;
                     %%hl_replace_with%%: <input type="text" id="_hl_glb_replace"  class="field field10" onkeypress="return hl_replaceEnterKeyPress(event, AMI.find('#_hl_glb_search'), AMI.find('#_hl_glb_replace'), 'glb');"/>
                     <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_replace.gif" onclick="oGlbCssEditor.replace(AMI.find('#_hl_glb_search').value, AMI.find('#_hl_glb_replace').value, '%%hl_confirm_replace%%');" title="%%hl_replace%%">
                     <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_replace_all.gif" onclick="oGlbCssEditor.replaceAll(AMI.find('#_hl_glb_search').value, AMI.find('#_hl_glb_replace').value, '%%hl_confirm_replace_all%%');" title="%%hl_replace_all%%">
                 </div>
                  <div class="edit_form_block_popup">
                      <textarea wrap="OFF" class="field" style="width: 100%; height: 400px; font-family: Courier New; font-size: 13px;" name="custom_css_file_body" id="custom_css_file_body">##custom_css_file_body##</textarea>
                  </div>
              </div>                

              <div id="tab-page-css-global" class="tab-page" style="background: white; padding-top:4px;">
                  <div class="tooltip" id="realFieldsDesc" style="display: block; margin-left:10px;">%%default_css_tooltip%%</div>
                  <textarea wrap="OFF" class="field" style="width: 100%; height: 400px; font-family: Courier New; font-size: 13px; border-top:1px solid #c8c8c8;" name="common_css_file_body" id="common_css_file_body">##common_css_file_body##</textarea>
              </div>
                                      
              <div id="tab-page-html-head-tail" class="tab-page" style="background: white; padding-top:4px;">
                  <div class="tooltip" id="realFieldsDesc" style="display: block; margin-left:10px;">%%head_tooltip%%</div>
                  <textarea wrap="OFF" class="field" style="width: 100%; height: 400px; font-family: Courier New; font-size: 13px; border-top:1px solid #c8c8c8;" name="html_head_tail" id="html_head_tail">##html_head_tail##</textarea>
              </div>
            </div>
          </div>

          <script type="text/javascript">
            var baseTabs = new cTabs('tab-control', {
                'body' : ['%%layout%%', 'active', '', false],
                'css' : ['%%css%%', 'normal', '', false],
                'css-custom' : ['%%css_custom%%', 'normal', '', false],
                'css-global' : ['%%css_global%%', 'normal', '', false],
                'html-head-tail' : ['%%html_head_tail%%', 'normal', '', false],
                '':''
            });
          </script>

       </td>
     </tr>
     <tr>
       <td colspan=2>
       <br>
       </td>
     </tr>
    </table>
    <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
    <col width="150">
    <col width="*">
     <tr>
        <td colspan="2" align="right">
        <br>
        ##cancel##
        ##if(add != 'disabled')##<input type="submit" name="add" value="  %%add_btn%%  " class="but" ##add## onClick="this.form.action.value='add'">##else##
        <input type="submit" name="apply" value="  %%ok_btn%%  " class="but" ##apply## onClick="this.form.action.value='apply'">##endif##
        <input type="submit" name="save" value="  %%apply_btn%%  " class="but" onClick="this.form.action.value='save'">
        <br><br>
        </td>
     </tr>
     <tr>
       <td colspan="2">
         <sub>%%required_fields%%</sub>
       </td>
     </tr>
     </table>

    </form>
<script>
genLayout();
var d = new Date();
</script>
##warning##


<script type="text/javascript">
    oTextEditor = new AMI.TextEditor('bodytxt');
    oTplCssEditor = new AMI.TextEditor('css_file_body', true, {
            mode: "css",
            tabMode: "shift",
            indentUnit: 4,
            lineWrapping: false
        });
    oGlbCssEditor = new AMI.TextEditor('custom_css_file_body', true, {
            mode: "css",
            tabMode: "shift",
            indentUnit: 4,
            lineWrapping: false
        });
    oForm = document.forms[_cms_document_form];
    AMI.find('#css_file_create_row').style.display = oForm.elements["css_file"].selectedIndex ? 'none' : 'table-row';
</script>