%%include_language "templates/lang/srv_login_history.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="form_items" value="
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td>
     %%create_date%%:
     </td>
       <td>
     ##create_date##
     </td>
   </tr>
     <tr>
       <td>
     %%update_date%%:
     </td>
       <td>
     ##update_date##
     </td>
   </tr>
     <tr>
       <td>
     %%quantity%%:
     </td>
       <td>
     ##quantity##
     </td>
   </tr>
     <tr>
       <td>
     %%count_pages%%:
     </td>
       <td>
     ##count_pages##
     </td>
   </tr>
     <tr>
     <td valign="top">
     %%search_query%%:
     </td>
       <td>
         <textarea name="message" class="field" style="width:350px" rows="7" readonly>##query##</textarea>
     </td>
   </tr>
   </table>
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'historyform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';

function OnObjectChanged_srv_login_history_form(elemName, first_change, evt){
  return false;
}
addFormChangedHandler(OnObjectChanged_srv_login_history_form);

-->
</script>

  <form action=##script_link## method=post enctype="multipart/form-data" name="historyform">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
     ##filter_hidden_fields##
   ##form_items##
    </form>

