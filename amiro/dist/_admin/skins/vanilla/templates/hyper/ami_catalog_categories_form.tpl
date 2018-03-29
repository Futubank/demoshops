##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
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

function listActionDelete(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id){
            openDialog('%%delete%%', 'eshop_cat.php?action=del&id=' + params.oParameters.id, 450, 230);
            break;
        }
    }
    return false;
}

function listExternalLink(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id){
            openDialog('%%external_link%%', 'eshop_cat.php?action=external_link&id=' + params.oParameters.id, 450, 200);
            break;
        }
    }
    return false;
}

AMI.PartialAsync.init({
    actions: {
        list_edit: 'edit',
        list_delete: listActionDelete,
        list_external_link: listExternalLink,
        list_public: listActionPublish,
        list_un_public: listActionPublish
    },
    groupActions: [],
    scrollToForm: ##if(id)##true##else##false##endif##
});
</script>
"-->
