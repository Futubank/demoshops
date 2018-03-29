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
        list_public:    listActionPublish,
        list_un_public: listActionPublish,
        list_edit:      'edit',
        list_delete:    listActionDelete
    },
    groupActions: {
        grp_public:   'publish_on',
        grp_unpublic: 'publish_off',
        grp_delete:   'del'
    },
    scrollToForm: ['edit', 'save']
});
</script>
"-->
