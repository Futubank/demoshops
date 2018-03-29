AMI.ForumFilter = {
    modId:       '',
    oComponent:  null,
    oForm:       null,
    useSections: false,
    oItemForm:   null,
    isInThread:  false,
    pathRefId:   null,
    lastThreadId: 0,
    doReloadFilter: null,

    init: function(){
        AMI.Message.addListener('ON_PAGE_CONTENT_RECEIVED', this.onPageContentReceived);
    },

    reset: function(){
        var doReload = this.oForm.elements['category'].value || this.oForm.elements['id_thread'].value;
        if(doReload){
            document.location.href = '?';
        }else{
            AMI.Page.doModuleAction(this.modId, this.oComponent.componentId, 'filter_reset', this.oForm);
        }
        return false;
    },

    selectSection: function(sectionId){
        this.resetThread();
        if(this.useSections){
            this.oForm.elements['category'].value = sectionId;
            this.oItemForm.elements['flt_section_id'].value = sectionId ? 0 : 1;
            this.oItemForm.elements['enc_flt_section_id'].value = sectionId ? 0 : 1;
        }
        this.doReloadFilter = true;
        this.oForm.onsubmit();
        if(this.doReloadFilter){
            this.oComponent.getContent();
        }
        return false;
    },

    onPageContentReceived: function(oMod){
        AMI.ForumFilter._onPageContentReceived(oMod);
        return true;
    },

    fillPathSection: function(refId){
        this.pathRefId = refId;
        this._fillPathRef();
    },

    onSubmit: function(oParameters){
        var doReload = false;

        if(this.useSections){
            var catId = parseInt(this.oForm.elements['category'].value);
            if(isNaN(catId)){
                catId = 0;
                this.oForm.elements['category'].value = catId;
            }
            if(catId > 0 && this.oForm.elements['category'].value != this.oItemForm.elements['flt_section_id'].value){
                this._setThreadId(0, oParameters);
                this.oItemForm.elements['flt_section_id'].value = this.oForm.elements['category'].value;
                doReload = true;
            }
        }
        this._checkGroupActions();
        this._set50FormFilterData();
        if(doReload){
            AMI.Page.addHashData(this.modId, {category: this.oForm.elements['category'].value});
            user_click('rsrtme', '');
            this.doReloadFilter = false;
            return false;
        }
        return true;
    },

    onReset: function(oParameters){
        if(
            (this.useSections && (this.oForm.elements['category'].value != this.oItemForm.elements['flt_section_id'].value)) ||
            parseInt(this.oForm.elements['id_thread'].value) != 0
        ){
            document.location.href = '?';
            return false;
        }
        // if(this.useSections && this.oForm.elements['category'].value){
            this.resetThread();
        // }
        return true;
    },

    displayThread: function(threadId, sectionId, sortCol, sortDir){
        var
            topicsOnly = threadId ? 0 : 1,
            oHash = {
                topics_only: topicsOnly,
                flt_topics_only: topicsOnly,
                id_thread: threadId,
                flt_id_thread: threadId
            };

        this._setThreadId(threadId);
        this.oItemForm.elements['flt_id_thread'].value = threadId;
        this.oItemForm.elements['enc_flt_id_thread'].value = threadId;
        if(this.useSections && sectionId){
            this.oForm.elements['category'].value = sectionId;
            this.oItemForm.elements['flt_section_id'].value = sectionId;
            this.oItemForm.elements['enc_flt_section_id'].value = sectionId;
            oHash.category = sectionId;
            oHash.flt_section_id = sectionId;
        }
        if(typeof(sortCol) != 'undefined'){
            if(typeof(sortDir) == 'undefined'){
                sortDir = 'desc';
            }
            oHash.sort_column = sortCol;
            oHash.sort_dir = sortDir;
        }
        AMI.Page.addHashData(this.modId, oHash);
        user_click('rsrtme', '');
        // this.oForm.onsubmit();
        return false;
    },

    resetThread: function(oParameters){
        if(this.oItemForm.elements['flt_id_thread'].value){
            this._setThreadId(0, oParameters);
        }
        this._checkGroupActions();
    },

    setItemFormFields: function(oFields){
        for(var k in oFields){
            this.oItemForm.elements[k].value = oFields[k];
            this.oItemForm.elements['enc_' + k].value = oFields[k];
        }
    },

    _onPageContentReceived: function(oMod){
        if(this.oComponent == null){
            // first load
            this.oComponent = oMod.getComponentsByType('form_filter')[0];
            this.modId = this.oComponent.oModule.moduleId;
            this.oForm = this.oComponent.oForm;
            this.useSections = typeof(this.oForm.elements['category']) != 'undefined';
            this.oItemForm = document.forms[_cms_document_form];
            this.isInThread = this.oForm.elements['id_thread'].value ? true : false;
            this.lastThreadId = this.isInThread ? parseInt(this.oForm.elements['id_thread'].value) : 0;
        }else{
            // components refreshing
            var isInThread = this.oForm.elements['id_thread'].value ? true : false;
            if(isInThread != this.isInThread){
                this.isInThread = isInThread;
                this.oComponent.getContent();
            }
        }
        this._fillPathRef();
    },

    _setThreadId: function(threadId, oParameters){
        var
            setParameters = typeof(oParameters) != 'undefined',
            topicsOnly = threadId ? 0 : 1;

        this.oForm.elements['topics_only'].value = topicsOnly;
        this.oForm.elements['id_thread'].value = threadId;
        this.oItemForm.elements['flt_topics_only'].value = topicsOnly;
        this.oItemForm.elements['enc_flt_topics_only'].value = topicsOnly;
        if(setParameters){
            oParameters.oParameters.topics_only = topicsOnly;
            oParameters.oParameters.id_thread = threadId;
        }
        AMI.Page.addHashData(
            this.modId,
            {
                topics_only: topicsOnly,
                id_thread: threadId,
                flt_topics_only: topicsOnly,
                flt_id_thread: threadId
            }
        );
    },

    _checkGroupActions: function(){
        if(this.lastThreadId != this.oForm.elements['id_thread'].value){
            this.oComponent.oModule.getComponentsByType('list')[0].oList = null;
        }
        this.lastThreadId = this.isInThread ? parseInt(this.oForm.elements['id_thread'].value) : 0;
    },

    _set50FormFilterData: function(){
        if(this.useSections){
            this.oItemForm.elements['flt_section_id'].value = this.oForm.elements['category'].value;
            this.oItemForm.elements['enc_flt_section_id'].value = this.oForm.elements['category'].value;
        }
        this.oItemForm.elements['flt_id_thread'].value = this.oForm.elements['id_thread'].value;
        this.oItemForm.elements['enc_flt_id_thread'].value = this.oForm.elements['id_thread'].value;
    },

    _fillPathRef: function(){
        if(this.pathRefId === ''){
            return;
        }
        if(this.pathRefId !== null && this.oComponent !== null){
            AMI.$('#' + this.pathRefId)[0].innerHTML = AMI.$(':selected', this.oForm.elements['category'])[0].text;
            this.pathRefId = '';
        }
    }
};

AMI.ForumFilter.init();
