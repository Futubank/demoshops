##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="col_cat_name" value="
<a href='#' onClick="var oFilter = AMI.Page.aModules['##mod_id##'].getComponentsByType('form_filter')[0].oDOMElement; oFilter.elements['category'].value = '##id##'; oFilter.onsubmit(); return false;">##name##&nbsp;&raquo;</a>
"-->

<!--#set var="javascript" value="
AMI.Message.addListener('ON_AMI_LIST_ROW', function(oComponent, oParameters){
    if(isNaN(oParameters.data.id_parent) || parseInt(oParameters.data.id_parent) <= 0){
        delete(oParameters.data.actions['delete']);
        delete(oParameters.data.actions['external_link']);
    }
});
"-->
