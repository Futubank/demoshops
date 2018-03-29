<!--#set var="js_files" value="

var numFiles = '##num_files##';

function Init() {

  var editorBaseHref = top.editorBaseHref;

  top.document.forms['eshop_form'].file_ids.value = document.pagersform.file_ids.value;
  top.document.forms['eshop_form'].num_files.value = numFiles;
  if(numFiles > 0) {
    top.document.getElementById("div_eshop_digitals_icon_add").style.display="none";
    top.document.getElementById("div_eshop_digitals_icon_edit").style.display="inline";
  } else {
    top.document.getElementById("div_eshop_digitals_icon_add").style.display="inline";
    top.document.getElementById("div_eshop_digitals_icon_edit").style.display="none";
  }
}

function freedownload(id, act){
  var sform = document.forms["pagersform"];
  var link = _cms_script_link;

  sform.action.value = 'free_download';
  sform.free_download.value = act;
  sform.id.value = id;
  document.location = link + collect_link(sform);

  return false;
}

function prepareFileIds()
{
    var re1 = /^;/;
    var re2 = /;$/;
    var re3 = /;/g;
    var ids = document.forms[_cms_document_form].elements[_groupFieldName].value.replace(re1, '').replace(re2, '').replace(re3, ',');
    document.forms[_cms_document_form].elements['file_ids'].value += (document.forms[_cms_document_form].elements['file_ids'].value == '' ? '' : ',') + ids;
}

"-->

<!--#set var="edit_icon" value="&nbsp;<a href="javascript:void(0);" onclick="return editFile(##id##);" title="%%edit_file%%">%%edit%%</a>&nbsp;|
"-->



<!--#set var="selected_row" value="
<tr bgcolor="##bgcolor##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)">
<td width="60" align="center">##ficon##
</td>
<td width="30" align=center>##active##</td>
<td align="center">##free_download_icon##</td>
<td align="left">##file_name_short##</td>
<td align="left">##name##&nbsp;</td>
<td align=right>##size##&nbsp;</td>
<td width="120" align="right"><nobr>##fcdate##</nobr><br><nobr>##fmdate##</nobr></td>
<td align=right><div align="right">##edit_icon##
&nbsp;<a href="javascript:void(0);" onclick="return removeFile(##id##);" title="%%remove_file%%">%%remove_file%%</a>&nbsp;|&nbsp;<a href="javascript:void(0);" onclick="return deleteFile(##id##);">%%delete_force%%</a>&nbsp;
</td>
</tr>
"-->

<!--#set var="selected_files_header" value="
  <tr>
    <td class="first_row_left_td" width="60">
     %%ftype%%
    </td>
    <td class="first_row_all" width="30">&nbsp;</td>
    <td class="first_row_all" width="60">
     %%free_download%%
    </td>
    <td class="first_row_all" width="200">
     %%fname%%
    </td>
    <td class="first_row_all">
     %%name%%
    </td>
    <td class="first_row_all" width="80">
     %%fsize%%
    </td>
    <td class="first_row_all" width="120">
     %%fcdate%%<br>%%fmdate%%
    </td>
    <td class="first_row_all" width="250">
     %%actions%%
    </td>
  </tr>
"-->

<!--#set var="selected_files_list" value="
    <table border="0" width="100%" cellspacing="0" cellpadding="0">
      ##selected_files_header##
      ##selected_files##
    </table>
"-->

<!--#set var="selected_files_list_empty" value="
<tr>
  <td align="center">
  <h3>%%selected_list_empty%%</h3>
  </td>
</tr>
"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - %%title%%</TITLE>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css" />
<link rel="stylesheet" href="##skin_path##_css/scroll_bars.css" type="text/css" />
<script type="text/javascript">
var editorBaseHref = '##root_path_www##';
</script>
##scripts##
<script type="text/javascript">

##images_preload##

function HandleError(message, url, line) {
  return true;
}


##js_functions##

function moveToList(id) {
  document.pagersform.elements["id"].value=id;
  document.pagersform.elements["action"].value="move";
  document.pagersform.submit();
  return false;
}

function removeFile(id) {
  if(confirm('%%remove_confirm%%')) {
    document.pagersform.elements["id"].value=id;
    document.pagersform.elements["action"].value="remove";
    document.pagersform.submit();
  }
  return false;
}

function editFile(id) {
  document.pagersform.elements["id"].value=id;
  document.pagersform.elements["action"].value="edit";
  document.pagersform.submit();
  return false;
}

function deleteFile(id) {
  if(confirm('%%delete_confirm%%')) {
    document.pagersform.elements["id"].value=id;
    document.pagersform.elements["action"].value="del";
    document.pagersform.submit();
  }
  return false;
}

function filenameChanged(el) {
  setcheckbox(document.forms.filesForm.ftype, getfiletype(el.value), document.forms.filesForm.ftype.options.length - 1);
  return true;
}

function applyForm() {
  top.document.forms['eshop_form'].file_ids.value = document.pagersform.file_ids.value;
  top.document.forms['eshop_form'].num_files.value = numFiles;
  closeDialogWindow();
  return false;
}

</script>
</HEAD>

<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">

<table cellspacing="0" cellpadding="10" align="center" width=100% id="popup_content">
  <tr>
    <td>
    <div>##status##</div>
    <br>
    <h3>%%selected_files_list%%</h3><br>
    ##selected_files_list##
    <br>
    <nobr>
    <BUTTON class="but" ID=btnOK onClick="applyForm();" tabIndex=50>&nbsp;&nbsp;&nbsp;%%close_btn%%&nbsp;&nbsp;&nbsp;</BUTTON>
    </nobr>
    </td>
   </tr>
   <tr>
    <td align="center">##form##</td>
   </tr>
   <tr>
    <td>

    <br><br><br>
    <h3>%%files_list%%</h3>
    ##list_table##
    </td>
  </tr>
</table>
<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'filesForm';
var _cms_script_link = '##script_link##?';


//-->
</script>

  <form action="##script_link##" method=post name="pagersform">
  ##filter_hidden_fields##
  ##form_common_hidden_fields##
  <input type="hidden" name="file_ids" value="##file_ids##">
  <input type="hidden" name="itemId" value="##item_id##">
  <input type="hidden" name="free_download" value="">
  <input type="hidden" name="activate" value="">
  </form>

<script>
 Init();
 InitForm();
</script>


</BODY>
</HTML>
