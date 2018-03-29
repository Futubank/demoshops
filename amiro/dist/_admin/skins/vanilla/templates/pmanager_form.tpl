%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/pmanager.lng"%%
%%include_language "templates/lang/options_form.lng"%%

<!--#set var="path_row" value="path_not_allowed[##num##] = '##path##';
"-->

<!--#set var="lay_row" value="
<option value="##id##">##name##</option>"-->

<!--#set var="lay_array_item" value="
layouts[##id##] = Array();
layouts[##id##]["body"] = '##layout##';
layouts[##id##]["css"] = '##css_file##';
"-->

<!--#set var="block_hidden_field" value="
<input type="hidden" id="lay_f##block_number##_body" name="lay_f##block_number##_body" value="">
<input type="hidden" id="lay_f##block_number##_body_modified" name="lay_f##block_number##_body_modified" value="">
<input type="hidden" id="lay_f##block_number##_body_protected" name="lay_f##block_number##_body_protected" value="">
"-->

<script type="text/javascript">
<!--

var editor_enable = '##editor_enable##';
var _cms_document_form = 'pmanagerform';
var _cms_script_link = 'pmanager.php?';
var _cms_document_form_changed = false;
var _cms_form_changed_alert = "%%form_changed%%";

var _cms_form_init_manual_start = true;

var _cms_selected_layout_block = "lay_body";
var _cms_selected_layout_block_name;
var _cms_pm_template_blocks_number = ##template_blocks_number##;
var page_loading = "%%page_loading%%";
var add_subpage_confirm = '%%add_subpage_confirm%%';
var add_page_confirm = '%%add_page_confirm%%';
var page_del_confirm = '%%del_confirm%%';
var pages_del_confirm = '%%group_del_confirm%%';
var group_mode_title = '%%group_mode_title%%';
var processing_msg = '%%processing%%';
var lay_over = '#ddf8e4';
var clipboardItemId = 0;
var oLayout;
var current_version;
var group_mode = false;
var redirect_mode = false;
var _prev_grp_ids = '';
var path_not_allowed =  Array();
var globalUndoStates = Array();
var isRedirect = false;
var isRedirectPageSet = false;

##path_list##
var _pm_is_loaded = false;

function selectLayoutBlock(name){

  if (!oLayout) return;

  if (name == undefined || !document.getElementById(name))
    name = "lay_body";


  var table = oLayout;
  /*var cells = table.getElementsByTagName('TD');
  if (cells.length == 0)	{
        var cells = table.getElementsByTagName('DIV');
  }*/

  var cells = AMI.$(table).find('TD,DIV,HEADER,NAV,FOOTER,ARTICLE,ASIDE,SECTION');

  if (typeof(globalUndoStates[_cms_selected_layout_block]) == "undefined"){
    globalUndoStates[_cms_selected_layout_block] = Array();
  }
  if (typeof(_cms_selected_layout_block) != "undefined" && _cms_selected_layout_block.length > 0){
    globalUndoStates[_cms_selected_layout_block]['states_stored'] = statesStored['body'];
    globalUndoStates[_cms_selected_layout_block]['current_state'] = currentState['body'];
    globalUndoStates[_cms_selected_layout_block]['undo_states'] = UndoStatesArray['body'];
    globalUndoStates[_cms_selected_layout_block]['undo_ranges'] = UndoRangesArray['body'];
  }

  if (typeof(globalUndoStates[name]) != "undefined"){
    statesStored['body'] = globalUndoStates[name]['states_stored'];
    currentState['body'] = globalUndoStates[name]['current_state'];
    UndoStatesArray['body'] = globalUndoStates[name]['undo_states'];
    UndoRangesArray['body'] = globalUndoStates[name]['undo_ranges'];
  }else{
    statesStored['body'] = 0;
    currentState['body'] = 0;
    UndoStatesArray['body'] = Array();
    UndoRangesArray['body'] = Array();
  }
  _cms_selected_layout_block = name;

  for (var i=0;i<cells.length;i++){
    if ((getRuntimeStyle(cells[i], 'backgroundColor') == "") && (cells[i].style.backgroundColor=="")) continue;
    if (cells[i].modified)
      setRuntimeStyle(cells[i], 'color', '#bc4702');
    else
      clearRuntimeStyle(cells[i]);
      cells[i].style.backgroundColor="";
  }

  setRuntimeStyle(document.getElementById(name), 'backgroundColor', '#ffeac4');
  setRuntimeStyle(document.getElementById(name), 'cursor', 'default');
  if(document.getElementById(name).modified){
    setRuntimeStyle(document.getElementById(name), 'color', '#bc4702');
  }

  //treeframe.insert_in_editor('body',   document.forms[_cms_document_form].elements[name+'_body'].value);
  treeframe.updateEditorText('body', document.forms[_cms_document_form].elements[name+'_body'].value);

  var _tmp = document.getElementById(name);
  if(typeof(_tmp.innerText) != 'undefined'){
    _cms_selected_layout_block_name = _tmp.innerText;
  }else{
    _cms_selected_layout_block_name = fromHTMLToText(_tmp.innerHTML);
  }
  if(document.getElementById("tab-control-body-label")){
    document.getElementById("tab-control-body-label").innerHTML = _cms_selected_layout_block_name;
  }
}

function InitLayout(){
  oLayout = document.getElementById("box_layout");
  if (oLayout){
    prepareLayoutHTML(oLayout);

    oLayout.onmousedown = OnLayoutClick;
    oLayout.onmouseover = OnLayoutMouseOver;
    oLayout.onmouseout = OnLayoutMouseOut;
    oLayout.disabled = false;

    selectLayoutBlock(_cms_selected_layout_block);
  }
}

var bShowOptions = false;

function showRedirectBlock(bState){
    document.getElementById('redirect_block').style.display = bState ? tableRowShowStyle : 'none';
    if(redirect_mode){
        if(!bState || document.getElementById('is_redirect_1').checked){
            baseTabs.showTab('navy');
            baseTabs.setTabState('options', 'disabled');
        }else if(bShowOptions && !baseTabs.isTabActive('options')){
            baseTabs.setTabState('options', 'normal');
        }
    }
}

var reInitRedirectPage = false;

function setRedirectPage(id, onClick){
  oForm = document.forms[_cms_document_form];
  if (id > 0){
    var oTreeNode = treeframe.document.getElementById('tree_it_'+id);
    if (oForm.elements["id"].value == oTreeNode.getAttribute("rid")){
      alert('%%cross_link_warn%%');
      return;
    }

    if(reInitRedirectPage){
        oForm.elements['page_noindex'].checked = oTreeNode.getAttribute('data-ami-use_noindex') == 1;
    }

    var sPageName = fromHTMLToText(oTreeNode.innerHTML);
    var sPageURL = treeframe.document.getElementById('tree_url_'+id).href.replace(editorBaseHref, "");
    var sButton = " <a href='javascript:void(0)' onclick='isRedirectPageSet = false; reInitRedirectPage = true; setRedirectPage(0, true);return false;'>[%%change%%]</a>";
    document.getElementById('redirect_page_name').innerHTML = sPageName + sButton;
##--
    if (oForm.elements["name"].value == oForm.elements["name"].oldValue){
      oForm.elements["name"].value = sPageName;
    }
    var targetName = isRedirect ? 'dest_link' : 'script_link';
    if (oForm.elements[targetName].value == oForm.elements[targetName].oldValue){
      oForm.elements[targetName].value = sPageURL;
    }
--##
    if(isRedirect){
        oForm.elements['dest_link'].value = sPageURL;
    }
    isRedirectPageSet = true;
    bShowOptions = !document.getElementById('is_redirect_1').checked;
    if(bShowOptions && !baseTabs.isTabActive('options')){
        baseTabs.setTabState('options', 'normal');
    }

    reInitRedirectPage = false;
  }else{
    if(isRedirect && typeof(onClick) == 'undefined'){
        if(!id){
            setSpecialRedirectPageMode();
        }
    }else{
        document.getElementById('redirect_page_name').innerHTML = '<span style="font-size:10px">%%select_page%%</span>';
    }
    if(redirect_mode){
        bShowOptions = false;
        baseTabs.showTab('navy');
        baseTabs.setTabState('options', 'disabled');
    }
  }
  oForm.elements["redirect_id"].value = id;
}

function setSpecialRedirectPageMode(){
    document.getElementById('redirect_page_name').innerHTML = '<span style="font-size: 10px; cursor: pointer;" onclick="isRedirectPageSet = false;isRedirect = false; reInitRedirectPage = true; setRedirectPage(0); isRedirect = true; return false;">%%click_to_select_page%%</span>';
    isRedirectPageSet = true;
}

/*
function disableTab(tab_name, state){
    if(state == true){
        document.getElementById("tab_"+tab_name).className = "dis";
        document.getElementById("tab_"+tab_name+"_").className = "dis_";
    }else if(document.getElementById("tab_"+tab_name).className == 'dis'){
        document.getElementById("tab_"+tab_name).className = "normal";
        document.getElementById("tab_"+tab_name+"_").className = "normal_";
    }
}
*/

function setRedirectMode(mode){

  oForm = document.forms[_cms_document_form];
  if(isRedirect && !mode){
      document.getElementById('is_redirect_0').checked = true;
      displayRedirectionControl(true);
      isRedirectPageSet = false;
  }
  document.getElementById("layout_block").style.display = mode ? "none" : "block";
  document.getElementById("versin_block").style.display = mode ? 'none' : tableRowShowStyle;
  showRedirectBlock(mode && isURLLocal(oForm.elements['script_link'].value));
  document.getElementById('link_radio_block').style.display = mode ? tableRowShowStyle : 'none';

  if (mode){
    baseTabs.showTab('navy');
    baseTabs.setTabState('body', 'disabled');
    baseTabs.setTabState('options', 'disabled');
  }else{
    if(!baseTabs.isTabActive('body')){
      baseTabs.setTabState('body', 'normal');
    }
    if (!baseTabs.isTabActive('options')){
      baseTabs.setTabState('options', 'normal');
    }
  }

  oForm.elements['html_title_inherit'].disabled = mode;
  oForm.elements['html_title'].disabled = mode;
  oForm.elements['html_keywords'].disabled = mode;
  oForm.elements['html_description'].disabled = mode;
  oForm.elements['html_head_tail'].disabled = mode;

  oForm.elements['is_printable'].disabled = mode;
  oForm.elements['skip_search'].disabled = mode;

  redirect_mode = mode;
}

function OnObjectKeyUp(oElement){
    if(redirect_mode && oElement.name == (isRedirect ? 'dest_link' : 'script_link')){
        showRedirectBlock(isURLLocal(oElement.value));
        checkRedirectURLAndTreePage(oElement);
    }
}

function checkRedirectURLAndTreePage(oElement){
    if(isRedirect && isURLLocal(oElement.value) && parseInt(oElement.form.elements['redirect_id'].value)){
        var
            link = oElement.value,
            lang_data = '##admin_lang_data##/'.toLowerCase(),
            redirectId = parseInt(oElement.form.elements['redirect_id'].value);

        if(redirectId < 1){
            return;
        }
        if((link.toLowerCase() + '/').substr(0, lang_data.length) == lang_data) {
            link = link.substr(lang_data.length);
        }
        if(link != treeframe.document.getElementById('tree_url_' + redirectId).href.replace(editorBaseHref, '')){
            setRedirectPage(0);
            oElement.form.elements['redirect_id'].value = -1;
        }
    }
}

function OnObjectChanged_pmanager_form(name, first_change, evt){
  oForm = document.forms[_cms_document_form];

  if (first_change){
    oForm.elements["cancel"].disabled = false;
  }

  if (name == 'page_version'){
    var oSel = oForm['page_version'];
    if (confirm('%%change_version_confirm%% ' + oSel.options[oSel.selectedIndex].innerHTML + ' ?')){
      treeframe.tree_act_version('change_version');
      return true;
    } else{
      oSel.value = current_version;
      return false;
    }
  }
  if (name == 'layout_id'){
    return ResetLayout();
  }
  if (name == 'html_title_inherit'){
    if (oForm[name].checked == true)
      document.getElementById('html_title_prop').style.visibility='hidden';
    else{
      showInputProperties(document.getElementById('html_title'));
      document.getElementById('html_title_prop').style.visibility='visible';
    }
  }
  if(name && (name.substr(0, 4) == "lay_")){
		if (document.getElementById(name)){
            setRuntimeStyle(document.getElementById(name), 'backgroundColor', '#ffebc6');
            setRuntimeStyle(document.getElementById(name), 'cursor', 'default');
            setRuntimeStyle(document.getElementById(name), 'color', '#bc4702');
            document.getElementById(name).modified = true;
			oForm.elements[name+"_body_modified"].value="1";
			return true;
		}
  }

  if (name == "module_name" ){
        var oElem = oForm.elements[name];

      if(1 == AMI.$(oElem.options[oElem.selectedIndex]).attr('dis_func')){
          return false;
      }

    treeframe.SetTemplates();

/*
    if (oForm.elements['module_name'].value == 'print_version'){
      if (document.getElementById('tab-page-navy').style.display == "block"){
        baseTabs.showTab('body');
      }
      document.getElementById('tab_navy').disabled = true;
    }else{
      document.getElementById('tab_navy').disabled = false;
    }
*/

    if (oForm.elements['module_name'].value == oForm.elements['module_name'].oldValue){
      oForm.elements['tpl_addon'].value = oForm.elements['tpl_addon'].oldValue;
    }else{
      oForm.elements['tpl_addon'].value = '';
    }

    if (_cms_selected_layout_block != "lay_body"){
      selectLayoutBlock("lay_body");
    }
    editor_updateHiddenField("body");

    if (oForm.elements["module_name"].value != "pages" && oForm.elements["module_name"].value != "redirect"){
      treeframe.check_in_editor("body", "spec_module_body", true); //add text if not found
    }else{
      treeframe.check_in_editor("body", "spec_module_body", false); //remove block
    }
    editor_updateHiddenField("body");

    // go to redirect mode
    if (!redirect_mode && (oForm.elements["module_name"].value == "redirect")){
      oForm.elements['page_noindex'].checked = 1;
      setRedirectMode(true);
    }

    // go out of redirect mode
    if (redirect_mode && (oForm.elements["module_name"].value != "redirect")){
      setRedirectMode(false);
    }

    amiPMSpecialPage.onLoad(oForm);
    return true;
  }

  if (name == 'menu_main'){
    document.getElementById('main_menu_images').style.display = (oForm.elements['menu_main'].checked)?'block':'none';
    return true;
  }

  if (name == 'img_menu_normal'){

    if (oForm.elements['img_menu_normal'].value == '') {
      document.images['img_menu_normal_img'].src='skins/vanilla/images/menu_normal_##admin_lang##.gif';
      document.images['img_menu_over_img'].src='skins/vanilla/images/menu_over_##admin_lang##.gif';
      document.images['img_menu_active_img'].src='skins/vanilla/images/menu_active_##admin_lang##.gif';
      oForm.elements['img_menu_over'].value='';
      oForm.elements['img_menu_active'].value='';
    }else{
      if ( oForm.elements['img_menu_over'].value == ''){
        document.images['img_menu_over_img'].src=document.images['img_menu_normal_img'].src;
        oForm.elements['img_menu_over'].value = oForm.elements['img_menu_normal'].value;
      }
      if ( oForm.elements['img_menu_active'].value == ''){
        document.images['img_menu_active_img'].src=document.images['img_menu_normal_img'].src;
        oForm.elements['img_menu_active'].value = oForm.elements['img_menu_normal'].value;
      }
    }
    return true;
  }
  if (name == 'img_menu_over' && oForm.elements['img_menu_over'].value == ''){
    document.images['img_menu_over_img'].src='skins/vanilla/images/menu_over_##admin_lang##.gif';
    return true;
  }
  if (name == 'img_menu_active' && oForm.elements['img_menu_active'].value == ''){
    document.images['img_menu_active_img'].src='skins/vanilla/images/menu_active_##admin_lang##.gif';
    return true;
  }

  if(name == 'is_redirect' || name == 'redirection_code'){
    displayRedirectionControl(false);
  }
  return true;
}
addFormChangedHandler(OnObjectChanged_pmanager_form);

function displayRedirectionControl(isCalledOnLoad){
    var
        blocks = ['dest_link_block', 'redirection_code_block'],
        form = document.forms[_cms_document_form],
        redirectId = parseInt(form.elements['redirect_id'].value);

    for(isRedirect = 0; isRedirect < 2; isRedirect++){
        if(document.getElementById('is_redirect_' + isRedirect).checked){
            break;
        }
    }

    var display = isRedirect == 1 ? tableRowShowStyle : 'none';
    showRedirectBlock(display == tableRowShowStyle);
    for(var i = 0, q = blocks.length; i < q; i++){
        document.getElementById(blocks[i]).style.display = display;
    }

    if(isRedirect && !isCalledOnLoad){
        if(redirectId && redirectId != -1){
            isRedirectPageSet = true;
        }else if(form.elements['dest_link'].value != ''){
            setSpecialRedirectPageMode();
        }
    }
    if(isRedirect){
        if(!isCalledOnLoad && redirectId > 0 && treeframe.document.getElementById('tree_url_' + redirectId)){
            form.elements['dest_link'].value = treeframe.document.getElementById('tree_url_' + redirectId).href.replace(editorBaseHref, '');
        }
    }else{
        if(!isCalledOnLoad && (redirectId == 0 || redirectId == -1)){
            setRedirectPage(0);
            form.elements['redirect_id'].value = redirectId;
        }
        showRedirectBlock(isURLLocal(oForm.elements['script_link'].value));
    }
    var redirectionCode = form.elements['redirection_code'].value;
    if(isRedirect){
        var showDestLinkStyle = redirectionCode == 301 || redirectionCode == 302 ? tableRowShowStyle : 'none';
        showRedirectBlock(showDestLinkStyle == tableRowShowStyle);
        document.getElementById('dest_link_block').style.display = showDestLinkStyle;
    }else if(!isCalledOnLoad && (redirectionCode == 404 || redirectionCode == 503)){
        setRedirectPage(0);
    }
}

function OnLayoutClick(evt){
  evt = amiCommon.getValidEvent(evt);
  var target = amiCommon.getEventTarget(evt);

  if (target && target.id != 'box_layout'){
    if(isClickableTag(target.tagName)){
      if(!target.id && isClickableTag(target.parentNode.tagName) && target.parentNode.id){
          target = target.parentNode;
      }
      if (target.id != _cms_selected_layout_block){
        editor_updateHiddenField("body");
        baseTabs.showTab('body');
        selectLayoutBlock(target.id);
      }
    }else if(target.tagName == "IMG" && target.id.indexOf('_protected') >= 0){
        protectedStatusChanged(target, target.getAttribute('blockNumber'), evt);
    }
  }
}

function OnLayoutMouseOver(evt){
  evt = amiCommon.getValidEvent(evt);
  var target = amiCommon.getEventTarget(evt);
  if (target && ( target.id != 'box_layout') && isClickableTag(target.tagName)){
    if (target.id.substr(0,4) == "lay_" &&  target.id != _cms_selected_layout_block){
    target.style.backgroundColor = lay_over;
    }
  }
}

function OnLayoutMouseOut(evt){
  evt = amiCommon.getValidEvent(evt);
  var target = amiCommon.getEventTarget(evt);
  if (target && ( target.id != 'box_layout') && isClickableTag(target.tagName)){
    if (target.id != _cms_selected_layout_block){
        target.style.backgroundColor = "";
    }
  }
}


function ResetLayout(){
  oForm = document.forms[_cms_document_form];
  if (confirm('%%reset_lay_confirm1%% "'+document.getElementById('lay_body_body').name+'" %%reset_lay_confirm2%%')){
    //editor_setfocus("body");
    oForm.elements["action"].value = "reset_lay";
    oForm.submit();
    enableForm(false);
    return true;
  }else{
    oForm.elements["layout_id"].value = oForm.elements["layout_id"].oldValue;
    return false;
  }
}


function enableForm(bEnable){
    if(!bEnable){
        processRequest();
    }else{
        processRequestStop();
    }

  /*oForm = document.forms[_cms_document_form];
  var arrElements =  oForm.elements;
  //var grp_generate_keywords_auto = oForm.elements["grp_generate_keywords_auto"].disabled;

  for (var i=0;i<arrElements.length ; i++){
    if (oForm.elements[i].tagName == "FIELDSET" || oForm.elements[i].tagName == "BUTTON" ||  oForm.elements[i].getAttribute('unselectable')=='on'){
      continue;
    }
    if (arrElements[i].name.substr(0, 9) != "_spec_opt"){
      if (arrElements[i].tagName == "INPUT" && (arrElements[i].type == "checkbox" ||
          arrElements[i].type == "text" || arrElements[i].type == "button" || arrElements[i].type == "submit") ||
          arrElements[i].tagName == "TEXTAREA" || arrElements[i].tagName == "SELECT"){
        arrElements[i].disabled = !bEnable;
      }
    }
  }
  document.getElementById("box_layout").disabled = !bEnable;

  if (oForm.elements['level'].value > oForm.elements['allowed_menu_level'].value){
    oForm.elements['menu_main'].disabled = true;
  }

  //oForm.disabled = !bEnable;

  //oForm.elements["grp_generate_keywords_auto"].disabled = grp_generate_keywords_auto;

  //objname = _cms_selected_layout_block.substr(4, _cms_selected_layout_block.length);
  //enableEditor("body", bEnable);
  */

}

function clearForm(title, clear_layout){

  var oForm = document.forms[_cms_document_form];

  if (title){
    document.getElementById('form_title').innerHTML = title;
  }
  document.getElementById('stModified').style.display = "none";
  //document.getElementById('tree_time').innerHTML = '';
  oForm.elements['public'].checked = true;
  oForm.elements['redirect_id'].value = 0;
  oForm.elements['show_me_at_parent'].checked = false;
  oForm.elements['show_in_sitemap'].checked = true;
  oForm.elements['show_siblings'].checked = false;
  oForm.elements['is_printable'].checked = false;
  oForm.elements['skip_search'].checked = false;
  oForm.elements['name'].value = '';
  oForm.elements['name'].disabled = false;
  oForm.elements['script_link'].value = '';
  oForm.elements['html_title'].value = '';
  oForm.elements['html_title_inherit'].checked = false;
  oForm.elements['html_keywords'].value = '';
  oForm.elements['html_description'].value = '';
  oForm.elements['html_head_tail'].value = '';
  oForm.elements['module_name'].value = '';
  oForm.elements['tpl_addon'].value = '';
  oForm.elements['is_section'].checked = false;
  oForm.elements['level'].value = 0;
  oForm.elements['menu_main'].checked = false;
  oForm.elements['menu_main'].disabled = false;
  oForm.elements['menu_top'].checked = false;
  oForm.elements['menu_bottom'].checked = false;
  oForm.elements['use_noindex'].checked = false;
  oForm.elements['page_noindex'].checked = false;
  oForm.elements['page_use_hreflang'].checked = false;
  oForm.elements['img_menu_normal'].value = '';
  oForm.elements['img_menu_over'].value = '';
  oForm.elements['img_menu_active'].value = '';
  document.images['img_menu_normal_img'].src = 'skins/vanilla/images/menu_normal_##admin_lang##.gif';
  document.images['img_menu_over_img'].src = 'skins/vanilla/images/menu_over_##admin_lang##.gif';
  document.images['img_menu_active_img'].src = 'skins/vanilla/images/menu_active_##admin_lang##.gif';
  document.getElementById('main_menu_images').style.display = 'none';


##if(VISIBLE_AREA=="1")##
  oForm.elements['visible_area'].value = 'all';
##endif##


  if (clear_layout){
    document.getElementById('box_layout').innerHTML = '%%page_loading%%';
    oForm.elements['layout_id'].value = 0;
  }

  treeframe.insert_in_editor('body', '');

  oForm.elements['lay_body_body'].value = '';

  for (i = 1 ;i<=_cms_pm_template_blocks_number; i++){
    oForm.elements['lay_f'+i+'_body'].value = '';
  }

  amiPMSpecialPage.onLoad(oForm);
  ResetFormChanges();
}

function checkSublinks(str){
    if(str.search(/[ ]/) != -1){
        alert('%%link_has_spaces%%');
        return false;
    }
    if(str.search(/^[0-9a-zA-Z\-\_\.\/:\?\=\%\&\#]*$/) == -1){
        alert('%%link_illegal_symbols%%');
        return false;
    }
    if(((qpos = str.indexOf("?")) > 0 ) && ( str.indexOf("?", qpos+1) > 0)){
        alert('%%link_illegal_qm_use%%');
        return false;
    }
    if(qpos <= 0){
        qpos = str.length;
    }

    if(( (amppos = str.indexOf("&")) >= 0 && (amppos < qpos)) || ((qmpos =str.indexOf("=")) >= 0 && ( qmpos < qpos))){
        alert('%%link_illegal_amp_use%%');
        return false;
    }
    if(str.search(/^\/+.*?$/) != -1){
        alert('%%link_start_slash%%');
        return false;
    }
    if(str.search(/\/{2,}$/) != -1){
        alert('%%link_start_slash%%');
        return false;
    }
    if(str.search(/^[a-zA-Z\-\_\.]/) == -1){
        alert('%%link_start_illegal%%');
        return false;
    }
    return true;
}
function isURLLocal(sURL){
  return !(sURL.substr(0, 5)=='http:' || sURL.substr(0, 6)=='https:' || sURL.substr(0, 4)=='ftp:');
}

function pmFormOnSubmit(form)
{
    form.submit();
    enableForm(false);
    return false;
}

function CheckForm(form) {
  var multi_site_root_www='##multi_site_root_www##';
  if (form.isReadOnly){
    return false;
  }
  var errmsg = "";
  window.scrollTo(0,0);
  if (group_mode){
    if (form._grp_ids.value.length == 0){
      alert('%%select_pages_warn%%');
      return false;
    }

    var opt_changed = false;
    var act_changed = false;

    if ( form.elements['grp_generate_link'].checked && !confirm('%%generate_link_confirm%%')) {
      return false;
    }
    if ( form.elements['grp_generate_link'].checked || form.elements['grp_generate_keywords'].checked ){
      act_changed = true;
    }

    ##if(VISIBLE_AREA=="1")##
    if ( !act_changed && ( form.elements['grp_visible_area'].value.length > 0 || form.elements['grp_layout_id'].value.length > 0) ){
      act_changed = true;
    }
    ##endif##

    for (i=0;i<form.elements.length;i++){
      if ( ( form.elements[i].tagName == 'INPUT' ) && ( form.elements[i].type == 'checkbox' ) && ( form.elements[i].name.substr(0, 4) == 'grp_') && form.elements[i].checked ){
        if (form.elements[i].name != 'grp_generate_link' && form.elements[i].name != 'grp_generate_keywords'){
          opt_changed = true;
          break;
        }
      }
    }
    var msg='';
    if (opt_changed) msg += '%%grp_confirm_opt%%';
    if ( msg.length > 0 && act_changed ) msg += ' %%grp_confirm_and%% ';
    if (act_changed) msg += '%%grp_confirm_act%%';
    msg = '%%grp_confirm1%% ' + msg + ' %%grp_confirm2%%';
    if ( opt_changed || act_changed ){
      if (confirm(msg)){
        document.getElementById('form_title').innerHTML ="%%applying_grp%%";
        document.getElementById('status-msgs').innerHTML = '';
			  document.getElementById("status-block").style.display = 'none';
        clearForm();
        form.elements['action'].value = 'grp_apply';
        return pmFormOnSubmit(form);
      }
    }else{
      alert('%%select_options_warn%%');
    }
  }else{
      var
        redirectId = parseInt(form.elements['redirect_id'].value),
        redirect_local = isURLLocal(form.elements['script_link'].value);
      if(redirect_mode){
          if(isRedirect){
              redirect_local = isURLLocal(form.elements['dest_link'].value);
              if(form.elements['script_link'].value.replace(/^ *(.*?)[ /]*$/, '$1') == form.elements['dest_link'].value.replace(/^ *(.*?)[ /]*$/, '$1')){
                  form.dest_link.focus();
                  alert('%%warn_equal_src_dest_links%%');
                  form.dest_link.focus();
                  return false;
              }
              if(redirectId > 0){
                  form.elements['redirect_id'].value = -redirectId;
              }
          }else{
            if(redirectId < 0){
              form.elements['redirect_id'].value = -redirectId;
            } else if(redirectId == 1){
                form.elements['redirect_id'].value = 0;
                redirectId = 0;
            }
          }

      }

    var redirectionCode = form.elements['redirection_code'].value;

    if(redirect_mode && redirect_local && (isRedirect ? !isRedirectPageSet : redirectId < 1) && (redirectionCode == 301 || redirectionCode == 302)){
       errmsg+='%%redirect_warn%%';
       alert(errmsg);
       return false;
    }


    if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
    }

    if(form.script_link.value.length>0){
      ##--www_root = '##root_path_www##';--##
      lang_data = '##admin_lang_data##/';
      multi_site_root_www = '##multi_site_root_www##';
      if((form.script_link.value.toLowerCase() + '/').substr(0, multi_site_root_www.length) == multi_site_root_www.toLowerCase()){
        form.script_link.value = form.script_link.value.substr(multi_site_root_www.length);
        if((form.script_link.value.toLowerCase() + '/').substr(0, lang_data.length) == lang_data.toLowerCase()){
          form.script_link.value = form.script_link.value.substr(lang_data.length);
        }
      }

      if (!checkSublinks(form.script_link.value)){
        form.script_link.focus();
        form.script_link.select();
        return false;
      }

      var bFound = false;
      var i=0;
      while(!bFound && i < path_not_allowed.length){
        if (form.script_link.value == path_not_allowed[i])
          bFound = true;
        i++;
      }

      if (bFound){
        alert('"'+form.script_link.value+'"'+' %%link_not_allowed%%');
        form.script_link.focus();
        form.script_link.select();
        return false;
      }
    }

    document.getElementById('status-msgs').innerHTML = '';
    document.getElementById("status-block").style.display = 'none';

    if (form.module_name.value != "pages"){
     if (_cms_selected_layout_block == "lay_body"){
       treeframe.check_in_editor("body", "spec_module_body", true); //add text if not found
     }
    }else{
     treeframe.check_in_editor("body", "spec_module_body", false); //remove block
    }

    editor_updateHiddenField("body");

    document.getElementById('form_title').innerHTML ="%%saving_page%%";
    form.elements['action'].value = 'apply';
    if (!redirect_mode && !redirect_local) {
      form.redirect_id.value = 0;
    }

    // trim html_head_tail code, check html syntax partially
    var re = /^\s+(.*)\s+$/g;
    form.html_head_tail.value = form.html_head_tail.value.replace(re, '$1');
    if (form.html_head_tail.value != '') {
        re = /\<[^\>]+\>/g;
        var code = form.html_head_tail.value.replace(re, '');
        if ((code.indexOf('<') > -1 || code.indexOf('>') > -1) && !confirm('%%unmatched_lt_gt%%')) {
            baseTabs.showTab('options');
            form.html_head_tail.focus();
            return false;
        }
    }

    var setRedirectionId = isRedirect && redirectionCode != 301 && redirectionCode != 302;

    if(setRedirectionId || (redirect_mode && !redirect_local && (redirectionCode == 301 || redirectionCode == 302))){
        form.elements['redirect_id'].value = -1;
    }

    var modId = form.elements['module_name'].value;
    for(var i = 0, q = treeframe.aModules.length; i < q; ++i){
        var modInfo = treeframe.aModules[i];

        if(modInfo['name'] === modId){
            if(
                modInfo['installed'] != '1' ||
                ('undefined' !== typeof(modInfo['disabled']) && '1' == modInfo['disabled'])
            ){
                return focusedAlert(form.module_name, '%%unable_to_save_page_with_selected_module%%');
            }
            break;
        }
    }

    amiPMSpecialPage.onSubmit(form);
    return pmFormOnSubmit(form);
  }
  return false;
}

amiPMSpecialPage = {
    page: '',
    fields: {
        'print_version': [
            ['show_me_at_parent', false],
            ['show_in_sitemap', false],
            ['show_siblings', false],
            ['is_printable', false],
            ['skip_search', true],
            ['is_section', false],
            ['menu_main', false],
            ['menu_top', false],
            ['menu_bottom', false],
            ['page_noindex', false]
        ],
        'eshop_compare': [
            ['skip_search', true],
            ['show_in_sitemap', false],
            ['show_me_at_parent', false],
            ['menu_main', false],
            ['menu_top', false],
            ['menu_bottom', false]
        ]
    },

    onLoad: function(form){
        for(var module in this.fields){
            for(var i = 0, q = this.fields[module].length; i < q; i++){
                var field = this.fields[module][i];
                form.elements[field[0]].disabled = false;
            }
        }
        if(this.checkModule(form)){
            for(var i = 0, q = this.fields[this.page].length; i < q; i++){
                var field = this.fields[this.page][i];
                form.elements[field[0]].checked = field[1];
                form.elements[field[0]].disabled = true;
            }
        }
    },

    onSubmit: function(form){
        if(this.checkModule(form)){
            for(var i = 0, q = this.fields[this.page].length; i < q; i++){
                var field = this.fields[this.page][i];
                form.elements[field[0]].disabled = false;
            }
        }
    },

    checkModule: function(form){
        this.page = form.module_name.value;
        return this.fields[this.page] ? true : false;
    }
}

function OnPMLoad(){
  _pm_is_loaded = true;
  if (window.treeframe._start_set_page_data)
    window.treeframe.SetPageData();

}

function reexpand(state){
    if (typeof (treeframe.document.forms['ftree'])=="object" && typeof (treeframe.document.forms['ftree'].expand)=="object"){
      treeframe.document.forms['ftree'].expand.value = (state)?'1':'0';
      document.forms[_cms_document_form].expand.value = (state)?'1':'0';
      treeframe.document.forms['ftree'].submit();
      return false;
    }
}

function openLayoutDialog(){
  var cbFunction = function(){
        if (confirm('%%layout_changed%%')){
           document.location.reload();
        }
  }
  openExtDialog('%%layouts%%', 'layouts.php?flt_mode=simple&action=edit&id='+document.forms[_cms_document_form].elements['layout_id'].value+'#anchor', 1, 1, 0, 0, -1, -1, 0, 0, cbFunction);
}

function replaceBlockNumbers(content, isProtected, pageId){
    if(isProtected){
        content = content.replace(/(#\#spec_\w+_\d{8})(#\#)/g, '$1'+pageId+'$2');
    }else{
        content = content.replace(/(#\#spec_\w+_\d{8})\d*?(#\#)/g, '$1$2');
    }
    return content;
}

function protectedStatusChanged(obj, blockNumber, evt){
    // Set field and icon to protected / not protected
    var isProtected = document.getElementById('lay_f'+blockNumber+'_body_protected').value == '1' ? false : true;
    document.getElementById('lay_f'+blockNumber+'_body_protected').value = (isProtected?'1':'');
    obj.src='skins/vanilla/images/bp_'+document.getElementById('lay_f'+blockNumber+'_body_protected').value+'.gif';
    // Parse block content
    if(typeof(globalEditor['body']) != 'undefined'){
        var curPageId = document.forms[_cms_document_form].elements['id'].value;
        var sCurLayNum = _cms_selected_layout_block.replace('lay_f', '');
        if(sCurLayNum == blockNumber && globalEditor['body'].tagName.toLowerCase()=='iframe'){
            var editdoc = globalEditor['body'].contentWindow.document;
            var spanObjects = editdoc.getElementsByTagName('SPAN');
            for(i = 0; i < spanObjects.length; i++){
                if(spanObjects[i].className && spanObjects[i].className == 'spec_modules' || spanObjects[i].className == 'spec_common'){
                    var objNum = spanObjects[i].spec_num;
                    var objInnerHTML = spanObjects[i].innerHTML;
                    if(isProtected && objNum.length <= 9){
                        spanObjects[i].spec_num += curPageId;
                        spanObjects[i].innerHTML = objInnerHTML + curPageId;
                        document.getElementById('lay_f'+blockNumber+'_body_modified').value = '1';
                    }else if(!isProtected && objNum.length >= 9){
                        spanObjects[i].spec_num = spanObjects[i].spec_num.substr(0, 8);
                        objInnerHTML = objInnerHTML.replace(/ (\d{8})\d*?$/, ' $1');
                        spanObjects[i].innerHTML = objInnerHTML;
                        document.getElementById('lay_f'+blockNumber+'_body_modified').value = '1';
                    }
                }
            }
        }else if(sCurLayNum == blockNumber){
            editorObj = globalEditor['body'];
            editorObj.value = replaceBlockNumbers(editorObj.value, isProtected, curPageId);
            document.getElementById('lay_f'+blockNumber+'_body_modified').value = '1';
        }else{
            if(document.getElementById('lay_f'+blockNumber+'_body')){
                document.getElementById('lay_f'+blockNumber+'_body').value = replaceBlockNumbers(document.getElementById('lay_f'+blockNumber+'_body').value, isProtected, curPageId);
                document.getElementById('lay_f'+blockNumber+'_body_modified').value = '1';
            }
        }
    }
    FormChanged(evt, document.getElementById('lay_f'+blockNumber+'_body_protected'));
}

-->
</script>

<form action="gettree.php" target=treeframe method="POST" name="pmanagerform" onSubmit="return  CheckForm(this);">
  <input type="hidden" name="id" value="">
  <input type="hidden" name="itemid" value="">
  <input type="hidden" name="redirect_id" value="0">
  <input type="hidden" name="_grp_ids" value="">
  <input type="hidden" name="selId" value="">
  <input type="hidden" name="expand" value="##expand##">
  <input type="hidden" name="parentId" value="">
  <input type="hidden" name="action" value="">
  <input type="hidden" name="oldname" value="">
  <input type="hidden" name="level" value="">
  <input type="hidden" name="last_modified" value="">
  <input type="hidden" id="lay_body_body" name="lay_body_body" value="">
  <input type="hidden" id="lay_body_body_modified" name="lay_body_body_modified" value="">
  <input type="hidden" id="allowed_menu_level" name="allowed_menu_level" value="0">
  ##blocks_hidden_fields##


<div id="page_properties_form">
<table border="0" cellspacing="0" cellpadding="0" class="frm" width=100%  id="single_mode_controls" border=0>
     <tr>
       <td valign=top align=left style="padding-right:20px;" width=100%>
         <table border="0" cellspacing="0" cellpadding="0" class="frm" height=100% width=100%>
          <tr>
            <td nowrap style="padding-top:10px;padding-bottom:10px;" colspan=2>
              <input type="checkbox" name="public" id="public" disabled value="1" helpId="form_public"> <label for="public">%%public%%</label>
            </td>
          </tr>
          <tr>
             <td height=26 nowrap>
               <nobr>%%module%%:&nbsp;</nobr>
             </td>
             <td align=left width=100%>
               <select data-helpid="module_name" name="module_name" helpId="form_module_name" style="width:200px">
                 ##mod_list##
               </select>
               <span id="notInstalledModId" style="color: #888;" title="%%not_installed_mod_id%%"></span>
             </td>
          </tr>
          <tr id="link_radio_block" style="display:none;">
            <td colspan="2">
                <input id="is_redirect_0" type="radio" name="is_redirect" value="0" checked /> <label for="is_redirect_0">%%link%%</label>
                <input id="is_redirect_1" type="radio" name="is_redirect" value="1" /> <label for="is_redirect_1">%%redirection%%</label>
            </td>
          </tr>
          <tr id="redirect_block" style="display:none">
             <td height=26>
               <nobr>%%on_page%%:&nbsp;</nobr>
             </td>
             <td align=left id=redirect_page_name style="font-size:11px;font-weight:bold;color:#900000">
             </td>
          </tr>
          <tr id="tpl_addon_block" style="display:none">
             <td height=26>
               <nobr>%%template%%:&nbsp;</nobr>
             </td>
             <td align=left height=26 valign=top>
<div class="template_select_block">
    <select name="tpl_addon" helpId="form_tpl_addon"></select>
    <a href="#" onclick="openModTplDialog();return false;" class="list-icon icon-template-edit" title="%%edit_template%%"><div class="amiModuleLink"></div></a>
    <a class="icon-template-help" href="javascript:void;" onclick="return false;" id="tpl_addon_tooltip" class="amiTooltip"></a>
</div>
<script type="text/javascript">
AMI.$(document).ready(function(){
    AMI.$("#tpl_addon_tooltip").tooltip({
        bodyHandler: function(){
            return '%%template_hint%%';
        },
        showURL: false
    });
});
function openModTplDialog(){
    var modName = AMI.$('SELECT[name="module_name"]').val();
    var tplName = AMI.$('SELECT[name="tpl_addon"]').val();
    var tplId = 0;
    for(var i = 0; i < treeframe.aModules.length; i++){
        if(treeframe.aModules[i]['name'] == modName){
            if(treeframe.aModules[i]['templates'].indexOf(tplName) >= 0){
                var index = treeframe.aModules[i]['templates'].indexOf(tplName);
                if(treeframe.aModules[i]['templates_ids'].length){
                    if(typeof(treeframe.aModules[i]['templates_ids'][index]) != 'undefined'){
                        tplId = treeframe.aModules[i]['templates_ids'][index];
                    }
                }
            }
        }
    }
    var add = '';
    if(tplId){
        add += '&id=' + tplId + '#mid=modules_templates&id=' + tplId + '&scroll_to_form=1';
    }
    openExtDialog('%%templates_popup%%', 'engine.php?mod_id=modules_templates&mode=popup&modname=' + modName + add, 1, 1 );
}
</script>

             </td>
          </tr>
          <tr id="versin_block">
             <td height=26>
               <nobr>%%version%%:&nbsp;</nobr>
             </td>
             <td align=left nowrap>
               <select name="page_version"  helpId="form_page_version" style="width:150px">
               </select>##--<button name=delete_version onclick="if(confirm('%%delete_version_confirm%%')) treeframe.tree_act_version('delete_version');" style="width:17;height:16;margin:2px;" disabled><img id="delete_version_img" src="skins/vanilla/images/sel_del_but.gif" style="filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=10)"></button>--##
             </td>
          </tr>
          <tr id="name_block">
            <td height=26>
              %%name%%*:&nbsp;
            </td>
            <td>
              <input type=text name="name" class="field" value="##name##" style="width:200px" maxlength="255" helpId="form_name">
            </td>
          </tr>
          <tr id="dest_link_block" style="display: none;">
             <td height="26"><nobr>%%dest_link%%:&nbsp;</nobr></td>
             <td><input type="text" name="dest_link" class="field" value="" style="width:200px;" helpId="form_dest_link" /></td>
          </tr>
          <tr id="redirection_code_block" style="display: none;">
             <td height="26"><nobr>%%redirection_code%%:&nbsp;</nobr></td>
             <td><select name="redirection_code" helpId="form_redirection_code">
                <option value="301">%%redirection_code_301%%</option>
                <option value="302">%%redirection_code_302%%</option>
                <option value="503">%%redirection_code_503%%</option>
                <option value="404">%%redirection_code_404%%</option>
             </select>
          </tr>
          <tr>
             <td height=26>
              <nobr>%%link%%:&nbsp;</nobr>
             </td>
             <td>
               <input type=text name="script_link" class="field" value="" style="width:200px" maxlength="255" helpId="form_script_link">
             </td>
          </tr>
          <tr>
             <td colspan=2 height=25 nowrap>
             </td>
          </tr>
        </table>
       </td>
       <td align=right valign=top width=220>
          ##--<h3 align=left>%%page_layout%%</h3>--##
          <br>
          <div data-helpid="lay_block" class="layout-block">
          <div class="l-lt-c"></div><div class="l-rt-c"></div>
             <table border="0" cellspacing="0" cellpadding="0" width=220 id=layout_block>
               <tr>
                 <td align=left nowrap width=220>
                   <select name="layout_id" id="layout_id"  helpId="form_layout_id" style="width:83%;">
                     ##lay_list##
                   </select>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:openLayoutDialog();return false;"><img

                   src="skins/vanilla/icons/icon-edit.gif" class=icon title="%%edit_layout%%" align=absmiddle></a>
                </td>
              </tr>
               <tr>
                 <td data-helpid='box_layout' id=box_layout style="border:0px #ffffff solid;" helpId="form_layout" valign=top>
                  <img src="skins/vanilla/images/custom_##ADM_COPY_PREF##/loading-blue.gif" style="margin-right:10px;" align="absmiddle">%%page_loading%%
                 </td>
              </tr>
            </table>
          <div class="l-lb-c"></div><div class="l-rb-c"></div>
          </div>

        </td>
     </tr>
     <tr>
       <td colspan="2">
        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-body">
              <textarea class="field" style="width:100%" rows="30" name="body" id="body">##body##</textarea><script type="text/javascript">
               if(editor_enable) { editor_generate('body', 0, true, '100%', '400'); }
              </script>
            </div>
            ##options_form##

          </div>
        </div>


        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'body' : ["%%body%%", 'active', '', false],
              'navy' : ['%%navigation%%', 'normal', '', false],
              'options' : ['%%options%%', 'normal', '', false],
          '':''});

        </script>

       </td>
     </tr>
##--
     <tr>
       <td colspan="2">
         <div id="div_body">
         <textarea class="field" style="width:100%" rows="30" name="body" id="body">##body##</textarea><script type="text/javascript">
           if(editor_enable)
             editor_generate('body', 0, true, '100%', '400'); // field, width, height
         </script>
         </div>
       </td>
     </tr>
--##
     <tr>
       <td colspan="2">
         <sub>%%required_fields%%</sub><br>
       </td>
     </tr>
     </table>

    <div id="group_mode_controls" style="display:none">
    <br>
    <table cellspacing=0 cellpadding=0 border=0 width=100%>
     <tr>
       <td colspan=2>
        <br>
      </td>
     </tr>
     <tr>
       <td>
        <table cellspacing=0 cellpadding=3 border=0>
         <tr>
           <td nowrap>%%grp_page_layout%%:</td>
           <td width=100%>
             <select name="grp_layout_id" detectchanges="off">
               <option value="">%%select%%</option>
                 ##lay_list##
             </select>
          </td>
         </tr>
     <tr>
       <td colspan=2>
        <br>
      </td>
     </tr>    ##if(VISIBLE_AREA=="1")##
         <tr>
           <td nowrap>%%grp_visible_area%%:</td>
           <td width=100%>
             <select name=grp_visible_area detectchanges="off">
               <option value="">%%select%%</option>
               <option value="all">%%area_all%%</option>
               <option value="local">%%area_local%%</option>
               <option value="public">%%area_public%%</option>
             </select>
          </td>
         </tr>
    ##endif##
         <tr>
           <td colspan=2  valign=top>
            <img src="skins/vanilla/icons/icon_opt_on.gif" align=absmiddle width=14 style="margin-left:11px;margin-right:8px;border:1px #82c69e solid;"><img src="skins/vanilla/icons/icon_opt_off.gif" align=absmiddle width=14 style="margin-right:2px;border:1px #d89494 solid;"><span style="padding-left:2px;"><b>%%set_option%%</b></span>
          </td>
         </tr>
        </table>
       </td>
     </tr>
     <tr>
       <td>
        <fieldset>
        <legend><b>%%common_options%%</b></legend>
        <table cellspacing=0 cellpadding=3 border=0 background="skins/vanilla/images/grp_opt_bg.gif" style="background-repeat:repeat-y;">
         <tr>
           <td colspan=2  valign=top>
            &nbsp;&nbsp;<input class=check type="checkbox" name="grp_public" id="grp_public" value="1" onmouseup="if (!this.checked) grp_public[1].checked=false" detectchanges="off">&nbsp;<input class=check type="checkbox" name="grp_public" value="0" onmouseup="if (!this.checked) grp_public[0].checked=false" detectchanges="off">
            <label for="grp_public">%%public%%</label>
          </td>
         </tr>
         <tr>
           <td colspan=2  valign=top>
             &nbsp;&nbsp;<input class=check type="checkbox" name="grp_html_title_inherit" id="grp_html_title_inherit" value="1" onmouseup="if (!this.checked) grp_html_title_inherit[1].checked=false" detectchanges="off">&nbsp;<input class=check type="checkbox" name="grp_html_title_inherit" value="0" onmouseup="if (!this.checked) grp_html_title_inherit[0].checked=false" detectchanges="off">
            <label for="grp_html_title_inherit">%%title_inherit%%</label>
          </td>
         </tr>
         <tr>
           <td colspan=2 valign=top>
             &nbsp;&nbsp;<input class=check type="checkbox" name="grp_is_section" id="grp_is_section" value="1" onmouseup="if (!this.checked) grp_is_section[1].checked=false" detectchanges="off">&nbsp;<input class=check type="checkbox" name="grp_is_section" value="0" onmouseup="if (!this.checked) grp_is_section[0].checked=false" detectchanges="off">
            <label for="grp_is_section">%%is_section%%</label>&nbsp;
          </td>
         </tr>
         <tr>
           <td colspan=2 valign=top>
             &nbsp;&nbsp;<input class=check type="checkbox" name="grp_is_printable" id="grp_is_printable" value="1" onmouseup="if (!this.checked) grp_is_printable[1].checked=false" detectchanges="off">&nbsp;<input class=check type="checkbox" name="grp_is_printable" value="0" onmouseup="if (!this.checked) grp_is_printable[0].checked=false" detectchanges="off">
             <label for="grp_is_printable">%%grp_is_printable%%</label>
           </td>
         </tr>
         <tr>
           <td colspan=2 valign=top>
            &nbsp;&nbsp;<input class=check type="checkbox" name="grp_skip_search" id="grp_skip_search" value="1" onmouseup="if (!this.checked) grp_skip_search[1].checked=false" detectchanges="off">&nbsp;<input class=check type="checkbox" name="grp_skip_search" value="0" onmouseup="if (!this.checked) grp_skip_search[0].checked=false" detectchanges="off">
             <label for="grp_skip_search">%%grp_skip_search%%</label>
           </td>
         </tr>
         <tr>
           <td colspan=2 valign=top>
            &nbsp;&nbsp;<input class=check type="checkbox" name="grp_page_noindex" id="grp_page_noindex" value="1" onmouseup="if (!this.checked) grp_page_noindex[1].checked=false" detectchanges="off">&nbsp;<input class=check type="checkbox" name="grp_page_noindex" value="0" onmouseup="if (!this.checked) grp_page_noindex[0].checked=false" detectchanges="off">
             <label for="grp_page_noindex">%%page_noindex%%</label>
           </td>
         </tr>
        </table>
        </fieldset>
       </td>
     </tr>
     <tr>
       <td>
        <fieldset>
        <legend><b>%%navigation%%</b></legend>
        <table cellspacing=0 cellpadding=3 border=0 background="skins/vanilla/images/grp_opt_bg.gif" style="background-repeat:repeat-y;">
         <tr>
           <td colspan=2  valign=top>
             &nbsp;&nbsp;<input class=check type="checkbox" name="grp_show_in_sitemap" id="grp_show_in_sitemap" value="1" onmouseup="if (!this.checked) grp_show_in_sitemap[1].checked=false" detectchanges="off">&nbsp;<input class=check type="checkbox" name="grp_show_in_sitemap" value="0" onmouseup="if (!this.checked) grp_show_in_sitemap[0].checked=false" detectchanges="off">
             <label for="grp_show_in_sitemap">%%grp_show_in_sitemap%%</label>
           </td>
         </tr>
         <tr>
           <td colspan=2  valign=top>
             &nbsp;&nbsp;<input class=check type="checkbox" name="grp_show_me_at_parent" id="grp_show_me_at_parent" value="1" onmouseup="if (!this.checked) grp_show_me_at_parent[1].checked=false" detectchanges="off">&nbsp;<input class=check type="checkbox" name="grp_show_me_at_parent" value="0" onmouseup="if (!this.checked) grp_show_me_at_parent[0].checked=false" detectchanges="off">
             <label for="grp_show_me_at_parent">%%grp_show_me_at_parent%%</label>
           </td>
         </tr>
         <tr>
           <td colspan=2 valign=top>
             &nbsp;&nbsp;<input class=check type="checkbox" name="grp_show_siblings" id="grp_show_siblings" value="1" onmouseup="if (!this.checked) grp_show_siblings[1].checked=false" detectchanges="off">&nbsp;<input class=check type="checkbox" name="grp_show_siblings" value="0" onmouseup="if (!this.checked) grp_show_siblings[0].checked=false" detectchanges="off">
            <label for="grp_show_siblings">%%grp_show_siblings%%</label>
           </td>
         </tr>
        </table>
        </fieldset>
       </td>
     </tr>
     <tr>
       <td>
        <fieldset>
        <legend><b>%%menu%%</b></legend>
        <table cellspacing=0 cellpadding=3 border=0 background="skins/vanilla/images/grp_opt_bg.gif" style="background-repeat:repeat-y;">
         <tr>
           <td colspan=2 valign=top>
             &nbsp;&nbsp;<input class=check type="checkbox" name="grp_menu_main" id="grp_menu_main" value="1" onmouseup="if (!this.checked) grp_menu_main[1].checked=false" detectchanges="off">&nbsp;<input class=check type="checkbox" name="grp_menu_main" value="0" onmouseup="if (!this.checked) grp_menu_main[0].checked=false" detectchanges="off">
            <label for="grp_menu_main">%%menu_main%%</label>
          </td>
         <tr>
           <td colspan=2 valign=top>
             &nbsp;&nbsp;<input class=check type="checkbox" name="grp_menu_top" id="grp_menu_top" value="1" onmouseup="if (!this.checked) grp_menu_top[1].checked=false" detectchanges="off">&nbsp;<input class=check type="checkbox" name="grp_menu_top" value="0" onmouseup="if (!this.checked) grp_menu_top[0].checked=false" detectchanges="off">
            <label for="grp_menu_top">%%menu_top%%</label>
          </td>
         </tr>
         <tr>
           <td colspan=2 valign=top>
             &nbsp;&nbsp;<input class=check type="checkbox" name="grp_menu_bottom" id="grp_menu_bottom" value="1" onmouseup="if (!this.checked) grp_menu_bottom[1].checked=false" detectchanges="off">&nbsp;<input class=check type="checkbox" name="grp_menu_bottom" value="0" onmouseup="if (!this.checked) grp_menu_bottom[0].checked=false" detectchanges="off">
            <label for="grp_menu_bottom">%%menu_bottom%%</label>
          </td>
         </tr>
         </tr>
         <tr>
           <td colspan=2 valign=top>
            &nbsp;&nbsp;<input class=check type="checkbox" name="grp_use_noindex" id="grp_use_noindex" value="1" onmouseup="if (!this.checked) grp_use_noindex[1].checked=false" detectchanges="off">&nbsp;<input class=check type="checkbox" name="grp_use_noindex" value="0" onmouseup="if (!this.checked) grp_use_noindex[0].checked=false" detectchanges="off">
            <label for="grp_use_noindex">%%use_noindex%%</label>
          </td>
         </tr>
        </table>
        </fieldset>
      </td>
     </tr>
     <tr>
       <td><br>
      </td>
     </tr>
     <tr>
       <td>
        <table cellspacing=0 cellpadding=3 border=0>
         <tr>
           <td colspan=2 style="padding-left:11px;">
             <input class=check type="checkbox" name="grp_generate_keywords" id="grp_generate_keywords" value="1" detectchanges="off" onclick="this.form.grp_generate_keywords_auto.disabled = !this.checked;">
             <label for="grp_generate_keywords">%%grp_generate_keywords%%</label>
          </td>
         </tr>
         <tr>
           <td colspan=2 style="padding-left:33px;padding-top:0px">
             <input class=check type="checkbox" name="grp_generate_keywords_auto" id="grp_generate_keywords_auto" value="1" detectchanges="off" checked>
             <label for="grp_generate_keywords_auto">%%grp_generate_keywords_auto%%</label>
          </td>
         </tr>
         <tr>
           <td colspan=2 style="padding-left:11px;">
             <input class=check type="checkbox" name="grp_generate_link" id="grp_generate_link" value="1" detectchanges="off" onclick="if (this.checked) { if (document.getElementById('grp_generate_link_block').style.display=='block') { blinkElement('grp_generate_link_info', 'visibility', 'hidden', 300, 2)} else { document.getElementById('grp_generate_link_block').style.display='block';}};">
             <label for="grp_generate_link">%%grp_generate_link%%</label>
          </td>
         </tr>
         <tr id=grp_generate_link_block style="display:none;">
           <td colspan=2 style="padding-left:14px;" valign=top>
             <div id=grp_generate_link_info><font color=#900000>%%grp_generate_link_info%%</font></div>
          </td>
         </tr>
        </table>
      </td>
     </tr>
     <tr>
       <td><br>
      </td>
     </tr>
   </table>
   <br>
   </div>

    <table cellspacing=0 cellpadding=0 border=0 width=100%>
     <tr>
        <td align=right>
              <input type="button" name="cancel" disabled onclick = "javascript:return confirm(_cms_form_changed_alert) ? treeframe.SetPageData() : false;" value="%%cancel_btn%%" class="but">
              <input type="submit" name="apply" value="%%apply_btn%%" class="but">
        </td>
     </tr>
   </table>

    </form>
</div>

<div id="no_page_properties_form" style="display:none">
%%page_loading_error_msg%%
</div>