%%include_language "templates/lang/files.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="num_downloaded_header" value="
  <td class="first_row_all" width="100">
   %%num_downloaded%%
   ##sort_num_downloaded##
  </td>
"-->

<!--#set var="num_downloaded_col" value="
  <td width="100" align="right">&nbsp;##num_downloaded##</td>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  ##_positions_col##
  <td width="30" align=center>##public##</td>
  ##_picture_col##
  ##category_col##
  <td>##name##&nbsp;</td>
  <td class="td_small_text">##announce##&nbsp;</td>
  <td width="50" align="center">&nbsp;<a target="_blank" href="##view_link##">##ficon##</a><br>##fsize##</td>

  ##if(EXTENSION_AUDIT=="1")##
    <td align="center">
      <b>##audit_status##</b><br>
      ##audit_role##<br>
      ##audit_username##
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

  ##num_downloaded_col##
  <td width="120" align="right"  class="td_small_text"><nobr>##cdate##</nobr><br><nobr>##mdate##</nobr></td>
##_id_page_row_col##
  <td width="100" align=center>##--actions--####action_edit####action_del##&nbsp;</td>
</tr>
"-->

<!--#set var="list_body" value="
           
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
##_positions_data##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                ##_positions_header##
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_public##
                </td>
                ##_picture_header##
                ##category_list_header##
                <td class="first_row_all">
                 %%fname%%
                 ##sort_name##
                </td>
                <td class="first_row_all">
                 %%announce%%
                 ##sort_announce##
                </td>
                <td class="first_row_all" width="60">
                 %%ftype%%
                 ##sort_ftype##
                </td>
                
##if(EXTENSION_AUDIT=="1")##
                <td class="first_row_all" width="100">
                %%audit_status%%
                </td>
##endif##

##if(EXTENSION_RATING=="1")##
                <td class="first_row_all" width="30">
                %%votes_count%%
                ##sort_votes_count##
                </td>
                <td class="first_row_all" width="30">
                %%votes_rate%%
                ##sort_votes_rate##
                </td>
##endif##

                ##num_downloaded_header##
                <td class="first_row_all" width="120">
                 %%fcdate%%<br>%%fmdate%%
                 ##sort_cdate##
                </td>
##_id_page_header##
                <td class="first_row_all" align="center" width="40">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
            ##_group_operations_footer##
            </form>
<a name="anchor"></a>
"-->