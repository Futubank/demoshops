%%include_language "templates/lang/srv_login_history.lng"%%
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
  <td width="120" class="td_small_text">##date##</td>
  <td><nobr>##login##&nbsp;<nobr></td>
##if(HOST_MODE=="1")##
  <td>##domain##&nbsp;</td>
##endif##
  <td width="80">##status##&nbsp;</td>
  <td width="100">##ip##</td>
</tr>
"-->
           
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="first_row_left_td" width="120">
                 %%date%%
                  ##sort_date##
                </td>
                <td class="first_row_all">
                 %%login%%
                 ##sort_login##
                </td>
##if(HOST_MODE=="1")##
                <td class="first_row_all">
                 %%domain%%
                 ##sort_domain##
                </td>
##endif##
                <td class="first_row_all" width="80">
                 %%status%%
                  ##sort_status##
                </td>
                <td class="first_row_all" width="100">
                 %%ip%%
                  ##sort_ip##
              </tr>
              ##login_history_list##
            </table>

