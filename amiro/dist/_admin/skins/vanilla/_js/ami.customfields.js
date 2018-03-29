//
// This class supposes the global JavaScript variables:
// dataLanguage
// ajaxProcessURL
//

function amiCustomFields(oDictionary){
    this.htmlEncoding = 'autodetect'; // HTML encoding of the pages (autodetect = get encoding from head meta)
    this.oDictionary = oDictionary;

    this.loadedModules = {}; // Contains loaded modules to prevent reiterated data loading
    this.lastModule = '';
    this.attempts = 0;
    this.skipFieldsTableClearing = false;

    this.oSourceObject = null;

    // extention functionality {
    this.fieldName = 'stub';
    this.objectId = 'stub';
    // } extention functionality

    this.loadFields = function(moduleName, skipFieldsTableClearing){
        this.skipFieldsTableClearing = skipFieldsTableClearing;
        if(this.loadedModules[moduleName]){
            this.setModuleData(this.loadedModules[moduleName]);
            this.oSourceObject.oForm.module_name.disabled = false;
            this.oSourceObject.oForm.module_name.options[0].disabled = true;
            this.oSourceObject.oForm.module_name.selectedIndex = newModuleNameIndex;
        }else{
            this.lastModule = moduleName;
            amiAjax.getContent('GET',
                ajaxProcessURL + '?html_encoding=' + encodeURIComponent(this.getHTMLEncoding()) +
                '&type=customfields&data_language=' + dataLanguage +
                '&module_name=' + moduleName,
                '',
                function(currentObject){return function(state, content){currentObject.loadFieldsCallback(state, content)}}(this)
            );
        }
    }

    this.loadFieldsCallback = function(state, content){
        if(state == 1){
            // success
            var res = eval(content);
            if(res){
                this.loadedModules[this.lastModule] = res;
                this.oSourceObject.oForm.module_name.disabled = false;
                this.oSourceObject.oForm.module_name.options[0].disabled = true;
                this.oSourceObject.oForm.module_name.selectedIndex = newModuleNameIndex;
            }
            this.lastModule = '';
            this.setModuleData(res);
        }else{
            this.attempts++;
            if(this.attempts < 4){
                this.loadFields(this.lastModule, this.skipFieldsTableClearing);
            }else{
                this.attempts = 0;
                alert(oDictionary.get('cannot_load_custom_fields'));
            }
        }
    }

    this.setModuleData = function(data){
        this.oSourceObject.freeFields = [];
        if(!this.skipFieldsTableClearing){
            this.oSourceObject.deleteAllFields();
        }
        if(data){
            var fieldsMap = ';';
            if(this.skipFieldsTableClearing){
                for(var i = 1, q = this.oSourceObject.realFieldsObj.rows.length; i < q; i++){
                    fieldsMap += this.oSourceObject.realFieldsObj.rows[i].getAttribute('clearid') + ';';
                }
            }
            for(var i in data){
                if(
                    typeof(data[i]) == 'function' ||
                    this.skipFieldsTableClearing && fieldsMap.indexOf(';' + data[i][0] + ';') > -1
                ){
                    continue;
                }
                data[i][3] = 0;// unuse
                this.oSourceObject.freeFields.push(data[i]);
                if(data[i][4]){
                    // shared field
                    this.oSourceObject.insertFieldRow(data[i][0]);
                }
            }
        }
        // prepend hardcoded fields
        for(var i in this.oSourceObject.hcFields){
            if(typeof(this.oSourceObject.hcFields[i]) == 'function'){
                continue;
            }
            this.oSourceObject.freeFields.push(this.oSourceObject.hcFields[i]);
        }
        this.skipFieldsTableClearing = false;
        // display fields
        this.oSourceObject.fillFreeFields();
        this.oSourceObject.watchRealFieldsDiv();
    }

    this.getHTMLEncoding = function(){
        if(this.htmlEncoding == 'autodetect'){
            this.htmlEncoding = '';
            var metas = document.getElementsByTagName('meta');
            for(i = 0; i < metas.length; i++){
                if(metas[i].httpEquiv && metas[i].content && metas[i].httpEquiv.toLowerCase() == 'content-type'){
                    var matches = metas[i].content.match(/charset=\s*([^ ]*)/i);
                    if(matches != null && matches.length >= 2){
                        this.htmlEncoding = matches[1];
                    }
                }
            }
        }
        return this.htmlEncoding;
    }

    // extention functionality {

    this.loadDatasetId = function(moduleName, fieldName, tableName, objectId){
        this.fieldName = fieldName;
        this.objectId = objectId;
        amiAjax.getContent('GET',
            ajaxProcessURL + '?html_encoding=' + encodeURIComponent(this.getHTMLEncoding()) +
            '&type=customfields&data_language=' + dataLanguage +
            '&module_name=' + moduleName +
            '&table=' + tableName +
            '&object_id=' + objectId,
            '',
            function(currentObject){return function(state, content){currentObject.loadDatasetIdCallback(state, content)}}(this)
        );
    }

    this.loadDatasetIdCallback = function(state, content){
        this.oSourceObject.oForm.elements[this.fieldName].disabled = false;
        if(state == 1){
            // success
            var datasetId = eval(content);
            // if(datasetId){
                this.oSourceObject.datasets[this.objectId] = datasetId;
                for(var i = 0, q = this.oSourceObject.oForm.elements[this.fieldName].options.length; i < q; i++){
                    if(this.oSourceObject.oForm.elements[this.fieldName].options[i].value == this.objectId){
                        this.oSourceObject.oForm.elements[this.fieldName].selectedIndex = i;
                        break;
                    }
                }
                if(typeof(this.oSourceObject.is60) == 'undefined'){
                    this.oSourceObject.cbOnFormChange(this.fieldName, false, null, true);
                }else{
                    this.oSourceObject.cbOnFormChange({
                        'target':      this.oSourceObject.oForm.elements[this.fieldName],
                        'name':        this.fieldName,
                        'isFirstTime': false,
                        'evt':         null,
                        'skipAjax':    true
                    });
                }
                return;
            // }
        }
        this.oSourceObject.datasets[this.objectId] = 'stub';
        this.oSourceObject.cbOnFormChange(this.fieldName, false, null, true);
        if(typeof(this.oSourceObject.is60) == 'undefined'){
            this.oSourceObject.cbOnFormChange(this.fieldName, false, null, true);
        }else{
            this.oSourceObject.cbOnFormChange({
                'target':      this.oSourceObject.oForm.elements[this.fieldName],
                'name':        this.fieldName,
                'isFirstTime': false,
                'evt':         null,
                'skipAjax':    true
            });
        }
    }

    // } extention functionality

/*
    this.clone = function(src){
        var newObj = (src instanceof Array) ? [] : {};
        for (i in src) {
//            if (i == 'clone') continue;
            newObj[i] = /*src[i] && typeof src[i] == 'object' ? src[i].clone() : *//*src[i];
        }
        return newObj;
    }
*/
}