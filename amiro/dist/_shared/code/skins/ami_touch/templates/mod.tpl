##--system info: module_owner="" module="" system="1"--##
%%include_language "_shared/code/skins/ami_touch/templates/lang/mod.lng"%%

<!--#set var="forbidden" value="<script>
    parent.amiSkinController.showMessage('%%forbidden%%');
</script>"-->

<!--#set var="mod" value="<!DOCTYPE html>
<!--[if IE 8]> <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <link rel="stylesheet" type="text/css" href="##www_root##_shared/code/web/skins/ami_touch/plugins/bootstrap/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="##www_root##_shared/code/web/skins/ami_touch/plugins/fontawesome/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="##www_root##amiro_sys_css.php?styles=skin&_cv=##cmsVersion##&less_mode=##lessMode##&sv=##cssVersion##">
        <script type="text/javascript">
            var oActiveModule = {
            modId:  '##modId##',
                    itemId: ##if (itemId)####itemId#### else##0##endif##,
                    catId:  parent.active_module_category_id,
                    pageId: '##pageId##',
                    hasForm: ##if (hasForm)##true## else##false##endif##,
                    aLocale: ##aLocale##
            };</script>
    </head>
    <body id="edit-page-bar" class="wysihtml5-supported">
        ##if(hasForm)##
        <!-- FORM COMPONENT -->
        <div ng-app="module" ng-controller="oForm.controller" id="moduleBody" class="big-spinner">
            <ami_form></ami_form>
            <input type="hidden" id="ami_ajax_response" ng-model="response" >
            <input type="hidden" id="ami_recompile" ng-model="recompile" >
        </div>
        ##endif##
        <div id="loader"></div>
        <script src="##www_root##_shared/code/web/skins/ami_touch/plugins/jquery/jquery.min.js"></script>
        <script src="##www_root##_shared/code/web/skins/ami_touch/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="##www_root##_shared/code/web/skins/ami_touch/plugins/angular/angular.min.js"></script>
        <script src="##www_root##_shared/code/web/skins/ami_touch/plugins/tinymce/tinymce.min.js"></script>
        <script type="text/javascript">var AMI = top.AMI;</script>
        <script src="##www_root##amiro_sys_js.php?script=skin&_cv=##cmsVersion##&sv=##cssVersion##"></script>
    </body>
</html>"-->


<!--#set var="auth_form" value="
<style>
    #ami-skin-auth-form {
        font-size:13px;
        font-family: arial, tahoma, verdana;
        display: block;
        background: #000;
        color: white;
        min-height: 26px;
        z-index: 100000;
        top: 0px;
        left: 0px;
        position: relative;
        padding: 12px;
        margin-top: -50px;
        text-align: center;
        transition: all 0.3s ease-out 0s;
        -moz-transition: all 0.3s ease-out 0s;
        -webkit-transition: all 0.3s ease-out 0s;
        -o-transition: all 0.3s ease-out 0s;
    }

    #ami-skin-auth-form.ami-skin-auth-form__show {
        margin-top: 0;
    }

    #ami-skin-auth-form form {
        display: inline-block;
    }

    #ami-skin-auth-form .ami-skin-auth-form__forgot {
        color: #fff;
        font-size:13px;
        font-family: arial, tahoma, verdana;
        text-decoration: underline;
    }

    #ami-skin-auth-form form input {
        border: 1px solid #ccc;
        border-radius: 2px;
        width: 100px;
        padding: 2px 4px; margin: 2px 4px;
        font-size:13px;
        font-family: arial, tahoma, verdana;
        color: #848484;
    }

    #ami-skin-auth-form form .ami-skin-auth-form__submit {
        cursor: pointer;
        background: #1bbae1;
        color: #fff;
        border: 1px solid #1bbae1;
        margin: 0 4px 0 0;
        width: auto;
        font-size:13px;
        font-family: arial, tahoma, verdana;
    }

    @media screen and (max-width: 500px) {
        #ami-skin-auth-form form input {
            width: 50px;
        }
    }
</style>
<nobr id="ami-skin-auth-form">
    <form action="pages.php" method="POST" enctype="multipart/form-data">
        <input class="ami-skin-auth-form__login" type="text" name="username" placeholder="%%input_username%%">
        <input class="ami-skin-auth-form__password" type="password" name="password" placeholder="%%input_password%%">
        <input type="hidden" name="modlink" value="##membersLink##">
        <input type="hidden" name="wantsurl" value="">
        <input class="ami-skin-auth-form__submit" value="%%input_submit%%" type="submit" name="submit">
    </form>
    <a class="ami-skin-auth-form__forgot" href="##www_root####membersLink##?action=forgot">%%forgot_pwd%%</a>
</nobr>
"-->

