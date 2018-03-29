%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/sys_users.lng"%%

<!--#set var="js_users" value="

var num_users = ##num_users##;

function Init() {

  var editorBaseHref = top.editorBaseHref;

  top.document.groupsform.user_ids.value = document.pagersform.user_ids.value;
  top.document.groupsform.num_users.value = num_users;
}

"-->

<!--#set var="selected_row" value="
<tr>
  <td class="##style##" align=center>##active##</td>
  <td class="##style##">##username##</td>
  <td class="##style##">&nbsp;##lastname##</td>
  <td class="##style##">&nbsp;##firstname##</td>
  <td class="##style##">##email##</td>
  <td class="##style##" nowrap>
##if(remove_ok=="1")##
  <a href="javascript:if(confirm('%%remove_confirm%%')) user_click('remove','##id##');"><img title="%%icon_remove%%" class=icon src="skins/vanilla/icons/icon-popup_del.gif"></a>
##endif##
  ##actions##
  </td>
</tr>
"-->

<!--#set var="selected_users_header" value="
  <tr>
    <td class="first_row_left_td" align="center">
     &nbsp;
    </td>
    <td class="first_row_all">
     %%username%%
    </td>
    <td class="first_row_all">
     %%orig_lastname%%
    </td>
    <td class="first_row_all">
     %%orig_firstname%%
    </td>
    <td class="first_row_all">
     %%email%%
    </td>
    <td class="first_row_all" align="center">
     %%actions%%
    </td>
  </tr>
"-->

<!--#set var="selected_users_list" value="
    <table border="0" width="100%" cellspacing="0" cellpadding="0">
      ##selected_users_header##
      ##selected_users##
    </table>
"-->

<!--#set var="selected_users_list_empty" value="
<tr>
  <td class=row1 align=center><h3>%%selected_users_empty%%</h3></td>
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

function applyForm() {
  top.document.groupsform.user_ids.value = document.pagersform.user_ids.value;
  top.document.groupsform.num_users.value = num_users;
  closeDialogWindow();
}

</SCRIPT>
</HEAD>

<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">

<br><div>##status##</div>
<table cellspacing="0" cellpadding="10" align="center" width=100% id="popup_content">
  <tr>
    <td valign=top width=50%>
    <h3>%%users_list%%</h3><br>
        ##filter##
    ##list_table##
    </td>
    <td valign=top width=50%>
    <h3>%%selected_users_list%%</h3><br>
    ##selected_users_list##
    </td>
   </tr>
  <tr>
   <td colspan=2>
    <BUTTON class="but" ID=btnOK onClick="applyForm();" tabIndex=50>&nbsp;&nbsp;&nbsp;%%close_btn%%&nbsp;&nbsp;&nbsp;</BUTTON>
   </td>
  </tr>
   <tr>
    <td align="left"  colspan=2>
    ##form##
    </td>
   </tr>
</table>
<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'users_form';
var _cms_script_link = '##script_link##?';

function OnObjectChanged_sys_users_popup(name, first_change, evt){
  return true;
}
addFormChangedHandler(OnObjectChanged_sys_users_popup);

-->
</script>

  <form action="##script_link##" method=post name="pagersform">
  ##filter_hidden_fields##
  <input type="hidden" name="groupId" value="##group_id##">
  <input type="hidden" name="user_ids" value="##user_ids##">
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
