##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">

function listCopy(params){
    if (confirm(AMI.Template.Locale.get('list_confirm_copy'))){
        var oList = params.oComponent.getListData().data.list;
        for(var i = 0, q = oList.length; i < q; i++){
            if(oList[i].id == params.oParameters.id){
                user_click('copy', oList[i].id);
            }
        }
    }
}

function listDelete(params){
    if (confirm(AMI.Template.Locale.get('list_confirm_deletion'))){
        var oList = params.oComponent.getListData().data.list;
        for(var i = 0, q = oList.length; i < q; i++){
            if(oList[i].id == params.oParameters.id){
                user_click('del', oList[i].id);
            }
        }
    }
}

AMI.PartialAsync.init({
    actions: {
        list_edit:    'edit',
        list_copy:    listCopy,
        list_delete:  listDelete
    },

    groupActions: {
        grp_delete: 'del'
    },

    scrollToForm: ['edit', 'save']
});
</script>
"-->
