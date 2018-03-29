##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="query_column" value="<a href='##link##' target='_blank'>##value## &raquo;</a>"-->
<!--#set var="count_column" value="<a href='#' onclick="var oFilter = AMI.Page.aModules['##mod_id##'].getComponentsByType('form_filter')[0].oDOMElement; oFilter.elements['group'][1].checked = false; oFilter.elements['query'].value = '##value##'; oFilter.onsubmit(); oFilter.elements['query'].value = ''; oFilter.elements['header'].value = '##value##'; return false;" title="%%click_to_filter%%">&raquo;</a>"-->