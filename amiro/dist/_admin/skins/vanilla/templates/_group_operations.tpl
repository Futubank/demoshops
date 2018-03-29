%%include_language "templates/lang/_group_operations.lng"%%

<!--#set var="group_operations_script" value="
<SCRIPT LANGUAGE="JavaScript">
<!--
var _cms_group_operations_form = 'group_operations_form';

var _groupInitialized = false;
var _groupFieldName = '_grp_ids';


function grpInitialize() {
  if(!_groupInitialized) {
    var oForm = document.forms[_cms_document_form];
    if(typeof(oForm.elements['enc_' + _groupFieldName]) != 'undefined') {
      oForm.elements['enc_' + _groupFieldName].value = oForm.elements[_groupFieldName].value;
      _groupFieldName = 'enc_' + _groupFieldName;
    }
    _groupInitialized = true;
  }
}

function grpInitRowItems() {
  var oGrpForm = document.forms[_cms_group_operations_form];
  for (var i=0; i<oGrpForm.elements.length ;i++ ){
    if (oGrpForm.elements[i].name.substr(0, 9)=='group_id_') {
      selGroupRow(oGrpForm.elements[i].value, oGrpForm.elements[i].checked);
    }
  }
  grpResetButtonUpdate();
}

function grpSelectAllItems() {
  var oGrpForm = document.forms[_cms_group_operations_form];
  grpInitialize();
  for (var i=0; i<oGrpForm.elements.length ;i++ ){
    if (oGrpForm.elements[i].name.substr(0, 9)=='group_id_') {
      oGrpForm.elements[i].checked = oGrpForm.elements['group_all'].checked;
      selGroupRow(oGrpForm.elements[i].value, oGrpForm.elements[i].checked);
      grpUpdateItemsList(oGrpForm.elements[i].value, oGrpForm.elements[i].checked);
    }
  }
}

function grpResetAll() {
  var oGrpForm = document.forms[_cms_group_operations_form];
  var oForm = document.forms[_cms_document_form];

  oGrpForm.elements['group_all'].checked = false;
  grpSelectAllItems();
  oGrpForm.elements['_grp_num_checked'].value = 0;
  oForm.elements[_groupFieldName].value = '';
  grpResetButtonUpdate();
}

function grpChangeItem(itemId) {
  var oGrpForm = document.forms[_cms_group_operations_form];
  grpInitialize();
  oGrpForm.elements['group_all'].checked = false;
  var itemChecked = oGrpForm.elements['group_id_'+itemId].checked;
  selGroupRow(itemId, itemChecked);
  grpUpdateItemsList(itemId, itemChecked);
}

function grpUpdateItemsList(itemId, itemChecked) {
  var oForm = document.forms[_cms_document_form];
  var oGrpForm = document.forms[_cms_group_operations_form];
  if(itemChecked) {
    if(oForm.elements[_groupFieldName].value.length == 0) {
      oForm.elements[_groupFieldName].value = ';';
    }
    if(oForm.elements[_groupFieldName].value.indexOf(';' + itemId + ';') == -1) {
      oForm.elements[_groupFieldName].value += itemId + ';';
      oGrpForm.elements['_grp_num_checked'].value = parseInt(oGrpForm.elements['_grp_num_checked'].value) + 1;
    }
  } else {
    oForm.elements[_groupFieldName].value = oForm.elements[_groupFieldName].value.replace(';'+itemId+';', ';');
    oGrpForm.elements['_grp_num_checked'].value = parseInt(oGrpForm.elements['_grp_num_checked'].value) - 1;
  }
  grpResetButtonUpdate();
}

function grpResetButtonUpdate(){
  var oGrpForm = document.forms[_cms_group_operations_form];
  if (parseInt(oGrpForm.elements['_grp_num_checked'].value) == 0){
    document.getElementById('group_itemlist_reset').disabled=true;
    //document.getElementById('group_operations_panel').disabled=true;
  }else{
    document.getElementById('group_itemlist_reset').disabled=false;
    //document.getElementById('group_operations_panel').disabled=false;
  }
}

function grpCheckSelection() {
  var oForm = document.forms[_cms_document_form];
  if(oForm.elements[_groupFieldName].value == '' || oForm.elements[_groupFieldName].value == ';') {
      alert('%%group_nonchecked_warn%%');
      return false;
  }
  return true;
}

