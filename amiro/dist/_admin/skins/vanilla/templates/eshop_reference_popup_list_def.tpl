<!--#set var="empty" value="
<div align="center" width="100%"><h3>%%list_empty%%</h3></div>
"-->

<!--#set var="row" value="
<tr bgcolor="##bgcolor##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" vAlign="top">
  <td width="150">##name##</td>
  <td>##description##&nbsp;</td>
  <td width="60">##fdate##&nbsp;</td>
<td align=right width="370"><div align="right">&nbsp;<a href="javascript:void(0);" onclick="return moveToList(##id##);" title="%%select_reference%%">%%add_to_list%%</a>&nbsp;##if(REFERENCE_TYPE != "related_items" && REFERENCE_TYPE != "related_cats" && REFERENCE_TYPE != "date")##|&nbsp;<a href="javascript:void(0);" onclick="return editReference(##id##);" title="%%edit_reference%%">%%edit%%</a>
&nbsp;##endif##|&nbsp;<a href="javascript:void(0);" onclick="return deleteReference(##id##);">%%delete%%</a>&nbsp;
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
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td class="first_row_left_td list_name_col" width="150">
      ##sort_name##
      %%name%%
    </td>
    <td class="first_row_all">
     %%description%%
    </td>
    <td class="first_row_all" width="60">
     ##sort_date##
     %%cdate%%
    </td>
    <td class="first_row_all" align="center" width="370">
     %%actions%%
    </td>
  </tr>
  ##list##
</table>
<div align="right" width="100%">##pager##</div>
<a name="anchor"></a>
"-->
