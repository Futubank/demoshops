%%include_language "templates/lang/adv_campaigns.lng"%%
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
  ##_group_operations_col##
  <td width="30" align=center>##public##</td>
  <td>##name##&nbsp;</td>
  <td width="130" class="td_small_text">
    ##cmpg_status##
    ##if(status=="finished")##<br>[%%stat_finished%%: ##status_comment##]##elseif(status=="active" && active_views=="1")##<br>[%%stat_active_progress%%]##endif##
  </td>
  <td width="130" class="td_small_text">
    ##if(start_date == "")##
        %%date_unknown%%
    ##else##
        ##start_date##
    ##endif##
  </td>
  <td width="130" class="td_small_text">
    ##if(start_date == end_date)##
        &nbsp;
    ##else##
        ##end_date##
    ##endif##
  </td>
  <td width="70" class="td_small_text">
    ##if(priority >= 2)##
        %%priority_high%%
    ##elseif(priority == 1)##
        %%priority_normal%%
    ##else##
        %%priority_low%%
    ##endif##
  </td>
  <td align=right>##banners_num##</td>
  <td vAlign=top align=right class="td_small_text">
    <table>
    <tr><td style="border:0px">%%cost_base%%</td><td style="border:0px" align=right>##cost##</td></tr>
    ##if(hascostview == "1")##
    <tr><td style="border:0px">%%cost_view%%</td><td style="border:0px" align=right>##cost_view##</td></tr>
    ##endif##
    ##if(hascostclick == "1")##
    <tr><td style="border:0px">%%cost_click%%</td><td style="border:0px" align=right>##cost_click##</td></tr>
    ##endif##
    ##if(hasmaxcostview == "1")##
    <tr><td style="border:0px">%%max_cost_view%%</td><td style="border:0px" align=right>##max_cost_view##</td></tr>
    ##endif##
    ##if(hasmaxcostclick == "1")##
    <tr><td style="border:0px">%%max_cost_click%%</td><td style="border:0px" align=right>##max_cost_click##</td></tr>
    ##endif##
    </table>
  </td>
  <td class="td_small_text"><nobr>##lastname## ##firstname##</nobr> (##username##)</td>
##_id_page_row_col##
  <td width="100" align=center>##action_edit####action_del####--actions--##</td>
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
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_public##
                </td>
                <td class="first_row_all list_name_col">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all" width="130">
                 ##sort_status##
                 %%cmpg_status%%
                </td>
                <td class="first_row_all" width="130">
                 %%start_date%%
                 ##sort_start_date##
                </td>
                <td class="first_row_all" width="130">
                 %%end_date%%
                 ##sort_end_date##
                </td>
                <td class="first_row_all" width="70">
                 %%priority%%
                 ##sort_priority##
                </td>
                <td class="first_row_all" width="80">
                 %%banners_num%%
                 ##sort_banners_num##
                </td>
                <td class="first_row_all">
                 ##sort_cost##
                 %%cost%%
                </td>
                <td class="first_row_all">
                 %%advertiser%%
                 ##sort_advertiser##
                </td>
##_id_page_header##
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
##_group_operations_footer##
</form>

<div class=tooltip>%%campaign_notice%%</div>
<a name="anchor"></a>
"-->