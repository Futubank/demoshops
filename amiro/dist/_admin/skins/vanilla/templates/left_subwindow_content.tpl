##--!ver=0200 rules="-SETVAR|-IF"--##
%%include_language "templates/lang/content.lng"%%
<!--#set var="pm_link" value="
<p align="justify">
<a id="admin_link" href="##pm_link##"><b>%%to_edit%%</b></a>
%%to_edit2%%
</p>
"-->
<!--#set var="front_link" value="
##IF(script)##
<p>
<a id="front_link" href="##script##" target="_blank"><b>%%to_view%%</b></a>
%%to_view2%%
</p>
##ENDIF##
"-->
<!--#set var="front_link_np" value="
<p><font color="#ff0000">
%%lwin_front_link_np%%
</font></p>
"-->
<!--#set var="front_link_disabled" value="
<p align="justify"><font color="#ff0000">
%%lwin_front_link_disabled%%
</font></p>
"-->
<!--#set var="front_link_notfound" value="
<p align="justify"><font color="#ff0000">
%%lwin_front_link_notfound%%
<br>
<b><a href="##script##">%%click_here%%</a> %%do_now%%
</font></b></p>
"-->

##body##