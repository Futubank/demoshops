##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="msg_date" value="
<a href="?id=##msg_id##&action=reply&ext_module=##ext_module##&id_ext_module=##id_ext_module##" title="%%to_message%%"><span>##msg_date##</span>&nbsp;&raquo;</a><br />
%%from%%
##IF(msg_id_member)##
<a href="##members_link##id=##msg_id_member##&action=edit#anchor">##msg_author##&nbsp;&raquo;</a>
##ELSE##
##msg_author##
##ENDIF##
"-->

<!--#set var="module" value="<a href="#" onclick="return AMI.DiscussionFilter.setModId('##ext_module##');">##caption##&nbsp;&raquo;</a>"-->

<!--#set var="header" value="<a href="#" onclick="return AMI.DiscussionFilter.displayItemMessages('##ext_module##', ##id_ext_module##, ##id##);" title="%%display_all_messages%%">##caption##&nbsp;&raquo;</a>"-->

<!--#set var="answers" value="<a href="#" onclick="return AMI.DiscussionFilter.displayItemMessages('##ext_module##', ##id_ext_module##, ##id##);" title="%%display_all_messages%%">##count_children##&nbsp;/&nbsp;##count_public_children##&nbsp;&raquo;</a>"-->

<!--#set var="author" value="<a href="##url##id=##id_member##&action=edit#anchor" target="_blank">##author##&nbsp;&raquo;</a>"-->