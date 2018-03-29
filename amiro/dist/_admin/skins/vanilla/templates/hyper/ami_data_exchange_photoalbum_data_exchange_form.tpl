##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/data_exchange.tpl"%%

<!--#set var="hint_field(caption=photoalbum_import_not_allowed)" value="
<tr><td><b>%%photoalbum_import_not_allowed%%</b></td></tr>
"-->

<!--#set var="hint_field(caption=photoalbum_note)" value="
<tr><td colspan=3><div class="tooltip">%%photoalbum_note%%</div></td></tr>
"-->

<!--#set var="hint_field(caption=photoalbum_additional_params)" value="<tr><td colspan=3><br><b>%%photoalbum_additional_params%%</b><br><br></td></tr>"-->

<!--#set var="input_field(name=catname)" value="
<tr>
    <td>&nbsp;</td>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td><input type="text" name="##name##" id="catname" class="field field40 value="##value##" maxlength="30" ##attributes## onkeyPress="syncWithSelect(event, this.form.cat_id, this);" onkeyup="OnFieldKeyUp(this, event);"/></td>
</tr>
"-->

<!--#set var="radio_field" value="<tr><td colspan="3">##select##</td></tr>"-->

<!--#set var="radio_field_row(name=cattype_2)" value="
<input type="radio" id="cattype_2" onclick="switchCategoriesList(false);" ##checked## value="2" name="cattype" title="" />&nbsp;&nbsp;<label for="cattype_2">##caption##</label>
"-->

<!--#set var="radio_field_row(name=cattype_1)" value="
<input type="radio" id="cattype_1" onclick="switchCategoriesList(true);" ##checked## value="1" name="cattype" title="" />&nbsp;&nbsp;<label for="cattype_1">##caption##</label>
"-->

<!--#set var="select_field(name=cat_id)" value="
<tr>
    <td>&nbsp;</td>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td>##if(select)##<select id="category_id" name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##select##</select>##else##%%no_categories%%##endif##</td>
</tr>
"-->

<!--#set var="select_field(name=id_page_cattype_2)" value="
<tr>
    <td colspan=2>&nbsp;</td>
    <td>##element_caption##: <select name="id_page" id="id_page_cattype_2" ##attributes##>##select##</select>
    </td>
</tr>
"-->

<!--#set var="select_field(name=id_page_cattype_1)" value="
<tr>
    <td>&nbsp;</td>
    <td colspan=2>##element_caption##: <select name="id_page" id="id_page_cattype_1" ##attributes##>##select##</select></td>
</tr>
"-->

<!--#set var="checkbox_field(name=force_rewrite)" value="
<tr>
    <td colspan=3>
        <label>
            <input type="checkbox" id="cb_##name##" name="##name##" value="1"##checked## class="##filter_class##" helpId="form_##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />
            ##element_caption####IF(validator_filled)##*##ENDIF##
        </label>
    </td>
</tr>
"-->
