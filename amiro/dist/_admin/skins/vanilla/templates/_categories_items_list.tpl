%%include_language "templates/lang/_categories_items.lng"%%

<!--#set var="category_list_header" value="
<td class="first_row_all">%%category%%##sort_category_name##
<script type="text/javascript">
function setFilterCategory(categoryId)
{
    document.forms[_cms_filter_form].##flt_field_name##.value = categoryId;
    fireEvent2(document.forms[_cms_filter_form], 'submit');
    document.forms[_cms_filter_form].submit();
    return false;
}
</script>
</td>
"-->

<!--#set var="category_list_col" value="
<td class="td_small_text"><a href="javascript:" onClick="return setFilterCategory(##id_category##)">##category_name##&nbsp;&raquo;</a>&nbsp;</td>
"-->