function _grpGetUrl(action) {
  var sform = document.forms[_cms_document_form];
  var link = _cms_script_link;
  sform.action.value = 'grp_'+action;
  var url = link + collect_link(sform);
  return url;
}

function grpAction(action) {
  document.location = _grpGetUrl(action);
  return false;
}

function grpBlankAction(action) {
  window.open( _grpGetUrl(action));
  return false;
}

function grpAdvAction(action, urlParams) {
  document.location = _grpGetUrl(action) + urlParams;
  return false;
}

function grpPopupAction(action, title, width, height, left, top){
  var url = _grpGetUrl(action);
  openDialog(title, url, width, height, left, top);
}

function selGroupRow(itemId, itemChecked){
  var oRow = document.getElementById('group_row_'+itemId);
  if (oRow){
    highLightRow(oRow, 0);
    if (itemChecked){
      //oRow.runtimeStyle.backgroundColor="#F8DDE4";
      setRuntimeStyle(oRow, 'backgroundColor', '#F8DDE4');
    }else{
      //oRow.runtimeStyle.backgroundColor="";
      setRuntimeStyle(oRow, 'backgroundColor', '');
    }
  }
}

function groupDelConfirm(){
    return confirm('%%grp_delete_warn%%');
}
//-->
</SCRIPT>
"-->

<!--#set var="group_operations_header" value="<td class="first_row_left_td" align="center" style="padding:0px;" width="1%"><input type="checkbox" name="group_all" onClick="grpSelectAllItems();" title="%%select_all_on_page%%"></td>"-->

<!--#set var="group_operations_col" value="<td align="right"><input type="checkbox" name="group_id_##id##" value="##id##" onClick="grpChangeItem(this.value)" ##_group_checked##></td>"-->
<!--#set var="group_operations_no_col" value="<td align="right">&nbsp;</td>"-->

<!--#set var="group_operations_footer" value="
  <div class=group_operations_panel id='group_operations_panel'><b>%%group_num_checked%%:</b> <input type="text" name="_grp_num_checked" value="##_group_num_checked##" readonly style=" text-align:right;" class="field field4"> &nbsp;##_group_operations_reset##
  <br><b>%%group_operations%%:</b> ##_group_actions##
  </div>
<script>
grpInitRowItems();
</script>
"-->


<!--#set var="icons_grp_book"     value="<a href="javascript:grpAction('book');" onClick="return (grpCheckSelection() && confirm('%%grp_book_warn%%'));"><img title="%%icon_grp_book%%" class=icon src="skins/vanilla/icons/icon-ok.gif" align=absmiddle hspace=3></a>"-->

<!--#set var="icons_grp_email"     value="<a href="javascript:grpAction('email');" onClick="return (grpCheckSelection() && confirm('%%grp_email_warn%%'));"><img title="%%icon_grp_email%%" class=icon src="skins/vanilla/icons/icon-email.gif" align=absmiddle hspace=3></a>"-->

<!--#set var="icons_grp_del"     value="<a href="javascript:grpAction('del');" onClick="return (grpCheckSelection() && groupDelConfirm());"><img title="%%icon_grp_del%%" class=icon src="skins/vanilla/icons/icon-del.gif" align=absmiddle hspace=3></a>"-->

<!--#set var="popup_grp_del"     value="<a href="javascript:grpAction('del');" onClick="return (grpCheckSelection() && groupDelConfirm());"><img title="%%icon_grp_del%%" class=icon src="skins/vanilla/icons/icon-del.gif" align=absmiddle hspace=3></a>"-->

<!--#set var="icons_grp_copy"     value="<a href="javascript:grpAction('copy');" onClick="return (grpCheckSelection() && confirm('%%grp_copy_warn%%'));"><img title="%%icon_grp_copy%%" class=icon src="skins/vanilla/icons/icon-copy.gif" align=absmiddle hspace=3></a>"-->

<!--#set var="icons_grp_publish_on"    value="<a href="javascript:grpAction('publish_on');" onClick="return (grpCheckSelection() && confirm('%%grp_public_on_warn%%'));"><img title="%%icon_grp_publish_on%%" class=icon src="skins/vanilla/icons/icon-published.gif" border="0" helpId="btn_grp_public_on" align=absmiddle hspace=3></a>"-->

