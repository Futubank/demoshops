##--system info: module_owner="" module="" system="1"--##
%%include_language "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
AMI.Message.removeListener('ON_AMI_LIST_SHOW_ADD_BUTTON');
AMI.PartialAsync.init({
    actions: { list_show: 'view' },
    groupActions: [],
    scrollToForm: ['view']
});
</script>
"-->
