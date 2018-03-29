##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_res_cms_inst.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="cms_copy" value="
<a href="javascript:" onClick="javascript:openDialog('%%title_copy%%', '##script_link##?action=copy&id=##copy_id##&type=popup', 680, 420); return false;"><img
    alt="%%icon_copy%%" class=icon src="skins/vanilla/icons/icon-copy.gif"></a>
"-->


%%include_template "templates/hst_res_inst_list.tpl"%%