<!--#set var="icons_grp_publish_off"    value="<a href="javascript:grpAction('publish_off');" onClick="return (grpCheckSelection() && confirm('%%grp_public_off_warn%%'));"><img title="%%icon_grp_publish_off%%" class=icon src="skins/vanilla/icons/icon-notpublished.gif" border="0" helpId="btn_grp_public_off" align=absmiddle hspace=3></a>&nbsp;&nbsp;|&nbsp;&nbsp;"-->

<!--#set var="icons_grp_special_on"     value="<a href="javascript:grpAction('special_on');" onClick="return (grpCheckSelection() && confirm('%%grp_special_on_warn%%'));"><img title="%%icon_grp_special_on%%" class=icon src="skins/vanilla/icons/icon-special1.gif" border="0" helpId="btn_grp_special_on" align=absmiddle hspace=3></a>"-->

<!--#set var="icons_grp_special_off"    value="<a href="javascript:grpAction('special_off');" onClick="return (grpCheckSelection() && confirm('%%grp_special_off_warn%%'));"><img title="%%icon_grp_special_off%%" class=icon src="skins/vanilla/icons/icon-notspecial1.gif" border="0" helpId="btn_grp_special_off" align=absmiddle hspace=3></a>&nbsp;&nbsp;|&nbsp;&nbsp;"-->

<!--#set var="icons_grp_special_advanced"     value="<a href="javascript:void(0)" onClick="if(grpCheckSelection() && confirm('%%grp_special_advanced_warn%%')){grpPopupAction('special_advanced', '%%eshop_grp_special_form%%', 400, 280);} return false;"><img title="%%icon_grp_special_advanced%%" class=icon src="skins/vanilla/icons/icon-special1.gif" border="0" helpId="btn_grp_special_advanced" align=absmiddle hspace=3></a>&nbsp;&nbsp;|&nbsp;&nbsp;"-->

<!--#set var="icons_grp_id_page" value="
<nobr>&nbsp;&nbsp;|&nbsp;&nbsp;
<select name="grp_type">
    <option value="move">%%grp_move_items%%</option>
    <option value="copy">%%grp_copy_items%%</option>
</select>
%%grp_popup_on_page%%:&nbsp;<span id="idPageSelectPlace"></span>
&nbsp;<input type="button" value="OK" class="but-short" onClick="if(grpCheckSelection() && confirm('%%grp_id_page_warn%%')){grpAdvAction('id_page', '&grp_type='+this.form.grp_type.value+'&grp_id_page='+this.form.grp_id_page.value);};"></nobr>
<script type="text/javascript">groupOperationsCreateIdPage()</script>
"-->

<!--#set var="icons_grp_change_parent_cat" value="
<nobr>&nbsp;&nbsp;|&nbsp;&nbsp;
<select name="grp_type">
    <option value="move">%%grp_move_items%%</option>
    <option value="copy">%%grp_copy_items%%</option>
</select>
%%grp_to_category%%:&nbsp;<span id="idCatSelectPlace"></span>
&nbsp;<input type="button" value="OK" class="but-short" onClick="if(grpCheckSelection() && confirm('%%grp_id_cat_warn%%')){grpAdvAction('change_parent_cat', '&grp_type='+this.form.grp_type.value+'&grp_id_cat='+this.form.grp_id_cat.value);};"></nobr>
<script type="text/javascript">groupOperationsCreateParentCat()</script>
"-->

<!--#set var="icons_grp_open_popup" value="&nbsp;&nbsp;|&nbsp;&nbsp;<input type="button" name="grp" value="%%icon_grp_open_popup%%" class="but" onClick="javascript:if(grpCheckSelection()) {grpPopupAction('open_popup', '%%group_operations%%', 760, 535)}; return false;">"-->

<!--#set var="grp_popup_id_page_body" value="
<table border=0 cellspacing=2 cellpadding=0>
<tr>
  <td>
    <input type="radio" name="grp_type" value="move" id="grp_type_move" checkedGrp="id_page">
  </td>
  <td>
    <label for="grp_type_move">%%grp_move_items%%</label>
  </td>
  <td rowspan="2" style="padding-left: 20px;">
    %%grp_popup_on_page%%:&nbsp;<select name="grp_id_page"><option value=0>%%grp_popup_all_pages%%</option>##pages_list##</select>
  </td>
