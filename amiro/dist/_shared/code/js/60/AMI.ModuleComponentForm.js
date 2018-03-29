/**
* @fileOverview File contains AMI.ModuleComponentForm class that creates add/edit form and manages its actions.
*/

/**
* Class of form component inhertited from AMI.ModuleComponent that load and draws form received from server, and contains methods for submitting form storing actual form state.
*
* @class Form component class.
* @param {AMI.Module} oModule Module object.
* @param {string} componentType Type of component (filter_form, form, list).
* @param {bool} fullEnv  Flag specifying always full environment mode.
* @param {string} componentId Id of current component.
*/
AMI.ModuleComponentForm = function(oModule, componentType, fullEnv, componentId){
    AMI.ModuleComponentForm.superclass.constructor.call(this, oModule, componentType, fullEnv, componentId);
    this.componentType = componentType;
    this.defaultEnvMode = fullEnv;
    this.modAction = 'form_edit';
    this.hashDataFilter = 'id';

    this.expectedReturn = '';
    this.appliedId = 0;
    this.oForm = undefined;
    this.bScrollToForm = false;
    this.bFocusAtHeader = false;

    if(typeof(_cms_form_changed_alert) == 'undefined'){
        window._cms_form_changed_alert = AMI.Template.Locale.get('form_changed');
    }
    // Opera workaround to emulate onbeforeunload event
    if(AMI.Browser.isOpera){
        if(typeof(AMI.$) != 'undefined'){
            AMI.$('a[operaunloadhandler!=1]').click(function(e){
                AMI.$(this).attr('operaunloadhandler', 1)
                var href = AMI.$(this).attr('href');
                if(href && (href.indexOf('#') != 0)){
                    if(_cms_document_form_changed){
                        if(!confirm(_cms_form_changed_alert)){
                            AMI.Browser.Event.stopProcessing(e);
                        }
                    }
                }
            });
        }
    }
    AMI.Message.addListener('ON_PAGE_UNLOAD_FORM_CHANGED', function(){return _cms_form_changed_alert;});
    AMI.Message.addListener('ON_MODULE_FORM_RESET_ACTION', function(oComponent, oParameters){
        if((typeof(fullEnvForms) != 'undefined') && (typeof(fullEnvForms[oComponent.componentId]) != 'undefined') && fullEnvForms[oComponent.componentId]){
            oComponent.ami_full = 1;
            oParameters.ami_full = 1;
        }
        return true;
    })

    /**
     * FORM ACTIONS
     */

    // Reset form
    this.addAction('form_reset', function(oComponent, oParameters){
        if(oComponent.relatedComponents.length){
            // Reset related lists
            var oRelatedComponents = oComponent.getRelatedComponents();
            for(var componentId in oRelatedComponents){
                if(oRelatedComponents[componentId].componentType == 'list'){
                    oRelatedComponents[componentId].setRowClassById(0, '');
                }
            }
        }else{
            // Reset first list component
            var aListComponent = oComponent.oModule.getComponentsByType('list');
            if(aListComponent.length > 0){
                aListComponent[0].setRowClassById(0, '');
            }
        }
        oParameters.id = '';
        if(typeof(oParameters['isListAddButton']) != 'undefined' && oParameters['isListAddButton']){
            oParameters['scrollToForm'] = true;
        }
        var scrollToForm = oParameters['scrollToForm'] == 'undefined' ? true : false;
        var focusAtHeader = !scrollToForm;
        oComponent.oModule.openEditForm(oParameters, scrollToForm, focusAtHeader);
        return true;
    });

    // Save
    this.addAction('form_save', function(oComponent, oParameters){
        oComponent.oModule.scheduleListReload = true;
        if(AMI.Message.send('ON_FORM_SUBMIT', oComponent, oParameters)){
            oComponent.submitForm(oParameters);
        }
        AMI.Page.Status.skipHideOnce();
        return true;
    },
    false);

    /**
     * Form fields changing handler.
     *
     * @param  {string}   name         Changing field name
     * @param  {bool}     isFirstTime  Flag specifying is field is changed first time
     * @param  {DOMEvent} evt          Event
     * @return {bool}  True to accept changes, false otherwise
     * @since  5.12.8
     */
    this.onChange = function(name, isFirstTime, evt){
        return AMI.Message.send('ON_FORM_FIELD_CHANGED', {
            'target':      evt && evt.currentTarget ? evt.currentTarget : null,
            'name':        name,
            'isFirstTime': isFirstTime,
            'event':       evt
        });
    }

    if(typeof(addFormChangedHandler) == 'function'){
        addFormChangedHandler(this.onChange);
    }

    AMI.Message.addListener('ON_PAGE_CONTENT_RECEIVED', function(){
        AMI.Message.send('ON_AMI_LIST_SHOW_ADD_BUTTON', this);
        return true;
    });

    /**
    * Submit form and set callback for replace form content when response is received.
    *
    * @param {object} oParameters Associative array of data that will be posted to server. return_type and mod_id will be automatically added to posted data.
    * @returns {void}
    */
    this.submitForm = function(oParameters){

        this.oForm = oParameters['_form_object'];
        delete(oParameters['_form_object']);

        this.updateHtmlEditorFields(oParameters);

        if(!this.validateForm()){
            return false;
        }

        if(typeof(oParameters.action) != 'undefined' && oParameters.action == 'apply'){
            oParameters['return_type'] = this.expectedReturn = 'current';
        }else{
            oParameters['return_type'] = this.expectedReturn = 'new';
        }

        this.showLoader();

        oParameters['mod_id'] = this.oModule.moduleId;

        if(typeof oParameters['html_keywords'] != 'undefined'){
            oParameters['html_keywords'] = oParameters['html_keywords'].replace(/"/g, '');
            oParameters['html_description'] = oParameters['html_description'].replace(/"/g, '');
        }

        if(typeof(AMI_SessionData) != 'undefined' && AMI_SessionData.locale){
            oParameters.ami_locale = AMI_SessionData.locale;
            oParameters.ami_async = 1;
        }
        if(!AMI.Message.send('ON_FORM_POST_REQUEST_DATA', this, oParameters)){
            return;
        }

        oParameters.componentId = this.componentId;

        AMI.HTTPRequest.getContent(
            'POST',
            amiModuleLink || '',
            oParameters,
            function(_this){return function(state, content){_this.onContentReceived(state, content)}}(this)
        );
        if(oParameters['return_type'] == 'new'){
            var oElement = AMI.find('.componentList');
            if(typeof(oElement) == 'object'){
                var aMoveTo = AMI.Browser.getObjectPosition(oElement[0]);
                window.scrollTo(aMoveTo[0], aMoveTo[1]);
            }
        }
    }

    this.updateHtmlEditorFields = function(oParameters){
        for (var i = 0; i < this.oForm.elements.length; i++){
            var oField = this.oForm.elements[i];
            if(oField.className.match(new RegExp('(\\s|^)'+'htmlEditorTextarea'+'(\\s|$)'))){
                editor_updateHiddenField(oField.name);
                oParameters[oField.name] = oField.value;
            }
        }
    }

    /**
    * Callback that being called when form content is received.
    *
    * @private
    * @param {object} oData Associative array returned from server side.
    * @returns {void}
    */
    this.setBlockDataFromObject = function(oData){
        this.oDebug = null;
        if(typeof(oData.code) == 'undefined' || oData.code != 1){ // 1 means PHP AMI_ModForm::SAVE_SUCCEED
            this.oModule.scheduleListReload = false;
        }else{
            AMI.Browser.DOM.setInnerHTML(this.oContainer, oData.data.htmlCode);
        }
    }

    /**
    * Method that could be overriden. Called after the component is ready to place the content.
    *
    * @param {object} oData Evalled content that was received from server.
    * @returns {void}
    */
    this.onComponentContentReceived = function(oData){
        this.appliedId = 0;
        if(typeof(oData.data) != 'undefined'){
            if(oData.data.appliedId != 'undefined' && oData.data.appliedId > 0){
                this.appliedId = oData.data.appliedId;
            }
            if(oData.data.id != 'undefined' && oData.data.id > 0){
                AMI.Page.addHashData(this.getModuleId(), {'id': oData.data.id}, !this.primary);
            }
        }
    };

    /**
    * Callback method for form content placing. Sets hash data by form type
    *
    * @private
    * @returns {void}
    */
    this.onComponentContentPlaced = function(){

        this.oContainer.insertBefore(document.createElement('BR'), this.oContainer.firstChild);

        this.isNew = !this.expectedReturn || (this.expectedReturn == 'new');

        var oData = this.getHashData();
        if(this.expectedReturn == 'new' && typeof(oData.id) != 'undefined' && oData.id > 0){
            if(this.appliedId == 0){
                this.appliedId = oData.id;
            }
            this.addHashData({'id': ''});
        }else if(((this.expectedReturn == 'current') || (!this.expectedReturn)) && (typeof(oData.id) != 'undefined' && oData.id > 0)){
            this.isNew = false;
            if(this.appliedId == 0){
                this.appliedId = oData.id;
            }
        }

        if(
            document.getElementById('amiro-header__control__view-page')
        ){
            var
                oFrnURL = document.getElementById('amiro-header__control__view-page'),
                oQuery = AMI.HTTPRequest.parseURLQuery(oFrnURL.search),
                url = '', aQuery = [];

            if(!AMI.$(oFrnURL).prop('savedHRef')){
                AMI.$(oFrnURL).prop('savedHRef', oFrnURL.href);
            }
            if(!this.isNew && oData.id){
                if(!oFrnURL.pathname.match('ami_strict\.php$')){
                    url = oFrnURL.pathname.substr(1);
                    oFrnURL.href = editorBaseHref + 'ami_strict.php';
                    oQuery = {
                        ami_svc: 'ami_lookup',
                        ami_env: 'fast'
                    };
                }
                oQuery['lookup_mod_id'] = module_name;
                oQuery['lookup_id'] = oData.id;
                for(var k in oQuery){
                    aQuery.push(k + '=' + oQuery[k]);

                }
                oFrnURL.search = aQuery.join('&');
            }else{
                oFrnURL.href = AMI.$(oFrnURL).prop('savedHRef');
            }
        }

        if(this.oDOMElement){
            var input = document.createElement("input");
            input.setAttribute("type", "hidden");
            input.setAttribute("name", "componentName");
            input.setAttribute("disabled", true);
            input.setAttribute("value", this.componentId);
            this.oDOMElement.appendChild(input);
            this.scrollToForm();
            this.focusAtHeader();
        }

        var aFilterPages = document.getElementsByName('id_page');
        if(aFilterPages.length > 0){
            var oClone = aFilterPages[0].cloneNode(true);
            var oParameters = {
                'pagesElement': oClone.innerHTML
            };
            AMI.Message.send('ON_PAGES_ELEMENT_RECEIVED', oParameters);
        }
        var aCatPages = document.getElementsByName('cat');
        if(aCatPages.length > 0){
            oClone = aCatPages[0].cloneNode(true);
            oParameters = {
                'catsElement': oClone.innerHTML
            };
            AMI.Message.send('ON_CATS_ELEMENT_RECEIVED', oParameters);
        }
    }

     /**
     * Sets focus at header field if present.
     *
     * @returns {void}
     */
    this.focusAtHeader = function(){
        if(this.oDOMElement && this.bFocusAtHeader){
            var headerElements = AMI.find('INPUT[name=header]', this.oDOMElement);
            if(headerElements && headerElements.length){
                headerElements[0].focus();
            }
            this.bFocusAtHeader = false;
        }
    }

    /**
    * Load form and place to component area. Also page will be scrolled to form if allowed.
    *
    * @param {bool} bScrollToForm Allow or not to scroll page to form. true by default.
    * @returns {void}
    */
    this.loadForm = function(bScrollToForm){
        var oData = this.getHashData();
        if(typeof(oData.id) != 'undefined' && oData.id > 0){
            this.expectedReturn = 'current';
        }else{
            this.expectedReturn = 'new';
        }

        this.getContent();

        this.bScrollToForm = bScrollToForm;
        this.scrollToForm();
    }

    /**
    * Scrolls page to the form element.
    *
    * @returns {void}
    */
    this.scrollToForm = function(){
        if(this.oDOMElement && this.bScrollToForm){
            var aMoveTo = AMI.Browser.getObjectPosition(this.oDOMElement);
            window.scrollTo(aMoveTo[0], aMoveTo[1]);
            this.bScrollToForm = false;
        }
    }

    /**
    * Method returns current form id and state. For example this required for rows highligting.
    *
    * @returns {object} Returns associative array like {'id': x, 'type': 'edit' or 'new'}.
    */
    this.getAppliedData = function(){
        var oRes = {};
        if(this.expectedReturn != ''){
            var oRes = {
                'id': this.appliedId,
                'type': this.expectedReturn == 'current' ? 'edit' : 'new'
            };
        }

        return oRes;
    }

    this.focusAt = function(oFieldElement){
        var oParent = oFieldElement;
        var stop = false;
        var oTab = null;
        while(!stop){
            oParent = oParent.parentNode;
            if ((oParent.tagName == 'FORM') || (oParent.tagName == 'BODY')){
                stop = true;
            }
            if((oParent.tagName == 'DIV') && (oParent.className.match(new RegExp('(\\s|^)tab-page(\\s|$)')))){
                oTab = oParent;
                stop = true;
            }
        }
        // There's a tab, activate it
        if(oTab != null){
            if(typeof(baseTabs) != 'undefined'){
                var tabName = oTab.id.replace('tab-page-', '');
                var oTabControl = AMI.find('#tab-control-' + tabName);
                baseTabs.selectTab(oTabControl, true);
            }
        }

        // Focus
        if(oFieldElement.editorAttached && oFieldElement.editorObject.currentMode == 'editor'){
            oFieldElement.editorObject.focusWindow(); // CE
        }else{
            oFieldElement.focus(); // Other fields
        }
    }

    /**
    * Validate current form fields.
    *
    * @returns {bool}
    */
    this.validateForm = function(){

        var
        error = false,
        focusField = false,
        oFirstFocusField = false;

        for (var i = 0; i < this.oForm.elements.length; i++){
            var oField = this.oForm.elements[i];
            if(oField.hasAttribute('data-ami-validators')){
                // this.highlightElementAsOk(oField.name);
            }
        }

        for (var i = 0; i < this.oForm.elements.length; i++){
            var oField = this.oForm.elements[i];
            if(oField.hasAttribute('data-ami-validators')){
                var validatorsString = oField.getAttribute('data-ami-validators');
                var aValidators = validatorsString.split(' ');
                for (var v = 0; v < aValidators.length; v++){
                    var validator = aValidators[v];
                    if(validator){
                        if((typeof(oField.value) == 'undefined' || oField.value == '') && !validatorsString.match(/filled/)){
                            continue;
                        }
                        aValidate = this.validateField(oField, validator);
                        if(aValidate.error){
                            error = true;
                            if(!focusField){
                                oFirstFocusField = oField;
                            }
                            focusField = oField.name;
                            this.focusAt(oField);
                            // this.highlightFieldAsError(oField.name);
                            if(validatorsString.match(/stop_on_error/)){
                                message = aValidate.customMessage;
                                if(message == ''){
                                    if(AMI.Template.Locale.get('form_field_' + oField.name + '_empty_warn') != null){
                                        message = AMI.Template.Locale.get('form_field_' + oField.name + '_empty_warn');
                                    }
                                    if(AMI.Template.Locale.get('form_field_' + oField.name + '_invalid_warn') != null){
                                        message = AMI.Template.Locale.get('form_field_' + oField.name + '_invalid_warn');
                                    }
                                }
                                this.showError(focusField, message);
                                return false;
                            }
                        }
                    }
                }
            }
        }
        if(error){
            message = '';
            if(AMI.Template.Locale.get('form_field_' + oFirstFocusField.name + '_empty_warn') != null){
                message = AMI.Template.Locale.get('form_field_' + oFirstFocusField.name + '_empty_warn');
            }
            if(AMI.Template.Locale.get('form_field_' + oFirstFocusField.name + '_invalid_warn') != null){
                message = AMI.Template.Locale.get('form_field_' + oFirstFocusField.name + '_invalid_warn');
            }
            this.showError(oFirstFocusField.name, message);
            return false;
        }

        return true;
    }

    /**
     * Validate field oField vith some validator (alphanum, float, etc).
     *
     * @returns {bool}
     */
    this.validateField = function(oField, validator){
        var error = false;
        var customMessage = '';
        var value = oField.value;
        switch(validator){
            case 'alphanum':
                error = !value.match(/^[0-9a-zA-Z]+$/);
                if(error){
                    customMessage = AMI.Template.Locale.get('validator_format');
                }
                break;
            case 'float':
            case 'double':
                value = value.replace(',', '.');
                oField.value = value;
                error = !value.match(/^-?[0-9]+\.?[0-9]*$/);
                if(error){
                    customMessage = AMI.Template.Locale.get('validator_format');
                }
                break;
            case 'date':
            case 'date_limits':
                oDate = this.parseDate(value);
                if(!oDate){
                    error = true;
                    customMessage = AMI.Template.Locale.get('form_field_date_created_invalid_warn');
                }else{
                    oEndDate = this.parseDate(oField.getAttribute('data-ami-max-date'));
                    oStartDate = this.parseDate(oField.getAttribute('data-ami-min-date'));
                    if(oEndDate && oStartDate && (oDate < oStartDate || oDate > oEndDate)){
                        error = true;
                        customMessage = AMI.Template.Locale.get('form_field_date_created_invalid_warn');
                    }
                }
                break;
            case 'time':
                error = !value.match(/^[0-9]{1,2}\:[0-9]{1,2}\:[0-9]{2,4}$/);
                if(error){
                    customMessage = AMI.Template.Locale.get('validator_format');
                }
                break;
            case 'email':
                error = value != '' && !value.match(/^(\w+[\w.-]*\@[A-Za-z0-9а-яёА-ЯЁ]+((\.|-+)[A-Za-z0-9а-яёА-ЯЁ]+)*\.[\-A-Za-z0-9а-яёА-ЯЁ]+(;|,|$))+$/);
                if(error){
                    customMessage = AMI.Template.Locale.get('validator_format');
                }
                break;
            case 'domain':
                error = !value.match(/^([A-Za-z0-9а-яёА-ЯЁ_\-\.])+\.([A-Za-zа-яёА-ЯЁ]{2,4})$/);
                if(error){
                    customMessage = AMI.Template.Locale.get('validator_format');
                }
                break;
            case 'int':
                error = !value.match(/^-?[0-9]*$/);// isNaN(parseInt(value));
                if(error){
                    customMessage = AMI.Template.Locale.get('validator_format');
                }
                break;
            case 'filled':
                error = (typeof(value) == 'undefined' || value == '');
                var message = AMI.Template.Locale.get('validator_filled_' + oField.name);
                if(message){
                    customMessage = message;
                }
                if(error && customMessage == ''){
                    customMessage = AMI.Template.Locale.get('validator_filled');
                }
                break;
            case 'url':
                error = !value.match(/^https?:\/\/[a-z0-9а-яёА-ЯЁ-]+(\.[a-z0-9а-яёА-ЯЁ-]+)+([/?].+)?$/);
                if(error){
                    customMessage = AMI.Template.Locale.get('validator_format');
                }
                break;
            case 'sublink':
                var locale = '';
                if(
                    value.search(/[ ]/) != -1 ||
                    value.search(/^[0-9a-zA-Z\-\_\.\/]+$/) == -1
                ){
                    locale = 'sublink_invalid_symbols';
                }
                error = (locale != '');
                if(error){
                    customMessage = AMI.Template.Locale.get(locale);
                }
                break;
            case 'custom':
                oParameters = {
                    'oComponent': this,
                    'oForm':      this.oForm,
                    'oField':     oField,
                    'error':      false,
                    'message':    ''
                };
                AMI.Message.send('ON_FORM_FIELD_VALIDATE', oParameters);
                customMessage = oParameters.message;
                error = oParameters.error;
                AMI.Message.send('ON_FORM_FIELD_VALIDATE_' + oField.name.toUpperCase(), oParameters);
                break;
        }
        return {error: error, customMessage: customMessage};
    }

    /**
    * Highlight field as error field.
    *
    * @return
    */
    this.highlightFieldAsError = function(name){
        this.oForm.elements[name].style.backgroundColor = '#fdd';
    }

    /**
    * Highlight field as field without error.
    *
    * @return
    */
    this.highlightFieldAsOk = function(name){
        this.oForm.elements[name].style.backgroundColor = '';
    }

    /**
    * Show error and place focus to error field.
    *
    * @return
    */
    this.showError = function(focusField, customMessage){
        if(focusField){
            this.focusAt(this.oForm.elements[focusField]);
        }
        if(typeof(customMessage) == 'undefined'){
            customMessage = '';
        }
        // alert(AMI.Template.Locale.get('errors_found') + customMessage);
        if(customMessage == '' || customMessage == null){
            alert(AMI.Template.Locale.get('errors_found'));
        }else{
            alert(customMessage);
        }

        return false;
    }

    /**
     * Parse string as a date.
     * Returns false or Date object.
     *
     * @returns false|Date
     */
    this.parseDate = function(value){

        if(!value){
            return false;
        }

        if(!value.match(new RegExp('^' + calendarFormat.replace(/[DMY]/g,'\\d') + '$'))){
            return false;
        }

        dayIndex = calendarFormat.indexOf('DD');
        monthIndex = calendarFormat.indexOf('MM');
        yearLongIndex = calendarFormat.indexOf('YYYY');
        yearIndex = calendarFormat.indexOf('YY');

        day = value.substr(dayIndex,2);
        month = value.substr(monthIndex,2);
        if(yearLongIndex>=0){
            year = value.substr(yearLongIndex,4);
        }else{
            year = value.substr(yearIndex,2);
            if(year<40){
                year = '20' + year;
            }else{
                year = '19' + year;
            }
        }

        var oDate = new Date(month + "/" + day + "/" + year);

        if(oDate.getDate() != day ||  oDate.getMonth() != month-1 || oDate.getFullYear() != year){
            return false;
        }
        return oDate;
    }

    this.init();
}
AMI.inherit(AMI.ModuleComponentForm, AMI.ModuleComponent);
