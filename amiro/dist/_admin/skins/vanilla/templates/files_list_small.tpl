%%include_language "templates/lang/files.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td width="60" align="center">
  ##--&nbsp;<a target="_blank" href="##view_link##">##ficon##</a>--##
  <a href="javascript:void(0);" onclick="set_url('1', '##view_link##', '##j_fname##')">##ficon##</a>
  </td>
  <td>##fname##&nbsp;</td>
  <td>##fdescription##&nbsp;</td>
  <td width="60" align="center">##fsize## %%kbytes%%</td>
  <td width="120" align="right"><nobr>##fcdate##</nobr><br><nobr>##fmdate##</nobr></td>
</tr>
"-->
           <div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_all" width="60">
                 %%ftype%%
                </td>
                <td class="first_row_all">
                 %%fname%% 
                </td>
                <td class="first_row_all">
                 %%description%%
                </td>
                <td class="first_row_all">
                 %%fsize%% 
                </td>
                <td class="first_row_all" width="120">
                 %%fcdate%%<br>%%fmdate%%
                </td>
              </tr>
              ##files_list##
            </table>
           <div align="right" width="100%">##pager##</div>

