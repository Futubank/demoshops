##--!ver=0200 rules="-SETVAR|-IF"--##
<!--#set var="active_item" value="<tr><td class=menu-item-active>##caption##</td></tr>"-->
<!--#set var="opened_item" value="<tr><td class=menu-item-active>##caption##</td></tr>"-->
<!--#set var="standart_item" value="<tr><td class=menu-item><a href="##script##">##caption##</a></td></tr>"-->

<!--#set var="active_subitem" value="<tr><td class=menu-subitem-active>##caption##</td></tr>"-->
<!--#set var="standart_subitem" value="<tr><td class=menu-subitem><a href="##script##">##caption##</a></td></tr>"-->

<!--#set var="splitter" value="
        <tr><td class="menu_splitter"></td></tr>
"-->
<!-- MENU START -->
      <table cellspacing=0 cellpadding=0 border=0 class="menu">
      ##item_eshop_cat##
      ##item_eshop_item##
      ##item_eshop_user##
      ##item_eshop_order##

      ##splitter##

      ##item_exit##
      </table>
<!-- MENU END -->
