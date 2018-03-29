%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/relations.lng"%%
%%include_language "templates/lang/main.lng"%%


<!--#set var="js_relations" value="
var numRelations = '##relations_number##';
var formName = top._cms_document_form;
"-->

<!--#set var="selected_row" value="
<tr class="row1" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)">
    <td>##module##</td>
    <td width="30" align="center">##public##</td>
    <td width="140">##name##&nbsp;</td>
    <td>##announce##&nbsp;</td>
    <td width="150" align="right"><a href="javascript:void(0);" onclick="return removeFromList('##moduleName##', ##id##);" title="%%remove_from_list%%">%%remove_from_list%%</a>&nbsp;</td>
</tr>
"-->

<!--#set var="selected_objects_header" value="
  <tr>
    <td class="first_row_left_td">%%module%%</td>
    <td class="first_row_all" width="30">&nbsp;</td>
    <td class="first_row_all list_name_col" width="140">%%name%%</td>
    <td class="first_row_all">%%announce%%</td>
    <td class="first_row_all" width="150">%%actions%%</td>
  </tr>
"-->

<!--#set var="selected_objects_list" value="
    <table border="0" width="100%" cellspacing="0" cellpadding="0">
      ##selected_objects_header##
      ##selected_objects##
    </table>
"-->

<!--#set var="selected_objects_list_empty" value="
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
<TITLE>%%site_title%% - %%relations_list%%</TITLE>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css" />
<link rel="stylesheet" href="##skin_path##_css/scroll_bars.css" type="text/css" />
<script type="text/javascript">
var editorBaseHref = '##root_path_www##';
</script>
##scripts##

<script type="text/javascript">

##images_preload##

function HandleError(message, url, line)
{
    return true;
}

##js_relations##

function Init()
{
    var editorBaseHref = top.editorBaseHref;
    top.document.forms[formName].relations_number.value = numRelations;
}

function prepareFileIds()
{
}

function moveToList(id)
{
    document.pagersform.elements['id'].value = id;
    document.pagersform.elements['action'].value = 'move';
    document.pagersform.submit();
    return false;
}

function removeFromList(module, id)
{
    if(confirm('%%remove_from_list_confirm%%')) {
        document.pagersform.elements['id'].value = id;
        document.pagersform.elements['action'].value = 'remove';
        document.pagersform.elements['targetModule'].value = module;
        document.pagersform.submit();
    }
    return false;
}

function applyForm()
{
    top.document.forms[formName].relations_number.value = numRelations;
    closeDialogWindow();
    return false;
}

</SCRIPT>
</HEAD>

<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">
<table cellspacing="0" cellpadding="10" align="center" width="100%" id="popup_content">
<tr>
    <td>
        <div>##status##</div><br />
        <h3>%%relations_list%%</h3><br />
        ##selected_objects_list##<br />
        <nobr><button class="but" onClick="applyForm()" tabIndex="50">&nbsp;&nbsp;&nbsp;%%close_btn%%&nbsp;&nbsp;&nbsp;</button></nobr>
    </td>
</tr>
<tr><td>##form##</td></tr>
<tr>
    <td>
        <br /><br /><br />
        <h3>%%entities_list%%</h3><br />
        ##filter##<br />
        ##list_table##
    </td>
</tr>
</table>
<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'emptyPagerForm';
var _cms_script_link = '##script_link##?';
//-->
</script>
<form action="##script_link##" method="post" name="pagersform">
##filter_hidden_fields##
##form_common_hidden_fields##
<input type="hidden" name="objectId" value="##objectId##" />
<input type="hidden" name="objectModule" value="##objectModule##" />
<input type="hidden" name="targetModule" value="" />
<input type="hidden" name="popup" value="1" />
</form>

<script>
    Init();
    InitForm();
</script>

</BODY>
</HTML>
