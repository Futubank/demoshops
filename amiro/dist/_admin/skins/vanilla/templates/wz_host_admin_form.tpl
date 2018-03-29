%%include_language "templates/lang/wz_host_admin.lng"%%
%%include_language "templates/lang/_wz_host_admin_msgs.lng"%%



<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'admform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';

-->
</script>

  <form action=##script_link## method=post enctype="multipart/form-data" name="admform">
     <input type="hidden" name="id" value="1">
     <input type="hidden" name="action" value="##action##">
   <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
   <tr>
     <td>
	<input type="checkbox" name="site_create" value="1" ##create_checked##>
     </td>
     <td>
     %%allow_create_site%%
     </td>
   </tr>
   <tr>
     <td>
    <input type="checkbox" name="site_create_front" value="1" ##create_front_checked##>
     </td>
     <td>
     %%allow_create_front_site%%
     </td>
   </tr>
   <tr>
     <td>
	<input type="checkbox" name="site_update" value="1" ##update_checked##>
     </td>
     <td>
     %%allow_update_site%%
     </td>
   </tr>
   <tr>
     <td>
	<input type="checkbox" name="site_delete" value="1" ##delete_checked##>
     </td>
     <td>
     %%allow_delete_site%%
     </td>
   </tr>
   <tr>
     <td>
	<input type="checkbox" name="site_copy" value="1" ##copy_checked##>
     </td>
     <td>
     %%allow_copy_site%%
     </td>
   </tr>

   <tr><td colspan="2"><hr></td></tr>
   <tr>
     <td align="center" colspan="2">
     <b>%%demo_sites%%</b>
     </td>
   </tr>
   <tr>
     <td>
	<input type="radio" name="demo_status" value="unchanged" checked>
     </td>
     <td>
     %%demo_unchanged%%
     </td>
   </tr>
   <tr>
     <td>
	<input type="radio" name="demo_status" value="lock_all">
     </td>
     <td>
     %%demo_lock_all%%
     </td>
   </tr>
   <tr>
     <td>
	<input type="radio" name="demo_status" value="unlock_all">
     </td>
     <td>
     %%demo_unlock_all%%
     </td>
   </tr>

  <tr>
<td colspan="2" align="right">
	<br>
	<input type="submit" name="apply" value="  %%apply_btn%%  " class="but" ##apply##>
</td>
</table>
</form>