</tr>
  <td>
    <input type="radio" name="grp_type" value="copy" id="grp_type_copy" checkedGrp="id_page">
  </td>
  <td>
    <label for="grp_type_copy">%%grp_copy_items%%</label>
  </td>
<tr>
    
</tr>
</table>
"-->

<!--#set var="grp_popup_common_row" value="
##if(action=='index_details')##
<tr>
  <td></td><td><hr></td>
</tr>
##endif##
<tr>
  <td><input type="radio" name="_grp_action" value="##action##" id="##action##"></td>
  <td><label for="##action##">##caption##</label></td>
</tr>
##if(action=='publish_off' || action=='archive_off' || action=='del')##
<tr>
  <td></td><td><hr></td>
</tr>
##endif##
"-->

<!--#set var="grp_popup_common_row_gen_keywords" value="
<tr>
  <td><input type="radio" name="_grp_action" value="##action##" id="##action##" onClick="this.form.gen_keywords_force.value=0;"></td>
  <td><label for="##action##">%%icon_grp_gen_keywords%%</label></td>
</tr>
<tr>
  <td><input type="radio" name="_grp_action" value="##action##" id="##action##_force" onClick="this.form.gen_keywords_force.value=1;"></td>
  <td><label for="##action##_force">%%icon_gen_keywords%%</label></td>
</tr>
<input type="hidden" name="gen_keywords_force">
"-->

<!--#set var="grp_popup_common_list" value="
<tr>
  <td>
    <fieldset style="padding: 5px;" onClick="popupSetGroup(event, 'common');" id="fs_common">
      <legend><b>##caption##</b></legend>
      <table cellspacing="0" cellpadding="3" width="100%">
      ##common_list##
      </table>
    </fieldset>
  </td>
</tr>
"-->

<!--#set var="grp_popup_custom_row" value="
<tr>
  <td>
    <fieldset style="padding: 5px;" onClick="popupSetGroup(event, '##action##');" id="fs_##action##">
      <legend><b>##caption##</b></legend>
      <table cellspacing="0" cellpadding="3" width="100%">
        <tr>
          <td colspan="2">##data##</td>
        </tr>
      </table>
    </fieldset>
  </td>
</tr>
"-->


<!--#set var="grp_popup_operation_list" value="
<script>
<!--

var _grpPrevGroup;
_grpPrevGroup = '';

function popupGrpAction() {

  if(document.grpForm.grp_action.value != '') {
    if(document.grpForm.grp_action.value == 'special_advanced'){
        top.grpPopupAction('special_advanced', '%%eshop_grp_special_form%%', 400, 280);
    }else{
        top.document.location = top._grpGetUrl(document.grpForm.grp_action.value) + '&' + top.collect_link(document.grpForm, true);
    }
    closeDialogWindow();
    return true;
  } else {
    alert('%%grp_popup_no_action_warn%%');
    return false;
  }
}


function popupSetGroup(evt, grpId) {
  evt = amiCommon.getValidEvent(evt);
  var target = amiCommon.getEventTarget(evt);
    
  var i, n, val;
  val = '';

  if(target.tagName != 'INPUT') {
    return;
  }

  n = document.grpForm._grp_action.length;
  if(grpId == 'common') {
      if(isNaN(n)){
          document.grpForm.grp_action.value = document.grpForm._grp_action.value;
      }else{
          for(i=0; i<n; i++){
              if(document.grpForm._grp_action[i].checked){
                  document.grpForm.grp_action.value = document.grpForm._grp_action[i].value;
                  break;
              }
          }
      }

  } else {
    document.grpForm.grp_action.value = grpId;
    if(isNaN(n)){
        document.grpForm._grp_action.checked = false;
    }else{
        for(i=0; i<n; i++) {
            if(document.grpForm._grp_action[i].checked) {
                document.grpForm._grp_action[i].checked = false;
                break;
            }
        }
    }
  }

  n = document.grpForm.elements.length;
  for(i=0 ; i<n; i++) {
    var el = document.grpForm.elements[i];
    var attr = el.getAttribute("checkedGrp");

    if(typeof(attr) != "undefined" && attr != null) {
      if(attr != grpId) {
        el.checked = false;
      }
    }
  }

  

  if(_grpPrevGroup != grpId) {
    document.getElementById('fs_' + grpId).className = 'grppopup_sel';
    if(_grpPrevGroup != '') {
      document.getElementById('fs_' + _grpPrevGroup).className = 'grppopup_norm';
    }
    _grpPrevGroup = grpId;
  }
}

