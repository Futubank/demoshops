%%include_language "templates/lang/subs_send.lng"%%
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
  <td width="160"  class="td_small_text">##topic##&nbsp;</td>
  <td width="30">##attach##&nbsp;</td>
  <td>##subject##&nbsp;</td>
  <td width="70" class="td_small_text">##status##&nbsp;</td>
##if(ONLY_ACTIVE!="1")##
  <td width="90" class="td_small_text">##send_to##</td>
##endif##
  <td width="120" class="td_small_text"><nobr>##date##</nobr></td>
  <td align=center>##actions##</td>
</tr>
"-->


##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_left_td" valign="middle" width="160">
                 %%topic%%
                 ##sort_topic##
                </td>
                <td class="first_row_all" width="30">
                  ##sort_attach##
                </td>
                <td class="first_row_all list_name_col">
                 %%name%%
                  ##sort_subject##
                </td>
                <td class="first_row_all" width="70">
                 %%status%%
                  ##sort_attempts_left##
                </td>
##if(ONLY_ACTIVE!="1")##
                <td class="first_row_all" width="90">
                 %%send_to%%
                 ##sort_send_to##
                </td>
##endif##
                <td class="first_row_all" width="120" valign="middle">
                 ##sort_date##
                 %%date%%
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##history_list##
            </table>
<a name="anchor"></a>