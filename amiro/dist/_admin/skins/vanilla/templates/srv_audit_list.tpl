##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/srv_audit.lng"%%
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
  <td width="125">##fdate##&nbsp;</td>
  <td width="60" align=right>
    ##if(module_link!="")##
      <a href="##module_link##?action=locate&id=##id_item###anchor">##id_item## &raquo;</a>
    ##else##
      ##id_item##
    ##endif##</td>
  <td width="120">
    ##if(module_link!="")##
      <a href="##module_link##?action=locate&id=##id_item###anchor">##item_name## &raquo;</a>
    ##else##
      ##item_name##
    ##endif##&nbsp;</td>
  <td width="140">##module_name##</td>
  <td width="120">##original_status##</td>
  <td width="120">##audit_status##</td>
  <td>##if(username!="")## ##username## ##else## %%admin%% ##endif##
  (##firstname##&nbsp;##lastname##)</td>
  <td align=center>
    ##--if(action!="approved" && action!="rejected")--##
      ##action_edit##
    ##--else##
      &nbsp;
    ##endif--##
  </td>
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
                 %%date_last%%
                 ##sort_date##
                </td>
                <td class="first_row_all">
                 %%id_item%%
                  ##sort_id_item##
                </td>
                <td class="first_row_all">
                 %%item_name%%
                </td>
                <td class="first_row_all">
                 %%module_name%%
                  ##sort_module_name##
                </td>
                <td class="first_row_all">
                 %%original_status%%
                  ##sort_original_status##
                </td>
                <td class="first_row_all">
                 %%audit_status%%
                  ##sort_audit_status##
                </td>
                <td class="first_row_all">
                 %%username%%
                  ##sort_username##
                </td>
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