//-->
</script>
<form name="grpForm">
<input type="hidden" name="grp_action" value="">
<table cellspacing="0" cellpadding="10" align="center" width=100%>
##list##
<tr>
  <td colspan="2" align="right"><input type="button" value="%%ok_btn%%" class="but" onClick="popupGrpAction();">&nbsp;<input type="button" value="%%cancel_btn%%" class="but" onClick="closeDialogWindow();"></td>
</tr>
</table>
</form>
"-->

<!--#set var="icons_grp_archive_on"     value="<a href="javascript:grpAction('archive_on');" onClick="return (grpCheckSelection() && confirm('%%grp_archive_on_warn%%'));"><img title="%%icon_grp_archive_on%%" class=icon src="skins/vanilla/icons/icon-archived.gif" border="0" helpId="btn_grp_archive_on" align=absmiddle hspace=3></a>"-->

<!--#set var="icons_grp_archive_off"    value="<a href="javascript:grpAction('archive_off');" onClick="return (grpCheckSelection() && confirm('%%grp_archive_off_warn%%'));"><img title="%%icon_grp_archive_off%%" class=icon src="skins/vanilla/icons/icon-not_archived.gif" border="0" helpId="btn_grp_archive_off" align=absmiddle hspace=3></a>&nbsp;&nbsp;|&nbsp;&nbsp;"-->

<!--#set var="icons_grp_active_on"     value="<a href="javascript:grpAction('active_on');" onClick="return (grpCheckSelection() && confirm('%%grp_active_on_warn%%'));"><img title="%%icon_grp_active_on%%" class=icon src="skins/vanilla/icons/icon-ok.gif" helpId="btn_grp_active_on" align=absmiddle hspace=3></a>"-->

<!--#set var="icons_grp_active_off"    value="<a href="javascript:grpAction('active_off');" onClick="return (grpCheckSelection() && confirm('%%grp_active_off_warn%%'));"><img title="%%icon_grp_active_off%%" class=icon src="skins/vanilla/icons/icon-close.gif" helpId="btn_grp_active_off" align=absmiddle hspace=3></a>&nbsp;&nbsp;|&nbsp;&nbsp;"-->

<!--#set var="icons_grp_reset"     value="<a href="javascript:grpAction('reset');" onClick="return (grpCheckSelection() && confirm('%%grp_reset_pass_warn%%'));"><img title="%%icon_grp_reset_pass%%" class=icon src="skins/vanilla/icons/icon-reset_pass.gif" align=absmiddle hspace=3></a>
"-->

<!--#set var="icons_grp_print"     value="<a href="#" onClick="if (grpCheckSelection() && confirm('%%grp_print_warn%%')) grpBlankAction('print'); return false;"><img title="%%icon_grp_print%%" class=icon src="skins/vanilla/icons/icon-print.gif" align=absmiddle hspace=3></a>
"-->

<!--#set var="icons_grp_export"     value="<a href="#" onClick="if (grpCheckSelection()) grpBlankAction('export'); return false;"><img title="%%icon_grp_export%%" class=icon src="skins/vanilla/icons/icon-file.gif" align=absmiddle hspace=3></a>
"-->

<!--#set var="group_operations_reset"    value="<span id="group_itemlist_reset" onclick="javascript:grpResetAll();" class="text_button">%%grp_reset_all%%</span>"-->


<!--#set var="icons_grp_reset_ratings"   value="
##if(EXTENSION_RATING=="1")##
<b>&nbsp;&nbsp;|&nbsp;&nbsp;</b><a href="javascript:grpAction('reset_ratings');" onClick="return (grpCheckSelection() && confirm('%%grp_reset_ratings_warn%%'));"><img title="%%icon_grp_reset_ratings%%" class=icon src="skins/vanilla/icons/icon-reset_num.gif" helpId="btn_grp_reset_rating" align=absmiddle hspace=3></a><b>&nbsp;
##endif##
"-->


