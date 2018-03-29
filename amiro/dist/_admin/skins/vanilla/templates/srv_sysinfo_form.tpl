&nbsp;%%include_language "templates/lang/srv_sysinfo.lng"%%



<!--#set var="admin_summary" value="<!-- admin_summary -->
   <tr>
     <td nowrap>%%num_domain_active%%:</td>
       <td align="right">##num_domain_active##</td>
   </tr>
   <tr>
     <td nowrap>%%num_domain_suspend%%:</td>
       <td align="right">##num_domain_suspend##</td>
   </tr>
   <tr>
     <td nowrap>
     %%num_ftpusers%%:
     </td>
       <td align="right">
     ##num_ftpusers##
     </td>
   </tr>
   <tr>
     <td nowrap>
     %%min_reg_date%%:
     </td>
       <td align="right">
     ##min_reg_date##
     </td>
   </tr>
   <tr>
     <td nowrap>
     %%max_reg_date%%:
     </td>
       <td align="right">
     ##max_reg_date##
     </td>
   </tr>
##login_summary##
   <tr>
     <td nowrap>%%disk_free_space%%:</td>
       <td align="right">##disk_free_space##</td>
   </tr>
   <tr>
     <td colspan="2"><hr></td>
   </tr>
"-->

<!--#set var="domain_info" value="<!-- domain_info -->
   <tr>
     <td nowrap>
     %%domain%%:
     </td>
       <td align="right">
     ##domain##
     </td>
   </tr>
   <tr>
     <td nowrap>
     %%alias_domain%%:
     </td>
       <td align="right">
##if(alias_domain=="")##
		%%no_alias%%
##elseif(alias_domain=="_add_")##
	<a href="##add_alias_href##">%%create_alias%% &raquo;</a>
##else##
	 ##alias_domain##
##endif##
     </td>
   </tr>
##endif##
##if(SHARED_MODE=="1")##
   <tr>
     <td nowrap>
     %%date_registered%%:
     </td>
       <td align="right">
     ##date_registered##
     </td>
   </tr>
##if(licence_expires=="1")##
   <tr>
     <td nowrap>
     %%licence_expire_date%%:
     </td>
       <td align="right">
     ##licence_expire_date##
     </td>
   </tr>
##endif##
##endif##
##login_info##
   <tr>
     <td colspan="2"><hr>
     </td>
   </tr>
"-->

<!--#set var="login_info" value="<!-- login_info -->
   <tr>
     <td nowrap>
       %%login_info%%:
     </td>
     <td align="right">
       <a href="##login_link##">##logins_success##/##logins_fail## &raquo;</a>
     </td>
   </tr>
"-->


<!--#set var="form_items" value="
   <table cellspacing="5" cellpadding="0" border="0" class="frm srv_sysinfo_form_table">
	<col width="150">
	<col width="*">
   ##admin_summary##
   ##domain_info##
##if(SINGLE_MODE)##
##endif##
##if(SHARED_MODE)##
   <tr>
     <td nowrap>
     %%disk_quota%%:
     </td>
       <td align="right">
     ##disk_quota## %%megabyte%%
     </td>
   </tr>
   <tr>
     <td nowrap>
     %%disk_space%%:
     </td>
       <td align="right">
     ##disk_space##
     </td>
   </tr>
   <tr>
     <td nowrap>
     %%db_size%%:
     </td>
       <td align="right">
     ##db_size##
     </td>
   </tr>
   <tr><td nowrap>%%email_quota%%:</td>
       <td align="right">##email_quota##</td>
     <td></td>
   </tr>
   <tr><td nowrap>%%email_space_used%%:</td>
       <td align="right">##email_space_used##</td>
   </tr>
   <tr><td nowrap>%%ftp_enabled%%:</td>
       <td align="right">##ftp_enabled##</td>
   </tr>
##if(days)##
   <tr><td nowrap>%%index_status%%:</td>
       <td align="right">
       ##index_enabled##
       </td>
   </tr>
##if(index_can_not_be_enabled)##
   <tr><td nowrap><font color="red"><b>%%index_enable_later%%:</b></font></td>
       <td align="right">
       <font color="red"><b>##index_enable_date##</b></font>
       </td>
   </tr>
##endif##
##if(index_can_be_enabled)##
   <tr>
       <td colSpan="2" align="right"><b><a href="?enable_index=1"><font color="red"><b>%%index_enable%% &raquo;</b></font></a></b></td>
   </tr>
##endif##
##endif##
   <tr><td colSpan="3"><hr /></td></tr>
##endif##  ##-- SHARED_MODE --##

   <tr><td colSpan="3"><div style="text-align:center;font-weight:bold">%%sys_user_info%%</div></td></tr>
   <tr>
       <td nowrap>%%username%%:</td>
       <td align="right">##username##</td>
   </tr>
   <tr>
       <td nowrap>%%name%%:</td>
       <td align="right">##firstname## ##lastname##</td>
   </tr>
   <tr>
       <td nowrap>%%email%%:</td>
       <td align="right">##email##</td>
   </tr>
   <tr>
       <td colSpan="2" align="right"><b><a href="members.php?id=##id_sys_user##&action=edit">%%edit_sys_user%% &raquo;</a></b></td>
   </tr>
   <tr><td colSpan="3"><hr /></td></tr>
   <tr>
       <td colSpan="2"><b><a href="srv_options.php">%%srv_options%% &raquo;</a></b></td>
   </tr>
      <tr>
       <td colSpan="2"><b><a href="choose_lang.php">%%srv_chooselang%% &raquo;</a></b></td>
   </tr>
   </tr>
      <tr>
       <td colSpan="2"><b><a href="pay_drivers.php">%%pay_drivers%% &raquo;</a></b></td>
   </tr>
   </tr>
      <tr>
       <td colSpan="2"><b><a href="locales.php">%%locales%% &raquo;</a></b></td>
   </tr>
   </tr>
      <tr>
       <td colSpan="2"><b><a href="engine.php?mod_id=ami_webservice">%%webservice%% &raquo;</a></b></td>
   </tr>
   </tr>
      <tr>
       <td colSpan="2"><b><a href="engine.php?mod_id=ami_service">%%ami_service%% &raquo;</a></b></td>
   </tr>
   </table>
"-->

<!--#set var="no_details" value="%%no_details%%"-->

<script language="javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'sysinfoform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
-->
</script>

  <form action=##script_link## method=post enctype="multipart/form-data" name="sysinfoform">
     <input type="hidden" name="action" value="##action##">
     ##filter_hidden_fields##
    </form>
   ##form_items##
