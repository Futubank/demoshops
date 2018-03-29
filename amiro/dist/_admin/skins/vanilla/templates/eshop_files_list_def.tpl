<!--#set var="free_download_on" value="<a href="javascript:freedownload('##file_id##','off');"><img title="%%icon_free_download_on%%" class=icon src="skins/vanilla/icons/icon-free_download_on.gif" border="0" helpId="btn_free_download"></a>"-->
<!--#set var="free_download_off" value="<a href="javascript:freedownload('##file_id##','on');"><img title="%%icon_free_download_off%%" class=icon src="skins/vanilla/icons/icon-free_download_off.gif" border="0" helpId="btn_free_download"></a>"-->

<!--#set var="leg_free_download_on" value="<nobr><img title="%%leg_free_download_on%%" src="skins/vanilla/icons/leg-free_download_on.gif" border="0" align="absmiddle" helpId="legend"> - %%leg_free_download_on%%</nobr>&nbsp;&nbsp;"-->
<!--#set var="leg_free_download_off" value="<nobr><img title="%%leg_free_download_off%%" src="skins/vanilla/icons/leg-free_download_off.gif" border="0" align="absmiddle" helpId="legend"> - %%leg_free_download_off%%</nobr>&nbsp;&nbsp;"-->

<!--#set var="item_add_icon_link" value="<a href="##view_link##" target="_blank">##ficon##</a>"-->
<!--#set var="item_add_link" value="<a href="##view_link##" title="" target="_blank">##file_name_short##</a>"-->

<!--#set var="empty" value="
<div align="center" width="100%"><h3>%%list_empty%%</h3></div>
"-->

<!--#set var="icons_grp_del"     value="<a href="javascript:grpAction('del');" onClick="return (grpCheckSelection() && confirm('%%grp_delete_warn%%'));" title="%%icon_grp_del%%">%%delete%%</a>
"-->

<!--#set var="icons_grp_move"     value="<a href="javascript:prepareFileIds();grpAction('move');" onClick="return (grpCheckSelection() && confirm('%%grp_move_warn%%'));" title="%%grp_add_to_list%%">%%add_to_list%%</a>&nbsp;|&nbsp;
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
##_group_operations_col##
<td width="60" align="center">##ficon##</td>
<td width="30" align=center>##active##</td>
<td align="center">##free_download_icon##</td>
<td align="left">##file_name_short##&nbsp;</td>
<td align="left">##name##&nbsp;</td>
<td align=right>##size##&nbsp;</td>
<td width="120" align="right"><nobr>##fcdate##</nobr><br><nobr>##fmdate##</nobr></td>
<td align=right><div align="right">&nbsp;<a href="javascript:void(0);" onclick="return moveToList(##id##);" title="%%select_file%%">%%add_to_list%%</a>&nbsp;|##edit_icon##&nbsp;<a href="javascript:void(0);" onclick="return deleteFile(##id##);">%%delete%%</a>&nbsp;
</td>
</tr>
"-->

<!--#set var="list_body" value="
<table border="0" width=100% cellspacing="0" cellpadding="0">
<tr>
  <td align=left>##filter##&nbsp;</td>
  <td align=right>##pager##</td>
</tr>
</table>
##_group_operations_script##
<form name="group_operations_form">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    ##_group_operations_header##
    <td class="first_row_all" width="60">
     ##sort_ftype##
     %%ftype%%
    </td>
    <td class="first_row_all" width="30">&nbsp;</td>
    <td class="first_row_all" width="60">
     %%free_download%%
    </td>
    <td class="first_row_all" width="200">
     ##sort_original_fname##
     %%fname%%
    </td>
    <td class="first_row_all list_name_col">
     ##sort_name##
     %%name%%
    </td>
    <td class="first_row_all" width="80">
     ##sort_filesize##
     %%fsize%%
    </td>
    <td class="first_row_all" width="120">
     %%fcdate%%<br>%%fmdate%%
    </td>
    <td class="first_row_all" width="250">
     %%actions%%
    </td>
  </tr>
  ##list##
</table>
##_group_operations_footer##
</form>
<div align="right" width="100%">##pager##</div>
<a name="anchor"></a>
"-->
