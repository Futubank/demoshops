##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
function listDefaultHandler(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id && !oList[i].is_default.enabled){
            user_click('default', oList[i].id);
        }
    }
}
function listShowHandler(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id){
            if(parseInt(oList[i].p_id) > 0){
                window.open(oList[i].p_script_link);
            }else{
                alert('%%view_warn_no_pages%%');
            }
        }
    }
}
function listRestoreHandler(params){
    if(confirm('%%restore_warn%%')){
        var oList = params.oComponent.getListData().data.list;
        for(var i = 0, q = oList.length; i < q; i++){
            if(oList[i].id == params.oParameters.id){
                user_click('restore', oList[i].id);
            }
        }
    }
}
function listBackupHandler(params){
    if(confirm('%%backup_warn%%')){
        var oList = params.oComponent.getListData().data.list;
        for(var i = 0, q = oList.length; i < q; i++){
            if(oList[i].id == params.oParameters.id){
                user_click('backup', oList[i].id);
            }
        }
    }
}
function listDeleteHandler(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id){
            if(oList[i].is_default.enabled){
                alert('%%default_layout_del%%');
            }else{
                openDialog('%%are_you_sure%%', 'layouts.php?action=del&id=' + oList[i].id, 540, 200);
            }
        }
    }
}

AMI.PartialAsync.init({
    actions: {
        'list_is_default': listDefaultHandler,
        'list_un_is_default': listDefaultHandler,
        'list_show': listShowHandler,
        'list_copy': 'copy',
        'list_edit': 'edit',
        'list_restore': listRestoreHandler,
        'list_backup': listBackupHandler,
        'list_delete': listDeleteHandler
    },
    groupActions: [],
    scrollToForm: ['edit', 'copy', 'restore', 'backup'],
});
</script>
"-->
