##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
function listActivate(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id){
	        activate(oList[i].id, oList[i].active.enabled == 1 ? 'off' : 'on');
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

AMI.PartialAsync.init({
    actions: {
	    list_edit: 'edit',
	    list_delete: listDelete,
	    list_active: listActivate,
	    list_un_active: listActivate,
    },
    groupActions: [],
    scrollToForm: module50action == 'edit' ? true : false
});
</script>
"-->
