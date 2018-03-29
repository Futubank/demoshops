%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/_common_msgs.lng"%%
%%include_language "templates/lang/sitemap_history.lng"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  <td width="60" class="td_small_text">##fdate##&nbsp;<br />##ftime##&nbsp;</td>
  <td width="150" class="td_small_text"><nobr>%%##action##%%&nbsp;</nobr>##if(sitemap_file != '')##<a href="##sitemap_file_link##" target="_blank">##sitemap_file##&raquo;</a>##endif##</td>
  <td align="right" width="60">&nbsp;##time##</td>
  <td align="right" width="60">&nbsp;##sitemap_size##</td>
  <td align="right" width="60">&nbsp;##num_urls##&nbsp;</td>
  <td class="td_small_text">##useragent##&nbsp;</td>
  <td align="center">%%##action_status##%%&nbsp;</td>
  <td width="40" align=center nowrap>##--actions--####action_view####action_del##</td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_all" align="left" width="60">
                %%fdate%%&nbsp;
                ##sort_date##
                </td>
                <td class="first_row_all list_name_col" align="left" width="150">
                %%action%%&nbsp;
                ##sort_action##
                </td>
                <td class="first_row_all" align="left">
                %%time%%
                ##sort_time##
                </td>
                <td class="first_row_all" align="left">
                %%size%%
                ##sort_size##
                </td>
                <td class="first_row_all" align="left">
                %%urls%%
                ##sort_num_urls##
                </td>
                <td class="first_row_all" align="left">
                %%useragent%%&nbsp;
                </td>
                <td class="first_row_all" align="left" width="60">
                %%status%%
                ##sort_status##
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
      ##_group_operations_footer##
      </form>

<a name="anchor"></a>
"-->
