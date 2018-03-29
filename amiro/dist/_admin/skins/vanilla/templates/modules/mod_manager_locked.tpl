##--system info: module_owner="services" module="mod_manager" system="1"--##
%%include_language "templates/lang/modules/mod_manager_locked.lng"%%

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
<body>
    <div style="text-align:center;">
        <div style="
            width: 440px !important;
            margin: 5px auto 0px auto !important;
            font-family: Tahoma !important;
            font-size: 12px !important;
            border-radius: 10px !important;
            border: 2px black solid !important;
            border-color: red !important;
            padding: 10px !important;
            color: #000 !important;
            background-color: #eee !important;
            visibility: visible !important;
            opacity: 1 !important;
            display: block !important;
            text-align:left;
        ">
        <div style="color: #f00 !important; font-size: 16px !important;">%%header%%</div>
        <p>
            %%content%%
            ##IF(left)##
            %%repeat_after%% ##left## %%repeat_after_sec%%.
            ##ELSE##
            %%repeat%%
            ##ENDIF##
        </p>
        </div>
    </div>
</body>
</html>
