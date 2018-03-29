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

function OnObjectChanged_sys_users_form(param1, param2, evt){
##on_change_member_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_sys_users_form);

-->
</script>

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="users_form" onSubmit="return CheckForm(window.document.users_form);">
      ##form_common_hidden_fields##
     <input type="hidden" name="activate" value="">
##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">

##member_form##

   <tr>
     <td>
       %%user_groups%%:
     </td>
     <td>
        <input type="hidden" name="group_ids" value="##group_ids##">
        <a href="javascript:void(0);" onClick="openExtDialog('%%groups_add_list%%', 'sys_groups_popup.php?userId=##id##&group_ids='+document.users_form.group_ids.value); return false;"><img title="%%groups_add_list%%" class=icon src="skins/vanilla/icons/icon-groups.gif" helpId="btn_groups_add" align=absmiddle></a>
        <font style="font-size:9px">[%%number_groups%%:<input name="num_groups" type="text" value="##groups##" readonly style="width: 20px;text-align: right; background-color: #FFFFFF;font-size:11px; BORDER: #FFFFFF 0px solid; ">]</font>
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