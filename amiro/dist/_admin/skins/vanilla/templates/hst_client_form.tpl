%%include_language "templates/lang/hst_clients.lng"%%

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
var _cms_document_form = 'client_form';
var _cms_script_link = '##script_link##?';

##header_memeber_script##

function CheckForm(cform) {
   var errmsg = "";

##check_member_script##

   return true;
}

function OnObjectChanged_eshop_user_form_def(){

##if(HAVE_CLIENTS=="1")##
  if(event.srcElement.name == "is_reseller") {
    event.srcElement.checked = true;
    alert('%%have_clients_alert%%');
  }
##endif##

##on_change_member_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_eshop_user_form_def);

-->
</script>

<!--#set var="history_row" value="
    <tr>
      <td class="##style##">##_date##&nbsp;</td>
      <td class="##style##" align=right><nobr>##balance##</nobr></td>
      <td class="##style##">##changed_by##&nbsp;</td>
      <td class="##style##">##ip##&nbsp;</td>
    </tr>
"-->

<!--#set var="history_list" value="
     <tr>
       <td colspan=2>%%balance_history%%:
          <table border=0 cellspacing=0 cellpadding=0>
          <tr>
            <td class="first_row_left_td" width=130>%%date%%</td>
            <td class="first_row_all" width=80>%%balance%%</td>
            <td class="first_row_all" width=100>%%changed_by%%</td>
            <td class="first_row_all" width=100>%%ip%%</td>
          </tr>
          ##list##
          </table>
       </td>
"-->

<!--#set var="history_list_empty" value="
"-->

<!--#set var="reseller_option" value="<option value="##id_member##"##if(selected)## selected##endif##>##name##</option>
            "-->

  ##form_hint##
  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="client_form" onSubmit="return CheckForm(window.document.client_form);">
     ##form_common_hidden_fields##
     <input type="hidden" name="activate" value="">
##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
##IF(IS_ADMIN=="1")##
     <tr>
        <td>
            %%reseller%%:
        </td>
        <td>
            <select name="reseller">
            <option value=''>%%select_reseller%%</option>
            ##resellers_options##
            </select>
        </td>
     </tr>
     <tr>
        <td>
            %%is_reseller%%:
        </td>
        <td>
            <input name="is_reseller" type="checkbox"##if(is_reseller)## checked##endif####if(HAVE_CLIENTS=="1")##  readonly##endif##>
        </td>
     </tr>
##ENDIF ##
##member_form##
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