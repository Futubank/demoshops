%%include_language "templates/lang/sitemap_history.lng"%%

##check_url##

<script type="text/javascript">
<!--
var _cms_document_form = 'smform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function CheckForm(form) {
   var errmsg = "";

   return true;
}
-->
</script>

  <br>
    <form action="##script_link##" method="post" name="smform" onSubmit="return CheckForm(window.document.smform);">
    ##form_common_hidden_fields##
    ##_id_page_field##
    ##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td>%%date%%:</td>
       <td>##fdate##</td>
     </tr>
     <tr>
       <td>%%action%%:</td>
       <td><nobr>%%##sm_action##%%&nbsp;</nobr></td>
     </tr>
     ##if(sitemap_file != '')##
     <tr>
       <td>%%current_sitemap%%:</td>
       <td><b><a href="##sitemap_file_link##" target="_blank">##sitemap_file##&raquo;</a></b></td>
     </tr>
     ##endif##
     ##if(user_login != '')##
     <tr>
       <td>%%act_user%%:</td>
       <td>##user_login##</td>
     </tr>
     ##endif##
     ##if(!daemon_mode)##
     <tr>
       <td>%%ip%%:</td>
       <td>##user_ip##</td>
     </tr>
     ##endif##
     ##if(useragent != '')##
     <tr>
       <td>%%useragent%%:</td>
       <td>##useragent##</td>
     </tr>
     ##endif##
     <tr>
       <td>%%formtime%%:</td>
       <td>##time##</td>
     </tr>
     ##if(sitemap_size != '')##
     <tr>
       <td>%%size%%:</td>
       <td>##sitemap_size##</td>
     </tr>
     ##endif##
     ##if(num_urls != '')##
     <tr>
       <td>%%urls%%:</td>
       <td>##num_urls##</td>
     </tr>
     ##endif##
     <tr>
       <td>%%status%%:</td>
       <td>%%##action_status##%%</td>
     </tr>
     </table>
    </form>
