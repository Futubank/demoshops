<!--#set var="js_references" value="
function Init(){
    var appliedChanges = AMI.$.parseJSON('##APPLIED_CHANGES##');

    top.document.forms['eshop_form'].##field_id##.value = document.pagersform.references.value;

    if(null == appliedChanges || 'undefined' == typeof(top.document.forms['eshop_form'].##field_id##_select)){
        return;
    }
    var
        oSelect = top.document.forms['eshop_form'].##field_id##_select,
        oOptions = oSelect.options,
        isMultiple = AMI.$(oSelect).attr('multiple');

    if(parseInt('##refref##') < 1 && parseInt('##refmulti##') < 1){
        appliedChanges.id = appliedChanges.name;
    }

    switch(appliedChanges.mode){
        case 'create':
            AMI.$(oSelect).append(
                '<option' + (appliedChanges.selected ? ' selected="selected"' : '') +
                ' value="' + appliedChanges.id + '">' + appliedChanges.name + '</option>'
            );
            break;
        case 'select':
        case 'update':
            var
                index = findOptionByRefValueIndex(oOptions, appliedChanges.id),
                current = document.pagersform.references.value;
            if(!isNaN(index)){
                if('update' == appliedChanges.mode){
                    oOptions[index].text = appliedChanges.name;
                }
                oOptions[index].selected =
                    appliedChanges.id == current ||
                    current.indexOf(';' + appliedChanges.id + ';') >= 0;
                if(!isMultiple && oOptions[index].selected){
                    oSelect.selectedIndex = index;
                }
            }
            break;
        case 'remove':
            var index = findOptionByRefValueIndex(oOptions, appliedChanges.id);
            if(appliedChanges.deleted){
                AMI.$(oSelect).find('option[value="' + appliedChanges.id + '"]').remove();
            }else{
                oOptions[index].selected = false;
            }
            break;
    }
    if(isMultiple){
        top.refreshMultiselect(oSelect);
    }
}

"-->

<!--#set var="selected_row" value="
<tr class="reference_table_tr" bgcolor="##bgcolor##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" vAlign="top">
  <td width="150">##name##&nbsp;</td>
  <td>##description##&nbsp;</td>
  <td width="60">##fdate##&nbsp;</td>
<td align=right width="300"><div align="right">
##if(REFERENCE_TYPE != "related_items" && REFERENCE_TYPE != "related_cats" && REFERENCE_TYPE != "date")##&nbsp;<a href="javascript:void(0);" onclick="return editReference(##id##, true);" title="%%edit_reference%%">%%edit%%</a>&nbsp;|##endif##&nbsp;<a href="javascript:void(0);" onclick="return removeReference(##id##);" title="%%remove_reference%%">%%remove_reference%%</a>&nbsp;|&nbsp;<a href="javascript:void(0);" onclick="return deleteReference(##id##);">%%delete_force%%</a>&nbsp;
</td>
</tr>
"-->

<!--#set var="selected_reference_header" value="
  <tr>
    <td class="first_row_left_td list_name_col" width="150">
      %%name%%
    </td>
    <td class="first_row_all">
     %%description%%
    </td>
    <td class="first_row_all" width="60">
     %%cdate%%
    </td>
    <td class="first_row_all" align="center" width="300">
     %%actions%%
    </td>
  </tr>
"-->

<!--#set var="selected_reference_list" value="
    <table border="0" width="100%" cellspacing="0" cellpadding="0">
      ##selected_reference_header##
      ##selected_reference##
    </table>
"-->

<!--#set var="selected_reference_list_empty" value="
<tr>
  <td align="center">
  <h3>%%selected_reference_empty%%</h3>
  </td>
</tr>
"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
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

function removeReference(id) {
  if(confirm('%%remove_confirm%%')) {
    document.pagersform.elements["id"].value=id;
    document.pagersform.elements["action"].value="remove";
    document.pagersform.submit();
  }
  return false;
}

function editReference(id, selected){
    if('undefined' == typeof(selected)){
        selected = false;
    }

    document.pagersform.elements["id"].value=id;
    document.pagersform.elements["action"].value="edit";
    document.pagersform.elements['selected'].value = selected ? 1 : '';
    document.pagersform.submit();

    return false;
}

function deleteReference(id) {
  if(confirm('%%delete_confirm%%')) {
    document.pagersform.elements["id"].value=id;
    document.pagersform.elements["action"].value="del";
    document.pagersform.submit();
  }
  return false;
}

function applyForm(){
    top.document.forms['eshop_form'].##field_id##.value = document.pagersform.references.value;
    closeDialogWindow();

    return false;
}

function findOptionByRefValueIndex(oOptions, index){
    for(var i in oOptions){
        if('undefined' != typeof(oOptions[i].value) && oOptions[i].value == index){
            return i;
        }
    }

    return null;
}

</script>
</head>
<body id="bdy" leftmargin="0" topmargin="0" bgcolor="#FFFFFF">

<table cellspacing="0" cellpadding="10" align="center" width=100% id="popup_content">
  <tr>
    <td align="right">
    <b>%%current_reference%%: ##referene_name##</b>
    </td>
   </tr>
  <tr>
    <td>
    <div>##status##</div>
    <br>
    <h3>%%selected_reference_list%% ##if(refmulti != "1")## %%selected_reference_list_one%% ##endif##</h3><br>
    ##selected_reference_list##
    <br>
    <nobr>
    <BUTTON class="but" ID=btnOK onClick="applyForm();" tabIndex=50>&nbsp;&nbsp;&nbsp;%%close_btn%%&nbsp;&nbsp;&nbsp;</BUTTON>
    </nobr>
    </td>
   </tr>
  <tr>
    <td>
    <br><br>
    <h3>%%reference_list%%</h3>
    ##filter##
    ##list_table##
    <br>
    </td>
  </tr>
   <tr>
    <td align="center">##form##</td>
   </tr>
</table>
<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'referenceForm';
var _cms_script_link = '##script_link##?';

function OnObjectChanged_eshop_reference_popup_def(name, first_change, evt){
  return true;
}
addFormChangedHandler(OnObjectChanged_eshop_reference_popup_def);

-->
</script>

<form action="##script_link##" method="post" name="pagersform">
    ##filter_hidden_fields##
    <input type="hidden" name="itemId" value="##item_id##" />
    <input type="hidden" name="refmulti" value="##refmulti##" />
    <input type="hidden" name="refref" value="##refref##" />
    <input type="hidden" name="reference_id" value="##reference_id##" />
    <input type="hidden" name="field_id" value="##field_id##" />
    <input type="hidden" name="references" value="##references##" />
    <input type="hidden" name="id" value="##id##" />
    <input type="hidden" name="action" value="##action##" />
    <input type="hidden" name="selected" value="" />
</form>

<script type="text/javascript">
 Init();
 InitForm();
</script>

</body>
</html>