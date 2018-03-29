<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
    <td class="row1" align="center"><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="icons_grp_delete_from_list" value="<b>|</b><a href="javascript:grpAction('delete_from_list');" onClick="return (grpCheckSelection() && confirm('%%grp_delete_from_list_warn%%'));"><img title="%%icon_delete_from_list%%" class="icon" src="skins/vanilla/icons/icon-popup_del.gif" helpId="btn_grp_delete_from_list" align="absmiddle" hspace="3" /></a>"-->
<!--#set var="icon_delete_from_list"      value="<img title="%%icon_delete_from_list%%" class="icon" src="skins/vanilla/icons/icon-popup_del_leg.gif" border="0" helpId="btn_delete_from_list">"-->
<!--#set var="leg_delete_from_list"       value="<nobr><img title="%%icon_delete_from_list%%" class="leg_icon" src="skins/vanilla/icons/icon-popup_del_leg.gif" align="absmiddle" helpId="legend"> - %%icon_delete_from_list%%&nbsp;&nbsp;</nobr>"-->
<!--#set var="icons_grp_apply_price"      value="<b>|&nbsp;&nbsp;&nbsp;</b><input type="text" name="grpPrice" class="field field80"  maxLength="255" /> <input type="button" class="but" onClick="if (grpCheckSelection() && grpCheckPriceToApply(this.form.grpPrice.value) && confirm('%%warn_grp_apply_price%%')) { document.forms[_cms_document_form].grpPrice.value = this.form.grpPrice.value; grpAction('apply_price'); } return false;" value="%%btn_grp_apply_price%%" style="margin-bottom:-1px;" />"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
    ##_group_operations_col##
    <td>##name##&nbsp;<input type="hidden" id="pure_name_##id##" value="##pure_name##" disabled /></td>
    <td align="center" nowrap="nowrap" width="80">
        ##action_edit##
        ##action_del##
    </td>
</tr>
"-->

<!--#set var="list_body" value="
<script>

function grpCheckPriceToApply(value)
{
    if (value.length < 1) {
        alert('%%warn_missing_price_to_apply%%');
        return false;
    }
    return true;
}

</script>

<div width="100%" align="right" style="margin-top: 15px;" >##pager##</div>
    ##_group_operations_script##
    <form name="group_operations_form">
    <table width="100%" align="center" border="0" cellspacing="0" cellpadding="4">
    <tr>
        ##_group_operations_header##
        <td class="first_row_left_td">
            ##sort_name##
            %%sort_name%%
        </td>
        <td class="first_row_all" align="center" width="40">
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