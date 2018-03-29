%%include_language "templates/lang/srv_host_trafic.lng"%%
%%include_language "templates/lang/_srv_host_trafic_msgs.lng"%%
%%include_template "templates/_icons.tpl"%%



<!--#set var="traf_details" value="
##if(BUILDER_VERSION > 1)##
  <br>%%domain%%: ##domain##<br><br>
##endif##
  <table border=0 cellspacing=0 cellpadding=0>
  <tr>
    <td class="first_row_all">%%month%%</td>
    <td class="first_row_all">FTP %%in%%</td>
    <td class="first_row_all">FTP %%out%%</td>
    <td class="first_row_all">HTTP %%in%%</td>
    <td class="first_row_all">HTTP %%out%%</td>
    <td class="first_row_all">Email %%in%%</td>
    <td class="first_row_all">Email %%out%%</td>
    <td class="first_row_all">%%month_total%% %%in%%</td>
    <td class="first_row_all">%%month_total%% %%out%%</td>
    <td class="first_row_all">%%month_total%%</td>
  </tr>
  ##details_list##
  ##traf_totals##
  </table>
"-->

<!--#set var="over_limit" value="<span style="color:red">##value##</span>"-->

<!--#set var="traf_details_row" value="
    <tr class="##style##">
      <td>##month##&nbsp;</td>
      <td>##ftp_in##&nbsp;</td>
      <td>##ftp_out##&nbsp;</td>
      <td>##http_in##&nbsp;</td>
      <td>##http_out##&nbsp;</td>
      <td>##mail_in##&nbsp;</td>
      <td>##mail_out##&nbsp;</td>
      <td>##total_m_in##&nbsp;</td>
      <td>##total_m_out##&nbsp;</td>
      <td>##total_m##&nbsp;</td>
    </tr>
"-->

<!--#set var="traf_totals" value="
    <tr>
      <td class="last_row_all">%%total%%&nbsp;</td>
      <td class="last_row_all">##ftp_in##&nbsp;</td>
      <td class="last_row_all">##ftp_out##&nbsp;</td>
      <td class="last_row_all">##http_in##&nbsp;</td>
      <td class="last_row_all">##http_out##&nbsp;</td>
      <td class="last_row_all">##mail_in##&nbsp;</td>
      <td class="last_row_all">##mail_out##&nbsp;</td>
      <td class="last_row_all">##total_in##&nbsp;</td>
      <td class="last_row_all">##total_out##&nbsp;</td>
      <td class="last_row_all">##total##&nbsp;</td>
    </tr>
"-->


<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'trafform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';

-->
</script>

  <form action=##script_link## method=post enctype="multipart/form-data" name="trafform"">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="type">
     <input type="hidden" name="action" value="##action##">
     ##filter_hidden_fields##
  <div align="center"><b>%%srv_host_trafic_view%%</b></div>
   <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
##if(BUILDER_VERSION == 1)##
   <tr>
     <td>
     %%username%%:
     </td>
     <td>
       ##username##
     </td>
   </tr><tr>
     <td>
     %%domain%%:
     </td>
     <td>
       ##domain##
     </td>
   </tr>
##endif##
   <tr>
     <td>
     %%quota%%:
     </td>
     <td>
       ##quota##
     </td>
   </tr><tr>
     <td>
     %%total%%:
     </td>
     <td>
       ##total##
     </td>
   </tr>
   </table>
   <br>
     ##traf_details##
   <br><br>
   %%last_update%%: <b>##last_update##</b>
    </form>
