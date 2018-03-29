%%include_language "templates/lang/adv_campaigns.lng"%%

<!--#set var="select_option" value="<option value="##value##" ##selected##>##name##</option>"-->

<script type="text/javascript">
<!--
    var _cms_document_form = 'advlinksstats';
    var _cms_document_form_changed = false;
    var _cms_script_link = '##script_link##?';
    var _cms_form_changed_alert = "%%form_changed%%";
-->
</script>

    <form action=##script_link## method=post enctype="multipart/form-data" name="advlinksstats" onSubmit="return CheckForm(this);">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
    </form>