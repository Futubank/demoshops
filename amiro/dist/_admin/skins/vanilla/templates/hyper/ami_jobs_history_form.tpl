##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
function listAttachHandler(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id && oList[i].id_file){
            window.open(top.adminBaseURL + 'ftpgetfile.php?module=files&id=' + oList[i].id_file);
        }
    }
}

function listMoveHandler(params){
    openDialog('%%popup_title%%', 'jobs_resume.php?popup=1&ext_module=jobs_history&id_ext_module=' +  + params.oParameters.id, '');
}

AMI.Message.removeListener('ON_AMI_LIST_SHOW_ADD_BUTTON');

AMI.PartialAsync.init({
    actions: {
        'list_edit'         : 'edit',
        'list_print'        : 'print',
        'list_reply'        : 'reply',
        'list_attach'       : listAttachHandler,
        'list_attach-off'   : false,
        'list_move'         : listMoveHandler,
        'list_move-off'     : false,
        'list_delete'       : 'del'
    },
    groupActions: {
        grp_delete          : 'del'
    },
    blankActions: ['print'],
    scrollToForm: ['edit', 'save', 'reply'],
    confirms: {'list_delete' : '%%list_confirm_deletion%%'}
});
</script>
"-->
