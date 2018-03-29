%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/modules_datasets_popup.lng"%%

<!--#set var="js" value="
var numObjects = '##objects_counter##', formName = top._cms_document_form;
"-->

<!--#set var="selected_row" value="
<tr class="row1" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)">
    <td width="30" align="center">##public##</td>
    <td><a href="pmanager.php?id=##id##" target="_blank">##name##</a>&nbsp;</td>
    <td width="150" align="right">##if(!is_sys)##<a href="javascript:void(0);" onclick="return removeFromList('##moduleName##', ##id##);" title="%%remove_from_list%%">%%remove_from_list%%</a>##endif##&nbsp;</td>
</tr>
"-->

<!--#set var="selected_objects_header" value="
<tr>
    <td class="first_row_all" width="30">&nbsp;</td>
    <td class="first_row_all">%%name%%</td>
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
<tr><td align="center"><h3>%%selected_list_empty%%</h3></td></tr>
"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css" />
<link rel="stylesheet" href="##skin_path##_css/scroll_bars.css" type="text/css" />
<script type="text/javascript">
var editorBaseHref = '##root_path_www##';
</script>
##scripts##
<script type="text/javascript">

function HandleError(message, url, line){
    return true;
}

##js##

function Init(){
    var editorBaseHref = top.editorBaseHref;
    top.document.forms[formName].##mode##_counter.value = numObjects;
}

function moveToList(id){
    document.pagersform.elements['id'].value = id;
    document.pagersform.elements['action'].value = 'move';
    document.pagersform.submit();
    return false;
}

function removeFromList(module, id){
    if(confirm('%%remove_from_list_confirm%%')){
        document.pagersform.elements['id'].value = id;
        document.pagersform.elements['action'].value = 'remove';
        document.pagersform.elements['targetModule'].value = module;
        document.pagersform.submit();
    }
    return false;
}

function applyForm(){
    top.document.forms[formName].##mode##_counter.value = numObjects;
    closeDialogWindow();
    return false;
}

</script>
</head>

<body id="bdy" leftmargin="0" topmargin="0" bgcolor="#ffffff">
<table cellspacing="0" cellpadding="10" align="center" width="100%" id="popup_content">
<tr>
    <td>
        <div>##status##</div><br />
        <h3>%%##mode##_list%% &quot;##module_caption##&quot;</h3><br />
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
var editor_enable = '##editor_enable##';
var _cms_document_form = 'emptyPagerForm';
var _cms_script_link = '##script_link##?';
</script>
<form action="##script_link##" method="post" name="pagersform">
##filter_hidden_fields##
##form_common_hidden_fields##
<input type="hidden" name="objectId" value="##objectId##" />
<input type="hidden" name="objectModule" value="##objectModule##" />
<input type="hidden" name="targetModule" value="" />
<input type="hidden" name="popup" value="1" />
</form>

<script type="text/javascript">
Init();
InitForm();
</script>

</BODY>
</HTML>
