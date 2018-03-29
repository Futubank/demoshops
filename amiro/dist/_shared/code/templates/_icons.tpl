##--!ver=0200 rules="-SETVAR|-IF"--##
%%include_language "_shared/code/templates/lang/_icons.lng"%%


<!--#set var="edit" value="
  <a href="##front_script_link##?action=edit&id=##edit_id##&offset=##offset##">%%icon_edit%%</a><br>
"-->

<!--#set var="icon_none" value="
  <img class=icon src="images/spacer.gif" width=18 height=16>
"-->

<!--#set var="del" value="
  <a href="##front_script_link##?action=del&id=##del_id##&offset=##offset##" onClick="return confirm('%%delete_warn%%')">%%icon_del%%</a>
"-->

<!--#set var="public_on"     value="<img alt="%%icon_public_on%%" class=icon src="_img/icons/icon-published.gif" border="0">"-->

<!--#set var="public_off"     value="<img alt="%%icon_public_off%%" class=icon src="_img/icons/icon-notpublished.gif" border="0">"-->

<!--#set var="special_on;special_advanced_on"     value=""-->

<!--#set var="special_off;special_advanced_off"    value=""-->


##-- ============================= Legend Icons =================================== --##

<!--#set var="leg_edit"    value=""-->

<!--#set var="leg_del" value=""-->

<!--#set var="published"    value="<nobr><img alt="%%published%%" class=leg_icon src="_img/icons/icon-published_leg.gif" border="0"> - %%published%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="notpublished" value="<nobr><img alt="%%notpublished%%" class=leg_icon src="_img/icons/icon-notpublished_leg.gif"> - %%notpublished%%&nbsp;&nbsp;</nobr>"-->

<!--#set var="special"    value=""-->

<!--#set var="not_special" value=""-->