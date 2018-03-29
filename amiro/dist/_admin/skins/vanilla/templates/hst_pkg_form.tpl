##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_pkg.lng"%%

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

<!--#set var="empty_resources_list" value="
<tr>
  <td class=row1 align=center colspan=4><h3>%%no_resources%%</h3></td>
</tr>
"-->

<!--#set var="resource_row" value="<tr>
  <td class="row##row_style_index##"><input name="resid##res_id##" id="resid##res_id##" type=hidden value="##res_id##">##res_name##&nbsp;##if (res_unit != '')## (##res_unit##)##endif##</td>
  <td class="row##row_style_index##"><input type="checkbox" name="res_included_##res_id##" id="res_included_##res_id##" ##included## value="1"></td>
  <td class="row##row_style_index##">##if(subtype != "on-off")##<input class=field name="value_##res_id##" id="value_##res_id##" value="##value##">##endif##&nbsp;</td>
</tr>
"-->


<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'hst_pkgform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
##pictures_js_vars##

function OnObjectChanged_hst_pkg_form(name, first_change){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_hst_pkg_form);

function CheckForm(form) {
   var errmsg = "";

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   return true;
}
//-->
</script>

  ##form_hint##
  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="hst_pkgform" onSubmit="return CheckForm(window.document.hst_pkgform);">
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
        %%setup_fee%%:
       </td>
       <td>
         <input type=text name=setup_fee class="field field15" value="##setup_fee##" maxlength="255">
       </td>
     </tr>

     <tr>
       <td colspan=2>
         <table width="100%" border="0" cellspacing="0" cellpadding="4">
         <tr>
           <td class="first_row_left_td" width=120>%%res_name%%&nbsp;</td>
           <td class="first_row_all" width=160>%%include_resource_in_package%%&nbsp;</td>
           <td class="first_row_all" width=125>%%count%%&nbsp;</td>
         </tr>
          ##resource_rows##
         </table>
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