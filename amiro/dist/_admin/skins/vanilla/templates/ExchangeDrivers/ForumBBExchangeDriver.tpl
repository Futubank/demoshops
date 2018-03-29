%%include_language "templates/ExchangeDrivers/lang/ForumBBExchangeDriver.lng"%%

<!--#set var="import_form" value="
<script type="text/javascript">
function onSubmitHandler_ForumBBExchangeDriver(form)
{
    errFunc = onSubmitHandler_ForumBBExchangeDriver;

    if (form.import_driver.value == 'ForumBBExchangeDriver') {
        var dbPrefix = form.prefix.value;
        if (dbPrefix.length < 1) {
            alert('%%warn_prefix%%');
            form.prefix.focus();
            return false;
        }
        if (dbPrefix == 'cms_') {
            alert('%%status_invalid_db_prefix%%');
            form.prefix.focus();
            return false;
        }
    }
    if (form.erase_forum.checked && !confirm('%%warn_erase_forum%%')) {
        return false;
    }
    return true;
}
addDriverOnSubmitHandler(onSubmitHandler_ForumBBExchangeDriver);

function OnObjectChanged_ForumBBExchangeDriver(name, firstChange, evt)
{
    errFunc = OnObjectChanged_ForumBBExchangeDriver;

    if (name == 'import_avatars') {
        document.getElementById('div_import_avatars').style.display = document.forms[_cms_document_form].import_avatars.checked ? 'block' : 'none';
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_ForumBBExchangeDriver);
</script>

<tr name="##driver_name##_##driver_type##" style="display:##display##;"><td>
<table>
  <tr>
    <td>%%prefix%%*:</td>
    <td><input class="field field20" type="text" name="prefix"  maxLen="50" value="phpbb_" /></td>
  </tr>
  <tr>
    <td colSpan="2"><input type="checkbox" name="erase_forum" id="erase_forum" /> <label for="erase_forum">%%erase_forum%%</label></td>
  </tr>
  <tr>
    <td colSpan="2">
        <input type="checkbox" name="import_avatars" id="import_avatars" /> <label for="import_avatars">%%import_avatars%%</label><br />
        <div id ="div_import_avatars" class="tooltip" style="display:none;margin-left:22px;margin-top:5px;width:420px">%%tooltip_import_avatars%%</div>
    </td>
  </tr>
</table></td></tr>
"-->