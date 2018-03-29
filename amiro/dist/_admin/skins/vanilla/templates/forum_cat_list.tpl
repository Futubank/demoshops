%%include_language "templates/lang/_categories.lng"%%
%%include_template "templates/_icons.tpl"%%
%%include_template "templates/_categories_list.tpl"%%
%%include_language "templates/lang/forum.lng"%%
%%include_language "templates/lang/forum_cat.lng"%%

<!--#set var="list_custom_fields_header" value="<td class="first_row_all">%%last_message%%&nbsp;</td><td class="first_row_all" width="50">%%counter_items%%</td>"-->
<!--#set var="list_custom_fields_row" value="<td class="td_small_text">##if(msg_id)##<a href="##forum_link##?id=##msg_id##&action=reply##flt_module_body_only##&flt_id_thread=##msg_id_thread##&flt_topics_only=0&flt_go_last_page=1" title="%%to_message%%"><span id="d##id##">##msg_date##</span><script>replaceDateTitle('d##id##')</script>&nbsp;&raquo;</a><br /><a href="##forum_link##?flt_id_thread=##msg_id_thread####flt_module_body_only##&flt_topics_only=0" title="%%to_topic%%">##msg_topic##&nbsp;&raquo;</a><br />%%from%%&nbsp;##if(msg_id_member)##<a href="##members_link##?id=##msg_id_member##&action=edit##flt_module_body_only###anchor">##msg_author##&nbsp;&raquo;</a>##else####msg_author####endif####else##&nbsp;##endif##</td>
<td align="right"><a href="##forum_link##?flt_id_thread=##msg_id_thread####flt_module_body_only##&flt_topics_only=0" title="%%to_topic%%">##num_items##/##num_public_items##&nbsp;&raquo;</td>
"-->

<!--#set var="list_custom_fields_row_separator" value="<td>&nbsp;</td><td>&nbsp;</td>
"-->

