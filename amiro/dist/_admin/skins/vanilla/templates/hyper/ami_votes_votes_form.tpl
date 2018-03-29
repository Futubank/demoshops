##--system info: module_owner="" module="" system="1"--##
%%include_language "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
AMI.PartialAsync.init({
    actions: { list_edit: 'edit', list_result: 'result', list_reset_num: 'reset' },
    groupActions: [],
    confirms: { list_reset_num: '%%reset_warn%%' },
    scrollToForm: ['edit', 'save', 'result'],
});
</script>
"-->
