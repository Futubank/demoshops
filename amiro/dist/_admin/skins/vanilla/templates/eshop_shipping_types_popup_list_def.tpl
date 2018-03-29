<!--#set var="is_default" value="<img class="icon" src="skins/vanilla/icons/icon-ok.gif" border="0" helpId="btn_is_default" />"-->
<!--#set var="nbsp" value="&nbsp;"-->

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
    <td class="row1" align="center"><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
    ##_group_operations_col##
##--    <td width="30" align="center">##is_default##</td>--##
    <td>##name##&nbsp;<input type="hidden" name="full_name_##id##" value="##full_name##" /></td>
    <td align="right">##methods_count##&nbsp;</td>
    <td align="right">##categories_count##&nbsp;</td>
    <td align="center" nowrap="nowrap">
        ##action_select##
    </td>
</tr>
"-->

<!--#set var="list_body" value="
<script>
function selectItemFromPopup(form, id)
{
    var srcForm = document.group_operations_form;
    var destForm = top.document.forms['eshop_form'];
    if (destForm.id_shipping_type.value != id) {
        fireEvent2(destForm.id_shipping_type, 'onChange', top.document);
    }
    top.document.getElementById('img_shipping_type').title = '%%button_select%% (%%current_shipping_type%%: ' + srcForm.elements['full_name_' + id].value + ')';
    destForm.id_shipping_type.value = id;
    closeDialogWindow();
}
</script>

<div width="100%" align="right" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
    <form name="group_operations_form">
    <table width="100%" align="center" border="0" cellspacing="0" cellpadding="4">
    <tr>
        ##_group_operations_header##
##--        <td class="first_row_left_td" align="center" valign="middle" width="30">
            %%sort_is_default%%
            ##sort_is_default##
        </td>--##
        <td class="first_row_all">
            %%sort_name%%
            ##sort_name##
        </td>
        <td class="first_row_all" width="70" title="%%sort_methods_count_help%%">
            %%sort_methods_count%%
            ##sort_methods_count##
        </td>
        <td class="first_row_all" width="70" title="%%sort_categories_count_help%%">
            %%sort_categories_count%%
            ##-- sort_categories_count --##
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