##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
AMI.PartialAsync.init({
    actions: {
        list_edit:    'edit',
        list_delete:  'del'
    },
    groupActions: {
        grp_delete: 'del'
    },
    confirms: {
        list_delete: AMI.Template.Locale.get('list_confirm_deletion')
    },
    scrollToForm: ['edit', 'save']
});
</script>
"-->
