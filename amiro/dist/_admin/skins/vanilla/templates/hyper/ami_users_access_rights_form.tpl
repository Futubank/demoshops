##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
function listActionActivate(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id){
            activate(oList[i].id, oList[i].active.enabled == 1 ? 'off' : 'on');
        }
    }
}

AMI.PartialAsync.init({
    actions: {
        list_active:         listActionActivate,
        list_un_active:      listActionActivate,
        list_edit:           'edit'
    },
    confirms: {
        list_delete: AMI.Template.Locale.get('list_confirm_deletion')
    },
    scrollToForm: ['edit', 'save']
});
</script>
"-->
