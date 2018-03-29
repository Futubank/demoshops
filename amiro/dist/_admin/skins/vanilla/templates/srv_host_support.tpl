%%include_language "templates/lang/srv_host_support.lng"%%

%%message%% <a href="##url##" target="_blank">%%click_here%%</a>.
<form id="supportPageId" action="##url##" method="get" target="_blank"></form>
<script language="JavasSript" type="text/javascript">
document.getElementById('supportPageId').submit();
</script>
