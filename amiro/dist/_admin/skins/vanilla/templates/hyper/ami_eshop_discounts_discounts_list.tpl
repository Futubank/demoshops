##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="javascript" value="
AMI.Message.addListener('ON_AMI_LIST_ROW', function(oComponent, oParameters){
    if(oParameters.data.cond_orig == 'global'){
        delete(oParameters.data.actions['copy']);
    }
});
"-->
