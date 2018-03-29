##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%
%%include_language "templates/lang/hyper/ami_forum_forum_cat_list.lng"%%

<!--#set var="last_message" value="<a href="##forum_link##id=##msg_id##&action=reply&flt_id_thread=##msg_id_thread##&id_thread=##msg_id_thread##&category=##id##&flt_topics_only=0&topics_only=0" title="%%to_message%%"><span>##msg_date##</span>&nbsp;&raquo;</a><br />
<a href="##forum_link##id=##msg_id##&flt_id_thread=##msg_id_thread##&id_thread=##msg_id_thread##&flt_topics_only=0&topics_only=0&category=##id##" title="%%to_topic%%">##msg_topic##&nbsp;&raquo;</a><br />
%%from%% ##if(msg_id_member)##<a href="##members_link##id=##msg_id_member##&action=edit#anchor" target="_blank">##msg_author##&nbsp;&raquo;</a>##else####msg_author####endif##"-->

<!--#set var="topics_messages" value="<a href="##forum_link##?flt_id_thread=##msg_id_thread##&id_thread=##msg_id_thread##&category=##id##&flt_topics_only=0&topics_only=0" title="%%to_topic%%">##num_items##/##num_public_items##&nbsp;&raquo;"-->