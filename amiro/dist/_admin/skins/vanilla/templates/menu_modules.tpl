<!--#set var="active_item" value="
    <tr class="submenu_##module##"><td class="menu-item menu-item-active##class_disabled##"##title_disabled##><a href="##script##">##caption##</a></td></tr>
"-->

<!--#set var="opened_item" value="##setglobalvar flag="1"##<tr class="submenu_##module##"><td class="menu-item menu-item-active##class_disabled##"##title_disabled##><a href="##script##">##caption##</a></td></tr><tr><td class="menu-stub"></td></tr>"-->

<!--#set var="standart_item" value="
    ##setglobalvar @count=(flag=="1")?count+1:count####if(flag=="1" && count=="1")##<tr><td class="menu-stub"></td></tr><tr><td class="menu-item-active-end"></td></tr>##endif##<tr class="submenu_##module##"><td class="menu-item##class_disabled##"##title_disabled##><a href="##script##">##caption##</a></td></tr>
"-->

<!--#set var="active_subitem" value="<tr><td class="menu-subitem-active##class_disabled##"##title_disabled##><a href="##script##">##caption##</a></td></tr>"-->
<!--#set var="standart_subitem" value="<tr><td class="menu-subitem##class_disabled##"##title_disabled##><a href="##script##">##caption##</a></td></tr>"-->

<!--#set var="splitter" value="
        ##if(count!="")##<tr><td class="menu-splitter"></td></tr>##endif##
"-->

<!-- MENU START -->
      <table width=220 cellspacing=0 cellpadding=0 border=0 class="submenu">##items##</table>
<!-- MENU END -->
