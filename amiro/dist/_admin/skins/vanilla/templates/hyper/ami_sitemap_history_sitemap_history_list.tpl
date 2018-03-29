##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="action" value="<nobr>##title####IF(file)## <a href=##file_url## target='_blank'>##file##»</a>##endif##</nobr>"-->

<!--#set var="javascript" value="
AMI.Message.removeListener('ON_AMI_LIST_SHOW_ADD_BUTTON');
"-->