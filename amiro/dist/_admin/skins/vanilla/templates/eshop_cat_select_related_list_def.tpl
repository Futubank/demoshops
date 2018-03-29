<!--#set var="empty" value="
<script>
function changeCategory(id) {
  var sform = document.forms[_cms_document_form];
  var link = _cms_script_link;
  sform.action.value = '';
  document.location = link + collect_link(sform) + "&cat_id=" + id;
  return false;
}
</script>
##path##
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="icons_grp_apply"    value="<input type=button class=but value="%%apply_btn%%" onClick="ApplyItems();">"-->

<!--#set var="public_on"     value="<img title="%%icon_public_on%%" class=icon src="skins/vanilla/icons/icon-published.gif" border="0" helpId="btn_public">"-->
<!--#set var="public_off"    value="<img title="%%icon_public_off%%" class=icon src="skins/vanilla/icons/icon-notpublished.gif" border="0" helpId="btn_public">"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  <td width="30" align=center>##cat_public##</td>
  ##_picture_col##
##if(PARENT_COL=="1")##
  <td width="150">##parentname##&nbsp;</td>
##endif##
  <td width="240"><a href="" onClick="return changeCategory(##id##);">##name##</a></td>
  <td>##announce##&nbsp;</td>
##if(INSTRUCTIONS_ON=="1")##
  <td width="30" align="center">##instruct##&nbsp;</td>
##endif##
  ##counter_product_row##
</tr>
"-->

<!--#set var="list_body" value="
<SCRIPT LANGUAGE="JavaScript">
<!--
function ApplyItems() {
  var numberSelected = document.forms[_cms_group_operations_form].elements['_grp_num_checked'].value;
  top.document.forms[top._cms_document_form].elements['##custom_field_name##'].value = document.forms[_cms_document_form].elements[_groupFieldName].value;
  top.document.forms[top._cms_document_form].elements['##custom_field_name##_number'].value = numberSelected;
  if(numberSelected > 0) {
    top.document.getElementById('div_##custom_field_name##_add').style.display = 'none';
    top.document.getElementById('div_##custom_field_name##_edit').style.display = 'inline';
  } else {
    top.document.getElementById('div_##custom_field_name##_add').style.display = 'inline';
    top.document.getElementById('div_##custom_field_name##_edit').style.display = 'none';
  }
  closeDialogWindow();
  return false;
}

function changeCategory(id) {
  var sform = document.forms[_cms_document_form];
  var link = _cms_script_link;
  sform.action.value = '';
  document.location = link + collect_link(sform) + "&cat_id=" + id;
  return false;
}

//-->
</SCRIPT>

##_group_operations_script##

            <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><nobr>##path##</nobr>&nbsp;</td>
              <td align="right">##pager##</td>
            </tr>
            </table>
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
##_group_operations_header##
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_cat_public##
                </td>
                ##_picture_header##
##if(PARENT_COL=="1")##
                <td class="first_row_all" valign="middle" width="150">
                 %%parentname%%
                  ##sort_parentname##
                </td>
##endif##
                <td class="first_row_all list_name_col" width="240">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all">
                 %%announce%%
                  ##sort_announce##
                </td>
##if(INSTRUCTIONS_ON=="1")##
                <td class="first_row_all" width="30">
                ##sort_instruct##
                </td>
##endif##
                ##counter_product_header##
              </tr>
              ##list##
              </table>
##_group_operations_footer##
</form>

              <a name="anchor"></a>
"-->