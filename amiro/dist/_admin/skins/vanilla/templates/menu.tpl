<!--#set var="main_block" value="##content##&nbsp;&nbsp;"-->
<!--#set var="main_item" value="##splitter##
  ##if(have_submenu == "1" )## 
   <a name="v##id##" id="j##id##" href="##link##" onmouseover="show(##id##);" onmouseout="moff();">##name##</a>
  ##else## 
    <a href="##link##">##name##</a>
  ##endif##
##-- ##submenu## --##
##-- ##special## --##
"-->
<!--#set var="main_item_active" value="##splitter##
  ##if(have_submenu == "1" )## 
   <a name="v##id##" id="j##id##" href="##link##" onmouseover="show(##id##);" onmouseout="moff();">##name##</a>
  ##else## 
    <a href="##link##">##name##</a>
  ##endif##
##-- ##submenu## --##
##-- ##special## --##
"-->
<!--#set var="main_splitter" value="&nbsp;&nbsp;&nbsp;"-->


<!--#set var="sub_block" value="
<div id=g##parent_id## class=submenu>
<table border="0" cellspacing="0" cellpadding="5">
 <tr>
  <td bgcolor="#207A80" valign="top">
   <table border="0" cellspacing="0" cellpadding="2" width="110">
    <tr valign="top">
     <td align="left" valign="top" rowspan="2" class="pd_menu">
      <table border="0" cellspacing="2" cellpadding="0" align="left">
##content##
      </table></td>
    </tr>
   </table></td>
 </tr>
</table>
</div>
"-->
<!--#set var="sub_item" value="##splitter##<tr><td><nobr><a href="##link##"  onmouseover=mon() onmouseout=moff()><span class="a1">&bull; </span>##name##</a></nobr></td></tr>
"-->
<!--#set var="sub_item_active" value="##splitter##<tr><td><nobr><a href="##link##"  onmouseover=mon() onmouseout=moff()><span class="a1">&bull; </span>##name##</a></nobr></td></tr>
"-->
<!--#set var="sub_splitter" value=""-->


<!--#set var="special_block" value="
##content##
"-->
<!--#set var="special_item" value="hide('##id##');"-->
<!--#set var="special_item_active" value="hide('##id##');"-->


<!--#set var="bottom_block" value="
          <span class="top_links">
          ##content##&nbsp;&nbsp;
          </span>
"-->
<!--#set var="bottom_item" value="##splitter##<a href="##link##">##name##</a>"-->
<!--#set var="bottom_item_active" value="##splitter##<a href="##link##">##name##</a>"-->
<!--#set var="bottom_splitter" value="&nbsp;&middot;&nbsp;"-->
