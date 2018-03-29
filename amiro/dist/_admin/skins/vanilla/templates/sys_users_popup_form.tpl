%%include_language "templates/lang/sys_users.lng"%%

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'users_form';
var _cms_script_link = '##script_link##?';

##header_memeber_script##

function CheckForm(form) {
   var errmsg = "";

##check_member_script##

   return true;
}

function OnObjectChanged_sys_users_popup_form(param1, param1, evt){

##on_change_member_script##

  return true;
}
addFormChangedHandler(OnObjectChanged_sys_users_popup_form);

-->
</script>

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="users_form" onSubmit="return CheckForm(window.document.users_form);">
    ##form_common_hidden_fields##
     <input type="hidden" name="activate" value="">
     <input type="hidden" name="groupId" value="##group_id##">
     <input type="hidden" name="user_ids" value="##user_ids##">
##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">

##member_form##

     <tr>
        <td colspan="2"><br><input type=checkbox name=add_to_list value="1" ##add_to_list##>&nbsp;%%add_to_list%%</td>
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