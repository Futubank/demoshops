##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/srv_audit.lng"%%

<!--#set var="history_row" value="
    <tr>
      <td class="##style##">##_date##&nbsp;</td>
      <td class="##style##">##status##&nbsp;</td>
      <td class="##style##">##owner##&nbsp;</td>
      <td class="##style##">##changed_by##, ##firstname## ##lastname## (##username##)</td>
      <td class="##style##">##ip##&nbsp;</td>
      <td class="##style##"><span title="##comments##">##comments_short##</span>&nbsp;</td>
    </tr>
"-->

<!--#set var="history_list" value="
     <tr>
       <td colspan=2>%%changes_history%%:
          <table border=0 cellspacing=0 cellpadding=0>
          <tr>
            <td class="first_row_left_td" width=130>%%date%%</td>
            <td class="first_row_all" width=80>%%status%%</td>
            <td class="first_row_all" width=80>%%username%%</td>
            <td class="first_row_all" width=200>%%changed_by%%</td>
            <td class="first_row_all" width=80>%%ip%%</td>
            <td class="first_row_all" width=130>%%comments%%</td>
          </tr>
          ##list##
          </table>
       </td>
     </tr>
##if(show_full_history=="1")##
     <tr>
       <td colspan=2>
         <a href="#" onClick="openDialog('%%audit_popup_title%%', 'srv_audit_popup.php?item_id=##item_id##&module_name=##module_name##', ''); return false;" title="%%srv_audit_popup_open%%">%%full_history%% (##history_length## %%records%%)</a>
       </td>
     </tr>
##endif##
"-->

<!--#set var="history_list_empty" value="
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'srv_audit_form';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function OnObjectChanged_srv_audit_form(name, first_change, evt){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_srv_audit_form);

function CheckForm(form) {
   var errmsg = "";
   return true;
}
-->
</script>


  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="srv_audit_form" onSubmit="return CheckForm(window.document.srv_auditform);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
     <tr>
       <td width="200">
%%date_last%%:
</td>
       <td>
         ##fdate##
       </td>
     </tr>
     <tr>
       <td>
%%id_item%%:
</td>
       <td>
    ##if(module_link!="")##
      <b><a href="##module_link##?action=locate&id=##id_item###anchor">##id_item##</a></b>
    ##else##
      ##id_item##
    ##endif##
       </td>
     </tr>
     <tr>
       <td>
%%item_name%%:
</td>
       <td>
    ##if(module_link!="")##
      <b><a href="##module_link##?action=locate&id=##id_item###anchor">##item_name##</a></b>
    ##else##
      ##item_name##
    ##endif##
       </td>
     </tr>
     <tr>
       <td>
%%module_name%%:
</td>
       <td>
         ##module_header##
       </td>
     </tr>
     <tr>
       <td>
%%original_status%%:
</td>
       <td>
         ##original_status##
       </td>
     </tr>
     <tr>
       <td>
%%audit_status%%:
</td>
       <td>
         ##audit_status##
       </td>
     </tr>
     <tr>
       <td>
%%owner_name%%:
</td>
       <td>
         ##firstname## ##lastname##
       </td>
     </tr>

##changes_history##

     <tr>
        <td colspan="2" align="right">
        <br>
        ##form_buttons##
        <br><br>
        </td>
     </tr>
     </table>

    </form>
