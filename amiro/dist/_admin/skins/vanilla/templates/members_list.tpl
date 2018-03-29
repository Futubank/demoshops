%%include_language "templates/lang/members.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr><td class="row1" align="center"><h3>%%empty%%</h3></td></tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
    <td width="30" align=center>##active##</td>
    <td class="td_small_text"><nobr>##date##</nobr></td>
    <td width="100">##username##&nbsp;</td>
    <td width="*">##nickname##&nbsp;</td>
    ##if(CONFIRM_NEED=="1")##
    <td>##user_status##&nbsp;</td>
    ##endif##
    <td width="180">##email##&nbsp;</td>
    <td width="110">##firstname##&nbsp;</td>
    <td width="110">##lastname##&nbsp;</td>
##--    <td>##company##<br>##webcompany##&nbsp;</td>--##
    <td width="100" align=center nowrap>##actions##</td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_left_td" align="center" valign="middle" width="30">
                 ##sort_active##
                </td>
                <td class="first_row_all" width="60" valign="middle">
                 ##sort_date##
                 %%date%%
                </td>
                <td class="first_row_all" width="100">
                 ##sort_username##
                 %%username%%
                </td>
                <td class="first_row_all" width="*">
                 ##sort_nickname##
                 %%nickname%%
                </td>
##if(CONFIRM_NEED=="1")##
                <td class="first_row_all" width="180">
                 ##sort_user_status##&nbsp;
                 %%user_status%%
                </td>
##endif##
                <td class="first_row_all" width="180">
                 %%email%%
                 ##sort_email##
                </td>
                <td class="first_row_all" width="110">
                  ##sort_firstname##
                 %%firstname%%
                </td>
                <td class="first_row_all" width="110">
                  ##sort_lastname##
                 %%lastname%%
                </td>
##--                <td class="first_row_all">
                 %%company%%
                 ##sort_company##
                </td>--##
                <td class="first_row_all" align="center" width="70">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
<a name="anchor"></a>
"-->