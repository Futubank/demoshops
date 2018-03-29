%%include_language "_host/_login.lng"%%

<!--#set var="edp_login" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
##meta##
<title>%%##ADM_COPY_PREF##title%%</title>
</head>
<body>
%%auth_required%%
</body>
<html>
"-->

<!--#set var="reset_password_en" value="
Hello, ##fullname##,

Your password has been reset, your new login information is:

Admin URL ##adminurl##
Username: ##username##
Password: ##password##

Password reset from IP: ##ip##

"-->

<!--#set var="reset_password_ru" value="
Здравствуйте, ##fullname##,

Ваш пароль был сброшен, новая информация для доступа:

Панель администратора: ##adminurl##
Пользователь: ##username##
Пароль: ##password##

Пароль сброшен с IP: ##ip##

"-->

<!--#set var="redirect_login" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<body onload="document.rform.submit()">
<form action="##url##" method="post" name="rform">
    <input type="hidden" name="domain" value="##domain##">
    <input type="hidden" name="loginname" value="##loginname##">
    <input type="hidden" name="loginpwd" value="##password##">
    <input type="hidden" name="faction" value="##faction##">
    <input type="hidden" name="adm_pref" value="##ADM_COPY_PREF##">
</form>
</body>
</html>
"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        ##meta##
        <title>%%##ADM_COPY_PREF##title%%</title>
        <link rel="stylesheet" href="skins/vanilla/_css/style.css?##time##" type="text/css">
        <link rel="stylesheet" href="skins/vanilla/_css/scroll_bars.css?##time##" type="text/css">
        <style>
            .amiro-header__logo {
                width: 65px;
            }
            .amiro-header__member-area {
                color: #990000;
                font-size: 17px;
                padding-left: 20px;
            }
            .amiro-header {
                position: relative;
                height: 59px;
                background: #FFCA6A;
            }
            .amiro-header__logo-img {
                background: url(skins/vanilla/images/custom_/amiro-header/amiro-header__logo.png) no-repeat;
                width: 28px;
                height: 45px;
                display: inline-block;
                left: 14px;
                position: relative;
            }
            
            .properties_form_table {
                border: 1px solid #FFE0A7;
            }
            
            .properties_form_table span {
                font-size: 13px;
            }
            .properties_form_title {
                background: #FFCE72;
            }
            .properties_form_table span {
                font-size: 13px;
                font-weight: normal;
            }
            input[type="text"], select, input[name="password"], input[name="password2"], input[name="loginpwd"] {
                padding: 5px 0px 5px 5px !important;
                border-color: #DBE1E8;
                border-radius: 6px;
                box-sizing: border-box;
                -moz-box-sizing: border-box;
                -webkit-box-sizing: border-box;
            }
            input.field {
                font-size: 11px;
            }
            button, .but, .but-short, .but-mid, .but-long, .but-244, .but-250, .filter_but, .but-95, .but-130 {
                color: #bc4702;
                font-weight: bold;
                font-size: 11px;
                border: 0px;
                background: url(../images/button_bg_120.gif);
                width: 120px;
                height: 25px;
                margin-bottom: 1px;
                cursor: pointer;
            }
            .properties_form_table tbody > tr:nth-of-type(1), .properties_form_table tbody > tr:nth-of-type(3) {
                height: 45px;
                vertical-align: middle;
            }
            .but, .but-short, .but-mid, .but-long, .but-244, .but-250, .filter_but, .but-95, .but-130 {
                background-image: none;
                background: #FFCE72;
                border: 1px solid #FFCE72;
                border-radius: 3px;
                line-height: 1.5;
                margin: 0px 0px 0px 5px;
                white-space: nowrap;
            }

        </style>
        <script>
            function checkPassword(field){
            if (field.value.search(/^[(\040a-zA-Z0-9_\-\!\@\#\$\%\^\&\*\(\)\+\=\{\}\[\]\;\:\.\>\<\,\\\/\`\~\|\?\"\')]*$/) == - 1){
            document.getElementById("pwd_alert").style.display = 'block';
            } else{
            document.getElementById("pwd_alert").style.display = 'none';
            }
            }
        </script>
    </head>
    <body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
        <table width="100%" height=100% border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td class="header-area" valign="top">
                    <table class="amiro-header" id="amiro-header-block" width="100%" height=100% border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="amiro-header__logo" rowspan="2"><span class="amiro-header__logo-img"></span></td>
                            <td class="amiro-header__favourites amiro-header__member-area" rowspan="2">%%auth%%</td>
                            <td class="amiro-header__select-modules" rowspan="2"><div id="select_module"></div></td>
                        </tr>
                        <tr>
                            <td class="amiro-header__control" colspan="2"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td bgcolor="#D9D9D9" height="2"></td>
            </tr>
            <tr>
                <td valign="top" class="center_area" height=100%>
                    <!-- BODY START-->
                    <br>
                    <div style="width:800px;margin: 0 auto 0 auto;">
                        <div id="status-block" class="status-block"##if (status=='')## style="display:none" ##endif##>
                            <div id="status-msgs" class="status-msgs">##status##</div>
                        </div>
                    </div>

                    <br>

                    <div id="div_login_form">
                        <table class="main-form__table properties_form_table" border="0" cellpadding="0" cellspacing="0" align="center">
                            <tr height=35 class="properties_form_title">
                                <td style="line-height:0px;" align=left></td>
                                <td nowrap height="35">
                                    <span id="form_title" class="form-header">%%welcome_##fform##%%</span></td>
                                <td nowrap  height="35" style="text-align:right;"></td>
                                <td style="line-height:0px;"></td>
                            </tr>
                            <tr>
                                <td  width="11"></td>
                                <td colspan=2 class="table_sticker" valign="top">

                                    <form name="loginform" id="loginform" action="##if(ADMIN_REQUIRE_SSL == "ssl_only" || (ADMIN_REQUIRE_SSL == "allow_ssl" && ssl_checked))####script_link_https####else####script_link####endif##" method="post">
                                          <input type="hidden" name="faction" value="##faction##">
                                        <input type="hidden" name="adm_pref" value="##ADM_COPY_PREF##">
                                        <table cellspacing="2" cellpadding="0" border="0" width=320>
                                            <tr>
                                            <br>
                                            <td colspan=2 class=small nowrap><b>%%enter_##fform##%%</b><br>&nbsp;</td>
                                            </tr>
                                            ##if(host_mode=="1")##
                                            <tr>
                                                <td class=small nowrap>%%site%%:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                <td class=small>
                                                    <input class=field style="width:144px;" type=text name="domain" value="##domain##">
                                                </td>
                                            </tr>
                                            ##endif##
                                            ##if(fform=="login")##
                                            <tr>
                                                <td class=small nowrap>%%login%%:&nbsp;</td>
                                                <td width=60%>
                                                    <input class=field type=text name="loginname" value="##loginname##">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class=small nowrap>%%pwd%%:&nbsp;</td>
                                                <td>
                                                    <input class=field type=password name="loginpwd" value="" onkeyup="checkPassword(this)">
                                                </td>
                                            </tr>
                                            ##if(ADMIN_REQUIRE_SSL == "allow_ssl")##
                                            <tr>
                                                <td class=small nowrap>%%allow_ssl%%:&nbsp;</td>
                                                <td>
                                                    <input type="checkbox" name="allow_ssl" value="1" onclick="document.getElementById('loginform').action = (this.checked) ? '##script_link_https##' : '##script_link##';" ##if(ssl_checked)##checked="checked"##endif##/>
                                                </td>
                                            </tr>
                                            ##endif##
                                            <tr>
                                                <td colspan=2 class=small><span id=pwd_alert style="color:#FF0000;display:none">%%pwd_alert%%</span></td>
                                            </tr>
                                            ##else##
                                            <tr>
                                                <td class=small nowrap>%%email%%:&nbsp;</td>
                                                <td width=60%>
                                                    <input class=field style="width:140px" type=text name="email" value="">
                                                </td>
                                            </tr>
                                            ##endif##
                                            ##if(fform=="forgot")##
                                            <tr>
                                                <td colspan=2 class=small><br><br></td>
                                            </tr>
                                            ##endif##
                                            <tr>
                                                <td></td>
                                                <td align="right" valign=bottom>
                                                    <input type="submit" value="%%btn_##fform##%%" class="but">
                                                    <br>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan=2 class=small><br><hr></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="right" class=small>
                                                    ##IF (fform=="login")##
                                                    <br>
                                                    <b><a href="##script_link##?fform=forgot">%%link_forgot%%</a></b>
                                                    <br>
                                                    ##ENDIF##
                                                    ##IF (fform=="forgot")##
                                                    <br>
                                                    <b><a href="##script_link##">%%link_login%%</a></b>
                                                    <br>
                                                    ##ENDIF##
                                                    ##IF (ADM_COPY_URL!="")##
                                                    <br>
                                                    %%support%%: <a href="##ADM_COPY_URL##">##ADM_COPY_URL##</a>
                                                    <br>
                                                    ##ENDIF##
                                                    ##IF (ADM_COPY_MAIL!="" && ADM_COPY_URL=="")##
                                                    <br>
                                                    %%support%%: <a href="mailto:##ADM_COPY_MAIL##">##ADM_COPY_MAIL##</a>
                                                    <br>
                                                    ##ENDIF##
                                                </td>
                                            </tr>
                                        </table>
                                    </form>


                                </td>
                                <td width="11"></td>
                            </tr>
                            <tr>
                                <td style="line-height:0px;"></td>
                                <td style="line-height:0px;" colspan=2 height="11"></td>
                                <td style="line-height:0px;"></td>
                            </tr>
                        </table>
                    </div>
                    <br>
                    <div class="warn-block" style="display:block;width:600px;" id="div_attention_form">
                        <div class="l-lt-c"></div><div class="l-rt-c"></div>
                        <div class="l-lb-c"></div><div class="l-rb-c"></div>
                        <div class="status-icon"><img src="skins/vanilla/icons/icon_warn.gif" width=18 height=18></div>
                        <div id="status-msgs" class="status-msgs">%%note%%</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="background:#e0e0e0;height:3px;"></div>
                    <div style="background:#FFD68A;height:7px;width:200px;"></div>
                    <div style="text-align:right;font-size:10px;padding:10px;">
                        ##--{copy=30}--##
                        ##ADM_COPY_NAME##
                        ##--//{copy=30}--##
                    </div>
                </td>
            </tr>
        </table>

        <script>
                    if (typeof (BodyOnLoad) == "function"){
            BodyOnLoad();
            }
            if (!document.loginform.disabled){
            ##--
                    ##if (host_mode == "1")##
                    document.loginform.domain.focus();
                    ## else##
                    document.loginform.loginname.focus();
                    ##endif##
                    --##
            }

        </script>
    </body>
</html>