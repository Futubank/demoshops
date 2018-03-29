%%include_language "templates/ExchangeDrivers/lang/RapidYandexEshopDriver.lng"%%

<!--#set var="import_form" value="
<script name="javascript">

function driverFunc_RapidYandexEshopDriver_import(action) {
    if (action == 'on') {
        rapid_yandex_to_dest_category();
    } else {
        document.forms[_cms_document_form].cat_id.disabled  = false;
    }
}

function rapid_yandex_to_dest_category() {
    if (document.forms[_cms_document_form].rapid_import_create_cat_arr.value == 'yandex_import_default') {
        document.forms[_cms_document_form].cat_id.disabled  = false;
    }
    else {
        document.forms[_cms_document_form].cat_id[0].selected = true;
        document.forms[_cms_document_form].cat_id.disabled  = true;
    }
}

function rapid_show_image_get(value) {
    if (value == 'import_img_download') {
        document.getElementById("##driver_name##_##driver_type##_image_get").style.display = "block";
        document.getElementById("##driver_name##_##driver_type##_image_time").style.display = "block";
    }
    else {
        document.getElementById("##driver_name##_##driver_type##_image_get").style.display = "none";
        document.getElementById("##driver_name##_##driver_type##_image_time").style.display = "none";
    }
}

</script>

<tr name="##driver_name##_##driver_type##" style="display:##display##;">
  <td colspan=3><b>%%import_description%%</b></td>
</tr>

##if(import_create_cat_arr_error==0)##
<tr name="##driver_name##_##driver_type##" style="display:##display##;">
  <td>%%import_create_cat_arr%%</td>
  <td>
  <select name="rapid_import_create_cat_arr" OnChange="rapid_yandex_to_dest_category();">
  ##import_create_cat_arr_rows##
  </select>
  </td>
</tr>
##endif##

##if(import_img_error==0)##
<tr name="##driver_name##_##driver_type##" style="display:##display##;">
  <td>%%import_img_type%%</td>
  <td colspan=2>
    <select name="rapid_import_img_type" OnChange="rapid_show_image_get(this.value);">
    ##import_img_type_rows##
    </select>
  </td>
</tr>
<tr name="##driver_name##_##driver_type##" style="display:##display##;">
  <td>&nbsp;</td>
  <td>
  <div id="##driver_name##_##driver_type##_image_get" style="display:;">
  %%import_img_get%%&nbsp;
  <select name="rapid_import_img_get">
  ##import_img_get_rows##
  </select>&nbsp;
  </div>
  <br>
  <div id="##driver_name##_##driver_type##_image_time" style="display:;">
  %%import_time_type%%&nbsp;
  <select name="rapid_import_time_type">
  ##import_time_type_rows##
  </select>&nbsp;
  </div>
  </td>
</tr>
##else##
<tr name="##driver_name##_##driver_type##" style="display:##display##;">
  <td>%%import_img_type%%</td>
  <td colspan=2>%%import_img_error%%</td>
</tr>
##endif##
"-->

<!--#set var="export_form" value="
<tr name="##driver_name##_##driver_type##" style="display:##display##;">
  <td>%%export_decription%%</td>
  <td colspan=2>
    ##if(export_type_error==0)##
    %%export_type%%
    <select name="export_type">
      ##export_type_rows##
    </select>
    ##else##
    <font color=red>%%export_type_error%%</font>
    ##endif##
  </td>
</tr>
"-->

<!--#set var="import_create_cat_arr_row" value="<option value=##type## ##select##>##name##</option>"-->

<!--#set var="import_img_type_row" value="<option value=##type##>##name##</option>"-->

<!--#set var="import_img_get_row" value="<option value=##type##>##name##</option>"-->

<!--#set var="import_time_type_row" value="<option value=##type##>##name##</option>"-->


<!--#set var="export_type_row" value="<option value=##type##>##name##</option>"-->
