%%include_language "templates/lang/articles.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td align="right">
      ##--cat_list--##
    </td>
  </tr>
  <tr>
    <td class=row1 align=center><h3>%%empty%%</h3></td>
  </tr>
  </table>
"-->

<!--#set var="forum_replies_header" value="
    <td class="first_row_all" width="30">
    %%forum_replies%%
    </td>
"-->


<!--#set var="views_col" value="
<td align="center">##views_count##</td>
"-->

<!--#set var="views_header" value="
    <td class="first_row_all" width="30">
    %%views_count%%
    </td>
"-->


<!--#set var="votes_col" value="
<td align="center">##votes_count##</td>
"-->

<!--#set var="votes_header" value="
    <td class="first_row_all" width="30">
    %%votes_count%%
    </td>
"-->

<!--#set var="rating_col" value="
<td align="center">##votes_rate##</td>
"-->

<!--#set var="rating_header" value="
    <td class="first_row_all" width="30">
    %%votes_rate%%
    </td>
"-->



<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  ##_positions_col##
<td width="30" align=center>##public##</td>
##--if(ARTICLES_MANUAL_ARCHIVE=="1")--##
  <td width="30" align=center>##archive##</td>
##--endif--##
  ##_picture_col##
  <td width="60" class="td_small_text">##fdate##&nbsp;</td>
  ##category_col##
  <td>##header##&nbsp;</td>
  <td  class="td_small_text">##announce##&nbsp;</td>
##if(EXTENSION_AUDIT=="1")##
    <td align="center">
      <b>##audit_status##</b><br>
      ##audit_role##<br>
      ##audit_username##
    </td>
##endif##
##if(EXTENSION_FORUM=="1")##
<td align="center">
    ##if(replies)##<a href="#" onClick="openDialog('%%forum_popup_title%%', '##forum_link##?popup=1&ext_module=articles&id_ext_module=##id##'); return false;" title="%%forum_open%%">
      <b>##replies##</b> &raquo;
    </a>##else##0##endif##
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


##if(SHOW_ADV_PLACE_COLUMNS == 1)##
<td width=140>##adv_place##&nbsp;</td>
##endif##

##if(SHOW_ADV_STAT_COLUMNS == 1)##
<td width=115 align=right>##shown_items##/##shown_details##/##shown_ctr##</td>
##endif##
  <td width="100" align=center>##--actions--####action_edit####action_del##</td>
</tr>
"-->

<!--#set var="list_body" value="
         ##--if(NO_ARTICLES_CATS!="1")##
           <div width="100%" align="right">##cat_list##</div>
         ##endif--##

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

              ##--if(ARTICLES_MANUAL_ARCHIVE=="1")--##
                <td class="first_row_all" width="30">
                  ##sort_archive##
                </td>
              ##--endif--##

                ##_picture_header##
                <td class="first_row_all"  width="60">
                 %%date%%
                 ##sort_date##
                </td>
                ##category_list_header##
                <td class="first_row_all list_name_col">
                 %%header%%
                 ##sort_header##
                </td>
                <td class="first_row_all">
                 %%announce%%
                 ##sort_announce##
                </td>
##if(EXTENSION_AUDIT=="1")##
                <td class="first_row_all" width="100">
                %%audit_status%%
                </td>
##endif##

##if(EXTENSION_FORUM=="1")##
                <td class="first_row_all" width="30">
                %%forum_replies%%
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


##if(SHOW_ADV_PLACE_COLUMNS == 1)##
<td class="first_row_all" width=140>%%col_adv_place%%</td>
##endif##

##if(SHOW_ADV_STAT_COLUMNS == 1)##
<td class="first_row_all" width=115>%%col_adv_stats%%</td>
##endif##

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