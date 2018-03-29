##--system info: module_owner="" module="" system="1"--##
%%include_language "templates/lang/modules/_pagination.lng"%%

##-- pagination { --##

<!--#set var="first"    value="<a href="##link##" title="%%first%%"><span class=page_num>##page##</span></a> ..."-->
<!--#set var="last"     value="... <a href="##link##" title="%%last%%"><span class=page_num>##page##</span></a>"-->
<!--#set var="prev"     value="<a href="##link##" title="%%prev%%"><span class=page_move>&laquo;</span></a>"-->
<!--#set var="next"     value="<a href="##link##" title="%%next%%"><span class=page_move>&raquo;</span></a>"-->
<!--#set var="active"   value="<span class=page_active title="%%active%%">##page##</span>"-->
<!--#set var="page"     value="<a href="" data-ami-action="gotoPage" data-ami-parameters="offset=##offset##" class="amiModuleLink">##page##</a>"-->
<!--#set var="spacer"   value="&nbsp;"-->

<!--#set var="page_size_row" value="<option value="##value##" ##active##>##caption##</option>"-->
<!--#set var="page_size" value="
    <span>%%page_size%%:</span><select name="limit" class="pagination-select" onChange="AMI.Page.doModuleAction('##_mod_id##', '##_root_component_id##', 'changePageNumber', this);">##data##</select>
"-->

<!--#set var="pagination" value="
    <div class=pagination>##body##&nbsp;##page_size##</div>
"-->

##-- } pagination --##
