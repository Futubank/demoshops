%%include_language "templates/lang/main.lng"%%

<form action="index.php">
<input type="hidden" name="action" value="change">
<table cellspacing="0" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
<tr>
  <td colspan="2" align="right">
    <br>
  </td>
</tr>
<tr>
  <td>%%cur_lang%%:</td>
  <td>
    <select name="lang">
      <option ##lang_sel_en## value="en">%%eng%%</option>
      <option ##lang_sel_ru## value="ru">%%rus%%</option>
    </select>
  </td>
</tr>
<tr>
  <td colspan="2" align="right">
    <br>
    <input type="submit" value="%%lang_change_btn%%" class="but">
    <br><br>
  </td>
</tr>
</table>
</form>
