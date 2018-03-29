%%include_language "_shared/code/templates/lang/adv_campaigns.lng"%%
%%include_template "_shared/code/templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr vAlign=top>
  <td width="*" align=left>
    ##name##
    &nbsp;
  </td>
  <td vAlign=top align=right>
    <table border=0>
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
  <td width="80" align=left>
    ##cmpg_status##
    ##if(status == "refused")##
        %%status_refused%%
    ##elseif(status == "active")##
        %%status_active%%
    ##elseif(status == "finished")##
        %%status_finished%%
    ##else##
        %%status_pending%%
    ##endif##
    ##if(status=="finished")##<br>[%%stat_finished%%: ##status_comment##]##elseif(status=="active" && active_views=="1")##<br>[%%stat_active_progress%%]##endif##
  </td>
  <td width="80" align=right>##if(banners_num > 0)####banners_num####else##<a href="##BANNERS_URL##" title="%%create_banners_note%%" style="color:red">%%no_banners%%</a>##endif####--<br><a href=##BANNERS_URL##>[%%edit_banners%%]</a>--##</td>

##--if(EXTENSION_AUDIT=="1")##
    <td align=left>
      ##audit_status##
    </td>
##endif--##

  <td width="130">
    ##if(start_date == "")##
        %%date_unknown%%
    ##else##
        ##start_date##
    ##endif##
  </td>
  <td width="130">
    ##if(start_date == end_date)##
        &nbsp;
    ##else##
        ##end_date##
    ##endif##
  </td>

  <td width="40" align=center>##action_edit####if(deletable == "1")####action_del####endif####if(renewable == "1")##<a href="##CAMPAIGN_TYPES_URL##?action=rsrtme&flt_renew=##id_type##">%%renew%%</a>##endif##</td>
</tr>
"-->

<!--#set var="list_body" value="
        <div align="right" width="100%">##pager##</div>
            <table width="100%" border="0" class=tbl cellspacing="0" cellpadding="4">
              <tr>
                <th class="first_row_all" width="*" align=left>
                 ##sort_name##
                 %%name%%
                </th>
                <th class="first_row_all" align=left>
                 ##sort_cost##
                 %%cost%%
                </th>
                <th class="first_row_all" width="80" align=left>
                 ##sort_status##
                 %%status%%
                </th>
                <th class="first_row_all" width="80" align=left>
                 ##sort_banners_num##
                 %%banners_num%%
                </th>
                ##--if(EXTENSION_AUDIT=="1")##
                <th class="first_row_all" width="100" align=left>
                %%audit_status%%
                </th>
                ##endif--##
                <th class="first_row_all" width="130">
                 ##sort_start_date##
                 %%start_date%%
                </th>
                <th class="first_row_all" width="130">
                 ##sort_end_date##
                 %%end_date%%
                </th>
                <th class="first_row_all" align="center" width="40">
                 %%actions%%
                </th>
              </tr>
              ##list##
            </table>
           <div align="right" width="100%">##pager##</div>

##if(legend != "")##
<table cellspacing=0 cellpadding=5 border=0>
<tr><td valign="top">
<b>%%legend%%:</b>
<td valign="top" align="left" width=100%>
##legend##
</td>
</tr></table>
##endif##
<a name="anchor"></a>
"-->
