##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%
%%include_language "templates/lang/modules/data_exchange.lng"%%

<!--#set var="tab" value="
<div class="tab-page" id="tab-page-##name##" style="padding:10px;">
<table class="frm" cellspacing="5" cellpadding="0" border="0" width="100%">
##section_html##
</table>
</div>
"-->

<!--#set var="form_buttons" value="<div id="form-buttons">##add_btn##</div>"-->

<!--#set var="add_btn" value="<input type="submit" value="%%run_btn%%" class="but""/>
"-->

<!--#set var="hint_field(caption=import_tooltip)" value="
<tr><td colspan=3><div class="tooltip">%%import_tooltip%%</div></td></tr>
"-->

<!--#set var="select_field(name=import_driver)" value="
<tr><td colspan=3>
<table>
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:</td>
    <td><select name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##select##</select></td>
</tr>
"-->

<!--#set var="radio_field(name=data_source_type)" value="<tr><td></td><td>##select##"-->

<!--#set var="radio_field_row(name=data_source_type)" value="<input ##disabled## type="radio" id="##id##" name="##name##" ##checked## value="##value##" />&nbsp;"-->

<!--#set var="select_field(name=data_source_ftp)" value="
##element_caption####IF(validator_filled)##*##ENDIF##: <select name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##select##</select></td>
</tr>
</table>
</td></tr>
"-->

<!--#set var="data_source_ftp_caption" value="##title##    ##IF(file_size)####file_size## (##file_size_bytes## %%byte%%)##else##0 %%byte%%##endif##"-->

<!--#set var="section_form" value="
<script type="text/javascript">
##scripts##

var
    _cms_document_form = 'exchange_form',
    _cms_document_form_changed = false;

function CheckForm(form){
    var popupTitle,
        exchangeType = form.elements['exchange_type'].value;

    if(exchangeType == 'import'){
       popupTitle = '%%import_popup_title%%';

       if(form.elements["import_driver"].value == ''){
           alert('%%import_driver_warn%%');
           form.elements["import_driver"].focus();
           return false;
       }
       /*
       if(currDataSourceType == 'file'){
           ext = form.data_source_file.value.substring(form.data_source_file.value.lastIndexOf('.') + 1, form.data_source_file.value.length);
           ext = ext.toLowerCase();
           if(form.data_source_file.value=='' || (form.data_source_file.value!='' && !CheckExtension(ext))) {
               return focusedAlert(form.data_source_file, '%%file_warn%%');
           }
       }
       */
       var currDataSourceType = 'ftp';
       if(currDataSourceType == 'ftp'){
           if(form.elements["data_source_ftp"].value == ''){
               alert('%%data_source_ftp_warn%%');
               form.elements["data_source_ftp"].focus();
               return false;
           }
       }
    }

    //alert(collect_link(document.forms['exchange_form'], true));
    openExtDialog(popupTitle, 'photoalbum_data_exchange.php?popup=1&'+collect_link(document.forms[_cms_document_form], true), 0, 0, 550, 330, -1, -1, 1, 1);

    return false;
}

function switchCategoriesList(disabled){
  if(disabled){
    document.getElementById('id_page_cattype_1').disabled = false;
    if(document.getElementById('category_id')){
        document.getElementById('category_id').disabled = true;
    }
    document.getElementById('catname').disabled = true;
    document.getElementById('id_page_cattype_2').disabled = true;
  }else{
    document.getElementById('id_page_cattype_1').disabled = true;

    // Import to default category radio button
    var catname = document.getElementById('catname').value;
    if(document.getElementById('category_id')){
        document.getElementById('category_id').disabled = (catname != '');
    }
    document.getElementById('catname').disabled = false;
    document.getElementById('id_page_cattype_2').disabled = (catname == '');
  }
}

function OnObjectKeyUp(oElement) {
  if(oElement.name == 'catname') {
      if(typeof(oElement.form.cat_id) == 'object') {
          oElement.form.cat_id.disabled = (oElement.value != '');
      }
      if(typeof(oElement.form.id_page) == 'object') {
          document.getElementById('id_page_cattype_2').disabled = (oElement.value == '');
      }
  }
  return true;
}

if(typeof(document.forms[_cms_document_form].cat_id) == 'object'){
    switchCategoriesList();
}
</script>

<div id="div_properties_form" class="main-form">
	<table ccc="1" class="main-form__table data_exchange_form_table" border="0" cellpadding="0" cellspacing="0" ##if(width != '')##width="##width##"##endif## ##if(height != '')##height="##height##"##endif## style="margin-left:auto;margin-right:auto;">
		<tr class="properties_form_title">
			<td align=left id="add_left_top_img"></td>
			<td nowrap id="add_center_top_img">
				<span id="form_title" class="form-header">##header##</span>
			</td>
			<td nowrap id="add_right_info_top_img">
				<div id=stModified style="display:none;" class=form-header> [ %%modified%% ]</div>
			</td>
			<td id="add_right_top_img"></td>
		</tr>
		<tr>
			<td id="add_left_center_img"></td>
			<td colspan=2 class="table_sticker" valign="top">
<br>
<form action="##_mod_id##.php" method=get enctype="multipart/form-data" name="exchange_form" id="exchange_form" onsubmit="return CheckForm(this);">
<input type="hidden" name="action" value="run" />
<input type="hidden" name="ami_full" value="" />
<table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
<col class="first_column">
<col class="second_column">
##section_html##
</table>

<table cellspacing="0" cellpadding="0" border="0" class="frm" width=100%>
<col width="150">
<col width="*">
<tr>
<td colspan="2" align="right">
<br>
##form_buttons##
<br><br>
</td>
</tr>
<tr>
<td colspan="2">
 <sub>%%required_fields%%</sub>
</td>
</tr>
</table>
</form>
			</td>
			<td id="add_right_center_img"></td>
		</tr>
		<tr>
			<td id="add_left_bot_img"></td>
			<td id="add_center_bot_img" colspan=2></td>
			<td id="add_right_bot_img"></td>
		</tr>
	</table>
</div>
"-->
