%%include_language "templates/lang/srv_host_mailmanage.lng"%%
%%include_language "templates/lang/_srv_host_mailmanage_msgs.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->


<!--#set var="row" value="<!--row-->
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td width="75"><nobr>##email##</nobr></td>
  <td width="115">
      ##creation_date##
  </td>
  <td width="70">##alias_type##</td>
  <td width="70"><nobr>##alias##&nbsp;</nobr></td>
 ##if(show_size=="1")##
  <td width="70" align="right">##size##<br>##disk_quota####if(low_quota)##<font color="red"><b> (!!!)</b></font>##endif##</td>
 ##endif##
  <td align=center>##actions##</td>
</tr>
"-->

<!--#set var="list_body" value="<!--list_body-->
           
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_all">
                 %%email%%
                 ##sort_local_part##
                </td>
                <td class="first_row_all" width="75">
                 %%creation_date%%
                 ##sort_cdate_sort##
                </td>
                <td class="first_row_all" width="70">
                 %%mail_alias_type%%
                </td>
                <td class="first_row_all">
                 %%where%%
                </td>
                ##if(show_size=="1")##
                <td class="first_row_all" width="70">
                 %%mbox_size%%
                </td>
                ##endif##
                <td class="first_row_all" width="100" nowrap>
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>

<a name="anchor"></a>

"-->
