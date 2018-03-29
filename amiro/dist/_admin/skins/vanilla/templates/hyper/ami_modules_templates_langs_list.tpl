##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/hyper/ami_modules_templates_templates_list.tpl"%%

<!--#set var="javascript" value="
AMI.Message.addListener(
    'ON_MODULE_ACTION',
    function(action, oParameters){
        switch(action){
            case 'group_action':
                return confirm(AMI.Template.Locale.get('list_confirm_grp_restore'));
                break;
        }
        return true;
    }
);

var aDisabledCheckboxes = [];

AMI.Message.addListener('ON_AMI_LIST_ROW', function(oComponent, oParameters){
    if(oParameters.data.is_restore_allowed != 1){
        oParameters.row.className = 'hide_grp_checkbox';
        aDisabledCheckboxes.push(oParameters.data.id);
    }
});

AMI.Message.addListener(
    'ON_COMPONENT_CONTENT_PLACED',
    function(oComponent){
        if(oComponent.componentType == 'list'){
            AMI.$('TR.hide_grp_checkbox input[type=checkbox]').remove();
            for(var i = 0, q = oComponent.aGroupIdCheckboxes.length; i < q; i++){
                if(aDisabledCheckboxes.indexOf(oComponent.aGroupIdCheckboxes[i].value) > -1){
                    delete oComponent.aGroupIdCheckboxes[i];
                }
            }
        }
        return true;
    },
    true
);

AMI.Message.addListener(
    'ON_LIST_ROW_CLICK',
    function(oArgs){
        return aDisabledCheckboxes.indexOf(oArgs.oCheckbox.value) == -1;
    },
    true
);

"-->
