%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/google_sitemap.lng"%%

<!--#set var="sitemap_history" value="
  <table border=0 cellspacing=0 cellpadding=0 width="100%">
  <tr>
    <td class="first_row_left_td">%%date%%</td>
    <td class="first_row_all">%%sm_action%%</td>
    <td class="first_row_all">%%sm_time%%</td>
    <td class="first_row_all">%%sm_status%%</td>
  </tr>
  ##sitemap_history_list##
  </table>
"-->

<!--#set var="action_row" value="
    <tr>
      <td class="##style##">##action_date##&nbsp;</td>
      <td class="##style##">%%##sm_action##%%&nbsp;##sm_additional##</td>
      <td class="##style##">##action_time##&nbsp;</td>
      <td class="##style##">%%##action_status##%%&nbsp;</td>
    </tr>
"-->

<!--#set var="progress_popup_header" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% %%page_title%%</TITLE>
<link rel="stylesheet" href="##admin_root####skin_path##_css/style.css" type="text/css">
<script src="jsapi.php" type="text/javascript"></script>
<script type="text/javascript" src="##admin_root####skin_path##_js/ami.jquery.js"></script>
<script type="text/javascript" src="##admin_root####skin_path##_js/ami.admin.js"></script>

</HEAD>
<BODY id=bdy leftmargin="20" topmargin="0" bgcolor="#FFFFFF">
<div id="progressBar" style="display: none;">
<center>
<br>
%%gen_sitemap%%
<br>
<table border=0 cellspacing=0 cellpadding=0>
<tr><td width=400 style="border: 1px blue solid;">
<div id="percent" align="center" style="width: 0%; color: #FFFFFF; background-color: blue"></div>
</td>
</tr>
</table>
</center>
</div>
<script type="text/javascript">
var elPercent = document.getElementById("percent");
var elProgressBar = document.getElementById("progressBar");
</script>

<script>
    var currentPercent = 0;
    
    function setProgressData(receivedData){
        stopProgressDownloader();
        
        var intPercent = parseInt(receivedData);
        if(currentPercent < intPercent){
            currentPercent = intPercent;
            elPercent.style.width = currentPercent + '%';
            elPercent.innerHTML = currentPercent + '%';
            elProgressBar.style.display = "inline";
        }
        
        if(currentPercent < 100){
            startProgressDownloader('##progress_id##');
        }
    }
    
    startProgressDownloader('##progress_id##');
</script>
"-->

<!--#set var="progress_popup_iterator" value="
<script type="text/javascript">
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

setProgressData('##percent##');
</script>
"-->

<!--#set var="progress_popup_footer" value="
<br>
##status##
<br><br>
<form name="progressForm">
<center>
<input type="button" name="close" value="  %%close_btn%%  " class="but-mid" OnClick="closeDialogWindow();">
</center>
</form>
</BODY>
</HTML>
"-->

<script type="text/javascript">
<!--

var editor_enable = '##editor_enable##';
var _cms_document_form = 'txfrm';
var _cms_script_link = '##script_link##?';

-->
</script>

<br>
<br>
    <form name="txfrm" method="post">
    <input type="hidden" name="action" value="send_sitemap">
     <table cellspacing="0" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     ##if(search_not_installed == "1")##
     <tr>
      <td colspan="2">%%att_search_install%%<br/><br/></td>
     </tr>
     ##else##
     ##if(sitemaps_is_turned_off)##
     <tr>
      <td colspan="2"><b>%%sitemaps_is_turned_off%%</b><br/><br/></td>
     </tr>
     ##endif##
     <tr>
      <td colspan="2">%%sitemap_info%%<br/><br/></td>
     </tr>
     <tr>
       <td>%%last_gen_sitemap%%:</td>
       <td>&nbsp; ##if(last_gen_sitemap == "")##%%sitemap_not_created%%##else####last_gen_sitemap####endif##</td>
     </tr>
     ##if(last_gen_sitemap == "")##
     ##else##
     <tr>
       <td>%%sitemap_link%%:</td>
       <td>&nbsp; <b><a href="##sitemap_link##" target="_blank">##sitemap_index_file##&raquo;</a></b></td>
     </tr>
     ##endif##
     ##gen_sitemap##
     <tr>
       <td colspan="2" align="right">
         <br/><br/>
         <input type="button" name="gen_sitemap" ##gen_sitemap_status## value="%%gen_sitemap_btn%%" class="but-mid" OnClick="javascript:openExtDialog('%%gen_sitemap%%', '##script_link##?action=gen_sitemap', 0, 0, 550, 330, -1, -1, 0, 1, function(){document.location.reload()});">
         <br/>
       </td>
     </tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2"><hr></td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr>
       <td colspan="2">%%att_google_send%%<br/><br/></td>
     </tr>
     <tr>
       <td>%%last_send_date%%:</td>
       <td>&nbsp; ##if(last_send_sitemap == "")##%%sitemap_not_sent%%##else####last_send_sitemap####endif##</td>
     </tr>
     ##if(last_send_sitemap == "")##
     ##else##
     <tr>
       <td>%%last_send_status%%:</td>
       <td>&nbsp; ##if(last_send_status == "ok")##%%last_send_status_ok%%##else##%%last_send_status_failed%%##endif##</td>
     </tr>
     ##endif##
     ##gen_sitemap##
     <tr>
       <td colspan="2" align="right">
         <br/><br/>
         <input type="submit" name="send_sitemap" ##send_sitemap_status## value="%%send_sitemap_btn%%" class="but-long">
         <br/>
       </td>
     </tr>
     ##endif##
     </table>
    </form>

