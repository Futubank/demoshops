%%include_language "templates/lang/srv_multi_sites.lng"%%

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'sites_form';
var _cms_script_link = '##script_link##?';

function CheckForm(form) {
   var errmsg = "";

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   if (form.url.value=="") {
       return focusedAlert(form.url, '%%url_warn%%');
   }

   return true;
}
-->
</script>

<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
"-->

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="sites_form" onSubmit="return CheckForm(window.document.sites_form);">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">

     <tr>
       <td>%%name%%*:</td>
       <td>
         <input type=text name=name class="field field50" value="##name##" maxlength="64">
       </td>
     </tr>
     <tr>
       <td>%%url%%*:</td>
       <td>
         http://&nbsp;<input type=text name=url class="field field50" value="##url##" maxlength="255">
       </td>
     </tr>
     <tr>
        <td colspan="2" align="right">
        <br>
        <input type="submit" name="add" value="  %%add_btn%%  " class="but" ##add##>
        <input type="submit" name="apply" value="  %%apply_btn%%  " class="but" ##apply##>
        ##cancel##
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

