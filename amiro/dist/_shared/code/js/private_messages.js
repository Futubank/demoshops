var amiPrivateMessagesPopup = '';
var hideUserMenuHandlerSet = false;
var moduleInitialization = function(){
    // Private Messages module specific handler.
    // Nowhere to move it yet.
    AMI.Message.addListener('ON_COMPONENT_GET_REQUEST_DATA', function(oComponent, oParameters){
        // send all modules get params to a component
        if(oComponent.paramSent == undefined){
            var fullQString = window.location.search.substring(1);
            var paramArray = fullQString.split("&");
            for (i=0;i<paramArray.length;i++)
            {
                var currentParameter = paramArray[i].split("=");
                if(currentParameter[0]){
                    if(oParameters[currentParameter[0]] == undefined){
                        oParameters[currentParameter[0]] = currentParameter[1];
                    }
                }
            }
            oComponent.paramSent = 1;
        }

        var moduleId = 'private_messages';
        oParameters['mode'] = 'inbox';

        var hashData = AMI.Page.getHashData(moduleId);
        if(hashData.sent){
            oParameters['mode'] = 'sent';
        }
        if(hashData.deleted){
            oParameters['mode'] = 'deleted';
        }
        if((AMI.Page.aModules[moduleId] != undefined) && (AMI.Page.aModules[moduleId].mode != undefined)){
            oParameters['mode'] = AMI.Page.aModules[moduleId].mode;
        }

        if(!hideUserMenuHandlerSet){
            AMI.Browser.Event.addHandler(document, 'click', function(evt){hideAllUserMenues(evt)});
            hideUserMenuHandlerSet = true;
        }

        return true;
    });

    AMI.Message.addListener('ON_AMI_LIST_ROW', function(oComponent, oParameters){
        if(oParameters.data.is_read != 1){
            oParameters.row.className = oParameters.row.className + ' not_read';
        }
        if(oParameters.data.sender_is_deleted == 1){
            oParameters.data.sender_nickname = '<span style="text-decoration:line-through">' + oParameters.data.sender_nickname + '</span>';
        }
        if(oParameters.data.recipient_is_deleted == 1){
            oParameters.data.recipient_nickname = '<span style="text-decoration:line-through">' + oParameters.data.recipient_nickname + '</span>';
        }
        return true;
    });

    AMI.Message.addListener('ON_AMI_FORM_READ_ALL_ACTION', function(oModule, oParameters){
        var moduleId = 'private_messages';
        oModule.getComponentsByType('form')[0].modAction = 'form_read_all';
        oModule.scheduleListReload = true;
        return false;
    });

    window.markMessageAsUnread = function(messageId){
        var moduleId = 'private_messages';
        var oList = AMI.Page.aModules[moduleId].getComponentsByType('list')[0];
        oList.skipEditor = 1;
        AMI.Page.doModuleAction(moduleId, oList, 'list_unread', {id:messageId, ami_full:1, calc_found_rows:1});
    }

    window.markAllAsRead = function(){
        AMI.Page.doModuleAction('private_messages', AMI.Page.aModules['private_messages'].getComponentsByType('form')[0], 'form_read_all', {ami_full:1});
    }

    window.amiPMCompose = function(){
        var contacts = document.getElementsByName('id_recipient')[0];
        if(contacts && (contacts.tagName == 'SELECT') && !contacts.options.length){
            alert(AMI.Template.Locale.get('contact_list_empty'), 'status_error');
            return;
        }
        var moduleId = 'private_messages';
        var cForm = AMI.Page.aModules[moduleId].getComponentsByType('form')[0];
        if(cForm.messageId){
            cForm.autoShowComposePopup = 1;
            AMI.Page.aModules[moduleId].openEditForm({id:''}, true);
        }else{
            amiPMShowMsgPopup();
        }
    }

    window.amiPMReply = function(){
        amiPMShowMsgPopup();
    }

    window.amiPMShowMsgPopup = function(){
        var txtArea = AMI.find('#idb_body');
        txtArea.style['max-width'] = txtArea.style.width;
        window.amiPrivateMessagesPopup = new AMI.UI.Popup(
            AMI.find('#div_compose_form'),
            {
                id: 'ami_private_messages_popup',
                header: AMI.find('#pmFormHeader').value,
                width:  650,
                height: 440,
                autosize: true,
                modal: true,
                onClose: function(){AMI.Page.aModules['private_messages'].getComponentsByType('form')[0].autoShowComposePopup = 0;}
            }
        );

        if(document.getElementsByName('preview').length){
            var previewBtn = document.getElementsByName('preview')[0];
            AMI.Browser.Event.addHandler(previewBtn, 'click', function(e){
                amiPrivateMessagesPopup.autosize(true);
            });
        }

    }

    window.amiPMCheckComposePopup = function(messageId, message_to_yourself){
        var moduleId = 'private_messages';
        var cForm = AMI.Page.aModules[moduleId].getComponentsByType('form')[0];
        if(!messageId){
            var id = AMI.Page.aModules[moduleId].getComponentsByType('form')[0].oContainer.getElementsByTagName('form')[0].elements['id'].value;
            if(id){
                messageId = id;
            }
        }
        cForm.messageId = messageId;
        if(message_to_yourself){
            alert(AMI.Template.Locale.get('message_to_yourself'), 'status_error');
            cForm.autoShowComposePopup = 0;
            AMI.Page.doModuleAction(moduleId, cForm.componentId, 'form_reset', {});
            return false;
        }
        if(!cForm.messageId && (cForm.autoShowComposePopup != undefined) && (cForm.autoShowComposePopup == 1)){
            amiPMCompose();
        }
    }
};