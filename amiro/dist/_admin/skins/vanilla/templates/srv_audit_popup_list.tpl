##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/srv_audit.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="history_list_empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="history_row" value="
<tr class="##style##">
  <td>##_date##&nbsp;</td>
  <td>##status##</td>
  <td>##owner##&nbsp;</td>
  <td>##changed_by##, ##firstname## ##lastname## (##username##)</td>
  <td>##ip##&nbsp;</td>
  <td><span title="##comments##">##comments_short##</span>&nbsp;</td>
</tr>
"-->

<!--#set var="history_list" value="
        
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_all" align="center" valign="middle" width="125">
                 %%date_last%%
                </td>
                <td class="first_row_all">
                 %%status%%
                </td>
                <td class="first_row_all">
                 %%username%%
                </td>
                <td class="first_row_all">
                 %%changed_by%%
                </td>
                <td class="first_row_all">
                 %%ip%%
                </td>
                <td class="first_row_all">
                 %%comments%%
                </td>
              </tr>
              ##list##
            </table>
           
##button_add##
<div align="right" width="100%">##pager##</div>

"-->