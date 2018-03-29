##--!ver=0200 rules="-SETVAR"--##

<script type="text/javascript">
<!--
var _cms_document_form = 'hst_subscriptions_popup_form';
var _cms_script_link = '##script_link##?';

function CheckForm() {
    return false;
}


//-->
</script>

    <form action=##script_link## method=post enctype="multipart/form-data" name="hst_subscriptions_popup_form" onSubmit="return CheckForm(window.document.hst_subscriptions_form);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
    </form>

<script type="text/javascript">
<!--
##fill_pkg_rows##
UpdateTotalCount();
ButtonAddActivation();
-->
</script>
