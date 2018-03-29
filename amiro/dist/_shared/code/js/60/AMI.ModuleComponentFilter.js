/**
* @fileOverview File contains AMI.ModuleComponentFilter class that creates module filter and manages its actions.
*/

/**
* Class of filter component inhertited from AMI.ModuleComponent that setup values filter rules and contains custom functionality.
*
* @class Filter component class.
* @param {AMI.Module} oModule Module object.
* @param {string} componentType Type of component (filter_form, form, list).
* @param {bool} fullEnv  Flag specifying always full environment mode.
* @param {string} componentId Id of current component.
*/
AMI.ModuleComponentFilter = function(oModule, componentType, fullEnv, componentId){
    AMI.ModuleComponentForm.superclass.constructor.call(this, oModule, componentType, fullEnv, componentId);
    this.componentType = componentType;
    this.defaultEnvMode = fullEnv;
    this.modAction = 'filter_view';
    //this.hashDataFilter = '^flt_.*';
    this.hashDataFilter = '.*';
    this.oForm = null;

    /**
     * Filter list action handler.
     */
    this.addAction('filter', function(oComponent, oParameters){
        var oModule = oComponent.oModule;
        var oRelatedComponents = oComponent.getRelatedComponents();
        oParameters['offset'] = 0;
        oComponent.addHashData(oParameters);
        for(var componentId in oRelatedComponents){
            oRelatedComponents[componentId].addHashData(oParameters);
            oModule.reloadList(oRelatedComponents[componentId]);
        }
        return true;
    },
    false);

    /**
     * Reset filter action handler.
     */
    this.addAction('filter_reset', function(oComponent, oParameters){
        var oModule = oComponent.oModule;
        var oRelatedComponents = oComponent.getRelatedComponents();
        oComponent.resetFilter(oParameters);
        return true;
    },
    false);

    /**
    * Callback method that is being called when filter form content placed to component area. Finds and set form DOM object.
    *
    * @private
    * @returns {void}
    */
    this.onComponentContentPlaced = function(){
        this.oForm = null;

        var aForms = AMI.find('FORM', this.oContainer);
        if(aForms.length > 0){
            this.oForm = aForms[0];
        }

        if(this.oDOMElement){
            var input = document.createElement("input");
            input.setAttribute("type", "hidden");
            input.setAttribute("name", "componentName");
            input.setAttribute("disabled", true);
            input.setAttribute("value", this.componentId);
            this.oDOMElement.appendChild(input);
        }
        var oFormValues = AMI.Page.getFormValues(this.oForm);
        var oRelatedComponents = this.getRelatedComponents();
        this.addHashData(oFormValues);
        for(var componentId in oRelatedComponents){
            if(!oRelatedComponents[componentId].primary){
                oRelatedComponents[componentId].addHashData(oFormValues);
            }
        }
        var aFilterPages = document.getElementsByName('id_page');
        if(aFilterPages.length > 0){
            var oClone = aFilterPages[0].cloneNode(true);
            oClone.options[1] = null;
            oClone.options[0].value = 0;
            var oParameters = {
                'pagesElement': oClone.innerHTML
            };
            AMI.Message.send('ON_PAGES_ELEMENT_RECEIVED', oParameters);
        }
        var aCatPages = document.getElementsByName('category');
        if(aCatPages.length > 0){
            var oClone = aCatPages[0].cloneNode(true);
            var oParameters = {
                'catsElement': oClone.innerHTML
            };
            AMI.Message.send('ON_CATS_ELEMENT_RECEIVED', oParameters);
        }
    };

    /**
    * Reset filter and reload list if required.
    *
    * @returns {void}
    */
    this.resetFilter = function(){
        this.oForm.reset();

        for(var i = 0; i < this.oForm.elements.length; i++){
            var oField = this.oForm.elements[i];
            if(!oField.disabled && oField.name != ''){
                var defaultInputs = document.getElementsByName('default_value_' + oField.name);
                if(defaultInputs && defaultInputs.length){
                    var defaultInput = defaultInputs[0];
                    var defaultValue = defaultInput.value;
                    if((oField.nodeName == 'INPUT')){
                        if(oField.type == 'checkbox'){
                            oField.checked = parseInt(defaultValue) ? true : false;
                        }else{
                            oField.value = defaultValue;
                        }
                    }
                    if((oField.nodeName == 'SELECT')){
                        if(defaultValue == ''){
                            AMI.$(oField).val('');
                        }else{
                            for(var index = 0; index < oField.length; index++){
                                if(oField[index].value == defaultValue){
                                     oField.selectedIndex = index;
                                }
                            }
                        }
                    }
                }
            }
        }
        var hashData = AMI.Page.getFormValues(this.oForm);
        this.addHashData(hashData);
        var oRelatedComponents = this.getRelatedComponents();
        for(var componentId in oRelatedComponents){
            oRelatedComponents[componentId].addHashData(hashData);
            oModule.reloadList(oRelatedComponents[componentId]);
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
             this.focusAt(oFirstFocusField);
             //this.showError(oFirstFocusField.name, message);
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
                break;
            case 'float':
            case 'double':
                value = value.replace(',', '.');
                oField.value = value;
                error = !value.match(/^-?[0-9]+\.?[0-9]*$/);
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
                break;
            case 'email':
                error = value != '' && !value.match(/^(\w+[\w.-]*\@[A-Za-z0-9а-яёА-ЯЁ]+((\.|-+)[A-Za-z0-9а-яёА-ЯЁ]+)*\.[\-A-Za-z0-9а-яёА-ЯЁ]+(;|,|$))+$/);
                break;
            case 'domain':
                error = !value.match(/^([A-Za-z0-9а-яёА-ЯЁ_\-\.])+\.([A-Za-zа-яёА-ЯЁ]{2,4})$/);
                break;
            case 'int':
                error = !value.match(/^-?[0-9]*$/);// isNaN(parseInt(value));
                break;
            case 'filled':
                error = (typeof(value) == 'undefined' || value == '');
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
                 break;
        }
        return {error: error, customMessage: customMessage};
    }

    this.focusAt = function(oFieldElement){
        oFieldElement.focus();
    }

    /**
     * Highlight field as error field.
     *
     * @returns
     */
    this.highlightFieldAsError = function(name){
        this.oForm.elements[name].style.backgroundColor = '#fdd';
    }

    /**
     * Highlight field as field without error.
     *
     * @returns
     */
    this.highlightFieldAsOk = function(name){
        this.oForm.elements[name].style.backgroundColor = '';
    }

    /**
     * Show error and place focus to error field.
     *
     * @returns
     */
    this.showError = function(focusField, customMessage){
        if(focusField){
            this.oForm.elements[focusField].focus();
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
    * Callback that being called when form content is received.
    *
    * @private
    * @param {object} oData Associative array returned from server side.
    * @returns {void}
    */
   this.setBlockDataFromObject = function(oData){
       AMI.Browser.DOM.setInnerHTML(this.oContainer, oData.data);
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
AMI.inherit(AMI.ModuleComponentFilter, AMI.ModuleComponent);
