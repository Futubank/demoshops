##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="section_form" value="
<script type="text/javascript">
function grpActionGenKeywords(oParams, force){
    var oForm = document.forms[_cms_document_form];

    oForm.action.value = 'grp_gen_keywords';
    document.location = _cms_script_link + collect_link(oForm) + (typeof(force) != 'undefined' && force ? '&gen_keywords_force=1' : '');
    return false;
}

function listActionPublish(params){
    var oList = params.oComponent.getListData().data.list;
    for(var i = 0, q = oList.length; i < q; i++){
        if(oList[i].id == params.oParameters.id){
            publish(oList[i].id, oList[i].public.enabled == 1 ? 'off' : 'on');
            break;
        }
    }
    return false;
}

function listGroupActionGenHTMLMetaForce(params){
    grpActionGenKeywords(null, true);
    return false;
}

AMI.PartialAsync.init({
    actions: {
        // list_reply:     'reply', ///
        list_public:    listActionPublish,
        list_un_public: listActionPublish,
        list_edit:      'edit',
        list_delete:    'del'
    },
    groupActions: {
        grp_public:              'publish_on',
        grp_unpublic:            'publish_off',
        grp_delete:              'del',
        grp_lock:                'lock_on',
        grp_unlock:              'lock_off',
        grp_id_cat:              'grp_id_cat',
        grp_gen_sublink:         'gen_sublink',
        grp_gen_html_meta:       grpActionGenKeywords,
        grp_gen_html_meta_force: listGroupActionGenHTMLMetaForce,
        grp_index_details:       'index_details',
        grp_no_index_details:    'no_index_details'
    },
    confirms: {
        grp_lock: AMI.Template.Locale.get('list_confirm_grp_lock'),
        grp_unlock: AMI.Template.Locale.get('list_confirm_grp_unlock'),
        list_delete: AMI.Template.Locale.get('list_confirm_deletion')
    },
    scrollToForm: ['reply', 'edit', 'save']##--IF(id)##true##ELSE##false##ENDIF--##
});
</script>
"-->
