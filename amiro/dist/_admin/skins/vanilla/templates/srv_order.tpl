%%include_language "templates/lang/_buttons.lng"%%
%%include_language "templates/lang/srv_order.lng"%%

<script>

  function checkOrder(cForm, cAction){
  
    var inputs = cForm.elements;
    var found = false;

    for(var i=0;i<inputs.length;i++)
     if ( inputs[i].type == "checkbox" && inputs[i].checked){
       found = true;
       break;
     }

     if(!found) alert('%%no_modules_selected%%');

    return found;
  }

</script>

<!--#set var="module_descr" value="
<div style="display:none" id=##name##_module_descr><p align=justify>##description##</p></div>
"-->
<!--#set var="module_descr_default" value="
<div id=descr_default style="display:none;">%%welcome%%</div>
<div id=module_descr style="padding-right:5px;padding-left:10px;color:#444444;position:absolute;">%%welcome%%</div>
"-->

<!--#set var="owner" value="
<tr><td valign=middle colspan=2>
<div style="border:1px #FFFFFF solid;padding:2px;" 
onmouseover=""
onmouseout="document.getElementById('module_descr').innerHTML=document.getElementById('descr_default').innerHTML">
<table  
onmouseover="if (document.getElementById('##name##_module_descr')) document.getElementById('module_descr').innerHTML = document.getElementById('##name##_module_descr').innerHTML"
width=100% cellspacing=o cellpadding=0 border=0><tr><td><img src="skins/vanilla/images/##name##_icon##type##.gif" border=0 width=54 height=48></td>
<td width=100% background="skins/vanilla/images/##name##_bg.gif" valign=middle nowrap style="padding-top:12px"><b>##caption##</b>&nbsp;</td>
<td><img src="skins/vanilla/images/##name##_end.gif"></td>
</table>

<div style="padding-left:20px">
##modules##
</span>

</div></td></tr>
"-->

<!--#set var="HSplitter" value=""-->
<!--#set var="VSplitter" value=""-->
<!--#set var="module" value="
<span style="width:160px;border:1px #FFFFFF solid;cursor:pointer;padding:2px" onclick="document.getElementById('fmod_##name##').checked=!document.getElementById('fmod_##name##').checked;" 
onmouseover="this.style.border='1px #c0c0c0 solid';if (document.getElementById('##name##_module_descr'])  document.getElementById('module_descr').innerHTML = document.getElementById('##name##_module_descr').innerHTML" 
onmouseout="this.style.border='1px #FFFFFF solid';document.getElementById('module_descr').innerHTML=document.getElementById('descr_default').innerHTML">
<nobr>
<input type="checkbox" name="fmod_##name##" value=1>
<img src="skins/vanilla/images/##imgname##_icon.gif" border=0 width=34 height=34 align=absmiddle>
##caption##</nobr></span>

"-->
<!--#set var="order_link" value=" onclick="window.location='##link##';" "-->

<!--#set var="empty" value="
<br>
<div width="100%"><h4 align=center>%%empty%%</h4></div>
"-->
<!--#set var="order_control" value="
  <tr>
    <td colspan=2><input type=submit value=" %%order%% " class=but>
    </td>
  </tr>      
"-->
<!--#set var="order_form" value="
  <tr>
    <td valign=top>
    <br>
    %%comments%%<br>
    <textarea name=finfo class=field rows=10 cols=30 ></textarea>
    </td>
    <td width=100% valign=top>
    <br>
    ##modules_descr##
    </td>
  </tr>      
"-->
<!--#set var="confirm_form" value="
  <tr>
    <td colspan=2>
    <input type=hidden name="action" value="##action##">
    <br>
    <table border=0 class="frm">
     <tr>
      <td nowrap>You have ordered </td><td nowrap><b>##num_modules##</b> module(s)</td>
     </tr>
     <tr>
      <td nowrap>With comments:</td><td>##comments##</td>
    </td>
  </tr>      
  <tr>
    <td colspan=2>
    <br><br>
    </td>
  </tr>      
  <tr>
    <td><input type=button value=" %%cancel_btn%% " class=but>
    </td>
    <td><input type=submit value=" %%confirm_btn%% " class=but>
    </td>
  </tr>      
"-->
<!--#set var="thanks" value="
<br>
<div width="100%"><h3 align=center>%%thanks%%</h3></div>
"-->

<form name="fform" method=post onSubmit="return checkOrder(fform, '##action##');">
 <input type=hidden name="action" value="##action##">
 <table border=0 cellpadding=0 cellspacing=10 width=100% class="frm">
  ##order_control##
  ##content##
  ##order_form##
  ##order_control##
 </table>
</form>
