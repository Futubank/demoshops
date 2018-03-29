##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
if(!document.getElementById("condition_global")){
    AMI.Message.removeListener('ON_AMI_LIST_SHOW_ADD_BUTTON');
}

function listCopy(params){
    if(confirm('%%list_confirm_copy%%')){
        var oList = params.oComponent.getListData().data.list;
        for(var i = 0, q = oList.length; i < q; i++){
            if(oList[i].id == params.oParameters.id){
                user_click('copy', oList[i].id);
            }
        }
    }
}

function listDelete(params){
    if(confirm('%%list_confirm_deletion%%')){
        var oList = params.oComponent.getListData().data.list;
        for(var i = 0, q = oList.length; i < q; i++){
            if(oList[i].id == params.oParameters.id){
                user_click('del', oList[i].id);
            }
        }
    }
}

function listSelect(params){
    var destForm = top.document.forms['eshop_form'];
    if(destForm.id_discount.value != params.oParameters.id){
        fireEvent2(destForm.id_discount, 'change', top.document);
    }
    destForm.id_discount.value = params.oParameters.id;
    closeDialogWindow();
}

function listActionPublish(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id){
            publish(oList[i].id, oList[i].public.enabled == 1 ? 'off' : 'on');
            break;
        }
    }
    return false;
}

AMI.PartialAsync.init({
    actions: {
        list_public: listActionPublish,
        list_un_public: listActionPublish,
        list_edit: 'edit',
        list_copy: listCopy,
        list_delete: listDelete,
        list_active: listSelect
    },
    groupActions: {
        grp_copy: 'copy',
        grp_delete: 'del',
        grp_public: 'publish_on',
        grp_unpublic: 'publish_off',
    },
    scrollToForm: ['edit', 'save']
});
</script>
"-->
