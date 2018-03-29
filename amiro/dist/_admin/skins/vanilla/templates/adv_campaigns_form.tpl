%%include_language "templates/lang/adv_campaigns.lng"%%

<!--#set var="select_option" value="<option value="##value##" ##selected##>##name##</option>"-->

<!--#set var="audit_select_status" value="
    if(form.audit_status.value=='approve') {
        form.cmpg_status.options[2].selected = true;
    }
    if(form.audit_status.value=='reject') {
        form.cmpg_status.options[1].selected = true;
    }
"-->

<script type="text/javascript">
<!--
var _cms_document_form = 'advcampaignsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
var editor_enable = '0';

function CheckForm(form) {
   var errmsg = "";

   ##audit_check_form##

   if (form.name.value == "") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   return true;
}
-->
</script>


  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="advcampaignsform" onSubmit="return CheckForm(this);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <input type="hidden" name="publish" value="">
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
     <tr>
       <td>
         <input type="checkbox" name="public" ##public## value="1" helpId= "form_public">
         %%public%%
       </td>
       <td align=right></td>
     </tr>
     ##_id_page_field##
     <tr>
       <td>
         %%cmpg_status%%:
       </td>
       <td>
         <select name=cmpg_status>
            <option value="pending" ##if(status == "pending")##selected##endif##>%%cmpg_status_pending%%</option>
            <option value="refused" ##if(status == "refused")##selected##endif##>%%cmpg_status_refused%%</option>
            <option value="active" ##if(status == "active")##selected##endif##>%%cmpg_status_active%%</option>
            <option value="finished" ##if(status == "finished")##selected##endif##>%%cmpg_status_finished%%</option>
         </select>
       </td>
     </tr>
     <tr>
       <td width=150>
         %%name%%*:
       </td>
       <td>
         <input type=text name=name class="field field50" value="##name##" >
       </td>
     </tr>
     <tr>
       <td>%%start_date%%:</td>
       <td>
         <input type=text name=start_date class='field fieldDate' value="##start_date##" maxlength="30">
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.advcampaignsform.start_date);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
       </td>
     </tr>
     <tr vAlign="top">
       <td>%%end_date%%:</td>
       <td>
         <input type=text name=end_date class='field fieldDate' value="##end_date##" maxlength="30">
         <a href="javascript: void(0);" onclick="return getCalendar(event, document.advcampaignsform.end_date);">
         <img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
	     <div class=tooltip style="width:300px;" id="realFieldsDesc">%%end_date_note%%</div>
       </td>
     </tr>
     <tr>
       <td>
         %%campaign_type%%:
       </td>
       <td>
         <select name=type>
            ##campaign_types##
         </select>
       </td>
     </tr>
     <tr>
       <td>
         %%advertiser%%:
       </td>
       <td>
         <select name=advertiser>
            ##advertisers##
         </select>
       </td>
     </tr>
     
##if(EXT_AUDIT=="1")##
     <tr>
       <td colspan=2>
         <hr>
         %%tab_audit%%:<br>
         ##audit_form##
         <script language=javascript>
            if(document.getElementById('div_audit'))document.getElementById('div_audit').style.display='block';
            if(document.getElementById('table_audit'))document.getElementById('table_audit').style.border = '0px';
         </script>
       </td>
     </tr>
##endif##
     
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