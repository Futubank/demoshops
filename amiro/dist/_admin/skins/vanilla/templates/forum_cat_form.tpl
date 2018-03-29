%%include_language "templates/lang/_categories.lng"%%
%%include_template "templates/_categories_form.tpl"%%
%%include_language "templates/lang/forum.lng"%%

<!--#set var="custom_cat_form_fields" value="
<script type="text/javascript">
function OnObjectChanged_forum_cat_form(name, first_change, evt){
    if(name == 'is_separator'){
        var isSeparator = document.forms[_cms_document_form].is_separator.checked,
            state = isSeparator ? 'disabled' : 'normal';

        baseTabs.setTabState('body', state);
        baseTabs.setTabState('options', state);
        if(isSeparator && !baseTabs.isTabActive('announce')){
            baseTabs.showTab('announce');
        }
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_forum_cat_form);
</script>
<tr>
    <td colspan="2">
        <input type="checkbox" name="is_separator" id="is_separator"##is_separator## value="1" />
        <label for="is_separator">%%is_separator%%</label>
    </td>
</tr>
"-->

<script type="text/javascript">
if(document.forms[_cms_document_form].is_separator.checked){
    OnObjectChanged_forum_cat_form('is_separator');
}
</script>
