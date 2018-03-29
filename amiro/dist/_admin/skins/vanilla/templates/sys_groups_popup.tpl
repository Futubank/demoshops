%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/sys_groups.lng"%%

<!--#set var="js_groups" value="

var num_groups = ##num_groups##;

function Init() {

  var editorBaseHref = top.editorBaseHref;

  top.document.forms['users_form'].group_ids.value = document.pagersform.group_ids.value;
  top.document.forms['users_form'].num_groups.value = num_groups;
}

"-->

<!--#set var="selected_row" value="
<tr>
  <td class="##style##" align=center width="60">##is_default##</td>
  <td class="##style##" align=center>##guest##</td>
  <td class="##style##">##name##</td>
  <td class="##style##" align=right>##modules##</td>
  <td class="##style##" align=center>##login##</td>
  <td class="##style##" nowrap>
##if(remove_ok=="1")##
  <a href="javascript:if(confirm('%%remove_confirm%%')) user_click('remove','##id##');"><img title="%%icon_remove%%" class=icon src="skins/vanilla/icons/icon-popup_del.gif"></a>
##endif##
  ##actions##
  </td>
</tr>
"-->

<!--#set var="selected_groups_header" value="
      <tr>
        <td class="first_row_left_td" align="center">
         <nobr>%%is_default%%</nobr>
        </td>
        <td class="first_row_all" align="center">
         %%guest%%
        </td>
        <td class="first_row_all list_name_col" valign="middle">
         %%name%%
        </td>
        <td class="first_row_all" valign="middle">
         %%modules_header%%
        </td>
        <td class="first_row_all" align="center">
         %%login%%
        </td>
        <td class="first_row_all" align="center">
         %%actions%%
        </td>
      </tr>
"-->

<!--#set var="selected_groups_list" value="
    <table border="0" width="100%" cellspacing="0" cellpadding="0">
      ##selected_groups_header##
      ##selected_groups##
    </table>
"-->

<!--#set var="selected_groups_list_empty" value="
<tr>
  <td class=row1 align=center><h3>%%selected_groups_empty%%</h3></td>
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
var cms_version = '##cms_version##';
var interface_lang = '##admin_lang##';
var _cms_selected_layout_block;
var ceCSSFile = '##skin_path##_css/ce.css';
var ceDynamicCSSFile = '##skin_path##_css/dynamic.css';
var frontCSSFile = '##front_css_path##common.css';
var frontCustomCSSFile = '##front_css_path##default.css';
var specCSSFile = '##skin_path##_css/spec.css';
</script>
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

function applyForm() {
  top.document.forms['users_form'].group_ids.value = document.pagersform.group_ids.value;
  top.document.forms['users_form'].num_groups.value = num_groups;
  closeDialogWindow();
  return false;
}

</SCRIPT>
</HEAD>

<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">

    <div>##status##</div>
    <br>
<table cellspacing="0" cellpadding="10" width=100% id="popup_content" border=0>
  <tr>
    <td valign=top width=50%>
    <h3>%%groups_list%%</h3><br>
    ##filter##
    ##list_table##
    </td>
    <td valign=top width=50%>
    <h3>%%selected_groups_list%%</h3><br>
    ##selected_groups_list##
    </td>
  </tr>
  <tr>
   <td colspan=2>
    <BUTTON class="but" ID=btnOK onClick="applyForm();" tabIndex=50>&nbsp;&nbsp;&nbsp;%%close_btn%%&nbsp;&nbsp;&nbsp;</BUTTON>
   </td>
  </tr>
  <tr>
    <td align="left" colspan=2>
    ##form##
    </td>
  </tr>
</table>
<script type="text/javascript">
<!--
function OnObjectChanged_sys_groups_popup(name, first_change, evt){
  return true;
}
addFormChangedHandler(OnObjectChanged_sys_groups_popup);

-->
</script>

  <form action="##script_link##" method=post name="pagersform">
  ##filter_hidden_fields##
  <input type="hidden" name="userId" value="##user_id##">
  <input type="hidden" name="group_ids" value="##group_ids##">
  <input type="hidden" name="id" value="##id##">
  <input type="hidden" name="action" value="##action##">
  <input type="hidden" name="activate" value="">
  </form>

<script>
 Init();
 InitForm();
</script>


</BODY>
</HTML>
