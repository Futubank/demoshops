##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
AMI.Message.addListener(
    'ON_PAGE_CONTENT_RECEIVED',
    function(action, oActionData){
        if(document.getElementById("add_new_button")){
            document.getElementById("add_new_button").innerHTML = '<span class="text_button" onclick="window.open(\'subs_list.php?action=export&tid=##tid##&lang_data=' + dataLanguage + '\')">%%export%%</span>';
        }
        return true;
    }
);

function listEdit(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id){
            user_click('edit', oList[i].id_member);
        }
    }
}

function listActivate(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id){
            activate(oList[i].id_member, 'on');
        }
    }
}

function listDeActivate(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id){
            activate(oList[i].id_member, 'off');
        }
    }
}

function listReset(params){
    if (confirm('%%reset_pass_warn%%')){
        var oList = params.oComponent.getListData().data.list;
        for(var i = 0, q = oList.length; i < q; i++){
            if(oList[i].id == params.oParameters.id){
                user_click('reset', oList[i].id_member);
            }
        }
    }
}

function listDelete(params){
    if (confirm('%%delete_warn%%')){
        var oList = params.oComponent.getListData().data.list;
        for(var i = 0, q = oList.length; i < q; i++){
            if(oList[i].id == params.oParameters.id){
                user_click('del', oList[i].id_member);
            }
        }
    }
}

AMI.PartialAsync.init({
    actions: {
        list_active: listActivate,
        list_un_active: listDeActivate,
        list_edit: listEdit,
        list_reset: listReset,
        list_delete: listDelete
    },
    groupActions: [],
    scrollToForm: module50action == 'edit' ? true : false
});
</script>
"-->
