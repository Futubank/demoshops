##--!ver=0200 rules="-SETVAR|-IF"--##
<!--#set var="nav_item" value="##splitter##<a href="##page_link##">##item##</a>"-->
<!--#set var="nav_splitter" value="&nbsp;&nbsp;|&nbsp;&nbsp;"-->

<!--#set var="path_item" value="##splitter##<a href="##page_link##">##item##</a>"-->
<!--#set var="path_item_active" value="##splitter##<b>##item##</b>"-->
<!--#set var="path_splitter" value="&nbsp;&nbsp;/&nbsp;&nbsp;"-->

<!--#set var="sibl_item" value="##splitter##<a href="##page_link##">##item##</a>"-->
<!--#set var="sibl_item_active" value="##splitter##<b>##item##</b>"-->
<!--#set var="sibl_splitter" value="&nbsp;&nbsp;/&nbsp;&nbsp;"-->

<!--#set var="path" value="
         ##path##
"-->
<!--#set var="nav_bar" value="
     <tr>
       <td align=center>
         ##nav_bar##
       </td>
     </tr>
"-->
<!--#set var="sibl_bar" value="
      <tr>
       <td>
         ##sibl_bar##
       </td>
     </tr>
"-->
<!--#set var="name" value="
      <tr>
       <td>
         <h3>##name##</h3>
       </td>
     </tr>
"-->
<!--#set var="body" value="
     <tr>
       <td>
         ##body##
       </td>
     </tr>
"-->
<!--{title=##page_name##}-->
<table width="100%" border="0" cellspacing="5" cellpadding="0" class="frm">
##path##
##nav_bar##
##sibl_bar##
##name##
##body##
</table>
