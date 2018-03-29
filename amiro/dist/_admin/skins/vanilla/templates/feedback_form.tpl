##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/feedback.lng"%%

<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="user_click('none',''); return false;">
"-->

<!--#set var="field_custom_text" value="
     <tr>
       <td width="30%">
         <nobr>##title##:</nobr>
       </td>
       <td width="70%">
         ##value##
       </td>
     </tr>
"-->

<!--#set var="field_custom_checkbox" value="
     <tr>
       <td colspan="2">
         <input type="checkbox" ##value## disabled>&nbsp;##title##
       </td>
     </tr>
"-->

<!--#set var="field_custom_textarea" value="
     <tr>
       <td colspan="2">
         ##title##:<br>
         <textarea name="info" class=field wrap=soft cols="##cols##" rows="##rows##" readonly>##value##</textarea>
       </td>
     </tr>
"-->

<!--#set var="form_item_other" value="
     <tr>
       <td width="30%">
         <nobr>##title##:</nobr>
       </td>
       <td width="70%">
         ##value##
       </td>
     </tr>
"-->

<!--#set var="form_item_email" value="
     <tr>
       <td width="30%">
         <nobr>##title##:</nobr>
       </td>
       <td width="70%">
         <a href="mailto:##value##">##value##</a>
       </td>
     </tr>
"-->

<!--#set var="form_item_web" value="
     <tr>
       <td width="30%">
         <nobr>##title##:</nobr>
       </td>
       <td width="70%">
         <a href="http://##value##" target="_blank">##value##</a>
       </td>
     </tr>
"-->

<!--#set var="form_item_area" value="
     <tr>
       <td colspan="2">
         ##title##:<br>
         <textarea name="info" class=field wrap=soft cols="73" rows="8">##value##</textarea>
       </td>
     </tr>
"-->

<script type="text/javascript">
<!--
var editor_enable = '';
var _cms_document_form = 'fbform';
var _cms_script_link = '##script_link##?';
var _cms_document_form_changed = false;
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {
   return true;
}
//-->
</script>

  <br>
    <form action="##script_link##" method="post" name="fbform" onSubmit="return CheckForm(window.document.fbform);">
    ##filter_hidden_fields##
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">

     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     ##form_items##
     ##ext_modules_custom_fields_top##
     ##if(1==0)##
     %%include_template "templates/ext_modules_custom_fields.tpl"%%
     ##endif##
     ##ext_modules_custom_fields_bottom##
     </table>
    </form>
