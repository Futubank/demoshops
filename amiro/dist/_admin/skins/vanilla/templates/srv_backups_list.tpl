%%include_language "templates/lang/srv_backups.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="restore" value="
  <a href="javascript:" onClick="if (confirm('%%restore_backup%%')){startRestore(##restore_id##);}return false;"><img title="%%icon_restore%%" class=icon src="skins/vanilla/icons/icon-restore.gif"></a>
"-->

<!--#set var="download" value="
  <a href="javascript:void(0)" onclick="dloadFile('##href##');return false"
    target="_new" title='%%download_file%%'><img src='skins/vanilla/icons/icon-dec-sel.gif' border=0 title='%%download_file%%'>##filename## &raquo;</a>
"-->

<!--#set var="row" value="<!--row-->
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td class="td_small_text"><nobr>##tstamp##</nobr></td>
  <td>##site_id##&nbsp;</td>
  <td class="td_small_text">##description##&nbsp;</td>
  <td>##arch_type##&nbsp;</td>
  <td class="td_small_text">##items##</td>
  <td class="td_small_text"><nobr>##filename##</nobr></td>
  <td>##file_size##</td>
  <td width="40" align=center><nobr>&nbsp;##action_restore####action_del##</nobr></td>
</tr>
"-->

<!--#set var="list_body" value="<!--list_body-->
        
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_all" width="15%">
                 %%date%%
                 ##sort_tstamp##
                </td>
                <td class="first_row_all">
                 %%site%%
                </td>
                <td class="first_row_all">
                 %%description%%
                </td>
                <td class="first_row_all">
                 %%arch_type%%
                </td>
                <td class="first_row_all">
                 %%items%%
                </td>
                <td class="first_row_all">
                 %%filename%%
                </td>
                <td class="first_row_all">
                 %%filesize%%
                </td>
                <td class="first_row_all" align="center" width="40">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
</form>

<a name="anchor"></a>
"-->
