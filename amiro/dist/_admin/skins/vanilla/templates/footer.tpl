##--!ver=0200 rules="-SETVAR|-IF"--##
%%include_language "templates/lang/main.lng"%%
</td>
</tr>
  <tr id="footerTR">
    <td>
      <div style="background:#e0e0e0;height:3px;margin-top:20px;"></div>
      <div style="background:#FFD68A;height:7px;width:200px;"></div>
      <div style="text-align:right;padding:10px;">
##--{copy=30}--##
            ##ADM_COPY_NAME##
##--//{copy=30}--##
         ##stat_agent##
      </div>
    </td>
  </tr>
</table>
</div>

<div id=popup_loading_content>
<table cellspacing=0 cellpadding=0 border=0 width=100% height=100% >
  <tr>
    <td style="vertical-align:center;text-align:middle;">
    <b>%%page_loading%%</b>
    </td></tr>
 </table>
</div>

<div id=sp_dialog style="border:2px outset;width:400px;position:absolute;left:350;top:200;padding:5px;display:none;background-color:#D4D0C8">
</div>

##--hidden_content--##

<script>
  if(typeof(BodyOnLoad)=="function"){
    BodyOnLoad();
  }
</script>
</body>
</html>