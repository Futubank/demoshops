##--!ver=0200 rules="-SETVAR|-IF"--##
%%include_language "templates/lang/main.lng"%%

<script type="text/javascript">
<!--
//onChange="return CheckLen(this.value, ##date_maxlen##)"
function CheckLen(cobj, cmaxlen)
{
  if(cmaxlen > 0)
  if(cobj.length > cmaxlen) {
     alert('%%maxlen_warn_begin%% '+cobj.length+', %%maxlen_warn_sub%% '+cmaxlen+' %%maxlen_warn_end%%');
     return false;
  }
  return true;
}
//-->
</script>
