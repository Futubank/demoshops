<!--#set var="del" value="
  <a href="javascript:" onClick="if (confirm('##if(numcats > 0)##%%delete_warn_pre%% ##numcats##\n##endif##%%delete_warn%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" class=icon src="skins/vanilla/icons/icon-del.gif"></a>
"-->

<!--#set var="copy" value="<a href="javascript:" onclick="if(confirm('%%copy_warn%%')){user_click('copy','##copy_id##');}return false;"><img title="%%icon_copy%%" class="icon" src="skins/vanilla/icons/icon-copy.gif" /></a>"-->

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
  <td>##name##</td>
  <td width="90" align=right>##numfields##</td>
  <td width="90" align=right>##numcats##</td>
  <td width="150">##postfix##</td>
  <td width="150">##sku_map##&nbsp;</td>
  <td align=center>
    ##action_edit##
    ##action_copy##
    ##action_del##
  </td>
</tr>
"-->

<!--#set var="list_body" value="
           <div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_left_td list_name_col">
                  %%name%%
                  ##sort_name##
                </td>
                <td class="first_row_all" width="90" align=right>
                  %%numfields%%
                  ##sort_numfields##
                </td>
                <td class="first_row_all" width="90" align=right>
                  %%numcats%%
                  ##sort_numcats##
                </td>
                <td class="first_row_all" width="150">
                  %%postfix%%
                  ##sort_postfix##
                </td>
                <td class="first_row_all" width="150">
                 %%sku_map%%
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