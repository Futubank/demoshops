##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/main.lng"%%
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
##init##
##header##
<!--#set var="top_toolbar" value=""-->
<!--#set var="top_line" value=""-->
<tr>
    <td valign=top height=100%> ##--top_line--## <div style="background-color:#e0e0e0;height:2px;"></div>
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            ##if(module_name != 'start')##
            <td valign="top" id="left_area_td" style="margin-left: 0; display: block;">
            <div id="left_area_big" data-width-default="220">
                <table id="left-area__block" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top">
                        <div id="left-menu-block">
                            ##up_menu##
                            ##tree##
                            ##menu##
                        </div></td>
                        <td valign="top"><div class="left-menu-tab-close" onclick="switchLeftArea()" id="left-menu-tab"></div></td>
                    </tr>
                </table>
                ##submenu##
            </div></td>
            <td valign="top" class="center_area" width=100% id=body_content>
            <script>
                if (TrimStr(document.getElementById("left-menu-block").innerHTML) == '') {
                    document.getElementById("left-menu-tab").style.display = 'none';
                }
                if (AMI.$('#left_area_td').length > 0 && AMI.$('#help_block').length != 1) {
                    AMI.$('#slide-btn__area').css('visibility', 'visible');
                    var showLeftArea = AMI.Cookie.get("gShowLeftArea");
                    if (AMI.$('.amiro-header__control-help:eq(0)').attr('data-helpid-page') == 'pages') {
                        showLeftArea = '1';
                        AMI.$('#left-menu-tab').animate({
                            left : parseInt(AMI.$('#left_area_big').attr('data-width-default')) + 2
                        }, 150);
                    } else {
                        if ((showLeftArea == null) || (showLeftArea == "0")) {
                            AMI.$('#left_area_td').addClass('module-menu__hide-on');
                            switchLeftArea(0);
                        } else if (showLeftArea == "1") {
                            switchLeftArea(1);
                        }
                    }
                }
                AMI.$(function() {
                    AMI.$(document).click(function(event) {
                        if ($(event.target).closest("#amiro-header__setting-block").length)
                            return;
                        AMI.$('#amiro-header__setting-form').fadeOut(150);
                        AMI.$('#amiro-header__setting-block').removeClass('amiro-header__control-option-block-on');
                        if ($(event.target).closest("#favorites_block").length)
                            return;
                        AMI.$('#favorites_block').fadeOut();
                        if ($(event.target).closest("#calendar_block").length)
                            return;
                        AMI.$('#calendar_block').fadeOut();
                        event.stopPropagation();
                    });
                });
            </script><div id="top-submenu"></div><div class="top-submenu__splitter"></div>
            <script>
                if (AMI.$('.menu-subitem-active, .menu-subitem').length > 0) {
                    AMI.$('.menu-subitem-active, .menu-subitem').each(function(i) {
                        i = 0;
                        // Temporary
                        if (AMI.$(this).attr('class').indexOf('active') != -1) {
                            AMI.$('#top-submenu').append('<span style="z-index: -' + i + '" class="top-submenu__item top-submenu__item-active">' + AMI.$(this).html() + '</span>');
                        } else {
                            AMI.$('#top-submenu').append('<span style="z-index: -' + i + '" class="top-submenu__item">' + AMI.$(this).html() + '</span>');
                        }
                    });
                }
            </script>
            <div id="request_processing" class="processingRequest">
                <div>
                    <div class="cssload-thecube">
                        <div class="cssload-cube cssload-c1"></div>
                        <div class="cssload-cube cssload-c2"></div>
                        <div class="cssload-cube cssload-c4"></div>
                        <div class="cssload-cube cssload-c3"></div>
                    </div>
                </div>
            </div>
            <div id="loading_module" class="processingRequest">
                <div>
                    <div class="cssload-thecube">
                        <div class="cssload-cube cssload-c1"></div>
                        <div class="cssload-cube cssload-c2"></div>
                        <div class="cssload-cube cssload-c4"></div>
                        <div class="cssload-cube cssload-c3"></div>
                    </div>
                </div>
            </div> ##filter##
            <div id="status-block" class="status-block"##if (status=='')## style="display:none" ##endif##>
                <div id="status-msgs" class="status-msgs">
                    ##status##
                </div>
            </div> ##list_table##
            <div style="width:90%; min-width: 730px; padding-right:13px; margin-left:auto; margin-right:auto;">
                ##form##
            </div></td>
            ##else##
                <td style="vertical-align: top;">
                    ##form##
                </td>
                <td class="start__amiro-col">
                    ##submenu##
                </td>
            ##endif##
        </tr>
    </table></td>
</tr>
<tr>
    <td> ##footer##
