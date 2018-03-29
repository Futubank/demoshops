##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
AMI.Message.removeListener('ON_AMI_LIST_SHOW_ADD_BUTTON');

function listActionActive(params){
    activate(params.oParameters.id, 'on');
}

function listActionUnactive(params){
    activate(params.oParameters.id, 'off');
}

AMI.PartialAsync.init({
    actions: { 
                list_edit: 'edit',
                list_reset_password: 'reset',
                list_delete: 'del',
                list_active: listActionActive,
                list_un_active: listActionUnactive
            },
    groupActions: {
        grp_delete: 'del',
        grp_active: 'active_on',
        grp_unactive: 'active_off',
        grp_reset_password: 'reset'
    },
    confirms: {
        list_delete: AMI.Template.Locale.get('list_confirm_deletion'),
        list_reset_password: AMI.Template.Locale.get('list_confirm_reset')
    },
    scrollToForm: ##if(id)##true##else##false##endif##
});
</script>
"-->