<!--#set var="menu" value="<!DOCTYPE html>
<html style="background: #000; opacity: 0;">
<head>
    <title>Amiro.CMS Toolbar</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="##www_root##_shared/code/web/skins/ami_touch/plugins/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="##www_root##_shared/code/web/skins/ami_touch/plugins/fontawesome/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="##www_root##amiro_sys_css.php?styles=skin&_cv=##cmsVersion##&sv=##cssVersion##">
    <script src="##www_root##_shared/code/web/skins/ami_touch/plugins/jquery/jquery.min.js"></script>
</head>
<script>
var aLocale = ##aLocale##;
</script>
<body class="admin-bar-iframe" onload="initMenu();">
<div id="edit-black-bar" class="admin-bar">
    <header class="navbar navbar-default">
        <ul class="nav navbar-nav-custom bar-infoblock" id="menu-buttons">
        </ul>
        <ul class="nav navbar-nav-custom pull-right">
            <li id="refreshBtn" title="%%caption_refresh_hint%%">
                <a href="#" onclick="$('#fa-refresh').addClass('fa-spin'); parent.amiSkinController.reload();">
                    <i id="fa-refresh" class="fa fa-refresh refreshBtn-label"></i>
                    <span class="bar-title-block refreshBtn-label">
                        <span class="bar-title">%%caption_refresh%%</span>
                    </span>
                </a>
            </li>
            <li id="username-btn">
                <a href="#" onclick="parent.amiSkinController.userMenu(); return false;">
                    <i class="fa fa-user"></i>
                    <span class="bar-title-block">
                        <span class="bar-title" id="username"></span>
                    </span>
                </a>
            </li>
        </ul>
    </header>
</div>
<div id="device-class"></div>
<script>
    function initMenu(){
        window.checkInterval = setInterval(function(){
            if(typeof(parent.amiSkinController) != 'undefined'){
                if(parent.amiSkinController.isModuleLoaded) {
                    parent.amiSkinController.initToolbar();
                    clearInterval(window.checkInterval);
                }
            }
        }, 500);
    }
</script>
##if(is_shared)##
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-503988-11', 'auto');
  // ga('send', 'pageview');
</script>
##endif##
</body>
</html>"-->

<!--#set var="list" value="<!DOCTYPE html><!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
    <link rel="stylesheet" type="text/css" href="##www_root##_shared/code/web/skins/ami_touch/plugins/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="##www_root##_shared/code/web/skins/ami_touch/plugins/fontawesome/css/font-awesome.min.css">
</head>
<body style="padding-top: 50px; background: #fff; display: block;" id="edit-page-bar">
    <div id="loader"></div>

<div class="block-area ng-scope">
    <div class="edit-area">
        <div class="block-title">
            <div class="block-options pull-right">
                <a href="#" class="btn btn-alt btn-sm btn-default" onclick="parent.amiSkinController.openModule()"><i class="fa fa-times"></i></a>
            </div>
            <span href="#" class="add-contant">%%caption_edit%%</span>
        </div>
    </div>
</div>

<div class="table-responsive">
    <table class="table table-striped table-vcenter table-hover" id="general-table">
        <thead>
            <tr>
                <th class="text-center"><input type="checkbox"></th>
                <th class="text-center text-data">%%caption_date%%</th>
                <th>%%caption_header%%</th>
                <th class="text-center text-action">%%caption_actions%%</th>
            </tr>
        </thead>
        <tbody class="elements-item-row">
            <tr style="display: none;" class="item-row__1">
                <td class="text-center"></td>
                <td></td>
                <td></td>
                <td class="text-center"></td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="4">
                    <div class="btn-group btn-group-sm">
                        <a href="javascript:void(0)" class="btn btn-primary" data-toggle="tooltip" title="" data-original-title="Delete Selected"><i class="fa fa-times"></i></a>
                    </div>
                </td>
            </tr>
        </tfoot>
    </table>
</div>

<script src="##www_root##amiro_sys_js.php?script=skin&_cv=##cmsVersion##&sv=##cssVersion##"></script>
<script src="##www_root##_shared/code/web/skins/ami_touch/plugins/jquery/jquery.min.js"></script>
<script src="##www_root##_shared/code/web/skins/ami_touch/plugins/bootstrap/bootstrap.min.js"></script>
<script>
    $(document).keydown(function(e){parent.amiSkinController.escCancel(e);});
    $(function(){ TablesGeneral.init(); });
</script>
</body>
</html>"-->

<!--#set var="minimum_layout" value="
"-->

<!--#set var="minimum_layout(mod_id="eshop_order_history")" value="
<div id="eshop-order-edp__links">
    <div class="eshop-order-edp__links-area">
        <a href="##ROOT_PATH_WWW##">%%to_main_page%%</a> |
        <a href="##member_script##">%%to_members_page%%</a>
    </div>
</div>
"-->
