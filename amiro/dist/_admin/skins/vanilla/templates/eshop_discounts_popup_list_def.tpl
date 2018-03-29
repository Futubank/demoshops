<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
    <td class="row1" align="center"><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
    <td width="30" align="center">##public##</td>
    <td><input type="hidden" name="full_name_##id##" value="##full_name##" />##name##&nbsp;</td>
    <td width="120">%%##condition##%%&nbsp;</td>
    <td width="60">##fdate_start##&nbsp;</td>
    <td width="60">##fdate_end##&nbsp;</td>
    <td align="right"><input type="hidden" name="full_amount_##id##" value="##amount####type##" />##amount####type##&nbsp;</td>
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
    if (destForm.id_discount.value != id) {
        fireEvent2(destForm.id_discount, 'change', top.document);
    }
    destForm.id_discount.value = id;
    top.document.getElementById('img_discount').title = '%%button_select%% (%%current_discount%%: ' + srcForm.elements['full_name_' + id].value + ')';
    closeDialogWindow();
}

</script>

<div width="100%" align="right" style="margin-top: 15px;" >##pager##</div>
    <form name="group_operations_form">
    <input type="hidden" name="category_id" value="##category_id##" />
    <table width="100%" align="center" border="0" cellspacing="0" cellpadding="4">
    <tr>
        <td class="first_row_left_td" align="center" valign="middle" width="30">
            ##sort_public##
        </td>
        <td class="first_row_all">
            %%sort_name%%
            ##sort_name##
        </td>
        <td class="first_row_all" width="70">
            %%sort_condition%%
            ##sort_condition##
        </td>
        <td class="first_row_all" width="80">
            %%sort_date_start%%
            ##sort_date_start##
        </td>
        <td class="first_row_all" width="80">
            %%sort_date_end%%
            ##sort_date_end##
        </td>
        <td class="first_row_all" width="60">
            %%sort_amount%%
            ##sort_amount##
        </td>
        <td class="first_row_all" width="70" title="%%sort_categories_count_help%%">
            %%sort_categories_count%%
            ##sort_categories_count##
        </td>
        <td class="first_row_all" align="center" width="100">
            %%actions%%
        </td>
    </tr>
    ##list##
    </table>
</form>


<a name="anchor"></a>
"-->
