##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
function listAttachHandler(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id && oList[i].id_file){
            window.open(top.editorBaseHref + 'ftpgetfile.php?module=files&id=' + oList[i].id_file);
        }
    }
}
AMI.PartialAsync.init({
    actions: {
        'list_edit'         : 'edit',
        'list_print'        : 'print',
        'list_reply'        : 'reply',
        'list_attach'       : listAttachHandler,
        'list_attach-off'   : false,
        'list_delete'       : 'del'
    },
    groupActions: {
        grp_delete: 'del'
    },
    // blankActions: ['print'],
    scrollToForm: ['edit', 'save', 'reply'],
    confirms: {'list_delete' : '%%list_confirm_deletion%%'}
});
</script>
"-->


