
<!--#set var="active_item" value="<tr><td background=skins/vanilla/images/m_isel_bg.gif width=190 height=23 class=menu_item><div class=menu_1lvl_sel><a href=##script##.php>##name##</a></div></td></tr>"-->
<!--#set var="opened_item" value="<tr><td background=skins/vanilla/images/m_iopen_bg.gif width=190 height=23 class=menu_item><div class=menu_1lvl_sel><a href=##script##.php>##name##</a></div></td></tr>"-->
<!--#set var="standart_item" value="<tr><td background=skins/vanilla/images/m_i_bg.gif width=190 height=23 class=menu_item><div class=menu_1lvl><a href=##script##.php>##name##</a></div></td></tr>"-->
<!--#set var="main_item" value="<tr><td background=skins/vanilla/images/m_i_bg.gif width=190 height=23 class=menu_item><div class=menu_1lvl><a href=##script##.php>##name##</a></div></td></tr>"-->

<!--#set var="active_subitem" value="<td valign=middle width=190 height=14 class=menu_item><div class=menu_2lvl_sel><img src=skins/vanilla/images/submenu_isel.gif border=0>"-->
<!--#set var="standart_subitem" value="<td valign=middle width=190 height=14 class=menu_item><div class=menu_2lvl><img src=skins/vanilla/images/submenu_n.gif border=0>"-->

<!--#set var="splitter" value="
            <tr>
              <td width="167" height="10">
              <table width="130" height="10" border="0"  cellpadding="0" cellspacing="0">
                 <tr>
                   <td background="skins/vanilla/images/dot_line_bg.gif">
                   <img src="skins/vanilla/images/spacer.gif" width="1" height="1"></td>
                 </tr>
              </table>
              </td>
            </tr>
"-->


        <!-- MENU START -->
          <table width="200" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td><img src="skins/vanilla/images/spacer.gif" width="200" height="1"></td>
            </tr>

              ##item_eshop_cat##
              ##item_eshop_item##
              ##item_eshop_user##
              ##item_eshop_order##

              ##splitter##

              ##item_exit##

         </table>
        <!-- MENU END -->
