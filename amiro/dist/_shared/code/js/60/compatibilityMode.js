AMI.PartialAsync = {
    initialized:  false,
    actions: [],
    groupActions: [],
    blankActions: [],
    oldCheckForm: function(){},
    oldUserClick: null,
    confirms: {},

    /**
     * Initialize partial async mode helper.
     *
     * aParams = {
     *    actions       : [ list_edit: "edit", list_delete: function(){...} ],
     *    groupActions  : ["grp_list", "grp_del"],          // List of group actions that should go into 5.0 code
     *    blankActions  : ["edit"],                         // List of actions that should open result on a new page
     *    scrollToForm  : boolean or ["edit", "save"],      // [bool: Scroll to form on action or not] or [array: list of 50 actions to scroll on]
     *    confirms      : ["delete": "Are you sure?"]       // Confirmation messages for specified actions
     * }
     */
    init: function(aParams){
        if(AMI.PartialAsync.initialized) return;
        AMI.PartialAsync.initialized = true;

        if(aParams.actions != undefined){
            AMI.PartialAsync.actions = aParams.actions;
        }
        if(aParams.groupActions != undefined){
            AMI.PartialAsync.groupActions = aParams.groupActions;
        }
        if(aParams.blankActions != undefined){
            AMI.PartialAsync.blankActions = aParams.blankActions;
        }
        if((aParams.scrollToForm != undefined) && aParams.scrollToForm){
            var needScroll = false;
            if(typeof(AMI.Page.aHashData) != 'undefined' && typeof(AMI.Page.aHashData[module_name]) != 'undefined' && typeof(AMI.Page.aHashData[module_name].force_scroll_to_form) != 'undefined'){
                needScroll = true;
                AMI.Page.deleteHashData(module_name, 'force_scroll_to_form');
            }
            if((typeof(aParams.scrollToForm) == 'object') && (typeof(module50action) != 'undefined')){
                if((aParams.scrollToForm.indexOf(module50action) >= 0) || (typeof(aParams.scrollToForm[module50action]) != 'undefined')){
                    needScroll = true;
                }
            }else{
                needScroll = true;
            }
            if(needScroll){
                AMI.PartialAsync.scrollToForm();
            }
        }
        if(aParams.confirms != undefined){
            AMI.PartialAsync.confirms = aParams.confirms;
        }
        AMI.$(document).ready(AMI.PartialAsync.onready);
    },

    onready: function(){
        AMI.PartialAsync.addModuleListener();
        if(typeof(CheckForm) != 'undefined'){
            AMI.PartialAsync.oldCheckForm = CheckForm;
            CheckForm = function(evt, form){
                var res = AMI.PartialAsync.oldCheckForm(evt, form);
                if(res){
                    _cms_document_form_changed = false;
                }
                return res;
            }
        }else if(typeof(validateForm) != 'undefined'){
            AMI.PartialAsync.oldCheckForm = validateForm;
            validateForm = function(form){
                var res = AMI.PartialAsync.oldCheckForm(form);
                if(res){
                    _cms_document_form_changed = false;
                }
                return res;
            }
        }

        AMI.PartialAsync.oldUserClick = user_click;
        user_click = function(action, id){
            if(action == 'none'){
                AMI.Message.removeListener('ON_PAGE_UNLOAD_FORM_CHANGED');
            }
            return AMI.PartialAsync.oldUserClick(action, id);
        }

        var oForm = AMI.PartialAsync.getForm();
        if(oForm){
            var hashData = document.createElement('INPUT');
            hashData.type = 'hidden';
            hashData.name = '_url_hash_data';
            hashData.id = '_url_hash_data';
            oForm.appendChild(hashData);
            AMI.PartialAsync.updateHash();
        }
    },

    updateHash: function(){
        if(AMI.find('#_url_hash_data')){
            AMI.find('#_url_hash_data').value = escape(document.location.hash);
            var currentAction = AMI.find('#_url_hash_data').parentNode.getAttribute('action');
            AMI.find('#_url_hash_data').parentNode.setAttribute('action', currentAction + document.location.hash);
        }
    },

    addModuleListener: function(){
        var listenerFunc = function(action, params){
            var confirmAction = action != 'group_action' ? action : params.oParameters.action;
            if(typeof(AMI.PartialAsync.confirms[confirmAction]) != 'undefined'){
                if(!confirm(AMI.PartialAsync.confirms[confirmAction])){
                    return false;
                }
            }
            if(typeof(AMI.PartialAsync.actions[action]) != 'undefined'){
                if(typeof(AMI.PartialAsync.actions[action]) != 'function'){
                    if(AMI.PartialAsync.actions[action] != false){
                        AMI.PartialAsync.do50Action(AMI.PartialAsync.actions[action], params.oParameters.id);
                    }
                }else{
                    AMI.PartialAsync.actions[action](params);
                }
                return false;
            }
            switch(action){
                case 'form_reset':
                    if((typeof(window.currentElementId) == 'undefined') || !parseInt(window.currentElementId)){
                        var oForm = AMI.PartialAsync.getForm();
                        if(oForm){
                            oForm.scrollIntoView();
                        }
                    }else{
                        AMI.Page.addHashData(module_name, {force_scroll_to_form: 1});
                        window.location.href = window.location.pathname + window.location.hash;
                    }
                    return false;
                case 'group_action':
                    return AMI.PartialAsync.do50GroupAction(AMI.PartialAsync.groupActions, params);
                default:
            }
            return true;
        };

        AMI.Message.addListener('ON_MODULE_ACTION', listenerFunc, true);
        AMI.Message.addListener('ON_AFTER_MODULE_ACTION', AMI.PartialAsync.updateHash, true);
    },

    do50Action: function(action, id){
        if(AMI.PartialAsync.blankActions.indexOf(action) >= 0){
            user_click_blank(action, id);
        }else{
            user_click(action, id);
        }
    },

    do50GroupAction: function(actions, params){
        var action = params.oParameters.action;
        if(typeof(actions[action]) != 'undefined'){
            var oForm = AMI.PartialAsync.getForm();
            if(!oForm){
                return false;
            }

            var
                str = ';',
                aCb = params.oComponent.aGroupIdCheckboxes;

            for(var i = 0; i < aCb.length; i++){
                if(aCb[i] && aCb[i].checked){
                    str += (aCb[i].value.toString() + ';');
                }
            }
            document.getElementsByName('_grp_ids')[0].value = str;
            document.getElementsByName('enc__grp_ids')[0].value = escape(str);

            if(typeof(actions[action]) == 'function'){
                actions[action](params);
            }else{
                // from _grpGetUrl
                var link = _cms_script_link;
                oForm.action.value = 'grp_' + actions[action];
                var url = link + collect_link(oForm);
                document.location = url
            }
            return false;
        }
        return true;
    },

    scrollToForm: function(){
        setTimeout(function(){
            var oForm = AMI.PartialAsync.getForm();
            if(oForm){
                // AMI.scrollTo(oForm);
                oForm.scrollIntoView();
                if(AMI.Page.Status.messages.length){
                    setTimeout(AMI.Page.Status.payAttention, 1000);
                }
            }
        }, 1000);
    },

    getForm: function(){
        if(typeof(_cms_document_form) != 'undefined'){
            return document.forms[_cms_document_form];
        }
        return null;
    }
}