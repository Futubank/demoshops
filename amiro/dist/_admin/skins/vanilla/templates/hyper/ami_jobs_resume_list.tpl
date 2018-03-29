##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="department_column" value="##if(id)##<a href="#" onclick="if(AMI.Page.aModules['##_mod_id##']){var oFilter = AMI.Page.aModules['##_mod_id##'].getComponentsByType('form_filter')[0].oDOMElement; oFilter.elements['department'].value = ##id##; oFilter.onsubmit();} return false;">##endif####header####if(id)## &raquo;</a>##endif##"-->

<!--#set var="javascript" value="
AMI.Message.addListener('ON_AMI_LIST_ROW', function(oComponent, oParameters){
    if(oParameters.data.id_file.toString() == "0"){
        oParameters.data.actions['attach'].value = oParameters.data.actions['attach'].value + '-off';
        oParameters.data.actions['attach'].title = '%%list_action_attach_off%%';
    }
});
"-->