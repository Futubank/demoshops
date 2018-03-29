##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%
%%include_language "templates/lang/hyper/ami_forum_forum_list.lng"%%

<!--#set var="topic" value="<a href="#" onclick="return AMI.ForumFilter.displayThread(##id_thread##, ##cat_id##, 'date_created', 'desc');" title="%%display_topic_messages%%">##topic##&nbsp;&raquo;</a>"-->

<!--#set var="author" value="<a href="##url##id=##id_member##&action=edit#anchor" target="_blank">##author##&nbsp;&raquo;</a>"-->

<!--#set var="last_message" value="<a href="?id=##msg_id##&action=reply&flt_id_thread=##id_thread##&id_thread=##id_thread####IF(cat_id)##&category=##cat_id####ENDIF##&flt_topics_only=0&topics_only=0" title="%%to_message%%"><span>##msg_date##</span>&nbsp;&raquo;</a><br />
<a href="?##--id=##msg_id##&--##flt_id_thread=##id_thread##&id_thread=##id_thread##&flt_topics_only=0&topics_only=0##IF(cat_id)##&category=##cat_id####ENDIF##" title="%%to_topic%%">##msg_topic##&nbsp;&raquo;</a><br />%%from%% ##if(msg_id_member)##<a href="##members_link##id=##msg_id_member##&action=edit#anchor" target="_blank">##msg_author##&nbsp;&raquo;</a>##else####msg_author####endif##"-->