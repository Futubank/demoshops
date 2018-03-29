##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/srv_tags.lng"%%
%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/_buttons.lng"%%
%%include_language "templates/lang/_common_items.lng"%%
%%include_language "templates/lang/_common_msgs.lng"%%
%%include_language "templates/lang/_menu_all.lng"%%
%%include_template "templates/_icons.tpl"%%



<!--#set var="icons_grp_apply"    value="<input type=button class=but value="%%apply_btn%%" onClick="ApplyItems();">"-->




<!--#set var="is_default" value="<img class="icon" src="skins/vanilla/icons/icon-ok.gif" border="0" helpId="btn_is_default" />"-->
<!--#set var="nbsp" value="&nbsp;"-->

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
    <td class="row1" align="center"><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
    ##_group_operations_col##
##--    <td width="30" align="center">##is_default##</td>--##
    <td><div id="tag##id##">##tag##</div>&nbsp;</td>
    <td align="center" nowrap="nowrap" width="80">
      ##action_select##
    </td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div width="100%" align="right" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
##_positions_data##


<script>
<!--

function selectItemFromPopup(form, id, isClose)
{
    var tag = document.getElementById('tag'+id).innerHTML;
    var srcForm = document.forms['group_operations_form'];
    var destForm = top.document.forms['##form_name##'];

    var tag_reg = new RegExp("^\s*"+tag+"\s*\,|,\s*"+tag+"\s*$|^\s*"+tag+"\s*$|,\s*"+tag+"\s*\,");
    if (!tag_reg.test(destForm.srv_tags.value)) {
      if (destForm.srv_tags.value != "") {
        destForm.srv_tags.value += ","
      }
      destForm.srv_tags.value += tag;
    }
    if (isClose == undefined) {
      closeDialogWindow();
    }
}

function deleteItemFromPopup(form, id, isClose)
{
    var tag = document.getElementById('tag'+id).innerHTML;
    var srcForm = document.forms['group_operations_form'];
    var destForm = top.document.forms['##form_name##'];

    if (destForm.srv_tags.value.indexOf(tag) >= 0) {
        tag = tag.replace(/([.*\\\/?\[\]\{\}\_\-])/g, "\\$1");
        var rx = '(^|,)' + tag + '(,|$)';
        var rx = new RegExp(rx, "ig");
        destForm.srv_tags.value = destForm.srv_tags.value.replace(rx, ',');
        destForm.srv_tags.value = destForm.srv_tags.value.replace(/^,/, '');
        destForm.srv_tags.value = destForm.srv_tags.value.replace(/,$/, '');
    }
    if (isClose == undefined) {
      closeDialogWindow();
    }
}

function ApplyItems() {
  var destForm = top.document.forms['##form_name##'];
  var numberSelected = document.forms[_cms_group_operations_form].elements['_grp_num_checked'].value;

    var oGrpForm = document.forms[_cms_group_operations_form];
    for (var i=0; i<oGrpForm.elements.length ;i++ ){
      if (oGrpForm.elements[i].checked) {
        if (oGrpForm.elements[i].name.substr(0, 9)=='group_id_') {
          selectItemFromPopup(oGrpForm, oGrpForm.elements[i].name.substr(9), true);
        }
      } else {
        if (oGrpForm.elements[i].name.substr(0, 9)=='group_id_') {
          deleteItemFromPopup(oGrpForm, oGrpForm.elements[i].name.substr(9), true);
        }
      }
    }

  closeDialogWindow();
  return false;
}

-->
</script>


    <form name="group_operations_form">
    <table width="100%" align="center" border="0" cellspacing="0" cellpadding="4">
    <tr>
        ##_group_operations_header##
        <td class="first_row_all list_name_col">
            ##sort_tag##
            %%tag%%
        </td>
        <td class="first_row_all" align="center" width="40">
            %%actions%%
        </td>
    </tr>
    ##list##
    </table>
##_group_operations_footer##
</form>

<a name="anchor"></a>
"-->