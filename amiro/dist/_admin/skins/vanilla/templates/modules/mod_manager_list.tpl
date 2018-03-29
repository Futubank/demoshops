##--system info: module_owner="services" module="mod_manager" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="caption_field" value="
<table class="mod-manager__list" cellspacing="0" cellpadding="0" border="0" width="100%">
    <tr>
        <td>
            <img src="##icon_path##" style="width: 34px; height: 34px; vertical-align: middle;" alt="" title="" />
        </td>
        <td width="100%">
            ##IF(admin_url)##<a href="##admin_url##" title="%%to_module%%">##ENDIF####caption####IF(admin_url)##</a>##ENDIF##
            <br>
            [##id##]
        </td>
    </tr>
</table>
"-->