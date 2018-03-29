%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/faq.lng"%%


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

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)"
onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  ##_positions_col##
  <td width="30" align=center>##public##</td>
  <td width="60" class="td_small_text">##fdate##&nbsp;</td>
   ##category_col##
  <td><nobr>##if(email!='')##<a href="mailto:##email##">##author##&nbsp;&raquo;</a>&nbsp;</nobr>##else####author##&nbsp;##endif##</td>
  <td class="td_small_text">##question##&nbsp;</td>

##if(EXTENSION_RATING=="1")##
    <td align="center">
      ##votes_count##
  </td>
    <td align="center">
      ##votes_rate##
  </td>
##endif##


  <td width="40" align=center>##action_edit####action_del##&nbsp;</td>
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
                <td class="first_row_left_td" align="center" valign="middle" width="30">
                 ##sort_public##
                </td>
                <td class="first_row_all" width="60">
                 %%date%%
                 ##sort_date##
                </td>
                ##category_list_header##
                <td class="first_row_all" width="70">
                 %%author%%
                  ##sort_author##
                </td>
                <td class="first_row_all list_name_col">
                 %%question%%
                 ##sort_question##
                </td>

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