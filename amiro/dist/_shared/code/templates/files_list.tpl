##--!ver=0200 rules="-SETVAR"--##
%%include_language "_shared/code/templates/lang/news.lng"%%
%%include_template "_shared/code/templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
  <td width="30" align=center>##public##</td>
  <td width="60">##fdate##&nbsp;</td>
  <td width="140"><nobr>##header##&nbsp;<nobr></td>
  <td>##announce##&nbsp;</td>

##if(EXTENSION_AUDIT=="1")##
    <td align="center">
      ##audit_status##
    </td>
    <td align="center">
      ##audit_comments##&nbsp;
    </td>
##endif##

##if(EXTENSION_FORUM=="1")##
  <td align="center">
    ##replies##
  </td>
##endif##

##if(EXTENSION_RATING=="1")##
    <td align="center">
      ##votes_count##
  </td>
    <td align="center">
      ##votes_rate##
  </td>
##endif##


  <td width="40" align=center>##action_edit####action_del####--actions--##</td>
</tr>
"-->

<!--#set var="list_body" value="
        <div align="right" width="100%">##pager##</div>
            <table width="100%" border="0" class=tbl cellspacing="0" cellpadding="4">
              <tr>
                <th class="first_row_all" align="center" valign="middle" width="30">
                 &nbsp;
                </th>
                <th class="first_row_all" width="60">
                 %%date%%
                </th>
                <th class="first_row_all">
                 %%header%%
                </th>
                <th class="first_row_all">
                 %%announce%%
                </th>
##if(EXTENSION_AUDIT=="1")##
                <th class="first_row_all" width="100">
                %%audit_status%%
                </th>
                <th class="first_row_all" width="150">
                %%audit_comments%%
                </th>
##endif##

##if(EXTENSION_FORUM=="1")##
                <th class="first_row_all" width="30">
                %%forum_replies%%
                </th>
##endif##

##if(EXTENSION_RATING=="1")##
                <th class="first_row_all" width="30">
                %%votes_count%%
                </th>
                <th class="first_row_all" width="30">
                %%votes_rate%%
                </th>
##endif##

                <th class="first_row_all" align="center" width="40">
                 %%actions%%
                </th>
              </tr>
              ##list##
            </table>
           <div align="right" width="100%">##1pager##</div>
##if(legend != "")##
<table cellspacing=0 cellpadding=5 border=0>
<tr><td valign="top">
<b>%%legend%%:</b>
</td>
<td valign="top" align="left" width=100%>
##legend##
</td>
</tr></table>
##endif##
<a name="anchor"></a>
"-->
