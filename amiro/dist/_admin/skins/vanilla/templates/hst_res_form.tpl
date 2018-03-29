##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_res.lng"%%

<!--#set var="hint" value="
##if(!IS_USER)##
<div id="form_hint_link" style="text-align: right; font-size: 7pt; width: 100%;">
<a href="modules_templates_langs.php?id=##id##&action=edit&flt_tpl_name=##name##" target="hint_wnd">##if(form_hint != '')##%%hint_edit%%##else##%%hint_add%%##endif##</a>
</div>
##endif##
##if(form_hint != '')##
<div id="form_hint" style="font-size: 7pt; background-color: #FFFFE1; border: 1px #666666 solid; padding: 5px; width: 100%;">##form_hint##</div>
##endif##
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'hst_resform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
##pictures_js_vars##

function OnObjectChanged_hst_res_form(name, first_change){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_hst_res_form);

function CheckForm(form) {
   var errmsg = "";

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }
##--
   if (form.type.value=="") {
       return focusedAlert(form.type, '%%type_warn%%');
   }
--##
   return true;
}

function onAddResDepends() {
  var errmsg = "";
##if(action == "add")##
  var slave_id = 0;
##else## 
  var slave_id = window.document.hst_resform.id.value;
##endif## 
  var addedResDep = window.document.hst_resform.added_dep_resources.value;

//function openExtDialog(title, url, resizeable, scrollable, width, height, left, top, forceWindow, bDontWaitLoad)
  openExtDialog('%%hst_add_resource_depends%%',
                'hst_res.php?mode=select_depends&id_slave=' + slave_id + '&dest_field_id=added_dep_resources' + '&added_res_dep=' + addedResDep,
                1, 1, 700, 500);
  return false;
}

//-->
</script>


  ##form_hint##
  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="hst_resform" onSubmit="return CheckForm(window.document.hst_resform);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
     <tr>
       <td>
%%name%%*:
</td>
       <td>
         <input type=text name=name class="field field50" value="##name##" maxlength="255">
       </td>
     </tr>
     <tr>
       <td>
%%unit%%:
</td>
       <td>
         <input type=text name=unit class="field field50" value="##unit##" maxlength="32">
       </td>
     </tr>
##--
     <tr>
       <td>
%%type%%*:
</td>
       <td>
         <input type=text name=type class="field field50" value="##type##" maxlength="255">
       </td>
     </tr>
--##
     <tr>
       <td>
%%subtype%%:
</td>
       <td>
         <select name=subtype class=field>
            <option value="normal"##if(subtype=='normal')## selected##endif##>%%normal%%</option>
            <option value="on-off"##if(subtype=='on-off')## selected##endif##>%%on-off%%</option>
         </select>
       </td>
     </tr>
     <tr>
        <td colspan="2" align="right">
        <br>
            <input type=hidden name="added_dep_resources" id="added_dep_resources" value="##added_dep_resources##">
            <input type=button name=add_depends value="%%hst_add_res_depends_button%%" class="but" onClick="javascript:onAddResDepends();">
        <br><br>
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