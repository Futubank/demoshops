%%include_language "templates/lang/_default_layout.lng"%%

<!--#set var="simple_layout" value="
<!--%%header%%-->
&#35;&#35;init&#35;&#35;
<body leftmargin=0 topmargin=0>
<!--%%stat_agent%%-->
<div id=stat>&#35;&#35;stat_agent&#35;&#35;</div>
<table cellspacing=0 cellpadding=0 border=0 width=100% height=100%>
<tr><td valign=top id=lay_f1 height=100>
<!--%%first_block%%-->
&#35;&#35;lay_f1_body&#35;&#35;
</td></tr>
<tr><td valign=top id=lay_body height=100%>
<!--%%status_messages%%-->
&#35;&#35;status_messages&#35;&#35;
<!--%%main_block%%-->
&#35;&#35;lay_body_body&#35;&#35;
</td></tr>
</table>
</body>
<!--%%footer%%-->
&#35;&#35;end&#35;&#35;
"-->
