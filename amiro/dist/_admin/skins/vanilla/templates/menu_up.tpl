##--!ver=0200 rules="-SETVAR"--##
<!--#set var="up_menu_active_item" value="
<tr onclick="showSubMenuCalc('##up_item_module##', 'td_sub_##up_item_module##'); return false;" class="module-menu-tr__active">
    <td id="td_sub_##up_item_module##" ##--onclick="window.location='##up_item_link##';return false;"--## data-title="##up_item##" data-module-link="window.location='##up_item_link##';return false;" data-module-sublink="showSubMenuCalc('##up_item_module##', 'td_sub_##up_item_module##'); return false;" valign="middle" align="left" class="submenu_area menu_up menu_up_active" nowrap>
        <div class="submenu_area module-menu__item-block module-menu__##up_item_module## module-menu-selected__##up_item_module##">
            <span class="submenu_area module-menu__item module-menu-selected__item">##up_item##</span>
        </div>
    </td>
    ##--<td class="submenu_area menu_up_active module-menu__submenu module-menu-selected__submenu" id="td_sub_##up_item_module##">
        <a href="#" onclick="return false;"><img border="0" class="submenu_area submenu_btn icon" src="skins/vanilla/icons/icon_sub_menu_white.gif" /></a>
    </td>--##
</tr>
"-->

<!--#set var="up_menu_standart_item" value="
<tr onclick="showSubMenuCalc('##up_item_module##', 'td_sub_##up_item_module##'); return false;" class="submenu_area module-menu-tr">
    <td id="td_sub_##up_item_module##" ##--onclick="window.location='##up_item_link##';return false;"--## data-title="##up_item##" data-module-link="window.location='##up_item_link##';return false;" data-module-sublink="showSubMenuCalc('##up_item_module##', 'td_sub_##up_item_module##'); return false;" width=100% valign="middle" align="left" id="menu_up_##up_item_module##" class="submenu_area menu_up" nowrap ##--onclick="window.location='##up_item_link##';return false;"--##>
        <div class="submenu_area module-menu__item-block module-menu__##up_item_module##">
            <span class="submenu_area module-menu__item">##up_item##</span>
        </div>
    </td>
    ##--<td class="submenu_area menu_up module-menu__submenu"  id="td_sub_##up_item_module##"><a href="#" onclick="return false;">
        <img border="0" class="submenu_area submenu_btn icon" src="skins/vanilla/icons/icon_sub_menu.gif" /></a>
    </td>--##
</tr>
"-->

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="submenu_area menu">
##items##
</table>
##up_menu##