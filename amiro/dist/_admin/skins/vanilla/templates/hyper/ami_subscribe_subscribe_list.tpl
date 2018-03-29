##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="topics_column" value="<nobr>##value##</nobr><br>"-->
<!--#set var="subscribe_column" value="<nobr>##date##</nobr><br><nobr>##date_stop##</nobr><br>##ip##&nbsp;"-->

<!--#set var="javascript" value="
AMI.Message.addListener('ON_AMI_LIST_ROW', function(oComponent, oParameters){
    if(oParameters.data.id_member == currentElementId && module50action == 'edit'){
        oParameters.row.className = oParameters.row.className + ' onedit';
    }
});
"-->