<!--#set var="icons_grp_gen_keywords"    value="
<script type="text/javascript">
<!--
function grpActionGenKeywords(force) {
  var sform = document.forms[_cms_document_form];
  var link = _cms_script_link;
  var param = '';
  sform.action.value = 'grp_gen_keywords';
  if(force) {
    param = '&gen_keywords_force=1';
  }
  document.location = link + collect_link(sform) + param;
  return false;
}

//-->
</script>
<a href="javascript:grpActionGenKeywords(1);" onClick="return (grpCheckSelection() && confirm('%%grp_gen_keywords_warn%%'));"><img title="%%icon_grp_gen_keywords%%" class=icon src="skins/vanilla/icons/icon-genkw.gif" helpId="btn_gen_keywords_manual" align=absmiddle hspace=3></a>
<a href="javascript:grpActionGenKeywords(0);" onClick="return (grpCheckSelection() && confirm('%%grp_gen_keywords_warn%%'));"><img title="%%icon_gen_keywords%%" class=icon src="skins/vanilla/icons/icon-genkw_force.gif" helpId="btn_gen_keywords" align=absmiddle hspace=3></a>
"-->

<!--#set var="icons_grp_gen_sublink"    value="&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:grpAction('gen_sublink');" onClick="return (grpCheckSelection() && confirm('%%grp_gen_sublink_warn%%'));"><img title="%%icon_grp_gen_sublink%%" class=icon src="skins/vanilla/icons/icon-genlink.gif" helpId="btn_gen_sublink_on" align=absmiddle hspace=3></a>"-->

<!--#set var="icons_grp_index_details" value="<b>&nbsp;&nbsp;|&nbsp;&nbsp;</b><a href="javascript:grpAction('index_details');" onClick="return (grpCheckSelection() && confirm('%%grp_index_details_warn%%'));"><img title="%%icon_grp_index_details%%" class=icon src="skins/vanilla/icons/icon-index.gif" helpId="btn_gen_index_details" align=absmiddle hspace=3></a>"-->

<!--#set var="icons_grp_no_index_details" value="<a href="javascript:grpAction('no_index_details');" onClick="return (grpCheckSelection() && confirm('%%grp_no_index_details_warn%%'));"><img title="%%icon_grp_no_index_details%%" class=icon src="skins/vanilla/icons/icon-no_index.gif" helpId="btn_gen_no_index_details" align=absmiddle hspace=3></a>"-->

<!--#set var="icons_grp_move_position" value="
##if(POSITIONS_COL_ENABLED == 1)##
<script type="text/javascript">
<!--
function grpMovePositionOnChange(selVal) {
  var enabled;
  var el;
  el = document.getElementById("move_position_div");
  disabled = !(selVal=='custom');
  document.forms[_cms_group_operations_form].move_position.disabled = disabled;
  el.style.display = (disabled)?'none':'inline';
  if(!disabled) {
    document.forms[_cms_group_operations_form].move_position.focus();
  }
}

function grpMovePositionCheckForm() {
  var form, selVal, pos;
  form = document.forms[_cms_group_operations_form];
  selVal = form.grp_subaction.value;
  if(selVal == 'custom') {
    pos = parseInt(form.move_position.value);
    if(isNaN(pos) || pos < 1) {
      alert('%%grp_move_position_warn%%');
      form.move_position.focus();
      return false;

    }
  }
  return true;
}

//-->
</script>



&nbsp;&nbsp;|&nbsp;&nbsp;%%grp_move_position%%:&nbsp;<select name="grp_subaction" class="select" onChange="grpMovePositionOnChange(this.value)"><option value="top">%%grp_move_position_top%%</option><option value="bottom">%%grp_move_position_bottom%%</option><option value="custom">%%grp_move_position_custom%%</option></select>&nbsp;<div id="move_position_div" style="display: none" disabled>##--%%grp_move_position_num%%--##&nbsp;<input type="text" name="move_position" class="field field3"  disabled></div>&nbsp;<input type="button" value="%%ok_btn%%" class="but-short" onClick="if((grpCheckSelection() && grpMovePositionCheckForm() && confirm('%%grp_move_position_confirm%%'))) {grpAdvAction('move_position', '&grp_type='+this.form.grp_subaction.value+'&grp_position='+this.form.move_position.value);}" style="margin-bottom:-1px;">##endif##
"-->
