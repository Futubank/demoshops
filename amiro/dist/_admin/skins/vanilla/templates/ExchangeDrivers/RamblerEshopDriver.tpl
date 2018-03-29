%%include_language "templates/ExchangeDrivers/lang/RamblerEshopDriver.lng"%%

<!--#set var="import_form" value="
"-->

<!--#set var="export_form" value="
<tr name="##driver_name##_##driver_type##" style="display:##display##;">
  <td colspan=3>%%export_decription%%</td>
</tr>
<tr name="##driver_name##_##driver_type##" style="display:##display##;">
  <td colspan=3>%%export_cat_field%%:&nbsp;
  ##if(export_category_field_error==1)##
      %%export_category_field_error%%
  ##else##
      ##export_category_field_name##
  ##endif##
  </td>
</tr>
"-->

<!--#set var="export_type_row" value="<option value=##type##>##name##</option>"-->
