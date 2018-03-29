##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="javascript" value="
AMI.Message.addListener('ON_AMI_LIST_ROW', function(oComponent, oParameters){
    if(oParameters.data.id_file.toString() == "0"){
        oParameters.data.actions['attach'].value = oParameters.data.actions['attach'].value + '-off';
        oParameters.data.actions['attach'].title = '%%list_action_attach-off%%';
    }
});
"-->