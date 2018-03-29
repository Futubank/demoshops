%%include_language "templates/lang/iplist.lng"%%

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'prt_form';
var _cms_script_link = '##script_link##?';

function CheckIP(field, str) {
  if(!field.value.match(/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/)) {
    return focusedAlert(field, str);
  }

  return true;
}

function CheckForm(form) {
   var errmsg = "";

   if (!CheckIP(form.start, '%%invalid_ip%%')) return false;
   if (!CheckIP(form.end, '%%invalid_ip%%')) return false;
   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   return true;
}
-->
</script>

<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
"-->

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="prt_form" onSubmit="return CheckForm(window.document.prt_form);">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">

     <tr>
       <td>%%ip_start%%*:</td>
       <td>
         <input type=text name=start class="field field50" value="##start##" >
       </td>
     </tr>
     <tr>
       <td>%%ip_end%%*:</td>
       <td>
         <input type=text name=end class="field field50" value="##end##" >
       </td>
     </tr>
     <tr>
       <td>%%name%%*:</td>
       <td>
         <input type=text name=name class="field field50" value="##name##" maxlength="255">
       </td>
     </tr>
     <tr>
       <td>%%visible_area%%:</td>
       <td>
         <select name=visible_area>
           <option value="local" ##area_local##>%%area_local%%</option>
           <option value="public" ##area_public##>%%area_public%%</option>
         </select>
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

