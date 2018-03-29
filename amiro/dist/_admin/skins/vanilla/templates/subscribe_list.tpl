%%include_language "templates/lang/subscribe.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="export_row" value="##username####delim####email####delim####fdate####delim####firstname####delim####lastname####delim####address1####delim####address2####delim####city####delim####state####delim####zip####delim####country####delim####phone####delim####company####delim####companyweb####delim####active####delim####fdate_stop##
"-->
<!--#set var="export" value="##export_rows##"-->

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td width="30" align=center>##active##</td>
  <td width="90">##username##&nbsp;</td>
  <td width="160">##email##&nbsp;</td>
  <td width="110">##firstname##&nbsp;</td>
  <td width="110">##lastname##&nbsp;</td>
##if(TOPICS=="1")##
  <td class="td_small_text">##topics##&nbsp;</td>
##endif##
  <td width="120" class="td_small_text"><nobr>##date##</nobr><br><nobr>##date_stop##<nobr><br>##ip##&nbsp;</td>
  <td align=center>##actions##</td>
</tr>
"-->
          <table width="100%" border="0" cellspacing="0" cellpadding="4">
            <tr>
              <td align="left">
                <span class="text_button"  onclick="window.open('##script_link##?action=export&tid=##tid##&lang_data=##lang_data##')">%%export%%</span>
              </td>
              <td>
               
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
              </td>
            </tr>
          </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_left_td" align="center" valign="middle" width="30">
                 ##sort_active##
                </td>
                <td class="first_row_all" width="90">
                 %%username%%
                 ##sort_username##
                </td>
                <td class="first_row_all" width="160">
                 %%email%%
                 ##sort_email##
                </td>
                <td class="first_row_all" width="110">
                 %%firstname%%
                  ##sort_firstname##
                </td>
                <td class="first_row_all" width="110">
                 %%lastname%%
                  ##sort_lastname##
                </td>
##if(TOPICS=="1")##
                <td class="first_row_all">
                 %%topics%%
                </td>
##endif##
                <td class="first_row_all" width="120" valign="middle">
                 %%date%%
                 ##sort_date##
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##subscribe_list##
            </table>

<a name="anchor"></a>