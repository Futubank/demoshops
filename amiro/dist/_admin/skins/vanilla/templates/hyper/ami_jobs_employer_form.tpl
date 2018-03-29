##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
AMI.Message.removeListener('ON_AMI_LIST_SHOW_ADD_BUTTON');
AMI.PartialAsync.init({
    actions: {
        'list_edit'         : 'edit',
        'list_print'        : 'print',
        'list_reply'        : 'reply'
    },
    groupActions: [],
    blankActions: ['print'],
    scrollToForm: ['edit', 'save', 'reply']
});
</script>
"-->
