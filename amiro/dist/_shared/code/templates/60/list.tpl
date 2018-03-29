##--system info: module_owner="modules" module="news" system="1"--##
%%include_language "templates/lang/60/list.lng"%%

##-- list { --##

##--
<!--#set var="action_icon_css" value="a.icon-##action## div{background: url(##url##) 0 0 no-repeat;}
"-->
--##

<!--#set var="list_action_inner" value=" <a class="amiModuleLink" data-ami-parameters="##parameters##" data-ami-action="list_##action##" href="">%%list_action_##action##%%</a>
"-->

<!--#set var="header" value="<thead>##header##</thead>"-->
<!--#set var="header_row" value="<tr>##header_row##</tr>"-->
<!--#set var="header_item" value="<th>##list_col_caption##</th>"-->

<!--#set var="body" value="<tbody>##body##</tbody>"-->
<!--#set var="body_row" value="<tr>##body_row##</tr>"-->
<!--#set var="body_item" value="<td>##list_col_value##</td>"-->
<!--#set var="body_item(list_col_name=front_view)" value="<td><a href="##list_col_value##" target="_blank">View on front</a></td>"-->


<!--#set var="footer" value=""-->

<!--#set var="list" value="##pagination1##<table class="list" border="1" cellspacing="0" cellpadding="4">##header####body####footer##</table>##pagination2##"-->

##-- } list --##

<!--#set var="data_ajax" value="##list##"-->
