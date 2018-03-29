##--system info: module_owner="" module="" system="1"--##
%%include_template "templates/modules/_list.tpl"%%

<!--#set var="javascript" value="
if(typeof(AMI.Page.listJS) == 'undefined'){

    AMI.Page.reloadListAfterAction = false;
    AMI.Page.listJS = true;

    AMI.Message.addListener('ON_MODULE_FILTER_RESET_ACTION', function(oComponent, oParameters){
        if(oComponent.componentId == 'selected_filter'){
            oParameters.module = '';
        }else{
            oParameters.modname = 'news';
        }
        return true;
    });

    AMI.Message.addListener('ON_COMPONENT_GET_REQUEST_DATA', function(oComponent, oParameters){
        if(oComponent.componentId == 'selected_items_list'){
            oComponent.ami_full = 1;
            oParameters.ami_full = 1;
        }
        return true;
    },
    true);

    AMI.Message.addListener('ON_COMPONENT_CONTENT_RECEIVED', function(oComponent, oData){
        if(oComponent.componentId == 'selected_items_list'){
            if(typeof(top._cms_document_form) != 'undefined'){
                if(typeof(oData.data) != 'undefined'){
                    top.document.forms[top._cms_document_form].relations_number.value = oData.data.totalItems;
                }else{
                    top.document.forms[top._cms_document_form].relations_number.value = 0;
                }
            }
        }
        return true;
    },
    true);

    AMI.Message.addListener('ON_AFTER_MODULE_ACTION', function(action, oParameters){
        AMI.Page.reloadListAfterAction = false;
        switch(action){
            case 'list_remove':
                AMI.Page.reloadListAfterAction = 'module_items_list';
                break;
            case 'list_add_subitem':
                AMI.Page.reloadListAfterAction = 'selected_items_list';
                break;
            case 'group_action':
                AMI.Page.reloadListAfterAction = (oParameters.oParameters.action == 'grp_add') ? 'selected_items_list' : 'module_items_list';
                break;
        }
        return true;
    });

    AMI.Message.addListener('ON_COMPONENT_CONTENT_PLACED', function(oComponent){
        $('head').append('<style>#add_new_button:before{content:none;display:inline;}</style>'); // hack for unrelated ::before content injection
        if(oComponent.componentId == 'selected_items_list'){
            AMI.$('div#component_relations_list_selected_items_list .icon_button_add').html('<h3>%%selected_items_list%%:</h3>');
            AMI.$('div#component_relations_list_selected_items_list .icon_button_add').css('visibility', 'visible');
            AMI.$('div#component_relations_list_selected_items_list .icon_button_add').css('background', 'none');
            AMI.$('div#component_relations_list_selected_items_list .icon_button_add').css('border', 'none');
            if(AMI.Page.reloadListAfterAction == 'module_items_list'){
                AMI.Page.doModuleAction(oComponent.oModule.moduleId, 'module_items_list', 'list_view', {});
            }
        }
        if(oComponent.componentId == 'module_items_list'){
            AMI.$('div#component_relations_list_module_items_list .icon_button_add').html('<h3>%%module_items_list%%:</h3>');
            AMI.$('div#component_relations_list_module_items_list .icon_button_add').css('visibility', 'visible');
            AMI.$('div#component_relations_list_module_items_list .icon_button_add').css('background', 'none');
            AMI.$('div#component_relations_list_module_items_list .icon_button_add').css('border', 'none');
            if(AMI.Page.reloadListAfterAction == 'selected_items_list'){
                AMI.Page.doModuleAction(oComponent.oModule.moduleId, 'selected_items_list', 'list_view', {ami_full: 1});
            }
        }
        return true;
    },
    true);
}

"-->
