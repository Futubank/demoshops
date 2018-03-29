##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_res_ftp_inst.lng"%%
%%include_template "templates/hst_res_inst_form.tpl"%%

<script type='text/javascript'>
function onSelectHomeDirClick() {
    var currentPath = "";
    var idVhost = 0;
    if(document.forms[_cms_document_form].elements["id_vhost"]) {
        var idVhost = document.forms[_cms_document_form].elements["id_vhost"].value;
    }
    if(document.forms[_cms_document_form].elements["homedir"]) {
        var currentPath = document.forms[_cms_document_form].elements["homedir"].value;
    }
    var errmsg = '';
    if(idVhost == 0) {
        errmsg += '%%vhost_warn%%';
        alert(errmsg);
        return false;
    }
    openExtDialog('%%select_homedir%%', 'hst_res_ftp_select_path_popup.php?dest_field_id=homedir&id_vhost=' + idVhost + "&id_res_inst=##id_res_inst##&current_path=" + currentPath, 1, 1, 400, 500);
    return false;
}
</script>