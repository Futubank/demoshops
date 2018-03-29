%%include_language "templates/ExchangeDrivers/lang/RapidCSVEshopDriver.lng"%%

<!--#set var="import_form" value="
<tr name="##driver_name##_##driver_type##" style="display:##display##;">
  <td colspan=3><br><b>%%import_title%%</b></td>
</tr>
<tr name="##driver_name##_##driver_type##" style="display:##display##;">
  <td>%%delim%%:&nbsp;</td>
  <td colspan=2><select name="rapid_delim">
  <option value=";">;</option>
  <option value=",">,</option>
  </select></td>
</tr>
<tr name="##driver_name##_##driver_type##" style="display:##display##;">
  <td>%%read_from%%:&nbsp;</td>
  <td colspan=2><input type="checkbox" name="skip_first_line"/></td>
</tr>
<tr name="##driver_name##_##driver_type##" style="display:##display##;">
  <td colspan=3>%%import_decription%%</td>
</tr>
"-->
