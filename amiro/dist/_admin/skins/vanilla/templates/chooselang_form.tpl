%%include_language "templates/lang/main.lng"%%
<script type="text/javascript">
<!--
var editor_enable = "0";

var _cms_document_form = 'chl';
_cms_track_form_changes = false;
var _cms_script_link = '##script_link##?';
-->
</script>

<form name="chl" action="choose_lang.php" method="post">
<input type="hidden" name="action" value="change">
<table width="380" cellspacing="0" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">

<tr>
  <td colspan="2">%%choose_lang%%:&nbsp; 
          <select name="lang">
      <option ##lang_sel_en## value="en">%%eng%%</option>
      <option ##lang_sel_ru## value="ru">%%rus%%</option>
    </select>
  </td>
</tr>
<input type="hidden" name="skin" value="vanilla">
##--<tr>
  <td><br>%%choose_skin%%:&nbsp;</td>
  <td><br>
    <select name="skin">
      <option ##skin_sel_vanilla## value="vanilla">%%skin_vanilla%%</option>
      <option ##skin_sel_cross## value="cross">%%skin_cross%%</option>
    </select>
  </td>
</tr>--##
<tr>
  <td align=left valign=top class=small  colspan="2"><br>
    <input type=checkbox name=remember value=1 checked>&nbsp;
    %%remember_choice%%
        <br><br>
    <input type="submit" value="   %%ok_btn%%   " class="but">
    <br>
  </td>
</tr>
<tr>
  <td colspan="2" align="right" class=small>
    <br>
    %%add_lang1%%
##--{copy=50}--##
     <a href="mailto:##ADM_COPY_MAIL##">##ADM_COPY_MAIL##</a>
##--//{copy=50}--##
    <br><br>
  </td>
</tr>
</table>
</form>