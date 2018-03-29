##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_filter.tpl"%%

<!--#set var="path_all_modules" value="
<a href="#" onclick="return AMI.DiscussionFilter.setModId('');"><b>%%path_all_modules%%</b></a> |
<a href="#" onclick="return AMI.DiscussionFilter.setModId('##ext_module##');"><b>##caption##</b></a>
"-->

<!--#set var="path_mod_item" value=" |
<b>##caption##</b>
(<a href="##url##">%%path_mod_item%%</a>)
"-->

##-- <!--#set var="path_reset_parent" value=" | <a href="#" onclick="return AMI.DiscussionFilter.setParentId(0);">%%reset_parent%%</a>"--> --##
<!--#set var="path_reset_parent" value="##IF(!popup)## | ##ENDIF##<a href="#" onclick="return AMI.DiscussionFilter.resetLevel();">%%reset_parent%%</a>"-->