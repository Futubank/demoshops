##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/modules_templates.lng"%%

<!--#set var="option" value="<option value="##value##" ##selected##>##name##</option>"-->

<script type="text/javascript">
<!--

var _cms_document_form = 'modulestemplatesform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function tplsAction(act){
  var sform = document.forms[_cms_document_form];
  var link = _cms_script_link;

  var doAction = false;
  if(act == 'export' && confirm('%%do_export%%')){doAction = true;##if(isChooseExportSyncType)##
      if(!confirm('%%choose_export_type%%')){
        sform.sync_type.value = 1;
      }
  ##endif##}else if(act == 'import' && confirm('%%do_import%%')){doAction = true;##if(isChooseImportSyncType)##
      if(!confirm('%%choose_import_type%%')){
        sform.sync_type.value = 1;
      }
  ##endif##}

  if(doAction){
      sform.action.value = act;
      document.location = link + collect_link(sform);
  }

  return false;
}

function OnObjectChanged_modules_templates_form(name, first_change, evt){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_modules_templates_form);

function CheckForm(form) {
   var errmsg = "";
   
   var res = oTextEditor.save();
   if(res === false){
       form.ta_position.value = getCaretPos('txtArea');
   }else{
       form.ta_position.value = res;
   }
   
   // Check form
   var nameRX = new RegExp("^[a-zA-Z0-9_\\-\\.]+$");
   if (form.name && !nameRX.test(form.name.value)){
       return focusedAlert(form.name, '%%tplname_warn%%');
   }

   return true;
}

function LocalBodyOnLoad() {
    setCaretPos("txtArea", document.modulestemplatesform.ta_position.value);
    if(document.modulestemplatesform.ta_highlight.value != 'no'){
        oTextEditor.highlight(true);
        document.modulestemplatesform.ta_highlight_flag.checked = true;
    }else{
        document.modulestemplatesform.ta_highlight_flag.checked = false;
    }
}

function _hlCtrlFWarning(){
    return focusedAlert(document.getElementById('_hl_search'), '%%hl_ctrlf_warning%%');
}

//-->
</script>


  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="modulestemplatesform" onSubmit="return CheckForm(window.document.modulestemplatesform);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type="hidden" name="sync_type" value="2">
     <input type="hidden" name="ta_position" value="##ta_position##">
     <input type="hidden" name="ta_highlight" value="##ta_highlight##">
     <table cellspacing="0" cellpadding="0" border="0" width=100%>
	<col width="150">
	<col width="*">
     <tr>
       <td>
        %%name%%*:
       </td>
       <td>
         ##if(is_sys)##
         ##name##.tpl
         ##else##
         <input type=text name=name class="field field50" value="##name##" maxlength="255"><b>.tpl</b>
         ##endif##
       </td>
     </tr>
     <tr>
       <td>
        %%path%%:
       </td>
       <td>
         ##if(is_sys)##
         ##paths_current##
         ##else##
         <select name="path">
         ##paths##
         </select>
         ##endif##
       </td>
     </tr>
     <tr>
       <td>
        %%module%%:
       </td>
       <td>
         ##if(is_sys)##
         ##modules_current##
         ##else##
         <select name="module">
         ##modules##
         </select>
         ##endif##
       </td>
     </tr>
     <tr>
       <td colspan=2>
         &nbsp;<br>
         <div style="overflow: hidden">
             %%content%%:
             <label style="display: block; float: right; padding-bottom:6px;"><input type="checkbox" name="ta_highlight_flag" value="1" onChange="oTextEditor.highlight(this.checked); document.modulestemplatesform.ta_highlight.value = this.checked ? 'yes' : 'no'; AMI.find('#_hl_search_bar').style.display = this.checked ? 'block' : 'none';"> %%highlight_code%%</label>
             <div id="_hl_search_bar" style="float:right; padding-right:16px;">
                 %%hl_search_for%%: <input type="text" id="_hl_search" class="field field10" onkeypress="return hl_searchEnterKeyPress(event);"/>
                 <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_search_continue.gif" onclick="oTextEditor.search(AMI.find('#_hl_search').value);" title="%%hl_search%%">
                 &nbsp;&nbsp;&nbsp;
                 %%hl_replace_with%%: <input type="text" id="_hl_replace"  class="field field10" onkeypress="return hl_replaceEnterKeyPress(event);"/>
                 <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_replace.gif" onclick="oTextEditor.replace(AMI.find('#_hl_search').value, AMI.find('#_hl_replace').value, '%%hl_confirm_replace%%');" title="%%hl_replace%%">
                 <img class="imgButton" align="absmiddle" src="##skin_path##/images/ed_replace_all.gif" onclick="oTextEditor.replaceAll(AMI.find('#_hl_search').value, AMI.find('#_hl_replace').value, '%%hl_confirm_replace_all%%');" title="%%hl_replace_all%%">
                 <script type="text/javascript">
                 <!--
                    function hl_searchEnterKeyPress(e){
                        var evt=(e)?e:(window.event)?window.event:null;
                        if(evt){
                            var key=(evt.charCode)?evt.charCode:
                                ((evt.keyCode)?evt.keyCode:((evt.which)?evt.which:0));
                            if(key=="13"){
                                oTextEditor.search(AMI.find('#_hl_search').value);
                                AMI.find('#_hl_search').focus();
                                return false;
                            }
                        }
                        return true;
                    }

                    function hl_replaceEnterKeyPress(e){
                        var evt=(e)?e:(window.event)?window.event:null;
                        if(evt){
                            var key=(evt.charCode)?evt.charCode:
                                ((evt.keyCode)?evt.keyCode:((evt.which)?evt.which:0));
                            if(key=="13"){
                                oTextEditor.replace(AMI.find('#_hl_search').value, AMI.find('#_hl_replace').value, '%%hl_confirm_replace%%');
                                AMI.find('#_hl_replace').focus();
                                return false;
                            }
                        }
                        return true;
                    }

                 -->
                 </script>
             </div>
         </div>
         <textarea name=body class=field style="width: 100%; height: 500px; font-family: Courier New; font-size: 13px; background: #f0f0f0" id="txtArea" wrap="OFF">##body##</textarea>
       </td>
     </tr>
     <tr>
        <td colspan="2" align="right">
        <br>
        ##form_buttons##
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
    
<script type="text/javascript">
    var oTextEditor = new AMI.TextEditor('txtArea');
</script>