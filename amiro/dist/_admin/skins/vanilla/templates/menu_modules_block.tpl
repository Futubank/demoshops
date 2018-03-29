##--!ver=0200 rules="-SETVAR|-IF"--##
<!--#set var="active_item" value="<tr class="submenu_##module##"><td class="menu-item-active##class_disabled##"##title_disabled##>##caption##</td></tr>"-->
<!--#set var="opened_item;standart_item" value="<tr class="submenu_##module##"><td class="menu-item##class_disabled##"##title_disabled##><a href="##script##" onclick="window.top.hideSubMenu()" target="_top"><img class="submenu__img" src="##root_path_www##_local/_admin/images/icons/##module##.gif" />##caption##</a></td></tr>"-->

<!--#set var="active_subitem" value="<tr class="submenu_##module##"><td class="menu-subitem-active##class_disabled##"##title_disabled##>##caption##</td></tr>"-->
<!--#set var="standart_subitem" value="<tr class="submenu_##module##"><td class="menu-subitem##class_disabled##"##title_disabled##><a href="##script##" onclick="window.top.hideSubMenu()" target="_top">##caption##</a></td></tr>"-->

<!--#set var="splitter" value="
        <tr class="submenu-splitter_##module##"><td class="menu_splitter"></td></tr>
"-->
<!-- MENU START -->
      <table cellspacing=0 cellpadding=0 border=0 class="menu-block">##items##</table>
<!-- MENU END -->