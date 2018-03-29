%%include_language "templates/lang/hst_resellers.lng"%%

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

<!--#set var="reseller_option" value="
        <option value="##id##">##name##</option>"-->

<!--#set var="del_popup_form" value="
<form name="delForm" action="##script_link##" enctype="multipart/form-data" method="POST">
<table cellspacing="0" cellpadding="10" align="center" width=100%>
  <tr>
   <td align="center">
    <table cellspacing="0" cellpadding="0" align="center">
     <tr>
      <td><input type="radio" name="type" value="del" id="type_del" checked />&nbsp;<label for="type_del">%%del_with_items%%</label></td>
     </tr>
     <tr>
      <td><input type="radio" name="type" value="move" id="type_leave" checked />&nbsp;<label for="type_leave">%%move_clients%%</label>
         <div align="right">
         <select name="id_new_reseller">
         <option value="0">%%select_reseller%%</option>##resellers_options##
         </div>
      </td>
     </tr>
    </table>
   </td>
  </tr>
  <tr>
    <td align="center">
        <input type="hidden" name="action" value="delete_confirm">
        <input type="button" name="add" value="  %%ok_btn%%  " class="but" onClick="return onBtnOk();">&nbsp;
        <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="javascript:top.close();">
    </td>
   </tr>
</table>
"-->


<!--#set var="del_popup" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>%%site_title%% - %%hst_reseller_delete_form%%</TITLE>
<link rel="stylesheet" href="_css/style.css" type="text/css">
<script type="text/javascript">
<!--
function onBtnOk() {

  for(var i=0;i<document.delForm.type.length;i++) {
    if(document.delForm.type[i].checked) {
      if(document.delForm.type[i].value == "move") {
        if(document.delForm.id_new_reseller.value == "0") {
            alert("%%select_reseller%%!");
            document.delForm.id_new_reseller.focus();
            return false;
        }
        top.opener.document.reseller_form.id_new_reseller.value = document.delForm.id_new_reseller.value;
      }
      top.opener.document.reseller_form.type.value = document.delForm.type[i].value;
      break;
    }
  }
  //alert(top.opener.document.reseller_form.id_new_reseller.value + ", " +top.opener.document.reseller_form.type.value);
  //return false;

  top.opener.user_click('del_confirm','##id##');
  top.close();
  return true;
}
-->
</script>

</HEAD>
<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">
<center>
<br>
##form##
</center>
</BODY>
</HTML>
"-->


<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'reseller_form';
var _cms_script_link = '##script_link##?';

##header_memeber_script##

function CheckForm(cform) {
   var errmsg = "";

##check_member_script##

   return true;
}

function OnObjectChanged_eshop_user_form_def(){
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

  ##form_hint##
  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="reseller_form" onSubmit="return CheckForm(window.document.reseller_form);">
     ##form_common_hidden_fields##
     <input type="hidden" name="activate" value="">
     <input type="hidden" name="type" value="">
     <input type="hidden" name="id_new_reseller" value="">
##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
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