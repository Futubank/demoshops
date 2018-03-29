##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_res_email_inst.lng"%%
%%include_template "templates/_icons.tpl"%%
%%include_template "templates/hst_res_inst_list.tpl"%%

<!--#set var="icon_mailmanage_purge" value="
<a href="javascript:" onClick="if(confirm('%%purge_mbox_confirm%% \'##email##\' ?')) {user_click('purge','##purge_id##');} return false;"><img alt="%%icon_purge%%" class=icon src="skins/vanilla/icons/icon-default.gif"></a>
"-->
