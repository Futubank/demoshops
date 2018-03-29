##--!ver=0200 rules="-SETVAR"--##
%%include_language "_shared/code/templates/lang/eshop_item.lng"%%
%%include_template "_shared/code/templates/_icons.tpl"%%

<!--#set var="calc_price;calc_other_price" value="
[##calc_price##]&nbsp;
"-->

<!--#set var="other_price" value="<nobr>##calc_price####price##</nobr><br>"-->

<!--#set var="other_prices_col" value="
  <td align="right">##prices##</td>
"-->

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
##if(PARENT_COL=="1")##
  <td width="150" id="prod_cat_##row_index##">##category##</td>
##endif##
  <td width="140"><nobr>##name##&nbsp;<nobr></td>
  <td>##announce##&nbsp;</td>
  <td align="right"><nobr>##calc_price##<b>##price##</b></nobr>&nbsp;</td>
  ##other_prices_col##

##if(EXTENSION_AUDIT=="1")##
  <td align="center">
    ##audit_status##
  </td>
    <td align="center">
      ##audit_comments##&nbsp;
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
##if(PARENT_COL=="1")##
                <th class="first_row_all" valign="middle" width="150">
                 %%category%%
                </th>
##endif##
                <th class="first_row_all">
                 %%name%%
                </th>
                <th class="first_row_all" width="*">
                 %%announce%%
                </th>
                <th class="first_row_all">
                 %%price%%
                </th>
##if(OTHER_PRICES=="1")##
                <th class="first_row_all">
                 %%other_prices%%
                </th>
##endif##
##if(EXTENSION_AUDIT=="1")##
                <th class="first_row_all" width="100">
                %%audit_status%%
                </th>
                <th class="first_row_all" width="150">
                %%audit_comments%%
                </th>
##endif##
                <th class="first_row_all" align="center" width="40">
                 %%actions%%
                </th>
              </tr>
              ##list##
            </table>
           <div align="right" width="100%">##1pager##</div>

<table cellspacing=0 cellpadding=5 border=0>
<tr><td valign="top">
<b>%%legend%%:</b>
<td valign="top" align="left" width=100%>
##legend##
</td>
</tr></table>
<a name="anchor"></a>
"-->
