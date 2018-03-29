<!--#set var="js_items" value="
function Init() {
  var editorBaseHref = top.editorBaseHref;
}

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
var _cms_document_form = 'pagersform';
var _cms_script_link = '##script_link##?';
</script>
##scripts##

<script type="text/javascript">

##images_preload##

function HandleError(message, url, line) {
  return true;
}


##js_functions##

function applyForm() {
  closeDialogWindow();
  return false;
}

</SCRIPT>
</HEAD>

<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">

##filter##
<table cellspacing="0" cellpadding="10" align="center" width=100% id="popup_content">
   <tr>
    <td>
    <BUTTON class="but" ID=btnOK onClick="applyForm();" tabIndex=50>&nbsp;&nbsp;&nbsp;%%close_btn%%&nbsp;&nbsp;&nbsp;</BUTTON><br><br>
    <h3>%%items%%</h3>
    ##list_table##
    </td>
  </tr>
</table>
<script type="text/javascript">
<!--
function OnObjectChanged_eshop_user_items_popup_def(name, first_change, evt){
  return true;
}
addFormChangedHandler(OnObjectChanged_eshop_user_items_popup_def);

-->
</script>

  <form action="##script_link##" method=post name="pagersform">
  ##filter_hidden_fields##
  <input type="hidden" name="userId" value="##user_id##">
  <input type="hidden" name="id" value="##id##">
  <input type="hidden" name="action" value="##action##">
  </form>

<script>
 Init();
 InitForm();
</script>


</BODY>
</HTML>
