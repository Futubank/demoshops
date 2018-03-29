%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/relations.lng"%%

<!--#set var="empty" value="
<div align="center" width="100%"><h3>%%list_empty%%</h3></div>
"-->

<!--#set var="icons_grp_move" value="<a href="javascript:prepareFileIds();grpAction('move');" onClick="return (grpCheckSelection() && confirm('%%grp_move_warn%%'));" title="%%grp_add_to_list%%">%%add_to_list%%</a>&nbsp;"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
    ##_group_operations_col##
    <td width="30" align="center">##public##</td>
    <td width="140"><nobr>##name##&nbsp;<nobr></td>
    <td>##announce##&nbsp;</td>
    <td align="right" width="60"><div align="right">&nbsp;<a href="javascript:void(0);" onclick="return moveToList(##id##);" title="%%select_file%%">%%add_to_list%%</a>&nbsp;</td>
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
        <td class="first_row_all" align="center" valign="middle" width="30">##sort_public##&nbsp;</td>
        <td class="first_row_all list_name_col">##sort_name##%%name%%</td>
        <td class="first_row_all">##sort_announce##%%announce%%</td>
        <td class="first_row_all" width="60">%%actions%%</td>
    </tr>
    ##list##
</table>
##_group_operations_footer##
</form>

##button_add##
<div align="right" width="100%">##pager##</div>
<a name="anchor"></a>
"-->
