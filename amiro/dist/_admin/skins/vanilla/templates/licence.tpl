%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/licence.lng"%%

<!--#set var="upgrade_message" value="
    <tr>
      <td colspan=2 align="center" valign=bottom>
        <br>
        ##upgrade_message##
        <br>
      </td>
    </tr>
"-->

<!--#set var="input_form" value="
<script>
var sStartString = '##start_string##';
var sEndString = '##end_string##';
var _cms_document_form = 'licenceform';

function SubmitForm(){
    var
        oForm    = document.forms[_cms_document_form],
        oLic     = oForm.elements['licence'],
        sLicence = oLic.value.replace(/^[ \r\n]*(.*)/, "$1"),
        srcLic   = oLic.getAttribute('data-ami-src').replace(/^[ \r\n]*(.*)/, "$1");

    if('FREE' !== sLicence.substr(0, 4)){
        sPos = sLicence.search(sStartString) + sStartString.length + 3;
        ePos = sLicence.search(sEndString); // - sEndString.length + 3;
        cCRC = sLicence.substr(sPos - 3, 3);
        cCRC = String.fromCharCode(cCRC);
        sLicence = sLicence.substr(sPos, ePos - sPos);
        if((sLicence.length == 0)){
            alert('%%err_4%%');

            return false;
        }

        crc = 0;
        for(i=0;i<sLicence.length;i++){
            var char_ = sLicence.charCodeAt(i);
            if(char_ == 10){
                crc ^= 13;
                crc ^= 10;
            }else if(char_ != 13){
                crc ^= char_;
            }
        }
        crc = String.fromCharCode(crc);
        if(crc != cCRC){
          alert('%%err_4%%');

          return false;
        }

        if(!confirm('%%update_key_confirm%%')){
            return false;
        }
    }else{
        if(
            ('FREE' !== srcLic.substr(0, 4)) &&
            (location.href.indexOf('full2free=1') < 0)
        ){
            alert('%%err_6%%');

            return false;
        }
        if(sLicence.substr(sLicence.length - 2, 2) != "-="){
            alert('%%err_1%%');

            return false;
        }
    }

    oForm.submit();
}
</script>


    <form name="licenceform" action="##script_link##" method="post">
    <input type="hidden" name="action" value="licence">
    <table width="400" cellspacing="0" cellpadding="0" border="0" class="frm">
    <tr>
      <td colspan="2" align="right">
        <br>
      </td>
    </tr>
    <tr>
      <td valign=top class=small colspan=2><br><div class=tooltip>%%licence_hint%%</div><br>
      </td>
    </tr>
    <tr>
      <td colspan=2 class=small>%%enter_licence%%:<br>&nbsp;</td>
    </tr>
    <tr>
      <td colspan=2 valign=top>
        <textarea class="field" style="width:490px" rows="14" name="licence">##licence##</textarea>
      </td>
    </tr>
    <tr>
      <td colspan=2>&nbsp;</td>
    </tr>
    <tr>
      <td colspan=2 align="center" valign=bottom>
        <br>
        <input type="button" value="%%activate_btn%%" class="but-long" onclick="SubmitForm();">
        <br>
      </td>
    </tr>
    ##upgrade_message##
    <tr>
      <td colspan="2" align="right" class=small>
        <br>
        <br>
        ##support_msg##
        <br><br>
      </td>
    </tr>
    </table>
    </form>
<script type="text/javascript">
var oLic = document.forms[_cms_document_form].elements['licence'];
oLic.setAttribute('data-ami-src', oLic.value);
</script>
"-->

<!--#set var="updated" value="
    <table width="400" cellspacing="0" cellpadding="0" border="0" class="frm">
    <tr>
      <td colspan="2" align="right">
        <br>
      </td>
    </tr>
    <tr>
      <td colspan=2>%%licence_ready%%<br>&nbsp;</td>
    </tr>
    <tr>
      <td colspan=2>
        <a href="start.php"><b>&raquo;&nbsp;%%start%%</b></a>
      </td>
    </tr>
    </table>
