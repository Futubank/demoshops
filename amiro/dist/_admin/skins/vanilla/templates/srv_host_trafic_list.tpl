%%include_language "templates/lang/srv_host_trafic.lng"%%
%%include_template "templates/_icons.tpl"%%


<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td>##username##</td>
##if(BUILDER_VERSION == 1)##
  <td>##domain##</td>
##endif##
  <td>##ftp_total##</td>
  <td>##http_total##</td>
  <td>##mail_total##</td>
  <td>##total##</td>
  <td>##traf_quota##</td>
  <td width="40" align=center>##actions##</td>
</tr>
"-->

<!--#set var="list_body" value="
           
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_all" width="115">
                 ##sort_username##
                 %%username%%
                </td>
##if(BUILDER_VERSION == 1)##
                <td class="first_row_all">
                 ##sort_domain##
                 %%domain%%
                </td>
##endif##
                <td class="first_row_all">
                 ##sort_ftp_total##
                 FTP
                </td>
                <td class="first_row_all">
                 ##sort_http_total##
                 HTTP
                </td>
                <td class="first_row_all">
                 ##sort_mail_total##
                 Email
                </td>
                <td class="first_row_all">
                 ##sort_total##
                 %%total%%
                </td>
                <td class="first_row_all">
                 %%quota%%
                </td>
                <td class="first_row_all" width="40" nowrap>
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
           
##button_add##
<div align="right" width="100%">##pager##</div>

<a name="anchor"></a>

"-->
