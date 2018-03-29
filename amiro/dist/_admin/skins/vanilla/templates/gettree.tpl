%%include_language "templates/lang/main.lng"%%
%%include_language "templates/tree/tree.lng"%%
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
##init##

<!--#set var="ver_row" value="
          aVersions[##num##] = Array();
          aVersions[##num##]['id'] = '##id##';
          aVersions[##num##]['date'] = '##date##';
          aVersions[##num##]['user'] = '##user##';
          aVersions[##num##]['is_active'] = '##is_active##';
"-->

<!--#set var="ver_list" value="
          elNum = oForm.elements["page_version"].options.length;
          for (var i=elNum;i>=0;i--)
            oForm.elements["page_version"].options[i] = null;
          ##ver_list##
          if (aVersions.length == 0){
            var oOption = parent.document.createElement("OPTION");
            oForm.elements["page_version"].options.add(oOption);
            oOption.value = 0;
            oOption.innerHTML = "%%no_versions%%";
          }else{
            for (var i=0; i < aVersions.length; i++){
              var oOption = parent.document.createElement("OPTION");
              oForm.elements["page_version"].options.add(oOption);
              oOption.value = aVersions[i]['id'];
              oOption.innerHTML = aVersions[i]['date']; // + ' ['+aVersions[i]['user']+']';
              if (aVersions[i]['is_active'] == 1){
                oForm.elements["page_version"].value = aVersions[i]['id'];
                parent.current_version = aVersions[i]['id'];
              }
            }
          }

"-->

<!--#set var="mod_parent_splitter" value="::"-->

<!--#set var="mod_row" value="
          aModules[##num##] = Array();
          aModules[##num##]['name'] = '##name##';
          aModules[##num##]['caption'] = '##title##';
          aModules[##num##]['installed'] = '##installed##';
          aModules[##num##]['disabled'] = '##disabled##';
          aModules[##num##]['adminLink'] = '##adminLink##';
          aModules[##num##]['templates'] = Array('' ##templates##);
          aModules[##num##]['templates_ids'] = Array(##templates_ids##);
"-->

<!--#set var="mod_to_search_row" value="aModulesToSearch[##num##] = new Array ();
aModulesToSearch[##num##]['name'] = '##name##';
aModulesToSearch[##num##]['caption'] = '##caption##';
"-->
<!--#set var="mod_to_search_js" value="aModulesToSearch = new Array ();
##mod_list##
"-->

<!--#set var="mod_list" value="
          elNum = oForm.elements["module_name"].options.length;

          for (var i=elNum;i>=0;i--){
            oForm.elements["module_name"].options[i] = null;
          }
          ##mod_list##
          for (var i=0; i < aModules.length; i++){
            var oOption = parent.document.createElement("OPTION");
            oForm.elements["module_name"].options.add(oOption);
            oOption.value = aModules[i]['name'];
            oOption.innerHTML = aModules[i]['caption'];
            if(
              aModules[i]['installed'] != '1' ||
              aModules[i]['disabled'] == '1'
            ){
              oOption.style.color = "#808080";
              if(aModules[i]['installed'] != '1'){
                oOption.innerHTML = oOption.innerHTML+' (%%uninstalled%%)';
              }
              if(aModules[i]['disabled'] == '1'){
                AMI.$(oOption).attr('dis_func', '1');
                oOption.title = '%%unavailable_functionality%%';
              }
            }else{
              oOption.adminLink = aModules[i]['adminLink'];
            }
          }
"-->

<!--#set var="block_body_textarea" value="<textarea id="ta_lay_f##block_number##_body" style="display: none">##block_body##</textarea>
"-->
<!--#set var="block_body" value="parent.document.getElementById("lay_f##block_number##_body").value = document.getElementById('ta_lay_f##block_number##_body').value;
oForm.elements["lay_f##block_number##_body"].isModified = false;
oForm.elements["lay_f##block_number##_body_modified"].value = '';
oForm.elements["lay_f##block_number##_body_protected"].value = '##protected##';
oForm.elements["lay_f##block_number##_body"].Name = '##name##';
"-->

<!--#set var="block_name" value="<img src="skins/vanilla/images/bp_##checked##.gif" class=block_check id="img_f##block_number##_body_protected" width=12 height=12 border=0 blockNumber="##block_number##" onmouseover="setRuntimeStyle(this, 'borderColor', '#900000')" onmouseout="clearRuntimeStyle(this)" helpId='sm_lay_bp' align=absmiddle style="background-color:#ffffff;"> ##name## "-->

<!--#set var="block_name_read_only" value="<img src="skins/vanilla/images/bp_##checked##.gif" class=block_check id="img_f##block_number##_body_protected" width=12 height=12 border=0 helpId='sm_lay_bp' align=absmiddle style="background-color:#ffffff;"> ##name## "-->

<!--#set var="block_name2" value="<input type=checkbox hidefocus ##checked## class=block_check name="f##block_number##_body_protected" value="1"> ##name## "-->

<!--#set var="block_name1" value="##name## "-->

<textarea id="ta_lay_body_body" style="display: none">##lay_body_body##</textarea>
<textarea id="ta_html_title" style="display: none">##html_title##</textarea>
<textarea id="ta_html_keywords" style="display: none">##html_keywords##</textarea>
<textarea id="ta_html_description" style="display: none">##html_description##</textarea>
<textarea id="ta_html_head_tail" style="display: none">##html_head_tail##</textarea>
##textareas##

<script type="text/javascript">

var itemId = 0;
var oldPid = 0;
var targetId = 0;
var oldTargetId = 0;
var dragAction="";

function fromHTMLToText(str){
    str = str.replace(/<\/?[\w][^>]*?>/g, '');
    return str;
}

function CopyItem(itemId, targetId, Action){

  itemName = fromHTMLToText(document.getElementById("tree_it_"+itemId).innerHTML);
  targetName = fromHTMLToText(document.getElementById("tree_it_"+targetId).innerHTML);

  if (Action == "copy"){
    var confirmText = "%%copy_confirm1%% '" +itemName+"' %%copy_confirm2%% '"+targetName+"'";
  }
  else{
    var confirmText = "%%move_confirm1%% '" +itemName+"' %%move_confirm2%% '"+targetName+"'";
  }

  if (confirm(confirmText)){
    parent.document.getElementById('form_title').innerHTML = processing_msg;
    parent.document.getElementById('status-msgs').innerHTML = '';
    parent.document.getElementById('status-block').style.display = 'none';
    document.forms['ftree'].action.value = Action;
    document.forms['ftree'].op_itemid.value = itemId;
    document.forms['ftree'].op_newpid.value = targetId;
    parent.clipboardItemId = 0;
    document.forms['ftree'].submit();
    parent.document.getElementById("loading_msg").innerHTML = processing_msg;
    parent.document.getElementById("sm_tool_bar").style.display = "none";
    parent.document.getElementById("loading_msg").style.display = "block";
    parent.enableForm(false);
  }
}

</script>

<form name="ftree" action="gettree.php"  method="get" onSubmit="javascript:return false" style="margin: 0px; padding: 0px;">
  <input type="hidden" name="action" value="">
  <input type="hidden" name="op_itemid" value="">
  <input type="hidden" name="op_newpid" value="">
  <input type="hidden" name="itemid" value="##id##">
  <input type="hidden" name="position" value="##position##">
  <input type="hidden" name="selectedId" value="##selectedId##">
  <input type="hidden" name="parentId" value="##parentId##">
  <input type="hidden" name="expand" value="##expand##">
  <input type="hidden" name="search_url" value="">
  <input type="hidden" name="previousQuery" value="##previousQuery##" />
  <input type="hidden" name="foundPagesIds" value="##foundPagesIds##" />
</form>

##site_map##
<script type="text/javascript">

var _start_set_page_data = false;

var _tree_rm;
var tree_action;
var page_loading = "%%page_loading%%";
var tree_load = "%%tree_load%%";
var processing_msg = "%%processing%%";

var is_top = '##is_top##';
var is_bottom = '##is_bottom##';
var front_path = '##front_path##';
var page_mt = '##page_mt##';
top._mtloc = '';

var resetForm = parseInt('##reset_form##');

var aVersions = Array();
var aModules = Array();

//if (typeof(parent.errorHandler)=='function') window.onerror = parent.errorHandler;

if (parseInt('##_sys_right_w##')==0){
  var parentFormTitle = '%%pmanager_view%%' + ' [##title_name##] ';
}else{
  var parentFormTitle = '%%pmanager_edit%%' + ' [##title_name##] ';
}

function SetTemplates(){
  var oForm = parent.document.forms[parent._cms_document_form];
  elNum = oForm.elements["tpl_addon"].options.length;
  for (var i=elNum;i>=0;i--){
    oForm.elements["tpl_addon"].options[i] = null;
  }

  for (var i=0; i < aModules.length; i++){
    if(aModules[i]['name'] == oForm.elements['module_name'].value){
      var selModule = i;
    }
  }

  if(selModule && aModules[selModule] && (aModules[selModule]['name'] != 'redirect')){
    if (aModules[selModule]['templates'].length >= 1){
      for (var i=0; i < aModules[selModule]['templates'].length; i++){
        var oOption = parent.document.createElement("OPTION");
        var tplName = aModules[selModule]['templates'][i];
        oForm.elements["tpl_addon"].options.add(oOption);
        oOption.value = tplName;
        oOption.innerHTML = ((tplName=='')?'%%default%%':(aModules[selModule]['name'] + '_' + tplName + '.tpl'));
      }
      oForm.elements["tpl_addon"].disabled = '';
      parent.document.getElementById('tpl_addon_block').style.display = top.tableRowShowStyle;
    }else{
      parent.document.getElementById('tpl_addon_block').style.display = 'none';
    }

    if(!aModules[selModule]['templates_ids'].length || (aModules[selModule]['templates_ids'].length == 1 && aModules[selModule]['templates_ids'] == '')){
        oForm.elements["tpl_addon"].disabled = "disabled";
        oForm.elements["tpl_addon"].options[0].selected = "selected";
    }
  }else{
    parent.document.getElementById('tpl_addon_block').style.display = 'none';
  }
}

function SetPageData(){

  parent.document.getElementById('form_title').innerHTML ="%%page_setting%%";
  // scroll
  var tobj = document.getElementById('tree_it_##id##');

  if(tobj != null){

     objPtr = tobj;

     var posx = objPtr.offsetLeft;
     var posy = objPtr.offsetTop;

     while (objPtr.offsetParent != null) {
       objPtr = objPtr.offsetParent;
       posx += objPtr.offsetLeft;
       posy += objPtr.offsetTop;
     }

     posx -= 80;
     posy -= 52;
    window.scrollTo(posx, posy);
  }

  //parent.window.scrollTo(0,0); line 306

  if (resetForm){
    parent.clearForm("%%page_setting%%", false);
  }else{
      parent.enableForm(true);
  }

  var oTreeToolBar = parent.document.getElementById('tree_tool_bar');
  parent.document.getElementById("loading_msg").style.display = "none";
  parent.document.getElementById("sm_tool_bar").style.display = "block";

  var parentId = parseInt('##parentId##');
  var allowMultiLang = parseInt('##allow_multi_lang##');

  if ((parseInt('##_sys_right_w##')==1) && (parseInt('##_add_sub_allowed##')==1)){
    smEnableButton("addsub", true, true);
  }else{
    smEnableButton("addsub", false, true);
  }

  if ((parentId > 0 ) && ( parseInt('##deep_level##')!=0)){
    if ((parseInt('##_sys_right_w##')==1) && (parseInt(is_top) != 1)){
      smEnableButton("up", true, true); smEnableButton("top", true, true);
    }else{
      smEnableButton("up", false, true); smEnableButton("top", false, true);
    }
    if ((parseInt('##_sys_right_w##')==1) && (parseInt(is_bottom) != 1)){
      smEnableButton("down", true, true); smEnableButton("bottom", true, true);
    }else{
      smEnableButton("down", false, true); smEnableButton("bottom", false, true);
    }

    if ((parseInt('##_sys_right_d##')==1) && (parseInt('##removable##') == 1)){
      smEnableButton("del", true, true);
    }else{
      smEnableButton("del", false, true);
    }
    smEnableButton("add", true, true);
  }else{
    smEnableButton("up", false, true); smEnableButton("top", false, true);
    smEnableButton("down", false, true); smEnableButton("bottom", false, true);
    smEnableButton("del", false, true);
    smEnableButton("add", false, true);
  }

  if(!allowMultiLang || (parentId <= 0)){
    parent.document.getElementById("tr_page_use_hreflang").style.display = "none";
  }else if(allowMultiLang && (parentId > 0)){
    parent.document.getElementById("tr_page_use_hreflang").style.display = "table-row";
  }

  document.body.onunload = function() {
                                parent.document.getElementById("loading_msg").innerHTML = '%%tree_load%%';
                                parent.document.getElementById("loading_msg").style.display = "block";
                                parent.document.getElementById("sm_tool_bar").style.display = "none";
                                document.getElementById("tree").style.visibility="hidden";
                                };
  document.body.onkeypress = function(evt) {
                                evt = amiCommon.getValidEvent(evt);
                                if (evt.keyCode == 27){
                                  top.topWindowOnKeyPress(evt, window);
                                }
                              }


var _tree_rm = '%%root_message%%';
var tree_action = '##tree_action##';

##IF(pmanager_link)##
if (parent.document.getElementById('menu_up_pmanager')){
    parent.document.getElementById('menu_up_pmanager').onclick = function(){
        parent.window.location = '##pmanager_link##';
    };
}
##ENDIF##
##IF(modules_link)##
if (parent.document.getElementById('menu_up_modules')){
    parent.document.getElementById('menu_up_modules').onclick = function(){
        parent.window.location = '##modules_link##';
    };
}
##ENDIF##
##IF(eshop_link)##
if (parent.document.getElementById('menu_up_eshop')){
    parent.document.getElementById('menu_up_eshop').onclick = function(){
        parent.window.location = '##eshop_link##';
    };
}
##ENDIF##
##IF(kb_link)##
if (parent.document.getElementById('menu_up_kb')){
    parent.document.getElementById('menu_up_kb').onclick = function(){
        parent.window.location = '##kb_link##';
    };
}
##ENDIF##
##IF(portfolio_link)##
if (parent.document.getElementById('menu_up_portfolio')){
    parent.document.getElementById('menu_up_portfolio').onclick = function(){
        parent.window.location = '##portfolio_link##';
    };
}
##ENDIF##
##IF(services_link)##
if (parent.document.getElementById('menu_up_services')){
    parent.document.getElementById('menu_up_services').onclick = function(){
        parent.window.location = '##services_link##';
    };
}
##ENDIF##
##IF(plugins_link)##
if (parent.document.getElementById('menu_up_plugins')){
    parent.document.getElementById('menu_up_plugins').onclick = function(){
        parent.window.location = '##plugins_link##';
    };
}
##ENDIF##
##IF(wizard_link)##
if (parent.document.getElementById('menu_up_wizard')){
    parent.document.getElementById('menu_up_wizard').onclick = function(){
        parent.window.location = '##wizard_link##';
    };
}
##ENDIF##

if(resetForm){
    parent._cms_document_form_changed = false;
    parent._cms_log_form_changes = false;
    var oForm = parent.document.forms[parent._cms_document_form];

    ##mod_list##
    ##ver_list##

##--    //parent._page_module_admin_link = '##module_link##';--##

    oForm.elements['module_name'].value = '##module_name##';

##--
    if (oForm.elements['itemid'].value != '##id##'){
      //parent.clearUndo('body');
      //parent.globalUndoStates=Array();
    }
--##

    oForm.elements['id'].value = '##id##';
    oForm.elements['itemid'].value = '##id##';
    oForm.elements['parentId'].value = '##parentId##';
    oForm.elements['redirect_id'].value = '##redirect_id##';
    oForm.elements['name'].value = '##name##';
    parent.document.getElementById('form_title').innerHTML = parentFormTitle;
    oForm.elements['action'].value = 'apply';

    selectGrpPages();

    oForm.elements['oldname'].value = '##name##';
    oForm.elements['last_modified'].value = '##last_changed##';
    oForm.elements['public'].checked = (parseInt('##public##')==1)?1:0;
    oForm.elements['name'].disabled = (parseInt('##fixed_name##')==1)?1:0;

    if(oForm.elements['module_name'].value != 'print_version'){

      oForm.elements['show_me_at_parent'].checked = (parseInt('##show_me_at_parent##')==1)?1:0;
      oForm.elements['show_in_sitemap'].checked = (parseInt('##show_in_sitemap##')==1)?1:0;
      oForm.elements['show_siblings'].checked = (parseInt('##show_siblings##')==1)?1:0;
      oForm.elements['is_printable'].checked = (parseInt('##is_printable##')==1)?1:0;
      oForm.elements['skip_search'].checked = (parseInt('##skip_search##')==1)?1:0;

      oForm.elements['level'].value = '##deep_level##';
      oForm.elements['allowed_menu_level'].value = '##allowed_menu_level##';

      if (oForm.elements['level'].value > oForm.elements['allowed_menu_level'].value){
        oForm.elements['menu_main'].disabled = true;
      }else{
        oForm.elements['menu_main'].checked = (parseInt('##menu_main##')==1)?1:0;
      }
      parent.document.getElementById('main_menu_images').style.display = (parent.document.getElementById('menu_main').checked)?'block':'none';
      oForm.elements['is_section'].checked = (parseInt('##is_section##')==1)?1:0;
      oForm.elements['menu_top'].checked = (parseInt('##menu_top##')==1)?1:0;
      oForm.elements['menu_bottom'].checked = (parseInt('##menu_bottom##')==1)?1:0;
      oForm.elements['use_noindex'].checked = (parseInt('##use_noindex##')==1)?1:0;
      oForm.elements['page_noindex'].checked = (parseInt('##page_noindex##')==1)?1:0;
      if(parentId > 0){
        oForm.elements['page_use_hreflang'].checked = (parseInt('##use_hreflang##')==1)?1:0;
      }

  ##if(VISIBLE_AREA=="1")##
      oForm.elements['visible_area'].value = '##visible_area##';
  ##endif##

      oForm.elements['img_menu_normal'].value = '##img_menu_normal##';
      oForm.elements['img_menu_over'].value = '##img_menu_over##';
      oForm.elements['img_menu_active'].value = '##img_menu_active##';
      if (oForm.elements['img_menu_normal'].value != '')
        parent.document.getElementById('img_menu_normal_img').src = front_path + '##img_menu_normal##';
      if (oForm.elements['img_menu_over'].value != '')
        parent.document.getElementById('img_menu_over_img').src = front_path + '##img_menu_over##';
      if (oForm.elements['img_menu_active'].value != '')
        parent.document.getElementById('img_menu_active_img').src = front_path + '##img_menu_active##';

      //parent.document.getElementById('tab_navy').disabled = false;

    }else{

      //parent.document.getElementById('tab_navy').disabled = true;
      if (parent.document.getElementById('tab-page-navy').style.display == "block"){
        parent.baseTabs.showTab('body');
      }
    }

    oForm.elements['script_link'].value = '##script_link##';

    oForm.elements['html_title'].value = amiCommon.decodeHTMLSpecialChars(document.getElementById('ta_html_title').value);
    oForm.elements['html_title_inherit'].checked = (parseInt('##html_title_inherit##')==1)?1:0;
    if (oForm['html_title_inherit'].checked == true)
      parent.document.getElementById('html_title_prop').style.visibility='hidden'
    else
      parent.document.getElementById('html_title_prop').style.visibility='visible';
    oForm.elements['html_keywords'].value = document.getElementById('ta_html_keywords').value;
    oForm.elements['html_description'].value = document.getElementById('ta_html_description').value;
    oForm.elements['html_head_tail'].value = document.getElementById('ta_html_head_tail').value;

    SetTemplates();

    oForm.elements['tpl_addon'].value = '##tpl_addon##';

    if (parent.document.getElementById('front_link'))
      if (oForm.elements['public'].checked){
        parent.document.getElementById('front_link').href = '##front_link##';
        parent.document.getElementById('amiro-header__control__view-page').href = '##front_link##';
        parent.document.getElementById('front_link').onclick = '';
      }else{
        parent.document.getElementById('front_link').href = '';
        parent.document.getElementById('amiro-header__control__view-page').href = '##front_link##';
        parent.document.getElementById('front_link').onclick = function(){alert('%%not_published%%');return false;};
      }

    parent.moduleHasOptions = '##hasOptions##';
    parent.moduleAdminLink = '##adminLink##';

    ##blocks_bodies##

    oForm.elements["lay_body_body"].value = document.getElementById('ta_lay_body_body').value;
    oForm.elements["lay_body_body"].Name = '##lay_body_type##';
    oForm.elements["lay_body_body"].isModified = false;

    /* Remove all forms */
    var divLayout = document.createElement('div');
    divLayout.innerHTML = '##layout##';
    var layoutForms = divLayout.getElementsByTagName('form');
    for(i = 0; i < layoutForms.length; i++){
        layoutForms[i].parentNode.removeChild(layoutForms[i]);
    }

    parent.document.getElementById("box_layout").innerHTML = divLayout.innerHTML;
    parent.frontCustomCSSFile = '##layout_css##';
    oForm.elements["layout_id"].value = '##layout_id##';

    parent.enableForm(true);

    parent.InitLayout();

    tree_form_mode(oForm, 'edit', '##parentId##');


    if (parseInt('##page_created##') == 1){
      oForm.elements['name'].focus();
      oForm.elements['name'].select();
    }

    oForm.elements['dest_link'].value = '##dest_link##';
    parent.document.getElementById('is_redirect_0').checked = true;
    parent.document.getElementById('is_redirect_1').checked = false;
    parent.document.getElementById('dest_link_block').style.display = 'none';
    parent.document.getElementById('redirection_code_block').style.display = 'none';
    if('##redirection_code##' != ''){
        for(var i = 0, q = oForm.elements['redirection_code'].options.length; i < q; i++){
            if(oForm.elements['redirection_code'].options[i].value == '##redirection_code##'){
                oForm.elements['redirection_code'].selectedIndex = i;
                parent.document.getElementById('is_redirect_0').checked = false;
                parent.document.getElementById('is_redirect_1').checked = true;
                break;
            }
        }
    }

    if ((oForm.elements['redirect_id'].value != 0 ) || !parent.isURLLocal(oForm.elements['script_link'].value )){
      parent.setRedirectMode(true);
      parent.displayRedirectionControl(true);
      oForm.elements['module_name'].value = 'redirect';
      var redirectId = parseInt(oForm.elements['redirect_id'].value), isRedirect = redirectId < 0;
      var setSpesialRedirectPageMode = isRedirect && redirectId == -1;
      if(isRedirect){
          redirectId = -redirectId;
      }
      if (document.getElementById('tree_it_' + redirectId)){
        parent.setRedirectPage(redirectId);
      }else{
        if(!isRedirect){
            parent.isRedirectPageSet = false;
            parent.setRedirectPage(0);
        }
      }
      if(isRedirect){
        if(setSpesialRedirectPageMode){
            parent.setSpecialRedirectPageMode();
        }else{
            parent.isRedirectPageSet = true;
        }
        parent.checkRedirectURLAndTreePage(oForm.elements['dest_link']);
      }
    }else{
      parent.setRedirectMode(false);
      parent.setRedirectPage(0);
    }

    parent.amiPMSpecialPage.onLoad(oForm);

    parent.InitForm((parseInt('##_sys_right_w##')==1)?false:true);
  }else{
    selectGrpPages();
  }

 parent.document.getElementById("status-msgs").innerHTML = '##status_msgs##';

 if (parent.document.getElementById("status-msgs").innerHTML.length > 0){
     parent.document.getElementById("status-block").style.display = 'block';
 }
}

if (parent._pm_is_loaded){
  if (isNaN(parseInt('##id##'))  || isNaN(parseInt('##layout_id##'))){
    parent.document.getElementById('page_properties_form').style.display='none';
    parent.document.getElementById('no_page_properties_form').style.display='block';
    parent.clearForm(parentFormTitle , false);
    var oTreeToolBar = parent.document.getElementById('tree_tool_bar');
    parent.document.getElementById("loading_msg").style.display = "none";
  }else{
    parent.document.getElementById('page_properties_form').style.display='block';
    parent.document.getElementById('no_page_properties_form').style.display='none';
    SetPageData();
  }
}else{
  _start_set_page_data = true;
}
var foundPageId = '##foundPageId##';
if (foundPageId) {

    Array.prototype.indexOf = function(val, fromIndex) {
        if (typeof(fromIndex) != 'number') {
            fromIndex = 0;
        }
        for (var index = fromIndex,len = this.length; index < len; index++) {
            if (this[index] == val) {
                return index;
            }
        }
        return -1;
    }
    var foundPagesIds = document.forms['ftree'].foundPagesIds.value.split(',');
    if (foundPagesIds.indexOf(foundPageId) < 0) {
        foundPagesIds.push(foundPageId);
        document.forms['ftree'].foundPagesIds.value = foundPagesIds.join(',');
    }
    document.forms['ftree'].previousQuery.value = parent.document.forms['formPageSearch'].sm_search_string.value;
}

window.onload = function()
{
    var oSelect = parent.document.forms['formPageSearchByType'].sm_module_name;
    if (oSelect.options.length > 1) {
        return;
    }
    for (var i = 0, q = aModulesToSearch.length; i < q; i++) {
        var oOption = parent.document.createElement('OPTION');
        oSelect.options.add(oOption);
        oOption.value = aModulesToSearch[i]['name'];
        oOption.innerHTML = aModulesToSearch[i]['caption'];
    }
}

top.document.getElementById('notInstalledModId').innerHTML = '##notInstalledModId##';

</script>
</body>
</html>