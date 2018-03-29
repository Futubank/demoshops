AMI.DiscussionFilter = {
    oComponent:            null,
    oForm:                 null,
    oItemForm:             null,
    hasTree:               false,
    forceParentLevel:      null,
    skipModActionHandling: false,
    isPopup:               null,

    init: function(){
        AMI.Message.addListener('ON_PAGE_CONTENT_RECEIVED', this.onPageContentReceived);
        AMI.Message.addListener('ON_MODULE_ACTION', this.onModuleAction);
    },

    setParentId: function(parentId){
        var level = parentId ? parseInt(this.oForm.elements['flt_parent_level'].value) + 1 : 0;

        this.oForm.elements['flt_parent_level'].value = level;
        this.oForm.elements['flt_id_parent'].value = parentId;
        this.oItemForm.elements['flt_id_parent'].value = parentId;
        this.oItemForm.elements['enc_flt_id_parent'].value = parentId;
        this.oItemForm.elements['flt_parent_level'].value = level;
        this.oItemForm.elements['enc_flt_parent_level'].value = level;
        var oData =
            {
                flt_id_parent:    parentId,
                flt_parent_level: level
            };
        if(typeof(this.oForm.elements['ext_module']) != 'undefined'){
            // Discussion module data
            oData.ext_module = this.oForm.elements['ext_module'].value;
            oData.id_ext_module = this.oForm.elements['id_ext_module'].value;
        }
        AMI.Page.addHashData(this.oComponent.oModule.moduleId, oData);
        user_click('reply', parentId);
        return false;
    },

    // Comments module {

    setModId: function(modId){
        if(
            parseInt(this.oForm.elements['id_ext_module'].value) > 0 ||
            (this.oForm.elements['ext_module'].value != this.oItemForm.elements['ext_module'].value)
        ){
            // Reload all page because of form
            var oArgs = {ext_module: modId};
            if(this.isPopup){
                oArgs.popup = 1;
                oArgs.id_ext_module = this.oForm.elements['id_ext_module'].value;
            }
            document.location.href = '?' + AMI.$.param(oArgs);
        }else{
            this.oForm.elements['ext_module'].value = modId;
            this.oForm.elements['flt_id_parent'].value = 0;
            this.oForm.onsubmit();
            /// @todo: reload filter
        }
        return false;
    },

    displayItemMessages: function(modId, modItemId, parentId, action){
        var
            oData =
                {
                    ext_module:    modId,
                    id_ext_module: modItemId,
                    flt_id_parent: parentId
                };

        if(typeof(action) == 'undefined'){
            action = 'rsrtme';
        }

        if(parseInt(this.oForm.elements['flt_id_parent'].value) != 0){
            if(typeof(this.oForm.elements['flt_parent_level']) != 'undefined'){
                oData.flt_parent_level =
                    this.forceParentLevel == null
                        ? parseInt(this.oForm.elements['flt_parent_level'].value) + 1
                        : this.forceParentLevel;
            }else{
                oData.flt_parent_level = 0;
            }
        }

        AMI.Page.addHashData(this.oComponent.oModule.moduleId, oData);

        this.oItemForm.elements['id_ext_module'].value = modItemId;
        this.oItemForm.elements['enc_id_ext_module'].value = modItemId;
        this.oItemForm.elements['enc_ext_module'].value = modId;
        this.oItemForm.elements['ext_module'].value = modId;
        if(typeof(this.oItemForm.elements['id_parent']) != 'undefined' && this.forceParentLevel == null){
            this.oItemForm.elements['id_parent'].value = parentId;
            // parentId = modItemId;
        }
        currentElementId = -1;
        user_click(action, parentId);
        return false;
    },

    resetLevel: function(){
        this.forceParentLevel = 0;
        return this.displayItemMessages(this.oForm.elements['ext_module'].value, this.oForm.elements['id_ext_module'].value, parseInt(rootId), 'reply');
    },

    // } Comments module

    onPageContentReceived: function(oMod){
        return AMI.DiscussionFilter._onPageContentReceived(oMod);
        true;
    },

    onModuleAction: function(action, oArgs){
        return AMI.DiscussionFilter._onModuleAction(action, oArgs);
    },

    _onPageContentReceived: function(oMod){
        if(this.oComponent == null){
            // first load
            this.oComponent = oMod.getComponentsByType('form_filter')[0];
            this.oForm = this.oComponent.oForm;
            this.oItemForm = document.forms[_cms_document_form];
            this.hasTree = typeof(this.oForm.elements['flt_parent_level']) != 'undefined';
            this.isPopup = typeof(this.oForm.elements['popup']) != 'undefined';
        }
        if(this.hasTree){
            var level = this.oForm ? parseInt(this.oForm.elements['flt_parent_level'].value) : 0;
            if(level  && AMI.$('#discussion-parent-level').length > 0){
                var path = '';
                for(var i = 0; i < parseInt(this.oForm.elements['flt_parent_level'].value); i++){
                    path += '../';
                }
                AMI.$('#discussion-parent-level')[0].innerHTML = path.substr(0, path.length - 1);
            }
        }
        return true;
    },

    _onModuleAction: function(action, oArgs){
        if(this.skipModActionHandling){
            this.skipModActionHandling = false;
            return true;
        }
        switch(oArgs.oRealComponent.oModule.moduleId){
            case 'discussion':
                var isExtModSelected = parseInt(this.oForm.elements['id_ext_module'].value) > 0;
                switch(action){
                    case 'filter':
                        if(isExtModSelected || (this.oForm.elements['ext_module'].value != this.oItemForm.elements['ext_module'].value)){
                            this.skipModActionHandling = true;
                            return this.setModId(this.oForm.elements['ext_module'].value);
                        }
                        break;
                    case 'filter_reset':
                        if(isExtModSelected){
                            document.location.href = '?' + (this.isPopup ? '&popup=1&ext_module=' + this.oForm.elements['ext_module'].value + '&id_ext_module=' + this.oForm.elements['id_ext_module'].value : '');
                            return false;
                        }
                        break;
                }
                break;
            case 'guestbook':
                switch(action){
                    case 'filter_reset':
                        if(document.getElementById('discussion-parent-level')){
                            document.location.href = '?';
                            return false;
                        }
                        break;
                }
                break;
        }
        return true;
    }

}

AMI.DiscussionFilter.init();
