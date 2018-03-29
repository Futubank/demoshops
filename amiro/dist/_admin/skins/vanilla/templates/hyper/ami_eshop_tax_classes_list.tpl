##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="javascript" value="
AMI.Message.addListener('ON_AMI_LIST_ROW', function(oComponent, oParameters){
    if(oParameters.data.is_default != ''){
        delete(oParameters.data.actions['delete']);
        //oParameters.row.className = 'hide_grp_checkbox';
    }
});

AMI.Message.addListener(
    'ON_MODULE_ACTION',
    function(action, oParameters){
        switch(action){
            case 'list_active':
                if(top.document.getElementById('id_tax_class').value != oParameters.oParameters.id){
                    //fireEvent2(top.document.getElementById('id_tax_class'), 'change', top.document.forms['eshop_form']);
                }
                top.document.getElementById('id_tax_class').value = oParameters.oParameters.id;
                closeDialogWindow();
                return false;
                break;
        }
        return true;
    }
);

/*
AMI.Message.addListener(
    'ON_COMPONENT_CONTENT_PLACED',
    function(oComponent){
        if(oComponent.componentType == 'list'){
            //AMI.$('TR.hide_grp_checkbox input[type=checkbox]').attr('disabled', 'disabled');
            //AMI.$('TR.hide_grp_checkbox input[type=checkbox]').hide();
            AMI.$('TR.hide_grp_checkbox input[type=checkbox]').remove();
        }
        return true;
    },
    true
);
*/
"-->
