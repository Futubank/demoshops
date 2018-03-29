##--!ver=0200 rules="-SETVAR"--##

<script type="text/javascript">
<!--
var _cms_document_form = 'hst_res_select_path_form';
var _cms_script_link = '##script_link##?';
var destFieldId = '##dest_field_id##';
<!--
function OnObjectChanged_hst_res_depend_form(name, first_change){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_hst_res_depend_form);

function CheckForm() {
    return false;
}


//-->
</script>

    <form action=##script_link## method=post enctype="multipart/form-data" name="hst_res_select_path_form" onSubmit="return CheckForm(window.document.hst_res_select_path_form);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
    </form>