"-->

<!--#set var="denied" value="
    <table width="400" cellspacing="0" cellpadding="0" border="0" class="frm">
    <tr>
      <td colspan="2" align="right">
        <br>
      </td>
    </tr>
    <tr>
      <td colspan=2>%%access_denied%%<br>&nbsp;</td>
    </tr>
    <tr>
      <td colspan=2 align=center>
        <a href="start.php">%%back_to_start%%</a>
      </td>
    </tr>
    </table>
"-->

<!--#set var="server_name" value="
<a target="_blank" href="##front_link##">##server##</a> • ##username## <a title="%%icon_logout%%" helpId="panel-logout" href="#" onclick="javascript: if(confirm('%%icon_logout%%?')) window.location='##if(ADM_COPY_PREF!="")##custom_login.php##else##login.php##endif##'; return false;" class="amiro-header__site-url__block__logout"></a>
"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
##meta##
<meta http-equiv="expires" content="-1">
<meta http-equiv="pragma" content="no-cache">
<title>%%##ADM_COPY_PREF##title%%</title>
<link rel="stylesheet" href="skins/vanilla/_css/style.css?##time##" type="text/css">
<link rel="stylesheet" href="skins/vanilla/_css/scroll_bars.css?##time##" type="text/css">
<style>


.amiro-header__logo {
    width: 65px;
    background: url(skins/vanilla/images/custom_/amiro-header/amiro-header__logo-bg.png) no-repeat;
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
.amiro-header__site-url__block__logout {
    background: url(skins/vanilla/icons/admin-icon__sprite.png) no-repeat -99px -95px;
    display: inline-block;
    height: 19px;
    position: absolute;
    right: 8px;
    top: 5px;
    width: 18px;
}
.amiro-header__site-url__block__logout:hover {
    background: url(skins/vanilla/icons/admin-icon__sprite.png) no-repeat -99px -114px;
}
.amiro-header__site-url__block {
    position: relative;
    border-radius: 0 13px 0 0;
    border-right: 1px solid #F1C28C;
    height: 24px;
    margin-right: 2px;
    padding: 8px 30px 0 0;
    background: none;
}
.amiro-header__amiro-edition__block {
    border-left: 1px solid #F1C28C;
    border-radius: 13px 0 0 0;
    height: 24px;
    padding: 8px 9px 0;
    background: none;
}
.amiro-header__amiro-edition__block a {
    color: #000;
    text-decoration: none;
}
.amiro-header__logo-img {
    background: url(skins/vanilla/images/custom_/amiro-header/amiro-header__logo.png) no-repeat;
    width: 28px;
    height: 45px;
    display: inline-block;
    left: 14px;
    position: relative;
}
.amiro-header__logo-img__to-home {
    background: url(skins/vanilla/images/custom_/amiro-header/amiro-header__logo-home.png) no-repeat 6px 8px;
    width: 38px;
    height: 35px;
    display: inline-block;
    left: 5px;
    position: relative;
}
.amiro-header__favourites-icon {
    background: url(skins/vanilla/images/custom_/amiro-header/amiro-header__favourites.png) no-repeat;
    width: 20px;
    height: 20px;
    display: inline-block;
    cursor: pointer;
}
.amiro-header__favourites-icon:hover {
    background: url(skins/vanilla/images/custom_/amiro-header/amiro-header__favourites.png) no-repeat 0 -20px;
}
.amiro-header__amiro-edition, .amiro-header__site-url {
    width: 5%;
    height: 30px;
    overflow: hidden;
    background: none;
    font-weight: normal;
}
.amiro-header__favourites {
width: 100%;
}

.properties_form_table {
    border: 1px solid #FFE0A7;
}

.properties_form_title {
    background: #FFCE72;
}

.form-header {
    color:#bc4702;
    font-size:16px;
    font-weight: normal;
}

.tooltip{
    font-size:10px;
    padding:8px 8px 8px 30px;
    margin:10px 10px 10px 0px;
    background: rgba(255, 235, 0, 0.25);
    -moz-border-radius: 10px;
    border-radius: 5px;
}

.tooltip:before {
    content: "?";
  font-size: 18px;
  position: relative;
  left: -20px;
  margin-right: -10px;
}

input.but-long[type="button"] {
    background:#FFCE72;
    border: 1px solid #FFCE72;
    border-radius: 3px;
    padding: 8px 20px;
    font-size: 12px;
    line-height: 1.5;
    height: auto;
    font-weight: normal;
}
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td class="header-area" valign="top">
                <table class="amiro-header" id="amiro-header-block" width="100%" height=100% border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="amiro-header__logo" rowspan="2">
                            ##if(module_name == 'start')##
                                <span class="amiro-header__logo-img"></span>
                            ##else##
                                <span class="amiro-header__logo-img-block">
                                    <a title="%%go_start_page%%" href="start.php" class="amiro-header__logo-img"></a>
                                    <a title="%%go_start_page%%" href="start.php" class="amiro-header__logo-img__to-home"></a>
                                </span>
                            ##endif##
                        </td>
                        <td class="amiro-header__favourites" rowspan="2"></td>
                        <td class="amiro-header__select-modules" rowspan="2"><div id="select_module"></div></td>
                        <td class="amiro-header__site-url"><div class="amiro-header__site-url__block">##server_name##</div></td>
                        <td class="amiro-header__amiro-edition"><div class="amiro-header__amiro-edition__block"><a target="_blank" href="http://www.amiro.ru" title="%%amiro_cms%%">Amiro.CMS##-- %%amiro_cms_edition_##edition##%%--##</a> <a target="_blank" class="amiro-header__amiro-history" title="%%amiro_cms_history%%" href="http://www.amiro.ru/product/amiro.cms/changes-history">##cms_version##</a></div></td>
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
    <td width="100%" valign="top" class="center_area">
          <!-- BODY START-->

      <br>
      <div id="status-block" class="status-block"##if (status=='')## style="display:none" ##endif##>
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div>
          <div id="status-msgs" class="status-msgs">##status##</div>
      </div>

      </div>

      <br>


    <div ##--form_align--## style="display:##display_form##;" id="div_properties_form" class="main-form">
     <table class="main-form__table properties_form_table" ccc="1" border="0" cellpadding="0" cellspacing="0" style="margin-left:auto;margin-right:auto;">
     <tr><td valign=top>
      <table border="0" cellpadding="0" cellspacing="0" width=100%>
        <tr class="properties_form_title" height=35>
          <td style="line-height:0px;" align=left></td>

          <td nowrap height="35">
            <span id="form_title" class="form-header">##welcome##</span></td>
          <td nowrap height="35" style="text-align:right;">
          <div id=stModified style="display:none;" class=form-header>&nbsp;</div></td>

          <td style="line-height:0px;"></td>
        </tr>
        <tr>
          <td width="11"><img src="skins/vanilla/images/spacer.gif" width="1" height="1"></td>
          <td colspan=2 class="table_sticker" valign="top">
          ##form##
           </td>
          <td width="11"><img src="skins/vanilla/images/spacer.gif" width="1" height="1"></td>
        </tr>
        <tr>
          <td style="line-height:0px;"></td>
          <td style="line-height:0px;" colspan=2 height="11"><img src="skins/vanilla/images/spacer.gif" width="1" height="1"></td>
          <td style="line-height:0px;"></td>
        </tr>
      </table>
      </td></tr>
      </table>
    </div>
      <br>
    </td>
  </tr>
  <tr>
    <td>
      <div style="background:#e0e0e0;height:3px;margin-top:20px;"></div>
      <div style="background:#FFD68A;height:7px;width:200px;"></div>
      <div style="text-align:right;padding:10px;">
##--{copy=30}--##
            ##ADM_COPY_NAME##
##--//{copy=30}--##
      </div>
    </td>
  </tr>
</table>
</body>
</html>