%%include_language "templates/lang/pager.lng"%%

<!--#set var="first_new"     value="<a href="##link##" title="%%first%%"><span class=pager_num>##page##</span></a> ..."-->
<!--#set var="last_new"     value="... <a href="##link##" title="%%last%%"><span class=pager_num>##page##</span></a>"-->
<!--#set var="prev_new"     value="<a href="##link##" title="%%prev%%"><span  class=pager_move>&laquo;</span></a>"-->
<!--#set var="next_new"     value="<a href="##link##" title="%%next%%"><span class=pager_move>&raquo;</span></a>"-->
<!--#set var="active_new"   value="<span class=pager_active title="%%active%%">##page##</span>"-->


<!--#set var="first"     value="<a href="##link##"><span class=pager_num>##page##</span></a> ..."-->
<!--#set var="last"     value="... <a href="##link##"><span class=pager_num>##page##</span></a>"-->
<!--#set var="prev"     value="<a href="##link##"><span  class=pager_move>&laquo;</span></a>"-->
<!--#set var="next"     value="<a href="##link##"><span class=pager_move>&raquo;</span></a>"-->
<!--#set var="active"   value="<span class=pager_active>##page##</span>"-->
<!--#set var="page"     value="<a href="##link##"><span class=pager_num>##page##</span></a>"-->
<!--#set var="spacer"   value="&nbsp;"-->
<!--#set var="page_size_row" value="
<option value="##value##" ##active##>##caption##</option>
"-->
<!--#set var="page_size" value="
<span>%%page_size%%:</span>
<select name="limit" class="pager-select" onChange="go_pagesize(this.value)">
   ##data##
</select>
"-->
<div class=pager>
##--first--####--prev--####--page_before_active--####--active--####--page_after_active--####--next--####--last--####body##&nbsp;##page_size##
</div> 